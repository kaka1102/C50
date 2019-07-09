<%@ Application Language="C#" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.Routing" %>

<script RunAt="server">
    void RegisterRoutes(RouteCollection routes)
    {
        routes.Ignore("{*allaxd}", new { allaxd = @".*\.axd(/.*)?" });
        routes.Ignore("{resource}.axd/{*pathInfo}");
        routes.Ignore("{resource}.ashx/{*pathInfo}");
        routes.MapPageRoute("Trace", "Trace.axd", "~/");

        // routes.MapPageRoute("chitietlog", "chi-tiet-log-he-thong/{type}-{idlog}.html", "~/SourceAdmin/module/ChiTietLog.aspx");

        routes.MapPageRoute("302", "302", "~/SourceAdmin/module/302.aspx");
        routes.MapPageRoute("404", "404", "~/SourceAdmin/module/404.aspx");

        routes.MapPageRoute("admin", "admin", "~/SourceAdmin/module/LoginAdmin.aspx");
        routes.MapPageRoute("index", "", "~/SourceClient/index.aspx");

        //menu cha
        routes.MapPageRoute("gioithieu", "gioi-thieu", "~/SourceClient/GioiThieu.aspx");
        routes.MapPageRoute("hoidap", "hoi-dap", "~/SourceClient/HoiDap.aspx");
        routes.MapPageRoute("guongdienhinh", "guong-dien-hinh", "~/SourceClient/DanhSach-TinTuc-SuKien.aspx");
        routes.MapPageRoute("canhbaonguoidan", "canh-bao-nguoi-dan", "~/SourceClient/DanhSach-TinTuc-SuKien.aspx");
        routes.MapPageRoute("tintucsukien", "tin-tuc-su-kien", "~/SourceClient/TinTucSuKien.aspx");
        routes.MapPageRoute("hoptacquocte", "hop-tac-quoc-te", "~/SourceClient/DanhSach-TinTuc-SuKien.aspx");
        routes.MapPageRoute("thuvien", "thu-vien", "~/SourceClient/ThuVien.aspx");
        routes.MapPageRoute("togiac", "to-giac", "~/SourceClient/ToGiac.aspx");
        routes.MapPageRoute("vanban", "van-ban", "~/SourceClient/VanBan.aspx");
        routes.MapPageRoute("lienhe", "lien-he", "~/SourceClient/LienHe.aspx");

        routes.MapPageRoute("tinhhuongkhancap", "tinh-huong-khan-cap", "~/SourceClient/TinhHuongKhanCap.aspx");

        routes.MapPageRoute("bieudothongketoipham", "bieu-do-thong-ke", "~/SourceClient/BieuDoThongKeToiPham.aspx");
        routes.MapPageRoute("timkiem", "tim-kiem", "~/SourceClient/KetQuaTimKiem.aspx");
        routes.MapPageRoute("sodoweb", "so-do-web", "~/SourceClient/SoDoWeb.aspx");
        // menu con
        routes.MapPageRoute("danhsachtintucsukien", "tin-tuc-su-kien/{menucon}", "~/SourceClient/DanhSach-TinTuc-SuKien.aspx");
        routes.MapPageRoute("danhsachhoptacquocte", "hop-tac-quoc-te/{menucon}", "~/SourceClient/DanhSach-TinTuc-SuKien.aspx");

        routes.MapPageRoute("danhsachthuvien", "thu-vien/{menucon}", "~/SourceClient/ThuVien.aspx");

        routes.MapPageRoute("danhsachduongdaynong", "tinh-huong-khan-cap/duong-day-nong", "~/SourceClient/TinhHuongKhanCap.aspx");
        routes.MapPageRoute("danhsachhuongdanxulytinhhuong", "tinh-huong-khan-cap/huong-dan-xu-ly-tinh-huong", "~/SourceClient/HuongDanKhanCap.aspx");

        routes.MapPageRoute("danhsachdanhmucvanban", "van-ban/{menucon}", "~/SourceClient/VanBan.aspx");

        // chi tiet gioi thieu
        routes.MapPageRoute("chitietbaivietgioithieu", "gioi-thieu/{link}", "~/SourceClient/GioiThieu.aspx");

        //chi tiet tin tuc , guong diien hinh , hop tac quoc te
        routes.MapPageRoute("chitietbvtintucsukien", "chi-tiet-tin-tuc/{linkbaiviet}-{idbv}.html", "~/SourceClient/TinTucChiTiet.aspx");

        //chi tiet van ban

        routes.MapPageRoute("chitietvanban", "chi-tiet-van-ban/{linkvanban}-{idbv}.{html}", "~/SourceClient/TinTucChiTiet.aspx");

        // chi tiet  huong dan xu ly tinh huong
        routes.MapPageRoute("chitiethuongdanxulytinhhuong", "huong-dan-xu-ly-tinh-huong/{linkbaiviet}-{idbv}.{html}", "~/SourceClient/TinTucChiTiet.aspx");

        //chi tiet hoi dap
        routes.MapPageRoute("chitiethoidap", "chi-tiet-hoi-dap/{linkbaiviet}-{idbv}.{html}", "~/SourceClient/TinTucChiTiet.aspx");

        // chi tiet thu vien
        routes.MapPageRoute("thuvienvideochitiet", "thuvienvideo/{linkbaiviet}-{idbv}.{html}", "~/SourceClient/ThuVien-ChiTiet.aspx");
        routes.MapPageRoute("thuvienhinhanhchitiet", "thuvienanh/{linkbaiviet}-{idbv}.{html}", "~/SourceClient/ThuVien-ChiTiet.aspx");
        DataC50Entities entity = new DataC50Entities();

        var danhsach = entity.tbl_Menu.Where(m => m.linkmenu != null && m.duongdan != null).ToList().Select(m => new
        {
            m.shortcode,
            m.linkmenu,
            m.duongdan
        }).ToList();

        for (int i = 0; i < danhsach.Count; i++)
        {
            routes.MapPageRoute(danhsach[i].shortcode, danhsach[i].linkmenu, danhsach[i].duongdan);
        }
    }

    void Application_Start(object sender, EventArgs e)
    {

        RegisterRoutes(RouteTable.Routes);
        Application["luottruycap"] = 0;
        Application["dangxem"] = 0;

    }

    void Application_End(object sender, EventArgs e)
    {
        Application.Lock();
        Application["dangxem"] = Convert.ToInt32(Application["dangxem"]) - 1;
        Application.UnLock();
        //string sessionId = this.Session.SessionID;
    }

    void Application_Error(object sender, EventArgs e)
    {
        Server.Transfer("/302");
    }

    void Session_Start(object sender, EventArgs e)
    {
        int count = 0;
        Application.Lock();
        Application["luottruycap"] = Convert.ToInt32(Application["luottruycap"]) + 1;
        Application["dangxem"] = Convert.ToInt32(Application["dangxem"]) + 1;
        Application.UnLock();
        Session.Add("captcha", null);

    }

    void Session_End(object sender, EventArgs e)
    {

        Application.Lock();
        Application["dangxem"] = Convert.ToInt32(Application["dangxem"]) - 1;
        string sessionId = this.Session.SessionID;
        List<kenhlamviec> klv = SocketHandler.klv;
        klv.Where(m => m.sessionid == sessionId).ToList().All(m =>
        {
            klv.Remove(m);
            return true;
        });
        Application.UnLock();

    }
    void Application_PreSendRequestHeaders()
    {
        Response.Headers.Remove("Server");
        Response.Headers.Remove("X-AspNet-Version");
        Response.Headers.Remove("X-AspNetMvc-Version");
    }
</script>
