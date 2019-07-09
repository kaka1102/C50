using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_module_IndexAdmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Libs.userDangNhap uSession = (Libs.userDangNhap)Session["uSession"];
        if (uSession != null)
        {
            helloadmin.InnerText = "\"Chào mừng đồng chí " + uSession.tendaydu + " đã đăng nhập vào hệ thống\"";
        }
        else
        {
            Response.Redirect("/admin");
        }
    }
}