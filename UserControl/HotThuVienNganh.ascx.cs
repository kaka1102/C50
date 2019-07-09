
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class UserControl_HotThuVienNganh : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DateTime date = DateTime.Now;

            var tentrang = entity.Menu_Client.Where(m => m.duongdan == "/thu-vien" && m.trangthai == 1).ToList().Select(m => new
            {
                tendanhmuc = m.tendanhmuc.ToUpper(),
                m.duongdan
            }).ToList();

            if (tentrang != null)
            {
                RepeaterTIEUDEMENU.DataSource = tentrang;
                RepeaterTIEUDEMENU.DataBind();


                var ds = entity.tbl_ThuVienClient.Where(m => m.trangthaithuvien.Value == 2).ToList().Select(m => new
                {
                    m.id_thuvien,
                    m.tieude,
                    m.gioithieu,
                    m.noidung,
                    m.ngayupload,
                    m.loaithuvien,
                    m.linlthuvien,
                    avatar = m.tbl_ChiTietThuVien.Where(x => x.trangthai == 1).Select(x => x.duongdanfile).FirstOrDefault()
                }).OrderByDescending(zz => zz.ngayupload).ToList();

                if (ds != null)
                {
                    if (ds.Count >= 6)
                    {
                        var danhsach = ds.Take(6);
                        RepeaterHOTTHUVIENNGANH.DataSource = danhsach;
                        RepeaterHOTTHUVIENNGANH.DataBind();
                    }
                    else if (ds.Count < 6 && ds.Count >= 4)
                    {
                        var danhsach = ds.Take(4);
                        RepeaterHOTTHUVIENNGANH.DataSource = danhsach;
                        RepeaterHOTTHUVIENNGANH.DataBind();
                    }
                    else
                    {
                        RepeaterHOTTHUVIENNGANH.DataSource = ds;
                        RepeaterHOTTHUVIENNGANH.DataBind();
                    }


                    // thu vien anh
                    var danhsachanh = ds.Where(xx => xx.loaithuvien == "thuvienanh").ToList().Select(xx => new
                    {
                        xx.id_thuvien,
                        xx.tieude,
                        xx.gioithieu,
                        xx.noidung,
                        xx.ngayupload,
                        xx.loaithuvien,
                        xx.linlthuvien,
                        avatar = xx.avatar
                    }).OrderByDescending(zz => zz.ngayupload).ToList();

                    if (danhsachanh != null)
                    {
                        if (danhsachanh.Count >= 6)
                        {
                            var _listIMG = danhsachanh.Take(6);
                            RepeaterHOTTHUVIENANH.DataSource = _listIMG;
                            RepeaterHOTTHUVIENANH.DataBind();
                        }
                        else if (danhsachanh.Count < 6 && danhsachanh.Count >= 4)
                        {
                            var _listIMG = danhsachanh.Take(4);
                            RepeaterHOTTHUVIENANH.DataSource = _listIMG;
                            RepeaterHOTTHUVIENANH.DataBind();
                        }
                        else
                        {
                            RepeaterHOTTHUVIENANH.DataSource = danhsachanh;
                            RepeaterHOTTHUVIENANH.DataBind();
                        }
                    }
                    else
                    {
                        RepeaterHOTTHUVIENANH.Visible = false;
                    }

                    // thu vien video


                    var danhsachvideo = ds.Where(xx => xx.loaithuvien == "thuvienvideo").ToList().Select(xx => new
                    {
                        xx.id_thuvien,
                        xx.tieude,
                        xx.gioithieu,
                        xx.noidung,
                        xx.ngayupload,
                        xx.loaithuvien,
                        xx.linlthuvien,
                        avatar = xx.avatar
                    }).OrderByDescending(zz => zz.ngayupload).ToList();

                    if (danhsachvideo != null)
                    {
                        if (danhsachvideo.Count >= 6)
                        {
                            var _listVIDEO = danhsachvideo.Take(6);
                            RepeaterHOTTHUVIENVIDEO.DataSource = _listVIDEO;
                            RepeaterHOTTHUVIENVIDEO.DataBind();
                        }
                        else if (danhsachvideo.Count < 6 && danhsachvideo.Count >= 4)
                        {
                            var _listVIDEO = danhsachvideo.Take(4);
                            RepeaterHOTTHUVIENVIDEO.DataSource = _listVIDEO;
                            RepeaterHOTTHUVIENVIDEO.DataBind();
                        }
                        else
                        {
                            RepeaterHOTTHUVIENVIDEO.DataSource = danhsachvideo;
                            RepeaterHOTTHUVIENVIDEO.DataBind();
                        }
                    }
                    else
                    {
                        RepeaterHOTTHUVIENVIDEO.Visible = false;
                    }
                }
                else
                {
                    RepeaterHOTTHUVIENNGANH.Visible = false;
                    RepeaterHOTTHUVIENANH.Visible = false;
                    RepeaterHOTTHUVIENVIDEO.Visible = false;
                }
            }
        }
        catch (System.Exception)
        {
            Response.Redirect("");
        }
    }
}