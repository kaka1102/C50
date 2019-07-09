using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class SourceAdmin_module_404 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string path = HttpContext.Current.Request.Url.AbsoluteUri;
        if (path.IndexOf("SourceAdmin/module") != -1)
        {
            Response.Redirect("/404");
        }

        Response.StatusCode = 404;
    }
    protected override void Render(HtmlTextWriter output)
    {
        string path = HttpContext.Current.Request.Path;
        StringWriter stringWriter = new StringWriter();

        HtmlTextWriter textWriter = new HtmlTextWriter(stringWriter);
        base.Render(textWriter);

        textWriter.Close();

        string strOutput = stringWriter.GetStringBuilder().ToString();

        strOutput = Regex.Replace(strOutput, "<input[^>]*id=\"__VIEWSTATE\"[^>]*>", "", RegexOptions.Singleline);
        strOutput = Regex.Replace(strOutput, "<input[^>]*id=\"__VIEWSTATEGENERATOR\"[^>]*>", "", RegexOptions.Singleline);
        output.Write(strOutput);
    }
}