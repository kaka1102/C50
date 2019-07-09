<%@ WebHandler Language="C#" Class="Handler" %>

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
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using SpreadsheetLight;

public class Handler : IHttpHandler, IRequiresSessionState
{
    DataC50Entities entity = new DataC50Entities();
    Libs.userDangNhap _session;
    string urlWeb = "https://" + HttpContext.Current.Request.Url.Authority;
    HttpContext context = HttpContext.Current;
    string type = "";
    public Libs.userDangNhap session
    {
        get { return _session; }
        set { _session = value; }
    }
    public void ProcessRequest(HttpContext ct)
    {
        session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        if (context.Request["type"] != null)
        {
            type = context.Request["type"];
            switch (type)
            {
                case "login":
                    Log_Dangnhap(context);
                    break;
                case "reset":
                    Log_Reset(context);
                    break;
                case "delete":
                    Log_Delete(context);
                    break;
                case "addnew":
                    Log_AddNew(context);
                    break;
                case "update":
                    Log_Update(context);
                    break;
                case "nguoidung":
                    Log_NguoiDung(context);
                    break;
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
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "loginthatbai" || m.type == "loginthanhcong").ToList();
        TaoFileExcel(Logs, type);
    }
    public void Log_Reset(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "resetmatkhauthatbai" || m.type == "resetmatkhauthanhcong").ToList();
        TaoFileExcel(Logs, type);
    }
    public void Log_Delete(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "xoathongtinthatbai" || m.type == "xoathongtinthanhcong").ToList();
        TaoFileExcel(Logs, type);
    }
    public void Log_AddNew(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "themmoithongtinthatbai" || m.type == "themmoithongtinthanhcong").ToList();
        TaoFileExcel(Logs, type);
    }
    public void Log_Update(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "suathongtinthatbai" || m.type == "suathongtinthanhcong").ToList();
        TaoFileExcel(Logs, type);
    }
    public void Log_NguoiDung(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "thaotacnguoidungthatbai" || m.type == "nguoidungthaotacthanhcong").ToList();
        TaoFileExcel(Logs, type);
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
             itemabc.id_taikhoan = (m.id_taikhoan != null) ? m.id_taikhoan.Value : 0;
             itemabc.tentk = (m.id_taikhoan != null) ? entity.TaiKhoan.Where(zzz => zzz.id_taikhoan == m.id_taikhoan).Select(zzz => zzz.taikhoan1).FirstOrDefault() : "Không xác định";
             itemabc.thoigiantao = m.ngaytao.Value.ToString("dd/MM/yyyy HH:mm:ss");
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
    public List<string> headerColumns = new List<string>() { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N" };
    //abc
    void TaoFileExcel(List<taikhoandangnhap> dulieu, string typelog)
    {
        if (typelog == "login")
        {
            typelog = "Báo_cáo_đăng_nhập";
        }
        if (typelog == "reset")
        {
            typelog = "Báo_cáo_reset_thông_tin";
        }
        if (typelog == "delete")
        {
            typelog = "Báo_cáo_xóa_dữ_liệu";
        }
        if (typelog == "addnew")
        {
            typelog = "Báo_cáo_thêm_mới_thông_tin";
        }
        if (typelog == "update")
        {
            typelog = "Báo_cáo_cập_nhật_thông_tin";
        }
        if (typelog == "nguoidung")
        {
            typelog = "Báo_cáo_thao_tác_người_dùng";
        }
        if (dulieu.Count > 0)
        {
            int totalRow = dulieu.Count;

            SLDocument sl = new SLDocument();
            SLStyleExport style = new SLStyleExport(sl);// tạo style
            SLStyle stHeader = style.stHeader;
            SLStyle stColTextTitle = style.stColTextTitle;
            SLStyle stColDefault = style.stColDefault;
            SLStyle stColTextSTT = style.stColTextSTT;
            SLStyle stColTextSTTBold = style.stColTextSTTBold;
            SLStyle stColPriceBold = style.stColPriceBold;
            SLStyle stColPrice = style.stColPrice;
            SLStyle stColTextTitleLeft = style.stColTextTitleLeft;
            SLStyle stColTextTitleLeftBold = style.stColTextTitleLeftBold;
            SLStyle stColTextTitleCenter = style.stColTextTitleCenter;
            SLStyle stColTextTitleFooterBold = style.stColTextTitleFooterBold;

            sl.MergeWorksheetCells("A1", "C1");
            sl.SetCellValue(1, 1, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "CỤC C50 - BỘ CÔNG AN")));
            sl.SetCellStyle(1, 1, 1, 1, stColTextTitleLeft);
            sl.MergeWorksheetCells("A2", "C2");
            sl.SetCellValue(2, 1, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "PHÒNG KỸ THUẬT")));
            sl.SetCellStyle(2, 1, 2, 1, stColTextTitleLeftBold);
            sl.MergeWorksheetCells("A3", "N3");
            sl.SetCellValue(3, 1, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "FILE BÁO CÁO LOG TRONG HỆ THỐNG")));
            sl.SetCellStyle(3, 1, 3, 1, stColTextTitleCenter);
            sl.MergeWorksheetCells("A5", "N5");
            sl.SetCellValue(5, 1, SpreadsheetLightExport.CreateStringInline(string.Format("Thời điểm tạo báo cáo : {0:HH} giờ,ngày {0:dd} tháng {0:MM} năm {0:yyyy}.", DateTime.Now)));
            sl.MergeWorksheetCells("A6", "N6");
            sl.SetCellValue(6, 1, SpreadsheetLightExport.CreateStringInline(string.Format("Tài khoản tạo báo cáo : {0}", session.tendangnhap)));

            int startTable = 8;

            sl.MergeWorksheetCells(string.Format("A{0}", startTable), string.Format("A{0}", startTable + 2));
            sl.SetCellValue(startTable, 1, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "STT")));
            sl.MergeWorksheetCells(string.Format("B{0}", startTable), string.Format("B{0}", startTable + 2));
            sl.SetCellValue(startTable, 2, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "ID_TK")));
            sl.MergeWorksheetCells(string.Format("C{0}", startTable), string.Format("C{0}", startTable + 2));
            sl.SetCellValue(startTable, 3, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "TÀI KHOẢN")));
            sl.MergeWorksheetCells(string.Format("D{0}", startTable), string.Format("D{0}", startTable + 2));
            sl.SetCellValue(startTable, 4, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "HÀNH ĐỘNG")));
            sl.MergeWorksheetCells(string.Format("E{0}", startTable), string.Format("E{0}", startTable + 2));
            sl.SetCellValue(startTable, 5, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "ĐỊA CHỈ IP")));
            sl.MergeWorksheetCells(string.Format("F{0}", startTable), string.Format("F{0}", startTable + 2));
            sl.SetCellValue(startTable, 6, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "THÀNH PHỐ")));
            sl.MergeWorksheetCells(string.Format("G{0}", startTable), string.Format("G{0}", startTable + 2));
            sl.SetCellValue(startTable, 7, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "ĐẤT NƯỚC")));
            sl.MergeWorksheetCells(string.Format("H{0}", startTable), string.Format("H{0}", startTable + 2));
            sl.SetCellValue(startTable, 8, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "NHÀ MẠNG")));
            sl.MergeWorksheetCells(string.Format("I{0}", startTable), string.Format("I{0}", startTable + 2));
            sl.SetCellValue(startTable, 9, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "PATH NAME")));
            sl.MergeWorksheetCells(string.Format("J{0}", startTable), string.Format("J{0}", startTable + 2));
            sl.SetCellValue(startTable, 10, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "THIẾT BỊ")));
            sl.MergeWorksheetCells(string.Format("K{0}", startTable), string.Format("K{0}", startTable + 2));
            sl.SetCellValue(startTable, 11, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "THỜI GIAN")));
            sl.MergeWorksheetCells(string.Format("L{0}", startTable), string.Format("L{0}", startTable + 2));
            sl.SetCellValue(startTable, 12, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "TÊN BẢNG")));
            sl.MergeWorksheetCells(string.Format("M{0}", startTable), string.Format("M{0}", startTable + 2));
            sl.SetCellValue(startTable, 13, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "LINK LOG")));
            sl.MergeWorksheetCells(string.Format("N{0}", startTable), string.Format("N{0}", startTable + 2));
            sl.SetCellValue(startTable, 14, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "BẢNG LOG")));


            int ii = (startTable + 3);

            sl.SetCellStyle(startTable, 1, (startTable + 2), 14, stHeader);// style header
            sl.SetCellStyle((startTable + 3), 1, (totalRow + (startTable + 3)), 14, stColTextSTT);

            sl.SetColumnWidth(1, 10);
            sl.SetColumnWidth(2, 10);
            sl.SetColumnWidth(3, 20);
            sl.SetColumnWidth(4, 20);
            sl.SetColumnWidth(5, 20);
            sl.SetColumnWidth(6, 20);
            sl.SetColumnWidth(7, 15);
            sl.SetColumnWidth(8, 20);
            sl.SetColumnWidth(9, 20);
            sl.SetColumnWidth(10, 20);
            sl.SetColumnWidth(11, 20);
            sl.SetColumnWidth(12, 15);
            sl.SetColumnWidth(13, 20);
            sl.SetColumnWidth(14, 20);

            for (int i = 0; i < dulieu.Count; i++)
            {
                var objToInsert = dulieu.ElementAt(i);

                for (int icolumn = 1; icolumn <= headerColumns.Count(); icolumn++)
                {
                    bool addnew = true;
                    string value = "";
                    string column = headerColumns.ElementAt(icolumn - 1);
                    if (column.Equals("A"))
                        value = string.Format("{0}", i);
                    if (column.Equals("B"))
                        value = string.Format("{0}", objToInsert.id_taikhoan);
                    if (column.Equals("C"))
                        value = string.Format("{0}", objToInsert.tentk);
                    if (column.Equals("D"))
                        value = string.Format("{0}", objToInsert.type);
                    if (column.Equals("E"))
                        value = string.Format("{0}", objToInsert.vt.ip);
                    if (column.Equals("F"))
                        value = string.Format("{0}", objToInsert.vt.region);
                    if (column.Equals("G"))
                        value = string.Format("{0}", objToInsert.vt.country);
                    if (column.Equals("H"))
                        value = string.Format("{0}", objToInsert.vt.org);
                    if (column.Equals("I"))
                        value = string.Format("{0}", objToInsert.vt.pathname);
                    if (column.Equals("J"))
                        value = string.Format("{0}", objToInsert.vt.thietbi);
                    if (column.Equals("K"))
                        value = string.Format("{0}", objToInsert.thoigiantao);
                    if (column.Equals("L"))
                        value = string.Format("{0}", objToInsert.vt.tenbang);
                    if (column.Equals("M"))
                    {
                        string url = string.Format("{0}", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + objToInsert.tablename + "&idlog=" + objToInsert.idlog);
                        sl.InsertHyperlink("M" + ii, SLHyperlinkTypeValues.Url, url, "Link chi tiết", "Click vào để xem chi tiết", true);

                        addnew = false;
                    }
                    if (column.Equals("N"))
                        value = string.Format("{0}", objToInsert.tablename);

                    if (addnew)
                    {
                        sl.SetCellValue(ii, icolumn, value);
                    }

                }
                ii++;
            }



            sl.MergeWorksheetCells(string.Format("J{0}", (ii + 1)), string.Format("M{0}", (ii + 1)));
            sl.SetCellValue((ii + 1), 10, SpreadsheetLightExport.CreateStringInline(string.Format("Hà Nội,  {0:HH} giờ,ngày {0:dd} tháng {0:MM} năm {0:yyyy}.", DateTime.Now)));
            sl.SetCellStyle((ii + 1), 10, (ii + 1), 10, stColTextTitleLeft);

            sl.MergeWorksheetCells(string.Format("J{0}", (ii + 2)), string.Format("M{0}", (ii + 2)));
            sl.SetCellValue((ii + 2), 10, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "Người tạo báo cáo")));
            sl.SetCellStyle((ii + 2), 10, (ii + 2), 10, stColTextTitleLeft);

            sl.MergeWorksheetCells(string.Format("J{0}", (ii + 3)), string.Format("M{0}", (ii + 3)));
            sl.SetCellValue((ii + 3), 10, SpreadsheetLightExport.CreateStringInline(string.Format("{0}", "(ký ghi rõ họ tên)")));
            sl.SetCellStyle((ii + 3), 10, (ii + 3), 10, stColTextTitleLeft);

            SLTable tbl = sl.CreateTable(string.Format("A{0}", (startTable)), string.Format("N{0}", (totalRow + (startTable + 1))));

            tbl.SetTableStyle(SLTableStyleTypeValues.Medium28);
            sl.InsertTable(tbl);

            var sucess = true;
            string tenbaocao = string.Format("{0}_ngày_{1:dd_MM_yyyy}.xlsx", typelog, DateTime.Now);
            var a = context.Server.MapPath("~/SourceAdmin/baocao/") + tenbaocao;
            sl.SaveAs(a);
            context.Response.Write(JsonConvert.SerializeObject(new { url = "SourceAdmin/baocao/" + tenbaocao, sucess = sucess }, Formatting.Indented));
        }

    }
    public static class SpreadsheetLightExport
    {
        public static InlineString CreateStringInline(string text)
        {
            InlineString inlineString = new InlineString();
            Text t = new Text();
            t.Text = text;

            inlineString.AppendChild(t);

            return inlineString;
        }
    }
    public class SLStyleExport
    {
        public SLStyle stHeader;
        public SLStyle stColTextTitle;
        public SLStyle stColDefault;
        public SLStyle stColTextSTT;
        public SLStyle stColTextSTTBold;
        public SLStyle stColPriceBold;
        public SLStyle stColPrice;
        public SLStyle stColTextTitleLeft;
        public SLStyle stColTextTitleLeftBold;
        public SLStyle stColTextTitleCenter;
        public SLStyle stColTextTitleFooterBold;
        SLDocument sl;
        public SLStyleExport(SLDocument sl)
        {
            this.sl = sl;
            this.styleHeader();
            this.styleColTextTitle();
            this.styleColDefault();
            this.styleColTextSTT();
            this.styleColTextSTTBold();
            this.styleColPriceBold();
            this.styleColPrice();
            this.styleColTextTitleLeft();
            this.styleColTextTitleLeftBold();
            this.styleColTextTitleCenter();
            this.styleColTextTitleFooterBold();
        }
        void styleHeader()
        {
            stHeader = sl.CreateStyle();
            stHeader.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stHeader.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stHeader.SetWrapText(true);
            stHeader.Font.FontName = "Times New Roman";
            stHeader.Font.FontSize = 8;
            stHeader.Font.FontColor = System.Drawing.Color.Black;
            stHeader.Font.Bold = true;
            stHeader.Font.Italic = false;
            stHeader.Font.Strike = false;
            stHeader.Font.Underline = UnderlineValues.None;
            //stHeader.Border.Outline = true;
            stHeader.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stHeader.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stHeader.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stHeader.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColTextTitle()
        {
            stColTextTitle = this.sl.CreateStyle();
            stColTextTitle.Alignment.Horizontal = HorizontalAlignmentValues.Left;
            stColTextTitle.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextTitle.SetWrapText(true);
            stColTextTitle.Font.FontName = "Times New Roman";
            stColTextTitle.Font.FontSize = 8;
            stColTextTitle.Font.FontColor = System.Drawing.Color.Black;
            stColTextTitle.Font.Bold = true;
            stColTextTitle.Font.Italic = false;
            stColTextTitle.Font.Strike = false;
            stColTextTitle.Font.Underline = UnderlineValues.None;
            //stHeader.Border.Outline = true;
            stColTextTitle.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextTitle.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextTitle.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextTitle.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColDefault()
        {
            stColDefault = this.sl.CreateStyle();
            stColDefault.Alignment.Horizontal = HorizontalAlignmentValues.Left;
            stColDefault.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColDefault.SetWrapText(false);
            stColDefault.Font.FontName = "Times New Roman";
            stColDefault.Font.FontSize = 8;
            stColDefault.Font.FontColor = System.Drawing.Color.Black;
            stColDefault.Font.Bold = false;
            stColDefault.Font.Italic = false;
            stColDefault.Font.Strike = false;
            stColDefault.Font.Underline = UnderlineValues.None;
            //stHeader.Border.Outline = true;
            stColDefault.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColDefault.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColDefault.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColDefault.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColTextSTT()
        {
            stColTextSTT = this.sl.CreateStyle();
            stColTextSTT.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextSTT.SetVerticalAlignment(VerticalAlignmentValues.Center);
            //stColTextSTT.Font.FontName = "Times New Roman";
            stColTextSTT.Font.FontSize = 8;

            //stColTextSTT.Font.FontColor = System.Drawing.Color.Black;
            //stHeader.Border.Outline = true;
            stColTextSTT.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTT.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTT.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTT.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColTextSTTBold()
        {
            stColTextSTTBold = this.sl.CreateStyle();
            stColTextSTTBold.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextSTTBold.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextSTTBold.Font.FontName = "Times New Roman";
            stColTextSTTBold.Font.FontSize = 8;
            stColTextSTTBold.Font.Bold = true;
            stColTextSTTBold.Font.FontColor = System.Drawing.Color.Black;
            //stHeader.Border.Outline = true;
            stColTextSTTBold.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTTBold.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTTBold.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColTextSTTBold.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColPriceBold()
        {
            stColPriceBold = this.sl.CreateStyle();
            stColPriceBold.Alignment.Horizontal = HorizontalAlignmentValues.Right;
            stColPriceBold.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColPriceBold.Font.FontName = "Times New Roman";
            stColPriceBold.Font.FontSize = 8;
            stColPriceBold.Font.FontColor = System.Drawing.Color.Black;
            stColPriceBold.Font.Bold = true;
            //stHeader.Border.Outline = true;
            stColPriceBold.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColPriceBold.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColPriceBold.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColPriceBold.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColPrice()
        {
            stColPrice = this.sl.CreateStyle();
            stColPrice.Alignment.Horizontal = HorizontalAlignmentValues.Right;
            stColPrice.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColPrice.Font.FontName = "Times New Roman";
            stColPrice.Font.FontSize = 8;
            stColPrice.Font.FontColor = System.Drawing.Color.Black;
            //stHeader.Border.Outline = true;
            stColPrice.Border.LeftBorder.BorderStyle = BorderStyleValues.Thin;
            stColPrice.Border.RightBorder.BorderStyle = BorderStyleValues.Thin;
            stColPrice.Border.TopBorder.BorderStyle = BorderStyleValues.Thin;
            stColPrice.Border.BottomBorder.BorderStyle = BorderStyleValues.Thin;
        }
        void styleColTextTitleLeft()
        {
            stColTextTitleLeft = this.sl.CreateStyle();
            stColTextTitleLeft.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextTitleLeft.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextTitleLeft.SetWrapText(true);
            stColTextTitleLeft.Font.FontName = "Times New Roman";
            stColTextTitleLeft.Font.FontSize = 10;
            stColTextTitleLeft.Font.FontColor = System.Drawing.Color.Black;
        }
        void styleColTextTitleLeftBold()
        {
            stColTextTitleLeftBold = this.sl.CreateStyle();
            stColTextTitleLeftBold.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextTitleLeftBold.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextTitleLeftBold.SetWrapText(true);
            stColTextTitleLeftBold.Font.FontName = "Times New Roman";
            stColTextTitleLeftBold.Font.FontSize = 10;
            stColTextTitleLeftBold.Font.FontColor = System.Drawing.Color.Black;
            stColTextTitleLeftBold.Font.Bold = true;
        }
        void styleColTextTitleCenter()
        {
            stColTextTitleCenter = this.sl.CreateStyle();
            stColTextTitleCenter.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextTitleCenter.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextTitleCenter.SetWrapText(true);
            stColTextTitleCenter.Font.FontName = "Times New Roman";
            stColTextTitleCenter.Font.FontSize = 13;
            stColTextTitleCenter.Font.FontColor = System.Drawing.Color.Black;
            stColTextTitleCenter.Font.Bold = true;
        }
        void styleColTextTitleFooterBold()
        {
            stColTextTitleFooterBold = this.sl.CreateStyle();
            stColTextTitleFooterBold.Alignment.Horizontal = HorizontalAlignmentValues.Center;
            stColTextTitleFooterBold.SetVerticalAlignment(VerticalAlignmentValues.Center);
            stColTextTitleFooterBold.SetWrapText(true);
            stColTextTitleFooterBold.Font.FontName = "Times New Roman";
            stColTextTitleFooterBold.Font.FontSize = 10;
            stColTextTitleFooterBold.Font.FontColor = System.Drawing.Color.Black;
            stColTextTitleFooterBold.Font.Bold = true;
        }
    }
    ///abc
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
    public string tentk;
    public string matkhau;
    public int id_taikhoan;
    public string thoigiantao;
    public string type;
    public string tablename;
    public vitrihoatdong vt { get; set; }
}