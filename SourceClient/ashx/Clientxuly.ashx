<%@ WebHandler Language="C#" Class="Clientxuly" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Drawing;
using Newtonsoft.Json;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web.SessionState;
using System.Reflection;
using System.Data.Entity.Core.Objects;

public class Clientxuly : IHttpHandler, IRequiresSessionState
{
    DataC50Entities entity = new DataC50Entities();
    public void ProcessRequest(HttpContext context)
    {
        if (context.Request["type"] != null)
        {
            string type = context.Request["type"];
            switch (type)
            {
                case "loadmenugioithieu":
                    loadmenugioithieu(context);
                    break;
                case "loadsodolanhdao":
                    loadsodolanhdao(context);
                    break;
                case "loadmenutrangvanban":
                    loadmenutrangvanban(context);
                    break;
                case "loaddanhsachvanban":
                    loaddanhsachvanban(context);
                    break;
                case "timkiemvanban":
                    timkiemvanban(context);
                    break;
                case "loadvanbantheodanhmucluachon":
                    loadvanbantheodanhmucluachon(context);
                    break;
                case "guithongtintogiac":
                    guithongtintogiac(context);
                    break;
                case "loaddanhsachcauhoithamdo":
                    loaddanhsachcauhoithamdo(context);
                    break;
                case "chechCaptchaformthamdo":
                    chechCaptchaformthamdo(context);
                    break;
                case "XemThongKeDapAnCauHoi":
                    XemThongKeDapAnCauHoi(context);
                    break;
                case "loadallbieudotrongtrang":
                    loadallbieudotrongtrang(context);
                    break;
                case "loadbieudotheohinhthucphamtoi":
                    loadbieudotheohinhthucphamtoi(context);
                    break;
                case "loadsodoweb":
                    loadsodoweb(context);
                    break;
                case "loadADS":
                    loadADS(context);
                    break;
                case "LoadDanhSachThamDoYKien":
                    LoadDanhSachThamDoYKien(context);
                    break;
                case "loaddanhsachcoquanbanhanh":
                    loaddanhsachcoquanbanhanh(context);
                    break;
                case "loaddanhsachlinhvuc":
                    loaddanhsachlinhvuc(context);
                    break;
                case "guicauhoi":
                    guicauhoi(context);
                    break;
            }
        }
    }

    public void guicauhoi(HttpContext context)
    {
        try
        {

            string msg = "";
            bool sucess = false;
            bool checkFileUpload = true;
            int gioihandata = 1048576 * 10;
            string tenfile;
            string duongdan;
            string fileanhluu = "";

            question_client thongtin = (question_client)JsonConvert.DeserializeObject(context.Request["objSend"], typeof(question_client));

            string session = context.Session["captcha"].ToString();
            int idtaikhoan = 0;

            TaiKhoan taikhoan = new TaiKhoan();

            string ErrCheck = new validateform().CallValidateGuiCauHoiMoiClient(thongtin.tendaydu, thongtin.email1, thongtin.tieudecauhoi, thongtin.chon, thongtin.cauhoi, thongtin.textcaptcha, session);
            if (ErrCheck == null)
            {
                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["filedinhkem"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);
                    string typeFile = Path.GetExtension(file.FileName);
                    int type = (mimeType.IndexOf("image/"));
                    int filesize = file.ContentLength;

                    if (filesize > gioihandata)
                    {
                        checkFileUpload = false;
                        msg = "Dung lượng file upload quá quy định";
                    }
                    else
                    {
                        if ((typeFile == ".doc" || typeFile == ".docx" || typeFile == ".xls" || typeFile == ".xlsx" || typeFile == ".pdf" || type == 0))
                        {
                            tenfile = MD5.RandomString(16);
                            fileanhluu = "/ThuMucGoc/NguoiDung/" + tenfile + typeFile;
                            duongdan = context.Server.MapPath("~" + fileanhluu);
                            file.SaveAs(duongdan);

                            // check file được upload
                            FileInfo ff = new FileInfo(duongdan);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.CheckUpLoadHoiDap(ff);
                            if (ck_Type == false)
                            {
                                var pathDell = duongdan;
                                // xoa file trong thu muc
                                if (System.IO.File.Exists(pathDell))
                                {
                                    System.IO.File.Delete(pathDell);
                                }

                                checkFileUpload = false;
                                msg = "File đính kèm không hợp lệ (doc,docx,xls,pdf,jpeg,gif,png,bmp,ico)";
                            }
                        }
                        else
                        {
                            checkFileUpload = false;
                            msg = "File đính kèm không hợp lệ (doc,docx,xls,pdf,jpeg,gif,png,bmp,ico)";
                        }
                    }
                }
                if (checkFileUpload == true)
                {
                    var checktench = entity.tbl_CauhoiTraLoi.Where(m => m.cauhoi == thongtin.cauhoi && m.trangthai != 0).FirstOrDefault();
                    if (checktench != null)
                    {
                        thongtin.cauhoi = thongtin.cauhoi + "-" + MD5.RandomString(10);
                    }

                    var kiemtra = entity.TaiKhoan.Where(m => m.email == thongtin.email1).FirstOrDefault();

                    if (kiemtra == null)
                    {
                        taikhoan.tendaydu = removeScriptAndCharacter.formatTextInput(thongtin.tendaydu);
                        taikhoan.email = removeScriptAndCharacter.formatTextInput(thongtin.email1);
                        taikhoan.trangthaitk = true;
                        taikhoan.ngaytao = DateTime.Now;
                        taikhoan.loaitaikhoan = 1;
                        taikhoan.avatar = "/ThuMucGoc/AnhDaiDien/iconClientDefault.jpg";

                        entity.TaiKhoan.Add(taikhoan);
                        entity.SaveChanges();

                        idtaikhoan = taikhoan.id_taikhoan;
                    }
                    else
                    {
                        idtaikhoan = kiemtra.id_taikhoan;
                    };

                    tbl_CauhoiTraLoi cauhoitraloi = new tbl_CauhoiTraLoi();
                    cauhoitraloi.tieudecauhoi = removeScriptAndCharacter.formatTextInput(thongtin.tieudecauhoi);
                    cauhoitraloi.cauhoi = removeScriptAndCharacter.formatTextInput(thongtin.cauhoi);
                    cauhoitraloi.ngayhoi = DateTime.Now;
                    cauhoitraloi.trangthai = 1;
                    cauhoitraloi.id_chuyenmuc = thongtin.chon;
                    cauhoitraloi.loaicauhoi = "nguoidung";
                    cauhoitraloi.id_nguoihoi = idtaikhoan;
                    cauhoitraloi.luotxem = 0;
                    if (context.Request.Files.Count > 0)
                    {
                        cauhoitraloi.fileQuestion = fileanhluu;
                    }
                    cauhoitraloi.statusRepQuestion = false;

                    entity.tbl_CauhoiTraLoi.Add(cauhoitraloi);
                    entity.SaveChanges();

                    var ttnguoigui = entity.TaiKhoan.Where(mm => mm.id_taikhoan == idtaikhoan).FirstOrDefault();

                    if (ttnguoigui != null)
                    {
                        string mailto = ttnguoigui.email;
                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", ttnguoigui.tendaydu);
                        string body = string.Format("Xin chào {0} !<br /> Bạn đã gửi câu hỏi tới ban quản trị C50 thành công.<br />Chúng tôi sẽ xem xét nội dung và trả lời bạn theo email này trong thời gian sớm nhất.</br>  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", ttnguoigui.tendaydu);
                        bool guimail = new Libs().sendEmail(mailto, subject, body);

                        sucess = true;
                        msg = "Chúng tôi sẽ gửi câu trả lời qua email cho bạn sớm nhất";
                    }
                    else
                    {
                        sucess = true;
                        msg = "Gửi email không thành công";
                    }

                }
            }
            else
            {
                msg = ErrCheck;
                sucess = false;
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = false }, Formatting.Indented));
        }
    }

    public class question_client
    {


        public string cauhoi { get; set; }
        public string email1 { get; set; }
        public string tendaydu { get; set; }
        public string pathFile { get; set; }
        public string tieudecauhoi { get; set; }
        public int chon { get; set; }
        public string textcaptcha { get; set; }
    }

    public void loaddanhsachlinhvuc(HttpContext context)
    {
        try
        {
            var danhsach = entity.Menu_Client.Where(m => m.idParent == 86 && m.trangthai == 1).ToList().Select(m => new
            {
                m.tendanhmuc,
                m.id_danhmuc
            });
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { data = "" }, Formatting.Indented));
        }
    }
    public void loaddanhsachcoquanbanhanh(HttpContext context)
    {
        try
        {
            var danhsach = entity.Menu_Client.Where(m => m.idParent == 85 && m.trangthai == 1).ToList().Select(m => new
            {
                m.tendanhmuc,
                m.id_danhmuc
            });
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { data = "" }, Formatting.Indented));
        }
    }

    public void LoadDanhSachThamDoYKien(HttpContext context)
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
            danhsachcautraloi = entity.tbl_DapAnThamDo.Where(x => x.trangthai == true && x.id_cauhoithamdo == m.id_cauhoithamdo & x.tbl_ThamDoYKien.id_hinhthuctraloi.Value != 3).ToList().Select(x => new
                  {
                      id_hinhthuctraloi = x.tbl_ThamDoYKien.id_hinhthuctraloi.Value,
                      x.noidungtraloi,
                      x.demcautraloi,
                      x.id_dapanthamdo
                  }).ToList()
        }).ToList();


        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));

    }

    public void loadADS(HttpContext context)
    {
        var left = context.Request["left"].Split(',');
        var right = context.Request["right"].Split(',');
        var center = context.Request["center"].Split(',');
        var bottom = context.Request["bottom"].Split(',');
        var rtleft = new List<object>();
        var rtright = new List<object>();
        var rtcenter = new List<object>();
        var rtbottom = new List<object>();

        foreach (string name in left)
        {
            var a = entity.tbl_quangcao
                .Where(m => m.tbl_VitriQuangCao.name == name && m.trangthaihienthi == 2 && m.ngaydang < DateTime.Now && m.ngaydung > DateTime.Now)
                .ToList()
                .OrderByDescending(m => m.tilexuathien.Value)
                .Select(m => new { m.id_quangcao, m.tbl_VitriQuangCao.name, m.manguon, m.linkquangcao })
                .FirstOrDefault();

            if (a != null)
                rtleft.Add(a);
        }
        foreach (string name in right)
        {
            var a = entity.tbl_quangcao
                .Where(m => m.tbl_VitriQuangCao.name == name && m.trangthaihienthi == 2 && m.ngaydang < DateTime.Now && m.ngaydung > DateTime.Now)
                .ToList()
                .OrderByDescending(m => m.tilexuathien.Value)
                .Select(m => new { m.id_quangcao, m.tbl_VitriQuangCao.name, m.manguon, m.linkquangcao })
                .FirstOrDefault();

            if (a != null)
                rtright.Add(a);
        }
        foreach (string name in center)
        {
            var a = entity.tbl_quangcao
                .Where(m => m.tbl_VitriQuangCao.name == name && m.trangthaihienthi == 2 && m.ngaydang < DateTime.Now && m.ngaydung > DateTime.Now)
                .ToList()
                .OrderByDescending(m => m.tilexuathien.Value)
                .Select(m => new { m.id_quangcao, m.tbl_VitriQuangCao.name, m.manguon, m.linkquangcao })
                .FirstOrDefault();

            if (a != null)
                rtcenter.Add(a);
        }
        foreach (string name in bottom)
        {
            var a = entity.tbl_quangcao
                .Where(m => m.tbl_VitriQuangCao.name == name && m.trangthaihienthi == 2 && m.ngaydang < DateTime.Now && m.ngaydung > DateTime.Now)
                .ToList()
                .OrderByDescending(m => m.tilexuathien.Value)
                .Select(m => new { m.id_quangcao, m.tbl_VitriQuangCao.name, m.manguon, m.linkquangcao })
                .FirstOrDefault();

            if (a != null)
                rtbottom.Add(a);
        }

        var rt = new
        {
            left = rtleft,
            right = rtright,
            center = rtcenter,
            bottom = rtbottom
        };

        context.Response.ContentType = "application/json";
        context.Response.Write(JsonConvert.SerializeObject(rt, Formatting.Indented));
    }

    public void loadsodoweb(HttpContext context)
    {
        List<Libs.jsonmenu> oDanhMuc = new List<Libs.jsonmenu>();
        // string href = context.Request.UrlReferrer.AbsolutePath;
        //  string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));
        int id_tm = client.ToInt(context.Request["id_tm"]);
        List<Libs.jsTree> data = new List<Libs.jsTree>();
        entity.Menu_Client.Where(m => m.idParent == id_tm && m.trangthai == 1).ToList().OrderByDescending(x => x.sothutu.Value).All(x =>
        {
            Libs.linkJsTree li = new Libs.linkJsTree();
            Libs.jsonthumuc json = new Libs.jsonthumuc();
            Libs.jsTree item = new Libs.jsTree();

            li.id = x.id_danhmuc;
            li.href = x.duongdan;


            item.text = x.tendanhmuc;
            item.href = x.duongdan;
            item.id = x.id_danhmuc;
            item.a_attr = li;
            item.icon = x.icon;
            item.children = entity.Menu_Client.Where(xx => xx.idParent == x.id_danhmuc).Any();
            item.menutop = entity.Vitri_Menu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.menutop.Value).FirstOrDefault();
            item.menuleft = entity.Vitri_Menu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.menuright.Value).FirstOrDefault();
            item.menubottom = entity.Vitri_Menu.Where(xx => xx.id_danhmuc == x.id_danhmuc).Select(xx => xx.menubottom.Value).FirstOrDefault();
            data.Add(item);
            return true;
        });
        context.Response.ContentType = "application/json";
        context.Response.Write(JsonConvert.SerializeObject(data, Formatting.Indented));
    }

    public void loadbieudotheohinhthucphamtoi(HttpContext context)
    {
        List<BieuDo> _list = new List<BieuDo>();
        List<BieuDo> _list2 = new List<BieuDo>();
        var danhsachbieudo = entity.tbl_BieuDo.Where(m => m.trangthai == 2).ToList().All(m =>
        {
            BieuDo ibd = new BieuDo();

            ibd.Denthoigian = m.denthoigian == null ? m.tuthoigian.Value : m.denthoigian.Value;
            ibd.Id_loaibieudo = m.id_loaibieudo.Value;
            ibd.Tenbieudo = m.tenbieudo;
            ibd.Tuthoigian = m.tuthoigian.Value;
            ibd.Tendonvi = m.tbl_donvithoigianbieudo.tendonvi;
            ibd.TenLoaiBieuDo = m.tbl_Loaibieudo.tenloaibieudo;
            ibd.IdDonviTG = m.tbl_donvithoigianbieudo.id_donvitg;
            ibd.Typebieudo = (m.id_loaibieudo == 1) ? "bar" : ((m.id_loaibieudo == 2) ? "pie" : "line");

            if (m.id_donvitg == 3)
            {
                int quy1 = DateTime.DaysInMonth(m.tuthoigian.Value, 3);
                int quy2 = DateTime.DaysInMonth(m.tuthoigian.Value, 6);
                int quy3 = DateTime.DaysInMonth(m.tuthoigian.Value, 9);
                int quy4 = DateTime.DaysInMonth(m.tuthoigian.Value, 12);

                DateTime startquy1 = new DateTime(m.tuthoigian.Value, 1, 1);
                DateTime endquy1 = new DateTime(m.tuthoigian.Value, 3, quy1);
                DateTime endquy2 = new DateTime(m.tuthoigian.Value, 6, quy2);
                DateTime endquy3 = new DateTime(m.tuthoigian.Value, 9, quy3);
                DateTime endquy4 = new DateTime(m.tuthoigian.Value, 12, quy4);

                //list

                List<thongketheoquy> lsquy1 = new List<thongketheoquy>();

                List<string> dataY = new List<string>() { "Qúy I", "Qúy II", "Qúy III", "Qúy IV" };

                // QUÝ 1
                var hinhthucphamtoiQ1 = entity.tbl_Hinhthucphamtoi.Where(mm => mm.trangthai == true && mm.trangthaithongke == true).ToList().Select(mm => new
                {

                    mm.hinhthucphamtoi,
                    mm.id_hinhthucphamtoi,
                }).ToList();


                foreach (var foo in hinhthucphamtoiQ1)
                {
                    thongketheoquy ValQuy1 = new thongketheoquy();
                    var datax = new List<int>();
                    var datay = new List<string>();
                    var random = new Random();
                    var listColor = new List<string>();
                    var color = String.Format("#{0:x6}", random.Next(0x1000000));
                    listColor.Add(color);

                    var DataQuyI = entity.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value >= startquy1 && nn.ngayluuhoso < endquy1) && nn.id_hinhthucphamtoi == foo.id_hinhthucphamtoi).ToList().Count;
                    var DataQuyII = entity.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value >= endquy1 && nn.ngayluuhoso < endquy2) && nn.id_hinhthucphamtoi == foo.id_hinhthucphamtoi).ToList().Count;
                    var DataQuyIII = entity.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value >= endquy2 && nn.ngayluuhoso < endquy3) && nn.id_hinhthucphamtoi == foo.id_hinhthucphamtoi).ToList().Count;
                    var DataQuyIV = entity.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value >= endquy3 && nn.ngayluuhoso < endquy4) && nn.id_hinhthucphamtoi == foo.id_hinhthucphamtoi).ToList().Count;

                    datax.Add(DataQuyI);
                    datax.Add(DataQuyII);
                    datax.Add(DataQuyIII);
                    datax.Add(DataQuyIV);
                    ValQuy1.DataX = datax;

                    ValQuy1.Hinhthucphamtoi = foo.hinhthucphamtoi;
                    ValQuy1.ListColor = listColor;

                    lsquy1.Add(ValQuy1);
                }

                ibd.ListTheoQuy = lsquy1;
                ibd.DataY = dataY;
            }


            else if (m.id_donvitg == 2)
            {
                var datax = new List<int>();
                var datay = new List<string>();
                var listColor = new List<string>();
                var random = new Random();

                var hinhthucphamtoi = entity.tbl_Hinhthucphamtoi.Where(mm => mm.trangthai == true && mm.trangthaithongke == true).ToList().Select(mm => new
                {

                    mm.hinhthucphamtoi,
                    mm.id_hinhthucphamtoi,
                    sovuan = mm.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value.Year >= ibd.Tuthoigian)).ToList().Count
                }).ToList();

                foreach (var foo in hinhthucphamtoi)
                {
                    var color = String.Format("#{0:x6}", random.Next(0x1000000));
                    listColor.Add(color);
                    datay.Add(foo.hinhthucphamtoi);
                    datax.Add(foo.sovuan);
                }
                ibd.DataX = datax;
                ibd.DataY = datay;
                ibd.ListColor = listColor;
            }
            else
            {

                var datax = new List<int>();
                var datay = new List<string>();
                var listColor = new List<string>();
                var random = new Random();

                var hinhthucphamtoi = entity.tbl_Hinhthucphamtoi.Where(mm => mm.trangthai == true && mm.trangthaithongke == true).ToList().Select(mm => new
                {

                    mm.hinhthucphamtoi,
                    mm.id_hinhthucphamtoi,
                    sovuan = mm.tbl_Hosovuan.Where(nn => nn.tinhtranghoso != 0 && (nn.ngayluuhoso.Value.Year >= ibd.Tuthoigian && nn.ngayluuhoso.Value.Year < ibd.Denthoigian)).ToList().Count
                }).ToList();

                foreach (var foo in hinhthucphamtoi)
                {
                    var color = String.Format("#{0:x6}", random.Next(0x1000000));
                    listColor.Add(color);
                    datay.Add(foo.hinhthucphamtoi);
                    datax.Add(foo.sovuan);
                }
                ibd.DataX = datax;
                ibd.DataY = datay;
                ibd.ListColor = listColor;
            }
            _list.Add(ibd);
            return true;
        });

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = _list }, Formatting.Indented));
    }


    // da xong
    public void loadallbieudotrongtrang(HttpContext context)
    {
        List<BieuDo> _list = new List<BieuDo>();

        var danhsachbieudo = entity.tbl_BieuDo.Where(m => m.trangthai == 2).ToList().All(m =>
        {
            BieuDo ibd = new BieuDo();

            ibd.Denthoigian = m.denthoigian == null ? m.tuthoigian.Value : m.denthoigian.Value;
            ibd.Id_loaibieudo = m.id_loaibieudo.Value;
            ibd.Tenbieudo = m.tenbieudo;
            ibd.Tuthoigian = m.tuthoigian.Value;
            ibd.Tendonvi = m.tbl_donvithoigianbieudo.tendonvi;
            ibd.TenLoaiBieuDo = m.tbl_Loaibieudo.tenloaibieudo;
            ibd.Typebieudo = (m.id_loaibieudo == 1) ? "bar" : ((m.id_loaibieudo == 2) ? "pie" : "line");
            if (m.id_donvitg == 3)
            {
                var danhsach = entity.tbl_Hosovuan.Where(x => x.ngayluuhoso.Value.Year == ibd.Tuthoigian && x.tinhtranghoso != 0).ToList().Select(x => new
                {
                    x.id_hoso,
                    x.id_toipham,
                    x.id_hinhthucphamtoi,
                    ngayluuhoso = x.ngayluuhoso.Value
                }).ToList();

                int quy1 = DateTime.DaysInMonth(m.tuthoigian.Value, 3);
                int quy2 = DateTime.DaysInMonth(m.tuthoigian.Value, 6);
                int quy3 = DateTime.DaysInMonth(m.tuthoigian.Value, 9);
                int quy4 = DateTime.DaysInMonth(m.tuthoigian.Value, 12);

                DateTime startquy1 = new DateTime(m.tuthoigian.Value, 1, 1);
                DateTime endquy1 = new DateTime(m.tuthoigian.Value, 3, quy1);
                DateTime endquy2 = new DateTime(m.tuthoigian.Value, 6, quy2);
                DateTime endquy3 = new DateTime(m.tuthoigian.Value, 9, quy3);
                DateTime endquy4 = new DateTime(m.tuthoigian.Value, 12, quy4);

                var sovuquy1 = danhsach.Where(zz => zz.ngayluuhoso >= startquy1 && zz.ngayluuhoso < endquy1).ToList().Count;
                var sovuquy2 = danhsach.Where(zz => zz.ngayluuhoso >= endquy1 && zz.ngayluuhoso < endquy2).ToList().Count;
                var sovuquy3 = danhsach.Where(zz => zz.ngayluuhoso >= endquy2 && zz.ngayluuhoso < endquy3).ToList().Count;
                var sovuquy4 = danhsach.Where(zz => zz.ngayluuhoso >= endquy3 && zz.ngayluuhoso < endquy4).ToList().Count;

                List<int> dataX = new List<int>() { sovuquy1, sovuquy2, sovuquy3, sovuquy4 };
                List<string> dataY = new List<string>() { "Qúy I", "Qúy II", "Qúy III", "Qúy IV" };
                List<string> listColor = new List<string>() { "#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9" };

                ibd.DataX = dataX;
                ibd.DataY = dataY;
                ibd.ListColor = listColor;
            }
            else if (m.id_donvitg == 2)
            {
                var datax = new List<int>();
                var datay = new List<string>();
                var listColor = new List<string>();
                var random = new Random();
                for (int i = 1; i <= 12; i++)
                {

                    var color = String.Format("#{0:x6}", random.Next(0x1000000));
                    var thang = "Tháng " + i;
                    datay.Add(thang);
                    listColor.Add(color);


                    DateTime firstdayofmonth = new DateTime(ibd.Tuthoigian, i, 1);
                    DateTime lastdayofmonth = new DateTime(ibd.Tuthoigian, i, DateTime.DaysInMonth(ibd.Tuthoigian, i));

                    var sovu = entity.tbl_Hosovuan.Where(zz => zz.ngayluuhoso >= firstdayofmonth && zz.ngayluuhoso < lastdayofmonth && zz.tinhtranghoso != 0).ToList().Count;
                    datax.Add(sovu);
                }
                ibd.DataX = datax;
                ibd.DataY = datay;
                ibd.ListColor = listColor;
            }
            else
            {
                var listColor = new List<string>();
                var datax = new List<int>();
                var datay = new List<string>();
                var random = new Random();
                for (int i = ibd.Tuthoigian; i <= ibd.Denthoigian; i++)
                {

                    var color = String.Format("#{0:x6}", random.Next(0x1000000));

                    listColor.Add(color);
                    var nam = "Năm " + i;
                    datay.Add(nam);
                    var sovu = entity.tbl_Hosovuan.Where(x => x.ngayluuhoso.Value.Year == i && x.tinhtranghoso != 0).ToList().Count;
                    datax.Add(sovu);
                }
                ibd.DataX = datax;
                ibd.DataY = datay;
                ibd.ListColor = listColor;
            }
            _list.Add(ibd);
            return true;
        });

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = _list }, Formatting.Indented));
    }


    public void XemThongKeDapAnCauHoi(HttpContext context)
    {
        int idCauHoi = client.ToInt(context.Request["id"]);
        var thongtincauhoi = entity.tbl_ThamDoYKien.Where(m => m.id_cauhoithamdo == idCauHoi && (m.trangthai != 0 || m.trangthai != 1)).ToList().Select(m => new
        {
            m.id_cauhoithamdo,
            m.id_hinhthuctraloi,
            m.cauhoi,
            ngaydang = m.tbl_LichHienThiThamDoYKien.tungay.Value.ToString("dd/MM/yyyy HH:mm:ss ,fff"),
            m.tongsocautraloi,
            danhsachdapan = m.tbl_DapAnThamDo.Where(zz => zz.trangthai == true && zz.tbl_ThamDoYKien.id_hinhthuctraloi != 3).ToList().Select(zz => new
            {
                zz.noidungtraloi,
                zz.demcautraloi
            }).ToList()
        }).FirstOrDefault();


        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { thongtincauhoi = thongtincauhoi }, Formatting.Indented));

    }
    public void chechCaptchaformthamdo(HttpContext context)
    {
        try
        {
            string captcha = context.Request["captcha"].ToString();
            string session = context.Session["captcha"].ToString();
            int idCauHoi = client.ToInt(context.Request["id"]);
            bool check = false;
            string msg = "";
            string ip = removeScriptAndCharacter.GetLocalIPAddress();

            tbl_logtraloithamdo logtraloi = new tbl_logtraloithamdo();
            tbl_DapAnThamDo dapan = new tbl_DapAnThamDo();
            int tongtl = 0, sl = 0;
            var checkcauhoi = entity.tbl_ThamDoYKien.Where(m => m.id_cauhoithamdo == idCauHoi && (m.trangthai != 0 || m.trangthai != 1)).FirstOrDefault();

            if (checkcauhoi != null)
            {
                var checkIPRepQues = entity.tbl_logtraloithamdo.Where(aa => aa.id_cauhoithamdo == idCauHoi && aa.ip == ip).FirstOrDefault();

                if (checkcauhoi.id_hinhthuctraloi.Value == 3)
                {
                    List<object> thongtin = (List<object>)JsonConvert.DeserializeObject(context.Request["listDA"], typeof(List<object>));

                    string ErrorCheck = new validateform().CallValidateThamDoYKien(thongtin[0].ToString());
                    if (captcha == session)
                    {
                        if (ErrorCheck == null)
                        {

                            if (checkIPRepQues == null)
                            {
                                dapan.id_cauhoithamdo = checkcauhoi.id_cauhoithamdo;
                                dapan.noidungtraloi = removeScriptAndCharacter.formatTextInput(thongtin[0].ToString());
                                dapan.demcautraloi = 1;
                                dapan.trangthai = true;

                                entity.tbl_DapAnThamDo.Add(dapan);


                                tongtl = checkcauhoi.tongsocautraloi.Value;
                                checkcauhoi.tongsocautraloi = tongtl + 1;

                                entity.SaveChanges();

                                string vitri = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogNguoiDung(JsonConvert.SerializeObject(new { thongtindangky = new { dapan.id_dapanthamdo, dapan.id_cauhoithamdo, dapan.noidungtraloi, dapan.demcautraloi, dapan.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().lognguoidungthanhcong(idlog);
                                check = true;
                                msg = "Gửi trả lời thành công";

                                logtraloi.id_cauhoithamdo = idCauHoi;
                                logtraloi.ngaytraloi = DateTime.Now;
                                logtraloi.ip = ip;
                                entity.tbl_logtraloithamdo.Add(logtraloi);
                                entity.SaveChanges();

                            }
                            else
                            {
                                msg = "Bạn đã trả lời câu hỏi này rồi";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Mã xác nhận không đúng";
                    }
                }
                else
                {
                    if (captcha == session)
                    {
                        if (checkIPRepQues == null)
                        {
                            List<int> listXoa = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listDA"], typeof(List<int>));
                            bool status = false;
                            for (int i = 0; i < listXoa.Count; i++)
                            {
                                int idDapAn = listXoa[i];
                                var checkdapan = entity.tbl_DapAnThamDo.Where(zz => zz.id_dapanthamdo == idDapAn && zz.trangthai == true).FirstOrDefault();
                                if (checkdapan != null)
                                {
                                    //bang dap an
                                    sl = checkdapan.demcautraloi.Value;
                                    checkdapan.demcautraloi = sl + 1;

                                    entity.SaveChanges();
                                    status = true;

                                    string vitri = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogNguoiDung(JsonConvert.SerializeObject(new { thongtindangky = new { checkdapan.id_dapanthamdo, checkdapan.id_cauhoithamdo, checkdapan.noidungtraloi, checkdapan.trangthai, checkdapan.demcautraloi } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().lognguoidungthanhcong(idlog);
                                }

                                else
                                {
                                    msg = "Đáp án không tồn tại";
                                }

                            }
                            if (status == true)
                            {
                                tongtl = checkcauhoi.tongsocautraloi.Value;
                                checkcauhoi.tongsocautraloi = tongtl + 1;
                                entity.SaveChanges();

                                logtraloi.id_cauhoithamdo = idCauHoi;
                                logtraloi.ngaytraloi = DateTime.Now;
                                logtraloi.ip = ip;
                                entity.tbl_logtraloithamdo.Add(logtraloi);
                                entity.SaveChanges();
                            }
                            check = true;
                            msg = "Gửi trả lời thành công";
                        }
                        else
                        {
                            msg = "Bạn đã trả lời câu hỏi này rồi";
                        }
                    }
                    else
                    {
                        msg = "Mã xác nhận không đúng";
                    }
                }
            }
            else
            {
                msg = "Câu hỏi không tồn tại";
            }


            if (check == false)
            {
                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                int idlog1 = new Libs().LuuLogNguoiDung(JsonConvert.SerializeObject(new { thongtindangky = new { msg = msg } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                new Libs().lognguoidungthatbai(idlog1);
            }

            var thongtincauhoi = entity.tbl_ThamDoYKien.Where(m => m.id_cauhoithamdo == idCauHoi && (m.trangthai != 0 || m.trangthai != 1)).ToList().Select(m => new
            {
                m.id_cauhoithamdo,
                m.id_hinhthuctraloi,
                m.cauhoi,
                ngaydang = m.tbl_LichHienThiThamDoYKien.tungay.Value.ToString("dd/MM/yyyy HH:mm:ss ,fff"),
                m.tongsocautraloi,
                danhsachdapan = m.tbl_DapAnThamDo.Where(zz => zz.trangthai == true && zz.tbl_ThamDoYKien.id_hinhthuctraloi != 3).ToList().Select(zz => new
                {
                    zz.noidungtraloi,
                    zz.demcautraloi
                }).ToList()
            }).FirstOrDefault();


            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { check = check, msg = msg, thongtincauhoi = thongtincauhoi }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { check = false, msg = "Mời bạn thao tác lại", thongtincauhoi = 0 }, Formatting.Indented));
        }
    }
    public void loaddanhsachcauhoithamdo(HttpContext context)
    {

        DateTime date = DateTime.Now;
        var danhsach = entity.tbl_ThamDoYKien.Where(m => (m.trangthai != 0 || m.trangthai != 1) && (m.tbl_LichHienThiThamDoYKien.tungay.Value <= date && m.tbl_LichHienThiThamDoYKien.denngay.Value >= date)).ToList().Select(m => new
        {
            m.cauhoi,
            m.tongsocautraloi,
            hinhthuctraloi = m.tbl_HinhthucTraLoi.hinhthuctraloi,
            m.id_hinhthuctraloi,
            m.id_lich,
            tungay = m.tbl_LichHienThiThamDoYKien.tungay,
            denngay = m.tbl_LichHienThiThamDoYKien.denngay,
            danhsachcautraloi = m.tbl_DapAnThamDo.Where(x => x.trangthai == true).ToList().Select(x => new
            {
                x.noidungtraloi,
                x.demcautraloi
            }).ToList()
        });

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = danhsach }, Formatting.Indented));

    }




    public void guithongtintogiac(HttpContext context)
    {
        string msg = "Mời bạn thao tác lại";
        bool sucess = false;
        try
        {
            Contructor.tinbaocongdan thongtin = (Contructor.tinbaocongdan)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tinbaocongdan));
            tbl_TinBaoCongDan tinbao = new tbl_TinBaoCongDan();
            var checkchuyenmuc = entity.tbl_ChuyenMucLuaChon.Where(m => m.id_chuyenmuc == thongtin.id_chuyenmuc && m.trangthai == true).FirstOrDefault();
            if (checkchuyenmuc != null)
            {
                string val = new validateform().CallValidatethongtintogiac(thongtin.hoten, thongtin.email, thongtin.dienthoai, thongtin.diachi, thongtin.tieude, thongtin.diaban, thongtin.noidungtinbao);

                if (val == null)
                {
                    tinbao.hoten = (thongtin.hoten != "") ? removeScriptAndCharacter.formatTextInput(thongtin.hoten) : null;
                    tinbao.email = (thongtin.email != "") ? removeScriptAndCharacter.formatTextInput(thongtin.email) : null;
                    tinbao.dienthoai = (thongtin.dienthoai != "") ? removeScriptAndCharacter.formatTextInput(thongtin.dienthoai) : null;
                    tinbao.diachi = (thongtin.diachi != "") ? removeScriptAndCharacter.formatTextInput(thongtin.diachi) : null;
                    tinbao.diaban = removeScriptAndCharacter.formatTextInput(thongtin.diaban);
                    tinbao.noidungtinbao = removeScriptAndCharacter.formatTextInput(thongtin.noidungtinbao);
                    tinbao.trangthaihienthi = 1;
                    tinbao.ngaygui = DateTime.Now;
                    tinbao.id_chuyenmuc = checkchuyenmuc.id_chuyenmuc;
                    tinbao.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);

                    string tentin = new Libs().ConvertUrlsToLinks(tinbao.tieude);
                    List<DMNgang> _list = new List<DMNgang>();
                    _list = new Libs().getList(checkchuyenmuc.id_danhmuc.Value, new List<DMNgang>());
                    string href = "";
                    for (int j = _list.Count - 1; j >= 0; j--)
                    {
                        href = href + "/" + _list[j].shortcode;
                    }
                    tinbao.linktinbao = href + "/" + checkchuyenmuc.linkchuyenmuc + "/" + tentin;
                    tinbao.trangthaixem = false;

                    entity.tbl_TinBaoCongDan.Add(tinbao);
                    entity.SaveChanges();

                    sucess = true;
                    msg = "Gửi thông tin thành công";
                    string vitri = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
                    int idlog = new Libs().LuuLogNguoiDung(JsonConvert.SerializeObject(new { thongtindangky = new { tinbao.hoten, tinbao.email, tinbao.dienthoai, tinbao.diachi, tinbao.diaban, tinbao.noidungtinbao, tinbao.trangthaihienthi, tinbao.ngaygui, tinbao.ngayxem, tinbao.id_chuyenmuc, tinbao.tieude, tinbao.linktinbao, tinbao.trangthaixem } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                    new Libs().lognguoidungthanhcong(idlog);

                    if (tinbao.email != null)
                    {
                        string ten = "";
                        if (tinbao.hoten != null)
                        {
                            ten = tinbao.hoten;
                        }
                        else
                        {
                            ten = tinbao.email;
                        }
                        string mailto = tinbao.email;
                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", ten);
                        string body = string.Format("Xin chào {0} !<br />Xin cảm ơn bạn đã gửi thông tin tới cho chúng tôi , mọi thông tin cá nhân và các thông tin bạn cung cấp đều được chúng tôi giữ kín. <br />Chúng tôi sẽ xử lý tin báo của bạn trong thời gian sớm nhất.<br />  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", ten);
                        bool guimail = new Libs().sendEmail(mailto, subject, body);

                        if (guimail)
                        {
                            msg = "Gửi thông tin thành công vui lòng check email để xem chi tiết";
                        }
                    }
                }
                else
                {
                    msg = val;
                }

            }
            else
            {
                msg = "Chuyên mục bạn chọn không tồn tại trong hệ thống ";
            }

            if (sucess == false)
            {
                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
                int idlog1 = new Libs().LuuLogNguoiDung(JsonConvert.SerializeObject(new { thongtindangky = new { thongtin.hoten, thongtin.email, thongtin.dienthoai, thongtin.diachi, thongtin.diaban, thongtin.noidungtinbao, thongtin.tieude, thongtin.id_chuyenmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                new Libs().lognguoidungthatbai(idlog1);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
    }

    public void loadvanbantheodanhmucluachon(HttpContext context)
    {

        string link = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
        if (link.IndexOf("/van-ban") >= 0)
        {

            var danhsach = new Contructor().GetAllVanBan();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { danhsach = danhsach }, Formatting.Indented));
        }
    }



    public void timkiemvanban(HttpContext context)
    {
        try
        {
            int nam = 0;
            string noidung = context.Request["noidung"];
            noidung = removeScriptAndCharacter.formatTextInput(noidung);
            int coquanbanhanh = client.ToInt(context.Request["coquanbanhanh"]);
            int linhvuc = client.ToInt(context.Request["linhvuc"]);
            string nambanhanh = context.Request["nambanhanh"];
            if (nambanhanh != "chonnam")
            {
                nam = client.ToInt(nambanhanh);
            }
            else
            {

            }
            string msg = "";
            bool kq = false;
            var ketqua = entity.tbl_VanBan.Where(m => (((noidung != "") ? (m.noidung.Contains(noidung) || m.trichyeu.Contains(noidung) || m.tenvanban.Contains(noidung)) : true) && ((coquanbanhanh != 0 && linhvuc != 0) ? (m.id_coquanbanhanh == coquanbanhanh && m.id_loaivanban == linhvuc) : true) && ((coquanbanhanh == 0 && linhvuc != 0) ? (m.id_loaivanban == linhvuc) : true) && ((coquanbanhanh != 0 && linhvuc == 0) ? (m.id_coquanbanhanh == coquanbanhanh) : true) && ((nambanhanh != "chonnam") ? (m.ngaybanhanh.Value.Year == nam) : true) && m.trangthai == 2)).ToList().Select(m => new
          {
              m.ngaytao,
              ds = new { tenvanban = m.tenvanban, m.linkvanban, m.id_vanban },
              sokyhieu = m.sokyhieu,
              ngaybanhanh = m.ngaybanhanh.Value.ToString("dd/MM/yyyy"),
              trichyeu = m.trichyeu,
              noidung = m.noidung,
              icon = m.icon,
              duongdanfile = m.duongdanfile,
          }).ToList();

            if (ketqua.Count > 0)
            {
                kq = true;
                msg = "Tìm kiếm thành công";
            }
            else
            {
                msg = "Không có kết quả nào phù hợp";
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { kq = kq, msg = msg, data = ketqua }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { kq = false, msg = "Tìm kiếm thất bại vui lòng thử lại", data = 0 }, Formatting.Indented));
        }


    }

    public void loaddanhsachvanban(HttpContext context)
    {
        var danhsach = entity.tbl_VanBan.Where(m => m.trangthai == 2).ToList().Select(m => new
        {
            m.id_vanban,
            m.ngaytao,
            ds = new { tenvanban = m.tenvanban, m.linkvanban, m.id_vanban },
            sokyhieu = m.sokyhieu,
            ngaybanhanh = m.ngaybanhanh.Value.ToString("dd/MM/yyyy"),
            trichyeu = m.trichyeu,
            noidung = m.noidung,
            icon = m.icon,
            duongdanfile = m.duongdanfile,
        }).ToList();

        if (danhsach != null)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = "" }, Formatting.Indented));
        }

    }


    public void loadmenutrangvanban(HttpContext context)
    {
        List<client.jsonmenuClient> oDanhMuc = new List<client.jsonmenuClient>();

        entity.Menu_Client.Where(m => m.id_danhmuc == 8 && m.trangthai == 1).ToList().All(x =>
        {
            client.jsonmenuClient m = new client.jsonmenuClient();
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

            new client().getDanhMucVanBan(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }



    public void loadsodolanhdao(HttpContext context)
    {
        Libs.dscanbo canbo = new Libs.dscanbo();
        if (new Libs().CayChucVu(out canbo, 1))
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { danhsach = canbo }, Formatting.Indented));
        }

    }


    public void loadmenugioithieu(HttpContext context)
    {
        List<client.jsonmenuClient> oDanhMuc = new List<client.jsonmenuClient>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.Menu_Client.Where(m => m.id_danhmuc == 1 && m.trangthai == 1).ToList().All(x =>
        {
            client.jsonmenuClient m = new client.jsonmenuClient();
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

            new client().getDanhMucClient(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }





    public bool IsReusable
    {
        get
        {
            return false;
        }
    }



    class BieuDo
    {
        string _tenbieudo;

        public string Tenbieudo
        {
            get { return _tenbieudo; }
            set { _tenbieudo = value; }
        }
        string _tendonvi;

        public string Tendonvi
        {
            get { return _tendonvi; }
            set { _tendonvi = value; }
        }

        int _idDonviTG;

        public int IdDonviTG
        {
            get { return _idDonviTG; }
            set { _idDonviTG = value; }
        }
        int _tuthoigian;

        public int Tuthoigian
        {
            get { return _tuthoigian; }
            set { _tuthoigian = value; }
        }
        int _denthoigian;

        public int Denthoigian
        {
            get { return _denthoigian; }
            set { _denthoigian = value; }
        }
        int _id_loaibieudo;

        public int Id_loaibieudo
        {
            get { return _id_loaibieudo; }
            set { _id_loaibieudo = value; }
        }

        string _tenLoaiBieuDo;

        public string TenLoaiBieuDo
        {
            get { return _tenLoaiBieuDo; }
            set { _tenLoaiBieuDo = value; }
        }

        string _typebieudo;

        public string Typebieudo
        {
            get { return _typebieudo; }
            set { _typebieudo = value; }
        }

        private List<int> dataX;

        public List<int> DataX
        {
            get { return dataX; }
            set { dataX = value; }
        }
        private List<string> dataY;

        public List<string> DataY
        {
            get { return dataY; }
            set { dataY = value; }
        }

        private List<string> listColor;

        public List<string> ListColor
        {
            get { return listColor; }
            set { listColor = value; }
        }


        int id_hinhthucphamtoi;

        public int Id_hinhthucphamtoi
        {
            get { return id_hinhthucphamtoi; }
            set { id_hinhthucphamtoi = value; }
        }

        string hinhthucphamtoi;

        public string Hinhthucphamtoi
        {
            get { return hinhthucphamtoi; }
            set { hinhthucphamtoi = value; }
        }

        bool trangthaithongke;

        public bool Trangthaithongke
        {
            get { return trangthaithongke; }
            set { trangthaithongke = value; }
        }

        List<thongketheoquy> listTheoQuy;

        public List<thongketheoquy> ListTheoQuy
        {
            get { return listTheoQuy; }
            set { listTheoQuy = value; }
        }





    }
    class thongketheoquy
    {

        private List<int> dataX;

        public List<int> DataX
        {
            get { return dataX; }
            set { dataX = value; }
        }
        private List<string> dataY;

        public List<string> DataY
        {
            get { return dataY; }
            set { dataY = value; }
        }

        private List<string> listColor;

        public List<string> ListColor
        {
            get { return listColor; }
            set { listColor = value; }
        }
        string hinhthucphamtoi;

        public string Hinhthucphamtoi
        {
            get { return hinhthucphamtoi; }
            set { hinhthucphamtoi = value; }
        }

    }

}