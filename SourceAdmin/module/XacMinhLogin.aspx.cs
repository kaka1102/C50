using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_module_XacMinhLogin : System.Web.UI.Page
{
    Libs.userDangNhap _session_login;
    DataC50Entities entity = new DataC50Entities();
    List<kenhlamviec> klv = SocketHandler.klv;

    protected void Page_Load(object sender, EventArgs e)
    {
        session_login = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
        string ComputerName = System.Environment.MachineName;
        string ip = HttpContext.Current.Request.UserHostAddress;
        string Agent = Request.UserAgent;

        if (!IsPostBack)
        {
            if (session_login == null)
            {
                Response.Redirect("/admin");
            }
            else
            {
                var check = klv.Where(m => m.Agent == Agent && m.ComputerName == ComputerName && m.id == session_login.id && m.ip == ip && m.sessionid == session_login.sessionid && m.tendangnhap == session_login.tendangnhap && m.tendaydu == session_login.tendaydu).FirstOrDefault();
                if (check != null)
                {
                    if (check.trangthaixacminh == true && check.maxacminh != null)
                    {
                        Response.Redirect("/index-admin");
                    }
                }
            }
        }
    }
    protected void btnLoginadmin_Click(object sender, EventArgs e)
    {
        string ComputerName = System.Environment.MachineName;
        string ip = HttpContext.Current.Request.UserHostAddress;
        string Agent = Request.UserAgent;

        string maxm = removeScriptAndCharacter.formatTextInput(maxacminh.Text);

        if (session_login != null)
        {
            if (string.IsNullOrEmpty(maxm))
            {
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Bạn chưa nhập mã xác nhận', 'error')", true);
            }
            else if (maxm.Trim().Length !=6)
            {
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Mã xác nhận bắt buộc 6 ký tự', 'error')", true);
            }
            else
            {
                var check = klv.Where(m => m.trangthaixacminh == false && m.maxacminh != null && m.Agent == Agent && m.ComputerName == ComputerName && m.id == session_login.id && m.ip == ip && m.sessionid == session_login.sessionid && m.tendangnhap == session_login.tendangnhap && m.tendaydu == session_login.tendaydu).FirstOrDefault();
                if (check != null)
                {
                    if (check.solannhapma >= 3)
                    {
                        Session.Remove("uSession");
                        klv.Remove(check);
                        Response.Redirect("/admin");

                        loaddingpage.Attributes.CssStyle.Add("display", "none");
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Nhập mã sai quá 3 lần, vui lòng đăng nhập lại', 'error')", true);
                    }
                    else
                    {
                        if (check.maxacminh == maxm)
                        {
                            check.solannhapma = check.solannhapma + 1;
                            check.trangthaixacminh = true;
                            Response.Redirect("/index-admin");
                        }
                        else
                        {
                            check.solannhapma = check.solannhapma + 1;
                            loaddingpage.Attributes.CssStyle.Add("display", "none");
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Mã xác minh không chính xác', 'error')", true);
                        }
                    }
                }
                else
                {
                    loaddingpage.Attributes.CssStyle.Add("display", "none");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Có lỗi trong quá trình thao tác, vui lòng thử lại sau 5 phút', 'error')", true);
                }
            }
        }
        else
        {
            Response.Redirect("/admin");
        }
    }
    public Libs.userDangNhap session_login
    {
        get { return _session_login; }
        set { _session_login = value; }
    }
}