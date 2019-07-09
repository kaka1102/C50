using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_TinTucChiTiet : System.Web.UI.Page
{
    private DataC50Entities entity = new DataC50Entities();
    string type = HttpContext.Current.Request.Url.AbsolutePath;
    string url = HttpContext.Current.Request.Url.Host;
    int idmenu = 0;
    int soview = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (type.IndexOf("chi-tiet-hoi-dap") >= 0)
        {
            idmenu = 12;
            LoadHoiDap();
        }
        else if (type.IndexOf("chi-tiet-tin-tuc") >= 0)
        {
            LoadTinTuc();
        }
        else if (type.IndexOf("huong-dan-xu-ly-tinh-huong") >= 0)
        {
            idmenu = 70;
            LoadTinhHuong();

        }
        else if (type.IndexOf("chi-tiet-van-ban") >= 0)
        {
            LoadVanBan();
        }
    }

    public void LoadTinhHuong()
    {
        int idVTBV = client.ToInt(Page.RouteData.Values["idbv"]);
        var thongtin = entity.tbl_HuongDanSuLyTinhHuong.Where(m => m.id_huongdan == idVTBV && m.trangthai == 2).Select(m => new
        {
            m.id_huongdan,
            m.tinhhuong,
            m.cachxuly,
            m.ngaytao,
            m.tieude,
            m.linktinhhuong,
            baitruoc = entity.tbl_HuongDanSuLyTinhHuong.Where(x => x.id_huongdan != m.id_huongdan && x.ngaytao < m.ngaytao && x.trangthai == 2).Select(x => new
             {
                 x.id_huongdan,
                 x.tieude,
                 x.linktinhhuong
             }).FirstOrDefault(),
            baisau = entity.tbl_HuongDanSuLyTinhHuong.Where(x => x.id_huongdan != m.id_huongdan && x.ngaytao > m.ngaytao && x.trangthai == 2).Select(x => new
             {
                 x.id_huongdan,
                 x.tieude,
                 x.linktinhhuong
             }).FirstOrDefault(),
        }).FirstOrDefault();

        if (thongtin != null)
        {
            bool checkRouter = new client().CheckRouterUsing(idmenu);

            if (checkRouter == false)
            {
                Response.Redirect("/404");
            }
            else
            {

                // load menu url
                List<DMNgang> _listParent = new List<DMNgang>();
                List<DMNgang> _listParent2 = new List<DMNgang>();

                _listParent = new Libs().getList(idmenu, new List<DMNgang>());
                for (int j = _listParent.Count - 1; j >= 0; j--)
                {
                    _listParent2.Add(_listParent[j]);
                }
                DMNgang bv = new DMNgang();
                bv.id = thongtin.id_huongdan;
                bv.ten = thongtin.tieude;

                _listParent2.Add(bv);
                RepeaterUrlMenuDetail.DataSource = _listParent2;
                RepeaterUrlMenuDetail.DataBind();


                // load thong tin  bai viet

                var danhsach = entity.tbl_HuongDanSuLyTinhHuong.Where(zz => zz.id_huongdan != thongtin.id_huongdan && zz.trangthai == 2).ToList().Select(zz => new
                {
                    id_vitribv = zz.id_huongdan,
                    avatar = "/ThuMucGoc/AnhDaiDien/icon-guide.jpg",
                    title = zz.tieude,
                    link = zz.linktinhhuong,
                    ngay = zz.ngaytao
                }).OrderByDescending(zz => zz.ngay).ToList();

                if (danhsach.Count > 10)
                {
                    danhsach = danhsach.Take(10).ToList();
                }
                RepeaterBaiVietLienQuan.DataSource = danhsach;
                RepeaterBaiVietLienQuan.DataBind();

                datePost.InnerText = thongtin.ngaytao.Value.ToString("dd/MM/yyyy HH:mm:ss");
                tieude.InnerText = thongtin.tieude;
                noidung.InnerHtml = thongtin.cachxuly;
                gioithieu.InnerText = thongtin.tinhhuong;

                if (thongtin.baitruoc != null)
                {
                    baitruoc.InnerHtml = "<p>Bài viết trước</p><a href='" + thongtin.baitruoc.linktinhhuong + "-" + thongtin.baitruoc.id_huongdan + ".html" + "'><h5>" + thongtin.baitruoc.tieude + "</h5></a>";
                }
                if (thongtin.baisau != null)
                {
                    baisau.InnerHtml = "<p>Bài viết kế</p><a href='" + thongtin.baisau.linktinhhuong + "-" + thongtin.baisau.id_huongdan + ".html" + "'><h5>" + thongtin.baisau.tieude + "</h5></a>";
                }
                var loadbaivietlienquan = entity.Menu_Client.Where(x => x.id_danhmuc == idmenu).FirstOrDefault();
                if (loadbaivietlienquan != null)
                {
                    baivietlienquan.InnerHtml = "<h2>BÀI VIẾT LIÊN QUAN</h2><a href='" + loadbaivietlienquan.duongdan + "'><i class='fa fa-plus-circle'></i>Xem thêm</a>";
                }
                else
                {
                    baivietlienquan.Visible = false;
                }
            }
        }
        else
        {
            formplugin1.Visible = false;
            //formplugin.Visible = false;
            RepeaterUrlMenuDetail.Visible = false;
            RepeaterBaiVietLienQuan.Visible = false;
            tieude.InnerText = "Không tìm thấy bài viết !";
        }
    }
    public void LoadVanBan()
    {
        int idVTBV = client.ToInt(Page.RouteData.Values["idbv"]);
        var thongtin = entity.tbl_VanBan.Where(m => m.id_vanban == idVTBV && m.trangthai == 2).Select(m => new
        {
            m.id_vanban,
            m.tenvanban,
            m.sokyhieu,
            m.ngaybanhanh,
            m.trangthai,
            m.ngaytao,
            m.trichyeu,
            m.noidung,
            m.icon,
            m.duongdanfile,
            m.linkvanban,
            m.id_loaivanban,
            m.id_coquanbanhanh,
            coquan = m.Menu_Client.tendanhmuc,
            loaivanban = m.Menu_Client1.tendanhmuc,
            baitruoc = entity.tbl_VanBan.Where(x => x.id_vanban != m.id_vanban && x.ngaybanhanh < m.ngaybanhanh && x.trangthai == 2).Select(x => new
               {
                   x.id_vanban,
                   x.tenvanban,
                   x.linkvanban
               }).FirstOrDefault(),
            baisau = entity.tbl_VanBan.Where(x => x.id_vanban != m.id_vanban && x.ngaybanhanh > m.ngaybanhanh && x.trangthai == 2).Select(x => new
               {
                   x.id_vanban,
                   x.tenvanban,
                   x.linkvanban
               }).FirstOrDefault(),
        }).FirstOrDefault();

        if (thongtin != null)
        {

            bool checkRouter = new client().CheckRouterVanBan(thongtin.id_coquanbanhanh.Value, thongtin.id_loaivanban.Value);

            if (checkRouter == false)
            {
                Response.Redirect("/404");
            }
            else
            {
                // load menu url
                List<DMNgang> _listParent = new List<DMNgang>();
                List<DMNgang> _listParent2 = new List<DMNgang>();

                _listParent = new Libs().getList(thongtin.id_loaivanban.Value, new List<DMNgang>());
                for (int j = _listParent.Count - 1; j >= 0; j--)
                {
                    _listParent2.Add(_listParent[j]);
                }
                DMNgang bv = new DMNgang();
                bv.id = thongtin.id_vanban;
                bv.ten = thongtin.tenvanban;

                _listParent2.Add(bv);
                RepeaterUrlMenuDetail.DataSource = _listParent2;
                RepeaterUrlMenuDetail.DataBind();


                // load thong tin  bai viet

                var danhsach = entity.tbl_VanBan.Where(zz => zz.id_vanban != thongtin.id_vanban && zz.trangthai == 2).ToList().Select(zz => new
                {
                    id_vitribv = zz.id_vanban,
                    // avatar = zz.icon,
                    avatar = "/ThuMucGoc/AnhDaiDien/fileOther.jpg",
                    title = zz.tenvanban,
                    link = zz.linkvanban,
                    ngay = zz.ngaybanhanh
                }).OrderByDescending(zz => zz.ngay).ToList();

                if (danhsach.Count > 10)
                {
                    danhsach = danhsach.Take(10).ToList();
                }
                RepeaterBaiVietLienQuan.DataSource = danhsach;
                RepeaterBaiVietLienQuan.DataBind();

                datePost.InnerText = thongtin.ngaytao.Value.ToString("dd/MM/yyyy HH:mm:ss");
                tieude.InnerText = thongtin.tenvanban;
                noidung.InnerHtml = thongtin.noidung;
                gioithieu.InnerText = thongtin.trichyeu;
                tacgia.InnerText = "Cơ quan ban hành : " + thongtin.coquan;

                if (thongtin.duongdanfile != "")
                {
                    filedinhkem.InnerHtml = "<a href=" + thongtin.duongdanfile + " download>Tải xuống file đính kèm</a>";
                }

                if (thongtin.baitruoc != null)
                {
                    baitruoc.InnerHtml = "<p>Văn bản trước</p><a href='" + thongtin.baitruoc.linkvanban + "-" + thongtin.baitruoc.id_vanban + ".html" + "'><h5>" + thongtin.baitruoc.tenvanban + "</h5></a>";
                }
                if (thongtin.baisau != null)
                {
                    baisau.InnerHtml = "<p>Văn bản kế</p><a href='" + thongtin.baisau.linkvanban + "-" + thongtin.baisau.id_vanban + ".html" + "'><h5>" + thongtin.baisau.tenvanban + "</h5></a>";
                }
                var loadbaivietlienquan = entity.Menu_Client.Where(x => x.id_danhmuc == thongtin.id_loaivanban.Value).FirstOrDefault();
                if (loadbaivietlienquan != null)
                {
                    baivietlienquan.InnerHtml = "<h2>VĂN BẢN LIÊN QUAN</h2><a href='" + loadbaivietlienquan.duongdan + "'><i class='fa fa-plus-circle'></i>Xem thêm</a>";
                }
                else
                {
                    baivietlienquan.Visible = false;
                }
            }
        }
        else
        {
            formplugin1.Visible = false;
            //formplugin.Visible = false;
            RepeaterUrlMenuDetail.Visible = false;
            RepeaterBaiVietLienQuan.Visible = false;
            tieude.InnerText = "Không tìm thấy bài viết !";
        }
    }
    public void LoadTinTuc()
    {
        int idVTBV = client.ToInt(Page.RouteData.Values["idbv"]);
        var thongtin = entity.tbl_Vitribv.Where(m => m.id_vitribv == idVTBV && m.trangthaibaiviet != 0).Select(m => new
        {
            m.id_baiviet,
            m.id_danhmuc,
            m.linkbaiviet,
            m.soluotlike,
            m.soluotview,
            m.ngaydang,
            m.tbl_Baiviet.tieude,
            m.tbl_Baiviet.gioithieu,
            m.tbl_Baiviet.noidung,
            m.tbl_Baiviet.tacgia,
            m.tbl_Baiviet.tag,
            m.tbl_Baiviet.avatar,
            baitruoc = entity.tbl_Vitribv.Where(x => x.id_baiviet != m.id_baiviet && x.id_danhmuc == m.id_danhmuc && x.ngaydang < m.ngaydang && x.trangthaibaiviet == 1).Select(x => new
            {
                x.id_vitribv,
                x.tbl_Baiviet.tieude,
                x.tbl_Baiviet.linkbaiviet
            }).FirstOrDefault(),
            baisau = entity.tbl_Vitribv.Where(x => x.id_baiviet != m.id_baiviet && x.id_danhmuc == m.id_danhmuc && x.ngaydang > m.ngaydang && x.trangthaibaiviet == 1).Select(x => new
            {
                x.id_vitribv,
                x.tbl_Baiviet.tieude,
                x.tbl_Baiviet.linkbaiviet
            }).FirstOrDefault(),
        }).FirstOrDefault();


        if (thongtin != null)
        {
            bool checkRouter = new client().CheckRouterUsing(thongtin.id_danhmuc.Value);

            if (checkRouter == false)
            {
                Response.Redirect("/404");
            }
            else
            {
                string urlcheck = thongtin.linkbaiviet + "-" + idVTBV + ".html";
                if (urlcheck == type)
                {
                    // load menu url
                    List<DMNgang> _listParent = new List<DMNgang>();
                    List<DMNgang> _listParent2 = new List<DMNgang>();

                    _listParent = new Libs().getList(thongtin.id_danhmuc.Value, new List<DMNgang>());
                    for (int j = _listParent.Count - 1; j >= 0; j--)
                    {
                        _listParent2.Add(_listParent[j]);
                    }
                    DMNgang bv = new DMNgang();
                    bv.id = thongtin.id_baiviet.Value;
                    bv.ten = thongtin.tieude;

                    _listParent2.Add(bv);
                    RepeaterUrlMenuDetail.DataSource = _listParent2;
                    RepeaterUrlMenuDetail.DataBind();


                    // load thong tin  bai viet

                    var danhsach = entity.tbl_Vitribv.Where(zz => zz.id_baiviet != thongtin.id_baiviet.Value && zz.id_danhmuc == thongtin.id_danhmuc.Value && zz.trangthaibaiviet == 1).ToList().Select(zz => new
                    {
                        zz.id_vitribv,
                        avatar = zz.tbl_Baiviet.avatar,
                        title = zz.tbl_Baiviet.tieude,
                        link = zz.linkbaiviet,
                        ngay = zz.ngaydang
                    }).OrderByDescending(zz => zz.ngay).ToList();

                    if (danhsach.Count > 10)
                    {
                        danhsach = danhsach.Take(10).ToList();
                    }
                    RepeaterBaiVietLienQuan.DataSource = danhsach;
                    RepeaterBaiVietLienQuan.DataBind();

                    if (danhsach.Count == 0)
                    {
                        baivietlienquan.Visible = false;
                        RepeaterBaiVietLienQuan.Visible = false;
                    }

                    datePost.InnerText = thongtin.ngaydang.Value.ToString("dd/MM/yyyy HH:mm:ss");
                    tieude.InnerText = thongtin.tieude;
                    noidung.InnerHtml = thongtin.noidung;
                    gioithieu.InnerText = thongtin.gioithieu;
                    tacgia.InnerText = "Tác giả : " + thongtin.tacgia;

                    List<List_tag> listTag = new List<List_tag>();
                    string[] arrListStr = thongtin.tag.Split(',');
                    for (int i = 0; i < arrListStr.Length; i++)
                    {
                        List_tag t = new List_tag();
                        t.Tag = arrListStr[i];
                        listTag.Add(t);
                    }

                    RepeaterTAG.DataSource = listTag;
                    RepeaterTAG.DataBind();

                    var tangview = entity.tbl_Vitribv.Where(xx => xx.id_vitribv == idVTBV).FirstOrDefault();
                    soview = tangview.soluotview.Value;
                    if (soview == 0)
                    {
                        tangview.soluotview = 1;
                    }
                    else
                    {
                        tangview.soluotview = soview + 1;
                    }

                    entity.SaveChanges();

                    if (thongtin.baitruoc != null)
                    {
                        baitruoc.InnerHtml = "<p>Bài viết trước</p><a href='" + thongtin.baitruoc.linkbaiviet + "-" + thongtin.baitruoc.id_vitribv + ".html" + "'><h5>" + thongtin.baitruoc.tieude + "</h5></a>";
                    }
                    if (thongtin.baisau != null)
                    {
                        baisau.InnerHtml = "<p>Bài viết kế</p><a href='" + thongtin.baisau.linkbaiviet + "-" + thongtin.baisau.id_vitribv + ".html" + "'><h5>" + thongtin.baisau.tieude + "</h5></a>";
                    }
                    var loadbaivietlienquan = entity.Menu_Client.Where(x => x.id_danhmuc == thongtin.id_danhmuc.Value).FirstOrDefault();
                    //&& danhsach.Count !=0
                    if (loadbaivietlienquan != null && danhsach.Count > 0)
                    {
                        baivietlienquan.InnerHtml = "<h2>BÀI VIẾT LIÊN QUAN</h2><a href='" + loadbaivietlienquan.duongdan + "'><i class='fa fa-plus-circle'></i>Xem thêm</a>";
                    }
                    else
                    {
                        baivietlienquan.Visible = false;
                    }
                }
                else
                {
                    Response.Redirect(thongtin.linkbaiviet + "-" + idVTBV + ".html");
                }
            }
        }
        else
        {
            formplugin1.Visible = false;
            RepeaterUrlMenuDetail.Visible = false;
            RepeaterBaiVietLienQuan.Visible = false;
            tieude.InnerText = "Không tìm thấy bài viết !";
        }
    }
    class List_tag
    {
        string tag;

        public string Tag
        {
            get { return tag; }
            set { tag = value; }
        }
    }
    public void LoadHoiDap()
    {
        //int idVTBV = client.ToInt(HttpContext.Current.Request.QueryString["id"]);
        int idVTBV = client.ToInt(Page.RouteData.Values["idbv"]);
        var thongtin = entity.tbl_CauhoiTraLoi.Where(m => m.id_cauhoitraloi == idVTBV && m.trangthai == 2).Select(m => new
        {
            m.id_cauhoitraloi,
            m.cauhoi,
            m.traloi,
            m.ngayhoi,
            m.ngaytraloi,
            m.luotxem,
            m.TaiKhoan.tendaydu,
            m.filedinhkem,
            m.fileQuestion,
            m.linkcauhoi,
            m.tieudecauhoi,
            baitruoc = entity.tbl_CauhoiTraLoi.Where(x => x.id_cauhoitraloi != m.id_cauhoitraloi && x.ngayhoi < m.ngayhoi && x.trangthai == 2).Select(x => new
            {
                x.id_cauhoitraloi,
                x.cauhoi,
                x.linkcauhoi,
                x.tieudecauhoi
            }).FirstOrDefault(),
            baisau = entity.tbl_CauhoiTraLoi.Where(x => x.id_cauhoitraloi != m.id_cauhoitraloi && x.ngayhoi > m.ngayhoi && x.trangthai == 2).Select(x => new
            {
                x.id_cauhoitraloi,
                x.cauhoi,
                x.linkcauhoi,
                x.tieudecauhoi
            }).FirstOrDefault(),
        }).FirstOrDefault();

        if (thongtin != null)
        {
            bool checkRouter = new client().CheckRouterUsing(idmenu);

            if (checkRouter == false)
            {
                Response.Redirect("/404");
            }
            else
            {


                // load menu url
                List<DMNgang> _listParent = new List<DMNgang>();
                List<DMNgang> _listParent2 = new List<DMNgang>();

                _listParent = new Libs().getList(idmenu, new List<DMNgang>());
                for (int j = _listParent.Count - 1; j >= 0; j--)
                {
                    _listParent2.Add(_listParent[j]);
                }
                DMNgang bv = new DMNgang();
                bv.id = thongtin.id_cauhoitraloi;
                bv.ten = thongtin.tieudecauhoi;

                _listParent2.Add(bv);
                RepeaterUrlMenuDetail.DataSource = _listParent2;
                RepeaterUrlMenuDetail.DataBind();


                // load thong tin  bai viet

                var danhsach = entity.tbl_CauhoiTraLoi.Where(zz => zz.id_cauhoitraloi != thongtin.id_cauhoitraloi && zz.trangthai == 2).ToList().Select(zz => new
                {
                    id_vitribv = zz.id_cauhoitraloi,
                    avatar = "/ThuMucGoc/AnhDaiDien/icon-question.png",
                    title = zz.tieudecauhoi,
                    link = zz.linkcauhoi,
                    ngay = zz.ngayhoi,

                }).OrderByDescending(zz => zz.ngay).ToList();

                if (danhsach.Count > 10)
                {
                    danhsach = danhsach.Take(10).ToList();
                }
                RepeaterBaiVietLienQuan.DataSource = danhsach;
                RepeaterBaiVietLienQuan.DataBind();

                datePost.InnerText = thongtin.ngaytraloi.Value.ToString("dd/MM/yyyy HH:mm:ss");
                tieude.InnerText = thongtin.tieudecauhoi;
                noidung.InnerHtml = thongtin.traloi;
                gioithieu.InnerText = thongtin.cauhoi;
                tacgia.InnerText = "Người gửi : " + thongtin.tendaydu;



                if (thongtin.filedinhkem != null)
                {
                    filedinhkem.InnerHtml = "<a href=" + thongtin.filedinhkem + " download>Tải xuống file đính kèm</a>";
                }
                else
                {
                    filedinhkem.InnerHtml = "";
                }

                if (thongtin.baitruoc != null)
                {
                    baitruoc.InnerHtml = "<p>Bài viết trước</p><a href='" + thongtin.baitruoc.linkcauhoi + "-" + thongtin.baitruoc.id_cauhoitraloi + ".html" + "'><h5>" + thongtin.baitruoc.tieudecauhoi + "</h5></a>";
                }
                if (thongtin.baisau != null)
                {
                    baisau.InnerHtml = "<p>Bài viết kế</p><a href='" + thongtin.baisau.linkcauhoi + "-" + thongtin.baisau.id_cauhoitraloi + ".html" + "'><h5>" + thongtin.baisau.tieudecauhoi + "</h5></a>";
                }
                var loadbaivietlienquan = entity.Menu_Client.Where(x => x.id_danhmuc == idmenu).FirstOrDefault();
                if (loadbaivietlienquan != null)
                {
                    baivietlienquan.InnerHtml = "<h2>BÀI VIẾT LIÊN QUAN</h2><a href='" + loadbaivietlienquan.duongdan + "'><i class='fa fa-plus-circle'></i>Xem thêm</a>";
                }
                else
                {
                    baivietlienquan.Visible = false;
                }
                var tangview = entity.tbl_CauhoiTraLoi.Where(xx => xx.id_cauhoitraloi == idVTBV).FirstOrDefault();
                soview = tangview.luotxem.Value;
                if (soview == 0)
                {
                    tangview.luotxem = 1;
                }
                else
                {
                    tangview.luotxem = soview + 1;
                }

                entity.SaveChanges();
            }
        }
        else
        {
            formplugin1.Visible = false;
            //formplugin.Visible = false;
            RepeaterUrlMenuDetail.Visible = false;
            RepeaterBaiVietLienQuan.Visible = false;
            tieude.InnerText = "Không tìm thấy bài viết !";
        }
    }

}