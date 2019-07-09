using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

public partial class SourceClient_GioiThieu : System.Web.UI.Page
{
    private DataC50Entities db = new DataC50Entities();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        string type = HttpContext.Current.Request.Url.AbsolutePath;

        if (type == "/gioi-thieu")
        {
            string valDefault = db.tbl_BaiVietTrangGioiThieu.Where(x => x.trangthai == true).Select(x => x.noidung).FirstOrDefault();
            tieudebv.InnerHtml = valDefault;
        }
        else if (type == "/gioi-thieu/lanh-dao-cuc")
        {
        }
        else
        {
            string menuName = db.tbl_BaiVietTrangGioiThieu.Where(x => x.linkbaiGT == type).Select(x => x.noidung).FirstOrDefault();
            tieudebv.InnerHtml = menuName;
        }

        List<MenuGioiThieu> posts = (from item1 in db.Menu_Client
                  join item2 in db.Vitri_Menu on item1.id_danhmuc equals item2.id_danhmuc
                  where item1.trangthai == 1 && item1.idParent == 1 && item2.menuright == true && item2.trangthai == true
                  select new MenuGioiThieu
                  {
                      TenDanhMuc = item1.tendanhmuc,
                      LinkBaiViet = item1.duongdan
                  }).ToList();

     //   List<MenuGioiThieu> posts = db.Menu_Client.Where(n => n.trangthai == 1 && n.idParent == 1).Select(n => new MenuGioiThieu { TenDanhMuc = n.tendanhmuc, LinkBaiViet = n.duongdan }).ToList();
        menuItem.DataSource = posts;
        menuItem.DataBind();
    }

    public bool CayChucVu(out Libs.dscanbo canbo, int id)
    {
        canbo = null;
        bool accept = false;
        var cv = db.tbl_DanhSachChucVu.Where(x => x.id_chucvu == id).FirstOrDefault();
        if (cv != null)
        {
            accept = true;
            Libs.dscanbo cbTemp = new Libs.dscanbo();
            cbTemp.id_chucvu = cv.id_chucvu;
            cbTemp.idparent = cv.idParents.Value;
            cbTemp.tenchucvu = cv.tenchucvu;
            //cbTemp.
            List<Libs.thongtincanbo> dsCB = new List<Libs.thongtincanbo>();
            db.tbl_DanhSachCanBo.Where(x => x.id_chucvu == cv.id_chucvu).ToList().All(x =>
            {
                dsCB.Add(new Libs.thongtincanbo()
                {
                    anhdaidien = x.anhdaidien,
                    donvicongtac = x.donvicongtac,
                    tencanbo = x.tencanbo,
                    thongtinlienhe = x.thongtinlienhe,
                    quanham = x.quanham,
                    ngaysinh = x.ngaysinh.Value.ToString("dd/MM/yyyy"),
                    quequan = x.quequan,
                    id_chucvu = x.id_chucvu.Value,
                    tenchucvu = x.tbl_DanhSachChucVu.tenchucvu,
                    id_dscanbo = x.id_dscanbo,
                    trangthaicanbo = x.trangthaicanbo.Value,
                    idparent = x.tbl_DanhSachChucVu.idParents.Value

                });
                return true;
            });
            cbTemp.thongtincanbo = dsCB;
            List<Libs.dscanbo> dsCV = new List<Libs.dscanbo>();
            db.tbl_DanhSachChucVu.Where(x => x.idParents == cv.id_chucvu).ToList().All(x =>
            {
                Libs.dscanbo cvtemp = new Libs.dscanbo();
                if (CayChucVu(out cvtemp, x.id_chucvu))
                {
                    dsCV.Add(cvtemp);
                }
                return true;
            });
            cbTemp.danhsach = dsCV;
            canbo = cbTemp;
        }
        return accept;
    }

    List<Libs.thongtincanbo> tempTT = new List<Libs.thongtincanbo>();

    public void TaoSoDoCanBo(Libs.dscanbo oDanhMuc)
    {
        //if (oDanhMuc.danhsach.Count > 0)
        //{
        //    for (int i = 0; i < oDanhMuc.danhsach.Count; i++)
        //    {
        //        RepeaterLoopFirst.DataSource = oDanhMuc.thongtincanbo;
        //        RepeaterLoopFirst.DataBind();

        //        //for (int j = 0; j < oDanhMuc.thongtincanbo.Count; j++)
        //        //{
        //        //    var data = oDanhMuc.thongtincanbo[j];
        //        //}
        //        if (oDanhMuc.danhsach.Count > 0)
        //        {
        //          //  tempTT = oDanhMuc.thongtincanbo;
        //            TaoSoDoCanBo(oDanhMuc.danhsach[i]);
        //        }
        //    }
        //}

    }
    protected void RepeaterLoopFirst_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //{
        //    DataRowView drv = e.Item.DataItem as DataRowView;

        //    Repeater Repeater2 = e.Item.FindControl("RepeaterLoop") as Repeater;
        //    if (tempTT != null)
        //    {
        //        Repeater2.DataSource = tempTT;
        //        Repeater2.DataBind();
        //    }
        //    else
        //    {
        //        Repeater2.Visible = false;
        //    }
        //}
    }
}


public class MenuGioiThieu
{
    public string TenDanhMuc { get; set; }
    public int IdBaiViet { get; set; }
    public string LinkBaiViet { get; set; }
}