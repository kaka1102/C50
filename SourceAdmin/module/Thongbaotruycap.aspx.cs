using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_module_Thongbaotruycap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var a = Session["uSession"];
            if (a == null)
            {
                Response.Redirect("/admin");
            }
        }
    }
}