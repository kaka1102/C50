using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_HoiDap : System.Web.UI.Page
{
    DataC50Entities timkiem = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            danhsachhoidap();
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        ///    danhsachhoidap();
    }
    public void danhsachhoidap()
    {
        try
        {
            string path = HttpContext.Current.Request.Path;
            uSend.Attributes.Add("style", "display:none");
            datetoSend.Attributes.Add("style", "display:none");

            string noidung = "";
            int linhvuc = 0;
            string tacgia = "";
            string dateS = "";
            string dateE = "";

            string nd = Page.Request.QueryString["nd"];
            string lv = Page.Request.QueryString["lv"];
            string tg = Page.Request.QueryString["tg"];
            string ds = Page.Request.QueryString["ds"];
            string de = Page.Request.QueryString["de"];
            string status = Page.Request.QueryString["status"];
            string statusAll = Page.Request.QueryString["statusAll"];


            if (nd != null)
            {
                nd = removeScriptAndCharacter.formatTextInput(nd);
                txtTenTimkiem.Text = nd;
                noidung = nd;
            }
            else
            {
                noidung = removeScriptAndCharacter.formatTextInput(txtTenTimkiem.Text);
            }
            if (lv != null)
            {
                int idcm = client.ToInt(lv);
                try
                {
                    var checkDM = timkiem.tbl_ChuyenMucLuaChon.Where(m => m.id_chuyenmuc == idcm && m.id_danhmuc.Value == 12).FirstOrDefault();
                    if (checkDM != null)
                    {
                        DropDownList1.SelectedValue = lv;
                        linhvuc = int.Parse(lv);
                    }
                }
                catch (Exception)
                {

                    DropDownList1.SelectedValue = "0";
                    linhvuc = 0;
                }
            }
            else
            {
                try
                {
                    linhvuc = int.Parse(DropDownList1.SelectedValue);
                }
                catch (Exception)
                {
                    linhvuc = 0;
                }

            }
            if (tg != null)
            {
                tg = removeScriptAndCharacter.formatTextInput(tg);
                nguoigui.Text = tg;
                tacgia = tg;
            }
            else
            {
                tacgia = removeScriptAndCharacter.formatTextInput(nguoigui.Text);
            }
            if (ds != null)
            {
                tungay.Text = ds;
                dateS = ds;
            }
            else
            {
                dateS = tungay.Text;
            }
            if (de != null)
            {
                denngay.Text = de;
                dateE = de;
            }
            else
            {
                dateE = denngay.Text;
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

            DateTime startDate = DateTime.Now;
            DateTime endDate = DateTime.Now;
            string dateSUrl = dateS;
            string dateEUrl = dateE;

            if (dateS != "")
            {
                startDate = DateTime.Parse(dateS);
                dateS = startDate.ToString("yyyy-MM-dd").Replace("-", "");
            }
            if (dateE != "")
            {
                endDate = DateTime.Parse(dateE);
                dateE = endDate.ToString("yyyy-MM-dd").Replace("-", "");
            }
            ObjectParameter totalCount = new ObjectParameter("totalCount", typeof(int));
            var danhsach = timkiem.SP_PHANTRANGHOIDAP(2, noidung, linhvuc, tacgia, dateS, dateE, currPage, 8, totalCount).ToList();
            if (danhsach.Count > 0)
            {
                //   ulPage.Attributes.Remove("style");
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
                if (linhvuc != 0)
                {
                    url = url + @"&lv=" + linhvuc + "";
                }
                if (!string.IsNullOrEmpty(tacgia))
                {
                    url = url + @"&tg=" + tacgia + "";
                }
                if (!string.IsNullOrEmpty(dateS))
                {
                    url = url + @"&ds=" + dateSUrl + "";
                }
                if (!string.IsNullOrEmpty(dateE))
                {
                    url = url + @"&de=" + dateEUrl + "";
                }
                url = url + "&status=true";

                // phân trang

                pageHTML = new returnHTMLPage().outputHTMLPage(total, currPage, url);
                DropDownList1.SelectedValue = linhvuc.ToString();
                txtTenTimkiem.Text = noidung;
                nguoigui.Text = tacgia;
                tungay.Text = dateSUrl;
                denngay.Text = dateEUrl;

                if ((!string.IsNullOrEmpty(tacgia)) || (!string.IsNullOrEmpty(dateSUrl)) || (!string.IsNullOrEmpty(dateEUrl)))
                {
                    uSend.Attributes.Add("style", "display:block");
                    datetoSend.Attributes.Add("style", "display:block");
                }

                //   noidungPage.InnerHtml = pageHTML;
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

                //pageDau.Attributes.Add("onclick", "window.location = '" + path + "?page=1" + url + "';");
                //pageCuoi.Attributes.Add("onclick", "window.location = '" + path + "?page=" + total + "" + url + "';");

                //pageTruoc.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageTr + "" + url + "';");

                //pageSau.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageS + "" + url + "';");
            }
            else
            {
                DropDownList1.SelectedValue = linhvuc.ToString();
                txtTenTimkiem.Text = noidung;
                nguoigui.Text = tacgia;
                tungay.Text = dateSUrl;
                denngay.Text = dateEUrl;
                if ((!string.IsNullOrEmpty(tacgia)) || (!string.IsNullOrEmpty(dateSUrl)) || (!string.IsNullOrEmpty(dateEUrl)))
                {
                    uSend.Attributes.Add("style", "display:block");
                    datetoSend.Attributes.Add("style", "display:block");
                }
                //   ulPage.Attributes.Add("style", "display:none");
                string pageHTML = "";
                //   noidungPage.InnerHtml = pageHTML;
                Repeater4.Visible = false;
                thongbaoketqua.InnerText = "Không có kết quả !";
            }
        }
        catch (Exception)
        {
            Response.StatusCode = 404;
            //Response.Redirect("/error-404.html");
            //ulPage.Attributes.Add("style", "display:none");
            //Repeater4.Visible = false;
            //thongbaoketqua.InnerText = "Không có kết quả !";
        }
    }
}

