using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.MasterPage
{
    string chuoiHTMLCon = "";
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                string ComputerName = System.Environment.MachineName;
                string ip = HttpContext.Current.Request.UserHostAddress;
                string Agent = Request.UserAgent;

                List<kenhlamviec> klv = SocketHandler.klv;

                Libs.userDangNhap uSession = (Libs.userDangNhap)Session["uSession"];
                if (uSession != null)
                {
                    var check = klv.Where(m => m.trangthaixacminh == true && m.maxacminh != null && m.Agent == Agent && m.ComputerName == ComputerName && m.id == uSession.id && m.ip == ip && m.sessionid == uSession.sessionid && m.tendangnhap == uSession.tendangnhap && m.tendaydu == uSession.tendaydu).FirstOrDefault();
                    if (check != null)
                    {
                        var thongtincanhan = entity.TaiKhoan.Where(m => m.id_taikhoan == uSession.id).Select(m => new
                        {
                            m.avatar,
                            m.email,
                            m.id_nhomadmin,
                            m.id_taikhoan,
                            m.loaitaikhoan,
                            m.matkhau,
                            m.ngaytao,
                            m.sodienthoai,
                            m.taikhoan1,
                            m.tendaydu,
                            m.trangthaitk,
                            tennhomadmin = m.NhomAdmin.tennhom
                        }).FirstOrDefault();

                        tenadmin11.InnerText = thongtincanhan.tendaydu;


                        if (thongtincanhan.loaitaikhoan == 3)
                        {
                            email.InnerText = "Quản trị cấp cao";
                        }
                        else
                        {
                            email.InnerText = "Quản trị viên";
                        }
                        avatarAD.InnerHtml = "<img src='" + thongtincanhan.avatar + "' class='img-circle'>";
                        List<jsonmenu> oDanhMuc = new List<jsonmenu>();

                        //  string href = string.Format("{0}", new Libs().getSegmentsUrl(HttpContext.Current.Request.UrlReferrer.AbsoluteUri, 1));
                        //  string href = Page.RouteData.Values;

                        string href = HttpContext.Current.Request.Url.AbsolutePath;
                        href = href.Substring(1);
                        entity.tbl_Menu.Where(m => m.idParent == 0 && m.trangthai == 1).ToList().OrderBy(m => m.sothutu).All(x =>
                        {
                            jsonmenu m = new jsonmenu();
                            m.id_menu = x.id_menu;
                            m.tenmenu = x.tenmenu;
                            m.vitri = x.vitri;
                            m.trangthai = x.trangthai;
                            m.id_parent = x.idParent.Value;
                            m.sothutu = x.sothutu;
                            m.href = x.linkmenu;
                            m.icon = x.icon;
                            m.active = (x.linkmenu == href ? "active" : "");
                            hienthimenuAdmin(m);
                            oDanhMuc.Add(m);
                            return true;
                        });

                        string aaaa = taohtml(oDanhMuc);
                        menuadmin.InnerHtml = aaaa;
                    }
                    else
                    {
                        Response.Redirect("/admin", false);
                    }
                }
                else
                {
                    Response.Redirect("/admin", false);
                }
            }
            catch (Exception)
            {
                Response.Redirect("/admin", false);
            }
        }

    }


    string taohtml(List<jsonmenu> danhsach)
    {
        chuoiHTMLCon += "<ul class='treeview-menu'>";
        foreach (var item in danhsach)
        {
            string muiten = "";
            if (item.danhsach.Count > 0 && item.id_parent == 0)
            {
                muiten = "<span class='pull-right-container'><i class='fa fa-angle-right pull-right'></i></span>";
            }
            else
            {
                muiten = "";
            }
            chuoiHTMLCon = chuoiHTMLCon + "<li class='" + item.active + "'><a " + ((item.href == null) ? "" : "href=" + item.href + "") + "><i class='" + item.icon + "'></i><span>" + item.tenmenu.ToUpper() + "</span>" + muiten + "</a>";
            if (item.danhsach.Count > 0)
            {
                taohtml(item.danhsach);
            }
            chuoiHTMLCon += "</li>";
        }
        chuoiHTMLCon += "</ul>";
        return chuoiHTMLCon;
    }

    jsonmenu hienthimenuAdmin(jsonmenu menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        //   string href = string.Format("{0}", new Libs().getSegmentsUrl(HttpContext.Current.Request.UrlReferrer.AbsoluteUri, 1));
        string href = HttpContext.Current.Request.Url.AbsolutePath;
        href = href.Substring(1);
        List<jsonmenu> ltrmenu = new List<jsonmenu>();
        (from a in ketnoi.tbl_Menu where a.idParent == menu.id_menu && a.trangthai == 1 select a).ToList().OrderBy(x => x.sothutu).All(x =>
        {
            jsonmenu m = new jsonmenu();
            m.id_menu = x.id_menu;
            m.tenmenu = x.tenmenu;
            m.vitri = x.vitri;
            m.id_parent = x.idParent.Value;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.href = x.linkmenu;
            m.icon = x.icon;
            m.active = (x.linkmenu == href ? "active" : "");
            hienthimenuAdmin(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;

        return menu;
    }
}
public class jsonmenu
{
    public int id_menu { get; set; }
    public int id_parent { get; set; }
    public string vitri { get; set; }
    public int? trangthai { get; set; }
    public int? sothutu { get; set; }
    public string tenmenu { get; set; }
    public string href { get; set; }
    public string icon { get; set; }
    public string active { get; set; }
    public List<jsonmenu> danhsach { get; set; }
}
