using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_ThuVien_ChiTiet : System.Web.UI.Page
{
    DataC50Entities entity = new DataC50Entities();
    int take = 0;
    string type = "";
    public static bool timkiems = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        type = HttpContext.Current.Request.Url.PathAndQuery;
        if (!IsPostBack)
        {
            LoadThuVien();
            RepeaterTHUVIENALL.DataSource = source();
            RepeaterTHUVIENALL.DataBind();
        }


    }
    List<thuvienindex1> source()
    {
        var ds = new List<thuvienindex1>();

        ds = entity.tbl_ThuVienClient.Where(m => m.trangthaithuvien.Value == 2).ToList().Select(m => new thuvienindex1()
        {
            id_thuvien = m.id_thuvien,
            tieude = m.tieude,
            gioithieu = m.gioithieu,
            noidung = m.noidung,
            thoigian = m.ngayupload.Value.ToString("dd/MM/yyyy"),
            loaithuvien = m.loaithuvien,
            linlthuvien = m.linlthuvien,
            ngayupload = m.ngayupload.Value,
            luotxem = m.luotxem.Value,
            avatar = m.tbl_ChiTietThuVien.Where(x => x.trangthai == 1).Select(x => x.duongdanfile).FirstOrDefault()
        }).ToList();

        if (ds.Count >= 9)
        {
            take = 9;
        }
        else
        {
            take = ds.Count;
        }


        if (type.IndexOf("?tab=img") >= 0)
        {
            ds = ds.Where(xx => xx.loaithuvien == "thuvienanh").ToList();

            if (type.IndexOf("&action=order-view") >= 0)
            {
                ds = ds.OrderByDescending(m => m.luotxem).Take(take).ToList();
            }
            else if (type.IndexOf("&action=order-name") >= 0)
            {
                ds = ds.OrderBy(m => m.tieude).Take(take).ToList();
            }
            else
            {
                ds = ds.OrderByDescending(m => m.ngayupload).Take(take).ToList();
            }
        }
        else if (type.IndexOf("?tab=video") >= 0)
        {
            ds = ds.Where(xx => xx.loaithuvien == "thuvienvideo").ToList();

            if (type.IndexOf("&action=order-view") >= 0)
            {
                ds = ds.OrderByDescending(m => m.luotxem).Take(take).ToList();
            }
            else if (type.IndexOf("&action=order-name") >= 0)
            {
                ds = ds.OrderBy(m => m.tieude).Take(take).ToList();
            }
            else
            {
                ds = ds.OrderByDescending(m => m.ngayupload).Take(take).ToList();
            }
        }
        else
        {
            ds = ds.OrderByDescending(m => m.ngayupload).ToList();

            if (type.IndexOf("&action=order-view") >= 0)
            {
                ds = ds.OrderByDescending(m => m.luotxem).Take(take).ToList();
            }
            else if (type.IndexOf("&action=order-name") >= 0)
            {
                ds = ds.OrderBy(m => m.tieude).Take(take).ToList();
            }
            else
            {
                ds = ds.OrderByDescending(m => m.ngayupload).Take(take).ToList();
            }
        }

        return ds;
    }


    public void LoadThuVien()
    {
        int idVTBV = client.ToInt(Page.RouteData.Values["idbv"]);
        timkiems = true;
        var thongtin = entity.tbl_ThuVienClient.Where(m => m.id_thuvien == idVTBV && m.trangthaithuvien == 2).ToList().Select(m => new
        {
            m.id_thuvien,
            m.tieude,
            m.gioithieu,
            m.noidung,
            m.ngayupload,
            m.tacgia,
            m.id_danhmuc,
            m.linlthuvien,
            m.luotxem,
            routermenu = m.loaithuvien,
            detail = entity.tbl_ChiTietThuVien.Where(z => z.trangthai == 1 && z.id_thuvien == m.id_thuvien).ToList().Select(z => new
            {
                loaithuvien = m.loaithuvien,
                z.id_thuvien,
                z.id_chitietthuvien,
                z.duongdanfile,
                z.filetype
            }).ToList()
        }).FirstOrDefault();

        if (thongtin != null)
        {
            int idcheck = 0;
            if (thongtin.routermenu == "thuvienanh")
            {
                idcheck = 71;
            }
            else
            {
                idcheck = 72;
            }
            bool checkRouter = new client().CheckRouterUsing(idcheck);

            if (checkRouter == false)
            {
                Response.Redirect("/404");
            }
            else
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
                bv.id = thongtin.id_thuvien;
                bv.ten = thongtin.tieude;

                _listParent2.Add(bv);
                RepeaterUrlMenuDetail.DataSource = _listParent2;
                RepeaterUrlMenuDetail.DataBind();


                datePost.InnerText = thongtin.ngayupload.Value.ToString("dd/MM/yyyy HH:mm:ss");
                if (thongtin.detail != null)
                {
                    RepeaterSliderThuVienChiTiet.DataSource = thongtin.detail;
                    RepeaterSliderThuVienChiTiet.DataBind();
                }
                else
                {
                    RepeaterSliderThuVienChiTiet.Visible = false;
                }
                title.InnerText = thongtin.tieude;
                gioithieu.InnerText = thongtin.gioithieu;
                noidung.InnerHtml = thongtin.noidung;
                tacgia.InnerText = "Tác giả : " + thongtin.tacgia;

                var tangluotxem = entity.tbl_ThuVienClient.Where(m => m.id_thuvien == idVTBV && m.trangthaithuvien == 2).FirstOrDefault();
                int luotxemx = tangluotxem.luotxem.Value;
                tangluotxem.luotxem = luotxemx + 1;
                entity.SaveChanges();

            }
        }
        else
        {
            RepeaterUrlMenuDetail.Visible = false;
            title.InnerText = "Không tìm thấy bài viết !";
        }
    }
}
public class thuvienindex1
{
    public thuvienindex1()
    {
    }
    public int id_thuvien { get; set; }
    public string tieude { get; set; }
    public string gioithieu { get; set; }
    public string noidung { get; set; }
    public string thoigian { get; set; }
    public string loaithuvien { get; set; }
    public string linlthuvien { get; set; }
    public DateTime ngayupload { get; set; }
    public int luotxem { get; set; }
    public string avatar { get; set; }
}