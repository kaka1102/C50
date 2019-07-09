
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_HotTinTucSuKien : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime date = DateTime.Now;

            var tentrang = entity.Menu_Client.Where(m => m.duongdan == "/tin-tuc-su-kien" && m.trangthai == 1).ToList().Select(m => new
            {
                m.id_danhmuc,
                tendanhmuc = m.tendanhmuc.ToUpper(),
                m.duongdan
            }).ToList();

            if (tentrang != null)
            {
                RepeaterTIEUDEMENU.DataSource = tentrang;
                RepeaterTIEUDEMENU.DataBind();

                var listbv = GetAllTinTucSK();

                var results = listbv.GroupBy(
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
                              }).ToList();

                if (results != null)
                {
                    if (results.Count >= 4)
                    {
                        var danhsach = results.Take(4).ToList();
                        rptNews.DataSource = danhsach;
                        rptNews.DataBind();
                    }
                    else
                    {
                        rptNews.DataSource = results;
                        rptNews.DataBind();
                    }

                }
                else
                {
                    rptNews.Visible = false;
                    subst.InnerText = "Không có bài viết nào1";
                }

            }
            else
            {
                RepeaterTIEUDEMENU.Visible = false;
                subst.InnerText = "Không có bài viết nào2";
            }
        }
        catch (System.Exception)
        {
            Response.Redirect("");
        }
    }
    public List<Contructor.baiviet> GetAllTinTucSK()
    {
        List<Contructor.baiviet> listbv = new List<Contructor.baiviet>();
        try
        {
            client.jsonmenuClient _listParent = new client.jsonmenuClient();
            _listParent.id_danhmuc = 3;
            _listParent = new client().getdanhmucmenu(_listParent);
            var dscha = entity.tbl_Vitribv.Where(zz => zz.id_danhmuc == 3 && zz.trangthaibaiviet == 1).ToList().Select(zz => new
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
        catch (System.Exception)
        {
            return listbv;
        }
    }
}