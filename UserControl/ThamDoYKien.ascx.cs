using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_ThamDoYKien : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime date = DateTime.Now;
        var danhsach = entity.tbl_ThamDoYKien.Where(m => (m.trangthai == 2 || m.trangthai == 3) && (m.tbl_LichHienThiThamDoYKien.tungay.Value <= date && m.tbl_LichHienThiThamDoYKien.denngay.Value >= date)).ToList().Select(m => new
        {
            m.id_cauhoithamdo,
            m.cauhoi,
            m.tongsocautraloi,
            hinhthuctraloi = m.tbl_HinhthucTraLoi.hinhthuctraloi,
            id_hinhthuctraloi = m.id_hinhthuctraloi.Value,
            m.id_lich,
            tungay = m.tbl_LichHienThiThamDoYKien.tungay,
            denngay = m.tbl_LichHienThiThamDoYKien.denngay,
        }).ToList();
        if (danhsach.Count > 0)
        {
            RepeaterThamDoYkien.DataSource = danhsach;
            RepeaterThamDoYkien.DataBind();
        }
        else
        {
            RepeaterThamDoYkien.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "setdata('owl-question','" + "Không có câu hỏi hiển thị" + "')", true);
        }
    }
    protected void RepeaterThamDoYkien_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        DateTime date = DateTime.Now;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = e.Item.DataItem as DataRowView;
            string itemstr = Newtonsoft.Json.JsonConvert.SerializeObject(e.Item.DataItem);
            dynamic item = Newtonsoft.Json.JsonConvert.DeserializeObject(itemstr);
            int idDM = Convert.ToInt32(item["id_cauhoithamdo"]);
            var danhsachcautraloi = entity.tbl_DapAnThamDo.Where(x => x.trangthai == true && x.id_cauhoithamdo == idDM & x.tbl_ThamDoYKien.id_hinhthuctraloi.Value != 3).ToList().Select(x => new
              {
                  id_hinhthuctraloi = x.tbl_ThamDoYKien.id_hinhthuctraloi.Value,
                  x.noidungtraloi,
                  x.demcautraloi,
                  x.id_dapanthamdo
              }).ToList();

            Repeater Repeater2 = e.Item.FindControl("RepeaterCauTraLoi") as Repeater;
            if (danhsachcautraloi != null)
            {
                Repeater2.DataSource = danhsachcautraloi;
                Repeater2.DataBind();
            }

            else
            {
                Repeater2.Visible = false;
            }
        }

    }
}