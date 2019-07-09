
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_HotVanBan : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime date = DateTime.Now;

            var tentrang = entity.Menu_Client.Where(m => m.duongdan == "/van-ban" && m.trangthai == 1).ToList().Select(m => new
            {
                tendanhmuc = m.tendanhmuc.ToUpper(),
                m.duongdan
            }).ToList();

            if (tentrang != null)
            {
                RepeaterTIEUDEMENU.DataSource = tentrang;
                RepeaterTIEUDEMENU.DataBind();


                var ds = entity.tbl_VanBan.Where(m => m.trangthai.Value == 2).ToList().Select(m => new
                {
                    id_vanban = m.id_vanban,
                    linkvanban = m.linkvanban,
                    icon = m.icon,
                    tenvanban = m.tenvanban,
                }).ToList().OrderByDescending(m => m.id_vanban);

                if (ds != null)
                {
                    if (ds.Count() >= 3)
                    {
                        var danhsach = ds.Take(3);
                        RepeaterHOTVANBAN.DataSource = danhsach;
                        RepeaterHOTVANBAN.DataBind();
                    }
                    else
                    {
                        RepeaterHOTVANBAN.DataSource = ds;
                        RepeaterHOTVANBAN.DataBind();
                    }
                }
                else
                {
                    RepeaterHOTVANBAN.Visible = false;
                }
            }
        }
        catch (System.Exception)
        {
            Response.Redirect("");
        }
    }
}