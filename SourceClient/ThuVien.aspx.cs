using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_ThuVien : System.Web.UI.Page
{
    DataC50Entities entity = new DataC50Entities();
    string type = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        type = HttpContext.Current.Request.Url.PathAndQuery;
        if (!IsPostBack)
        {
            DANHSACHTHUVIEN();
        }
    }
    protected void btnTimKiem_Click(object sender, EventArgs e)
    {
    }

    public void DANHSACHTHUVIEN()
    {
        try
        {
            string path = HttpContext.Current.Request.Path;
            string pathTab = null;
            if (path == "/thu-vien/hinh-anh")
            {
                pathTab = "thuvienanh";
            }
            else if (path == "/thu-vien/video")
            {
                pathTab = "thuvienvideo";
            }
            else
            {
                path = null;
            }
            string noidungTK = "";

            string nd = Page.Request.QueryString["nd"];
            string status = Page.Request.QueryString["status"];
            string statusAll = Page.Request.QueryString["statusAll"];

            if (nd != null)
            {
                nd = removeScriptAndCharacter.formatTextInput(nd);
              //  noidung.Text = nd;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('noidung','" + nd + "')", true);
                noidungTK = nd;
            }
            //else
            //{
            //    noidungTK = removeScriptAndCharacter.formatTextInput(noidung.Text);
            //}

            //int curent = 0;
            //if (Page.Request.QueryString["page"] != null)
            //{
            //    if (!(int.TryParse(Page.Request.QueryString["page"], out curent)))
            //    {
            //        Response.Redirect("/error-404.html");
            //    }
            //}
            //int currPage = 1;
            //if (status != null)
            //{
            //    if (curent == 0)
            //    {
            //        currPage = 1;
            //    }
            //    else
            //    {
            //        currPage = curent;
            //    }
            //    if (!(status == "true" || status == "false")) Response.Redirect("/error-404.html");
            //}
            //if (statusAll != null)
            //{
            //    if (!(statusAll == "true" || statusAll == "false")) Response.Redirect("/error-404.html");
            //    currPage = 1;
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "ChangeUrl('aaa','?page=" + currPage + "')", true);
            //}
            //if (currPage > 10000)
            //{
            //    Response.Redirect("/error-404.html");
            //}


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
            var ds = entity.SP_THUVIEN(2, noidungTK, pathTab, currPage, 6, totalCount).ToList().Select(m => new
            {
                m.id_thuvien,
                m.tieude,
                m.gioithieu,
                m.noidung,
                thoigian = m.ngayupload.Value.ToString("dd/MM/yyyy"),
                m.loaithuvien,
                m.linlthuvien,
                ngayupload = m.ngayupload.Value,
                luotxem = m.luotxem.Value,
                avatar = entity.tbl_ChiTietThuVien.Where(x => x.trangthai == 1 && x.id_thuvien == m.id_thuvien).Select(x => x.duongdanfile).FirstOrDefault()
            }).ToList();
            if (ds.Count > 0)
            {
                if (type.IndexOf("orderby-view") >= 0)
                {
                    ds = ds.OrderByDescending(m => m.luotxem).ToList();
                }
                else if (type.IndexOf("orderby-name") >= 0)
                {
                    ds = ds.OrderBy(m => m.tieude).ToList();
                }
                else
                {
                    ds = ds.OrderByDescending(m => m.ngayupload).ToList();
                }


                RepeaterTHUVIENALL.Visible = true;
                thongbaoketqua.InnerText = "";
                RepeaterTHUVIENALL.DataSource = ds;
                RepeaterTHUVIENALL.DataBind();

                int total = int.Parse(totalCount.Value.ToString());
                if (total % 6 == 0)
                {
                    total = total / 6;
                }
                else
                {
                    total = (total / 6) + 1;
                }
                string pageHTML = "";
                string url = "";

                if (!string.IsNullOrEmpty(noidungTK))
                {
                    url = url + @"&nd=" + noidungTK + "";
                }
                url = url + "&status=true";

                // phân trang

                pageHTML = new returnHTMLPage().outputHTMLPage(total, currPage, url);

              //  noidung.Text = noidungTK;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('noidung','" + noidungTK + "')", true);
            //    noidungPage.InnerHtml = pageHTML;
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
              //  noidung.Text = noidungTK;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('noidung','" + noidungTK + "')", true);
             //   ulPage.Attributes.Add("style", "display:none");
              //  noidungPage.InnerHtml = pageHTML;
                RepeaterTHUVIENALL.Visible = false;
                thongbaoketqua.InnerText = "Không có kết quả !";
            }
        }
        catch (Exception)
        {
            Response.StatusCode = 404;
            //Response.Redirect("/error-404.html");
            //ulPage.Attributes.Add("style", "display:none");
            //RepeaterTHUVIENALL.Visible = false;
            //thongbaoketqua.InnerText = "Không có kết quả !";
        }

    }
}
