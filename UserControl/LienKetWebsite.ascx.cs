using System;
using System.Collections.Generic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_LienKetWebsite : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime date = DateTime.Now;

            var ds = entity.tbl_LienKetHopTac.Where(m => m.trangthai.Value == 2).ToList().Select(m => new
            {
                m.tendoitac,
                m.avatar,
                m.linkdiachi,
                m.target
            }).ToList();

            if (ds != null)
            {
                RepeaterBOXLIENKETWEB.DataSource = ds;
                RepeaterBOXLIENKETWEB.DataBind();
            }
            else
            {
                RepeaterBOXLIENKETWEB.Visible = false;
            }
        }
        catch (System.Exception)
        {
            Response.Redirect("");
        }
    }
}