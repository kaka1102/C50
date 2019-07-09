using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for client
/// </summary>
public class client
{
    public DataC50Entities entity = new DataC50Entities();
    public client()
    {
    }

    public bool CheckRouterUsing(int idcheck)
    {
        bool kq = true;

        var Recored = entity.Menu_Client.Where(x => x.id_danhmuc == idcheck).ToList().Select(x => new
        {
            x.idParent,
            checkSD = (x.trangthai == 0 || x.Vitri_Menu.Where(xx => xx.id_danhmuc == idcheck && xx.menubottom == false && xx.menuright == false && xx.menutop == false).Any() == true)
        }).FirstOrDefault();

        if (Recored != null && Recored.checkSD)
        {
            kq = false;
        }
        else
        {
            if (Recored != null && Recored.idParent > 0 && Recored.checkSD == false)
            {
                kq = CheckRouterUsing(Recored.idParent.Value);
            }
        }
        return kq;
    }

    public bool CheckRouterVanBan(int idcoquan, int idloaivb)
    {
        bool kq = true;
        var RecoredCoQuan = entity.Menu_Client.Where(x => x.id_danhmuc == idcoquan).ToList().Select(x => new
        {
            x.idParent,
            checkSD = (x.trangthai == 0 || x.Vitri_Menu.Where(xx => xx.id_danhmuc == idcoquan && xx.menubottom == false && xx.menuright == false && xx.menutop == false).Any() == true)
        }).FirstOrDefault();

        var RecoredLoaiVB = entity.Menu_Client.Where(x => x.id_danhmuc == idloaivb).ToList().Select(x => new
        {
            x.idParent,
            checkSD = (x.trangthai == 0 || x.Vitri_Menu.Where(xx => xx.id_danhmuc == idloaivb && xx.menubottom == false && xx.menuright == false && xx.menutop == false).Any() == true)
        }).FirstOrDefault();



        if ((RecoredCoQuan != null && RecoredCoQuan.checkSD) || (RecoredLoaiVB != null && RecoredLoaiVB.checkSD))
        {
            kq = false;
        }
        else
        {
            if ((RecoredCoQuan != null && RecoredCoQuan.idParent > 0 && RecoredCoQuan.checkSD == false) || (RecoredLoaiVB != null && RecoredLoaiVB.idParent > 0 && RecoredLoaiVB.checkSD == false))
            {
                kq = CheckRouterVanBan(RecoredCoQuan.idParent.Value, RecoredLoaiVB.idParent.Value);
            }
        }


        return kq;
    }

    static public int ToInt(object str)
    {
        int outt = 0;
        if (str != null && str != "")
        {
            string _str = str.ToString();
            int.TryParse(_str, out outt);


        }
        else
            outt = 0;

        return outt;
    }
    public class jsonmenuClient
    {
        public int id_danhmuc { get; set; }
        public string tendanhmuc { get; set; }
        public string link_danhmuc { get; set; }
        public int? trangthai { get; set; }
        public int id_baivietGT { get; set; }
        public int? sothutu { get; set; }
        public int? idParent { get; set; }
        public string shortcode { get; set; }
        public string duongdan { get; set; }
        public string icon { get; set; }
        public int? socapdanhmuc { get; set; }
        public string linkbv { get; set; }
        public string noidung { get; set; }
        public List<jsonmenuClient> danhsach { get; set; }
    }


    public class baivietgt
    {
        public int id_baivietGT { get; set; }
        public string noidung { get; set; }
        public bool trangthai { get; set; }
        public int id_danhmuc { get; set; }
        public string linkbaiGT { get; set; }
        public DateTime ngaytao { get; set; }
    }

    public jsonmenuClient getDanhMucVanBan(jsonmenuClient menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<jsonmenuClient> ltrmenu = new List<jsonmenuClient>();
        (from a in ketnoi.Menu_Client where a.idParent == menu.id_danhmuc && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenuClient m = new jsonmenuClient();
            baivietgt bvgt = new baivietgt();
            m.id_danhmuc = x.id_danhmuc;
            m.tendanhmuc = x.tendanhmuc;
            m.link_danhmuc = x.link_danhmuc;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.idParent = x.idParent;
            m.shortcode = x.shortcode;
            m.duongdan = x.duongdan;
            m.icon = x.icon;
            m.socapdanhmuc = x.socapdanhmuc;
            getDanhMucClient(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;
        return menu;

    }

    public jsonmenuClient getDanhMucClient(jsonmenuClient menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<jsonmenuClient> ltrmenu = new List<jsonmenuClient>();
        (from a in ketnoi.Menu_Client where a.idParent == menu.id_danhmuc && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenuClient m = new jsonmenuClient();
            baivietgt bvgt = new baivietgt();
            m.id_danhmuc = x.id_danhmuc;
            m.tendanhmuc = x.tendanhmuc;
            m.link_danhmuc = x.link_danhmuc;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.idParent = x.idParent;
            m.shortcode = x.shortcode;
            m.duongdan = x.duongdan;
            m.icon = x.icon;
            m.socapdanhmuc = x.socapdanhmuc;
            m.id_baivietGT = x.tbl_BaiVietTrangGioiThieu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.id_baivietGT).FirstOrDefault();
            m.linkbv = x.tbl_BaiVietTrangGioiThieu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.linkbaiGT).FirstOrDefault();
            m.noidung = x.tbl_BaiVietTrangGioiThieu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.noidung).FirstOrDefault();
            getDanhMucClient(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;
        return menu;

    }



    public jsonmenuClient getdanhmucmenu(jsonmenuClient menu)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        List<jsonmenuClient> ltrmenu = new List<jsonmenuClient>();
        (from a in ketnoi.Menu_Client where a.idParent == menu.id_danhmuc && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenuClient m = new jsonmenuClient();
            m.id_danhmuc = x.id_danhmuc;
            m.tendanhmuc = x.tendanhmuc;
            m.link_danhmuc = x.link_danhmuc;
            m.trangthai = x.trangthai;
            m.idParent = x.idParent;
            getDanhMucClient(m);
            ltrmenu.Add(m);
            return true;
        });
        menu.danhsach = ltrmenu;
        return menu;

    }


    public List<jsonmenuClient> getListMenu(int id, List<client.jsonmenuClient> _list)
    {
        DataC50Entities ketnoi = new DataC50Entities();
        (from a in ketnoi.Menu_Client where a.idParent == id && a.trangthai == 1 select a).ToList().All(x =>
        {
            jsonmenuClient m = new jsonmenuClient();
            m.id_danhmuc = x.id_danhmuc;
            m.tendanhmuc = x.tendanhmuc;
            m.link_danhmuc = x.link_danhmuc;
            m.trangthai = x.trangthai;
            m.idParent = x.idParent;
            _list.Add(m);
            getListMenu(m.id_danhmuc, _list);
            return true;
        });
        return _list;

    }
}