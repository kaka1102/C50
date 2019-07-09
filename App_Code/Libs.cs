using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Sockets;
using System.Net.Mail;
using System.IO;
using Newtonsoft.Json;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json.Linq;
/// <summary>
/// Summary description for Libs
/// </summary>
public class Libs
{
    public DataC50Entities entity = new DataC50Entities();


    //check password admin
    public string validateLogin(string matkhau1)
    {
        string msg = "";

        string passupper = new String(matkhau1.Where(c => Char.IsLetter(c) && Char.IsUpper(c)).ToArray());// lay cac chu hoa trong chuoi
        string passlower = new String(matkhau1.Where(c => Char.IsLetter(c) && Char.IsLower(c)).ToArray());//lay cac chu thuong trong chuoi
        string passspecial = new String(matkhau1.Where(c => !Char.IsLetter(c) && !Char.IsDigit(c)).ToArray());// lay cac ky tu dac biet trong chuoi
        string passnumber = Regex.Match(matkhau1, @"\d+").Value;

        if (passupper == "")
        {
            msg = "Mật khẩu không có chữ in hoa </br>";
        }
        if (passlower == "")
        {
            msg = msg + "Mật khẩu không có chữ thường </br>";
        }
        if (passspecial == "")
        {
            msg = msg + "Mật khẩu không có ký tự đặc biệt</br>";
        }
        if (passnumber == "")
        {
            msg = msg + "Mật khẩu không có số";
        }
        return msg;
    }
    //log reset mat khau
    public void ResetMKThatBai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "resetmatkhauthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'resetmatkhauthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void ResetThanhCong(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "resetmatkhauthanhcong";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'resetmatkhauthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    //log login
    public void LoginThatBai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "loginthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'loginthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void LoginThanhCong(int idLog)
    {


        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "loginthanhcong";
        //entity.SaveChanges();
        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'loginthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    //log xoa
    public void updateKieuLogXoaThanhCong(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "xoathongtinthanhcong";
        //entity.SaveChanges();


        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'xoathongtinthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void updateKieuLogXoaThatBai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "xoathongtinthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'xoathongtinthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    //log them moi
    public void updateKieuLogThemMoiThanhCong(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "themmoithongtinthanhcong";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'themmoithongtinthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void updateKieuLogThemMoiThatBai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "themmoithongtinthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'themmoithongtinthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    // log sua
    public void updateKieuLogSuaThongTinThanhCong(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "suathongtinthanhcong";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'suathongtinthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void updateKieuLogSuaThongTinThatBai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "suathongtinthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'suathongtinthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    public void lognguoidungthanhcong(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "nguoidungthaotacthanhcong";
        //entity.SaveChanges();


        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'nguoidungthaotacthanhcong' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }
    public void lognguoidungthatbai(int idLog)
    {
        //var taolog = entity.tbl_LogHeThong.Where(m => m.id_loghethong == idLog).FirstOrDefault();
        //taolog.ngaytao = DateTime.Now;
        //taolog.type = "thaotacnguoidungthatbai";
        //entity.SaveChanges();

        string name = getNameTaleLog();
        DateTime date = DateTime.Now;
        var sql = "UPDATE " + name + " SET [ngaytao] = GETDATE() ,[type] = 'thaotacnguoidungthatbai' WHERE id_loghethong=" + idLog + "";
        entity.Database.ExecuteSqlCommand(sql);
    }

    // log luu 
    public int LuuLogHoatDong(int id_taikhoan, string noidung, string vitringuoithaotac)
    {


        //tbl_LogHeThong log = new tbl_LogHeThong();
        //log.id_taikhoan = id_taikhoan;
        //log.noidung = noidung;
        //log.vitrihoatdong = vitringuoithaotac;
        //entity.tbl_LogHeThong.Add(log);
        //entity.SaveChanges();

        string name = getNameTaleLog();
        int id = 0;
        var pOutput = new SqlParameter
            {
                ParameterName = "@id",
                DbType = DbType.String,
                Size = 30,
                Direction = System.Data.ParameterDirection.Output,

            };
        var sql = @"INSERT INTO " + (name) + " (id_taikhoan,noidung,vitrihoatdong,tablename) VALUES (@id_taikhoan,@noidung,@vitri,@tablename); SELECT @id= SCOPE_IDENTITY();";
        entity.Database.ExecuteSqlCommand(sql, new SqlParameter("@id_taikhoan", id_taikhoan)
            , new SqlParameter("@noidung", noidung)
            , new SqlParameter("@vitri", vitringuoithaotac)
            , new SqlParameter("@tablename", name)
            , pOutput);
        int.TryParse(pOutput.Value.ToString(), out id);
        return id;
    }
    public int LuuLogNguoiDung(string noidung, string vitringuoithaotac)
    {

        //tbl_LogHeThong log = new tbl_LogHeThong();
        //log.noidung = noidung;
        //log.vitrihoatdong = vitringuoithaotac;
        //entity.tbl_LogHeThong.Add(log);
        //entity.SaveChanges();
        //return log.id_loghethong;


        string name = getNameTaleLog();
        int id = 0;
        var pOutput = new SqlParameter
        {
            ParameterName = "@id",
            DbType = DbType.String,
            Size = 30,
            Direction = System.Data.ParameterDirection.Output,

        };
        var sql = @"INSERT INTO " + (name) + " (noidung,vitrihoatdong,tablename) VALUES (@noidung,@vitri,@tablename); SELECT @id= SCOPE_IDENTITY();";
        entity.Database.ExecuteSqlCommand(sql, new SqlParameter("@noidung", noidung)
            , new SqlParameter("@vitri", vitringuoithaotac)
            , new SqlParameter("@tablename", name)
            , pOutput);
        int.TryParse(pOutput.Value.ToString(), out id);
        return id;
    }





    public int LuuLogHoatDongLoginFail(string noidung, string vitringuoithaotac)
    {

        //tbl_LogHeThong log = new tbl_LogHeThong();
        //log.noidung = noidung;
        //log.vitrihoatdong = vitringuoithaotac;
        //entity.tbl_LogHeThong.Add(log);
        //entity.SaveChanges();
        //return log.id_loghethong;

        string name = getNameTaleLog();
        int id = 0;
        var pOutput = new SqlParameter
        {
            ParameterName = "@id",
            DbType = DbType.String,
            Size = 30,
            Direction = System.Data.ParameterDirection.Output,

        };
        var sql = @"INSERT INTO " + (name) + " (noidung,vitrihoatdong,tablename) VALUES (@noidung,@vitri,@tablename); SELECT @id= SCOPE_IDENTITY();";
        entity.Database.ExecuteSqlCommand(sql, new SqlParameter("@noidung", noidung)
            , new SqlParameter("@vitri", vitringuoithaotac)
            , new SqlParameter("@tablename", name)
            , pOutput);
        int.TryParse(pOutput.Value.ToString(), out id);
        return id;
    }
    public int LuuLogHoatDongResetMKFail(string noidung, string vitringuoithaotac)
    {

        //tbl_LogHeThong log = new tbl_LogHeThong();
        //log.noidung = noidung;
        //log.vitrihoatdong = vitringuoithaotac;
        //entity.tbl_LogHeThong.Add(log);
        //entity.SaveChanges();
        //return log.id_loghethong;

        string name = getNameTaleLog();
        int id = 0;
        var pOutput = new SqlParameter
        {
            ParameterName = "@id",
            DbType = DbType.String,
            Size = 30,
            Direction = System.Data.ParameterDirection.Output,

        };
        var sql = @"INSERT INTO " + (name) + " (noidung,vitrihoatdong,tablename) VALUES (@noidung,@vitri,@tablename); SELECT @id= SCOPE_IDENTITY();";
        entity.Database.ExecuteSqlCommand(sql, new SqlParameter("@noidung", noidung)
            , new SqlParameter("@vitri", vitringuoithaotac)
            , new SqlParameter("@tablename", name)
            , pOutput);
        int.TryParse(pOutput.Value.ToString(), out id);
        return id;
    }

    public string getNameTaleLog()
    {
        string tenbangLog = "";
        DateTime date = DateTime.Now;
        var danhsach = entity.tbl_Danhsachbanglog.Where(m => m.trangthai == 1).OrderByDescending(m => m.ngaytao).FirstOrDefault();
        if (danhsach != null)
        {
            DateTime ngaytao = danhsach.ngaytao.Value;
            DateTime ngayketthuc = danhsach.ngaytao.Value.AddMonths(6);
            if (date <= ngayketthuc)
            {
                tenbangLog = danhsach.tenbanglog.ToString();
            }
            else
            {
                tenbangLog = TaoBangLog();
            }
        }
        else
        {
            tenbangLog = TaoBangLog();
        }
        return tenbangLog;
    }

    public string TaoBangLog()
    {
        DateTime date = DateTime.Now;
        string tenbang = "LogHeThong_" + date.Month + "_" + date.Year;

        var myTableDefinition = "CREATE TABLE [dbo].[" + tenbang + "](" +
                                "[id_loghethong] [int] IDENTITY(1,1) NOT NULL," +
                                "[noidung] [nvarchar](max) NULL," +
                                "[id_taikhoan] [int] NULL," +
                                "[ngaytao] [datetime] NULL," +
                                "[type] [nvarchar](50) NULL," +
                                "[vitrihoatdong] [nvarchar](max) NULL," +
                                "[tablename] [nvarchar](100) NULL," +
                                " CONSTRAINT [PK_tbl_" + tenbang + "] PRIMARY KEY CLUSTERED " +
                                "([id_loghethong] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF," +
                                " ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]";

        using (var context = new DataC50Entities())
        {
            int exists = entity.Database
                     .SqlQuery<int>(string.Format(@"IF EXISTS (SELECT * FROM sys.tables WHERE name = '{0}') SELECT 1
                        ELSE
                SELECT 0", tenbang)).SingleOrDefault();

            if (exists == 0)
            {
                context.Database.CreateIfNotExists();

                context.Database.ExecuteSqlCommand(myTableDefinition);

                tbl_Danhsachbanglog danhsachlog = new tbl_Danhsachbanglog();
                danhsachlog.ngaytao = DateTime.Now;
                danhsachlog.ngayketthuc = DateTime.Now.AddMonths(6);
                danhsachlog.tenbanglog = tenbang;
                danhsachlog.trangthai = 1;

                entity.tbl_Danhsachbanglog.Add(danhsachlog);
                entity.SaveChanges();



            }
        }

        return tenbang;
    }





    public bool checkfilesudung(string pathFile)
    {
        bool success = false;

        // van ban
        bool vanban = entity.tbl_VanBan.Where(m => m.duongdanfile == pathFile && m.trangthai != 0).Any();
        if (vanban == true)
        {
            success = true;
        }
        //thu vien
        bool thuvien = entity.tbl_ThuVienClient.Where(m => m.noidung.IndexOf(pathFile) > 0 && m.trangthaithuvien != 0).Any();
        if (thuvien == true)
        {
            success = true;
            return success;
        }
        //chi tiet thu vien
        bool chitietthuvien = entity.tbl_ChiTietThuVien.Where(m => m.duongdanfile == pathFile && m.trangthai != 0).Any();
        if (chitietthuvien == true)
        {
            success = true;
            return success;
        }
        //thong tin toi pham
        bool thongtintoipham = entity.tbl_Thongtintoipham.Where(m => m.hinhanh == pathFile && m.trangthai == true).Any();
        if (thongtintoipham == true)
        {
            success = true;
            return success;
        }
        //lien ket hop tac
        bool lienkethoptac = entity.tbl_LienKetHopTac.Where(m => m.avatar == pathFile && m.trangthai != 0).Any();
        if (lienkethoptac == true)
        {
            success = true;
            return success;
        }
        //huong dan su ly tinh huong
        bool dhsltinhhuong = entity.tbl_HuongDanSuLyTinhHuong.Where(m => m.cachxuly.IndexOf(pathFile) > 0 && m.trangthai != 0).Any();
        if (dhsltinhhuong == true)
        {
            success = true;
            return success;
        }
        //danh sach can bo
        bool danhsachcanbo = entity.tbl_DanhSachCanBo.Where(m => m.anhdaidien == pathFile && m.trangthaicanbo != 0).Any();
        if (danhsachcanbo == true)
        {
            success = true;
            return success;
        }
        //bai viet trang gioi thieu
        bool gioithieu = entity.tbl_BaiVietTrangGioiThieu.Where(m => m.noidung.IndexOf(pathFile) > 0 && m.trangthai == true).Any();
        if (gioithieu == true)
        {
            success = true;
            return success;
        }
        //bai viet
        bool baiviet = entity.tbl_Baiviet.Where(m => (m.noidung.IndexOf(pathFile) > 0 || m.avatar == pathFile) && m.trangthaibaiviet != 0).Any();
        if (baiviet == true)
        {
            success = true;
            return success;
        }

        //banner
        bool banner = entity.QuanLyBanner.Where(m => m.duongdanfile == pathFile && m.trangthai != 0).Any();
        if (banner == true)
        {
            success = true;
            return success;
        }

        //quangcao
        bool quangcao = entity.tbl_quangcao.Where(m => m.manguon == pathFile).Any();
        if (quangcao == true)
        {
            success = true;
            return success;
        }
        //taikhoan
        bool taikhoan = entity.TaiKhoan.Where(m => m.avatar == pathFile).Any();
        if (taikhoan == true)
        {
            success = true;
            return success;
        }

        //Cau hoi tra loi
        bool cauhoitraloi = entity.tbl_CauhoiTraLoi.Where(m => (m.traloi.IndexOf(pathFile) > 0 || m.filedinhkem == pathFile || m.fileQuestion==pathFile) && m.trangthai != 0).Any();
        if (cauhoitraloi == true)
        {
            success = true;
            return success;
        }
        return success;
    }

    // check quyen xem trang
    public bool QuyenVoiTrang()
    {
        bool success = false;
        string linkmenu = "";
        string path = "~" + HttpContext.Current.Request.Url.AbsolutePath;
        int check = path.IndexOf(".aspx");
        if (check > 0)
        {
            var link = entity.tbl_Menu.Where(m => m.duongdan == path).Select(m => m.linkmenu).FirstOrDefault();
            linkmenu = link;
        }
        else
        {
            string returnVal = HttpContext.Current.Request.Url.AbsoluteUri;
            linkmenu = getSegmentsUrl(returnVal, 1);
        }

        if (HttpContext.Current.Session["uSession"] != null)
        {
            userDangNhap uSession = (userDangNhap)HttpContext.Current.Session["uSession"];
            if (uSession != null)
            {
                var mUser = entity.TaiKhoan.Where(x => x.id_taikhoan == uSession.id && x.trangthaitk == true).Select(x => new
                {
                    x.id_taikhoan,
                    x.taikhoan1,
                    x.matkhau,
                    x.tendaydu,
                    x.email,
                    x.sodienthoai,
                    x.trangthaitk,
                    x.id_nhomadmin,
                    x.ngaytao,
                    x.loaitaikhoan,
                    x.avatar
                }).FirstOrDefault();
                if (mUser != null)
                {

                    var mMenu = entity.tbl_Menu.Where(x => x.linkmenu == linkmenu).Select(x => new
                    {
                        x.id_menu
                    }).FirstOrDefault();
                    if (mMenu != null)
                    {
                        if (mUser.loaitaikhoan == 2)
                        {
                            success = entity.NhomQuyen.Where(x => x.id_menu == mMenu.id_menu && x.id_nhomadmin == mUser.id_nhomadmin.Value && x.xem == true).Any();
                        }
                        else if (mUser.loaitaikhoan == 3 || mUser.loaitaikhoan == 4)
                        {
                            success = true;
                        }
                    }

                }
            }
        }
        return success;

    }

    public bool QuyenThemMoi()
    {
        bool success = false;

        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        string linkmenu = getSegmentsUrl(returnVal, 1);

        if (HttpContext.Current.Session["uSession"] != null)
        {
            userDangNhap uSession = (userDangNhap)HttpContext.Current.Session["uSession"];
            if (uSession != null)
            {
                var mUser = entity.TaiKhoan.Where(x => x.id_taikhoan == uSession.id && x.trangthaitk == true).Select(x => new
                {
                    x.id_taikhoan,
                    x.taikhoan1,
                    x.matkhau,
                    x.tendaydu,
                    x.email,
                    x.sodienthoai,
                    x.trangthaitk,
                    x.id_nhomadmin,
                    x.ngaytao,
                    x.loaitaikhoan,
                    x.avatar
                }).FirstOrDefault();
                if (mUser != null)
                {

                    var mMenu = entity.tbl_Menu.Where(x => x.linkmenu == linkmenu).Select(x => new
                    {
                        x.id_menu
                    }).FirstOrDefault();
                    if (mMenu != null)
                    {
                        if (mUser.loaitaikhoan == 2)
                        {
                            success = entity.NhomQuyen.Where(x => x.id_menu == mMenu.id_menu && x.id_nhomadmin == mUser.id_nhomadmin.Value && x.xem == true && x.them == true).Any();
                        }
                        else if (mUser.loaitaikhoan == 3 || mUser.loaitaikhoan == 4)
                        {
                            success = true;
                        }
                    }

                }
            }
        }
        return success;

    }

    public bool QuyenSuaTrongTrang()
    {
        bool success = false;

        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        string linkmenu = getSegmentsUrl(returnVal, 1);

        if (HttpContext.Current.Session["uSession"] != null)
        {
            userDangNhap uSession = (userDangNhap)HttpContext.Current.Session["uSession"];
            if (uSession != null)
            {
                var mUser = entity.TaiKhoan.Where(x => x.id_taikhoan == uSession.id && x.trangthaitk == true).Select(x => new
                {
                    x.id_taikhoan,
                    x.taikhoan1,
                    x.matkhau,
                    x.tendaydu,
                    x.email,
                    x.sodienthoai,
                    x.trangthaitk,
                    x.id_nhomadmin,
                    x.ngaytao,
                    x.loaitaikhoan,
                    x.avatar
                }).FirstOrDefault();
                if (mUser != null)
                {

                    var mMenu = entity.tbl_Menu.Where(x => x.linkmenu == linkmenu).Select(x => new
                    {
                        x.id_menu
                    }).FirstOrDefault();
                    if (mMenu != null)
                    {
                        if (mUser.loaitaikhoan == 2)
                        {
                            success = entity.NhomQuyen.Where(x => x.id_menu == mMenu.id_menu && x.id_nhomadmin == mUser.id_nhomadmin.Value && x.xem == true && x.sua == true).Any();
                        }
                        else if (mUser.loaitaikhoan == 3 || mUser.loaitaikhoan == 4)
                        {
                            success = true;
                        }
                    }

                }
            }
        }
        return success;

    }

    public bool QuyenXoaTrongTrang()
    {
        bool success = false;

        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        string linkmenu = getSegmentsUrl(returnVal, 1);

        if (HttpContext.Current.Session["uSession"] != null)
        {
            userDangNhap uSession = (userDangNhap)HttpContext.Current.Session["uSession"];
            if (uSession != null)
            {
                var mUser = entity.TaiKhoan.Where(x => x.id_taikhoan == uSession.id && x.trangthaitk == true).Select(x => new
                {
                    x.id_taikhoan,
                    x.taikhoan1,
                    x.matkhau,
                    x.tendaydu,
                    x.email,
                    x.sodienthoai,
                    x.trangthaitk,
                    x.id_nhomadmin,
                    x.ngaytao,
                    x.loaitaikhoan,
                    x.avatar
                }).FirstOrDefault();
                if (mUser != null)
                {

                    var mMenu = entity.tbl_Menu.Where(x => x.linkmenu == linkmenu).Select(x => new
                    {
                        x.id_menu
                    }).FirstOrDefault();
                    if (mMenu != null)
                    {
                        if (mUser.loaitaikhoan == 2)
                        {
                            success = entity.NhomQuyen.Where(x => x.id_menu == mMenu.id_menu && x.id_nhomadmin == mUser.id_nhomadmin.Value && x.xem == true && x.xoa == true).Any();
                        }
                        else if (mUser.loaitaikhoan == 3 || mUser.loaitaikhoan == 4)
                        {
                            success = true;
                        }
                    }

                }
            }
        }
        return success;

    }

    public string MaQuyenTrongTrang(int idtk)
    {
        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        string tentrang = getSegmentsUrl(returnVal, 1);


        string abc;
        var nhomadmin = entity.TaiKhoan.Where(m => m.id_taikhoan == idtk && m.loaitaikhoan == 2).Select(m => m.id_nhomadmin).FirstOrDefault();
        var idmenu = entity.tbl_Menu.Where(m => m.linkmenu == tentrang).Select(m => m.id_menu).FirstOrDefault();
        var idnhomquyen = entity.NhomQuyen.Where(m => m.id_menu == idmenu && m.id_nhomadmin == nhomadmin).Select(m => m.id_nhomquyen).FirstOrDefault();

        if (idnhomquyen == 0)
        {
            var button = new
               {
                   xem = true,
                   them = true,
                   sua = true,
                   xoa = true,
               };
            chucnang cn = new chucnang();
            cn.xem = button.xem;
            cn.them = button.them;
            cn.sua = button.sua;
            cn.xoa = button.xoa;
            abc = JsonConvert.SerializeObject(cn, Formatting.Indented);
        }
        else
        {
            var button = entity.NhomQuyen.Where(x => x.id_nhomquyen == idnhomquyen).Select(x => new
            {
                x.xem,
                x.them,
                x.sua,
                x.xoa,
            }).FirstOrDefault();
            chucnang cn = new chucnang();
            cn.xem = button.xem.Value;
            cn.them = button.them.Value;
            cn.sua = button.sua.Value;
            cn.xoa = button.xoa.Value;
            abc = JsonConvert.SerializeObject(cn, Formatting.Indented);
        }
        return abc;

    }
    public bool sendEmail(string mailto, string subject, string body)
    {
        bool success = false;
        try
        {
            string mailfrom = "";
            string passmailfrom = "";
            string Host = "";
            int Port = 0;
            mailfrom = "pasbiz@quantriwebhanoi.com";
            passmailfrom = "Qtw1234$";
            Host = "smtp.gmail.com";
            Port = 587;

            using (MailMessage mm = new MailMessage())
            {
                System.Net.Mail.MailAddress fromAddress = new System.Net.Mail.MailAddress(mailfrom, "Cục C50");
                System.Net.Mail.MailMessage message = new System.Net.Mail.MailMessage();
                mm.From = fromAddress;
                mm.To.Add(mailto);

                mm.Subject = subject;// string.Format("Xin chào bạn : {0}.Đây là thông báo lịch họp", tenkhach);
                mm.Body = body;// string.Format("Nội Dung thông báo : {0}", noidung);
                mm.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = Host;
                smtp.EnableSsl = true;
                System.Net.NetworkCredential credentials = new System.Net.NetworkCredential();
                credentials.UserName = mailfrom;
                credentials.Password = passmailfrom;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = credentials;
                smtp.Port = Port;
                smtp.Send(mm);
                success = true;
            }
        }
        catch (Exception ex)
        {

        }
        return success;
    }

    public string VitriTruyCapVaIP(string tenbang, string thietbi)
    {
        try
        {
            string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
            string pathname = getSegmentsUrl(returnVal, 1);


            string VisitorsIPAddr = string.Empty;
            //Users IP Address.                
            if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                VisitorsIPAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
            {
                VisitorsIPAddr = HttpContext.Current.Request.UserHostAddress;
            }
            string abc = "";
            try
            {
                string region = "http://ipinfo.io/" + VisitorsIPAddr;
                string ipResponse = IPRequestHelper(region);
                vitritruycap vt = (vitritruycap)JsonConvert.DeserializeObject(ipResponse, typeof(vitritruycap));
                vt.pathname = pathname;
                vt.tenbang = tenbang;
                vt.thietbi = thietbi;
                abc = JsonConvert.SerializeObject(vt, Formatting.Indented);
            }
            catch (Exception)
            {
                var aaa = GetIPLocation(VisitorsIPAddr);
                vitritruycap vt = (vitritruycap)JsonConvert.DeserializeObject(aaa, typeof(vitritruycap));
                vt.pathname = pathname;
                vt.tenbang = tenbang;
                vt.thietbi = thietbi;
                abc = JsonConvert.SerializeObject(vt, Formatting.Indented);
            }
            return abc;
        }
        catch (Exception)
        {
            string VisitorsIPAddr = string.Empty;
            //Users IP Address.                
            if (HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                VisitorsIPAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else if (HttpContext.Current.Request.UserHostAddress.Length != 0)
            {
                VisitorsIPAddr = HttpContext.Current.Request.UserHostAddress;
            }
            string region = "http://ipinfo.io/" + VisitorsIPAddr;
            string ipResponse = IPRequestHelper(region);
            vitritruycap vt = (vitritruycap)JsonConvert.DeserializeObject(ipResponse, typeof(vitritruycap));
            vt.pathname = "không xác định";
            vt.tenbang = tenbang;
            vt.thietbi = thietbi;
            string abc = JsonConvert.SerializeObject(vt, Formatting.Indented);

            return abc;
        }

    }

    public string IPRequestHelper(string url)
    {
        string checkURL = url;
        HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(url);
        HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
        StreamReader responseStream = new StreamReader(objResponse.GetResponseStream());
        string responseRead = responseStream.ReadToEnd();
        responseRead = responseRead.Replace("\n", String.Empty);
        responseStream.Close();
        responseStream.Dispose();
        return responseRead;
    }
    public string ThietBiTruyCap()
    {
        HttpContext context1 = HttpContext.Current;
        string[] mangcheck = "Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini".ToUpper().Split('|');
        var tentrinhduyet = context1.Request.Browser.Browser;
        var thietbi = context1.Request.UserAgent.ToUpper();
        var thietbitruycap = "Đăng nhập thông qua " + tentrinhduyet + " trên PC";
        bool kq = mangcheck.All(m =>
        {
            bool b = true;
            if (thietbi.Contains(m))
            {
                thietbitruycap = "Đăng nhập thông qua " + tentrinhduyet + " trên " + m.ToLower();
                b = false;
            }
            return b;
        });
        return thietbitruycap;
    }
    public string getSegmentsUrl(string path, int Segments)
    {
        var uri = new Uri(path);
        string url = "";
        if (uri.Segments.Length > Segments)
        {
            url = uri.Segments[Segments].Trim();
        }
        return url;
    }

    public string ConvertUrlsToLinks(string unicode)
    {
        unicode = unicode.ToLower();
        unicode = Regex.Replace(unicode, "[áàảãạăắằẳẵặâấầẩẫậåä]", "a");
        unicode = Regex.Replace(unicode, "[óòỏõọôồốổỗộơớờởỡợ]", "o");
        unicode = Regex.Replace(unicode, "[éèẻẽẹêếềểễệ]", "e");
        unicode = Regex.Replace(unicode, "[íìỉĩị]", "i");
        unicode = Regex.Replace(unicode, "[úùủũụưứừửữự]", "u");
        unicode = Regex.Replace(unicode, "[ýỳỷỹỵ]", "y");
        unicode = Regex.Replace(unicode, "[đ]", "d");
        //unicode = Regex.Replace(unicode, "[-\\s+/]+", "-");
        unicode = Regex.Replace(unicode, "\\W+", "-"); //Nếu bạn muốn thay dấu khoảng trắng thành dấu "" hoặc dấu cách " " thì thay kí tự bạn muốn vào đấu ""
       if(unicode.Length >=230){
           unicode = unicode.Substring(0,230);
       }
        return unicode;
    }
    public string DownloadDataNoAuth(string hostURI)
    {
        string retXml = string.Empty;
        try
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(hostURI);
            request.Method = "GET";
            String responseLine = String.Empty;
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                using (Stream dataStream = response.GetResponseStream())
                {
                    StreamReader sr = new StreamReader(dataStream);
                    retXml = sr.ReadToEnd();
                    sr.Close();
                    dataStream.Close();
                }
            }
        }
        catch (Exception e)
        {
            retXml = null;
        }
        return retXml;
    }
    public string GetIPLocation(string IPAddress)
    {
       vitritruycap IPLocation = new vitritruycap();
        string retJson = DownloadDataNoAuth(string.Format("http://www.freegeoip.net/json/{0}", IPAddress));
        IPLocation IPLOCA = (IPLocation)JsonConvert.DeserializeObject(retJson, typeof(IPLocation));
        IPLocation.ip = IPLOCA.ip;
        IPLocation.country = IPLOCA.country_name;
        IPLocation.region = IPLOCA.region_name;
        IPLocation.org = "Không xác định";

        return JsonConvert.SerializeObject(new { IPLocation.ip,IPLocation.country,IPLocation.region,IPLocation.org }, Formatting.Indented);
    }
    public class IPLocation
    {
        public string ip { get; set; }
        public string org { get; set; }
        public string region_name { get; set; }
        public string country_name { get; set; }
    }
    public class sessionClient
    {
        public int id { get; set; }
        public string tendaydu { get; set; }
        public string tendangnhap { get; set; }
    }
    public class statusLogin
    {
        public int captcha { get; set; }
    }
    public class userDangNhap
    {
        public int id { get; set; }
        public string tendaydu { get; set; }
        public string tendangnhap { get; set; }
        public string sessionid { get; set; }
        public string ip { get; set; }
        public string Agent { get; set; }
        public string ComputerName { get; set; }
        public string Tooken { get; set; }
    }
    public class thongtinConvert
    {
        public string tendangnhap { get; set; }
        public string matkhau { get; set; }
        public string email { get; set; }
        public int idnhomquanly { get; set; }
        public string tendaydu { get; set; }

        public string sodienthoai { get; set; }

        public string diadiem { get; set; }
        public string ip { get; set; }

        public int id_taikhoan { get; set; }
        public int id_tao { get; set; }
        public DateTime thoigiantao { get; set; }
        public string type { get; set; }
        public string page { get; set; }
        public string table { get; set; }
        public string thietbidangnhap { get; set; }

    }


    public class vitritruycap
    {
        public string ip { get; set; }
        public string region { get; set; }
        public string country { get; set; }
        public string org { get; set; }
        public string tenbang { get; set; }
        public string pathname { get; set; }
        public string thietbi { get; set; }

    }

    public class chucnang
    {
        public bool xem { get; set; }
        public bool them { get; set; }
        public bool sua { get; set; }
        public bool xoa { get; set; }
    }
    // menu
    public class jsonmenu
    {
        public int id_menu { get; set; }
        public string vitri { get; set; }
        public int? trangthai { get; set; }
        public int? sothutu { get; set; }
        public string tenmenu { get; set; }
        public string href { get; set; }
        public string icon { get; set; }
        public string active { get; set; }
        public List<jsonmenu> danhsach { get; set; }
    }
    public class thongtincanbo
    {
        public int id_dscanbo { get; set; }
        public string tencanbo { get; set; }
        public int id_chucvu { get; set; }
        public string donvicongtac { get; set; }
        public string thongtinlienhe { get; set; }
        public string anhdaidien { get; set; }
        public int trangthaicanbo { get; set; }
        public string quanham { get; set; }
        public string ngaysinh { get; set; }
        public string quequan { get; set; }

        public string tenchucvu { get; set; }
        public int idparent { get; set; }
    }

    public class dscanbo
    {
        public int id_chucvu { get; set; }
        public string tenchucvu { get; set; }
        public int idparent { get; set; }
        public List<dscanbo> danhsach { get; set; }
        public List<thongtincanbo> thongtincanbo { get; set; }
    }

    public dscanbo getbieudocanbo(dscanbo canbo)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<dscanbo> ltrmenu = new List<dscanbo>();

        List<thongtincanbo> thongtincanbo = new List<thongtincanbo>();

        (from a in ketnoi.tbl_DanhSachChucVu where a.idParents == canbo.id_chucvu && a.trangthai == true select a).ToList().All(x =>
        {


            dscanbo m = new dscanbo();
            thongtincanbo ds = new thongtincanbo();

            m.id_chucvu = x.id_chucvu;
            m.tenchucvu = x.tenchucvu;
            m.idparent = x.idParents.Value;
            (from listaa in ketnoi.tbl_DanhSachCanBo where listaa.id_chucvu == x.id_chucvu && listaa.trangthaicanbo == 2 select listaa).ToList().All(mm =>
             {
                 ds.id_dscanbo = mm.id_dscanbo;
                 ds.tencanbo = mm.tencanbo;
                 ds.quanham = mm.quanham;
                 ds.donvicongtac = mm.donvicongtac;
                 ds.thongtinlienhe = mm.thongtinlienhe;
                 ds.anhdaidien = mm.anhdaidien;
                 ds.ngaysinh = mm.ngaysinh.Value.ToString("dd/MM/yyyy");
                 ds.quequan = mm.quequan;
                 ds.tenchucvu = mm.tbl_DanhSachChucVu.tenchucvu;
                 ds.id_chucvu = mm.id_chucvu.Value;


                 thongtincanbo.Add(ds);
                 return true;
             });
            m.thongtincanbo = thongtincanbo;
            getbieudocanbo(m);
            ltrmenu.Add(m);
            return true;
        });

        canbo.danhsach = ltrmenu;
        return canbo;

    }

    public jsonmenu getmenu(jsonmenu menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        string href = string.Format("{0}", new Libs().getSegmentsUrl(HttpContext.Current.Request.UrlReferrer.AbsoluteUri, 1));
        List<jsonmenu> ltrmenu = new List<jsonmenu>();
        (from a in ketnoi.tbl_Menu where a.idParent == menu.id_menu && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenu m = new jsonmenu();
            m.id_menu = x.id_menu;
            m.tenmenu = x.tenmenu;
            m.vitri = x.vitri;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.href = x.linkmenu;
            m.icon = x.icon;
            m.active = (x.linkmenu == href ? "active" : "");
            getmenu(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;
        return menu;

    }


    //menu client
    public class jsonmenuClient
    {
        public int id_danhmuc { get; set; }
        public string tendanhmuc { get; set; }
        public string link_danhmuc { get; set; }
        public int? trangthai { get; set; }
        public int? sothutu { get; set; }
        public int? idParent { get; set; }
        public string shortcode { get; set; }
        public string duongdan { get; set; }

        public string icon { get; set; }
        public int? socapdanhmuc { get; set; }
        public List<jsonmenuClient> danhsach { get; set; }
    }
    public jsonmenuClient getDanhMucClient(jsonmenuClient menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<jsonmenuClient> ltrmenu = new List<jsonmenuClient>();
        (from a in ketnoi.Menu_Client where a.idParent == menu.id_danhmuc && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenuClient m = new jsonmenuClient();
            m.id_danhmuc = x.id_danhmuc;
            m.tendanhmuc = x.tendanhmuc;
            m.link_danhmuc = x.link_danhmuc;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.idParent = x.idParent;
            m.shortcode = x.shortcode;
            m.duongdan = x.duongdan;
            m.icon = x.icon;
            m.socapdanhmuc = x.socapdanhmuc;
            getDanhMucClient(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;
        return menu;

    }

    public class jsonthumuc
    {
        public int id_quanlythumuc { get; set; }
        public string tenthumuc { get; set; }
        public DateTime? ngaytao { get; set; }
        public int? id_taikhoan { get; set; }
        public bool? trangthai { get; set; }
        public int? id_menu { get; set; }
        public int? idParents { get; set; }
        public string icon { get; set; }
        public string active { get; set; }
        public List<jsonthumuc> danhsach { get; set; }
        public List<QuanLyThuMuc> danhsachthumuc { get; set; }
    }
    public jsonthumuc getthumuc(jsonthumuc thumuc)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<jsonthumuc> ltrthumuc = new List<jsonthumuc>();
        (from a in ketnoi.QuanLyThuMuc where a.idParents == thumuc.id_quanlythumuc select a).ToList().All(x =>
        {
            jsonthumuc m = new jsonthumuc();
            m.id_quanlythumuc = x.id_quanlythumuc;
            m.tenthumuc = x.tenthumuc;
            m.ngaytao = x.ngaytao;
            m.id_taikhoan = x.id_taikhoan;
            m.trangthai = x.trangthai;
            m.idParents = x.idParents;
            m.icon = x.icon;
            getthumuc(m);
            ltrthumuc.Add(m);
            return true;
        });
        thumuc.danhsach = ltrthumuc;
        return thumuc;

    }

    public jsonthumuc jsoncoppythumuc(jsonthumuc thumuc, int id)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<QuanLyThuMuc> ltrthumuc = new List<QuanLyThuMuc>();
        Libs.userDangNhap session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        QuanLyThuMuc them = new QuanLyThuMuc();
        (from a in ketnoi.QuanLyThuMuc where a.idParents == thumuc.id_quanlythumuc select a).ToList().All(x =>
        {
            jsonthumuc m = new jsonthumuc();
            m.id_quanlythumuc = x.id_quanlythumuc;
            m.tenthumuc = x.tenthumuc;
            m.ngaytao = x.ngaytao;
            m.id_taikhoan = x.id_taikhoan;
            m.trangthai = x.trangthai;
            m.idParents = x.idParents;
            m.icon = x.icon;

            them.tenthumuc = x.tenthumuc;
            them.ngaytao = DateTime.Now;
            them.id_taikhoan = session.id;
            them.trangthai = true;
            them.idParents = id;
            them.icon = "fa fa-folder-open";
            entity.QuanLyThuMuc.Add(them);
            entity.SaveChanges();

            string vitri = VitriTruyCapVaIP("QuanLyThuMuc", ThietBiTruyCap());
            int idlog = LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = them }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            updateKieuLogThemMoiThanhCong(idlog);


            jsoncoppythumuc(m, them.id_quanlythumuc);
            ltrthumuc.Add(them);
            return true;
        });
        thumuc.danhsachthumuc = ltrthumuc;
        return thumuc;

    }

    public class linkJsTree
    {
        public int? id { get; set; }
        public string href { get; set; }
    }
    public class jsTree
    {
        public int? id { get; set; }
        public string text { get; set; }
        public bool children { get; set; }
        public jsData data { get; set; }
        public string icon { get; set; }
        public string href { get; set; }
        public bool menutop { get; set; }
        public bool menubottom { get; set; }
        public bool menuleft { get; set; }
        public linkJsTree a_attr { get; set; }
    }

    public class jsData
    {
        public jsonthumuc child { get; set; }

    }

    public void getRoot2(int id, out int idroot, out int socap)
    {
        idroot = 0;
        socap = 0;
        int id_root_temp = 0;
        int socap_temp = 0;
        if (id > 0)
        {
            var timkiem = entity.Menu_Client.Where(m => m.id_danhmuc == id).FirstOrDefault();
            if (timkiem != null)
            {
                if (timkiem.idParent > 0)
                {
                    getRoot2(timkiem.idParent.Value, out id_root_temp, out socap_temp);
                    idroot = id_root_temp;
                    socap = socap_temp;
                }
                else
                {
                    idroot = timkiem.id_danhmuc;
                    socap = (timkiem.socapdanhmuc != null) ? timkiem.socapdanhmuc.Value : 0;
                }
            }
        }
    }

    public bool checkDuLieuGuiLen(string data)
    {
        bool success = false;
        if (!string.IsNullOrEmpty(string.Format("{0}", data)))
        {
            success = true;
        }
        return success;
    }


    public List<DMNgang> getList(int id, List<DMNgang> _list)
    {
        var dm = entity.Menu_Client.Where(x => x.id_danhmuc == id).FirstOrDefault();
        if (dm != null)
        {
            DMNgang new_item = new DMNgang();
            new_item.id = dm.id_danhmuc;
            new_item.ten = dm.tendanhmuc;
            new_item.shortcode = dm.link_danhmuc;
            new_item.idParent = dm.idParent;
            new_item.duongdan = dm.duongdan;
            _list.Add(new_item);
            List<DMNgang> _listtemp = getList(dm.idParent.Value, new List<DMNgang>());
            foreach (var item in _listtemp)
            {
                _list.Add(item);
            }
        }

        return _list;
    }


    public string GetMimeType(string fileName)
    {
        string mimeType = "application/unknown";
        string ext = System.IO.Path.GetExtension(fileName).ToLower();
        Microsoft.Win32.RegistryKey regKey = Microsoft.Win32.Registry.ClassesRoot.OpenSubKey(ext);
        if (regKey != null && regKey.GetValue("Content Type") != null)
            mimeType = regKey.GetValue("Content Type").ToString();
        return mimeType;
    }

    public string getIcon(string kieufile)
    {
        if (kieufile == ".txt")
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/txt.png";
        }
        else if (kieufile == ".docx")
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/iconWord.png";
        }
        else if (kieufile == ".doc")
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/iconWord.png";
        }
        else if (kieufile == ".pdf")
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/iconPDF.png";
        }
        else if (kieufile == ".xla" || kieufile == ".xlam" || kieufile == ".xlc" || kieufile == ".xlm" || kieufile == ".xls" || kieufile == ".xlsb" || kieufile == ".xlsm" || kieufile == ".xlt" || kieufile == ".xlsx")
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/excel.jpg";
        }
        else
        {
            kieufile = "/ThuMucGoc/AnhDaiDien/fileOther.jpg";
        }
        return kieufile;
    }




    public bool CayChucVu(out Libs.dscanbo canbo, int id)
    {
        canbo = null;
        bool accept = false;
        var cv = entity.tbl_DanhSachChucVu.Where(x => x.id_chucvu == id).FirstOrDefault();
        if (cv != null)
        {
            accept = true;
            Libs.dscanbo cbTemp = new Libs.dscanbo();
            cbTemp.id_chucvu = cv.id_chucvu;
            cbTemp.idparent = cv.id_chucvu;
            cbTemp.tenchucvu = cv.tenchucvu;
            //cbTemp.
            List<Libs.thongtincanbo> dsCB = new List<Libs.thongtincanbo>();
            entity.tbl_DanhSachCanBo.Where(x => x.id_chucvu == cv.id_chucvu).ToList().All(x =>
            {
                dsCB.Add(new Libs.thongtincanbo()
                {
                    anhdaidien = x.anhdaidien,
                    donvicongtac = x.donvicongtac,
                    tencanbo = x.tencanbo,
                    thongtinlienhe = x.thongtinlienhe,
                    quanham = x.quanham,
                    ngaysinh = x.ngaysinh.Value.ToString("dd/MM/yyyy"),
                    quequan = x.quequan,
                    id_chucvu = x.id_chucvu.Value,
                    tenchucvu = x.tbl_DanhSachChucVu.tenchucvu,
                    id_dscanbo = x.id_dscanbo,
                    trangthaicanbo = x.trangthaicanbo.Value,
                    //   idparent = x.tbl_DanhSachChucVu.idParents.Value

                });
                return true;
            });
            cbTemp.thongtincanbo = dsCB;
            List<Libs.dscanbo> dsCV = new List<Libs.dscanbo>();
            entity.tbl_DanhSachChucVu.Where(x => x.idParents == cv.id_chucvu).ToList().All(x =>
            {
                Libs.dscanbo cvtemp = new Libs.dscanbo();
                if (CayChucVu(out cvtemp, x.id_chucvu))
                {
                    dsCV.Add(cvtemp);
                }
                return true;
            });
            cbTemp.danhsach = dsCV;
            canbo = cbTemp;
        }
        return accept;
    }
}