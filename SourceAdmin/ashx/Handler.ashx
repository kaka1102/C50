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


public class Handler : IHttpHandler, IRequiresSessionState
{
    DataC50Entities entity = new DataC50Entities();
    Libs.userDangNhap _session;
    string urlWeb = "https://" + HttpContext.Current.Request.Url.Authority;



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


    public void Log_NguoiDung(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        string newfilename = string.Format("bc_nguoidung_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_nguoidung.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "thaotacnguoidungthatbai" || m.type == "nguoidungthaotacthanhcong").All(m =>
            {
                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {
                    command.Parameters.AddWithValue("@id_TK", m.id_taikhoan);
                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);
                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);
                    command.ExecuteNonQuery();
                    i++;
                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
    }


    public void Log_Update(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];



        bool sucess = false;
        string newfilename = string.Format("bc_update_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_update.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "suathongtinthatbai" || m.type == "suathongtinthanhcong").All(m =>
            {
                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {
                    command.Parameters.AddWithValue("@id_TK", m.id_taikhoan);
                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);
                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);
                    command.ExecuteNonQuery();
                    i++;
                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
    }


    public void Log_AddNew(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];



        bool sucess = false;
        string newfilename = string.Format("bc_addnew_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_addnew.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "themmoithongtinthatbai" || m.type == "themmoithongtinthanhcong").All(m =>
            {
                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {
                    command.Parameters.AddWithValue("@id_TK", m.id_taikhoan);
                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);
                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);
                    command.ExecuteNonQuery();
                    i++;
                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
    }



    public void Log_Delete(HttpContext context)
    {
        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];



        bool sucess = false;
        string newfilename = string.Format("bc_Delete_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_Delete.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 12.0 Xml;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "xoathongtinthatbai" || m.type == "xoathongtinthanhcong").All(m =>
            {
                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {
                    command.Parameters.AddWithValue("@id_TK", m.id_taikhoan);
                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);
                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);
                    command.ExecuteNonQuery();
                    i++;
                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
    }



    public void Log_Reset(HttpContext context)
    {

        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        string newfilename = string.Format("bc_reset_matkhau_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_reset_matkhau.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "resetmatkhauthatbai" || m.type == "resetmatkhauthanhcong").All(m =>
            {

                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {
                    command.Parameters.AddWithValue("@id_TK", m.id_taikhoan);
                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);
                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);
                    command.ExecuteNonQuery();
                    i++;
                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
    }


    public void Log_Dangnhap(HttpContext context)
    {

        string timestart = context.Request["timestart"];
        string timeend = context.Request["timeend"];

        bool sucess = false;
        string newfilename = string.Format("bc_login_{0:dd_MM_yyyy_HH_mm_ss}.xlsx", DateTime.Now);
        string path = HostingEnvironment.MapPath("~/SourceAdmin/example/bc_login.xlsx");
        string path2 = HostingEnvironment.MapPath("~/SourceAdmin/baocao/") + newfilename;
        if (File.Exists(path2))
        {
            File.Delete(path2);
        }
        File.Copy(path, path2);

        FileInfo info = new FileInfo(path2);
        var extension = info.Extension;
        string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1}'";
        connectionString = String.Format(connectionString, path2, "yes");
        using (OleDbConnection Connection = new OleDbConnection(connectionString))
        {
            Connection.Open();
            string cmText = "";
            int i = 1;

            var Logs = GetAllDataLogHoatDong(timestart, timeend).Where(m => m.type == "loginthatbai" || m.type == "loginthanhcong").All(m =>
            {
                cmText = string.Format(@"Insert Into [Sheet1$] ([ID_Tài khoản],[Tài khoản],[Hành động],[IP],[region],[country],[org],[pathname],[thietbi],[Thời gian],[Tên bảng],[Link Log],[tablename])
                                            Values(@id_TK,@account,@type,@ip,@region,@country,@org,@pathname,@thietbi,@thoigiantao,@tenbang,@linklog,@tablename)");
                using (OleDbCommand command = new OleDbCommand(cmText, Connection))
                {


                    command.Parameters.AddWithValue("@id_TK", (m.id_taikhoan == null) ? 0 : m.id_taikhoan);
                    command.Parameters.AddWithValue("@account", m.tendangnhap);

                    command.Parameters.AddWithValue("@type", m.type ?? "NULL");
                    command.Parameters.AddWithValue("@ip", m.vt.ip ?? "NULL");
                    command.Parameters.AddWithValue("@region", m.vt.region ?? "NULL");
                    command.Parameters.AddWithValue("@country", m.vt.country ?? "NULL");
                    command.Parameters.AddWithValue("@org", m.vt.org ?? "NULL");
                    command.Parameters.AddWithValue("@pathname", m.vt.pathname ?? "NULL");
                    command.Parameters.AddWithValue("@thietbi", m.vt.thietbi ?? "NULL");
                    command.Parameters.AddWithValue("@thoigiantao", m.thoigiantao);
                    command.Parameters.AddWithValue("@tenbang", m.vt.tenbang);

                    command.Parameters.AddWithValue("@linklog", urlWeb + "/chi-tiet-log-he-thong?type=chitietlog&tablelog=" + m.tablename + "&idlog=" + m.idlog);
                    command.Parameters.AddWithValue("@tablename", m.tablename);

                    command.ExecuteNonQuery();

                    i++;

                }
                sucess = true;
                return true;
            });
        }
        context.Response.Write(JsonConvert.SerializeObject(new { url = "/SourceAdmin/baocao/" + newfilename, sucess = sucess }, Formatting.Indented));
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