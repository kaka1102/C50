using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MT_Client : System.Web.UI.MasterPage
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        string path = HttpContext.Current.Request.Url.AbsoluteUri;
        string NewURL = removeScriptAndCharacter.formatURL(path);
        frmMain.Action = NewURL;

        if (!IsPostBack)
        {
            // check router
            string routerPage = Request.Url.AbsolutePath;
            if (routerPage != "/404")
            {
                var checkRouterPage = entity.Menu_Client.Where(m => m.duongdan == routerPage).FirstOrDefault();
                if (checkRouterPage != null)
                {
                    bool checkRouter = new client().CheckRouterUsing(checkRouterPage.id_danhmuc);

                    if (checkRouter == false)
                    {
                        Response.Redirect("/404");
                    }
                }
            }
            // check router

            loadbannerheader();
            loadlogo();
            loadmenubottom();
            loadmenuMobile();
            var ds = (from item1 in entity.Menu_Client
                      join item2 in entity.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                      where item1.trangthai == 1 && item1.idParent == 0 && item2.menutop == true && item2.trangthai == true
                      select new
                      {
                          item1.id_danhmuc,
                          item1.tendanhmuc,
                          item1.duongdan,
                          item1.sothutu
                      }).ToList().OrderByDescending(xx => xx.sothutu);
            if (ds != null)
            {
                Repeater1.DataSource = ds;
                Repeater1.DataBind();
            }
            else
            {
                Repeater1.Visible = false;
            }


        }

    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string itemstr = Newtonsoft.Json.JsonConvert.SerializeObject(e.Item.DataItem);
            dynamic item = Newtonsoft.Json.JsonConvert.DeserializeObject(itemstr);
            int id = Convert.ToInt32(item["id_danhmuc"]);

            var ds = (from item1 in entity.Menu_Client
                      join item2 in entity.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                      where item1.trangthai == 1 && item1.idParent == id && item2.menutop == true && item2.trangthai == true
                      select new
                      {
                          item1.id_danhmuc,
                          item1.tendanhmuc,
                          item1.duongdan
                      }).ToList();

            Repeater Repeater2 = e.Item.FindControl("Repeater2") as Repeater;
            Repeater2.DataSource = ds;
            Repeater2.DataBind();
        }
    }
    public void loadmenubottom()
    {
        var ds = (from item1 in entity.Menu_Client
                  join item2 in entity.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                  where item1.trangthai == 1 && item1.idParent == 0 && item2.menubottom == true && item2.trangthai == true
                  select new
                  {
                      item1.id_danhmuc,
                      item1.tendanhmuc,
                      item1.duongdan
                  }).ToList();
        if (ds != null)
        {
            Repeatermenubottom.DataSource = ds;
            Repeatermenubottom.DataBind();
        }
        else
        {
            Repeatermenubottom.Visible = false;
        }
    }

    public void loadmenuMobile()
    {
        var ds = (from item1 in entity.Menu_Client
                  join item2 in entity.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                  where item1.trangthai == 1 && item1.idParent == 0 && item2.menuright == true && item2.trangthai == true
                  select new
                  {
                      item1.id_danhmuc,
                      item1.tendanhmuc,
                      item1.duongdan,
                      item1.icon
                  }).ToList();
        if (ds != null)
        {
            RepeaterMobile.DataSource = ds;
            RepeaterMobile.DataBind();
        }
        else
        {
            RepeaterMobile.Visible = false;
        }
    }
    protected void RepeaterMobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string itemstr = Newtonsoft.Json.JsonConvert.SerializeObject(e.Item.DataItem);
            dynamic item = Newtonsoft.Json.JsonConvert.DeserializeObject(itemstr);
            int id = Convert.ToInt32(item["id_danhmuc"]);

            var ds = (from item1 in entity.Menu_Client
                      join item2 in entity.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                      where item1.trangthai == 1 && item1.idParent == id && item2.menuright == true && item2.trangthai == true
                      select new
                      {
                          item1.id_danhmuc,
                          item1.tendanhmuc,
                          item1.duongdan,
                          item1.icon
                      }).ToList();

            Repeater Repeatermb = e.Item.FindControl("RepeaterMobileChilren") as Repeater;
            Repeatermb.DataSource = ds;
            Repeatermb.DataBind();
        }
    }

    public void loadlogo()
    {
        DateTime date = DateTime.Now;

        try
        {
            var logoFooter = entity.QuanLyBanner.Where(m => m.trangthai == 1 && m.vitri == "Logo dưới" && m.type == "logo").ToList().Select(m => new
            {
                m.tenbanner,
                m.duongdanfile,
                ds = m.tbl_ChuKyHienThiBanner.Where(z => z.trangthai == 1 && (z.tungay.Value <= date && z.denngay > date)).ToList().OrderByDescending(z => z.mucdouutien.Value).FirstOrDefault(),
            }).ToList();

            if (logoFooter.Count > 0)
            {
                var bb = logoFooter.ToList().OrderByDescending(m => m.ds.mucdouutien.Value).FirstOrDefault();
                logofooter.InnerHtml = "<a title=''><img class='img-responsive' title='' alt='' src='" + bb.duongdanfile + "'/></a>";
            }
            else
            {

                logofooter.InnerHtml = "<a title=''  style='padding-top: 70px; float:left;'><img class='img-responsive' title='' alt='' src=''/></a>";
                //  logofooter.InnerHtml = "<a title=''><img class='img-responsive' title='' alt='' src='/SourceClient/img/logo.png'/></a>";
            }

        }
        catch (Exception)
        {
            logofooter.InnerHtml = "<a title=''  style='padding-top: 70px;float:left;'><img class='img-responsive' title='' alt='' src=''/></a>";
            // logofooter.InnerHtml = "<a title=''><img class='img-responsive' title='' alt='' src='/SourceClient/img/logo.png'/></a>";

        }

        try
        {
            var logoHeader = entity.QuanLyBanner.Where(m => m.trangthai == 1 && m.vitri == "Logo trên" && m.type == "logo").ToList().Select(m => new
            {
                m.tenbanner,
                m.duongdanfile,
                ds = m.tbl_ChuKyHienThiBanner.Where(z => z.trangthai == 1 && (z.tungay.Value <= date && z.denngay > date)).ToList().OrderByDescending(z => z.mucdouutien.Value).FirstOrDefault(),
            }).ToList();

            if (logoHeader.Count > 0)
            {
                var aa = logoHeader.ToList().OrderByDescending(m => (m.ds != null) ? m.ds.mucdouutien.Value : 0).FirstOrDefault();
                logoheader.InnerHtml = "<a href='../'><img class='img-responsive' src='" + aa.duongdanfile + "' alt=''/></a>";
            }
            else
            {
                logoheader.InnerHtml = "<a href='../'><img class='img-responsive' src='/SourceClient/img/LG02.png' alt=''/></a>";
            }
        }
        catch (Exception)
        {
            logoheader.InnerHtml = "<a href='../'><img class='img-responsive' src='/SourceClient/img/LG02.png' alt=''/></a>";
        }

    }

    public void loadbannerheader()
    {
        DateTime date = DateTime.Now;
        try
        {

            var bannerHeader = entity.QuanLyBanner.Where(m => m.trangthai == 1 && m.vitri == "Banner trên" && m.type == "banner").ToList().Select(m => new
            {
                m.tenbanner,
                m.duongdanfile,
                ds = m.tbl_ChuKyHienThiBanner.Where(z => z.trangthai == 1 && (z.tungay.Value <= date && z.denngay > date)).ToList().OrderByDescending(z => z.mucdouutien.Value).FirstOrDefault(),
            }).ToList();

            if (bannerHeader.Count > 0)
            {
                var aaaa = bannerHeader.OrderByDescending(m => (m.ds != null) ? m.ds.mucdouutien.Value : 0).FirstOrDefault();
                string css = "background: url('" + aaaa.duongdanfile + "') no-repeat bottom center;height: 152px; background-size: contain;";
                bannerH.Attributes.Add("style", css);
            }
            else
            {
                string css = "background: url('/SourceClient/img/bannertopdefaulf.png') no-repeat bottom center;height: 152px; background-size: contain;";
                bannerH.Attributes.Add("style", css);
            }
        }
        catch (Exception)
        {
            string css = "background: url('/SourceClient/img/bannertopdefaulf.png') no-repeat bottom center;height: 152px; background-size: contain;";
            bannerH.Attributes.Add("style", css);
        }


        try
        {
            var bannerFooter = entity.QuanLyBanner.Where(m => m.trangthai == 1 && m.vitri == "Banner dưới" && m.type == "banner").ToList().Select(m => new
            {
                m.tenbanner,
                m.duongdanfile,
                ds = m.tbl_ChuKyHienThiBanner.Where(z => z.trangthai == 1 && (z.tungay.Value <= date && z.denngay > date)).ToList().OrderByDescending(z => z.mucdouutien.Value).FirstOrDefault(),
            }).ToList();

            if (bannerFooter.Count > 0)
            {
                var bbbb = bannerFooter.ToList().OrderByDescending(m => (m.ds != null) ? m.ds.mucdouutien.Value : 0).FirstOrDefault();
                string css = "background: url('" + bbbb.duongdanfile + "') no-repeat bottom center;background-size: cover;";
                footer.Attributes.Add("style", css);
            }
            else
            {
                string css = "background: url('/SourceClient/img/bannerbottomdefaulf.jpg') no-repeat bottom center;background-size: cover;";
                footer.Attributes.Add("style", css);
            }
        }
        catch (Exception)
        {
            string css = "background: url('/SourceClient/img/bannerbottomdefaulf.jpg') no-repeat bottom center;background-size: cover;";
            footer.Attributes.Add("style", css);
        }
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("/login-client");
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
