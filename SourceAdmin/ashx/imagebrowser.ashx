<%@ WebHandler Language="C#" Class="imagebrowser" %>
using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Drawing;
using Newtonsoft.Json;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web.SessionState;
using System.Reflection;


public class imagebrowser : IHttpHandler, IRequiresSessionState
{
    DataC50Entities entity = new DataC50Entities();
    public void ProcessRequest(HttpContext context)
    {

        if (context.Request["type"] != null)
        {
            string type = context.Request["type"];
            switch (type)
            {
                case "getlistUrl":
                    getlistUrl(context);
                    break;
                case "Showdanhsachanhduocchiase":
                    Showdanhsachanhduocchiase(context);
                    break;
                case "Showdanhsachdulieutrongthumuc":
                    Showdanhsachdulieutrongthumuc(context);
                    break;
                case "Showdanhsachanhvideoduocchiase":
                    Showdanhsachanhvideoduocchiase(context);
                    break;
                case "Showdanhsachvideotrongthumuc":
                    Showdanhsachvideotrongthumuc(context);
                    break;
            }
        }
    }
    public void Showdanhsachvideotrongthumuc(HttpContext context)
    {
        bool quyen = false;
        int _idthumuc = int.Parse(context.Request["_idthumuc"]);

        Libs.userDangNhap session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach = entity.QuanLyFileUpload.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id)) && m.trangthai == true).ToList().OrderByDescending(m=>m.ngayupload.Value).Select(m => new
            {
                image = m.duongdanfile,
                type = m.mimetype
            }).ToList();

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
        }

    }


    public void Showdanhsachanhvideoduocchiase(HttpContext context)
    {
        bool quyen = false;
        Libs.userDangNhap session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach1 = entity.tbl_QuyenSuDungFile.Where(m => (quyen == true) ? (m.kieufile == "video") : (m.id_taikhoan == session.id && m.kieufile == "video")).ToList().Select(m => new
            {
                m.QuanLyFileUpload.tenfile,
                m.QuanLyFileUpload.duongdanfile,
                m.QuanLyFileUpload.id_quanlyfileupload,
                m.QuanLyFileUpload.id_taikhoan,
                m.QuanLyFileUpload.id_quanlythumuc,
                m.QuanLyFileUpload.mimetype,
                m.QuanLyFileUpload.ngayupload,
                m.QuanLyFileUpload.dungluongfile,
                m.QuanLyFileUpload.trangthai
            }).ToList().OrderByDescending(m=>m.ngayupload.Value);


            var danhsach = from a in danhsach1.Where(d => d.trangthai == true)
                           group a by new
                           {
                               a.id_quanlyfileupload
                           } into nhomfile
                           select new
                           {
                               image = nhomfile.Select(gg => gg.duongdanfile).FirstOrDefault(),
                               type = nhomfile.Select(gg=>gg.mimetype).FirstOrDefault()
                           };

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
        }

    }


    public void getlistUrl(HttpContext context)
    {
        string searchFolder = string.Format("/ThuMucGoc/AnhDaiDien");
        DirectoryInfo d = new DirectoryInfo(context.Server.MapPath(string.Format("~/ThuMucGoc/AnhDaiDien/")));//Assuming Test is your Folder
        FileInfo[] Files = d.GetFiles(); //Getting Text files
        List<jsonImage> fileimg = new List<jsonImage>();
        foreach (FileInfo i in Files)
        {
            fileimg.Add(new jsonImage() { image = string.Format("/ThuMucGoc/AnhDaiDien/{0}", i.Name) });
        }
        context.Response.ContentType = "application/json";
        context.Response.Write(JsonConvert.SerializeObject(fileimg, Formatting.Indented));
    }
    public void Showdanhsachdulieutrongthumuc(HttpContext context)
    {
        bool quyen = false;
        int _idthumuc = int.Parse(context.Request["_idthumuc"]);

        Libs.userDangNhap session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach = entity.QuanLyFileUpload.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id)) && m.trangthai == true).ToList().OrderByDescending(m=>m.ngayupload.Value).Select(m => new
            {
                image = m.duongdanfile
            }).ToList();

            context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
        }

    }

    public void Showdanhsachanhduocchiase(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        Libs.userDangNhap session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach1 = entity.tbl_QuyenSuDungFile.Where(m => (quyen == true) ? (m.kieufile == "images") : (m.id_taikhoan == session.id && m.kieufile == "images")).ToList().Select(m => new
            {
                m.QuanLyFileUpload.tenfile,
                m.QuanLyFileUpload.duongdanfile,
                m.QuanLyFileUpload.id_quanlyfileupload,
                m.QuanLyFileUpload.id_taikhoan,
                m.QuanLyFileUpload.id_quanlythumuc,
                m.QuanLyFileUpload.mimetype,
                m.QuanLyFileUpload.ngayupload,
                m.QuanLyFileUpload.dungluongfile,
                m.QuanLyFileUpload.trangthai,

            }).ToList().OrderByDescending(m=>m.ngayupload.Value);


            var danhsach = from a in danhsach1.Where(d => d.trangthai == true)
                           group a by new
                           {
                               a.id_quanlyfileupload
                           } into nhomfile
                           select new
                           {
                               image = nhomfile.Select(gg => gg.duongdanfile).FirstOrDefault(),
                           };

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
        }

    }





    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}

public class jsonImage
{
    public string image
    {
        get;
        set;
    }
}