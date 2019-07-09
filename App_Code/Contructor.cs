using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Contructor
/// </summary>
public class Contructor
{
    public class jsonImage
    {
        public string image
        {
            get;
            set;
        }
    }
    public class listName
    {
        public int id { get; set; }
    }

    public class thoitiet
    {
        public string ClassName { get; set; }
        public string CodeId { get; set; }
        public string Date { get; set; }
        public string DayNumber { get; set; }
        public string DayText { get; set; }
        public string FullDate { get; set; }
        public int High { get; set; }
        public int Humidity { get; set; }
        public int Id { get; set; }
        public string LocationName { get; set; }

        public int Low { get; set; }
        public string Status { get; set; }
        public string Sunrise { get; set; }
        public string Sunset { get; set; }
        public int Temperature { get; set; }
        public string Time { get; set; }

        public DateTime WeatherDate { get; set; }
        public float Wind { get; set; }
        public int id_TinhThanh { get; set; }
        public string ngayluu { get; set; }
        public string TenTinh { get; set; }
    }

    public class lienkethoptac
    {
        public int id { get; set; }
        public string tendoitac { get; set; }
        public string avatar { get; set; }
        public string linkdiachi { get; set; }
        public string thongtindoitac { get; set; }
        public string target { get; set; }

        public string trangthai { get; set; }

    }

    public class thongtincanbo
    {
        public int id_dscanbo { get; set; }
        public int id_chucvu { get; set; }
        public string tencanbo { get; set; }
        public string tenchucvu { get; set; }
        public string donvicongtac { get; set; }
        public string quanham { get; set; }
        public string thongtinlienhe { get; set; }
        public string anhdaidien { get; set; }

        public string trangthaicanbo { get; set; }
        public int id_capbac { get; set; }
        public DateTime ngaysinh { get; set; }
        public string quequan { get; set; }
    }
    public class tbl_menu
    {
        public int id_menu { get; set; }
        public string tenmenu { get; set; }
        public string linkmenu { get; set; }
        public string vitri { get; set; }
        public int trangthai { get; set; }
        public int idParent { get; set; }
        public int id_taikhoan { get; set; }

        public int sothutu { get; set; }
        public string icon { get; set; }
        public string duongdan { get; set; }
        public string shortcode { get; set; }
    }

    public class thongtinbanner
    {
        public string _TenLich { get; set; }
        public string _dateStart { get; set; }
        public string _dateEnd { get; set; }
        public string _timeStar { get; set; }
        public string _timeEnd { get; set; }
        public int _Uutien { get; set; }
        public string dungluong { get; set; }
        public string duongdanfile { get; set; }
        public string tenbanner { get; set; }
        public string linkbanner { get; set; }
        public string vitri { get; set; }
        public string target { get; set; }
        public int _idthumuc { get; set; }
        public int _idBanner { get; set; }



        public string trangthaihienthi { get; set; }
        public string ngaydang { get; set; }
        public string ngaydung { get; set; }
        public string type { get; set; }
    }

    public class thongtintaikhoan
    {
        public int id_taikhoan { get; set; }
        public string tendangnhap { get; set; }
        public string tendaydu { get; set; }
        public string email { get; set; }
        public string sodienthoai { get; set; }
        public string matkhau { get; set; }
        public string matkhaucu { get; set; }
        public string avatar { get; set; }
    }


    public class baiviet
    {
        public int id_baiviet { get; set; }
        public int id_vitribv { get; set; }
        public int id_danhmuc { get; set; }
        public string tieude { get; set; }
        public string gioithieu { get; set; }
        public string noidung { get; set; }
        public string tacgia { get; set; }
        public DateTime ngaydang { get; set; }
        public string linkbaiviet { get; set; }



        public string tag { get; set; }
        public int trangthaibaiviet { get; set; }
        public string avatar { get; set; }
        public int id_taikhoan { get; set; }
        public string hinhthuchienthi { get; set; }
        public string ngaydatlich { get; set; }
        public int idRoot { get; set; }
        public string tenRoot { get; set; }

    }


    public class listvanban
    {
        public int id_vanban { get; set; }
        public string tenvanban { get; set; }
        public string linkvanban { get; set; }
    }
    public class vanban
    {
        public int id_vanban { get; set; }
        public int _IDViTriCoQuan { get; set; }
        public int _IDViTriLoaiVB { get; set; }
        public string sokyhieu { get; set; }
        public string tenvanban { get; set; }
        public string linkvanban { get; set; }
        public DateTime ngaybanhanh { get; set; }
        public string trichyeu { get; set; }
        public string noidung { get; set; }
        public int? id_taikhoan { get; set; }
        public int? trangthai { get; set; }
        public string ngaybh { get; set; }
        public DateTime ngaytao { get; set; }
        public string kieuvanban { get; set; }
        public string icon { get; set; }
        public string duongdanfile { get; set; }
        public int idCQ { get; set; }
        public int idVB { get; set; }
        public string trangthaihienthi { get; set; }
        public int id_coquanbanhanh { get; set; }
        public int id_loaivanban { get; set; }
        public string ngay { get; set; }
        public string coquan { get; set; }
        public string loaivanban { get; set; }

        public listvanban dsvb { get; set; }
    }
    public List<vanban> GetAllVanBan()
    {
        try
        {
            DataC50Entities entity = new DataC50Entities();

            string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
           // string type =removeScriptAndCharacter.formatTextInput(new Uri(returnVal).PathAndQuery);
            string type = new Uri(returnVal).PathAndQuery;
            if (type == "/van-ban/tat-ca-van-ban" || type == "/van-ban/van-ban-quy-pham-phap-luat" || type == "/van-ban/van-ban-moi" || type == "/van-ban/co-quan-ban-hanh" || type == "/van-ban/loai-van-ban")
            {
                type = "/van-ban";
            }
            var menu = entity.Menu_Client.Where(x => x.duongdan == type).Select(x => x).FirstOrDefault();

            List<client.jsonmenuClient> _listParent = new List<client.jsonmenuClient>();

            _listParent = new client().getListMenu(menu.id_danhmuc, new List<client.jsonmenuClient>());
            client.jsonmenuClient js = new client.jsonmenuClient();
            js.id_danhmuc = menu.id_danhmuc;
            js.tendanhmuc = menu.tendanhmuc;
            js.link_danhmuc = menu.link_danhmuc;
            js.idParent = menu.idParent;
            _listParent.Add(js);

            List<vanban> listbv = new List<vanban>();

            for (int i = 0; i < _listParent.Count; i++)
            {
                int id = _listParent[i].id_danhmuc;

                var dsbv = entity.tbl_VanBan.Where(zz => ((type == "/van-ban") ? zz.id_coquanbanhanh == id : (zz.id_coquanbanhanh == id || zz.id_loaivanban == id)) && zz.trangthai == 2).ToList().Select(zz => new
                {
                    zz.id_vanban,
                    zz.tenvanban,
                    zz.sokyhieu,
                    ngaybanhanh = zz.ngaybanhanh.Value,
                    ngay = zz.ngaybanhanh.Value.ToString("dd/MM/yyyy"),
                    zz.trichyeu,
                    zz.noidung,
                    zz.ngaytao,
                    zz.icon,

                    zz.duongdanfile,
                    zz.linkvanban,
                    zz.id_coquanbanhanh,
                    zz.id_loaivanban,

                    coquan = zz.Menu_Client.tendanhmuc,
                    loaivanban = zz.Menu_Client1.tendanhmuc,
                }).OrderByDescending(zz => zz.ngaybanhanh).ToList();
                if (dsbv.Count > 0)
                {
                    for (int j = 0; j < dsbv.Count; j++)
                    {
                        vanban bbb = new vanban();

                        listvanban bbb3 = new listvanban();

                        bbb.id_vanban = dsbv[j].id_vanban;
                        bbb.tenvanban = dsbv[j].tenvanban;
                        bbb.sokyhieu = dsbv[j].sokyhieu;
                        bbb.ngaybanhanh = dsbv[j].ngaybanhanh;
                        bbb.ngay = dsbv[j].ngay;
                        bbb.trichyeu = dsbv[j].trichyeu;
                        bbb.noidung = dsbv[j].noidung;
                        bbb.ngaytao = dsbv[j].ngaytao.Value;
                        bbb.icon = dsbv[j].icon;
                        bbb.duongdanfile = dsbv[j].duongdanfile;
                        bbb.linkvanban = dsbv[j].linkvanban;
                        bbb.id_loaivanban = dsbv[j].id_loaivanban.Value;
                        bbb.id_coquanbanhanh = dsbv[j].id_coquanbanhanh.Value;
                        bbb.coquan = dsbv[j].coquan;
                        bbb.loaivanban = dsbv[j].loaivanban;

                        bbb3.id_vanban = bbb.id_vanban;
                        bbb3.linkvanban = bbb.linkvanban;
                        bbb3.tenvanban = bbb.tenvanban;

                        bbb.dsvb = bbb3;

                        listbv.Add(bbb);
                    }
                }
            }
            return listbv;
        }
        catch (Exception)
        {
            return null;
        }
    }
    public class bvgioithieu
    {

        public int id_baivietGT { get; set; }
        public string noidung { get; set; }
        public bool trangthai { get; set; }
        public int id_danhmuc { get; set; }
        public int iddmGT { get; set; }
    }
    public class cauhoicautraloi
    {

        public int id_cauhoitraloi { get; set; }
        public string tieudecauhoi { get; set; }
        public string cauhoi { get; set; }
        public string traloi { get; set; }
        public DateTime ngayhoi { get; set; }
        public DateTime ngaytraloi { get; set; }

        public int trangthai { get; set; }
        public int luotxem { get; set; }
        public int id_nguoitraloi { get; set; }
        public int id_chuyenmuc { get; set; }
        public string loaicauhoi { get; set; }
        public int id_nguoihoi { get; set; }
        public string filedinhkem { get; set; }
        public string trangthaihienthi { get; set; }
        public bool statusRepQuestion { get; set; }
        public string tentacvu { get; set; }
    }

    public class duongdaynong
    {

        public int id_dstongdai { get; set; }
        public string email { get; set; }
        public string sodienthoai { get; set; }
        public string trangthai { get; set; }
        public int id_taikhoan { get; set; }

        public string diachi { get; set; }
        public string tendonvi { get; set; }
        public string mota { get; set; }
    }
    public class tinhhuongvacachxuly
    {

        public int id_huongdan { get; set; }
        public string tieude { get; set; }
        public string tinhhuong { get; set; }
        public string cachxuly { get; set; }
        public string trangthai { get; set; }
        public int id_taikhoan { get; set; }

        public DateTime ngaytao { get; set; }
    }

    public class tinbaocongdan
    {

        public int id_tinbao { get; set; }
        public string hoten { get; set; }
        public string email { get; set; }
        public string dienthoai { get; set; }
        public string diachi { get; set; }

        public string diaban { get; set; }
        public string noidungtinbao { get; set; }
        public string trangthaihienthi { get; set; }
        public DateTime ngaygui { get; set; }
        public DateTime ngayxem { get; set; }
        public int id_chuyenmuc { get; set; }
        public string tieude { get; set; }
        public string linktinbao { get; set; }
        public bool trangthaixem { get; set; }
    }

    public class DapAnThamDo
    {
        public string noidung { get; set; }
    }

    public class albumClient
    {

        public int id_thuvien { get; set; }
        public string tieude { get; set; }
        public string gioithieu { get; set; }
        public string noidung { get; set; }
        public DateTime ngayupload { get; set; }
        public int id_danhmuc { get; set; }
        public string tacgia { get; set; }
        public string loaithuvien { get; set; }
        public int id_taikhoan { get; set; }
        public string trangthaithuvien { get; set; }
    }

    public class cauhoithamdoykien
    {

        public int id_cauhoithamdo { get; set; }
        public string cauhoi { get; set; }
        public int id_hinhthuctraloi { get; set; }
        public int id_taikhoan { get; set; }
        public int? id_lich { get; set; }
        public string trangthai { get; set; }
        public int tongsocautraloi { get; set; }

        public string tungay { get; set; }
        public string denngay { get; set; }
        public string ngayketthuc { get; set; }
    }

    public class thongtintoipham
    {

        public int id_toipham { get; set; }
        public int id_hoso { get; set; }
        public string hoten { get; set; }
        public string hokhauthuongtru { get; set; }
        public string sochungminhthu { get; set; }
        public string quequan { get; set; }
        public string bietdanh { get; set; }
        public string ngaysinh { get; set; }

        public bool trangthai { get; set; }
        public int id_hinhthucphamtoi { get; set; }
        public string ngayluuhoso { get; set; }
        public string tinhtranghoso { get; set; }
        public string hinhanh { get; set; }
    }

    public class tblhinhthucphamtoi
    {

        public int id_hinhthucphamtoi { get; set; }
        public string hinhthucphamtoi { get; set; }
        public string trangthaithongke { get; set; }
        public string trangthai { get; set; }
    }

    public class bieudo
    {
        public int id_bieudo { get; set; }
        public string tenbieudo { get; set; }
        public int tuthoigian { get; set; }
        public int denthoigian { get; set; }
        public int id_loaibieudo { get; set; }
        public int id_donvitg { get; set; }

        public string tenloaibieudo { get; set; }
        public string tendonvi { get; set; }
        public string trangthai { get; set; }
    }

    public class quangcao
    {
        public int id_quangcao { get; set; }
        public string tenquangcao { get; set; }
        public string donvidat { get; set; }
        public string trangthaihienthi { get; set; }
        public string thongtin { get; set; }
        public int tilexuathien { get; set; }
        public DateTime ngaydang { get; set; }
        public DateTime ngaydung { get; set; }
        public string diemdattrongtrang { get; set; }

        public string linkquangcao { get; set; }
        public string filequangcao { get; set; }

    }


    public class danhmuccauhoi
    {
        public int id_chuyenmuc { get; set; }
        public string tenchuyenmuc { get; set; }
        public int id_danhmuc { get; set; }
        public string linkchuyenmuc { get; set; }
    }
}

public class DMNgang
{
    public int? id { get; set; }
    public string ten { get; set; }
    public string duongdan { get; set; }
    public string shortcode { get; set; }
    public string linkbaiviet { get; set; }
    public int? idParent { get; set; }
}

