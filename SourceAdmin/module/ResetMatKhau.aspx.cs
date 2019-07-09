using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class SourceAdmin_module_ResetMatKhau : System.Web.UI.Page
{
    Libs.statusLogin _session;
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            session = (Libs.statusLogin)HttpContext.Current.Session["statuslogin"];
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
            //if (session != null && session.tendangnhap != null && session.tendaydu != null)
            //{
            //    Response.Redirect("/index-admin");
            //}
        }
    }
    protected void btnLoginadmin_Click(object sender, EventArgs e)
    {
        session = (Libs.statusLogin)HttpContext.Current.Session["statuslogin"];
        string msg = "";
        bool sucess = false;
        string sessioncaptcha = "";
        string captchalogin = txtCapcha.Text;
        if (session.captcha == 1)
        {
            sessioncaptcha = Page.Session["captchalogin"].ToString();
        }

        string mknew = removeScriptAndCharacter.formatTextInput(mkmoi.Text);
        string mknew2 = removeScriptAndCharacter.formatTextInput(mkmoi2.Text);

        string resulf = new Libs().validateLogin(mknew);

        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        var uri = new Uri(returnVal);
        string keyLink = "";
        int Segmentss = uri.Segments.Length - 1;
        keyLink = uri.Segments[Segmentss];

        var checkKey = entity.tbl_LogResetMatKhau.Where(m => m.malink == keyLink && m.trangthai == false).FirstOrDefault();

        if (checkKey != null)
        {
            DateTime dateT = DateTime.Now;
            DateTime ngaytao = checkKey.ngaytao.Value;
            DateTime ngayhethan = ngaytao.AddDays(1);

            if (ngayhethan > dateT)
            {
                var tk = entity.TaiKhoan.Where(xx => xx.id_taikhoan == checkKey.id_taikhoan).FirstOrDefault();
                if (tk != null)
                {
                    if (mknew != "")
                    {
                        if (mknew2 != "")
                        {
                            if (mknew == mknew2)
                            {
                                if (resulf == "")
                                {
                                    if (session.captcha == 1 && captchalogin == "")
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
                                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { tk.taikhoan1, tk.tendaydu, tk.email, tk.sodienthoai, tk.trangthaitk, tk.id_nhomadmin, tk.id_taikhoan, tk.matkhau, tk.ngaytao, tk.loaitaikhoan, tk.avatar }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                        tk.matkhau = MD5.GeneratePasswordHash(mknew);
                                        entity.SaveChanges();

                                        checkKey.trangthai = true;
                                        checkKey.matkhaumoi = MD5.GeneratePasswordHash(mknew);

                                        entity.SaveChanges();
                                        sucess = true;
                                        msg = "Reset mật khẩu thành công ";

                                        string mailto = tk.email;
                                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", tk.tendaydu);
                                        string body = string.Format("Xin chào {0} !<br />Bạn đã thực hiện reset mật khẩu thành công .<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", tk.tendaydu);
                                        bool guimail = new Libs().sendEmail(mailto, subject, body);


                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(tk.id_taikhoan, JsonConvert.SerializeObject(new { thongtindangky = new { checkKey.id_LogReset, checkKey.id_taikhoan, checkKey.ngaytao, checkKey.trangthai, checkKey.malink, checkKey.matkhaumoi, checkKey.matkhaucu } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().ResetThanhCong(idlog);

                                        TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                                        string vitri1 = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                                        int idlog1 = new Libs().LuuLogHoatDong(tk.id_taikhoan, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { tk.taikhoan1, tk.tendaydu, tk.email, tk.sodienthoai, tk.trangthaitk, tk.id_nhomadmin, tk.id_taikhoan, tk.matkhau, tk.ngaytao, tk.loaitaikhoan, tk.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog1);
                                    }
                                }
                                else
                                {
                                    msg = "Mật khẩu không đủ mạnh ! </br>" + resulf;
                                }
                            }
                            else
                            {
                                msg = "Nhập lại mật khẩu không chính xác ";
                            }
                        }
                        else
                        {
                            msg = "Mời bạn nhập lại mật khẩu";
                        }
                    }
                    else
                    {
                        msg = "Mật khẩu không được để trống ";
                    }

                }
                else
                {
                    msg = "Tài khoản không tồn tại trong hệ thống";
                }
            }
            else
            {
                msg = "Link reset mật khẩu chỉ có hiệu lực trong 1 ngày";
            }
        }
        else
        {
            msg = "Link reset mật khẩu đã hết hạn hoặc không tồn tại";
        }

        if (sucess == false)
        {
            Libs.statusLogin statuslogin = new Libs.statusLogin();
            statuslogin.captcha = 1;
            Page.Session.Add("statuslogin", statuslogin);

            pn_capchar.Visible = true;

            txtCapcha.Text = "";

            string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDongResetMKFail(JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().ResetMKThatBai(idlog);
            loaddingpage.Attributes.CssStyle.Add("display", "none");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", " swal('Thông báo ','" + msg + "', 'error')", true);
        }
        else
        {
            Libs.statusLogin statuslogin = new Libs.statusLogin();
            statuslogin.captcha = 0;
            Page.Session.Add("statuslogin", statuslogin);

            pn_capchar.Visible = false;
            loaddingpage.Attributes.CssStyle.Add("display", "none");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", " swal('Thông báo ','" + msg + "', 'success')", true);
        }
    }

    public Libs.statusLogin session
    {
        get { return _session; }
        set { _session = value; }
    }
    public bool IsValid(string value)
    {
        return Regex.IsMatch(value, @"(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{10,16}$");
    }

}