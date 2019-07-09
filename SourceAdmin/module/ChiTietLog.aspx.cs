using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_ChiTietLog : System.Web.UI.Page
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    if (!new Libs().QuyenVoiTrang())
        //    {
        //        Response.Redirect("/thong-bao-truy-cap");
        //    }
        //}
    }
}