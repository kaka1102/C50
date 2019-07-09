
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_HotTinBaoCongAn : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime date = DateTime.Now;

        var tentrang = entity.Menu_Client.Where(m => m.duongdan == "/tin-bao-cong-dan").ToList().Select(m => new
        {
            tendanhmuc = m.tendanhmuc.ToUpper(),
            m.duongdan
        }).ToList();

        if (tentrang != null)
        {
            RepeaterTIEUDEMENU.DataSource = tentrang;
            RepeaterTIEUDEMENU.DataBind();

            var ds = entity.tbl_TinBaoCongDan.Where(m => m.trangthaihienthi.Value == 2).ToList().Select(m => new
            {
                m.tieude,
                m.ngaygui,
                m.linktinbao,
            }).ToList();

            if (ds != null)
            {
                if (ds.Count >= 6)
                {
                    var danhsach = ds.Take(6);
                    RepeaterTINBAOCONGAN.DataSource = danhsach;
                    RepeaterTINBAOCONGAN.DataBind();
                }
                else
                {
                    RepeaterTINBAOCONGAN.DataSource = ds;
                    RepeaterTINBAOCONGAN.DataBind();
                }
            }
            else
            {
                RepeaterTINBAOCONGAN.Visible = false;
            }
        }
        }
        catch (System.Exception)
        {
            Response.Redirect("");
        }
    }
}