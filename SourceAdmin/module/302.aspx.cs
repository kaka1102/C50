using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_module_302 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
   
        Response.Redirect("/404");
        Response.StatusCode = 302;
        Response.End();
    }
}