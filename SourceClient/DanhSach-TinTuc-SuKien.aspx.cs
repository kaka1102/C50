using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_TinTuc_SuKien_TinHoatDongCuc : System.Web.UI.Page
{
    private DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            string path = HttpContext.Current.Request.Path;
            string type = HttpContext.Current.Request.Url.AbsolutePath;
            int curent = 0;
            int currPage = 1;
            if (Page.Request.QueryString["page"] != null)
            {
                if (int.TryParse(Page.Request.QueryString["page"], out curent))
                {
                    if (curent > 0 && curent < 10000)
                    {
                        string status = Page.Request.QueryString["status"];
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

            DateTime date = DateTime.Now;
            string dateInput = date.ToString("yyyy-MM-dd");

            var checktype = entity.Menu_Client.Where(m => m.duongdan == type && m.trangthai == 1).ToList().Select(m => new
            {
                m.id_danhmuc,
                m.duongdan,
                tendanhmuc = m.tendanhmuc.ToUpper()
            }).ToList();

            if (checktype != null)
            {

                RepeaterDANHSACHTINTUCSUKIEN.DataSource = checktype;
                RepeaterDANHSACHTINTUCSUKIEN.DataBind();

                int getid = entity.Menu_Client.Where(mm => mm.duongdan == type && mm.trangthai == 1).Select(mm => mm.id_danhmuc).FirstOrDefault();

                ObjectParameter totalCount = new ObjectParameter("totalCount", typeof(int));
                var danhsachbvdanhmuc = entity.SP_LOADDANHSACHBAIVIET(getid, 1, date, currPage, 6, totalCount).ToList().Select(x => new
                {
                    x.id_vitribv,
                    x.id_baiviet,
                    x.soluotlike,
                    x.soluotview,
                    ngaydang = x.ngaydang.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                    x.linkbaiviet,
                    tieude = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.tieude).FirstOrDefault(),
                    gioithieu = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.gioithieu).FirstOrDefault(),
                    noidung = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.noidung).FirstOrDefault(),
                    tacgia = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.tacgia).FirstOrDefault(),
                    tag = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.tag).FirstOrDefault(),
                    avatar = entity.tbl_Baiviet.Where(xx => xx.id_baiviet == x.id_baiviet).Select(xx => xx.avatar).FirstOrDefault(),
                }).ToList();

                if (danhsachbvdanhmuc.Count > 0)
                {
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB1.Visible = true;
                    thongbaoketqua.InnerText = "";
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB1.DataSource = danhsachbvdanhmuc;
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB1.DataBind();

                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB2.Visible = true;
                    thongbaoketqua2.InnerText = "";
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB2.DataSource = danhsachbvdanhmuc;
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB2.DataBind();

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
                    url = url + "&status=true";
                    // phân trang

                    if (total >= 1)
                    {
                        pageHTML = new returnHTMLPage().outputHTMLPage(total, currPage, url);
                        //  noidungPage.InnerHtml = pageHTML;
                        //noidungPage1.InnerHtml = pageHTML;

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
                        Literal2.Text = HTMLPage;
                        //pageDau.Attributes.Add("onclick", "window.location = '" + path + "?page=1" + url + "';");
                        //pageCuoi.Attributes.Add("onclick", "window.location = '" + path + "?page=" + total + "" + url + "';");
                        //pageTruoc.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageTr + "" + url + "';");
                        //pageSau.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageS + "" + url + "';");

                        //pageDau1.Attributes.Add("onclick", "window.location = '" + path + "?page=1" + url + "';");
                        //pageCuoi1.Attributes.Add("onclick", "window.location = '" + path + "?page=" + total + "" + url + "';");
                        //pageTruoc1.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageTr + "" + url + "';");
                        //pageSau1.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageS + "" + url + "';");
                    }
                }
                else
                {

                    //   ulPage.Attributes.Add("style", "display:none");
                    //  ulPage1.Attributes.Add("style", "display:none");
                    //  string pageHTML = "";
                    //   noidungPage.InnerHtml = pageHTML;
                    // noidungPage1.InnerHtml = pageHTML;
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB1.Visible = false;
                    RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB2.Visible = false;
                    thongbaoketqua.InnerText = "Không có kết quả !";
                    thongbaoketqua2.InnerText = "Không có kết quả !";
                }
            }
            else
            {
                RepeaterDANHSACHTINTUCSUKIEN.Visible = false;
                //  ulPage.Attributes.Add("style", "display:none");
                // ulPage1.Attributes.Add("style", "display:none");
                thongbaoketqua.InnerText = "Không có kết quả !";
                thongbaoketqua2.InnerText = "Không có kết quả !";
            }
        }
        catch (Exception)
        {
            //Response.Redirect("/error-404.html");
            //RepeaterDANHSACHTINTUCSUKIEN.Visible = false;
            //ulPage.Attributes.Add("style", "display:none");
            //ulPage1.Attributes.Add("style", "display:none");
            //thongbaoketqua.InnerText = "Không có kết quả !";
            //thongbaoketqua2.InnerText = "Không có kết quả !";
            Response.StatusCode = 404;
        }
    }

}