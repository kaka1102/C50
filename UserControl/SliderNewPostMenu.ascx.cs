using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_SliderNewPostMenu : System.Web.UI.UserControl
{
    private DataC50Entities entity = new DataC50Entities();
    string type = HttpContext.Current.Request.Url.AbsolutePath;
    DateTime date = DateTime.Now;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            var listbv = GetAllNewPost();
            var danhsachSlider = listbv.GroupBy(
                            p => p.id_baiviet,
                            (key, g) => new
                            {
                                id_baiviet = key,
                                id_vitribv = g.Select(xx => xx.id_vitribv).FirstOrDefault(),
                                ngaydang = g.Select(xx => xx.ngaydang).FirstOrDefault(),
                                linkbaiviet = g.Select(xx => xx.linkbaiviet).FirstOrDefault(),
                                tieude = g.Select(xx => xx.tieude).FirstOrDefault(),
                                gioithieu = g.Select(xx => xx.gioithieu).FirstOrDefault(),
                                noidung = g.Select(xx => xx.noidung).FirstOrDefault(),
                                tacgia = g.Select(xx => xx.tacgia).FirstOrDefault(),
                                tag = g.Select(xx => xx.tag).FirstOrDefault(),
                                avatar = g.Select(xx => xx.avatar).FirstOrDefault(),
                            }).OrderByDescending(xx => xx.ngaydang).ToList();


            if (danhsachSlider != null && danhsachSlider.Count >= 10)
            {
                var danhsach = danhsachSlider.Take(10).ToList();
                RepeaterSlider1.DataSource = danhsach;
                RepeaterSlider1.DataBind();
            }
            else if (danhsachSlider != null && danhsachSlider.Count < 10)
            {

                RepeaterSlider1.DataSource = danhsachSlider.ToList();
                RepeaterSlider1.DataBind();
            }
            else
            {
                RepeaterSlider1.Visible = false;
            }
        }
        catch (Exception)
        {
            RepeaterSlider1.Visible = false;
        }
    }

    public List<Contructor.baiviet> GetAllNewPost()
    {

        List<Contructor.baiviet> listbv = new List<Contructor.baiviet>();
        try
        {

            if (type == "/")
            {
                type = "/tin-tuc-su-kien";
            }
            int menu = entity.Menu_Client.Where(x => x.duongdan == type).Select(x => x.id_danhmuc).FirstOrDefault();
            client.jsonmenuClient _listParent = new client.jsonmenuClient();
            _listParent.id_danhmuc = menu;
            _listParent = new client().getdanhmucmenu(_listParent);

            var dscha = entity.tbl_Vitribv.Where(zz => zz.id_danhmuc == menu && zz.trangthaibaiviet == 1).ToList().Select(zz => new
            {
                zz.id_baiviet,
                zz.id_vitribv,
                zz.ngaydang,
                zz.linkbaiviet,
                tieude = zz.tbl_Baiviet.tieude,
                gioithieu = zz.tbl_Baiviet.gioithieu,
                noidung = zz.tbl_Baiviet.noidung,
                tacgia = zz.tbl_Baiviet.tacgia,
                tag = zz.tbl_Baiviet.tag,
                avatar = zz.tbl_Baiviet.avatar
            }).OrderByDescending(zz => zz.ngaydang).ToList();
            if (dscha.Count > 0)
            {

                for (int j = 0; j < dscha.Count; j++)
                {
                    Contructor.baiviet bbb = new Contructor.baiviet();
                    bbb.id_baiviet = dscha[j].id_baiviet.Value;
                    bbb.id_vitribv = dscha[j].id_vitribv;
                    bbb.ngaydang = dscha[j].ngaydang.Value;
                    bbb.linkbaiviet = dscha[j].linkbaiviet;
                    bbb.tieude = dscha[j].tieude;
                    bbb.gioithieu = dscha[j].gioithieu;
                    bbb.noidung = dscha[j].noidung;
                    bbb.tacgia = dscha[j].tacgia;
                    bbb.tag = dscha[j].tag;
                    bbb.avatar = dscha[j].avatar;
                    listbv.Add(bbb);
                }
            }


            for (int i = 0; i < _listParent.danhsach.Count; i++)
            {
                int id = _listParent.danhsach[i].id_danhmuc;

                var dsbv = entity.tbl_Vitribv.Where(zz => zz.id_danhmuc == id && zz.trangthaibaiviet == 1).ToList().Select(zz => new
                {
                    zz.id_baiviet,
                    zz.id_vitribv,
                    zz.ngaydang,
                    zz.linkbaiviet,
                    tieude = zz.tbl_Baiviet.tieude,
                    gioithieu = zz.tbl_Baiviet.gioithieu,
                    noidung = zz.tbl_Baiviet.noidung,
                    tacgia = zz.tbl_Baiviet.tacgia,
                    tag = zz.tbl_Baiviet.tag,
                    avatar = zz.tbl_Baiviet.avatar
                }).OrderByDescending(zz => zz.ngaydang).ToList();
                if (dsbv.Count > 0)
                {
                    for (int j = 0; j < dsbv.Count; j++)
                    {
                        Contructor.baiviet bbb = new Contructor.baiviet();
                        bbb.id_baiviet = dsbv[j].id_baiviet.Value;
                        bbb.id_vitribv = dsbv[j].id_vitribv;
                        bbb.ngaydang = dsbv[j].ngaydang.Value;
                        bbb.linkbaiviet = dsbv[j].linkbaiviet;
                        bbb.tieude = dsbv[j].tieude;
                        bbb.gioithieu = dsbv[j].gioithieu;
                        bbb.noidung = dsbv[j].noidung;
                        bbb.tacgia = dsbv[j].tacgia;
                        bbb.tag = dsbv[j].tag;
                        bbb.avatar = dsbv[j].avatar;
                        listbv.Add(bbb);
                    }
                }
            }
            return listbv;
        }
        catch (Exception)
        {
            return listbv;
        }
    }
}