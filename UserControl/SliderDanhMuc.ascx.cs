using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_SliderDanhMuc : System.Web.UI.UserControl
{
    private DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string type = HttpContext.Current.Request.Url.AbsolutePath;

            var menu = entity.Menu_Client.Where(x => x.duongdan == type).FirstOrDefault();

            DateTime date = DateTime.Now;

            var danhsachslider = entity.tbl_Vitribv.Where(m => m.trangthaibaiviet == 1 && m.ngaydang < date && m.id_danhmuc == menu.id_danhmuc).ToList().Select(m => new
            {
                m.id_vitribv,
              ngaydang=  m.ngaydang.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                m.linkbaiviet,
                tieude = m.tbl_Baiviet.tieude,
                gioithieu = m.tbl_Baiviet.gioithieu,
                noidung = m.tbl_Baiviet.noidung,
                tacgia = m.tbl_Baiviet.tacgia,
                tag = m.tbl_Baiviet.tag,
                avartar = m.tbl_Baiviet.avatar
            }).OrderByDescending(x => x.ngaydang).ToList();

            if (danhsachslider != null && danhsachslider.Count >= 6)
            {
                var danhsach = danhsachslider.Take(6).ToList();
                RepeaterDanhMucTinTuc.DataSource = danhsach;
                RepeaterDanhMucTinTuc.DataBind();
            }
            else if (danhsachslider != null && danhsachslider.Count < 6)
            {

                RepeaterDanhMucTinTuc.DataSource = danhsachslider;
                RepeaterDanhMucTinTuc.DataBind();
            }
            else
            {
                RepeaterDanhMucTinTuc.Visible = false;
            }
        }
        catch (Exception)
        {
            Response.Redirect("");
        }

    }
}