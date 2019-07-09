using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceAdmin_module_Login12 : System.Web.UI.Page
{
    Libs.statusLogin _session;
    Libs.userDangNhap _session_login;
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        string ComputerName = System.Environment.MachineName;
        string ip = HttpContext.Current.Request.UserHostAddress;
        string Agent = Request.UserAgent;

        if (!IsPostBack)
        {
            session_login = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];
            session = (Libs.statusLogin)HttpContext.Current.Session["statuslogin"];
            List<kenhlamviec> klv = SocketHandler.klv;

            if (session == null)
            {
                Libs.statusLogin statuslogin = new Libs.statusLogin();
                statuslogin.captcha = 0;
                Page.Session.Add("statuslogin", statuslogin);
                pn_capchar.Visible = false;
            }
            else if (session.captcha == 1)
            {
                pn_capchar.Visible = true;
            }
            else
            {
                pn_capchar.Visible = false;
            }
            if (session_login != null)
            {
                var check = klv.Where(m => m.Agent == Agent && m.ComputerName == ComputerName && m.id == session_login.id && m.ip == ip && m.sessionid == session_login.sessionid && m.tendangnhap == session_login.tendangnhap && m.tendaydu == session_login.tendaydu).FirstOrDefault();
                if (check != null)
                {
                    //  Response.Redirect("/index-admin");
                    if (check.trangthaixacminh == true && check.maxacminh != null)
                    {
                        Response.Redirect("/index-admin");
                    }
                    else
                    {
                        Response.Redirect("/xac-minh-dang-nhap");
                    }
                }
            }

        }
    }
    public Libs.statusLogin session
    {
        get { return _session; }
        set { _session = value; }
    }
    public Libs.userDangNhap session_login
    {
        get { return _session_login; }
        set { _session_login = value; }
    }
    public bool IsValid(string value)
    {
        return Regex.IsMatch(value, @"(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{10,16}$");
    }
    protected void btnLoginadmin_Click(object sender, EventArgs e)
    {
        loginadmin();
    }


    public void loginadmin()
    {
        try
        {
            loaddingpage.Attributes.Remove("style");

            session = (Libs.statusLogin)HttpContext.Current.Session["statuslogin"];
            bool success = false;
            string msg = "";
            string sessioncaptcha = "";
            string ten = removeScriptAndCharacter.formatTextInput(username.Text);
            string pass = removeScriptAndCharacter.formatTextInput(password.Text);

            string captchalogin = removeScriptAndCharacter.formatTextInput(txtCapcha.Text);

            if (session.captcha == 1)
            {
                sessioncaptcha = Page.Session["captchalogin"].ToString();
            }

            bool checkPass = IsValid(pass);

            if (ten == "")
            {
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Tên đăng nhập không được để trống', 'error')", true);
            }
            else if (ten.Length < 6)
            {
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Tên đăng nhập phải lớn hơn 6 ký tự', 'error')", true);
            }
            else if (checkPass == false)
            {
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Mật khẩu phải chứa ký tự đặc biệt, chữ in hoa và lớn hơn 10 ký tự !', 'error')", true);
            }
            else if (session.captcha == 1 && captchalogin == "")
            {
                txtCapcha.Text = "";
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Bạn chưa nhập captcha !', 'error')", true);
            }
            else if (session.captcha == 1 && captchalogin != "" && captchalogin != sessioncaptcha)
            {
                txtCapcha.Text = "";
                loaddingpage.Attributes.CssStyle.Add("display", "none");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Capcha không chính xác !', 'error')", true);
            }
            else
            {
                string matkhaumahoa = MD5.GeneratePasswordHash(pass);
                var taikhoandangnhap = entity.TaiKhoan.Where(x => x.taikhoan1 == ten && x.matkhau == matkhaumahoa && x.trangthaitk == true && (x.loaitaikhoan == 2 || x.loaitaikhoan == 3 || x.loaitaikhoan == 4)).Select(x => new
                {

                    x.id_nhomadmin,
                    tennhom = x.NhomAdmin.tennhom,
                    x.email,
                    x.id_taikhoan,
                    x.loaitaikhoan,
                    x.matkhau,
                    x.ngaytao,
                    x.taikhoan1,
                    x.trangthaitk,
                    x.tendaydu,
                    x.avatar,
                    x.sodienthoai
                }).FirstOrDefault();


                if (taikhoandangnhap != null)
                {
                    string sessionDefaulf = Page.Session.SessionID;
                    List<kenhlamviec> klv = SocketHandler.klv;
                    var check = klv.Where(m => m.sessionid == sessionDefaulf).FirstOrDefault();
                    if (check == null)
                    {
                        //    msg = "Đăng nhập thành công. Hệ thống sẽ tự động chuyển trang";
                        msg = "Đăng nhập thành công. Vui lòng nhập mã xác minh vừa được hệ thống gửi vào email";
                        Libs.statusLogin statuslogin = new Libs.statusLogin();
                        statuslogin.captcha = 0;
                        Page.Session.Add("statuslogin", statuslogin);

                        Libs.userDangNhap uSession = new Libs.userDangNhap();
                        uSession.id = taikhoandangnhap.id_taikhoan;
                        uSession.tendangnhap = taikhoandangnhap.taikhoan1;
                        uSession.tendaydu = taikhoandangnhap.tendaydu;
                        uSession.sessionid = Page.Session.SessionID;
                        uSession.ComputerName = System.Environment.MachineName;
                        uSession.ip = HttpContext.Current.Request.UserHostAddress;
                        uSession.Agent = Request.UserAgent;
                        uSession.Tooken = MD5.RandomString(16);
                        Page.Session.Add("uSession", uSession);


                        kenhlamviec k = new kenhlamviec();
                        k.id = uSession.id;
                        k.sessionid = uSession.sessionid;
                        k.tendangnhap = uSession.tendangnhap;
                        k.tendaydu = uSession.tendaydu;
                        k.ip = uSession.ip;
                        k.Tooken = uSession.Tooken;
                        k.Agent = uSession.Agent;
                        k.ComputerName = uSession.ComputerName;
                        k.maxacminh = MD5.RandomString(6);
                        k.trangthaixacminh = false;
                        klv.Add(k);

                        pn_capchar.Visible = false;
                        success = true;
                        string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                        int idlog = new Libs().LuuLogHoatDong(uSession.id, JsonConvert.SerializeObject(new { taikhoandangnhap.id_taikhoan, tendangnhap = taikhoandangnhap.taikhoan1, taikhoandangnhap.matkhau, taikhoandangnhap.tendaydu, taikhoandangnhap.email, taikhoandangnhap.sodienthoai, taikhoandangnhap.trangthaitk, taikhoandangnhap.id_nhomadmin, taikhoandangnhap.ngaytao, taikhoandangnhap.loaitaikhoan, taikhoandangnhap.avatar }, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                        new Libs().LoginThanhCong(idlog);

                        // gui ma xac minh

                        string mailto = taikhoandangnhap.email;
                        string subject = string.Format("Mã xác minh đăng nhập hệ thống quản trị C50");
                        string body = string.Format("Xin chào {0} !<br />Mã xác minh đăng nhập tài khoản <b>{1}</b> lúc {2} : <b>{3}</b><br /><br />Nếu không phải bạn mà là ai khác vui lòng liên hệ với chúng tôi để được hỗ trợ .<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", taikhoandangnhap.tendaydu, taikhoandangnhap.taikhoan1, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), k.maxacminh);
                        bool guimail = new Libs().sendEmail(mailto, subject, body);

                    }
                    else
                    {
                        pn_capchar.Visible = false;
                        loaddingpage.Attributes.CssStyle.Add("display", "none");
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Vui lòng reset lại trình duyệt và thử đăng nhập lại', 'error')", true);

                    }
                }
                else
                {
                    Libs.statusLogin statuslogin = new Libs.statusLogin();
                    statuslogin.captcha = 1;
                    Page.Session.Add("statuslogin", statuslogin);
                    pn_capchar.Visible = true;

                    var checkSave = entity.TaiKhoan.Where(mm => mm.taikhoan1 == ten).FirstOrDefault();
                    if (checkSave != null)
                    {
                        txtCapcha.Text = "";
                        msg = "Đăng nhập thất bại . Vui lòng thử lại ";
                        string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                        int idlog = new Libs().LuuLogHoatDongLoginFail(JsonConvert.SerializeObject(new { tendangnhap = ten, matkhau = pass, msg = msg }, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                        new Libs().LoginThatBai(idlog);
                    }
                    else
                    {
                        msg = "Tài khoản không tồn tại";
                    }
                }

                if (success == true)
                {
                    loaddingpage.Attributes.CssStyle.Add("display", "none");
                    //Response.Redirect("/index-admin", false);
                    Response.Redirect("/xac-minh-dang-nhap", false);
                }
                else
                {
                    loaddingpage.Attributes.CssStyle.Add("display", "none");
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", " swal('Thông báo ','" + msg + "', 'error')", true);
                }
            }
        }
        catch (Exception exx)
        {
            Libs.statusLogin statuslogin = new Libs.statusLogin();
            statuslogin.captcha = 1;
            Page.Session.Add("statuslogin", statuslogin);
            pn_capchar.Visible = true;
            loaddingpage.Attributes.CssStyle.Add("display", "none");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Có lỗi trong quá trình thao tác, vui lòng thực hiện lại', 'error')", true);
        }
    }
}