using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_TabThuVienAll : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //CollectionPager1.PageSize = 9;
        //CollectionPager1.DataSource = source();


        //CollectionPager1.BindToControl = RepeaterTHUVIENALL;
        //RepeaterTHUVIENALL.DataSource = CollectionPager1.DataSourcePaged;
        //RepeaterTHUVIENALL.DataBind();
    }

    List<thuvien> source()
    {
        var ds = new List<thuvien>();

        string type = HttpContext.Current.Request.Url.AbsolutePath;

        ds = entity.tbl_ThuVienClient.Where(m => m.trangthaithuvien.Value == 2).ToList().Select(m => new thuvien()
       {
           tieude = m.tieude,
           gioithieu = m.gioithieu,
           noidung = m.noidung,
           thoigian = m.ngayupload.Value.ToString("dd/MM/yyyy"),
           loaithuvien = m.loaithuvien,
           linlthuvien = m.linlthuvien,
           ngayupload = m.ngayupload.Value,
           luotxem = m.luotxem.Value,
           avatar = m.tbl_ChiTietThuVien.Where(x => x.trangthai == 1).Select(x => x.duongdanfile).FirstOrDefault()
       }).OrderByDescending(zz=>zz.ngayupload).ToList();

        if (type.IndexOf("/orderby-view") >= 0)
        {
            ds = ds.OrderByDescending(m => m.luotxem).ToList();
        }
        else if (type.IndexOf("/orderby-name") >= 0)
        {
            ds = ds.OrderBy(m => m.tieude).ToList();
        }
        else if (type.IndexOf("/orderby-date") >= 0)
        {
            ds = ds.OrderByDescending(m => m.ngayupload).ToList();
        }
        else if (type.IndexOf("/thu-vien/hinh-anh") >= 0)
        {
            ds = ds.Where(xx => xx.loaithuvien == "thuvienanh").ToList();
        }
        else if (type.IndexOf("/thu-vien/video") >= 0)
        {
            ds = ds.Where(xx => xx.loaithuvien == "thuvienvideo").ToList();
        }
        else
        {
            ds = ds.OrderByDescending(m => m.ngayupload).ToList();
        }

        return ds;
    }
}
public class thuvien
{
    public thuvien()
    {
    }

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