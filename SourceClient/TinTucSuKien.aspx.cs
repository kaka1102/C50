using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_TinTucSuKien : System.Web.UI.Page
{
    private DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string type = HttpContext.Current.Request.Url.AbsolutePath;
            DateTime date = DateTime.Now;
            var checktype = entity.Menu_Client.Where(m => m.duongdan == type).Select(m => m).FirstOrDefault();
            if (checktype != null)
            {
                //if(checktype.idParent ==0){
                //    bien = true;
                //}
                var danhsachcon = entity.Menu_Client.Where(x => x.idParent == checktype.id_danhmuc && x.trangthai == 1).ToList().Select(x => new
                {
                    x.id_danhmuc,
                    tendanhmuc = x.tendanhmuc.ToUpper(),
                    x.link_danhmuc,
                    x.shortcode,
                    x.duongdan,
                    top = x.tbl_Vitribv.Where(xx => xx.id_danhmuc == x.id_danhmuc && xx.trangthaibaiviet == 1 && xx.ngaydang < date).ToList().Select(xx => new
                        {
                            xx.id_vitribv,
                            xx.id_baiviet,
                            xx.id_danhmuc,
                            xx.soluotlike,
                            xx.soluotview,
                            ngaydang = xx.ngaydang.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                            xx.linkbaiviet,
                            tieude = xx.tbl_Baiviet.tieude,
                            gioithieu = xx.tbl_Baiviet.gioithieu,
                            noidung = xx.tbl_Baiviet.noidung,
                            tacgia = xx.tbl_Baiviet.tacgia,
                            tag = xx.tbl_Baiviet.tag,
                            avatar = xx.tbl_Baiviet.avatar
                        }).OrderByDescending(xx => xx.ngaydang).FirstOrDefault()
                }).ToList();

                if (danhsachcon != null)
                {
                    RepeaterDANHMUCTINTUCSUKIEN.DataSource = danhsachcon;
                    RepeaterDANHMUCTINTUCSUKIEN.DataBind();
                }
                else
                {
                    RepeaterDANHMUCTINTUCSUKIEN.Visible = false;
                }
            }
            else
            {
                Response.Redirect("/error-404.html");
            }
        }

    }
    protected void RepeaterDANHMUCTINTUCSUKIEN_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater Repeater2 = e.Item.FindControl("RepeaterDanhSachBaiViet") as Repeater;
        try
        {
            DateTime date = DateTime.Now;
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                string itemstr = Newtonsoft.Json.JsonConvert.SerializeObject(e.Item.DataItem);
                dynamic item = Newtonsoft.Json.JsonConvert.DeserializeObject(itemstr);
                int idDM = Convert.ToInt32(item["id_danhmuc"]);
                int idBV = item["top"]["id_baiviet"];
                var danhsachbaiviet = entity.tbl_Vitribv.Where(xx => xx.id_baiviet != idBV && xx.id_danhmuc == idDM && xx.trangthaibaiviet == 1 && xx.ngaydang < date).ToList().Select(xx => new
                         {
                             xx.id_vitribv,
                             xx.soluotlike,
                             xx.soluotview,
                             ngaydang = xx.ngaydang.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                             xx.linkbaiviet,
                             tieude = xx.tbl_Baiviet.tieude,
                             gioithieu = xx.tbl_Baiviet.gioithieu,
                             noidung = xx.tbl_Baiviet.noidung,
                             tacgia = xx.tbl_Baiviet.tacgia,
                             tag = xx.tbl_Baiviet.tag,
                             avatar = xx.tbl_Baiviet.avatar
                         }).OrderByDescending(xx => xx.ngaydang).ToList();


                if (danhsachbaiviet != null && danhsachbaiviet.Count >= 4)
                {
                    var danhsach = danhsachbaiviet.Take(4);
                    Repeater2.DataSource = danhsach;
                    Repeater2.DataBind();
                }
                else if (danhsachbaiviet != null && danhsachbaiviet.Count < 4)
                {
                    Repeater2.DataSource = danhsachbaiviet;
                    Repeater2.DataBind();
                }
                else
                {
                    Repeater2.Visible = false;
                }
            }
        }
        catch (Exception)
        {
            Repeater2.Visible = false;
        }
    }
}