<%@ WebHandler Language="C#" Class="TaoBaoCaoExcell" %>

using System;
using System.Web;
using System.Web.Hosting;
using System.IO;
using System.Data.OleDb;
using Newtonsoft.Json;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
using System.Web.SessionState;
using Excel = Microsoft.Office.Interop.Excel;

public class TaoBaoCaoExcell : IHttpHandler, IRequiresSessionState
{
    DataC50Entities entity = new DataC50Entities();
    Libs.userDangNhap _session;
    string urlWeb = HttpContext.Current.Request.Url.Authority;
    DateTime dtNow = DateTime.Now;




    public Libs.userDangNhap session
    {
        get { return _session; }
        set { _session = value; }
    }

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request["type"] != null)
        {

            string type = context.Request["type"];
            switch (type)
            {
                case "login":
                    Log_Dangnhap(context);
                    break;
                //case "reset":
                //    Log_Reset(context);
                //    break;
                //case "delete":
                //    Log_Delete(context);
                //    break;
                //case "addnew":
                //    Log_AddNew(context);
                //    break;
                //case "update":
                //    Log_Update(context);
                //    break;
                //case "nguoidung":
                //    Log_NguoiDung(context);
                //    break;
                case "chitietlog":
                    ChiTietLog(context);
                    break;
            }
        }
    }
    public void ChiTietLog(HttpContext context)
    {
        session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];

        string msg = "Sảy ra lỗi trong quá trình thao tác";
        bool sucess = false;

        if (new Libs().checkDuLieuGuiLen(context.Request["idlog"]) && new Libs().checkDuLieuGuiLen(context.Request["tablelog"]))
        {
            int idLog = int.Parse(context.Request["idlog"]);
            string tablelog = context.Request["tablelog"];
            if (session != null)
            {

                var sql = "select * from " + tablelog + " where id_loghethong=" + idLog + "";

                var blogNames = entity.Database.SqlQuery<tbl_LogHeThong>(sql).ToList();


                var thongtin = blogNames.Select(m => new
                {
                    m.id_loghethong,
                    m.noidung,
                    m.id_taikhoan,
                    tentaikhoan = entity.TaiKhoan.Where(z => z.id_taikhoan == m.id_taikhoan.Value).Select(z => z.taikhoan1),
                    m.ngaytao,
                    m.type,
                    m.vitrihoatdong,
                }).FirstOrDefault();

                if (thongtin != null)
                {
                    sucess = true;
                    msg = "Get sucess !";
                    context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess, data = thongtin }, Formatting.Indented));
                }
                else
                {
                    msg = "Log không tồn tại";
                }
            }
            else
            {
                msg = "Sesion không tồn tại";
            }
        }
        else
        {
            msg = "Có vấn đề với dữ liệu gửi lên";
        }
        if (sucess == false)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
    }
    public void Log_Dangnhap(HttpContext context)
    {
        DateTime dEnd = DateTime.Now;
        DateTime dStart = DateTime.Now;

        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;

        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "loginthatbai" || m.type == "loginthanhcong").ToList();

        if (Logs.Count() > 0)
        {
            if (!string.IsNullOrEmpty(timestart) && !string.IsNullOrEmpty(timeend))
            {
                dEnd = DateTime.Parse(timeend);
                dStart = DateTime.Parse(timestart);
            }
            else
            {
                dEnd = Logs.OrderByDescending(m => m.ngay).Select(m => m.ngay).FirstOrDefault();
                dStart = Logs.OrderBy(m => m.ngay).Select(m => m.ngay).FirstOrDefault();
            }
            string newfilename = string.Format("baocao_login_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
            string path = HostingEnvironment.MapPath("~/SourceAdmin/example/baocao_login.xlsx");
            string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
            if (File.Exists(path2))
            {
                File.Delete(path2);
            }
            File.Copy(path, path2);

            Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
            Microsoft.Office.Interop.Excel.Workbook sheet = excel.Workbooks.Open(path2);
            Microsoft.Office.Interop.Excel.Worksheet sheetx = excel.ActiveSheet as Microsoft.Office.Interop.Excel.Worksheet;

            
            int ii = 7;
            int stt = 1;
            sheetx.Range["J9", "J9"].Value2 = string.Format("Hà nội,ngày {0:dd} tháng {0:MM} năm {0:yyyy}", dtNow);
            sheetx.Range["D4", "D4"].Value2 = string.Format("Báo cáo log đăng nhập từ {0:dd/MM/yyyy} đến {1:dd/MM/yyyy}", dStart, dEnd);

            var Logs2 = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "loginthatbai").All(item =>
            {
                Excel.Range r1 = TaoCell("A" + ii, sheetx);
                sheetx.Cells[ii, 1] = item.id_taikhoan;
                r1.Cells.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
                sheetx.Range["A" + ii, r1].EntireRow.Font.Bold = false;

                sheetx.Range["B" + ii, "B" + ii].Value2 = ((item.tendangnhap != null) ? item.tendangnhap : "NULL");

                sheetx.Range["C" + ii, "C" + ii].Value2 = ((item.type != null) ? item.type : "NULL");

                sheetx.Range["D" + ii, "D" + ii].Value2 = ((item.vt.ip != null) ? item.vt.ip : "NULL");

                sheetx.Range["E" + ii, "E" + ii].Value2 = ((item.vt.region != null) ? item.vt.region : "NULL");

                sheetx.Range["F" + ii, "F" + ii].Value2 = ((item.vt.country != null) ? item.vt.country : "NULL");

                sheetx.Range["G" + ii, "G" + ii].Value2 = ((item.vt.org != null) ? item.vt.org : "NULL");

                sheetx.Range["H" + ii, "H" + ii].Value2 = ((item.vt.pathname != null) ? item.vt.pathname : "NULL");

                sheetx.Range["I" + ii, "I" + ii].Value2 = ((item.vt.thietbi != null) ? item.vt.thietbi : "NULL");

                sheetx.Range["J" + ii, "J" + ii].Value2 = ((item.thoigiantao != null) ? item.thoigiantao : "NULL");

                sheetx.Range["K" + ii, "K" + ii].Value2 = ((item.vt.tenbang != null) ? item.vt.tenbang : "NULL");

                string link = "http://" + (urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + item.tablename + "&idlog=" + item.idlog);

                Excel.Hyperlink slink = (Excel.Hyperlink)sheetx.Hyperlinks.Add(sheetx.Range["L" + ii, Type.Missing], link, Type.Missing, "Microsoft", "Xem chi tiết");

                sheetx.Range["M" + ii, "M" + ii].Value2 = ((item.tablename != null) ? item.tablename : "NULL");

                ii++;
                return true;
            });

            sucess = true;
            sheet.Close(true, Type.Missing, Type.Missing);
            excel.Quit();


            context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
        }
        else
        {
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess }, Formatting.Indented));
        }
    }

    public Excel.Range TaoCell(string cell, Microsoft.Office.Interop.Excel.Worksheet sheetx)
    {
        Excel.Range range = (Excel.Range)sheetx.Range[cell, System.Type.Missing].EntireRow;
        range.Insert(Excel.XlInsertShiftDirection.xlShiftDown, System.Type.Missing);
        return range;
    }

    public Excel.Range TaoColumn(string cell, Microsoft.Office.Interop.Excel.Worksheet sheetx)
    {
        Excel.Range range = sheetx.Range[cell];
        return range;
    }

    public List<taikhoandangnhap> GetAllDataLogHoatDong(string timestart, string timeend)
    {
        List<taikhoandangnhap> danhsach = new List<taikhoandangnhap>();

        List<tbl_LogHeThong> danhsachtong = new List<tbl_LogHeThong>();

        bool checkdate = true;
        DateTime datestart = DateTime.Now;
        DateTime dateend = DateTime.Now;
        // kiem tra xem co select theo ngay khong
        if (!string.IsNullOrEmpty(timestart) && !string.IsNullOrEmpty(timeend))
        {
            try
            {
                datestart = DateTime.Parse(timestart).AddDays(1).AddMilliseconds(-1);
                dateend = DateTime.Parse(timeend).AddDays(1).AddMilliseconds(-1);
            }
            catch (Exception ex)
            {
                checkdate = false;
            }
        }
        else
        {
            checkdate = false;

        }
        List<object> listTen = new List<object>();

        // danh sanh bang log theo ngay

        if (checkdate)
        {
            if (datestart <= dateend)
            {
                var danhsachbang = entity.tbl_Danhsachbanglog.Where(x => ((datestart <= x.ngaytao || datestart <= x.ngayketthuc) &&
                    (dateend >= x.ngayketthuc || x.ngaytao <= dateend)) &&
                x.trangthai == 1).ToList().OrderByDescending(x => x.ngaytao).Select(x => x.tenbanglog);
                foreach (var ten in danhsachbang)
                {
                    listTen.Add(ten);
                }
            }
            else
            {
                checkdate = false;
            }
        }
        else
        {
            var danhsachbang = entity.tbl_Danhsachbanglog.Where(x => x.trangthai == 1).ToList().OrderByDescending(x => x.ngaytao).FirstOrDefault().tenbanglog;
            listTen.Add(danhsachbang);
        }

        // get data theo tung bang log
        foreach (var ten in listTen)
        {
            //check xem bang log co ton tai khong
            int exists = entity.Database
                   .SqlQuery<int>(string.Format(@"IF EXISTS (SELECT * FROM sys.tables WHERE name = '{0}') SELECT 1
                        ELSE
                SELECT 0", ten)).SingleOrDefault();
            //neu ton tai thi thuc hien cau sql va add data vao list tong
            if (exists == 1)
            {
                var sql = "select * from " + ten + " ";
                var blogNames = entity.Database.SqlQuery<tbl_LogHeThong>(sql).ToList();
                danhsachtong.AddRange(blogNames);

            }
        }

        danhsachtong.Where(m => (checkdate) ? (m.ngaytao >= datestart.AddDays(-1).AddMilliseconds(1) && m.ngaytao <= dateend) : true).ToList().All(m =>
        {
            taikhoandangnhap itemabc = JsonConvert.DeserializeObject<taikhoandangnhap>(m.noidung);

            vitrihoatdong hd = JsonConvert.DeserializeObject<vitrihoatdong>(m.vitrihoatdong);
            itemabc.id_taikhoan = (m.id_taikhoan != null) ? m.id_taikhoan.Value : 1;
            itemabc.thoigiantao = m.ngaytao.Value.ToString("dd/MM/yyyy HH:mm:ss");
            itemabc.ngay = m.ngaytao.Value;
            itemabc.type = m.type;
            itemabc.dulieu = m.noidung.ToString().Replace('"', ' ');
            itemabc.vt = hd;
            itemabc.tablename = m.tablename;
            itemabc.idlog = m.id_loghethong;
            danhsach.Add(itemabc);
            return true;
        });
        return danhsach;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public class vitrihoatdong
    {
        public string ip;
        public string region;
        public string country;
        public string org;
        public string tenbang;
        public string pathname;
        public string thietbi;
    }

    public class taikhoandangnhap
    {
        public int idlog;
        public string dulieu;
        public string tendangnhap;
        public string matkhau;
        public int id_taikhoan;
        public string thoigiantao;
        public DateTime ngay;
        public string type;
        public string tablename;
        public vitrihoatdong vt { get; set; }
    }
}

