using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_HuongDanKhanCap : System.Web.UI.Page
{
    DataC50Entities xulytinhhuong = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DANHSACHTINHHUONGKHANCAP();
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
    }
    public void DANHSACHTINHHUONGKHANCAP()
    {
        try
        {
            string path = HttpContext.Current.Request.Path;
            string noidung = "";

            string nd = Page.Request.QueryString["nd"];
            string status = Page.Request.QueryString["status"];
            string statusAll = Page.Request.QueryString["statusAll"];

            if (nd != null)
            {
                nd = removeScriptAndCharacter.formatTextInput(nd);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('txtTenTimkiem','" + nd + "')", true);
                noidung = nd;
            }

            int curent = 0;
            int currPage = 1;
            if (Page.Request.QueryString["page"] != null)
            {
                if (int.TryParse(Page.Request.QueryString["page"], out curent))
                {
                    if (curent > 0 && curent < 10000)
                    {
                        if (!string.IsNullOrEmpty(status))
                        {
                            bool bstatus = true;

                            if (bool.TryParse(status, out bstatus))
                            {
                                currPage = curent;
                            }
                            else
                            {
                                Response.StatusCode = 404;
                            }
                        }
                    }
                    else
                    {
                        Response.StatusCode = 404;
                    }
                }
                else
                {
                    Response.StatusCode = 404;
                }
            }
            if (!string.IsNullOrEmpty(statusAll))
            {
                bool bstatusAll = true;
                if (bool.TryParse(statusAll, out bstatusAll))
                {
                    if (Page.Request.QueryString["page"] != null) ///moi them nay
                    {
                        currPage = 1;
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "ChangeUrl('aaa','?page=" + currPage + "')", true);
                    }
                }
                else
                {
                    Response.StatusCode = 404;
                }
            }
            ObjectParameter totalCount = new ObjectParameter("totalCount", typeof(int));
            var danhsach = xulytinhhuong.SP_TINHUONGKHANCAP(2, noidung, currPage, 8, totalCount).ToList();
            if (danhsach.Count > 0)
            {

                Repeater4.Visible = true;
                thongbaoketqua.InnerText = "";
                Repeater4.DataSource = danhsach;
                Repeater4.DataBind();

                int total = int.Parse(totalCount.Value.ToString());
                if (total % 8 == 0)
                {
                    total = total / 8;
                }
                else
                {
                    total = (total / 8) + 1;
                }
                string pageHTML = "";
                string url = "";

                if (!string.IsNullOrEmpty(noidung))
                {
                    url = url + @"&nd=" + noidung + "";
                }
                url = url + "&status=true";

                // phân trang

                pageHTML = new returnHTMLPage().outputHTMLPage(total, currPage, url);

                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('txtTenTimkiem','" + noidung + "')", true);

                int pageTr = 0;
                int pageS = 0;
                if (currPage == 1)
                {
                    pageTr = 1;
                }
                else
                {
                    pageTr = currPage - 1;
                }
                if (currPage == total)
                {
                    pageS = total;
                }
                else
                {
                    pageS = currPage + 1;
                }

                string HTMLPage = "";
                HTMLPage = HTMLPage + @"<ul>";
                HTMLPage = HTMLPage + @"<li>";
                HTMLPage = HTMLPage + @"<a href='" + path + "?page=1" + url + "' id='pageDau'>Đầu</a>";
                HTMLPage = HTMLPage + @"<a href='" + path + "?page=" + pageTr + "" + url + "' id='pageTruoc'>Trước</a>";
                HTMLPage = HTMLPage + @"</li>";
                HTMLPage = HTMLPage + @"<li>" + pageHTML + "</li>";
                HTMLPage = HTMLPage + @"<li>";
                HTMLPage = HTMLPage + @"<a href='" + path + "?page=" + pageS + "" + url + "' id='pageSau'>Sau</a>";
                HTMLPage = HTMLPage + @"<a href='" + path + "?page=" + total + "" + url + "' id='pageCuoi'>Cuối</a>";
                HTMLPage = HTMLPage + @"</li>";
                HTMLPage = HTMLPage + @"</ul>";
                Literal1.Text = HTMLPage;
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('txtTenTimkiem','" + noidung + "')", true);
                Repeater4.Visible = false;
                thongbaoketqua.InnerText = "Không có kết quả !";
            }
        }
        catch (Exception)
        {
            Response.StatusCode = 404;
        }

    }
}