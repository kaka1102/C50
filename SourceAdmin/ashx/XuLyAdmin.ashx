<%@ WebHandler Language="C#" Class="XuLyAdmin" %>

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
using System.Globalization;
using System.Data.SqlClient;
using System.Data.Entity.Core.Objects;

public class XuLyAdmin : IHttpHandler, IRequiresSessionState
{


    // tài khoản loại 1: user
    // loại 2: admin thường
    // loại 3: admin tổng
    // loại 4 : code
    // vị trí bài viết:xóa = 0; hiển thị  = 1;hẹn giờ =2;
    // bài viết : xóa = 0; hiển thị = 1;lưu nháp =2
    // câu hỏi có 2 loại : câu hỏi mẫu > loaicauhoi=admin , câu hỏi của người dùng =nguoidung
    // trạng thái câu hỏi : 0=xóa, 1 = đang lưu , 2 = hiển thị

    // loaicauhoi=admin , câu hỏi của người dùng =nguoidung
    // bang tài khoản  :  người hoi = taikhoan1 ,người trả lời = taikhoan
    // trạng thái câu hỏi : 0=xóa, 1 = đang lưu , 2 = hiển thị
    // có 3 loại update : 

    //tentacvu: "updatedata" >> update thong tin của cau hoi -tra loi cong dan    
    // tentacvu: "traloicauhoi" >> trả lời câu hỏi của công dân , 
    //tentacvu: "updatedatamau"  >> đây là câu của admin nên ko cần gửi mail 
    // check tentacvu để biết cái nào cần gửi mail
    // bảng hồ sơ vụ án :  tinhtranghoso:0 = xóa , 1=chưa thụ án , 2 = đã thụ án
    DataC50Entities entity = new DataC50Entities();
    Libs.userDangNhap _session;
    List<kenhlamviec> klv = SocketHandler.klv;


    public Libs.userDangNhap session
    {
        get { return _session; }
        set { _session = value; }
    }

    public void ProcessRequest(HttpContext context)
    {

        string ComputerName = System.Environment.MachineName;
        string ip = HttpContext.Current.Request.UserHostAddress;
        string Agent = context.Request.UserAgent;
        //  List<kenhlamviec> klv = SocketHandler.klv;

        var typeRequest = context.Request.HttpMethod;
        session = (Libs.userDangNhap)HttpContext.Current.Session["uSession"];

        if (context.Request["type"] != null)
        {

            string type = context.Request["type"];
            switch (type)
            {
                case "xacthucemailkhiquyenmatkhau":
                    xacthucemailkhiquyenmatkhau(context);
                    break;
                default:
                    {
                        if (session != null)
                        {
                            var check = klv.Where(m => m.trangthaixacminh == true && m.maxacminh != null && m.Agent == Agent && m.ComputerName == ComputerName && m.ip == ip && m.id == session.id && m.sessionid == session.sessionid && m.tendangnhap == session.tendangnhap && m.tendaydu == session.tendaydu).FirstOrDefault();
                            if (check != null)
                            {
                                var ss = context.Session.SessionID;
                                var req = SocketHandler.blocklist.Where(m => m.sessionid == ss && m.url == type).FirstOrDefault();
                                if (req == null)
                                {
                                    req = new Blocklist();
                                    req.url = type;
                                    req.sessionid = ss;
                                    req.numberrequest = 0;
                                    SocketHandler.blocklist.Add(req);
                                }
                                else
                                {
                                    // so lan request
                                    if (req.numberrequest >= 200)
                                    {
                                        return;
                                    }
                                    else
                                    {
                                        req.numberrequest++;
                                    }
                                }

                                if (typeRequest == "POST")
                                {
                                    var TookenClientSend = context.Request["stringTookenClient"];
                                    if (TookenClientSend != "")
                                    {
                                        if (TookenClientSend == session.Tooken && TookenClientSend == check.Tooken)
                                        {
                                            switch (type)
                                            {
                                                case "themmoiadmin":
                                                    themmoiadmin(context);
                                                    break;
                                                case "suathongtintaikhoanadmin":
                                                    suathongtintaikhoanadmin(context);
                                                    break;
                                                case "xoataikhoanadmin":
                                                    xoataikhoanadmin(context);
                                                    break;
                                                case "xoathongtincanbo":
                                                    xoathongtincanbo(context);
                                                    break;
                                                case "capnhatthongtincanbo":
                                                    capnhatthongtincanbo(context);
                                                    break;
                                                case "themmoicanbolanhdao":
                                                    themmoicanbolanhdao(context);
                                                    break;
                                                case "capnhattenchucvucanbo":
                                                    capnhattenchucvucanbo(context);
                                                    break;
                                                case "themmoichucvucanbotrongcoquan":
                                                    themmoichucvucanbotrongcoquan(context);
                                                    break;
                                                case "xoathongtinlienket":
                                                    xoathongtinlienket(context);
                                                    break;
                                                case "capnhatthongtinlienkethoptac":
                                                    capnhatthongtinlienkethoptac(context);
                                                    break;
                                                case "themmoilienkethoptac":
                                                    themmoilienkethoptac(context);
                                                    break;
                                                case "doitenfile":
                                                    doitenfile(context);
                                                    break;
                                                case "xoafile":
                                                    xoafile(context);
                                                    break;
                                                case "themmoithumuc":
                                                    themmoithumuc(context);
                                                    break;
                                                case "doitenthumuc":
                                                    doitenthumuc(context);
                                                    break;
                                                case "xoathumuc":
                                                    xoathumuc(context);
                                                    break;
                                                case "dichuyenthumuc":
                                                    dichuyenthumuc(context);
                                                    break;
                                                case "coppythumuc":
                                                    coppythumuc(context);
                                                    break;
                                                case "uploadfileanh":
                                                    uploadfileanh(context);
                                                    break;
                                                case "uploadFileVideo":
                                                    uploadFileVideo(context);
                                                    break;
                                                case "uploadFileTaiLieu":
                                                    uploadFileTaiLieu(context);
                                                    break;
                                                case "themmoimenuvaonhomquanly":
                                                    themmoimenuvaonhomquanly(context);
                                                    break;
                                                case "themadminvaonhom":
                                                    themadminvaonhom(context);
                                                    break;
                                                case "loaiboadminkhoinhomquanly":
                                                    loaiboadminkhoinhomquanly(context);
                                                    break;
                                                case "loaibomenukhoinhomquanly":
                                                    loaibomenukhoinhomquanly(context);
                                                    break;
                                                case "suaquyencuaadmintrongmenu":
                                                    suaquyencuaadmintrongmenu(context);
                                                    break;
                                                case "thaydoiquyenquanlylistmenu":
                                                    thaydoiquyenquanlylistmenu(context);
                                                    break;
                                                case "xoanhomadmin":
                                                    xoanhomadmin(context);
                                                    break;
                                                case "capnhatthongtinbanner":
                                                    capnhatthongtinbanner(context);
                                                    break;
                                                case "xoabanner":
                                                    xoabanner(context);
                                                    break;
                                                case "themmoibannervaohethong":
                                                    themmoibannervaohethong(context);
                                                    break;
                                                case "xoalichhienthibanner":
                                                    xoalichhienthibanner(context);
                                                    break;
                                                case "themmoilichhienthichobanner":
                                                    themmoilichhienthichobanner(context);
                                                    break;
                                                case "themmoiquangcao":
                                                    themmoiquangcao(context);
                                                    break;
                                                case "xoaquangcao":
                                                    xoaquangcao(context);
                                                    break;
                                                case "updatethongtinquangcao":
                                                    updatethongtinquangcao(context);
                                                    break;
                                                case "capnhatthongtincanhanadmin":
                                                    capnhatthongtincanhanadmin(context);
                                                    break;
                                                case "thaydoimatkhaucanhan":
                                                    thaydoimatkhaucanhan(context);
                                                    break;
                                                case "capnhatthongtindanhmuc":
                                                    capnhatthongtindanhmuc(context);
                                                    break;
                                                case "thaydoitrangthaihienthimenu":
                                                    thaydoitrangthaihienthimenu(context);
                                                    break;
                                                case "themmoidanhmuctrongmenu":
                                                    themmoidanhmuctrongmenu(context);
                                                    break;
                                                case "doitendanhmuc":
                                                    doitendanhmuc(context);
                                                    break;
                                                case "xoadanhmuc":
                                                    xoadanhmuc(context);
                                                    break;
                                                case "dichuyendanhmuc":
                                                    dichuyendanhmuc(context);
                                                    break;
                                                case "themmoibaiviet":
                                                    themmoibaiviet(context);
                                                    break;
                                                case "xoabaiviettintuc":
                                                    xoabaiviettintuc(context);
                                                    break;
                                                case "capnhatthongtinbaiviettintuc":
                                                    capnhatthongtinbaiviettintuc(context);
                                                    break;
                                                case "xoabaiviettrongdanhmuctintuc":
                                                    xoabaiviettrongdanhmuctintuc(context);
                                                    break;
                                                case "themmoidanhmucvalichhienthichobaiviet":
                                                    themmoidanhmucvalichhienthichobaiviet(context);
                                                    break;
                                                case "themmoivanban":
                                                    themmoivanban(context);
                                                    break;
                                                case "capnhatthongtinvanban":
                                                    capnhatthongtinvanban(context);
                                                    break;
                                                case "xoavanban":
                                                    xoavanban(context);
                                                    break;
                                                case "capnhatthongtinbvgt":
                                                    capnhatthongtinbvgt(context);
                                                    break;
                                                case "themmoibaivietgioithieu":
                                                    themmoibaivietgioithieu(context);
                                                    break;
                                                case "xoatinbaocongdan":
                                                    xoatinbaocongdan(context);
                                                    break;
                                                case "capnhattinhtrangxemcuatinbao":
                                                    capnhattinhtrangxemcuatinbao(context);
                                                    break;
                                                case "capnhatthongtintinbaocongdan":
                                                    capnhatthongtintinbaocongdan(context);
                                                    break;
                                                case "xoacauhoitraloimau":
                                                    xoacauhoitraloimau(context);
                                                    break;
                                                case "capnhatthongtincauhoitraloimau":
                                                    capnhatthongtincauhoitraloimau(context);
                                                    break;
                                                case "themmoicauhoitraloimau":
                                                    themmoicauhoitraloimau(context);
                                                    break;
                                                case "xoalienlacduongdaynong":
                                                    xoalienlacduongdaynong(context);
                                                    break;
                                                case "themoilienlacduongdaynong":
                                                    themoilienlacduongdaynong(context);
                                                    break;
                                                case "capnhatthongtinduongdaynong":
                                                    capnhatthongtinduongdaynong(context);
                                                    break;
                                                case "xoahuongdantinhhuongsayra":
                                                    xoahuongdantinhhuongsayra(context);
                                                    break;
                                                case "capnhatthongtintinhhuongvacachxuly":
                                                    capnhatthongtintinhhuongvacachxuly(context);
                                                    break;
                                                case "themmmoitinhhuongvacachxuly":
                                                    themmmoitinhhuongvacachxuly(context);
                                                    break;
                                                case "themmoithuvienanhClient":
                                                    themmoithuvienanhClient(context);
                                                    break;
                                                case "xoaalbumanh":
                                                    xoaalbumanh(context);
                                                    break;
                                                case "capnhatthongtinalbumanh":
                                                    capnhatthongtinalbumanh(context);
                                                    break;
                                                case "themmoithuvienVideoClient":
                                                    themmoithuvienVideoClient(context);
                                                    break;
                                                case "themmoicauhoithamdoykien":
                                                    themmoicauhoithamdoykien(context);
                                                    break;
                                                case "xoaphieuthamdoykien":
                                                    xoaphieuthamdoykien(context);
                                                    break;
                                                case "capnhatthongtincauhoithamdoykien":
                                                    capnhatthongtincauhoithamdoykien(context);
                                                    break;
                                                case "xoathongtintoipham":
                                                    xoathongtintoipham(context);
                                                    break;
                                                case "themmoihosoancuatoipham":
                                                    themmoihosoancuatoipham(context);
                                                    break;
                                                case "themmoithongtintoipham":
                                                    themmoithongtintoipham(context);
                                                    break;
                                                case "xoahosoancuatoipham":
                                                    xoahosoancuatoipham(context);
                                                    break;
                                                case "capnhatthongtinhosoantoipham":
                                                    capnhatthongtinhosoantoipham(context);
                                                    break;
                                                case "capnhatthongtincanhantoipham":
                                                    capnhatthongtincanhantoipham(context);
                                                    break;
                                                case "xoahinhthucphamtoi":
                                                    xoahinhthucphamtoi(context);
                                                    break;
                                                case "capnhatthongtinhinhthucphamtoi":
                                                    capnhatthongtinhinhthucphamtoi(context);
                                                    break;
                                                case "themmoihinhthucphamtoi":
                                                    themmoihinhthucphamtoi(context);
                                                    break;
                                                case "xoabieudo":
                                                    xoabieudo(context);
                                                    break;
                                                case "capnhatthongtinbieudo":
                                                    capnhatthongtinbieudo(context);
                                                    break;
                                                case "themmoibieudothongke":
                                                    themmoibieudothongke(context);
                                                    break;
                                                case "xoadanhmuchoidap":
                                                    xoadanhmuchoidap(context);
                                                    break;
                                                case "capnhatthongtindanhmuchoidap":
                                                    capnhatthongtindanhmuchoidap(context);
                                                    break;
                                                case "themmoidanhmuchoidap":
                                                    themmoidanhmuchoidap(context);
                                                    break;
                                                case "themmoinhomquanly":
                                                    themmoinhomquanly(context);
                                                    break;
                                                case "uploadfileanhtuserver":
                                                    uploadfileanhtuserver(context);
                                                    break;
                                                case "uploadFileTaiLieuServer":
                                                    uploadFileTaiLieuServer(context);
                                                    break;
                                                case "uploadFileVideoServer":
                                                    uploadFileVideoServer(context);
                                                    break;
                                                default:
                                                    context.Response.Write(JsonConvert.SerializeObject(new { msg = "Request not found !", sucess = false }, Formatting.Indented));
                                                    break;
                                            }
                                        }
                                        else
                                        {
                                            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Tooken request fail !", sucess = false }, Formatting.Indented));
                                        }
                                    }
                                    else
                                    {
                                        context.Response.Write(JsonConvert.SerializeObject(new { msg = "Request not tooken !", sucess = false }, Formatting.Indented));
                                    }
                                }
                                else if (typeRequest == "GET")
                                {

                                    switch (type)
                                    {
                                        case "logoutadmin":
                                            logoutadmin(context);
                                            break;
                                        case "loadthongtincanhanadmin":
                                            loadthongtincanhanadmin(context);
                                            break;
                                        case "abc":
                                            var aaaaaa = GetAllDataLogHoatDong().Where(m => m.type == "loginsucess" && m.id_taikhoan == 1).ToList();
                                            context.Response.Write(JsonConvert.SerializeObject(aaaaaa, Formatting.Indented));
                                            break;
                                        case "loadmenutrangadmin":
                                            loadmenutrangadmin(context);
                                            break;
                                        case "danhsachtaikhoanadmin":
                                            danhsachtaikhoanadmin(context);
                                            break;
                                        case "danhsachnhomquyen":
                                            danhsachnhomquyen(context);
                                            break;
                                        case "checkquyenxemtrang":
                                            checkquyenxemtrang(context);
                                            break;
                                        case "danhsachquyen":
                                            danhsachquyen(context);
                                            break;
                                        case "danhsachlienkethoptac":
                                            danhsachlienkethoptac(context);
                                            break;
                                        case "loaddanhsachthumucanh":
                                            loaddanhsachthumucanh(context);
                                            break;
                                        case "danhsachdulieutrongthumuc":
                                            danhsachdulieutrongthumuc(context);
                                            break;
                                        case "danhsachanhduocchiase":
                                            danhsachanhduocchiase(context);
                                            break;
                                        case "loaddanhsachthumucvideo":
                                            loaddanhsachthumucvideo(context);
                                            break;
                                        case "danhsachvideoduocchiase":
                                            danhsachvideoduocchiase(context);
                                            break;
                                        case "loaddanhsachthumucTailieu":
                                            loaddanhsachthumucTailieu(context);
                                            break;
                                        case "danhsachtailieuduocchiase":
                                            danhsachtailieuduocchiase(context);
                                            break;
                                        case "danhsachnhomadmin":
                                            danhsachnhomadmin(context);
                                            break;
                                        case "loaddanhsachadminthemmoivaonhom":
                                            loaddanhsachadminthemmoivaonhom(context);
                                            break;
                                        case "loadmenuchuatontaitrongquyen":
                                            loadmenuchuatontaitrongquyen(context);
                                            break;
                                        case "loadalladminthemvaonhomquanly":
                                            loadalladminthemvaonhomquanly(context);
                                            break;
                                        case "loadallmenuthemmoinhom":
                                            loadallmenuthemmoinhom(context);
                                            break;
                                        case "loaddanhsachthumucbanner":
                                            loaddanhsachthumucbanner(context);
                                            break;
                                        case "danhsachBannertrongthumuc":
                                            danhsachBannertrongthumuc(context);
                                            break;
                                        case "loadkeythumucmenuclient":
                                            loadkeythumucmenuclient(context);
                                            break;
                                        case "loadthongtindanhmuctheoID":
                                            loadthongtindanhmuctheoID(context);
                                            break;
                                        case "loaddanhsachdanhmuctintuc":
                                            loaddanhsachdanhmuctintuc(context);
                                            break;
                                        case "loadalldanhsachbaiviet":
                                            loadalldanhsachbaiviet(context);
                                            break;
                                        case "loaddanhsachcoquanbanhanh":
                                            loaddanhsachcoquanbanhanh(context);
                                            break;
                                        case "loaddanhsachloaivanban":
                                            loaddanhsachloaivanban(context);
                                            break;
                                        case "loaddanhsachvanbantronghethong":
                                            loaddanhsachvanbantronghethong(context);
                                            break;
                                        case "loaddanhmuctranggioithieu":
                                            loaddanhmuctranggioithieu(context);
                                            break;
                                        case "loaddanhsachbaivietcuadanhmucgioithieu":
                                            loaddanhsachbaivietcuadanhmucgioithieu(context);
                                            break;
                                        case "loaddanhsachdanhmuchoptacquocte":
                                            loaddanhsachdanhmuchoptacquocte(context);
                                            break;
                                        case "loaddanhsachbaiviethoptacquocte":
                                            loaddanhsachbaiviethoptacquocte(context);
                                            break;
                                        case "danhsachdanhmucGUONGDIENHINH":
                                            danhsachdanhmucGUONGDIENHINH(context);
                                            break;
                                        case "loadAlldanhsachbaivietGUONGDIENHINH":
                                            loadAlldanhsachbaivietGUONGDIENHINH(context);
                                            break;
                                        case "danhsachtinbaocongdan":
                                            danhsachtinbaocongdan(context);
                                            break;
                                        case "loaddanhsachdanhmuctinbaocongdan":
                                            loaddanhsachdanhmuctinbaocongdan(context);
                                            break;
                                        case "danhsachcauhoitraloimau":
                                            danhsachcauhoitraloimau(context);
                                            break;
                                        case "getAdllDanhmucCauhoi":
                                            getAdllDanhmucCauhoi(context);
                                            break;
                                        case "loadalldanhsachcauhoicuacongdan":
                                            loadalldanhsachcauhoicuacongdan(context);
                                            break;
                                        case "loadalldanhsachduongdaynong":
                                            loadalldanhsachduongdaynong(context);
                                            break;
                                        case "loadalldanhsachtinhhuong":
                                            loadalldanhsachtinhhuong(context);
                                            break;
                                        case "loaddaanhsachquanham":
                                            loaddaanhsachquanham(context);
                                            break;
                                        case "danhsachdonvicongtac":
                                            danhsachdonvicongtac(context);
                                            break;
                                        case "danhsachchucvulanhdao":
                                            danhsachchucvulanhdao(context);
                                            break;
                                        case "danhsachcanbolanhdao":
                                            danhsachcanbolanhdao(context);
                                            break;
                                        case "loadalldanhsachchucvucuacanbo":
                                            loadalldanhsachchucvucuacanbo(context);
                                            break;
                                        case "loaddanhsachdanhmuccuaalbumanh":
                                            loaddanhsachdanhmuccuaalbumanh(context);
                                            break;
                                        case "danhsachAlbumAnh":
                                            danhsachAlbumAnh(context);
                                            break;
                                        case "danhsachAlbumVideo":
                                            danhsachAlbumVideo(context);
                                            break;
                                        case "loadhinhthuctraloithamdoykien":
                                            loadhinhthuctraloithamdoykien(context);
                                            break;
                                        case "loaddanhsachcauhoithamdoykien":
                                            loaddanhsachcauhoithamdoykien(context);
                                            break;
                                        case "loadhinhthucphamtoi":
                                            loadhinhthucphamtoi(context);
                                            break;
                                        case "loaddanhsachtoipham":
                                            loaddanhsachtoipham(context);
                                            break;
                                        case "loadallHinhThucPhamToi":
                                            loadallHinhThucPhamToi(context);
                                            break;
                                        case "loadloaibieudo":
                                            loadloaibieudo(context);
                                            break;
                                        case "loaddonvivebieudo":
                                            loaddonvivebieudo(context);
                                            break;
                                        case "loaddanhsachbieudo":
                                            loaddanhsachbieudo(context);
                                            break;
                                        case "loadalllog":
                                            loadalllog(context);
                                            break;
                                        case "loadvitridatquangcao":
                                            loadvitridatquangcao(context);
                                            break;
                                        case "loaddanhsachquangcao":
                                            loaddanhsachquangcao(context);
                                            break;
                                        case "danhsachLogotrongthumuc":
                                            danhsachLogotrongthumuc(context);
                                            break;
                                        case "loaddanhsachbanglog":
                                            loaddanhsachbanglog(context);
                                            break;
                                        case "loadallDSdanhmuccaucoi":
                                            loadallDSdanhmuccaucoi(context);
                                            break;
                                        case "danhsachdanhmuccanhbaonguoidan":
                                            danhsachdanhmuccanhbaonguoidan(context);
                                            break;
                                        case "loadAlldanhsachbaivietcanhbaonguoidan":
                                            loadAlldanhsachbaivietcanhbaonguoidan(context);
                                            break;
                                        case "getTookenByServer":
                                            getTookenByServer(context);
                                            break;
                                        default:
                                            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Request not found  !", sucess = false }, Formatting.Indented));
                                            break;
                                    }
                                }
                                else
                                {
                                    context.Response.Write(JsonConvert.SerializeObject(new { msg = "Request not found  !", sucess = false }, Formatting.Indented));
                                }
                            }
                            else
                            {
                                // session sai
                                context.Response.ContentType = "text/plain";
                                context.Response.Write(JsonConvert.SerializeObject(new { msg = "session sai", suscess = false, data = 0 }, Formatting.Indented));
                                SocketHandler.send(JsonConvert.SerializeObject(new { logout = true }));
                                break;
                            }
                        }
                        else
                        {
                            context.Response.ContentType = "text/plain";
                            context.Response.Write(JsonConvert.SerializeObject(new { msg = "ko co session", suscess = false, data = 0 }, Formatting.Indented));
                            SocketHandler.send(JsonConvert.SerializeObject(new { pageLoad = true }));
                            break;
                        }
                    }
                    break;
            }
        }
    }

    public void getTookenByServer(HttpContext context)
    {
        string ComputerName = System.Environment.MachineName;
        string ip = HttpContext.Current.Request.UserHostAddress;
        string Agent = context.Request.UserAgent;

        var check = klv.Where(m => m.trangthaixacminh == true && m.maxacminh != null && m.Agent == Agent && m.ComputerName == ComputerName && m.ip == ip && m.id == session.id && m.sessionid == session.sessionid && m.tendangnhap == session.tendangnhap && m.tendaydu == session.tendaydu && m.Tooken == session.Tooken).FirstOrDefault();

        if (check != null)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { tooken = session.Tooken }, Formatting.Indented));
        }
        else
        {
            context.Response.Write(JsonConvert.SerializeObject(new { tooken = "tooken fail" }, Formatting.Indented));
        }
    }
    public void themmoidanhmuchoidap(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        tbl_ChuyenMucLuaChon hinhthucpt = new tbl_ChuyenMucLuaChon();

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                if (new Libs().QuyenThemMoi())
                {
                    Contructor.danhmuccauhoi thongtin = (Contructor.danhmuccauhoi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.danhmuccauhoi));

                    var checktontai = entity.tbl_ChuyenMucLuaChon.Where(x => x.tenchuyenmuc == thongtin.tenchuyenmuc && x.trangthai == true).FirstOrDefault();
                    if (checktontai == null)
                    {
                        string tenrutgon = new Libs().ConvertUrlsToLinks(thongtin.tenchuyenmuc);

                        hinhthucpt.tenchuyenmuc = thongtin.tenchuyenmuc;
                        hinhthucpt.trangthai = true;
                        hinhthucpt.id_danhmuc = 12;
                        hinhthucpt.linkchuyenmuc = tenrutgon;

                        entity.tbl_ChuyenMucLuaChon.Add(hinhthucpt);
                        entity.SaveChanges();

                        suscess = true;
                        msg = "Thêm mới danh mục hỏi đáp thành công ";
                        string vitrihs = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap());
                        int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hinhthucpt.id_chuyenmuc, hinhthucpt.tenchuyenmuc, hinhthucpt.trangthai, hinhthucpt.id_danhmuc, hinhthucpt.linkchuyenmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                        new Libs().updateKieuLogThemMoiThanhCong(idloghs);
                    }
                    else
                    {
                        msg = "Danh mục hỏi đáp này đã tồn tại trong hệ thống";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }
        if (suscess == false)
        {
            string vitri5 = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap());
            int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
            new Libs().updateKieuLogThemMoiThatBai(idlog5);
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }

    public void capnhatthongtindanhmuchoidap(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
        {
            Contructor.danhmuccauhoi thongtincb = (Contructor.danhmuccauhoi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.danhmuccauhoi));

            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_ChuyenMucLuaChon.Where(m => m.id_chuyenmuc == thongtincb.id_chuyenmuc && m.trangthai == true).FirstOrDefault();
                    if (check != null)
                    {
                        var checkten = entity.tbl_ChuyenMucLuaChon.Where(xx => xx.id_chuyenmuc != check.id_chuyenmuc && xx.tenchuyenmuc == thongtincb.tenchuyenmuc && xx.trangthai == true).FirstOrDefault();
                        if (checkten == null)
                        {
                            string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_chuyenmuc, check.tenchuyenmuc, check.trangthai, check.id_danhmuc, check.linkchuyenmuc }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                            string tenrutgon = new Libs().ConvertUrlsToLinks(thongtincb.tenchuyenmuc);

                            check.tenchuyenmuc = thongtincb.tenchuyenmuc;
                            check.linkchuyenmuc = tenrutgon;
                            entity.SaveChanges();

                            tbl_ChuyenMucLuaChon dataJsonParent = (tbl_ChuyenMucLuaChon)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_ChuyenMucLuaChon));

                            string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap());
                            int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_chuyenmuc, check.tenchuyenmuc, check.trangthai, check.id_danhmuc, check.linkchuyenmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                            sucess = true;
                            msg = "Cập nhật thông tin thành công";

                        }
                        else
                        {
                            msg = "Tên này đã tồn tại trong hệ thống ";
                        }
                    }
                    else
                    {
                        msg = "Danh mục câu hỏi này không tồn tại trong hệ thống";

                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền thực hiện chức năng này";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {

            string vitri = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap()); // vitri
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }


    public void xoadanhmuchoidap(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id_chuyenmuc = 0;
        if (new Libs().checkDuLieuGuiLen(context.Request["id_chuyenmuc"]))
        {
            //   int id_chuyenmuc = int.Parse(context.Request["id_chuyenmuc"]);
            int.TryParse(context.Request["id_chuyenmuc"], out id_chuyenmuc);
            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var checktienan = entity.tbl_ChuyenMucLuaChon.Where(x => x.id_chuyenmuc == id_chuyenmuc).FirstOrDefault();

                    if (checktienan != null)
                    {
                        checktienan.trangthai = false;
                        entity.SaveChanges();
                        sucess = true;

                        msg = "Xóa danh mục hỏi đáp thành công !";
                        string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap()); // vitri
                        int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checktienan.id_chuyenmuc, checktienan.tenchuyenmuc, checktienan.trangthai, checktienan.id_danhmuc, checktienan.linkchuyenmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                        new Libs().updateKieuLogXoaThanhCong(idlogxoahs);

                    }
                    else
                    {
                        msg = "Danh mục hỏi đáp này không tồn tại !";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitriFail = new Libs().VitriTruyCapVaIP("tbl_ChuyenMucLuaChon", new Libs().ThietBiTruyCap()); // vitri
            int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
            new Libs().updateKieuLogXoaThatBai(idlogFail);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void loadallDSdanhmuccaucoi(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_ChuyenMucLuaChon.Where(m => m.trangthai == true && m.id_danhmuc == 12).ToList().OrderByDescending(m => m.id_chuyenmuc).Select(m => new
            {
                m.id_chuyenmuc,
                m.tenchuyenmuc,
                m.trangthai,
                m.id_danhmuc,
                m.linkchuyenmuc,
                button = new
                {
                    m.id_chuyenmuc,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }



    public void loaddanhsachbanglog(HttpContext context)
    {

        var danhsach = entity.tbl_Danhsachbanglog.Where(m => m.trangthai == 1).Select(m => new
        {
            m.id_danhsach,
            m.ngaytao,
            m.tenbanglog
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void updatethongtinquangcao(HttpContext context)
    {
        // kaka
        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        bool quyen = false;
        bool checkFile = true;

        try
        {
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtinqc"]))
                    {
                        Contructor.quangcao thongtin = (Contructor.quangcao)JsonConvert.DeserializeObject(context.Request["thongtinqc"], typeof(Contructor.quangcao));

                        var checktontai = entity.tbl_quangcao.Where(m => m.id_quangcao == thongtin.id_quangcao).FirstOrDefault();
                        var checkvitri = entity.tbl_VitriQuangCao.Where(m => m.name == thongtin.diemdattrongtrang).FirstOrDefault();
                        if (checktontai != null)
                        {

                            string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_quangcao, checktontai.tenquangcao, checktontai.donvidat, checktontai.trangthaihienthi, checktontai.thongtin, checktontai.manguon, checktontai.tilexuathien, checktontai.ngaydang, checktontai.ngaydung, checktontai.id_quanlythumuc, checktontai.id_taikhoan, checktontai.id_vitriquangcao, checktontai.linkquangcao }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                            string tenfile;
                            string duongdan;
                            string typeFile;
                            string tenanh;
                            string fileanhluu = "";
                            string nhaytrang;
                            int gioihandata = 1048576 * 10;

                            if (context.Request.Files.Count > 0)
                            {

                                string tenmoicuafle;
                                HttpFileCollection files = context.Request.Files;
                                HttpPostedFile file = context.Request.Files["fileanh"];
                                string mimeType = MimeMapping.GetMimeMapping(file.FileName);

                                int type = (mimeType.IndexOf("image/"));

                                int filesize = file.ContentLength;
                                if (filesize > gioihandata)
                                {
                                    msg = "Dung lượng file vượt quá quy định ";
                                    checkFile = false;
                                }
                                else
                                {
                                    if (type >= 0)
                                    {
                                        if (mimeType == "image/png")
                                        {
                                            typeFile = Path.GetExtension(file.FileName);
                                            tenfile = MD5.RandomString(16);
                                            fileanhluu = "/ThuMucGoc/Banner_QuangCao/" + tenfile + typeFile;
                                            duongdan = context.Server.MapPath("~" + fileanhluu);
                                            file.SaveAs(duongdan);
                                        }
                                        else
                                        {
                                            string sImageName = file.FileName;

                                            file.SaveAs(context.Server.MapPath("~/images/" + Path.GetFileName(sImageName)));

                                            Bitmap bitmap = new Bitmap(context.Server.MapPath("~/images/" + Path.GetFileName(file.FileName)));

                                            int iwidth = bitmap.Width;
                                            int iheight = bitmap.Height;
                                            bitmap.Dispose();

                                            System.Drawing.Image objOptImage = new System.Drawing.Bitmap(iwidth, iheight, System.Drawing.Imaging.PixelFormat.Format16bppRgb555);
                                            using (System.Drawing.Image objImg = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/images/" + sImageName)))
                                            {
                                                using (System.Drawing.Graphics oGraphic = System.Drawing.Graphics.FromImage(objOptImage))
                                                {
                                                    var _1 = oGraphic;
                                                    System.Drawing.Rectangle oRectangle = new System.Drawing.Rectangle(0, 0, iwidth, iheight);
                                                    _1.DrawImage(objImg, oRectangle);
                                                }

                                                typeFile = Path.GetExtension(sImageName);
                                                tenfile = MD5.RandomString(16);
                                                fileanhluu = "/ThuMucGoc/Banner_QuangCao/" + tenfile + typeFile;

                                                objOptImage.Save(HttpContext.Current.Server.MapPath("~" + fileanhluu), System.Drawing.Imaging.ImageFormat.Jpeg);
                                                objImg.Dispose();
                                            }
                                            objOptImage.Dispose();
                                        }
                                        string tenFileCu = context.Server.MapPath(checktontai.manguon);

                                        if ((System.IO.File.Exists(tenFileCu)))
                                        {
                                            System.IO.File.Delete(tenFileCu);
                                        }

                                    }
                                    else
                                    {
                                        msg = "File upload không hợp lệ (chỉ chấp nhận các file ảnh)";
                                        checkFile = false;
                                    }
                                }
                            }
                            else
                            {
                                fileanhluu = checktontai.manguon;
                            }

                            if (checkFile)
                            {
                                checktontai.linkquangcao = removeScriptAndCharacter.formatTextInput(thongtin.linkquangcao);
                                checktontai.tenquangcao = removeScriptAndCharacter.formatTextInput(thongtin.tenquangcao);
                                checktontai.donvidat = removeScriptAndCharacter.formatTextInput(thongtin.donvidat);
                                checktontai.thongtin = removeScriptAndCharacter.formatTextInput(thongtin.thongtin);
                                checktontai.manguon = removeScriptAndCharacter.formatTextInput(fileanhluu);
                                checktontai.tilexuathien = thongtin.tilexuathien;
                                checktontai.id_vitriquangcao = checkvitri.id_vitriquangcao;

                                if (thongtin.trangthaihienthi == "hienthi")
                                {
                                    checktontai.trangthaihienthi = 2;
                                    checktontai.ngaydung = thongtin.ngaydung;
                                }
                                else if (thongtin.trangthaihienthi == "hengio")
                                {
                                    checktontai.trangthaihienthi = 2;
                                    checktontai.ngaydang = thongtin.ngaydang;
                                    checktontai.ngaydung = thongtin.ngaydung;
                                }
                                else
                                {
                                    checktontai.trangthaihienthi = 1;
                                }

                                entity.SaveChanges();
                                suscess = true;
                                msg = "Cập nhật thông tin thành công ";


                                tbl_Baiviet dataJson = (tbl_Baiviet)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_Baiviet));
                                string vitri = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_quangcao, checktontai.tenquangcao, checktontai.donvidat, checktontai.trangthaihienthi, checktontai.thongtin, checktontai.manguon, checktontai.tilexuathien, checktontai.ngaydang, checktontai.ngaydung, checktontai.id_quanlythumuc, checktontai.id_taikhoan, checktontai.id_vitriquangcao, checktontai.linkquangcao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                            }

                        }
                        else
                        {
                            msg = "Quảng cáo này không tồn tại trong hệ thống";
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }
    public void xoaquangcao(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int idquangcao = 0;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["idquangcao"]))
            {
                //   int idquangcao = int.Parse(context.Request["idquangcao"]);

                int.TryParse(context.Request["idquangcao"], out idquangcao);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var checkqc = entity.tbl_quangcao.Where(x => x.id_quangcao == idquangcao).FirstOrDefault();

                        if (checkqc != null)
                        {
                            checkqc.trangthaihienthi = 0;
                            entity.SaveChanges();
                            sucess = true;

                            msg = "Xóa quảng cáo thành công !";
                            string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap()); // vitri
                            int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkqc.id_quangcao, checkqc.tenquangcao, checkqc.donvidat, checkqc.trangthaihienthi, checkqc.thongtin, checkqc.manguon, checkqc.tilexuathien, checkqc.ngaydang, checkqc.ngaydung, checkqc.id_quanlythumuc, checkqc.id_taikhoan, checkqc.id_vitriquangcao, checkqc.linkquangcao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlogxoahs);

                        }
                        else
                        {
                            msg = "Quảng cáo này không tồn tại !";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void loaddanhsachquangcao(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_quangcao.Where(m => m.trangthaihienthi != 0).ToList().OrderByDescending(m => m.id_quangcao).Select(m => new
            {
                m.id_quangcao,
                m.tenquangcao,
                m.donvidat,
                m.trangthaihienthi,
                m.thongtin,
                m.manguon,
                m.tilexuathien,
                ngaydang = (m.ngaydang != null) ? m.ngaydang.Value.ToString("MM/dd/yyyy") : null,
                ngaydung = (m.ngaydung != null) ? m.ngaydung.Value.ToString("MM/dd/yyyy") : null,
                m.linkquangcao,
                trangthai = ((m.ngaydung > DateTime.Now && m.ngaydang < DateTime.Now && m.trangthaihienthi == 2) ? "Đang chạy" : ((m.ngaydung < DateTime.Now && m.ngaydang < DateTime.Now && m.trangthaihienthi == 2) ? "Đã chạy" : "Lưu nháp")),
                id_vitriquangcao = m.tbl_VitriQuangCao.id_vitriquangcao,
                name = m.tbl_VitriQuangCao.name,
                type = m.tbl_VitriQuangCao.type,
                mota = m.tbl_VitriQuangCao.mota,
                list = entity.tbl_VitriQuangCao.Where(zz => zz.type == m.tbl_VitriQuangCao.type).ToList().Select(zz => new
                {
                    zz.id_vitriquangcao,
                    zz.name,
                    zz.mota
                }),
                button = new
                {
                    m.id_quangcao,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }

            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }


    public void themmoiquangcao(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        tbl_quangcao quangcao = new tbl_quangcao();

        try
        {
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtinqc"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.quangcao thongtin = (Contructor.quangcao)JsonConvert.DeserializeObject(context.Request["thongtinqc"], typeof(Contructor.quangcao));

                        var checkvitri = entity.tbl_VitriQuangCao.Where(m => m.name == thongtin.diemdattrongtrang).FirstOrDefault();

                        if (checkvitri != null)
                        {
                            string tenfile;
                            string duongdan;
                            string typeFile;
                            string tenanh;
                            string fileanhluu = "";
                            string nhaytrang;
                            int gioihandata = 1048576 * 10;

                            if (context.Request.Files.Count > 0)
                            {
                                string tenmoicuafle;
                                HttpFileCollection files = context.Request.Files;
                                HttpPostedFile file = context.Request.Files["fileanh"];
                                string mimeType = MimeMapping.GetMimeMapping(file.FileName);

                                int type = (mimeType.IndexOf("image/"));

                                int filesize = file.ContentLength;
                                if (filesize > gioihandata)
                                {
                                    msg = "Dung lượng file vượt quá quy định ";
                                }
                                else
                                {
                                    if (type >= 0)
                                    {

                                        if (mimeType == "image/png")
                                        {
                                            typeFile = Path.GetExtension(file.FileName);
                                            tenfile = MD5.RandomString(16);
                                            fileanhluu = "/ThuMucGoc/Banner_QuangCao/" + tenfile + typeFile;
                                            duongdan = context.Server.MapPath("~" + fileanhluu);
                                            file.SaveAs(duongdan);
                                        }
                                        else
                                        {
                                            string sImageName = file.FileName;

                                            file.SaveAs(context.Server.MapPath("~/images/" + Path.GetFileName(sImageName)));

                                            Bitmap bitmap = new Bitmap(context.Server.MapPath("~/images/" + Path.GetFileName(file.FileName)));

                                            int iwidth = bitmap.Width;
                                            int iheight = bitmap.Height;
                                            bitmap.Dispose();

                                            System.Drawing.Image objOptImage = new System.Drawing.Bitmap(iwidth, iheight, System.Drawing.Imaging.PixelFormat.Format16bppRgb555);
                                            using (System.Drawing.Image objImg = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/images/" + sImageName)))
                                            {
                                                using (System.Drawing.Graphics oGraphic = System.Drawing.Graphics.FromImage(objOptImage))
                                                {
                                                    var _1 = oGraphic;
                                                    System.Drawing.Rectangle oRectangle = new System.Drawing.Rectangle(0, 0, iwidth, iheight);
                                                    _1.DrawImage(objImg, oRectangle);
                                                }

                                                typeFile = Path.GetExtension(sImageName);
                                                tenfile = MD5.RandomString(16);
                                                fileanhluu = "/ThuMucGoc/Banner_QuangCao/" + tenfile + typeFile;

                                                objOptImage.Save(HttpContext.Current.Server.MapPath("~" + fileanhluu), System.Drawing.Imaging.ImageFormat.Jpeg);
                                                objImg.Dispose();
                                            }
                                            objOptImage.Dispose();
                                        }

                                        // check mime type by byte file
                                        string link_CK = context.Server.MapPath("~" + fileanhluu);

                                        FileInfo ff = new FileInfo(link_CK);
                                        bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsImages(ff);
                                        if (ck_Type == true)
                                        {
                                            quangcao.linkquangcao = removeScriptAndCharacter.formatTextInput(thongtin.linkquangcao);
                                            quangcao.tenquangcao = removeScriptAndCharacter.formatTextInput(thongtin.tenquangcao);
                                            quangcao.donvidat = removeScriptAndCharacter.formatTextInput(thongtin.donvidat);
                                            quangcao.thongtin = removeScriptAndCharacter.formatTextInput(thongtin.thongtin);
                                            quangcao.manguon = removeScriptAndCharacter.formatTextInput(fileanhluu);
                                            quangcao.tilexuathien = thongtin.tilexuathien;
                                            quangcao.id_taikhoan = session.id;
                                            quangcao.id_quanlythumuc = 4;
                                            quangcao.id_vitriquangcao = checkvitri.id_vitriquangcao;

                                            if (thongtin.trangthaihienthi == "hienthi")
                                            {
                                                quangcao.trangthaihienthi = 2;
                                                quangcao.ngaydang = DateTime.Now;
                                                quangcao.ngaydung = thongtin.ngaydung;
                                            }
                                            else if (thongtin.trangthaihienthi == "hengio")
                                            {
                                                quangcao.trangthaihienthi = 2;
                                                quangcao.ngaydang = thongtin.ngaydang;
                                                quangcao.ngaydung = thongtin.ngaydung;
                                            }
                                            else
                                            {
                                                quangcao.trangthaihienthi = 1;
                                            }

                                            entity.tbl_quangcao.Add(quangcao);
                                            entity.SaveChanges();

                                            suscess = true;
                                            msg = "Thêm mới quảng cáo vào hệ thống thành công ";
                                            string vitrihs = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap());
                                            int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { quangcao.tenquangcao, quangcao.donvidat, quangcao.trangthaihienthi, quangcao.thongtin, quangcao.manguon, quangcao.tilexuathien, quangcao.ngaydang, quangcao.ngaydung, quangcao.id_taikhoan, quangcao.id_quanlythumuc, quangcao.id_vitriquangcao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                            new Libs().updateKieuLogThemMoiThanhCong(idloghs);
                                        }
                                        else
                                        {
                                            if (System.IO.File.Exists(link_CK))
                                            {
                                                System.IO.File.Delete(link_CK);
                                            }
                                            msg = "Kiểu file upload đã bị thay đổi (jpeg,gif,png,bmp,ico)";
                                        }
                                    }
                                    else
                                    {
                                        msg = "Kiểu file upload không hợp lệ (jpeg,gif,png,bmp,ico)";
                                    }
                                }
                            }
                            else
                            {
                                msg = "File quảng cáo lỗi";
                            }
                        }

                        else
                        {
                            msg = "Vị trí quảng cáo bạn chọn không hợp lệ ";
                        }

                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_quangcao", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }

    public void loadvitridatquangcao(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string key = context.Request["key"];
        if (session != null)
        {
            var danhsach = entity.tbl_VitriQuangCao.Where(m => m.type == key).ToList().Select(m => new
            {
                m.name,
                m.type,
                m.id_vitriquangcao,
                m.mota,
                m.show
            }).ToList();

            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }

    public void loadalllog(HttpContext context)
    {
        try
        {
            string log1 = "";
            string log2 = "";
            string kieulog = context.Request["idtype"];
            int idlog = int.Parse(context.Request["id"]);

            // phân trang
            int minrow = 0;
            int maxrow = 0;
            int.TryParse(context.Request["start"], out minrow);
            int length = 10;
            int.TryParse(context.Request["length"], out length);
            maxrow = (minrow + length);
            int draw = 0;
            int.TryParse(context.Request["draw"], out draw);
            int numberpage = maxrow / 10;
            // phân trang

            string tenbang = new Libs().getNameTaleLog();

            if (kieulog == "login")
            {
                log1 = "loginthatbai";
                log2 = "loginthanhcong";
            }
            else if (kieulog == "reset")
            {
                log1 = "resetmatkhauthatbai";
                log2 = "resetmatkhauthanhcong";
            }
            else if (kieulog == "addnew")
            {
                log1 = "themmoithongtinthatbai";
                log2 = "themmoithongtinthanhcong";
            }

            else if (kieulog == "update")
            {
                log1 = "suathongtinthatbai";
                log2 = "suathongtinthanhcong";
            }
            else if (kieulog == "delete")
            {
                log1 = "xoathongtinthatbai";
                log2 = "xoathongtinthanhcong";
            }
            else if (kieulog == "nguoidung")
            {
                log1 = "thaotacnguoidungthatbai";
                log2 = "nguoidungthaotacthanhcong";
            }

            if (session != null)
            {
                var danhsachsp = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id && m.trangthaitk == true && m.loaitaikhoan != 1).FirstOrDefault();
                if (danhsachsp != null)
                {
                    int idloai = danhsachsp.loaitaikhoan.Value;
                    var totalCount = new SqlParameter()
                    {
                        ParameterName = "@totalCount",
                        Value = 1,
                        Direction = System.Data.ParameterDirection.Output
                    };
                    var dangsach = entity.Database.SqlQuery<tbl_LogHeThong>(string.Format(@"exec [dbo].[sp_loalall_log] @idloai,@idlog,@sessionid,@type,@type2,@currPage,@recodperpage,@nametable,@totalCount output")
                        , new object[] { 
                          new SqlParameter("@idloai",idloai),
                           new SqlParameter("@idlog",idlog),
                           new SqlParameter("@sessionid",session.id), 
                           new SqlParameter("@type",log1),  
                           new SqlParameter("@type2",log2),
                           new SqlParameter("@currPage",numberpage),         
                           new SqlParameter("@recodperpage",10),
                           new SqlParameter("@nametable",tenbang.Trim()),
                           totalCount}).ToList().Select(zz => new
                        {

                            zz.id_loghethong,
                            id_taikhoan = (zz.id_taikhoan != null) ? zz.id_taikhoan : 0,
                            zz.noidung,
                            zz.ngaytao,
                            zz.type,
                            zz.tablename,
                            zz.vitrihoatdong,
                            ngaygio = zz.ngaytao.Value.ToString("dd/MM/yyyy HH:mm:ss"),
                            tenadmin = (zz.id_taikhoan != null) ? entity.TaiKhoan.Where(xx => xx.id_taikhoan == zz.id_taikhoan.Value).Select(xx => xx.tendaydu).FirstOrDefault() : "Ẩn danh",
                        }).ToList();
                    int total = 0;
                    int.TryParse(totalCount.Value.ToString(), out total);


                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(new
                    {
                        maxrow = maxrow,
                        minrow = minrow,
                        data = dangsach,
                        draw = (draw),
                        recordsFiltered = total,
                        recordsTotal = total
                    }, Formatting.Indented));
                }
            }
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = 0 }, Formatting.Indented));
        }
    }


    public void capnhatthongtinbieudo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.bieudo thongtincb = (Contructor.bieudo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.bieudo));

                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_BieuDo.Where(m => m.id_bieudo == thongtincb.id_bieudo && m.trangthai != 0).FirstOrDefault();
                        if (check != null)
                        {
                            var checkten = entity.tbl_BieuDo.Where(xx => xx.id_bieudo != check.id_bieudo && xx.tenbieudo == thongtincb.tenbieudo && xx.id_donvitg == thongtincb.id_donvitg && xx.id_loaibieudo == thongtincb.id_loaibieudo && xx.trangthai != 0).FirstOrDefault();
                            if (checkten == null)
                            {

                                string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_bieudo, check.id_donvitg, check.id_loaibieudo, check.tenbieudo, check.trangthai, check.tuthoigian, check.denthoigian }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });


                                check.tenbieudo = removeScriptAndCharacter.formatTextInput(thongtincb.tenbieudo);

                                if (thongtincb.trangthai == "hienthi")
                                {
                                    check.trangthai = 2;
                                }
                                else if (thongtincb.trangthai == "chiluu")
                                {
                                    check.trangthai = 1;
                                }
                                else
                                {
                                    check.trangthai = 1;
                                }

                                if (thongtincb.id_donvitg == 2 || thongtincb.id_donvitg == 3)
                                {
                                    check.tuthoigian = thongtincb.tuthoigian;
                                }
                                else if (thongtincb.id_donvitg == 1)
                                {
                                    check.tuthoigian = thongtincb.tuthoigian;
                                    check.denthoigian = thongtincb.denthoigian;
                                }

                                entity.SaveChanges();

                                tbl_BieuDo dataJsonParent = (tbl_BieuDo)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_BieuDo));
                                string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap());
                                int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_bieudo, check.id_donvitg, check.id_loaibieudo, check.tenbieudo, check.trangthai, check.tuthoigian, check.denthoigian } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                                sucess = true;
                                msg = "Cập nhật thông tin biểu đồ thành công";

                            }
                            else
                            {
                                msg = "Biểu đồ này đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = "Biểu đồ này không tồn tại trong hệ thống";

                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void xoabieudo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id_bieudo = 0;
        try
        {

            if (new Libs().checkDuLieuGuiLen(context.Request["id_bieudo"]))
            {
                //  int id_bieudo = int.Parse(context.Request["id_bieudo"]);
                int.TryParse(context.Request["id_bieudo"], out id_bieudo);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {

                        var checkbieudo = entity.tbl_BieuDo.Where(x => x.id_bieudo == id_bieudo).FirstOrDefault();

                        if (checkbieudo != null)
                        {
                            checkbieudo.trangthai = 0;
                            entity.SaveChanges();
                            sucess = true;

                            msg = "Xóa biểu đồ thành công !";
                            string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap()); // vitri
                            int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkbieudo.id_bieudo, checkbieudo.tenbieudo, checkbieudo.id_donvitg, checkbieudo.id_loaibieudo, checkbieudo.trangthai, checkbieudo.tuthoigian, checkbieudo.denthoigian } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlogxoahs);

                        }
                        else
                        {
                            msg = "Biểu đồ này không tồn tại !";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void loaddanhsachbieudo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_BieuDo.Where(m => m.trangthai != 0).ToList().OrderByDescending(m => m.id_bieudo).Select(m => new
            {
                m.id_bieudo,
                m.tenbieudo,
                m.trangthai,
                m.tuthoigian,
                m.denthoigian,
                m.id_loaibieudo,
                loaibieudo = m.tbl_Loaibieudo.tenloaibieudo,
                m.id_donvitg,
                donvitime = m.tbl_donvithoigianbieudo.tendonvi,
                button = new
                {
                    m.id_bieudo,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }



    public void themmoibieudothongke(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        tbl_BieuDo bieudo = new tbl_BieuDo();
        try
        {
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.bieudo thongtin = (Contructor.bieudo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.bieudo));
                        var checktontai = entity.tbl_BieuDo.Where(x => x.tenbieudo == thongtin.tenbieudo && x.id_loaibieudo == thongtin.id_loaibieudo && x.trangthai != 0).FirstOrDefault();
                        if (checktontai == null)
                        {
                            var checkloaibieudo = entity.tbl_Loaibieudo.Where(m => m.id_loaibieudo == thongtin.id_loaibieudo && m.trangthai == true).FirstOrDefault();
                            var checkdonvitime = entity.tbl_donvithoigianbieudo.Where(zz => zz.id_donvitg == thongtin.id_donvitg && zz.trangthai == true).FirstOrDefault();
                            if (checkloaibieudo != null)
                            {
                                if (checkdonvitime != null)
                                {
                                    bieudo.tenbieudo = removeScriptAndCharacter.formatTextInput(thongtin.tenbieudo);

                                    if (thongtin.trangthai == "hienthi")
                                    {
                                        bieudo.trangthai = 2;
                                    }
                                    else if (thongtin.trangthai == "chiluu")
                                    {
                                        bieudo.trangthai = 1;
                                    }
                                    else
                                    {
                                        bieudo.trangthai = 1;
                                    }
                                    bieudo.id_loaibieudo = thongtin.id_loaibieudo;
                                    bieudo.id_donvitg = thongtin.id_donvitg;

                                    if (thongtin.id_donvitg == 2 || thongtin.id_donvitg == 3)
                                    {
                                        bieudo.tuthoigian = thongtin.tuthoigian;
                                    }
                                    else if (thongtin.id_donvitg == 1)
                                    {
                                        bieudo.tuthoigian = thongtin.tuthoigian;
                                        bieudo.denthoigian = thongtin.denthoigian;
                                    }
                                    entity.tbl_BieuDo.Add(bieudo);
                                    entity.SaveChanges();

                                    suscess = true;
                                    msg = "Thêm mới biểu đồ vào hệ thống thành công ";
                                    string vitrihs = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap());
                                    int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { bieudo.id_bieudo, bieudo.id_donvitg, bieudo.id_loaibieudo, bieudo.tenbieudo, bieudo.trangthai, bieudo.tuthoigian, bieudo.denthoigian } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                    new Libs().updateKieuLogThemMoiThanhCong(idloghs);
                                }
                                else
                                {
                                    msg = "Đơn vị thời gian bạn chọn không tồn tại trong hệ thống ";
                                }
                            }
                            else
                            {
                                msg = "Loại biểu đồ bạn chọn không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = "Biểu đồ này đã tồn tại trong hệ thống";
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_BieuDo", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }

    public void loaddonvivebieudo(HttpContext context)
    {

        var danhsach = entity.tbl_donvithoigianbieudo.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_donvitg,
            m.tendonvi
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void loadloaibieudo(HttpContext context)
    {

        var danhsach = entity.tbl_Loaibieudo.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_loaibieudo,
            m.tenloaibieudo
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void themmoihinhthucphamtoi(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            tbl_Hinhthucphamtoi hinhthucpt = new tbl_Hinhthucphamtoi();
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.tblhinhthucphamtoi thongtin = (Contructor.tblhinhthucphamtoi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tblhinhthucphamtoi));

                        string ErrorCheck = new validateform().CallValidateThemMoiHinhThucPhamToi(thongtin.hinhthucphamtoi, thongtin.trangthaithongke);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_Hinhthucphamtoi.Where(x => x.hinhthucphamtoi == thongtin.hinhthucphamtoi && x.trangthai == true).FirstOrDefault();
                            if (checktontai == null)
                            {
                                hinhthucpt.hinhthucphamtoi = removeScriptAndCharacter.formatTextInput(thongtin.hinhthucphamtoi);
                                hinhthucpt.trangthai = true;
                                if (thongtin.trangthaithongke == "codung")
                                {
                                    hinhthucpt.trangthaithongke = true;
                                }
                                else if (thongtin.trangthaithongke == "khongdung")
                                {
                                    hinhthucpt.trangthaithongke = false;
                                }
                                else
                                {
                                    hinhthucpt.trangthaithongke = true;
                                }

                                entity.tbl_Hinhthucphamtoi.Add(hinhthucpt);
                                entity.SaveChanges();

                                suscess = true;
                                msg = "Thêm mới hình thức phạm tội vào hệ thống thành công ";
                                string vitrihs = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap());
                                int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hinhthucpt.id_hinhthucphamtoi, hinhthucpt.hinhthucphamtoi, hinhthucpt.trangthai, hinhthucpt.trangthaithongke } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                new Libs().updateKieuLogThemMoiThanhCong(idloghs);
                            }
                            else
                            {
                                msg = "Hình thức phạm tội này đã tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void capnhatthongtinhinhthucphamtoi(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.tblhinhthucphamtoi thongtincb = (Contructor.tblhinhthucphamtoi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tblhinhthucphamtoi));

                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        string ErrorCheck = new validateform().CallValidateThemMoiHinhThucPhamToi(thongtincb.hinhthucphamtoi, thongtincb.trangthaithongke);

                        if (ErrorCheck == null)
                        {
                            var check = entity.tbl_Hinhthucphamtoi.Where(m => m.id_hinhthucphamtoi == thongtincb.id_hinhthucphamtoi && m.trangthai == true).FirstOrDefault();
                            if (check != null)
                            {
                                var checkten = entity.tbl_Hinhthucphamtoi.Where(xx => xx.id_hinhthucphamtoi != check.id_hinhthucphamtoi && xx.hinhthucphamtoi == thongtincb.hinhthucphamtoi && xx.trangthai == true).FirstOrDefault();
                                if (checkten == null)
                                {
                                    string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_hinhthucphamtoi, check.hinhthucphamtoi, check.trangthai, check.trangthaithongke }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    check.hinhthucphamtoi = removeScriptAndCharacter.formatTextInput(thongtincb.hinhthucphamtoi);

                                    if (thongtincb.trangthaithongke == "codung")
                                    {
                                        check.trangthaithongke = true;
                                    }
                                    else if (thongtincb.trangthaithongke == "khongdung")
                                    {
                                        check.trangthaithongke = false;
                                    }
                                    else
                                    {
                                        check.trangthaithongke = true;
                                    }

                                    entity.SaveChanges();

                                    tbl_Hinhthucphamtoi dataJsonParent = (tbl_Hinhthucphamtoi)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_Hinhthucphamtoi));
                                    string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap());
                                    int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_hinhthucphamtoi, check.hinhthucphamtoi, check.trangthai, check.trangthaithongke } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                                    sucess = true;
                                    msg = "Cập nhật thông tin hình thức hiển thị thành công";

                                }
                                else
                                {
                                    msg = "Tên này đã tồn tại trong hệ thống ";
                                }
                            }
                            else
                            {
                                msg = "Hình thức phạm tội này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }

    public void xoahinhthucphamtoi(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_hinhthucphamtoi"]))
            {
                int id_hinhthucphamtoi = 0;
                int.TryParse(context.Request["id_hinhthucphamtoi"], out id_hinhthucphamtoi);
                ///   int.Parse(context.Request["id_hinhthucphamtoi"]);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {

                        var checktienan = entity.tbl_Hinhthucphamtoi.Where(x => x.id_hinhthucphamtoi == id_hinhthucphamtoi).FirstOrDefault();

                        if (checktienan != null)
                        {
                            checktienan.trangthai = false;
                            entity.SaveChanges();
                            sucess = true;

                            msg = "Xóa hình thức phạm tội thành công !";
                            string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap()); // vitri
                            int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checktienan.id_hinhthucphamtoi, checktienan.hinhthucphamtoi, checktienan.trangthai, checktienan.trangthaithongke } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlogxoahs);

                        }
                        else
                        {
                            msg = "Hình thức phạm tội này không tồn tại !";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_Hinhthucphamtoi", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void loadallHinhThucPhamToi(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_Hinhthucphamtoi.Where(m => m.trangthai == true).ToList().OrderByDescending(m => m.id_hinhthucphamtoi).Select(m => new
            {
                m.id_hinhthucphamtoi,
                m.hinhthucphamtoi,
                m.trangthai,
                m.trangthaithongke,
                button = new
                {
                    m.id_hinhthucphamtoi,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }



    public void capnhatthongtinhosoantoipham(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.thongtintoipham thongtincb = (Contructor.thongtintoipham)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtintoipham));

                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        string ErrorCheck = new validateform().CallValidateThemMoiHoSoToiPham(thongtincb.id_hinhthucphamtoi, thongtincb.ngayluuhoso, thongtincb.tinhtranghoso);

                        if (ErrorCheck == null)
                        {
                            var check = entity.tbl_Hosovuan.Where(m => m.id_hoso == thongtincb.id_hoso && m.id_toipham == thongtincb.id_toipham && m.tinhtranghoso != 0).FirstOrDefault();
                            if (check != null)
                            {

                                string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_hoso, check.id_toipham, check.id_hinhthucphamtoi, check.ngayluuhoso, check.tinhtranghoso }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                check.ngayluuhoso = DateTime.Parse(thongtincb.ngayluuhoso);
                                check.id_hinhthucphamtoi = thongtincb.id_hinhthucphamtoi;

                                if (thongtincb.tinhtranghoso == "dathuan")
                                {
                                    check.tinhtranghoso = 2;
                                }
                                else if (thongtincb.tinhtranghoso == "chuathuan")
                                {
                                    check.tinhtranghoso = 1;
                                }
                                else
                                {
                                    check.tinhtranghoso = 0;
                                }

                                entity.SaveChanges();

                                tbl_Hosovuan dataJsonParent = (tbl_Hosovuan)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_Hosovuan));
                                string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap());
                                int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_hoso, check.id_toipham, check.id_hinhthucphamtoi, check.ngayluuhoso, check.tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                                sucess = true;
                                msg = "Cập nhật hồ sơ án tội phạm thành công";
                            }
                            else
                            {
                                msg = "Hồ sơ án tội phạm này không tồn tại ";

                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void xoahosoancuatoipham(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id_hoso = 0, id_toipham = 0;
        try
        {

            if (new Libs().checkDuLieuGuiLen(context.Request["id_hoso"]) && new Libs().checkDuLieuGuiLen(context.Request["id_toipham"]))
            {
                //int id_hoso = int.Parse(context.Request["id_hoso"]);
                //int id_toipham = int.Parse(context.Request["id_toipham"]);

                int.TryParse(context.Request["id_hoso"], out id_hoso);
                int.TryParse(context.Request["id_toipham"], out id_toipham);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {

                        var checktienan = entity.tbl_Hosovuan.Where(x => x.id_toipham == id_toipham && x.id_hoso == id_hoso && x.tinhtranghoso != 0).FirstOrDefault();

                        if (checktienan != null)
                        {
                            checktienan.tinhtranghoso = 0;
                            entity.SaveChanges();
                            sucess = true;

                            msg = "Xóa hồ sơ án tội phạm thành công !";
                            string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap()); // vitri
                            int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checktienan.id_hoso, checktienan.id_toipham, checktienan.id_hinhthucphamtoi, checktienan.ngayluuhoso, checktienan.tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlogxoahs);

                        }
                        else
                        {
                            msg = "Thông tin về hồ sơ án này không chính xác !";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void themmoihosoancuatoipham(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        try
        {
            tbl_Hosovuan hosovuan = new tbl_Hosovuan();
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.thongtintoipham thongtin = (Contructor.thongtintoipham)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtintoipham));

                        string ErrorCheck = new validateform().CallValidateThemMoiHoSoToiPham(thongtin.id_hinhthucphamtoi, thongtin.ngayluuhoso, thongtin.tinhtranghoso);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_Thongtintoipham.Where(x => x.id_toipham == thongtin.id_toipham && x.trangthai == true).FirstOrDefault();
                            if (checktontai != null)
                            {
                                var checkhinhthucphamtoi = entity.tbl_Hinhthucphamtoi.Where(m => m.id_hinhthucphamtoi == thongtin.id_hinhthucphamtoi && m.trangthai == true).FirstOrDefault();
                                if (checkhinhthucphamtoi != null)
                                {

                                    hosovuan.id_toipham = thongtin.id_toipham;
                                    hosovuan.id_hinhthucphamtoi = thongtin.id_hinhthucphamtoi;
                                    hosovuan.ngayluuhoso = DateTime.Parse(thongtin.ngayluuhoso);
                                    if (thongtin.tinhtranghoso == "dathuan")
                                    {
                                        hosovuan.tinhtranghoso = 2;
                                    }
                                    else if (thongtin.tinhtranghoso == "chuathuan")
                                    {
                                        hosovuan.tinhtranghoso = 1;
                                    }
                                    else
                                    {
                                        hosovuan.tinhtranghoso = 0;
                                    }

                                    entity.tbl_Hosovuan.Add(hosovuan);
                                    entity.SaveChanges();

                                    suscess = true;
                                    msg = "Thêm mới hồ sơ án vào hệ thống thành công ";
                                    string vitrihs = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap());
                                    int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hosovuan.id_hoso, hosovuan.id_toipham, hosovuan.id_hinhthucphamtoi, hosovuan.ngayluuhoso, hosovuan.tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                    new Libs().updateKieuLogThemMoiThanhCong(idloghs);

                                }
                                else
                                {
                                    msg = "Hình thức phạm tội không tồn tại ";
                                }
                            }
                            else
                            {
                                msg = "Tội phạm bạn chọn không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }
    public void capnhatthongtincanhantoipham(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.thongtintoipham thongtincb = (Contructor.thongtintoipham)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtintoipham));

                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        string ErrorCheck = new validateform().CallValidateUpdateThongTinToiPham(thongtincb.hoten, thongtincb.ngaysinh, thongtincb.sochungminhthu, thongtincb.hokhauthuongtru, thongtincb.quequan);

                        if (ErrorCheck == null)
                        {
                            var check = entity.tbl_Thongtintoipham.Where(m => m.id_toipham == thongtincb.id_toipham && m.trangthai == true).FirstOrDefault();
                            if (check != null)
                            {
                                var checkten = entity.tbl_Thongtintoipham.Where(x => (x.id_toipham != check.id_toipham) && (x.sochungminhthu == thongtincb.sochungminhthu) && (x.trangthai == true)).FirstOrDefault();

                                if (checkten == null)
                                {
                                    string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_toipham, check.hoten, check.hokhauthuongtru, check.hinhanh, check.sochungminhthu, check.quequan, check.bietdanh, check.ngaysinh, check.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    check.hoten = removeScriptAndCharacter.formatTextInput(thongtincb.hoten);
                                    check.hokhauthuongtru = removeScriptAndCharacter.formatTextInput(thongtincb.hokhauthuongtru);
                                    check.sochungminhthu = thongtincb.sochungminhthu;
                                    check.quequan = removeScriptAndCharacter.formatTextInput(thongtincb.quequan);
                                    check.bietdanh = removeScriptAndCharacter.formatTextInput(thongtincb.bietdanh);
                                    check.ngaysinh = DateTime.Parse(thongtincb.ngaysinh);
                                    if (thongtincb.hinhanh != "")
                                    {
                                        check.hinhanh = removeScriptAndCharacter.formatTextInput(thongtincb.hinhanh);
                                    }
                                    entity.SaveChanges();

                                    tbl_Thongtintoipham dataJsonParent = (tbl_Thongtintoipham)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_Thongtintoipham));
                                    string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap());
                                    int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_toipham, check.hoten, check.hinhanh, check.hokhauthuongtru, check.sochungminhthu, check.quequan, check.bietdanh, check.ngaysinh, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                                    sucess = true;
                                    msg = "Cập nhật thông cá nhân tội phạm thành công";

                                }
                                else
                                {
                                    msg = "Trùng thông tin tội phạm";
                                }
                            }
                            else
                            {
                                msg = "Thông tin tội phạm này không tồn tại ";

                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }



    public void xoathongtintoipham(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id_toipham = 0;
        try
        {

            if (new Libs().checkDuLieuGuiLen(context.Request["id_toipham"]))
            {
                //   int id_toipham = int.Parse(context.Request["id_toipham"]);
                int.TryParse(context.Request["id_toipham"], out id_toipham);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_Thongtintoipham.Where(m => m.id_toipham == id_toipham).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = false;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Xóa thông tin tội phạm thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_toipham, check.hoten, check.hokhauthuongtru, check.sochungminhthu, check.quequan, check.bietdanh, check.ngaysinh, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlog);


                            var checktienan = entity.tbl_Hosovuan.Where(x => x.id_toipham == id_toipham && x.tinhtranghoso != 0).ToList();

                            if (checktienan != null)
                            {
                                for (int i = 0; i < checktienan.Count; i++)
                                {
                                    checktienan[i].tinhtranghoso = 0;
                                    entity.SaveChanges();

                                    string vitrixoahs = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap()); // vitri
                                    int idlogxoahs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checktienan[i].id_hoso, checktienan[i].id_hinhthucphamtoi, checktienan[i].id_toipham, checktienan[i].ngayluuhoso, checktienan[i].tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoahs); // luu log lan 1
                                    new Libs().updateKieuLogXoaThanhCong(idlogxoahs);
                                }
                            }
                            else
                            {
                                msg = "Xóa thông tin tội phạm thành công !";
                            }
                        }
                        else
                        {
                            msg = "Thông tin tội phạm này không tồn tại trong hệ thống";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void loaddanhsachtoipham(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_Thongtintoipham.Where(m => ((id == 0) ? true : m.id_toipham == id) && m.trangthai == true).Select(m => new
            {
                m.id_toipham,
                m.hoten,
                m.hokhauthuongtru,
                m.sochungminhthu,
                m.quequan,
                m.bietdanh,
                ngaysinh = m.ngaysinh,
                m.trangthai,
                m.hinhanh,
                danhsachan = entity.tbl_Hosovuan.Where(x => x.id_toipham.Value == m.id_toipham && x.tinhtranghoso != 0).Select(x => new
                {
                    x.id_hoso,
                    x.id_hinhthucphamtoi,
                    hinhthucphamtoi = x.tbl_Hinhthucphamtoi.hinhthucphamtoi,
                    ngayluuhoso = x.ngayluuhoso,
                    x.tinhtranghoso,
                    button = new
                    {
                        x.id_hoso,
                        m.id_toipham,
                        cn.xem,
                        cn.them,
                        cn.sua,
                        cn.xoa
                    }
                }),
                soan = entity.tbl_Hosovuan.Where(x => x.id_toipham.Value == m.id_toipham && x.tinhtranghoso != 0).Count(),
                button = new
                {
                    m.id_toipham,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList().OrderByDescending(m => m.soan);
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }




    // bảng hồ sơ vụ án :  tinhtranghoso:0 = xóa , 1=chưa thụ án , 2 = đã thụ án
    public void themmoithongtintoipham(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        tbl_Thongtintoipham thongtintoipham = new tbl_Thongtintoipham();
        tbl_Hosovuan hosovuan = new tbl_Hosovuan();
        try
        {
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.thongtintoipham thongtin = (Contructor.thongtintoipham)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtintoipham));

                        string ErrorCheck = new validateform().CallValidateThemMoiToiPham(thongtin.hoten, thongtin.ngaysinh, thongtin.sochungminhthu, thongtin.hokhauthuongtru, thongtin.quequan, thongtin.id_hinhthucphamtoi, thongtin.ngayluuhoso, thongtin.tinhtranghoso);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_Thongtintoipham.Where(x => x.hoten == thongtin.hoten && x.sochungminhthu == thongtin.sochungminhthu && x.trangthai == true).FirstOrDefault();
                            if (checktontai == null)
                            {
                                var checkhinhthucphamtoi = entity.tbl_Hinhthucphamtoi.Where(m => m.id_hinhthucphamtoi == thongtin.id_hinhthucphamtoi && m.trangthai == true).FirstOrDefault();
                                if (checkhinhthucphamtoi != null)
                                {

                                    thongtintoipham.hoten = removeScriptAndCharacter.formatTextInput(thongtin.hoten);
                                    thongtintoipham.hokhauthuongtru = removeScriptAndCharacter.formatTextInput(thongtin.hokhauthuongtru);
                                    thongtintoipham.sochungminhthu = thongtin.sochungminhthu;
                                    thongtintoipham.quequan = removeScriptAndCharacter.formatTextInput(thongtin.quequan);
                                    thongtintoipham.bietdanh = removeScriptAndCharacter.formatTextInput(thongtin.bietdanh);
                                    thongtintoipham.ngaysinh = DateTime.Parse(thongtin.ngaysinh);
                                    thongtintoipham.trangthai = true;
                                    if (thongtin.hinhanh != "")
                                    {
                                        thongtintoipham.hinhanh = removeScriptAndCharacter.formatTextInput(thongtin.hinhanh);
                                    }

                                    entity.tbl_Thongtintoipham.Add(thongtintoipham);
                                    entity.SaveChanges();


                                    string vitritp = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap());
                                    int idlogtp = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { thongtintoipham.id_toipham, thongtintoipham.hoten, thongtintoipham.hokhauthuongtru, thongtintoipham.sochungminhthu, thongtintoipham.quequan, thongtintoipham.bietdanh, thongtintoipham.ngaysinh, thongtintoipham.trangthai, thongtintoipham.hinhanh } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitritp);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlogtp);

                                    msg = "Thêm mới thông tin tội phạm thành công";

                                    hosovuan.id_toipham = thongtintoipham.id_toipham;
                                    hosovuan.id_hinhthucphamtoi = thongtin.id_hinhthucphamtoi;
                                    hosovuan.ngayluuhoso = DateTime.Parse(thongtin.ngayluuhoso);
                                    if (thongtin.tinhtranghoso == "dathuan")
                                    {
                                        hosovuan.tinhtranghoso = 2;
                                    }
                                    else if (thongtin.tinhtranghoso == "chuathuan")
                                    {
                                        hosovuan.tinhtranghoso = 1;
                                    }
                                    else
                                    {
                                        hosovuan.tinhtranghoso = 0;
                                    }

                                    entity.tbl_Hosovuan.Add(hosovuan);
                                    entity.SaveChanges();

                                    suscess = true;
                                    msg = "Thêm mới thông tin tội phạm và hồ sơ vào hệ thống thành công ";
                                    string vitrihs = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap());
                                    int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hosovuan.id_hoso, hosovuan.id_toipham, hosovuan.id_hinhthucphamtoi, hosovuan.ngayluuhoso, hosovuan.tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                    new Libs().updateKieuLogThemMoiThanhCong(idloghs);

                                }
                                else
                                {
                                    msg = "Hình thức phạm tội không tồn tại ";
                                }
                            }
                            else
                            {
                                var checkhinhthucphamtoi = entity.tbl_Hinhthucphamtoi.Where(m => m.id_hinhthucphamtoi == thongtin.id_hinhthucphamtoi && m.trangthai == true).FirstOrDefault();
                                if (checkhinhthucphamtoi != null)
                                {

                                    hosovuan.id_toipham = checktontai.id_toipham;
                                    hosovuan.id_hinhthucphamtoi = thongtin.id_hinhthucphamtoi;
                                    hosovuan.ngayluuhoso = DateTime.Parse(thongtin.ngayluuhoso);
                                    if (thongtin.tinhtranghoso == "dathuan")
                                    {
                                        hosovuan.tinhtranghoso = 2;
                                    }
                                    else if (thongtin.tinhtranghoso == "chuathuan")
                                    {
                                        hosovuan.tinhtranghoso = 1;
                                    }
                                    else
                                    {
                                        hosovuan.tinhtranghoso = 0;
                                    }

                                    entity.tbl_Hosovuan.Add(hosovuan);
                                    entity.SaveChanges();

                                    suscess = true;
                                    msg = "Tội phạm này đã tồn tại trong hệ thống, thêm mới hồ sơ vào hệ thống thành công ";
                                    string vitrihs = new Libs().VitriTruyCapVaIP("tbl_Hosovuan", new Libs().ThietBiTruyCap());
                                    int idloghs = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hosovuan.id_hoso, hosovuan.id_toipham, hosovuan.id_hinhthucphamtoi, hosovuan.ngayluuhoso, hosovuan.tinhtranghoso } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrihs);
                                    new Libs().updateKieuLogThemMoiThanhCong(idloghs);

                                }
                                else
                                {
                                    msg = "Hình thức phạm tội bạn chọn không tồn tại trong hệ thống";
                                }
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_Thongtintoipham", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }



    public void loadhinhthucphamtoi(HttpContext context)
    {

        var danhsach = entity.tbl_Hinhthucphamtoi.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_hinhthucphamtoi,
            m.hinhthucphamtoi
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }
    public void capnhatthongtincauhoithamdoykien(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            tbl_DapAnThamDo dapan = new tbl_DapAnThamDo();
            tbl_LichHienThiThamDoYKien lichhienthi = new tbl_LichHienThiThamDoYKien();
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) || new Libs().checkDuLieuGuiLen(context.Request["listDapAn"]))
            {

                Contructor.cauhoithamdoykien thongtincb = (Contructor.cauhoithamdoykien)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.cauhoithamdoykien));
                List<string> listDapAn = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listDapAn"], typeof(List<string>));
                List<int> listXoa = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listXoa"], typeof(List<int>));

                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_ThamDoYKien.Where(m => m.id_cauhoithamdo == thongtincb.id_cauhoithamdo).FirstOrDefault();
                        if (check != null)
                        {
                            string ErrorCheck = new validateform().CallValidateThemMoiCauHoiThamDo(thongtincb.cauhoi, thongtincb.id_hinhthuctraloi, listDapAn, thongtincb.trangthai, thongtincb.tungay, thongtincb.denngay, thongtincb.ngayketthuc);

                            if (ErrorCheck == null)
                            {
                                var checkten = entity.tbl_ThamDoYKien.Where(x => x.id_cauhoithamdo != thongtincb.id_cauhoithamdo && x.id_hinhthuctraloi == thongtincb.id_hinhthuctraloi && x.cauhoi == thongtincb.cauhoi && x.trangthai != 0).FirstOrDefault();

                                if (checkten == null)
                                {
                                    string jsonDuLieuCuParent = JsonConvert.SerializeObject(new { check.id_cauhoithamdo, check.cauhoi, check.id_hinhthuctraloi, check.id_taikhoan, check.id_lich, check.trangthai, check.tongsocautraloi }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    //xoa dap an
                                    int iddapan = 0;
                                    if (listXoa.Count > 0)
                                    {
                                        for (int i = 0; i < listXoa.Count; i++)
                                        {
                                            iddapan = listXoa[i];
                                            var checkdapntheoid = entity.tbl_DapAnThamDo.Where(xx => xx.id_dapanthamdo == iddapan).FirstOrDefault();
                                            if (checkdapntheoid != null)
                                            {
                                                checkdapntheoid.trangthai = false;
                                                entity.SaveChanges();

                                                sucess = true;
                                                msg = "Xóa đáp án thành công";

                                                string vitrixoa = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                                                int idlogxoa = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkdapntheoid.id_dapanthamdo, checkdapntheoid.noidungtraloi, checkdapntheoid.id_cauhoithamdo, checkdapntheoid.demcautraloi, checkdapntheoid.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrixoa);
                                                new Libs().updateKieuLogXoaThanhCong(idlogxoa);
                                            }
                                            else
                                            {
                                                msg = "Đáp án không tồn tại";
                                            }
                                        }
                                    }


                                    // theem cau tra loi
                                    string traloi = "";

                                    if (listDapAn.Count > 0)
                                    {
                                        for (int i = 0; i < listDapAn.Count; i++)
                                        {
                                            traloi = removeScriptAndCharacter.formatTextInput(listDapAn[i]);
                                            var checkdapantontai = entity.tbl_DapAnThamDo.Where(xx => xx.id_cauhoithamdo == check.id_cauhoithamdo && xx.noidungtraloi == traloi).FirstOrDefault();
                                            if (checkdapantontai == null)
                                            {
                                                dapan.noidungtraloi = traloi;
                                                dapan.id_cauhoithamdo = check.id_cauhoithamdo;
                                                dapan.demcautraloi = 0;
                                                dapan.trangthai = true;

                                                entity.tbl_DapAnThamDo.Add(dapan);
                                                entity.SaveChanges();

                                                sucess = true;
                                                msg = "Thêm mới đáp án thành công";
                                                string vitri2 = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                                                int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { dapan.id_dapanthamdo, dapan.noidungtraloi, dapan.id_cauhoithamdo, dapan.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                                new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                            }
                                            else
                                            {
                                                msg = "Đáp án đã tồn tại";
                                            }
                                        }
                                    }

                                    var checkhinhthuctraloi = entity.tbl_HinhthucTraLoi.Where(m => m.id_hinhthuctraloi == thongtincb.id_hinhthuctraloi && m.trangthai == true).FirstOrDefault();
                                    if (checkhinhthuctraloi != null)
                                    {

                                        if (check.id_lich == null)
                                        {
                                            if (thongtincb.trangthai == "hienthi")
                                            {

                                                DateTime dt = Convert.ToDateTime(thongtincb.ngayketthuc);
                                                string kaka = string.Format("{0}-{1}-{2} {3}:{4}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute);
                                                DateTime dateVal = DateTime.Parse(kaka);

                                                lichhienthi.tungay = DateTime.Now;
                                                lichhienthi.denngay = dateVal;
                                                lichhienthi.trangthai = true;

                                                entity.tbl_LichHienThiThamDoYKien.Add(lichhienthi);
                                                entity.SaveChanges();

                                                check.id_lich = lichhienthi.id_lich;
                                                string vitrilich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                                int idloglich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { lichhienthi.id_lich, lichhienthi.tungay, lichhienthi.denngay, lichhienthi.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrilich);
                                                new Libs().updateKieuLogThemMoiThanhCong(idloglich);

                                            }
                                            else if (thongtincb.trangthai == "datlich")
                                            {
                                                DateTime dttungay = Convert.ToDateTime(thongtincb.tungay);
                                                string starDate = string.Format("{0}-{1}-{2} {3}:{4}", dttungay.Year, dttungay.Month, dttungay.Day, dttungay.Hour, dttungay.Minute);
                                                DateTime dateValTuNgay = DateTime.Parse(starDate);

                                                DateTime dtdenngay = Convert.ToDateTime(thongtincb.denngay);
                                                string endDate = string.Format("{0}-{1}-{2} {3}:{4}", dtdenngay.Year, dtdenngay.Month, dtdenngay.Day, dtdenngay.Hour, dtdenngay.Minute);
                                                DateTime dateValDenNgay = DateTime.Parse(endDate);

                                                lichhienthi.tungay = dateValTuNgay;
                                                lichhienthi.denngay = dateValDenNgay;
                                                lichhienthi.trangthai = true;

                                                entity.tbl_LichHienThiThamDoYKien.Add(lichhienthi);
                                                entity.SaveChanges();

                                                check.id_lich = lichhienthi.id_lich;
                                                string vitrilich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                                int idloglich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { lichhienthi.id_lich, lichhienthi.tungay, lichhienthi.denngay, lichhienthi.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrilich);
                                                new Libs().updateKieuLogThemMoiThanhCong(idloglich);
                                            }
                                            else
                                            {
                                                msg = "Không có lịch";
                                            }
                                        }
                                        else
                                        {
                                            var checklich = entity.tbl_LichHienThiThamDoYKien.Where(mm => mm.id_lich == check.id_lich && mm.trangthai == true).FirstOrDefault();
                                            if (checklich != null)
                                            {
                                                /// thêm lịch hiển thị
                                                if (thongtincb.trangthai == "hienthi")
                                                {
                                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { checklich.id_lich, checklich.tungay, checklich.denngay, checklich.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                                    DateTime dt = Convert.ToDateTime(thongtincb.ngayketthuc);
                                                    string kaka = string.Format("{0}-{1}-{2} {3}:{4}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute);
                                                    DateTime dateVal = DateTime.Parse(kaka);

                                                    checklich.denngay = dateVal;

                                                    entity.SaveChanges();

                                                    check.id_lich = checklich.id_lich;
                                                    tbl_LichHienThiThamDoYKien dataJson = (tbl_LichHienThiThamDoYKien)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_LichHienThiThamDoYKien));
                                                    string vitriupdatelich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                                    int idlogupdatelich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checklich.id_lich, checklich.tungay, checklich.denngay, checklich.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatelich);
                                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatelich);
                                                }
                                                else if (thongtincb.trangthai == "datlich")
                                                {

                                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { checklich.id_lich, checklich.tungay, checklich.denngay, checklich.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                                    DateTime dttungay = Convert.ToDateTime(thongtincb.tungay);
                                                    string starDate = string.Format("{0}-{1}-{2} {3}:{4}", dttungay.Year, dttungay.Month, dttungay.Day, dttungay.Hour, dttungay.Minute);
                                                    DateTime dateValTuNgay = DateTime.Parse(starDate);

                                                    DateTime dtdenngay = Convert.ToDateTime(thongtincb.denngay);
                                                    string endDate = string.Format("{0}-{1}-{2} {3}:{4}", dtdenngay.Year, dtdenngay.Month, dtdenngay.Day, dtdenngay.Hour, dtdenngay.Minute);
                                                    DateTime dateValDenNgay = DateTime.Parse(endDate);

                                                    checklich.tungay = dateValTuNgay;
                                                    checklich.denngay = dateValDenNgay;

                                                    entity.SaveChanges();

                                                    check.id_lich = checklich.id_lich;
                                                    tbl_LichHienThiThamDoYKien dataJson = (tbl_LichHienThiThamDoYKien)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_LichHienThiThamDoYKien));
                                                    string vitriupdatelich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                                    int idlogupdatelich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checklich.id_lich, checklich.tungay, checklich.denngay, checklich.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatelich);
                                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatelich);

                                                }
                                                else
                                                {
                                                    msg = "Không có lịch";
                                                }
                                            }
                                        }



                                        /// update cau hoi tham do

                                        check.cauhoi = removeScriptAndCharacter.formatTextInput(thongtincb.cauhoi);
                                        check.id_hinhthuctraloi = thongtincb.id_hinhthuctraloi;

                                        if (thongtincb.trangthai == "hienthi")
                                        {
                                            check.trangthai = 2;
                                        }
                                        else if (thongtincb.trangthai == "datlich")
                                        {
                                            check.trangthai = 3;
                                        }
                                        else
                                        {
                                            check.trangthai = 1;
                                        }

                                        entity.SaveChanges();

                                        tbl_ThamDoYKien dataJsonParent = (tbl_ThamDoYKien)JsonConvert.DeserializeObject(jsonDuLieuCuParent, typeof(tbl_ThamDoYKien));
                                        string vitriupdatecauhoi = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap());
                                        int idlogupdatecauhoi = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJsonParent, dulieumoi = new { check.id_cauhoithamdo, check.cauhoi, check.id_hinhthuctraloi, check.id_taikhoan, check.id_lich, check.trangthai, check.tongsocautraloi } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriupdatecauhoi);
                                        new Libs().updateKieuLogSuaThongTinThanhCong(idlogupdatecauhoi);

                                        sucess = true;
                                        msg = "Cập nhật thông tin câu hỏi thăm dò thành công";
                                    }
                                    else
                                    {
                                        msg = "Hình thức trả lời này không tồn tại";
                                    }

                                }
                                else
                                {
                                    msg = "Câu hỏi này đã tồn tại";
                                }
                            }
                            else
                            {
                                msg = ErrorCheck;
                            }
                        }
                        else
                        {
                            msg = "Câu hỏi thăm dò này không tồn tại ";

                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
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

    public void xoaphieuthamdoykien(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_cauhoithamdo"]))
            {
                int id_cauhoithamdo = client.ToInt(context.Request["id_cauhoithamdo"]);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_ThamDoYKien.Where(m => m.id_cauhoithamdo == id_cauhoithamdo).FirstOrDefault();
                        if (check != null)
                        {

                            if (check.id_lich != null)
                            {
                                var checklick = entity.tbl_LichHienThiThamDoYKien.Where(xx => xx.id_lich == check.id_lich).FirstOrDefault();
                                if (checklick != null)
                                {
                                    checklick.trangthai = false;
                                    entity.SaveChanges();
                                    string vitrichecklich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap()); // vitri
                                    int idlogchecklich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checklick.id_lich, checklick.tungay, checklick.denngay, checklick.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrichecklich); // luu log lan 1
                                    new Libs().updateKieuLogXoaThanhCong(idlogchecklich);
                                }
                                else
                                {
                                    msg = "Lịch không tồn tại";
                                }
                            }
                            var checkdapan = entity.tbl_DapAnThamDo.Where(mm => mm.id_cauhoithamdo == check.id_cauhoithamdo).ToList();
                            if (checkdapan.Count > 0)
                            {
                                for (int i = 0; i < checkdapan.Count; i++)
                                {
                                    checkdapan[i].trangthai = false;
                                    entity.SaveChanges();

                                    string vitridapan = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap()); // vitri
                                    int idlogdapan = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkdapan[i].id_dapanthamdo, checkdapan[i].noidungtraloi, checkdapan[i].id_cauhoithamdo, checkdapan[i].demcautraloi, checkdapan[i].trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitridapan); // luu log lan 1
                                    new Libs().updateKieuLogXoaThanhCong(idlogdapan);
                                }
                            }
                            else
                            {
                                msg = "Không có đáp án";
                            }


                            check.trangthai = 0;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Xóa phiếu thăm dò ý kiến thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_cauhoithamdo, check.cauhoi, check.id_hinhthuctraloi, check.id_taikhoan, check.id_lich, check.trangthai, check.tongsocautraloi } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Phiếu thăm dò này không tồn tại trong hệ thống";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitriFail = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap()); // vitri
                int idlogFail = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitriFail); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlogFail);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }




    public void loaddanhsachcauhoithamdoykien(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            DateTime dateResult1;
            DateTime dateResult2;
            System.Globalization.CultureInfo culture;
            System.Globalization.DateTimeStyles styles;

            culture = System.Globalization.CultureInfo.CreateSpecificCulture("en-US");
            styles = System.Globalization.DateTimeStyles.None;

            var danhsach = entity.tbl_ThamDoYKien.Where(m => ((id == 0) ? true : m.id_cauhoithamdo == id) && m.trangthai != 0).ToList().OrderByDescending(m => m.id_cauhoithamdo).Select(m => new
            {
                m.id_cauhoithamdo,
                m.cauhoi,
                m.id_hinhthuctraloi,
                hinhthuctraloi = m.tbl_HinhthucTraLoi.hinhthuctraloi,
                m.id_taikhoan,
                m.id_lich,
                m.trangthai,
                m.tongsocautraloi,
                ngaybatdau = (m.id_lich != null) ? (m.tbl_LichHienThiThamDoYKien.tungay) : null,
                ngayketthuc = (m.id_lich != null) ? m.tbl_LichHienThiThamDoYKien.denngay : null,
                danhsachdapan = entity.tbl_DapAnThamDo.Where(x => x.id_cauhoithamdo.Value == m.id_cauhoithamdo && x.trangthai == true).Select(x => new
                {
                    x.id_dapanthamdo,
                    x.noidungtraloi,
                    x.demcautraloi
                }),
                button = new
                {
                    m.id_cauhoithamdo,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }

    public void themmoicauhoithamdoykien(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        int idlich = 0;
        try
        {
            tbl_ThamDoYKien cauhoithamdo = new tbl_ThamDoYKien();
            tbl_LichHienThiThamDoYKien lichhienthi = new tbl_LichHienThiThamDoYKien();
            tbl_DapAnThamDo dapanthamdo = new tbl_DapAnThamDo();

            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["listDapAn"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.cauhoithamdoykien thongtin = (Contructor.cauhoithamdoykien)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.cauhoithamdoykien));
                        List<string> listDapAn = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listDapAn"], typeof(List<string>));

                        var checktontai = entity.tbl_ThamDoYKien.Where(x => x.cauhoi == thongtin.cauhoi && x.id_hinhthuctraloi == thongtin.id_hinhthuctraloi && x.trangthai != 0).FirstOrDefault();
                        if (checktontai == null)
                        {
                            var checkhinhthuctraloi = entity.tbl_HinhthucTraLoi.Where(m => m.id_hinhthuctraloi == thongtin.id_hinhthuctraloi && m.trangthai == true).FirstOrDefault();
                            if (checkhinhthuctraloi != null)
                            {
                                string ErrorCheck = new validateform().CallValidateThemMoiCauHoiThamDo(thongtin.cauhoi, thongtin.id_hinhthuctraloi, listDapAn, thongtin.trangthai, thongtin.tungay, thongtin.denngay, thongtin.ngayketthuc);

                                if (ErrorCheck == null)
                                {
                                    /// thêm lịch hiển thị
                                    if (thongtin.trangthai == "hienthi")
                                    {

                                        DateTime dt = Convert.ToDateTime(thongtin.ngayketthuc);
                                        string kaka = string.Format("{0}-{1}-{2} {3}:{4}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute);
                                        DateTime dateVal = DateTime.Parse(kaka);

                                        lichhienthi.tungay = DateTime.Now;
                                        lichhienthi.denngay = dateVal;
                                        lichhienthi.trangthai = true;

                                        entity.tbl_LichHienThiThamDoYKien.Add(lichhienthi);
                                        entity.SaveChanges();
                                        cauhoithamdo.id_lich = lichhienthi.id_lich;
                                        string vitrilich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                        int idloglich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { lichhienthi.id_lich, lichhienthi.tungay, lichhienthi.denngay, lichhienthi.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrilich);
                                        new Libs().updateKieuLogThemMoiThanhCong(idloglich);

                                    }
                                    else if (thongtin.trangthai == "datlich")
                                    {
                                        DateTime dttungay = Convert.ToDateTime(thongtin.tungay);
                                        string starDate = string.Format("{0}-{1}-{2} {3}:{4}", dttungay.Year, dttungay.Month, dttungay.Day, dttungay.Hour, dttungay.Minute);
                                        DateTime dateValTuNgay = DateTime.Parse(starDate);

                                        DateTime dtdenngay = Convert.ToDateTime(thongtin.denngay);
                                        string endDate = string.Format("{0}-{1}-{2} {3}:{4}", dtdenngay.Year, dtdenngay.Month, dtdenngay.Day, dtdenngay.Hour, dtdenngay.Minute);
                                        DateTime dateValDenNgay = DateTime.Parse(endDate);

                                        lichhienthi.tungay = dateValTuNgay;
                                        lichhienthi.denngay = dateValDenNgay;
                                        lichhienthi.trangthai = true;

                                        entity.tbl_LichHienThiThamDoYKien.Add(lichhienthi);
                                        entity.SaveChanges();

                                        cauhoithamdo.id_lich = lichhienthi.id_lich;
                                        string vitrilich = new Libs().VitriTruyCapVaIP("tbl_LichHienThiThamDoYKien", new Libs().ThietBiTruyCap());
                                        int idloglich = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { lichhienthi.id_lich, lichhienthi.tungay, lichhienthi.denngay, lichhienthi.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrilich);
                                        new Libs().updateKieuLogThemMoiThanhCong(idloglich);


                                    }
                                    else
                                    {
                                        msg = "Không có lịch";
                                    }

                                    /// thêm câu hỏi thăm dò

                                    cauhoithamdo.cauhoi = removeScriptAndCharacter.formatTextInput(thongtin.cauhoi);
                                    cauhoithamdo.id_hinhthuctraloi = thongtin.id_hinhthuctraloi;
                                    cauhoithamdo.id_taikhoan = session.id;
                                    cauhoithamdo.tongsocautraloi = 0;

                                    if (thongtin.trangthai == "hienthi")
                                    {
                                        cauhoithamdo.trangthai = 2;
                                    }
                                    else if (thongtin.trangthai == "datlich")
                                    {
                                        cauhoithamdo.trangthai = 3;
                                    }
                                    else
                                    {
                                        cauhoithamdo.trangthai = 1;
                                    }

                                    entity.tbl_ThamDoYKien.Add(cauhoithamdo);
                                    entity.SaveChanges();

                                    string vitrithamdo = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap());
                                    int idlogthamdo = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { cauhoithamdo.id_cauhoithamdo, cauhoithamdo.cauhoi, cauhoithamdo.id_hinhthuctraloi, cauhoithamdo.id_taikhoan, cauhoithamdo.id_lich, cauhoithamdo.trangthai, cauhoithamdo.tongsocautraloi } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitrithamdo);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlogthamdo);

                                    suscess = true;
                                    msg = "Thêm mới câu hỏi thăm dò thành công";

                                    string tendapan = "";

                                    if (listDapAn.Count > 0 && (checkhinhthuctraloi.id_hinhthuctraloi == 1 || checkhinhthuctraloi.id_hinhthuctraloi == 2))
                                    {
                                        for (int i = 0; i < listDapAn.Count; i++)
                                        {
                                            tendapan = removeScriptAndCharacter.formatTextInput(listDapAn[i]);
                                            dapanthamdo.noidungtraloi = tendapan;
                                            dapanthamdo.id_cauhoithamdo = cauhoithamdo.id_cauhoithamdo;
                                            dapanthamdo.demcautraloi = 0;
                                            dapanthamdo.trangthai = true;
                                            entity.tbl_DapAnThamDo.Add(dapanthamdo);
                                            entity.SaveChanges();

                                            suscess = true;
                                            msg = "Thêm mới câu hỏi và đáp án thành công ";
                                            string vitri2 = new Libs().VitriTruyCapVaIP("tbl_DapAnThamDo", new Libs().ThietBiTruyCap());
                                            int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { dapanthamdo.id_dapanthamdo, dapanthamdo.noidungtraloi, dapanthamdo.id_cauhoithamdo, dapanthamdo.demcautraloi, dapanthamdo.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                            new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                        }
                                    }
                                    else
                                    {
                                        msg = "Thêm mới câu hỏi thành công nhưng không có đáp án";
                                    }
                                }
                                else
                                {
                                    msg = ErrorCheck;
                                }
                            }
                            else
                            {
                                msg = "Hình thức trả lời của câu hỏi không tồn tại ";
                            }
                        }
                        else
                        {
                            msg = "Câu hỏi với hình thức trả lời này đã tồn tại trong hệ thống ";
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_ThamDoYKien", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void loadhinhthuctraloithamdoykien(HttpContext context)
    {

        var danhsach = entity.tbl_HinhthucTraLoi.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_hinhthuctraloi,
            m.hinhthuctraloi
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void themmoithuvienVideoClient(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            tbl_ThuVienClient thuvien = new tbl_ThuVienClient();
            tbl_ChiTietThuVien chitietthuvien = new tbl_ChiTietThuVien();
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["listImages"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.albumClient thongtin = (Contructor.albumClient)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.albumClient));
                        List<string> listImages = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listImages"], typeof(List<string>));
                        string ErrorCheck = new validateform().CallValidateThemAlbumAnh(thongtin.tieude, thongtin.gioithieu, thongtin.tacgia, thongtin.noidung, listImages);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_ThuVienClient.Where(x => x.tieude == thongtin.tieude && x.trangthaithuvien != 0).FirstOrDefault();
                            if (checktontai == null)
                            {

                                thuvien.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                thuvien.gioithieu = removeScriptAndCharacter.formatTextInput(thongtin.gioithieu);
                                thuvien.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                thuvien.ngayupload = DateTime.Now;
                                thuvien.tacgia = removeScriptAndCharacter.formatTextInput(thongtin.tacgia);
                                thuvien.loaithuvien = "thuvienvideo";
                                thuvien.id_taikhoan = session.id;
                                thuvien.id_danhmuc = thongtin.id_danhmuc;
                                thuvien.luotxem = 0;
                                if (thongtin.trangthaithuvien == "hienthi")
                                {
                                    thuvien.trangthaithuvien = 2;
                                }
                                else
                                {
                                    thuvien.trangthaithuvien = 1;
                                }

                                string tenalbum = new Libs().ConvertUrlsToLinks(thuvien.tieude);
                                string video = new Libs().ConvertUrlsToLinks("thuvienvideo");
                                thuvien.linlthuvien = "/" + video + "/" + tenalbum;
                                entity.tbl_ThuVienClient.Add(thuvien);
                                entity.SaveChanges();

                                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap());
                                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { thuvien.id_thuvien, thuvien.luotxem, thuvien.linlthuvien, thuvien.id_danhmuc, thuvien.tieude, thuvien.gioithieu, thuvien.noidung, thuvien.ngayupload, thuvien.tacgia, thuvien.loaithuvien, thuvien.id_taikhoan, thuvien.trangthaithuvien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                suscess = true;
                                msg = "Thêm mới album thành công";

                                string tenanh = "";

                                if (listImages.Count > 0)
                                {
                                    for (int i = 0; i < listImages.Count; i++)
                                    {
                                        tenanh = removeScriptAndCharacter.formatTextInput(listImages[i]);
                                        chitietthuvien.duongdanfile = tenanh;
                                        chitietthuvien.id_thuvien = thuvien.id_thuvien;
                                        chitietthuvien.trangthai = 1;
                                        chitietthuvien.ngaytao = DateTime.Now;
                                        chitietthuvien.filetype = new Libs().GetMimeType(tenanh);
                                        entity.tbl_ChiTietThuVien.Add(chitietthuvien);
                                        entity.SaveChanges();

                                        suscess = true;
                                        msg = "Thêm mới video vào album thành công";
                                        string vitri2 = new Libs().VitriTruyCapVaIP("tbl_ChiTietThuVien", new Libs().ThietBiTruyCap());
                                        int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chitietthuvien.id_chitietthuvien, chitietthuvien.id_thuvien, chitietthuvien.duongdanfile, chitietthuvien.trangthai, chitietthuvien.ngaytao, chitietthuvien.filetype } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                    }
                                }
                                else
                                {
                                    msg = "Thêm mới album thành công nhưng không có video";
                                }

                            }
                            else
                            {
                                msg = "Tên Album này đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void danhsachAlbumVideo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_ThuVienClient.Where(m => ((id == 0) ? true : m.id_thuvien == id) && m.trangthaithuvien != 0 && m.loaithuvien == "thuvienvideo").ToList().OrderByDescending(m => m.ngayupload).Select(m => new
            {
                m.id_thuvien,
                m.tieude,
                m.gioithieu,
                m.noidung,
                m.ngayupload,
                m.tacgia,
                m.loaithuvien,
                m.id_taikhoan,
                m.trangthaithuvien,
                m.linlthuvien,
                danhsachanh = entity.tbl_ChiTietThuVien.Where(x => x.id_thuvien.Value == m.id_thuvien && x.trangthai.Value == 1).Select(x => new
                {
                    x.id_chitietthuvien,
                    x.duongdanfile
                }),
                tendanhmuc = m.Menu_Client.tendanhmuc,
                id_danhmuc = m.Menu_Client.id_danhmuc,
                soluonganh = m.tbl_ChiTietThuVien.Where(x => x.id_thuvien == m.id_thuvien && x.trangthai == 1).Count(),
                button = new
                {
                    m.id_thuvien,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }

    public void capnhatthongtinalbumanh(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            tbl_ChiTietThuVien chitietthuvien = new tbl_ChiTietThuVien();

            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {

                Contructor.albumClient thongtincb = (Contructor.albumClient)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.albumClient));
                List<string> listImages = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listImages"], typeof(List<string>));
                List<int> listXoa = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listXoa"], typeof(List<int>));
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_ThuVienClient.Where(m => m.id_thuvien == thongtincb.id_thuvien).FirstOrDefault();
                        if (check != null)
                        {
                            string ErrorCheck = new validateform().CallValidateUpdateAlbumAnh(thongtincb.tieude, thongtincb.gioithieu, thongtincb.tacgia, thongtincb.noidung);

                            if (ErrorCheck == null)
                            {
                                var checkten = entity.tbl_ThuVienClient.Where(x => x.id_thuvien != thongtincb.id_thuvien && x.tieude == thongtincb.tieude && x.trangthaithuvien != 0).FirstOrDefault();

                                if (checkten == null)
                                {
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_thuvien, check.id_taikhoan, check.tieude, check.linlthuvien, check.gioithieu, check.noidung, check.ngayupload, check.tacgia, check.loaithuvien, check.trangthaithuvien }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });


                                    // theem moi anh
                                    string tenanh = "";

                                    if (listImages.Count > 0)
                                    {
                                        for (int i = 0; i < listImages.Count; i++)
                                        {
                                            tenanh = removeScriptAndCharacter.formatTextInput(listImages[i]);
                                            chitietthuvien.duongdanfile = tenanh;
                                            chitietthuvien.id_thuvien = check.id_thuvien;
                                            chitietthuvien.trangthai = 1;
                                            chitietthuvien.ngaytao = DateTime.Now;
                                            chitietthuvien.filetype = new Libs().GetMimeType(tenanh);
                                            entity.tbl_ChiTietThuVien.Add(chitietthuvien);
                                            entity.SaveChanges();

                                            sucess = true;
                                            msg = "Thêm mới ảnh vào album thành công";
                                            string vitri2 = new Libs().VitriTruyCapVaIP("tbl_ChiTietThuVien", new Libs().ThietBiTruyCap());
                                            int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chitietthuvien.id_chitietthuvien, chitietthuvien.id_thuvien, chitietthuvien.duongdanfile, chitietthuvien.trangthai, chitietthuvien.ngaytao, chitietthuvien.filetype } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                            new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                        }
                                    }

                                    int idct = 0;
                                    if (listXoa.Count > 0)
                                    {
                                        for (int i = 0; i < listXoa.Count; i++)
                                        {
                                            idct = listXoa[i];
                                            var chitiet = entity.tbl_ChiTietThuVien.Where(z => z.id_chitietthuvien == idct).First();
                                            if (chitiet != null)
                                            {

                                                chitiet.trangthai = 0;
                                                entity.SaveChanges();

                                                sucess = true;
                                                msg = "Xoá ảnh khỏi album thành công";

                                                string vitri111 = new Libs().VitriTruyCapVaIP("tbl_ChiTietThuVien", new Libs().ThietBiTruyCap()); // vitri
                                                int idlog111 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { chitiet.id_chitietthuvien, chitiet.id_thuvien, chitiet.duongdanfile, chitiet.trangthai, chitiet.ngaytao, chitiet.filetype } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri111); // luu log lan 1
                                                new Libs().updateKieuLogXoaThanhCong(idlog111);
                                            }
                                            else
                                            {
                                                msg = "Ảnh không tồn tại";
                                            }

                                        }
                                    }
                                    check.tieude = removeScriptAndCharacter.formatTextInput(thongtincb.tieude);
                                    check.gioithieu = removeScriptAndCharacter.formatTextInput(thongtincb.gioithieu);
                                    check.noidung = removeScriptAndCharacter.formatTextInput(thongtincb.noidung);
                                    check.tacgia = removeScriptAndCharacter.formatTextInput(thongtincb.tacgia);
                                    check.id_danhmuc = thongtincb.id_danhmuc;
                                    if (thongtincb.trangthaithuvien == "hienthi")
                                    {
                                        check.trangthaithuvien = 2;
                                    }
                                    else
                                    {
                                        check.trangthaithuvien = 1;
                                    }

                                    string tenalbum = new Libs().ConvertUrlsToLinks(check.tieude);
                                    string video = new Libs().ConvertUrlsToLinks(check.loaithuvien);

                                    check.linlthuvien = "/" + video + "/" + tenalbum;

                                    entity.SaveChanges();
                                    sucess = true;
                                    msg = "Cập nhật thông tin thành công ";

                                    tbl_ThuVienClient cbo = (tbl_ThuVienClient)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_ThuVienClient));
                                    string vitri = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap()); // vitri
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = cbo, dulieumoi = new { check.id_thuvien, check.id_taikhoan, check.linlthuvien, check.tieude, check.gioithieu, check.noidung, check.ngayupload, check.tacgia, check.loaithuvien, check.trangthaithuvien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                                }
                                else
                                {
                                    msg = "Tiêu đề này đã tồn tại";
                                }
                            }
                            else
                            {
                                msg = ErrorCheck;
                            }
                        }
                        else
                        {
                            msg = "Album này không tồn tại ";

                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {

                string vitri = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void xoaalbumanh(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_thuvien"]))
            {
                int id_thuvien = client.ToInt(context.Request["id_thuvien"]);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_ThuVienClient.Where(m => m.id_thuvien == id_thuvien).FirstOrDefault();
                        if (check != null)
                        {

                            check.trangthaithuvien = 0;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Xóa album thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_thuvien, check.id_taikhoan, check.linlthuvien, check.id_danhmuc, check.tieude, check.gioithieu, check.noidung, check.ngayupload, check.tacgia, check.loaithuvien, check.trangthaithuvien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlog);

                            var checkchitiet = entity.tbl_ChiTietThuVien.Where(x => x.id_thuvien == check.id_thuvien && x.trangthai == 1).ToList();
                            if (checkchitiet.Count > 0)
                            {
                                for (int i = 0; i < checkchitiet.Count; i++)
                                {
                                    checkchitiet[i].trangthai = 0;
                                    entity.SaveChanges();

                                    string vitri1 = new Libs().VitriTruyCapVaIP("tbl_ChiTietThuVien", new Libs().ThietBiTruyCap());
                                    int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkchitiet[i].id_chitietthuvien, checkchitiet[i].duongdanfile, checkchitiet[i].id_thuvien, checkchitiet[i].trangthai, checkchitiet[i].ngaytao, checkchitiet[i].filetype } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                    new Libs().updateKieuLogXoaThanhCong(idlog1);
                                }
                            }
                        }
                        else
                        {
                            msg = "Album này không tồn tại trong hệ thống";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void danhsachAlbumAnh(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_ThuVienClient.Where(m => ((id == 0) ? true : m.id_thuvien == id) && m.trangthaithuvien != 0 && m.loaithuvien == "thuvienanh").ToList().OrderByDescending(m => m.ngayupload).Select(m => new
            {
                m.id_thuvien,
                m.tieude,
                m.gioithieu,
                m.noidung,
                m.ngayupload,
                m.tacgia,
                m.loaithuvien,
                m.id_taikhoan,
                m.trangthaithuvien,
                m.linlthuvien,
                danhsachanh = entity.tbl_ChiTietThuVien.Where(x => x.id_thuvien.Value == m.id_thuvien && x.trangthai.Value == 1).Select(x => new
                {
                    x.id_chitietthuvien,
                    x.duongdanfile
                }),
                tendanhmuc = m.Menu_Client.tendanhmuc,
                id_danhmuc = m.Menu_Client.id_danhmuc,
                soluonganh = m.tbl_ChiTietThuVien.Where(x => x.id_thuvien == m.id_thuvien && x.trangthai == 1).Count(),
                button = new
                {
                    m.id_thuvien,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }


    public void loaddanhsachdanhmuccuaalbumanh(HttpContext context)
    {

        var danhsach = entity.Menu_Client.Where(m => m.trangthai == 1 && m.idParent == 0).Select(m => new
        {
            m.id_danhmuc,
            m.tendanhmuc
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void themmoithuvienanhClient(HttpContext context)
    {
        bool suscess = false;
        string msg = "";


        try
        {
            tbl_ThuVienClient thuvien = new tbl_ThuVienClient();
            tbl_ChiTietThuVien chitietthuvien = new tbl_ChiTietThuVien();
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["listImages"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.albumClient thongtin = (Contructor.albumClient)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.albumClient));
                        List<string> listImages = (List<string>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["listImages"], typeof(List<string>));

                        string ErrorCheck = new validateform().CallValidateThemAlbumAnh(thongtin.tieude, thongtin.gioithieu, thongtin.tacgia, thongtin.noidung, listImages);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_ThuVienClient.Where(x => x.tieude == thongtin.tieude && x.trangthaithuvien != 0).FirstOrDefault();
                            if (checktontai == null)
                            {

                                thuvien.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                thuvien.gioithieu = removeScriptAndCharacter.formatTextInput(thongtin.gioithieu);
                                thuvien.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                thuvien.ngayupload = DateTime.Now;
                                thuvien.tacgia = removeScriptAndCharacter.formatTextInput(thongtin.tacgia);
                                thuvien.loaithuvien = "thuvienanh";
                                thuvien.id_taikhoan = session.id;
                                thuvien.id_danhmuc = thongtin.id_danhmuc;
                                thuvien.luotxem = 0;
                                if (thongtin.trangthaithuvien == "hienthi")
                                {
                                    thuvien.trangthaithuvien = 2;
                                }
                                else
                                {
                                    thuvien.trangthaithuvien = 1;
                                }


                                string tenalbum = new Libs().ConvertUrlsToLinks(thuvien.tieude);
                                string video = new Libs().ConvertUrlsToLinks("thuvienanh");

                                List<DMNgang> _listParent = new List<DMNgang>();
                                thuvien.linlthuvien = "/" + video + "/" + tenalbum;
                                entity.tbl_ThuVienClient.Add(thuvien);
                                entity.SaveChanges();

                                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap());
                                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { thuvien.id_thuvien, thuvien.luotxem, thuvien.id_danhmuc, thuvien.tieude, thuvien.linlthuvien, thuvien.gioithieu, thuvien.noidung, thuvien.ngayupload, thuvien.tacgia, thuvien.loaithuvien, thuvien.id_taikhoan, thuvien.trangthaithuvien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                suscess = true;
                                msg = "Thêm mới album thành công";

                                string tenanh = "";

                                if (listImages.Count > 0)
                                {
                                    for (int i = 0; i < listImages.Count; i++)
                                    {
                                        tenanh = removeScriptAndCharacter.formatTextInput(listImages[i]);
                                        chitietthuvien.duongdanfile = tenanh;
                                        chitietthuvien.id_thuvien = thuvien.id_thuvien;
                                        chitietthuvien.trangthai = 1;
                                        chitietthuvien.ngaytao = DateTime.Now;
                                        chitietthuvien.filetype = new Libs().GetMimeType(tenanh);
                                        entity.tbl_ChiTietThuVien.Add(chitietthuvien);
                                        entity.SaveChanges();

                                        suscess = true;
                                        msg = "Thêm mới ảnh vào album thành công";
                                        string vitri2 = new Libs().VitriTruyCapVaIP("tbl_ChiTietThuVien", new Libs().ThietBiTruyCap());
                                        int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chitietthuvien.id_chitietthuvien, chitietthuvien.id_thuvien, chitietthuvien.duongdanfile, chitietthuvien.trangthai, chitietthuvien.ngaytao, chitietthuvien.filetype } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                    }
                                }
                                else
                                {
                                    msg = "Thêm mới album thành công nhưng không có ảnh";
                                }

                            }
                            else
                            {
                                msg = "Tên Album này đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_ThuVienClient", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }



    public void themmoichucvucanbotrongcoquan(HttpContext context)
    {
        bool suscess = false;
        string msg = "";


        tbl_DanhSachChucVu chucvu = new tbl_DanhSachChucVu();

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                if (new Libs().QuyenThemMoi())
                {
                    Contructor.thongtincanbo thongtin = (Contructor.thongtincanbo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtincanbo));

                    var checktontai = entity.tbl_DanhSachChucVu.Where(x => x.tenchucvu == thongtin.tenchucvu && x.trangthai == true).FirstOrDefault();
                    if (checktontai == null)
                    {
                        var checkParent = entity.tbl_DanhSachChucVu.Where(m => m.id_chucvu == thongtin.id_chucvu).FirstOrDefault();

                        if (checkParent != null)
                        {
                            chucvu.tenchucvu = thongtin.tenchucvu;
                            chucvu.idParents = thongtin.id_chucvu;
                            chucvu.trangthai = true;
                            entity.tbl_DanhSachChucVu.Add(chucvu);
                            entity.SaveChanges();

                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DanhSachChucVu", new Libs().ThietBiTruyCap());
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chucvu.id_chucvu, chucvu.tenchucvu, chucvu.trangthai, chucvu.idParents } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                            new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                            suscess = true;
                            msg = "Thêm mới chức vụ thành công";
                        }
                        else
                        {
                            msg = "Chức vụ cha không tồn tại ";
                        }
                    }
                    else
                    {
                        msg = "Chức vụ này đã tồn tại trong hệ thống ";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }
        if (suscess == false)
        {
            string vitri5 = new Libs().VitriTruyCapVaIP("tbl_DanhSachChucVu", new Libs().ThietBiTruyCap());
            int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
            new Libs().updateKieuLogThemMoiThatBai(idlog5);
        }

        HttpContext.Current.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void capnhattenchucvucanbo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
        {

            Contructor.thongtincanbo thongtincb = (Contructor.thongtincanbo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtincanbo));
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_DanhSachChucVu.Where(m => m.id_chucvu == thongtincb.id_chucvu).FirstOrDefault();
                    if (check != null)
                    {
                        var checkten = entity.tbl_DanhSachChucVu.Where(x => x.id_chucvu != thongtincb.id_chucvu && x.tenchucvu == thongtincb.tenchucvu && x.trangthai == true).FirstOrDefault();

                        if (checkten == null)
                        {
                            string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_chucvu, check.tenchucvu, check.trangthai, check.idParents }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                            check.tenchucvu = thongtincb.tenchucvu;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Cập nhật thông tin thành công ";

                            tbl_DanhSachChucVu cbo = (tbl_DanhSachChucVu)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_DanhSachChucVu));
                            string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachChucVu", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = cbo, dulieumoi = new { check.id_chucvu, check.tenchucvu, check.trangthai, check.idParents } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Tên chức vụ đã tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Cán bộ này không tồn tại ";

                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền thực hiện chức năng này";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {

            string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachChucVu", new Libs().ThietBiTruyCap()); // vitri
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }


    public void loadalldanhsachchucvucuacanbo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_DanhSachChucVu.Where(m => m.trangthai == true).Select(m => new
            {
                m.id_chucvu,
                m.tenchucvu,
                m.trangthai,
                m.idParents,
                tenchucvucaptren = (entity.tbl_DanhSachChucVu.Where(x => x.id_chucvu == m.idParents).FirstOrDefault() == null) ? (entity.tbl_DanhSachChucVu.Where(xx => xx.id_chucvu == m.id_chucvu).Select(xx => new { id_chucvu = xx.id_chucvu, tenchucvu = xx.tenchucvu }).FirstOrDefault()) : (entity.tbl_DanhSachChucVu.Where(v => v.id_chucvu == m.idParents).Select(v => new { id_chucvu = v.id_chucvu, tenchucvu = v.tenchucvu }).FirstOrDefault()),
                button = new
                {
                    m.id_chucvu,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList().OrderBy(m => m.idParents);
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }

    public void capnhatthongtincanbo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string tendonvi = "";
        string tenquanham = "";


        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
        {
            Contructor.thongtincanbo thongtincb = (Contructor.thongtincanbo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtincanbo));


            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_DanhSachCanBo.Where(m => m.id_dscanbo == thongtincb.id_dscanbo).FirstOrDefault();

                    var checkdonvi = entity.tbl_DonVicongTac.Where(v => v.donvicongtac == thongtincb.donvicongtac).FirstOrDefault();
                    if (checkdonvi == null)
                    {
                        tbl_DonVicongTac donvict = new tbl_DonVicongTac();
                        donvict.donvicongtac = thongtincb.donvicongtac;
                        donvict.trangthai = true;
                        entity.tbl_DonVicongTac.Add(donvict);
                        int kq = entity.SaveChanges();

                        tendonvi = donvict.donvicongtac;
                        if (kq != 0)
                        {
                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DonVicongTac", new Libs().ThietBiTruyCap()); // vitri
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { donvict.id_donvi, donvict.donvicongtac, donvict.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                            new Libs().updateKieuLogThemMoiThanhCong(idlog1);
                        }
                        else
                        {
                            msg = "Thêm mới đơn vị công tác thất bại";
                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DonVicongTac", new Libs().ThietBiTruyCap()); // vitri
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                            new Libs().updateKieuLogThemMoiThatBai(idlog1);
                        }
                    }
                    else
                    {
                        if (checkdonvi.trangthai == false)
                        {
                            checkdonvi.trangthai = true;
                            entity.SaveChanges();
                            tendonvi = checkdonvi.donvicongtac;
                        }
                        else
                        {
                            tendonvi = checkdonvi.donvicongtac;
                        }
                    }
                    var checkcapbac = entity.tbl_CapBac.Where(x => x.quanham == thongtincb.quanham).FirstOrDefault();
                    if (checkcapbac == null)
                    {
                        tbl_CapBac dschucvu = new tbl_CapBac();
                        dschucvu.quanham = thongtincb.quanham;
                        dschucvu.trangthai = true;
                        entity.tbl_CapBac.Add(dschucvu);
                        int kq2 = entity.SaveChanges();
                        if (kq2 != 0)
                        {
                            tenquanham = dschucvu.quanham;
                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_CapBac", new Libs().ThietBiTruyCap()); // vitri
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { dschucvu.id_capbac, dschucvu.quanham, dschucvu.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                            new Libs().updateKieuLogThemMoiThanhCong(idlog1);
                        }
                        else
                        {
                            msg = "Thêm mới quân hàm thất bại ";
                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_CapBac", new Libs().ThietBiTruyCap()); // vitri
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                            new Libs().updateKieuLogThemMoiThatBai(idlog1);
                        }
                    }
                    else
                    {
                        if (checkcapbac.trangthai == false)
                        {
                            checkcapbac.trangthai = true;
                            entity.SaveChanges();
                            tenquanham = checkcapbac.quanham;
                        }
                        else
                        {
                            tenquanham = checkcapbac.quanham;
                        }
                    }



                    if (check != null)
                    {

                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_dscanbo, check.tencanbo, check.id_chucvu, check.donvicongtac, check.thongtinlienhe, check.anhdaidien, check.trangthaicanbo, check.quanham, check.ngaysinh, check.quequan }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });


                        check.tencanbo = thongtincb.tencanbo;
                        check.id_chucvu = thongtincb.id_chucvu;
                        check.donvicongtac = tendonvi;
                        check.thongtinlienhe = thongtincb.thongtinlienhe;
                        check.anhdaidien = thongtincb.anhdaidien;

                        if (thongtincb.trangthaicanbo == "hienthi")
                        {
                            check.trangthaicanbo = 2;
                        }
                        else
                        {
                            check.trangthaicanbo = 1;
                        }
                        check.quanham = tenquanham;
                        check.ngaysinh = thongtincb.ngaysinh;
                        check.quequan = thongtincb.quequan;

                        entity.SaveChanges();
                        sucess = true;
                        msg = "Cập nhật thông tin thành công ";

                        tbl_DanhSachCanBo cbo = (tbl_DanhSachCanBo)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_DanhSachCanBo));
                        string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap()); // vitri
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = cbo, dulieumoi = new { check.id_dscanbo, check.tencanbo, check.id_chucvu, check.donvicongtac, check.thongtinlienhe, check.anhdaidien, check.trangthaicanbo, check.quanham, check.ngaysinh, check.quequan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                    }
                    else
                    {
                        msg = "Cán bộ này không tồn tại ";

                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền thực hiện chức năng này";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {

            string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap()); // vitri
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }




    public void xoathongtincanbo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        if (new Libs().checkDuLieuGuiLen(context.Request["id_canbo"]))
        {
            //int id_canbo = int.Parse(context.Request["id_canbo"]);
            int id_canbo = 0;
            int.TryParse(context.Request["id_canbo"], out id_canbo);
            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_DanhSachCanBo.Where(m => m.id_dscanbo == id_canbo).FirstOrDefault();
                    if (check != null)
                    {

                        check.trangthaicanbo = 0;
                        entity.SaveChanges();
                        sucess = true;
                        msg = "Xóa thành công !";

                        string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap()); // vitri
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_dscanbo, check.tencanbo, check.id_chucvu, check.donvicongtac, check.thongtinlienhe, check.anhdaidien, check.trangthaicanbo, check.quanham, check.ngaysinh, check.quequan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                        new Libs().updateKieuLogXoaThanhCong(idlog);
                    }
                    else
                    {
                        msg = "Cán bộ này không tồn tại trong hệ thống";
                    }

                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap()); // vitri
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void danhsachcanbolanhdao(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (session != null)
        {

            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsach = entity.tbl_DanhSachCanBo.Where(m => m.trangthaicanbo != 0).Select(m => new
            {
                m.id_dscanbo,
                m.tencanbo,
                m.id_chucvu,
                tenchucvu = m.tbl_DanhSachChucVu.tenchucvu,
                m.donvicongtac,
                m.thongtinlienhe,
                m.anhdaidien,
                m.trangthaicanbo,
                gioithieu = "Đồng chí " + m.quanham + " " + m.tencanbo,
                m.quanham,
                m.ngaysinh,
                m.quequan,
                idparent = m.tbl_DanhSachChucVu.idParents,
                button = new
                {
                    m.id_dscanbo,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList().OrderBy(m => m.idparent);
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = 0 }, Formatting.Indented));
        }
    }
    public void danhsachchucvulanhdao(HttpContext context)
    {

        var danhsach = entity.tbl_DanhSachChucVu.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_chucvu,
            m.tenchucvu,
            m.idParents
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void danhsachdonvicongtac(HttpContext context)
    {

        var danhsach = entity.tbl_DonVicongTac.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_donvi,
            m.donvicongtac
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }

    public void loaddaanhsachquanham(HttpContext context)
    {

        var danhsach = entity.tbl_CapBac.Where(m => m.trangthai == true).Select(m => new
        {
            m.id_capbac,
            m.quanham
        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(danhsach, Formatting.Indented));
    }


    public void themmoicanbolanhdao(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        string tenQuanHam = "";
        string tenDonVi = "";


        tbl_DanhSachCanBo canbo = new tbl_DanhSachCanBo();

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                if (new Libs().QuyenThemMoi())
                {
                    Contructor.thongtincanbo thongtin = (Contructor.thongtincanbo)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtincanbo));

                    var checktontai = entity.tbl_DanhSachCanBo.Where(x => x.tencanbo == thongtin.tencanbo && x.id_chucvu == thongtin.id_chucvu && x.quanham == thongtin.quanham && x.quequan == thongtin.quequan && x.trangthaicanbo != 0).FirstOrDefault();
                    if (checktontai == null)
                    {
                        var checkchucvu = entity.tbl_DanhSachChucVu.Where(m => m.id_chucvu == thongtin.id_chucvu).FirstOrDefault();
                        if (checkchucvu != null)
                        {
                            var checkQuanham = entity.tbl_CapBac.Where(xx => xx.quanham == thongtin.quanham && xx.trangthai == true).FirstOrDefault();
                            if (checkQuanham != null)
                            {
                                tenQuanHam = thongtin.quanham;
                            }
                            else
                            {
                                tbl_CapBac capbac = new tbl_CapBac();
                                capbac.quanham = thongtin.quanham;
                                capbac.trangthai = true;
                                entity.tbl_CapBac.Add(capbac);
                                entity.SaveChanges();

                                tenQuanHam = capbac.quanham;
                            }

                            var checkDonViCongTac = entity.tbl_DonVicongTac.Where(mm => mm.donvicongtac == thongtin.donvicongtac && mm.trangthai == true).FirstOrDefault(); ;
                            if (checkDonViCongTac != null)
                            {
                                tenDonVi = thongtin.donvicongtac;
                            }
                            else
                            {
                                tbl_DonVicongTac donvi = new tbl_DonVicongTac();
                                donvi.donvicongtac = thongtin.donvicongtac;
                                donvi.trangthai = true;
                                entity.tbl_DonVicongTac.Add(donvi);
                                entity.SaveChanges();

                                tenDonVi = donvi.donvicongtac;
                            }



                            canbo.tencanbo = thongtin.tencanbo;
                            canbo.id_chucvu = thongtin.id_chucvu;
                            canbo.donvicongtac = tenDonVi;
                            canbo.thongtinlienhe = thongtin.thongtinlienhe;
                            canbo.anhdaidien = thongtin.anhdaidien;

                            if (thongtin.trangthaicanbo == "hienthi")
                            {
                                canbo.trangthaicanbo = 2;
                            }
                            else
                            {
                                canbo.trangthaicanbo = 1;
                            }
                            canbo.quanham = tenQuanHam;
                            canbo.ngaysinh = thongtin.ngaysinh;
                            canbo.quequan = thongtin.quequan;

                            entity.tbl_DanhSachCanBo.Add(canbo);
                            entity.SaveChanges();

                            string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap());
                            int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { canbo.id_dscanbo, canbo.tencanbo, canbo.id_chucvu, canbo.donvicongtac, canbo.thongtinlienhe, canbo.anhdaidien, canbo.trangthaicanbo, canbo.quanham, canbo.ngaysinh, canbo.quequan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                            new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                            suscess = true;
                            msg = "Thêm mới cán bộ thành công";
                        }
                        else
                        {
                            msg = "Chức vụ không tồn tại vui lòng thử lại";
                        }
                    }
                    else
                    {
                        msg = "Cán bộ này này đã tồn tại trong hệ thống ";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }
        if (suscess == false)
        {
            string vitri5 = new Libs().VitriTruyCapVaIP("tbl_DanhSachCanBo", new Libs().ThietBiTruyCap());
            int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
            new Libs().updateKieuLogThemMoiThatBai(idlog5);
        }

        HttpContext.Current.Response.ContentType = "text/plain";
        HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void capnhatthongtintinhhuongvacachxuly(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";

        try
        {
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.tinhhuongvacachxuly thongtin = (Contructor.tinhhuongvacachxuly)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tinhhuongvacachxuly));

                        string ErrorCheck = new validateform().CallValidateUpdateTinhHuongKhanCap(thongtin.id_huongdan, thongtin.tieude, thongtin.tinhhuong, thongtin.cachxuly);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_HuongDanSuLyTinhHuong.Where(m => m.id_huongdan == thongtin.id_huongdan && m.trangthai != 0).FirstOrDefault();

                            if (checktontai != null)
                            {

                                var checktrung = entity.tbl_HuongDanSuLyTinhHuong.Where(x => x.id_huongdan != thongtin.id_huongdan && x.trangthai != 0 && x.tieude == thongtin.tieude).FirstOrDefault();

                                if (checktrung == null)
                                {
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_huongdan, checktontai.tieude, checktontai.linktinhhuong, checktontai.id_taikhoan, checktontai.tinhhuong, checktontai.cachxuly, checktontai.trangthai, checktontai.ngaytao }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    checktontai.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                    checktontai.tinhhuong = removeScriptAndCharacter.formatTextInput(thongtin.tinhhuong);
                                    checktontai.cachxuly = removeScriptAndCharacter.formatTextInput(thongtin.cachxuly);
                                    if (thongtin.trangthai == "hienthi")
                                    {
                                        checktontai.trangthai = 2;
                                    }
                                    else
                                    {
                                        checktontai.trangthai = 1;
                                    }
                                    string tentinhhuong = new Libs().ConvertUrlsToLinks(checktontai.tieude);
                                    checktontai.linktinhhuong = "/huong-dan-xu-ly-tinh-huong/" + tentinhhuong;
                                    entity.SaveChanges();
                                    suscess = true;
                                    msg = "Cập nhật thông tin thành công ";

                                    tbl_HuongDanSuLyTinhHuong dataJson = (tbl_HuongDanSuLyTinhHuong)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_HuongDanSuLyTinhHuong));
                                    string vitri = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_huongdan, checktontai.tieude, checktontai.linktinhhuong, checktontai.id_taikhoan, checktontai.tinhhuong, checktontai.cachxuly, checktontai.trangthai, checktontai.ngaytao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                }
                                else
                                {
                                    msg = "Trùng thông tin";
                                }
                            }
                            else
                            {
                                msg = "Tình huống này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }



    public void themmmoitinhhuongvacachxuly(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        try
        {
            tbl_HuongDanSuLyTinhHuong hdxl = new tbl_HuongDanSuLyTinhHuong();
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.tinhhuongvacachxuly thongtin = (Contructor.tinhhuongvacachxuly)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tinhhuongvacachxuly));

                        string ErrorCheck = new validateform().CallValidateThemMoiTinhHuongKhanCap(thongtin.tieude, thongtin.tinhhuong, thongtin.cachxuly);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_HuongDanSuLyTinhHuong.Where(x => x.tinhhuong == thongtin.tinhhuong && x.trangthai != 0 && x.tieude == thongtin.tieude).FirstOrDefault();
                            if (checktontai == null)
                            {
                                hdxl.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                hdxl.tinhhuong = removeScriptAndCharacter.formatTextInput(thongtin.tinhhuong);
                                hdxl.cachxuly = removeScriptAndCharacter.formatTextInput(thongtin.cachxuly);
                                hdxl.id_taikhoan = session.id;
                                if (thongtin.trangthai == "hienthi")
                                {
                                    hdxl.trangthai = 2;
                                }
                                else
                                {
                                    hdxl.trangthai = 1;
                                }
                                hdxl.ngaytao = DateTime.Now;
                                string tentinhhuong = new Libs().ConvertUrlsToLinks(hdxl.tieude);
                                hdxl.linktinhhuong = "/huong-dan-xu-ly-tinh-huong/" + tentinhhuong;

                                entity.tbl_HuongDanSuLyTinhHuong.Add(hdxl);
                                entity.SaveChanges();

                                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { hdxl.id_huongdan, hdxl.tieude, hdxl.linktinhhuong, hdxl.id_taikhoan, hdxl.tinhhuong, hdxl.cachxuly, hdxl.trangthai, hdxl.ngaytao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                suscess = true;
                                msg = "Thêm mới tình huống thành công";
                            }
                            else
                            {
                                msg = "Tình huống này đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }



    public void xoahuongdantinhhuongsayra(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_huongdan"]))
            {
                int id_huongdan = client.ToInt(context.Request["id_huongdan"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_HuongDanSuLyTinhHuong.Where(m => m.id_huongdan == id_huongdan && m.trangthai != 0).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa tình huống thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_huongdan, check.id_taikhoan, check.tieude, check.linktinhhuong, check.tinhhuong, check.cachxuly, check.trangthai, check.ngaytao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Tình huống này không tồn tại ";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_HuongDanSuLyTinhHuong", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }

    public void loadalldanhsachtinhhuong(HttpContext context)
    {
        bool sucess = false;
        string msg = "";

        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_HuongDanSuLyTinhHuong.Where(m => ((id == 0) ? true : m.id_huongdan == id) && m.trangthai != 0).ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_huongdan,
                m.id_taikhoan,
                m.tinhhuong,
                m.cachxuly,
                m.trangthai,
                m.ngaytao,
                m.linktinhhuong,
                m.tieude,
                dsguive = new { m.tinhhuong, m.cachxuly, m.trangthai },
                button = new
                {
                    m.id_huongdan,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }



    // trang thai tong dai : 0 =xoa, 1= lưu , 2= hiển thị

    public void capnhatthongtinduongdaynong(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        try
        {
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.duongdaynong thongtin = (Contructor.duongdaynong)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.duongdaynong));

                        string ErrorCheck = new validateform().CallValidateUpdateDuongDayNong(thongtin.id_dstongdai, thongtin.tendonvi, thongtin.sodienthoai, thongtin.email, thongtin.mota, thongtin.diachi);

                        if (ErrorCheck == null)
                        {
                            var cauhoitl = entity.tbl_DanhSachTongDai.Where(m => m.id_dstongdai == thongtin.id_dstongdai).FirstOrDefault();

                            if (cauhoitl != null)
                            {

                                var checktrung = entity.tbl_DanhSachTongDai.Where(x => x.id_dstongdai != thongtin.id_dstongdai && x.trangthai != 0 && x.sodienthoai == thongtin.sodienthoai && x.tendonvi == thongtin.tendonvi).FirstOrDefault();

                                if (checktrung == null)
                                {
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { cauhoitl.id_dstongdai, cauhoitl.id_taikhoan, cauhoitl.email, cauhoitl.sodienthoai, cauhoitl.trangthai, cauhoitl.diachi, cauhoitl.tendonvi, cauhoitl.mota }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    cauhoitl.email = removeScriptAndCharacter.formatTextInput(thongtin.email);
                                    cauhoitl.sodienthoai = thongtin.sodienthoai;
                                    cauhoitl.diachi = removeScriptAndCharacter.formatTextInput(thongtin.diachi);
                                    cauhoitl.tendonvi = removeScriptAndCharacter.formatTextInput(thongtin.tendonvi);
                                    cauhoitl.mota = removeScriptAndCharacter.formatTextInput(thongtin.mota);
                                    if (thongtin.trangthai == "hienthi")
                                    {
                                        cauhoitl.trangthai = 2;
                                    }
                                    else
                                    {
                                        cauhoitl.trangthai = 1;
                                    }

                                    entity.SaveChanges();
                                    suscess = true;
                                    msg = "Cập nhật thông tin thành công ";

                                    tbl_DanhSachTongDai dataJson = (tbl_DanhSachTongDai)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_DanhSachTongDai));
                                    string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { cauhoitl.id_dstongdai, cauhoitl.id_taikhoan, cauhoitl.email, cauhoitl.sodienthoai, cauhoitl.trangthai, cauhoitl.diachi, cauhoitl.tendonvi, cauhoitl.mota } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                }
                                else
                                {
                                    msg = "Trùng thông tin";
                                }
                            }
                            else
                            {
                                msg = "Đường dây nóng này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void themoilienlacduongdaynong(HttpContext context)
    {
        bool suscess = false;
        string msg = "";
        try
        {
            tbl_DanhSachTongDai tongdai = new tbl_DanhSachTongDai();

            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.duongdaynong thongtin = (Contructor.duongdaynong)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.duongdaynong));
                        string ErrorCheck = new validateform().CallValidateThemDuongDayNong(thongtin.tendonvi, thongtin.sodienthoai, thongtin.email, thongtin.mota, thongtin.diachi);
                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_DanhSachTongDai.Where(x => x.sodienthoai == thongtin.sodienthoai && x.trangthai != 0 && x.tendonvi == thongtin.tendonvi).FirstOrDefault();
                            if (checktontai == null)
                            {
                                tongdai.email = removeScriptAndCharacter.formatTextInput(thongtin.email);
                                tongdai.sodienthoai = removeScriptAndCharacter.formatTextInput(thongtin.sodienthoai);
                                tongdai.diachi = removeScriptAndCharacter.formatTextInput(thongtin.diachi);
                                tongdai.tendonvi = removeScriptAndCharacter.formatTextInput(thongtin.tendonvi);
                                tongdai.mota = removeScriptAndCharacter.formatTextInput(thongtin.mota);
                                tongdai.id_taikhoan = session.id;
                                tongdai.ngaytao = DateTime.Now;
                                if (thongtin.trangthai == "hienthi")
                                {
                                    tongdai.trangthai = 2;
                                }
                                else
                                {
                                    tongdai.trangthai = 1;
                                }

                                entity.tbl_DanhSachTongDai.Add(tongdai);
                                entity.SaveChanges();

                                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { tongdai.id_dstongdai, tongdai.id_taikhoan, tongdai.email, tongdai.sodienthoai, tongdai.trangthai, tongdai.diachi, tongdai.tendonvi, tongdai.mota } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                suscess = true;
                                msg = "Thêm mới đường dây nóng thành công";
                            }
                            else
                            {
                                msg = "Địa chỉ đường dây nóng này đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void xoalienlacduongdaynong(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_dstongdai"]))
            {
                int id_dstongdai = client.ToInt(context.Request["id_dstongdai"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_DanhSachTongDai.Where(m => m.id_dstongdai == id_dstongdai).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa câu hỏi thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_dstongdai, check.id_taikhoan, check.email, check.sodienthoai, check.trangthai, check.diachi, check.tendonvi, check.mota } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Liên lạc này không tồn tại ";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_DanhSachTongDai", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
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


    public void loadalldanhsachduongdaynong(HttpContext context)
    {
        bool sucess = false;
        string msg = "";

        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_DanhSachTongDai.Where(m => ((id == 0) ? true : m.id_dstongdai == id) && m.trangthai != 0).ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_dstongdai,
                m.id_taikhoan,
                m.email,
                m.sodienthoai,
                m.trangthai,
                m.diachi,
                m.tendonvi,
                m.mota,
                dsguive = new { m.tendonvi, m.sodienthoai, m.mota, m.trangthai },
                button = new
                {
                    m.id_dstongdai,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }


    // loaicauhoi=admin , câu hỏi của người dùng =nguoidung
    // bang tài khoản  :  người hoi = taikhoan1 ,người trả lời = taikhoan
    // trạng thái câu hỏi : 0=xóa, 1 = đang lưu , 2 = hiển thị
    // có 3 loại update : 

    //tentacvu: "updatedata" >> update thong tin của cau hoi -tra loi cong dan    
    // tentacvu: "traloicauhoi" >> trả lời câu hỏi của công dân , 
    //tentacvu: "updatedatamau"  >> đây là câu của admin nên ko cần gửi mail 
    // check tentacvu để biết cái nào cần gửi mail
    public void loadalldanhsachcauhoicuacongdan(HttpContext context)
    {
        bool sucess = false;
        string msg = "";
        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_CauhoiTraLoi.Where(m => ((id == 0) ? true : m.id_cauhoitraloi == id) && m.trangthai != 0 && m.loaicauhoi == "nguoidung").ToList().OrderByDescending(m => m.ngayhoi).Select(m => new
            {
                m.id_cauhoitraloi,
                m.cauhoi,
                m.tieudecauhoi,
                traloi = (m.traloi != null) ? m.traloi : "",
                m.ngayhoi,
                ngaytraloi = (m.ngaytraloi != null) ? m.ngaytraloi : null,
                m.trangthai,
                m.luotxem,
                dateQues = m.ngayhoi.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                id_nguoitraloi = (m.id_nguoitraloi != null) ? m.id_nguoitraloi : null,
                tennguoitraloi = (m.id_nguoitraloi != null) ? m.TaiKhoan.tendaydu : "",
                m.id_chuyenmuc,
                tenchuyenmuc = m.tbl_ChuyenMucLuaChon.tenchuyenmuc,
                m.id_nguoihoi,
                tennguoihoi = m.TaiKhoan1.tendaydu,
                emailnguoihoi = m.TaiKhoan1.email,
                m.loaicauhoi,
                filedinhkem = (m.filedinhkem != null) ? m.filedinhkem : "",
                fileQuestion = (m.fileQuestion != null) ? m.fileQuestion : "",
                linkcauhoi = (m.linkcauhoi != null) ? m.linkcauhoi : "",
                m.statusRepQuestion,
                dsguive = new { m.cauhoi, m.trangthai, m.statusRepQuestion },
                button = new
                {
                    m.id_cauhoitraloi,
                    m.statusRepQuestion,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }

    public void capnhatthongtincauhoitraloimau(HttpContext context)
    {


        bool suscess = false;
        string msg = "Thay đổi không thành công ";

        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.cauhoicautraloi thongtin = (Contructor.cauhoicautraloi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.cauhoicautraloi));

                        string ErrorCheck = new validateform().CallValidateUpdateCauHoiMau(thongtin.id_cauhoitraloi, thongtin.tieudecauhoi, thongtin.cauhoi, thongtin.traloi, thongtin.id_chuyenmuc, thongtin.trangthaihienthi);

                        if (ErrorCheck == null)
                        {
                            var cauhoitl = entity.tbl_CauhoiTraLoi.Where(m => m.id_cauhoitraloi == thongtin.id_cauhoitraloi).FirstOrDefault();

                            var checkchuyenmuc = entity.tbl_ChuyenMucLuaChon.Where(xx => xx.id_chuyenmuc == thongtin.id_chuyenmuc).FirstOrDefault();

                            if (cauhoitl != null)
                            {
                                if (checkchuyenmuc != null)
                                {
                                    var chechtench = entity.tbl_CauhoiTraLoi.Where(xx => xx.id_cauhoitraloi != cauhoitl.id_cauhoitraloi && xx.cauhoi == thongtin.cauhoi && xx.trangthai != 0).FirstOrDefault();
                                    if (chechtench == null)
                                    {
                                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { cauhoitl.id_cauhoitraloi, cauhoitl.linkcauhoi, cauhoitl.statusRepQuestion, cauhoitl.id_chuyenmuc, cauhoitl.tieudecauhoi, cauhoitl.id_nguoihoi, cauhoitl.id_nguoitraloi, cauhoitl.cauhoi, cauhoitl.traloi, cauhoitl.ngayhoi, cauhoitl.ngaytraloi, cauhoitl.trangthai, cauhoitl.luotxem, cauhoitl.loaicauhoi, cauhoitl.filedinhkem }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                        cauhoitl.id_chuyenmuc = thongtin.id_chuyenmuc;
                                        cauhoitl.tieudecauhoi = removeScriptAndCharacter.formatTextInput(thongtin.tieudecauhoi);
                                        cauhoitl.cauhoi = removeScriptAndCharacter.formatTextInput(thongtin.cauhoi);
                                        cauhoitl.traloi = removeScriptAndCharacter.formatTextInput(thongtin.traloi);
                                        cauhoitl.filedinhkem = removeScriptAndCharacter.formatTextInput(thongtin.filedinhkem);
                                        if (thongtin.trangthaihienthi == "hienthi")
                                        {
                                            cauhoitl.trangthai = 2;
                                        }
                                        else
                                        {
                                            cauhoitl.trangthai = 1;
                                        }
                                        string tencauhoi = new Libs().ConvertUrlsToLinks(cauhoitl.tieudecauhoi);
                                        cauhoitl.linkcauhoi = "/chi-tiet-hoi-dap/" + tencauhoi;

                                        entity.SaveChanges();
                                        suscess = true;
                                        msg = "Cập nhật thông tin thành công ";

                                        tbl_CauhoiTraLoi dataJson = (tbl_CauhoiTraLoi)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_CauhoiTraLoi));
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { cauhoitl.id_cauhoitraloi, cauhoitl.linkcauhoi, cauhoitl.tieudecauhoi, cauhoitl.id_chuyenmuc, cauhoitl.id_nguoihoi, cauhoitl.id_nguoitraloi, cauhoitl.statusRepQuestion, cauhoitl.cauhoi, cauhoitl.traloi, cauhoitl.ngayhoi, cauhoitl.ngaytraloi, cauhoitl.trangthai, cauhoitl.luotxem, cauhoitl.loaicauhoi, cauhoitl.filedinhkem } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                        var thongtinnguoiguicauhoi = entity.TaiKhoan.Where(mm => mm.id_taikhoan == cauhoitl.id_nguoihoi).FirstOrDefault();
                                        string tailieu = cauhoitl.filedinhkem;
                                        if (tailieu != "")
                                        {
                                            tailieu = "<a href=" + strUrl + tailieu + " class='col-sm-8 control-label' download>Tải về</a>";
                                        }
                                        else
                                        {
                                            tailieu = "Không có tài liệu đính kèm";
                                        }
                                        if (thongtinnguoiguicauhoi != null)
                                        {
                                            if (thongtin.tentacvu == "updatedata")
                                            {
                                                string mailto = thongtinnguoiguicauhoi.email;
                                                string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", thongtinnguoiguicauhoi.tendaydu);
                                                string body = string.Format("Xin chào {0} !<br /> Đáp án câu hỏi của bạn đã được chúng tôi chỉnh sửa một số thông tin như sau :<br />Câu hỏi : {1} <br />Trả lời : {2} <br />Chuyên mục : {3} , Tệp đính kèm : {4}. <br />Mọi thắc vui lòng liên hệ trực tiếp với chúng tôi để được giải đáp.<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", thongtinnguoiguicauhoi.tendaydu, cauhoitl.cauhoi, cauhoitl.traloi, cauhoitl.tbl_ChuyenMucLuaChon.tenchuyenmuc, tailieu);
                                                bool guimail = new Libs().sendEmail(mailto, subject, body);

                                                if (!guimail)
                                                {
                                                    msg = "Gửi email không thành công";
                                                }
                                            }
                                            if (thongtin.tentacvu == "traloicauhoi")
                                            {
                                                cauhoitl.ngaytraloi = DateTime.Now;
                                                cauhoitl.id_nguoitraloi = session.id;
                                                cauhoitl.statusRepQuestion = true;
                                                entity.SaveChanges();

                                                string mailto1 = thongtinnguoiguicauhoi.email;
                                                string subject1 = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", thongtinnguoiguicauhoi.tendaydu);
                                                string body1 = string.Format("Xin chào {0} !<br /> Câu hỏi của bạn gửi đến chúng tôi đã nhận đươc , chúng tôi xin gửi câu trả lời để bạn tham khảo .<br />Câu hỏi :  {1} <br />Trả lời : {2} <br />Tệp đính kèm : {3}  .<br />  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", thongtinnguoiguicauhoi.tendaydu, cauhoitl.cauhoi, cauhoitl.traloi, tailieu);
                                                bool guimail1 = new Libs().sendEmail(mailto1, subject1, body1);

                                                if (!guimail1)
                                                {
                                                    msg = "Gửi email không thành công ";
                                                }
                                            }
                                        }
                                        else
                                        {
                                            msg = "Cập nhật thông tin thành công nhưng không gửi được email cho người gửi câu hỏi ";
                                        }
                                    }
                                    else
                                    {
                                        msg = "Câu hỏi đã tồn tại trong hệ thống";
                                    }
                                }
                                else
                                {
                                    msg = "Chuyên mục bạn chọn không tồn tại ";
                                }
                            }
                            else
                            {
                                msg = "Mẫu câu hỏi này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void themmoicauhoitraloimau(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            tbl_CauhoiTraLoi cauhoitl = new tbl_CauhoiTraLoi();

            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.cauhoicautraloi thongtin = (Contructor.cauhoicautraloi)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.cauhoicautraloi));

                        string ErrorCheck = new validateform().CallValidateThemCauHoiMau(thongtin.tieudecauhoi, thongtin.cauhoi, thongtin.traloi, thongtin.id_chuyenmuc, thongtin.trangthaihienthi);

                        if (ErrorCheck == null)
                        {
                            var checktencauhoi = entity.tbl_CauhoiTraLoi.Where(xxx => xxx.cauhoi == thongtin.cauhoi && xxx.trangthai != 0).FirstOrDefault();
                            if (checktencauhoi == null)
                            {
                                var checkchuyenmuc = entity.tbl_ChuyenMucLuaChon.Where(x => x.id_chuyenmuc == thongtin.id_chuyenmuc).FirstOrDefault();
                                if (checkchuyenmuc != null)
                                {
                                    cauhoitl.cauhoi = removeScriptAndCharacter.formatTextInput(thongtin.cauhoi);
                                    cauhoitl.tieudecauhoi = removeScriptAndCharacter.formatTextInput(thongtin.tieudecauhoi);
                                    cauhoitl.traloi = removeScriptAndCharacter.formatTextInput(thongtin.traloi);
                                    cauhoitl.ngayhoi = DateTime.Now;
                                    cauhoitl.ngaytraloi = DateTime.Now;
                                    if (thongtin.trangthaihienthi == "hienthi")
                                    {
                                        cauhoitl.trangthai = 2;
                                    }
                                    else
                                    {
                                        cauhoitl.trangthai = 1;
                                    }
                                    cauhoitl.id_nguoitraloi = session.id;
                                    cauhoitl.id_nguoihoi = session.id;
                                    cauhoitl.luotxem = 0;
                                    cauhoitl.id_chuyenmuc = checkchuyenmuc.id_chuyenmuc;
                                    cauhoitl.loaicauhoi = "admin";
                                    cauhoitl.id_nguoitraloi = session.id;
                                    cauhoitl.statusRepQuestion = true;
                                    if (cauhoitl.filedinhkem != null)
                                    {
                                        cauhoitl.filedinhkem = thongtin.filedinhkem;
                                    }

                                    string tencauhoi = new Libs().ConvertUrlsToLinks(cauhoitl.tieudecauhoi);
                                    cauhoitl.linkcauhoi = "/chi-tiet-hoi-dap/" + tencauhoi;
                                    entity.tbl_CauhoiTraLoi.Add(cauhoitl);
                                    entity.SaveChanges();

                                    string vitri1 = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                                    int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { cauhoitl.id_cauhoitraloi, cauhoitl.linkcauhoi, cauhoitl.id_chuyenmuc, cauhoitl.tieudecauhoi, cauhoitl.statusRepQuestion, cauhoitl.id_nguoihoi, cauhoitl.id_nguoitraloi, cauhoitl.cauhoi, cauhoitl.traloi, cauhoitl.ngayhoi, cauhoitl.ngaytraloi, cauhoitl.trangthai, cauhoitl.luotxem, cauhoitl.loaicauhoi, cauhoitl.filedinhkem } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                    suscess = true;
                                    msg = "Thêm mới câu hỏi mẫu thành công";
                                }
                                else
                                {
                                    msg = "Chuyên mục này không tồn tại trong hệ thống !";
                                }
                            }
                            else
                            {
                                msg = "Tên câu hỏi đã tồn tại trong hệ thống ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void getAdllDanhmucCauhoi(HttpContext context)
    {

        var danhsach = entity.tbl_ChuyenMucLuaChon.Where(m => m.id_danhmuc == 12).ToList().Select(m => new
        {
            m.id_chuyenmuc,
            m.tenchuyenmuc,
            m.id_danhmuc,
            tendanhmucgoc = m.Menu_Client.tendanhmuc,
            m.trangthai
        });

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));

    }
    public void xoacauhoitraloimau(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_cauhoitraloi"]))
            {
                int id_cauhoitraloi = client.ToInt(context.Request["id_cauhoitraloi"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_CauhoiTraLoi.Where(m => m.id_cauhoitraloi == id_cauhoitraloi).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa câu hỏi thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_cauhoitraloi, check.tieudecauhoi, check.cauhoi, check.traloi, check.ngayhoi, check.ngaytraloi, check.trangthai, check.luotxem, check.id_nguoitraloi, check.id_chuyenmuc, check.loaicauhoi, check.id_nguoihoi, check.filedinhkem } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Câu hỏi này không tồn tại ";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_CauhoiTraLoi", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void danhsachcauhoitraloimau(HttpContext context)
    {
        bool sucess = false;
        string msg = "";
        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_CauhoiTraLoi.Where(m => ((id == 0) ? true : m.id_cauhoitraloi == id) && m.trangthai != 0 && m.loaicauhoi == "admin").ToList().OrderByDescending(m => m.ngayhoi).Select(m => new
            {
                m.id_cauhoitraloi,
                m.tieudecauhoi,
                m.cauhoi,
                m.traloi,
                m.ngayhoi,
                m.ngaytraloi,
                ngay = m.ngayhoi.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                m.trangthai,
                m.luotxem,
                m.id_nguoitraloi,
                tennguoitraloi = m.TaiKhoan.tendaydu,
                m.id_chuyenmuc,
                tenchuyenmuc = m.tbl_ChuyenMucLuaChon.tenchuyenmuc,
                m.id_nguoihoi,
                tennguoihoi = m.TaiKhoan1.tendaydu,
                m.loaicauhoi,
                m.filedinhkem,
                button = new
                {
                    m.id_cauhoitraloi,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }

    public void capnhatthongtintinbaocongdan(HttpContext context)
    {
        String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
        String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");

        bool suscess = false;
        string msg = "Thay đổi không thành công ";


        if (session != null)
        {
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    Contructor.tinbaocongdan thongtin = (Contructor.tinbaocongdan)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.tinbaocongdan));

                    var check = entity.tbl_TinBaoCongDan.Where(m => m.id_tinbao == thongtin.id_tinbao).FirstOrDefault();

                    if (check != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_tinbao, check.hoten, check.email, check.dienthoai, check.diachi, check.diaban, check.noidungtinbao, check.trangthaihienthi, check.ngaygui, check.ngayxem, check.id_chuyenmuc, check.tieude, check.linktinbao, check.trangthaixem }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                        var getmenu = entity.tbl_ChuyenMucLuaChon.Where(xx => xx.id_chuyenmuc == thongtin.id_chuyenmuc).FirstOrDefault();
                        if (getmenu != null)
                        {
                            check.hoten = thongtin.hoten;
                            check.email = thongtin.email;
                            check.dienthoai = thongtin.dienthoai;
                            check.diachi = thongtin.diachi;
                            check.diaban = thongtin.diaban;

                            string nd = thongtin.noidungtinbao;
                            if (thongtin.noidungtinbao.Length > 2000)
                            {
                                check.noidungtinbao = thongtin.noidungtinbao.Substring(0, 2000);
                            }
                            else
                            {
                                check.noidungtinbao = thongtin.noidungtinbao;
                            }

                            if (thongtin.trangthaihienthi == "hienthi")
                            {
                                check.trangthaihienthi = 2;
                            }
                            else
                            {
                                check.trangthaihienthi = 1;
                            }
                            check.id_chuyenmuc = thongtin.id_chuyenmuc;
                            check.tieude = thongtin.tieude;
                            string tentinbao = new Libs().ConvertUrlsToLinks(check.tieude + check.ngaygui);

                            check.linktinbao = "/chi-tiet-tin-bao-cong-dan/" + tentinbao;
                            entity.SaveChanges();
                            suscess = true;
                            msg = "Cập nhật thông tin thành công ";

                            tbl_TinBaoCongDan dataJson = (tbl_TinBaoCongDan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_TinBaoCongDan));
                            string vitri = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_tinbao, check.hoten, check.email, check.dienthoai, check.diachi, check.diaban, check.noidungtinbao, check.trangthaihienthi, check.ngaygui, check.ngayxem, check.id_chuyenmuc, check.tieude, check.linktinbao, check.trangthaixem } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Danh mục không tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Tin báo này không tồn tại trong hệ thống";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }
    public void loaddanhsachdanhmuctinbaocongdan(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;


        if (session != null)
        {
            var danhsach = entity.tbl_ChuyenMucLuaChon.Where(m => m.id_danhmuc == 11 && m.trangthai == true).ToList().Select(m => new
            {
                m.id_chuyenmuc,
                m.tenchuyenmuc,
                m.id_danhmuc,
                m.trangthai
            });
            sucess = true;
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, data = danhsach }, Formatting.Indented));
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, data = 0 }, Formatting.Indented));
        }
    }


    public void capnhattinhtrangxemcuatinbao(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int id_tinbao = 0;
        if (new Libs().checkDuLieuGuiLen(context.Request["id_tinbao"]))
        {
            // int id_tinbao = int.Parse(context.Request["id_tinbao"]);
            int.TryParse(context.Request["id_tinbao"], out id_tinbao);
            if (session != null)
            {
                var check = entity.tbl_TinBaoCongDan.Where(m => m.id_tinbao == id_tinbao && m.trangthaihienthi != 0).FirstOrDefault();
                if (check != null)
                {
                    check.trangthaixem = true;
                    check.ngayxem = DateTime.Now;
                    entity.SaveChanges();
                    sucess = true;
                    msg = "ok";
                }
            }
            else
            {
                msg = "Session không tồn tại";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void xoatinbaocongdan(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int id_tinbao = 0;
        if (new Libs().checkDuLieuGuiLen(context.Request["id_tinbao"]))
        {
            // int id_tinbao = int.Parse(context.Request["id_tinbao"]);
            int.TryParse(context.Request["id_tinbao"], out id_tinbao);
            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_TinBaoCongDan.Where(m => m.id_tinbao == id_tinbao).FirstOrDefault();
                    if (check != null)
                    {
                        check.trangthaihienthi = 0;
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Xóa tin báo thành công !";

                        string vitri = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_tinbao, check.hoten, check.email, check.dienthoai, check.diachi, check.id_chuyenmuc, check.diaban, check.noidungtinbao, check.trangthaihienthi, check.trangthaixem, check.tieude, check.linktinbao, check.ngaygui } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogXoaThanhCong(idlog);
                    }
                    else
                    {
                        sucess = false;
                        msg = "Tin báo này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("tbl_TinBaoCongDan", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    /// <summary>
    /// trạng thái hiển thị tin báo công dân  : 0=xóa , 1 = chỉ lưu , 2 = hiển thị
    /// trạng thái xem : 0 = chưa ;1 = đã xem
    /// </summary>
    /// <param name="context"></param>
    public void danhsachtinbaocongdan(HttpContext context)
    {
        bool sucess = false;
        string msg = "";

        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_TinBaoCongDan.Where(m => m.trangthaihienthi != 0).ToList().Select(m => new
            {
                m.id_tinbao,
                m.hoten,
                m.email,
                m.dienthoai,
                m.diachi,
                m.id_chuyenmuc,
                tenchuyenmuc = m.tbl_ChuyenMucLuaChon.tenchuyenmuc,
                m.diaban,
                noidung = m.noidungtinbao,
                m.trangthaixem,
                m.trangthaihienthi,
                m.ngaygui,
                m.tieude,
                m.linktinbao,
                dsguive = new { m.diaban, ngay = m.ngaygui.Value.ToString("dd-MM-yyyy"), m.noidungtinbao, m.trangthaixem },
                button = new
                {
                    m.id_tinbao,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            var demsoluong = danhsach != null ? danhsach.Where(x => x.trangthaixem == false).Count() : 0;

            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach, demsoluong = demsoluong }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }

    public void loadAlldanhsachbaivietGUONGDIENHINH(HttpContext context)
    {
        bool sucess = false;
        string msg = "";

        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_Baiviet.Where(m => ((id == 0) ? true : m.id_baiviet == id) && m.trangthaibaiviet != 0 && m.idRoot == 10 && m.tenRoot == "guongdienhinh").ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_baiviet,
                m.tieude,
                m.gioithieu,
                m.noidung,
                m.tacgia,
                ngaytao = m.ngaytao.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                m.tag,
                m.trangthaibaiviet,
                m.avatar,
                m.id_taikhoan,
                ngaythang = m.ngaytao,
                button = new
                {
                    m.id_baiviet,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                danhsach = m.tbl_Vitribv.Where(x => x.id_baiviet == m.id_baiviet && x.trangthaibaiviet != 0).ToList().Select(x => new
                {
                    x.id_vitribv,
                    x.id_baiviet,
                    id_danhmuc = (x.id_danhmuc != null) ? x.id_danhmuc : 0,
                    id_datlich = (x.id_datlich != null) ? x.id_datlich : 0,
                    soluotlike = (x.soluotlike != null) ? x.soluotlike : 0,
                    soluotview = (x.soluotview != null) ? x.soluotview : 0,
                    x.trangthaibaiviet,
                    linkbaiviet = (x.linkbaiviet != null) ? x.linkbaiviet : "",
                    ngaydang = (x.ngaydang != null) ? x.ngaydang : null,
                    ngayhengio = (x.id_datlich != null) ? x.tbl_DatLich.ngaydang : null,
                    tendanhmuc = (x.id_danhmuc != null) ? x.Menu_Client.tendanhmuc : "",
                    time = (x.ngaydang != null) ? x.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy") : x.tbl_DatLich.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                    details = new
                    {
                        id = x.id_baiviet,
                        status = x.trangthaibaiviet,
                    }
                }).ToList()
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }

    public void loadAlldanhsachbaivietcanhbaonguoidan(HttpContext context)
    {
        bool sucess = false;
        string msg = "";

        int id = int.Parse(context.Request["id"]);
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_Baiviet.Where(m => ((id == 0) ? true : m.id_baiviet == id) && m.trangthaibaiviet != 0 && m.idRoot == 115 && m.tenRoot == "canhbaonguoidan").ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_baiviet,
                m.tieude,
                m.gioithieu,
                m.noidung,
                m.tacgia,
                ngaytao = m.ngaytao.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                m.tag,
                m.trangthaibaiviet,
                m.avatar,
                m.id_taikhoan,
                ngaythang = m.ngaytao,
                button = new
                {
                    m.id_baiviet,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                danhsach = m.tbl_Vitribv.Where(x => x.id_baiviet == m.id_baiviet && x.trangthaibaiviet != 0).ToList().Select(x => new
                {
                    x.id_vitribv,
                    x.id_baiviet,
                    id_danhmuc = (x.id_danhmuc != null) ? x.id_danhmuc : 0,
                    id_datlich = (x.id_datlich != null) ? x.id_datlich : 0,
                    soluotlike = (x.soluotlike != null) ? x.soluotlike : 0,
                    soluotview = (x.soluotview != null) ? x.soluotview : 0,
                    x.trangthaibaiviet,
                    linkbaiviet = (x.linkbaiviet != null) ? x.linkbaiviet : "",
                    ngaydang = (x.ngaydang != null) ? x.ngaydang : null,
                    ngayhengio = (x.id_datlich != null) ? x.tbl_DatLich.ngaydang : null,
                    tendanhmuc = (x.id_danhmuc != null) ? x.Menu_Client.tendanhmuc : "",
                    time = (x.ngaydang != null) ? x.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy") : x.tbl_DatLich.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                    details = new
                    {
                        id = x.id_baiviet,
                        status = x.trangthaibaiviet,
                    }
                }).ToList()
            }).ToList();
            sucess = true;
            msg = "ok";
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }
    public void danhsachdanhmuccanhbaonguoidan(HttpContext context)
    {
        List<Libs.jsonmenuClient> oDanhMuc = new List<Libs.jsonmenuClient>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.Menu_Client.Where(m => m.idParent == 0 && m.trangthai == 1 && m.id_danhmuc == 115).ToList().All(x =>
        {
            Libs.jsonmenuClient m = new Libs.jsonmenuClient();
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
            new Libs().getDanhMucClient(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }
    public void danhsachdanhmucGUONGDIENHINH(HttpContext context)
    {
        List<Libs.jsonmenuClient> oDanhMuc = new List<Libs.jsonmenuClient>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.Menu_Client.Where(m => m.idParent == 0 && m.trangthai == 1 && m.id_danhmuc == 10).ToList().All(x =>
        {
            Libs.jsonmenuClient m = new Libs.jsonmenuClient();
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
            new Libs().getDanhMucClient(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }
    public void loaddanhsachbaiviethoptacquocte(HttpContext context)
    {
        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_Baiviet.Where(m => ((id == 0) ? true : m.id_baiviet == id) && m.trangthaibaiviet != 0 && m.idRoot == 9 && m.tenRoot == "hoptacquocte").ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_baiviet,
                m.tieude,
                m.gioithieu,
                m.noidung,
                m.tacgia,
                ngaytao = m.ngaytao.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                m.tag,
                m.trangthaibaiviet,
                m.avatar,
                m.id_taikhoan,
                ngaythang = m.ngaytao,
                button = new
                {
                    m.id_baiviet,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                danhsach = m.tbl_Vitribv.Where(x => x.id_baiviet == m.id_baiviet && x.trangthaibaiviet != 0).ToList().Select(x => new
                {
                    x.id_vitribv,
                    x.id_baiviet,
                    id_danhmuc = (x.id_danhmuc != null) ? x.id_danhmuc : 0,
                    id_datlich = (x.id_datlich != null) ? x.id_datlich : 0,
                    soluotlike = (x.soluotlike != null) ? x.soluotlike : 0,
                    soluotview = (x.soluotview != null) ? x.soluotview : 0,
                    x.trangthaibaiviet,
                    linkbaiviet = (x.linkbaiviet != null) ? x.linkbaiviet : "",
                    ngaydang = (x.ngaydang != null) ? x.ngaydang : null,
                    ngayhengio = (x.id_datlich != null) ? x.tbl_DatLich.ngaydang : null,
                    tendanhmuc = (x.id_danhmuc != null) ? x.Menu_Client.tendanhmuc : "",
                    time = (x.ngaydang != null) ? x.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy") : x.tbl_DatLich.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                    details = new
                    {
                        id = x.id_baiviet,
                        status = x.trangthaibaiviet,
                    }
                }).ToList()
            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
    }


    public void loaddanhsachdanhmuchoptacquocte(HttpContext context)
    {
        List<Libs.jsonmenuClient> oDanhMuc = new List<Libs.jsonmenuClient>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.Menu_Client.Where(m => m.idParent == 0 && m.trangthai == 1 && m.id_danhmuc == 9).ToList().All(x =>
        {
            Libs.jsonmenuClient m = new Libs.jsonmenuClient();
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
            new Libs().getDanhMucClient(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }

    public void capnhatthongtinbvgt(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";

        try
        {
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.bvgioithieu thongtin = (Contructor.bvgioithieu)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.bvgioithieu));

                        string ErrorCheck = new validateform().CallValidateThemBVGioiThieu(thongtin.noidung);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_BaiVietTrangGioiThieu.Where(m => m.id_baivietGT == thongtin.id_baivietGT).FirstOrDefault();

                            if (checktontai != null)
                            {
                                string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_baivietGT, checktontai.noidung, checktontai.trangthai, checktontai.id_danhmuc, checktontai.linkbaiGT, checktontai.ngaytao }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });


                                checktontai.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);

                                entity.SaveChanges();
                                suscess = true;
                                msg = "Cập nhật thông tin thành công ";

                                tbl_BaiVietTrangGioiThieu dataJson = (tbl_BaiVietTrangGioiThieu)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_BaiVietTrangGioiThieu));
                                string vitri = new Libs().VitriTruyCapVaIP("tbl_BaiVietTrangGioiThieu", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_baivietGT, checktontai.noidung, checktontai.trangthai, checktontai.id_danhmuc, checktontai.linkbaiGT, checktontai.ngaytao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                            }
                            else
                            {
                                msg = "Bài viết này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_BaiVietTrangGioiThieu", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
    }


    public void themmoibaivietgioithieu(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");
            tbl_BaiVietTrangGioiThieu gioithieu = new tbl_BaiVietTrangGioiThieu();

            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.bvgioithieu thongtin = (Contructor.bvgioithieu)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.bvgioithieu));

                        string ErrorCheck = new validateform().CallValidateThemBVGioiThieu(thongtin.noidung);

                        if (ErrorCheck == null)
                        {
                            var KT = entity.tbl_BaiVietTrangGioiThieu.Where(m => m.id_danhmuc == thongtin.iddmGT && m.trangthai == true).FirstOrDefault();
                            if (KT == null)
                            {

                                gioithieu.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                gioithieu.trangthai = true;
                                gioithieu.id_danhmuc = thongtin.iddmGT;


                                List<DMNgang> _list = new List<DMNgang>();
                                _list = new Libs().getList(thongtin.iddmGT, new List<DMNgang>());
                                string href = "";
                                for (int j = _list.Count - 1; j >= 0; j--)
                                {
                                    href = href + "/" + _list[j].shortcode;
                                }
                                gioithieu.linkbaiGT = href;
                                gioithieu.ngaytao = DateTime.Now;

                                entity.tbl_BaiVietTrangGioiThieu.Add(gioithieu);
                                entity.SaveChanges();

                                suscess = true;
                                msg = "Thêm mới bài viết thành công";

                                string vitri = new Libs().VitriTruyCapVaIP("tbl_BaiVietTrangGioiThieu", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { gioithieu.id_baivietGT, gioithieu.noidung, gioithieu.trangthai, gioithieu.id_danhmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog);

                            }
                            else
                            {
                                msg = "Danh mục này đã có bài viết giới thiệu";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_BaiVietTrangGioiThieu", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }

    public void loaddanhsachbaivietcuadanhmucgioithieu(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["idDM"]))
            {
                int idDM = int.Parse(context.Request["idDM"]);
                string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
                Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
                var checkDM = entity.Menu_Client.Where(m => m.id_danhmuc == idDM && m.trangthai == 1).FirstOrDefault();
                if (checkDM != null)
                {
                    var danhsach = entity.tbl_BaiVietTrangGioiThieu.Where(m => m.id_danhmuc == idDM).ToList().Select(m => new
                    {
                        id_baivietGT = (m.id_baivietGT != null) ? m.id_baivietGT : 0,
                        noidung = (m.noidung != null) ? m.noidung : "",
                        trangthai = (m.trangthai != null) ? m.trangthai : false,
                        id_danhmuc = (m.id_danhmuc != null) ? m.id_danhmuc : 0,
                        tendanhmuc = (m.id_danhmuc != null) ? m.Menu_Client.tendanhmuc : "",
                        button = new
                        {
                            id_baivietGT = (m.id_baivietGT != null) ? m.id_baivietGT : 0,
                            cn.xem,
                            cn.them,
                            cn.sua,
                            cn.xoa
                        }
                    }).ToList();
                    msg = "Load thông tin thành công";
                    suscess = true;
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = danhsach }, Formatting.Indented));
                }
                else
                {
                    msg = "Danh mục không tồn tại";
                }

            }
            else
            {
                msg = "Có sự cố khi thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (suscess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }
    public void loaddanhmuctranggioithieu(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        bool quyen = false;

        if (session != null)
        {
            var danhsach = entity.Menu_Client.Where(m => (m.idParent == 1 && m.trangthai == 1) && (m.id_danhmuc != 62)).ToList().Select(m => new
            {
                m.id_danhmuc,
                m.tendanhmuc,
                m.link_danhmuc,
                m.trangthai,
                m.sothutu,
                m.idParent,
                m.shortcode,
                m.duongdan,
                m.icon
            }).ToList();
            suscess = true;
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (suscess == false)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg }, Formatting.Indented));
        }
    }

    public void capnhatthongtinvanban(HttpContext context)
    {
        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        try
        {
            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.vanban thongtin = (Contructor.vanban)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.vanban));
                        string ErrorCheck = new validateform().CallValidateUpdateVanBan(thongtin.id_vanban, thongtin.tenvanban, thongtin.sokyhieu, thongtin.ngaybh, thongtin.trichyeu, thongtin.noidung, thongtin.duongdanfile, thongtin.idCQ, thongtin.idVB);

                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_VanBan.Where(m => m.id_vanban == thongtin.id_vanban).FirstOrDefault();
                            if (checktontai != null)
                            {
                                var checktrunglink = entity.tbl_VanBan.Where(zzz => zzz.id_vanban != checktontai.id_vanban && zzz.tenvanban == thongtin.tenvanban && zzz.id_coquanbanhanh == thongtin.id_coquanbanhanh && zzz.id_loaivanban == thongtin.id_loaivanban).FirstOrDefault();
                                if (checktrunglink == null)
                                {
                                    var loaivb = entity.Menu_Client.Where(zz => zz.id_danhmuc == thongtin.idVB).FirstOrDefault();

                                    if (loaivb != null)
                                    {
                                        thongtin.ngaybanhanh = DateTime.Parse(thongtin.ngaybh);
                                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_vanban, checktontai.id_coquanbanhanh, checktontai.id_loaivanban, checktontai.tenvanban, checktontai.sokyhieu, checktontai.ngaybanhanh, checktontai.trichyeu, checktontai.noidung, checktontai.id_taikhoan, checktontai.trangthai, checktontai.ngaytao, checktontai.kieuvanban, checktontai.icon, checktontai.duongdanfile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                        checktontai.tenvanban = removeScriptAndCharacter.formatTextInput(thongtin.tenvanban);
                                        checktontai.sokyhieu = removeScriptAndCharacter.formatTextInput(thongtin.sokyhieu);
                                        checktontai.ngaybanhanh = thongtin.ngaybanhanh;
                                        checktontai.trichyeu = removeScriptAndCharacter.formatTextInput(thongtin.trichyeu);
                                        checktontai.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                        checktontai.duongdanfile = removeScriptAndCharacter.formatTextInput(thongtin.duongdanfile);

                                        if (thongtin.trangthaihienthi == "hienthi")
                                        {
                                            checktontai.trangthai = 2;
                                        }
                                        else
                                        {
                                            checktontai.trangthai = 1;
                                        }
                                        string path = Path.GetExtension(thongtin.duongdanfile);
                                        string icon = new Libs().getIcon(path);
                                        checktontai.kieuvanban = path;
                                        checktontai.icon = icon;
                                        checktontai.id_coquanbanhanh = thongtin.idCQ;
                                        checktontai.id_loaivanban = thongtin.idVB;

                                        string tenVB = new Libs().ConvertUrlsToLinks(checktontai.tenvanban);
                                        checktontai.linkvanban = "/chi-tiet-van-ban/" + tenVB;

                                        entity.SaveChanges();
                                        suscess = true;
                                        msg = "Cập nhật thông tin thành công ";

                                        tbl_VanBan dataJson = (tbl_VanBan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_VanBan));
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_vanban, checktontai.id_coquanbanhanh, checktontai.id_loaivanban, checktontai.tenvanban, checktontai.sokyhieu, checktontai.ngaybanhanh, checktontai.trichyeu, checktontai.noidung, checktontai.id_taikhoan, checktontai.trangthai, checktontai.ngaytao, checktontai.kieuvanban, checktontai.icon, checktontai.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                                    }
                                    else
                                    {
                                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                                    }
                                }
                                else
                                {
                                    msg = "Thông tin bạn muốn thay đổi đã tồn tại trong hệ thống vui lòng chọn lại";
                                }
                            }
                            else
                            {
                                msg = "Văn bản này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }


    public void xoavanban(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_baiviet"]))
            {
                int id_baiviet = client.ToInt(context.Request["id_baiviet"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_VanBan.Where(m => m.id_vanban == id_baiviet).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa văn bản thành công !";
                            string vitri = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_vanban, check.tenvanban, check.id_loaivanban, check.id_coquanbanhanh, check.sokyhieu, check.ngaybanhanh, check.trichyeu, check.noidung, check.id_taikhoan, check.trangthai, check.ngaytao, check.kieuvanban, check.icon, check.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            sucess = false;
                            msg = "Văn bản này không tồn tại ";
                        }
                    }
                    else
                    {
                        sucess = false;
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }

    public void loaddanhsachvanbantronghethong(HttpContext context)
    {
        int id = int.Parse(context.Request["id"]);

        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_VanBan.Where(m => ((id == 0) ? true : m.id_vanban == id) & m.trangthai != 0).ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_vanban,
                m.tenvanban,
                m.sokyhieu,
                ngaybanhanh = m.ngaybanhanh.Value.ToString("yyyy-MM-dd"),
                m.trichyeu,
                m.noidung,
                m.id_taikhoan,
                m.trangthai,
                m.kieuvanban,
                m.icon,
                m.duongdanfile,
                ngaythang = m.ngaytao,
                coquanbanhanh = m.Menu_Client.tendanhmuc,
                loaivanban = m.Menu_Client1.tendanhmuc,
                m.id_coquanbanhanh,
                m.id_loaivanban,
                button = new
                {
                    m.id_vanban,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
    }


    public void loaddanhsachcoquanbanhanh(HttpContext context)
    {
        var danhsach = entity.Menu_Client.Where(m => m.idParent == 85 && m.trangthai == 1).ToList().Select(m => new
           {
               m.id_danhmuc,
               m.tendanhmuc,
               m.link_danhmuc,
               m.trangthai,
               m.sothutu,
               m.idParent,
               m.shortcode,
               m.duongdan,
               m.icon

           });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
    }
    public void loaddanhsachloaivanban(HttpContext context)
    {
        var danhsach = entity.Menu_Client.Where(m => m.idParent == 86 && m.trangthai == 1).ToList().Select(m => new
        {
            m.id_danhmuc,
            m.tendanhmuc,
            m.link_danhmuc,
            m.trangthai,
            m.sothutu,
            m.idParent,
            m.shortcode,
            m.duongdan,
            m.icon

        }).ToList();
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
    }

    public void themmoivanban(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");
            tbl_VanBan vanban = new tbl_VanBan();
            tbl_ViTriVanBan vitrivb = new tbl_ViTriVanBan();

            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.vanban thongtin = (Contructor.vanban)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.vanban));
                        if (thongtin.id_coquanbanhanh != null && thongtin.id_loaivanban != null)
                        {
                            string ErrorCheck = new validateform().CallValidateThemVanBan(thongtin.tenvanban, thongtin.sokyhieu, thongtin.ngaybh, thongtin.trichyeu, thongtin.noidung, thongtin.duongdanfile, thongtin.id_coquanbanhanh, thongtin.id_loaivanban);

                            if (ErrorCheck == null)
                            {
                                var KT = entity.tbl_VanBan.Where(m => m.tenvanban == thongtin.tenvanban).FirstOrDefault();
                                if (KT == null)
                                {
                                    var loaivb = entity.Menu_Client.Where(mm => mm.id_danhmuc == thongtin.id_loaivanban).FirstOrDefault();

                                    if (loaivb != null)
                                    {
                                        thongtin.ngaybanhanh = DateTime.Parse(thongtin.ngaybh);
                                        vanban.tenvanban = removeScriptAndCharacter.formatTextInput(thongtin.tenvanban);
                                        vanban.sokyhieu = removeScriptAndCharacter.formatTextInput(thongtin.sokyhieu);
                                        vanban.ngaybanhanh = thongtin.ngaybanhanh;
                                        vanban.trichyeu = removeScriptAndCharacter.formatTextInput(thongtin.trichyeu);
                                        vanban.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                        vanban.id_taikhoan = session.id;
                                        vanban.trangthai = 1;
                                        vanban.ngaytao = DateTime.Now;

                                        vanban.duongdanfile = removeScriptAndCharacter.formatTextInput(thongtin.duongdanfile);
                                        string path = Path.GetExtension(thongtin.duongdanfile);
                                        string icon = new Libs().getIcon(path);
                                        vanban.kieuvanban = path;
                                        vanban.icon = icon;
                                        if (thongtin.trangthaihienthi == "hienthi")
                                        {
                                            vanban.trangthai = 2;
                                        }
                                        else
                                        {
                                            vanban.trangthai = 1;
                                        }
                                        vanban.id_coquanbanhanh = thongtin.id_coquanbanhanh;
                                        vanban.id_loaivanban = thongtin.id_loaivanban;

                                        string tenVB = new Libs().ConvertUrlsToLinks(vanban.tenvanban);

                                        vanban.linkvanban = "/chi-tiet-van-ban/" + tenVB;

                                        entity.tbl_VanBan.Add(vanban);
                                        entity.SaveChanges();

                                        suscess = true;
                                        msg = "Thêm mới văn bản thành công";

                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { vanban.id_vanban, vanban.tenvanban, vanban.id_coquanbanhanh, vanban.id_loaivanban, vanban.sokyhieu, vanban.ngaybanhanh, vanban.trichyeu, vanban.noidung, vanban.id_taikhoan, vanban.trangthai, vanban.ngaytao, vanban.kieuvanban, vanban.icon, vanban.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                    }
                                    else
                                    {
                                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                                    }
                                }
                                else
                                {
                                    msg = " Tên văn bản này đã tồn tại trong hệ thống ";
                                }
                            }
                            else
                            {
                                msg = ErrorCheck;
                            }
                        }
                        else
                        {
                            msg = "Có lỗi trong quá trình thao tác dữ liệu";
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_VanBan", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }



    public void xoabaiviettrongdanhmuctintuc(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_vitribv"]))
            {
                int id_vitribv = client.ToInt(context.Request["id_vitribv"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_Vitribv.Where(m => m.id_vitribv == id_vitribv).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthaibaiviet = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa bài viết trong danh mục thành công !";

                            var checktontai = entity.tbl_Vitribv.Where(x => x.id_baiviet == check.id_baiviet && x.trangthaibaiviet != 0 && x.id_vitribv != check.id_vitribv).FirstOrDefault();
                            if (checktontai == null)
                            {
                                var checkbv = entity.tbl_Baiviet.Where(v => v.id_baiviet == check.id_baiviet).FirstOrDefault();
                                if (checkbv != null)
                                {
                                    checkbv.trangthaibaiviet = 2;
                                    entity.SaveChanges();
                                }
                            }
                            string vitri = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_vitribv, check.id_baiviet, check.id_danhmuc, check.id_datlich, check.soluotlike, check.soluotview, check.trangthaibaiviet, check.linkbaiviet, check.ngaydang } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            sucess = false;
                            msg = "Bài viết này không tồn tại trong danh mục";
                        }
                    }
                    else
                    {
                        sucess = false;
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void themmoidanhmucvalichhienthichobaiviet(HttpContext context)
    {
        bool suscess = false;
        bool trangthaibv = false;
        string msg = "";
        int _idDM = 0;

        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");
            tbl_Baiviet baiviet = new tbl_Baiviet();
            tbl_Vitribv vitri = new tbl_Vitribv();
            tbl_DatLich datlich = new tbl_DatLich();


            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["dsdanhmuc"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.baiviet thongtin = (Contructor.baiviet)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.baiviet));
                        List<int> danhsachdm = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["dsdanhmuc"], typeof(List<int>));

                        if (thongtin.hinhthuchienthi != "")
                        {
                            var check = entity.tbl_Baiviet.Where(m => m.id_baiviet == thongtin.id_baiviet).FirstOrDefault();
                            if (check != null)
                            {
                                for (int i = 0; i <= danhsachdm.Count - 1; i++)
                                {
                                    _idDM = client.ToInt(danhsachdm[i]);
                                    var checktontai = entity.tbl_Vitribv.Where(x => x.id_baiviet == check.id_baiviet && x.id_danhmuc == _idDM && x.trangthaibaiviet != 0).FirstOrDefault();
                                    if (checktontai == null)
                                    {
                                        vitri.id_baiviet = check.id_baiviet;
                                        vitri.id_danhmuc = danhsachdm[i];
                                        vitri.soluotlike = 0;
                                        vitri.soluotview = 0;
                                        if (thongtin.hinhthuchienthi == "hienthi")
                                        {
                                            vitri.trangthaibaiviet = 1;
                                            vitri.ngaydang = DateTime.Now;
                                        }
                                        else
                                        {
                                            DateTime dt = Convert.ToDateTime(thongtin.ngaydatlich);
                                            string kaka = string.Format("{0}-{1}-{2} {3}:{4}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute);
                                            DateTime dateVal = DateTime.Parse(kaka);

                                            vitri.trangthaibaiviet = 2;
                                            datlich.ngaydang = dateVal;
                                            entity.tbl_DatLich.Add(datlich);
                                            entity.SaveChanges();
                                            vitri.id_datlich = datlich.id_datlich;
                                            vitri.ngaydang = datlich.ngaydang;

                                            string vitri22 = new Libs().VitriTruyCapVaIP("tbl_DatLich", new Libs().ThietBiTruyCap());
                                            int idlog22 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { datlich.id_datlich, datlich.ngaydang } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri22);
                                            new Libs().updateKieuLogThemMoiThanhCong(idlog22);

                                        }

                                        //List<DMNgang> _list = new List<DMNgang>();
                                        //_list = new Libs().getList(danhsachdm[i], new List<DMNgang>());
                                        //string href = "";
                                        //for (int j = _list.Count - 1; j >= 0; j--)
                                        //{
                                        //    href = href + "/" + _list[j].shortcode;
                                        //}

                                        string tenbaiviet = new Libs().ConvertUrlsToLinks(check.tieude);


                                        vitri.linkbaiviet = "/chi-tiet-tin-tuc" + "/" + tenbaiviet;
                                        entity.tbl_Vitribv.Add(vitri);
                                        entity.SaveChanges();

                                        suscess = true;
                                        trangthaibv = true;
                                        msg = "Thêm mới bài viết vào danh mục thành công";

                                        string vitri2 = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                                        int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { vitri.id_vitribv, vitri.id_baiviet, vitri.id_danhmuc, vitri.soluotview, vitri.soluotlike, vitri.trangthaibaiviet, vitri.linkbaiviet, vitri.id_datlich, vitri.ngaydang } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog2);
                                    }
                                    else
                                    {
                                        msg = "Bài viết này đã tồn tại trong danh mục";
                                        string vitri3 = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                                        int idlog3 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri3);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog3);
                                    }
                                }

                                // thêm thành công thì phải update lại trang thai của bài viết 
                                if (trangthaibv == true)
                                {
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_baiviet, check.tieude, check.gioithieu, check.noidung, check.tacgia, check.ngaytao, check.tag, check.trangthaibaiviet, check.avatar, check.id_taikhoan }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    check.trangthaibaiviet = 1;
                                    entity.SaveChanges();

                                    tbl_Baiviet dataJson = (tbl_Baiviet)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_Baiviet));
                                    string vitri111 = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                                    int idlog111 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_baiviet, check.tieude, check.gioithieu, check.noidung, check.tacgia, check.ngaytao, check.tag, check.trangthaibaiviet, check.avatar, check.id_taikhoan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri111);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog111);
                                }
                            }
                            else
                            {
                                msg = "Bài viết không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = "Có lỗi trong quá trình thao tác dữ liệu";
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }

    public void capnhatthongtinbaiviettintuc(HttpContext context)
    {
        // kaka
        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");

            if (session != null)
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
                    {
                        Contructor.baiviet thongtin = (Contructor.baiviet)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.baiviet));

                        string ErrorCheck = new validateform().CallValidateUpdateBaiViet(thongtin.tieude, thongtin.gioithieu, thongtin.avatar, thongtin.tag, thongtin.noidung, thongtin.tacgia, thongtin.id_baiviet);
                        if (ErrorCheck == null)
                        {
                            var checktontai = entity.tbl_Baiviet.Where(m => m.id_baiviet == thongtin.id_baiviet).FirstOrDefault();

                            if (checktontai != null)
                            {
                                var tenmenuClient = entity.Menu_Client.Where(xxx => xxx.id_danhmuc == checktontai.idRoot && xxx.trangthai == 1).Select(xxx => xxx).FirstOrDefault();
                                if (tenmenuClient != null)
                                {

                                    var checktenbv = entity.tbl_Baiviet.Where(xx => xx.id_baiviet != checktontai.id_baiviet && xx.tieude == thongtin.tieude && xx.trangthaibaiviet != 0).FirstOrDefault();
                                    if (checktenbv == null)
                                    {
                                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_baiviet, checktontai.tieude, checktontai.gioithieu, checktontai.noidung, checktontai.tacgia, checktontai.ngaytao, checktontai.trangthaibaiviet, checktontai.tag, checktontai.avatar, checktontai.id_taikhoan }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                        checktontai.avatar = removeScriptAndCharacter.formatTextInput(thongtin.avatar);
                                        checktontai.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                        checktontai.gioithieu = removeScriptAndCharacter.formatTextInput(thongtin.gioithieu);
                                        checktontai.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                        checktontai.tacgia = removeScriptAndCharacter.formatTextInput(thongtin.tacgia);
                                        checktontai.tag = removeScriptAndCharacter.formatTextInput(thongtin.tag);

                                        string tenbaiviet = new Libs().ConvertUrlsToLinks(checktontai.tieude);

                                        checktontai.linkbaiviet = "/chi-tiet-tin-tuc" + "/" + tenbaiviet;

                                        entity.SaveChanges();
                                        suscess = true;
                                        msg = "Cập nhật thông tin thành công ";


                                        tbl_Baiviet dataJson = (tbl_Baiviet)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_Baiviet));
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_baiviet, checktontai.tieude, checktontai.gioithieu, checktontai.noidung, checktontai.tacgia, checktontai.ngaytao, checktontai.trangthaibaiviet, checktontai.tag, checktontai.avatar, checktontai.id_taikhoan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                        int idDM = 0;
                                        var capnhatbangvitri = entity.tbl_Vitribv.Where(zz => zz.id_baiviet == checktontai.id_baiviet && zz.trangthaibaiviet != 0).ToList();
                                        if (capnhatbangvitri != null)
                                        {
                                            for (int i = 0; i < capnhatbangvitri.Count(); i++)
                                            {

                                                capnhatbangvitri[i].linkbaiviet = "/chi-tiet-tin-tuc" + "/" + tenbaiviet;
                                                entity.SaveChanges();
                                            }
                                        }

                                    }
                                    else
                                    {
                                        msg = "Tên bài viết đã tồn tại vui lòng nhập tên khác";
                                    }
                                }
                                else
                                {
                                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                                }

                            }
                            else
                            {
                                msg = "Bài viết này không tồn tại trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }

            if (suscess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", suscess = suscess }, Formatting.Indented));
        }
    }

    public void xoabaiviettintuc(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["id_baiviet"]))
            {
                int id_baiviet = client.ToInt(context.Request["id_baiviet"]);

                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_Baiviet.Where(m => m.id_baiviet == id_baiviet).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthaibaiviet = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa bài viết thành công !";

                            var checkdanhmuchienthi = entity.tbl_Vitribv.Where(x => x.id_baiviet == check.id_baiviet).ToList();
                            if (checkdanhmuchienthi.Count > 0)
                            {
                                for (int i = 0; i < checkdanhmuchienthi.Count; i++)
                                {
                                    int idVitri = checkdanhmuchienthi[i].id_vitribv;
                                    checkdanhmuchienthi[i].trangthaibaiviet = 0;
                                    entity.SaveChanges();

                                    string vitri1 = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                                    int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkdanhmuchienthi[i].id_vitribv, checkdanhmuchienthi[i].id_baiviet, checkdanhmuchienthi[i].id_danhmuc, checkdanhmuchienthi[i].soluotview, checkdanhmuchienthi[i].soluotlike, checkdanhmuchienthi[i].trangthaibaiviet, checkdanhmuchienthi[i].linkbaiviet, checkdanhmuchienthi[i].id_datlich, checkdanhmuchienthi[i].ngaydang } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                    new Libs().updateKieuLogXoaThanhCong(idlog1);
                                }
                            }
                            string vitri = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_baiviet, check.tieude, check.gioithieu, check.noidung, check.tacgia, check.ngaytao, check.tag, check.trangthaibaiviet, check.avatar, check.id_taikhoan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            sucess = false;
                            msg = "Bài viết này không tồn tại ";
                        }
                    }
                    else
                    {
                        sucess = false;
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }

    public void loadalldanhsachbaiviet(HttpContext context)
    {

        try
        {
            int id = int.Parse(context.Request["id"]);

            // phân trang
            int minrow = 0;
            int maxrow = 0;
            int.TryParse(context.Request["start"], out minrow);
            int length = 10;
            int.TryParse(context.Request["length"], out length);
            maxrow = (minrow + length);
            int draw = 0;
            int.TryParse(context.Request["draw"], out draw);
            int numberpage = maxrow / 10;
            // phân trang

            if (session != null)
            {
                string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
                Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

                ObjectParameter totalCount = new ObjectParameter("totalCount", typeof(int));
                var ds = entity.sp_loadall_tintucsukien(id, numberpage, 10, totalCount).Select(m => new
                {
                    m.id_baiviet,
                    m.tieude,
                    m.gioithieu,
                    m.noidung,
                    m.tacgia,
                    ngaytao = m.ngaytao.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                    m.tag,
                    m.trangthaibaiviet,
                    m.avatar,
                    m.id_taikhoan,
                    ngaythang = m.ngaytao,
                    button = new
                    {
                        m.id_baiviet,
                        cn.xem,
                        cn.them,
                        cn.sua,
                        cn.xoa
                    },
                    danhsach = entity.tbl_Vitribv.Where(x => x.id_baiviet == m.id_baiviet && x.trangthaibaiviet != 0).ToList().Select(x => new
                        {
                            x.id_vitribv,
                            x.id_baiviet,
                            id_danhmuc = (x.id_danhmuc != null) ? x.id_danhmuc : 0,
                            id_datlich = (x.id_datlich != null) ? x.id_datlich : 0,
                            soluotlike = (x.soluotlike != null) ? x.soluotlike : 0,
                            soluotview = (x.soluotview != null) ? x.soluotview : 0,
                            x.trangthaibaiviet,
                            linkbaiviet = (x.linkbaiviet != null) ? x.linkbaiviet : "",
                            ngaydang = (x.ngaydang != null) ? x.ngaydang : null,
                            ngayhengio = (x.id_datlich != null) ? x.tbl_DatLich.ngaydang : null,
                            tendanhmuc = (x.id_danhmuc != null) ? x.Menu_Client.tendanhmuc : "",
                            time = (x.ngaydang != null) ? x.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy") : x.tbl_DatLich.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                            details = new
                            {
                                id = x.id_baiviet,
                                status = x.trangthaibaiviet,
                            }
                        }).ToList()
                }).ToList(); ;


                //var danhsach = entity.tbl_Baiviet.Where(m => ((id == 0) ? true : m.id_baiviet == id) && m.trangthaibaiviet != 0 && m.idRoot == 3 && m.tenRoot == "tintucsukien").ToList().OrderByDescending(m => m.ngaytao).Select(m => new
                //{
                //    m.id_baiviet,
                //    m.tieude,
                //    m.gioithieu,
                //    m.noidung,
                //    m.tacgia,
                //    ngaytao = m.ngaytao.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                //    m.tag,
                //    m.trangthaibaiviet,
                //    m.avatar,
                //    m.id_taikhoan,
                //    ngaythang = m.ngaytao,
                //    button = new
                //    {
                //        m.id_baiviet,
                //        cn.xem,
                //        cn.them,
                //        cn.sua,
                //        cn.xoa
                //    },
                //    danhsach = m.tbl_Vitribv.Where(x => x.id_baiviet == m.id_baiviet && x.trangthaibaiviet != 0).ToList().Select(x => new
                //        {
                //            x.id_vitribv,
                //            x.id_baiviet,
                //            id_danhmuc = (x.id_danhmuc != null) ? x.id_danhmuc : 0,
                //            id_datlich = (x.id_datlich != null) ? x.id_datlich : 0,
                //            soluotlike = (x.soluotlike != null) ? x.soluotlike : 0,
                //            soluotview = (x.soluotview != null) ? x.soluotview : 0,
                //            x.trangthaibaiviet,
                //            linkbaiviet = (x.linkbaiviet != null) ? x.linkbaiviet : "",
                //            ngaydang = (x.ngaydang != null) ? x.ngaydang : null,
                //            ngayhengio = (x.id_datlich != null) ? x.tbl_DatLich.ngaydang : null,
                //            tendanhmuc = (x.id_danhmuc != null) ? x.Menu_Client.tendanhmuc : "",
                //            time = (x.ngaydang != null) ? x.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy") : x.tbl_DatLich.ngaydang.Value.ToString("HH:mm:ss dd-MM-yyyy"),
                //            details = new
                //            {
                //                id = x.id_baiviet,
                //                status = x.trangthaibaiviet,
                //            }
                //        }).ToList()
                //}).ToList();

                int total = 0;
                int.TryParse(totalCount.Value.ToString(), out total);


                context.Response.ContentType = "text/plain";
                context.Response.Write(JsonConvert.SerializeObject(new
                {
                    maxrow = maxrow,
                    minrow = minrow,
                    data = ds,
                    draw = (draw),
                    recordsFiltered = total,
                    recordsTotal = total
                }, Formatting.Indented));
            }
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = 0 }, Formatting.Indented));
        }
    }

    // vị trí bài viết:xóa = 0; hiển thị  = 1;hẹn giờ =2
    // bài viết : xóa = 0; đã sư dung = 1; lưu nháp =2
    public void themmoibaiviet(HttpContext context)
    {
        bool suscess = false;
        string msg = "";

        try
        {
            String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
            String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");

            tbl_Baiviet baiviet = new tbl_Baiviet();
            tbl_Vitribv vitri = new tbl_Vitribv();
            tbl_DatLich datlich = new tbl_DatLich();


            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["dsdanhmuc"]))
                {
                    if (new Libs().QuyenThemMoi())
                    {
                        Contructor.baiviet thongtin = (Contructor.baiviet)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.baiviet));
                        List<int> danhsachdm = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["dsdanhmuc"], typeof(List<int>));

                        string ErrorCheck = new validateform().CallValidateThemBaiViet(thongtin.tieude, thongtin.gioithieu, thongtin.avatar, thongtin.tag, thongtin.noidung, thongtin.tacgia, thongtin.hinhthuchienthi, danhsachdm, thongtin.ngaydatlich);
                        if (ErrorCheck == null)
                        {
                            var tenmenuClient = entity.Menu_Client.Where(xxx => xxx.id_danhmuc == thongtin.idRoot && xxx.trangthai == 1).Select(xxx => xxx).FirstOrDefault();
                            if (tenmenuClient != null)
                            {
                                if (thongtin.hinhthuchienthi != "")
                                {
                                    var chechtenbaiviet = entity.tbl_Baiviet.Where(m => m.tieude == thongtin.tieude && m.trangthaibaiviet != 0).FirstOrDefault();
                                    if (chechtenbaiviet == null)
                                    {
                                        baiviet.tieude = removeScriptAndCharacter.formatTextInput(thongtin.tieude);
                                        baiviet.gioithieu = removeScriptAndCharacter.formatTextInput(thongtin.gioithieu);
                                        baiviet.avatar = removeScriptAndCharacter.formatTextInput(thongtin.avatar);
                                        baiviet.noidung = removeScriptAndCharacter.formatTextInput(thongtin.noidung);
                                        baiviet.tacgia = removeScriptAndCharacter.formatTextInput(thongtin.tacgia);
                                        baiviet.ngaytao = DateTime.Now;
                                        baiviet.tag = removeScriptAndCharacter.formatTextInput(thongtin.tag);
                                        if ((thongtin.hinhthuchienthi == "hienthi" || thongtin.hinhthuchienthi == "hengio"))
                                        {
                                            baiviet.trangthaibaiviet = 1;
                                        }
                                        else
                                        {
                                            baiviet.trangthaibaiviet = 2;
                                        }
                                        string tenbaiviet = new Libs().ConvertUrlsToLinks(baiviet.tieude);

                                        baiviet.idRoot = tenmenuClient.id_danhmuc;
                                        baiviet.tenRoot = tenmenuClient.shortcode;

                                        baiviet.linkbaiviet = "/chi-tiet-tin-tuc" + "/" + tenbaiviet;

                                        baiviet.id_taikhoan = session.id;
                                        entity.tbl_Baiviet.Add(baiviet);
                                        entity.SaveChanges();
                                        suscess = true;
                                        msg = "Thêm mới bài viết thành công";
                                        string vitri1 = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                                        int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { baiviet.id_baiviet, baiviet.tieude, baiviet.gioithieu, baiviet.noidung, baiviet.tacgia, baiviet.ngaytao, baiviet.tag, baiviet.trangthaibaiviet, baiviet.avatar, baiviet.id_taikhoan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog1);

                                        int a = 0;
                                        string shortcode = "";
                                        if ((thongtin.hinhthuchienthi == "hienthi" || thongtin.hinhthuchienthi == "hengio") && (danhsachdm.Count > 0))
                                        {

                                            for (int i = 0; i < danhsachdm.Count; i++)
                                            {
                                                vitri.id_baiviet = baiviet.id_baiviet;
                                                vitri.id_danhmuc = danhsachdm[i];
                                                vitri.soluotview = 0;
                                                vitri.soluotlike = 0;
                                                if (thongtin.hinhthuchienthi == "hienthi")
                                                {
                                                    vitri.trangthaibaiviet = 1;
                                                    vitri.ngaydang = DateTime.Now;
                                                }
                                                else
                                                {
                                                    DateTime dt = Convert.ToDateTime(thongtin.ngaydatlich);
                                                    string kaka = string.Format("{0}-{1}-{2} {3}:{4}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute);
                                                    DateTime dateVal = DateTime.Parse(kaka);

                                                    vitri.trangthaibaiviet = 2;
                                                    datlich.ngaydang = dateVal;
                                                    entity.tbl_DatLich.Add(datlich);
                                                    entity.SaveChanges();
                                                    vitri.id_datlich = datlich.id_datlich;
                                                    vitri.ngaydang = datlich.ngaydang;
                                                }

                                                vitri.linkbaiviet = "/chi-tiet-tin-tuc" + "/" + tenbaiviet;
                                                entity.tbl_Vitribv.Add(vitri);
                                                entity.SaveChanges();

                                                suscess = true;
                                                msg = "Thêm mới bài viết thành công";


                                                string vitri2 = new Libs().VitriTruyCapVaIP("tbl_Vitribv", new Libs().ThietBiTruyCap());
                                                int idlog2 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { vitri.id_vitribv, vitri.id_baiviet, vitri.id_danhmuc, vitri.soluotview, vitri.soluotlike, vitri.trangthaibaiviet, vitri.linkbaiviet, vitri.id_datlich, vitri.ngaydang } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri2);
                                                new Libs().updateKieuLogThemMoiThanhCong(idlog2);

                                            }
                                        }
                                    }
                                    else
                                    {
                                        msg = "Tên bài viết đã tồn tại vui lòng chọn tên khác";
                                    }
                                }
                                else
                                {
                                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                                }
                            }
                            else
                            {
                                msg = "Menu không tồn tại ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Bạn không có quyền thực hiện chức năng này";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Session không tồn tại ";
            }
            if (suscess == false)
            {
                string vitri5 = new Libs().VitriTruyCapVaIP("tbl_Baiviet", new Libs().ThietBiTruyCap());
                int idlog5 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri5);
                new Libs().updateKieuLogThemMoiThatBai(idlog5);
            }

            HttpContext.Current.Response.ContentType = "text/plain";
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", suscess = suscess }, Formatting.Indented));
        }
    }

    public void loaddanhsachdanhmuctintuc(HttpContext context)
    {
        List<Libs.jsonmenuClient> oDanhMuc = new List<Libs.jsonmenuClient>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.Menu_Client.Where(m => m.idParent == 0 && m.trangthai == 1 && m.id_danhmuc == 3).ToList().All(x =>
        {
            Libs.jsonmenuClient m = new Libs.jsonmenuClient();
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
            new Libs().getDanhMucClient(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }

    public void thaydoitrangthaihienthimenu(HttpContext context)
    {
        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        int idDanhmucSel = 0;
        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["idDanhmucSel"]) && new Libs().checkDuLieuGuiLen(context.Request["tenmenu"]))
            {
                if (new Libs().QuyenSuaTrongTrang())
                {
                    //    int idDanhmucSel = int.Parse(context.Request["idDanhmucSel"]);
                    string tenmenu = context.Request["tenmenu"];
                    bool trangthai = false;
                    int.TryParse(context.Request["idDanhmucSel"], out idDanhmucSel);

                    //var checkmenuClient = entity.Menu_Client.Where(zzz => zzz.id_danhmuc == idDanhmucSel).FirstOrDefault();
                    //if (checkmenuClient != null)
                    //{

                    //    if (checkmenuClient.trangthai == 1)
                    //    {
                    //        checkmenuClient.trangthai = 0;
                    //    }
                    //    else
                    //    {
                    //        checkmenuClient.trangthai = 1;
                    //    }
                    //    entity.SaveChanges();
                    //}

                    var check = entity.Vitri_Menu.Where(m => m.id_danhmuc == idDanhmucSel && m.trangthai == true).FirstOrDefault();
                    if (check != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_danhmuc, check.id_vitrimenu, check.menubottom, check.menuright, check.menutop, check.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        if (tenmenu == "menutren")
                        {
                            if (check.menutop == true)
                            {
                                check.menutop = false;
                            }
                            else
                            {
                                check.menutop = true;
                            }
                        }
                        else if (tenmenu == "menutrai")
                        {
                            if (check.menuright == true)
                            {
                                check.menuright = false;
                            }
                            else
                            {
                                check.menuright = true;
                            }
                        }
                        else if (tenmenu == "menuduoi")
                        {
                            if (check.menubottom == true)
                            {
                                check.menubottom = false;
                            }
                            else
                            {
                                check.menubottom = true;
                            }
                        }
                        suscess = true;
                        msg = "Cập nhật thông tin thành công ";
                        entity.SaveChanges();

                        Vitri_Menu dataJson = (Vitri_Menu)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(Vitri_Menu));
                        string vitri = new Libs().VitriTruyCapVaIP("Vitri_Menu", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_danhmuc, check.id_vitrimenu, check.menubottom, check.menuright, check.menutop, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                    }
                    else
                    {
                        Vitri_Menu vtmn = new Vitri_Menu();
                        vtmn.id_danhmuc = idDanhmucSel;
                        vtmn.trangthai = true;

                        if (tenmenu == "menutren")
                        {
                            vtmn.menutop = true;
                            vtmn.menubottom = false;
                            vtmn.menuright = false;
                        }
                        else if (tenmenu == "menutrai")
                        {
                            vtmn.menuright = true;
                            vtmn.menutop = false;
                            vtmn.menubottom = false;
                        }
                        else if (tenmenu == "menuduoi")
                        {
                            vtmn.menubottom = true;
                            vtmn.menuright = false;
                            vtmn.menutop = false;
                        }
                        entity.Vitri_Menu.Add(vtmn);
                        entity.SaveChanges();
                        suscess = true;
                        msg = "Cập nhật thông tin thành công ";

                        string vitri = new Libs().VitriTruyCapVaIP("Vitri_Menu", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { vtmn.id_vitrimenu, vtmn.id_danhmuc, vtmn.menutop, vtmn.menuright, vtmn.menubottom, vtmn.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Vitri_Menu", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);

        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }

    public void dichuyendanhmuc(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        string msg = "Di chuyển không thành công ";
        int _idthumuc = 0, _idparent = 0;
        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idparent"]) && new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]))
            {
                //int _idthumuc = int.Parse(context.Request["_idthumuc"]);
                //int _idparent = int.Parse(context.Request["_idparent"]);


                int.TryParse(context.Request["_idthumuc"], out _idthumuc);
                int.TryParse(context.Request["_idparent"], out _idparent);
                if (new Libs().QuyenSuaTrongTrang())
                {
                    var check = entity.Menu_Client.Where(m => m.id_danhmuc == _idthumuc).FirstOrDefault();
                    var checkcha = entity.Menu_Client.Where(x => x.id_danhmuc == _idparent).FirstOrDefault();

                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_danhmuc, check.tendanhmuc, check.link_danhmuc, check.trangthai, check.sothutu, check.idParent, check.shortcode, check.duongdan, check.icon, check.socapdanhmuc }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                    if (check != null && checkcha != null)
                    {
                        check.idParent = _idparent;

                        List<DMNgang> _list = new List<DMNgang>();
                        _list = new Libs().getList(_idparent, new List<DMNgang>());
                        string href = "";
                        for (int j = _list.Count - 1; j >= 0; j--)
                        {
                            if (_list[j].idParent.Value == 0)
                            {
                                href = "/" + _list[j].shortcode;
                            }
                            //  href = href + "/" + _list[j].shortcode;
                        }
                        check.duongdan = href + "/" + check.link_danhmuc;

                        entity.SaveChanges();
                        suscess = true;
                        msg = "Di chuyển danh mục thành công ";

                        Menu_Client dataJson = (Menu_Client)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(Menu_Client));
                        string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_danhmuc, check.tendanhmuc, check.link_danhmuc, check.trangthai, check.sothutu, check.idParent, check.shortcode, check.duongdan, check.icon, check.socapdanhmuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                    }
                    else
                    {
                        msg = "Danh mục không tồn tại trong hệ thống";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này ";
                }
            }
            else
            {
                msg = "Có lỗi khi thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }
        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }

    public void xoadanhmuc(HttpContext context)
    {

        bool suscess = false;
        string msg = "Bạn không có quyền với chức năng này";
        bool quyen = false;
        int idnode = 0;

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idnode"]))
            {
                // int idnode = int.Parse(context.Request["_idnode"]);
                int.TryParse(context.Request["_idnode"], out idnode);
                if (new Libs().QuyenXoaTrongTrang())
                {

                    var check = entity.Menu_Client.Where(m => m.id_danhmuc == idnode).FirstOrDefault();
                    if (check != null)
                    {
                        var kiemtraxoa = entity.Menu_Client.Where(x => x.idParent == check.id_danhmuc && x.trangthai == 1).FirstOrDefault();
                        if (kiemtraxoa == null)
                        {
                            var xoabangvitri = entity.Vitri_Menu.Where(m => m.id_danhmuc == idnode).FirstOrDefault();
                            if (xoabangvitri != null)
                            {
                                xoabangvitri.trangthai = false;
                                entity.SaveChanges();
                            }
                            check.trangthai = 0;
                            entity.SaveChanges();
                            suscess = true;
                            msg = "Xóa danh mục thành công";

                            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_danhmuc, check.tendanhmuc, check.link_danhmuc, check.trangthai, check.sothutu, check.idParent, check.shortcode, check.duongdan, check.icon } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Bạn không thể xóa danh mục này vì nó còn thông tin bên trong";
                        }
                    }
                    else
                    {
                        msg = "Danh mục không tồn tại ";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi với dữ liệu trong quá trình thao tác";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }



    public void capnhatthongtindanhmuc(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        bool quyen = false;
        int idDanhmucSel = 0, sothutu = 0;


        if (session != null)
        {
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["idDanhmucSel"]) && new Libs().checkDuLieuGuiLen(context.Request["tendanhmuc"]) && new Libs().checkDuLieuGuiLen(context.Request["sothutu"]))
                {
                    //int idDanhmucSel = int.Parse(context.Request["idDanhmucSel"]);
                    string tendanhmuc = context.Request["tendanhmuc"];
                    // int sothutu = int.Parse(context.Request["sothutu"]);

                    //   string linktrang = context.Request["linktrang"];

                    int.TryParse(context.Request["idDanhmucSel"], out idDanhmucSel);
                    int.TryParse(context.Request["sothutu"], out sothutu);

                    var checktontai = entity.Menu_Client.Where(m => m.id_danhmuc == idDanhmucSel).FirstOrDefault();
                    var checkten = entity.Menu_Client.Where(x => x.id_danhmuc != idDanhmucSel && x.tendanhmuc == tendanhmuc).FirstOrDefault();

                    if (checktontai != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_danhmuc, checktontai.tendanhmuc, checktontai.link_danhmuc, checktontai.trangthai, checktontai.sothutu, checktontai.idParent, checktontai.shortcode, checktontai.duongdan, checktontai.icon }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        if (checkten == null)
                        {

                            string tenrutgon = new Libs().ConvertUrlsToLinks(tendanhmuc);
                            string _shortcode = tenrutgon.Replace("-", "");

                            checktontai.tendanhmuc = tendanhmuc;
                            checktontai.link_danhmuc = tenrutgon;
                            checktontai.sothutu = sothutu;
                            checktontai.shortcode = _shortcode;
                            //   checktontai.duongdan = linktrang;

                            List<DMNgang> _list = new List<DMNgang>();
                            _list = new Libs().getList(checktontai.idParent.Value, new List<DMNgang>());
                            string href = "";
                            for (int j = _list.Count - 1; j >= 0; j--)
                            {
                                if (_list[j].idParent.Value == 0)
                                {
                                    href = "/" + _list[j].shortcode;
                                }

                                // href = href + "/" + _list[j].shortcode;
                            }
                            checktontai.duongdan = href + "/" + tenrutgon;


                            entity.SaveChanges();
                            suscess = true;
                            msg = "Cập nhật thông tin thành công ";


                            Menu_Client dataJson = (Menu_Client)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(Menu_Client));
                            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_danhmuc, checktontai.tendanhmuc, checktontai.link_danhmuc, checktontai.trangthai, checktontai.sothutu, checktontai.idParent, checktontai.shortcode, checktontai.duongdan, checktontai.icon } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Tên danh mục này đã tồn tại trong hệ thống vui lòng chọn tên khác";
                        }
                    }
                    else
                    {
                        msg = "Danh mục này không tồn tại trong hệ thống";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void loadthongtindanhmuctheoID(HttpContext context)
    {
        bool suscess = false;
        string msg = "Load thông tin thất bại ";

        if (session != null && new Libs().checkDuLieuGuiLen(context.Request["idDanhmucSel"]))
        {
            int idDanhmucSel = int.Parse(context.Request["idDanhmucSel"]);
            var thongtin = entity.Menu_Client.Where(m => m.id_danhmuc == idDanhmucSel).Select(m => new
            {
                m.id_danhmuc,
                m.tendanhmuc,
                m.link_danhmuc,
                m.trangthai,
                m.sothutu,
                m.idParent,
                m.shortcode,
                m.duongdan,
                m.icon,
                m.socapdanhmuc


            }).FirstOrDefault();
            if (thongtin != null)
            {
                context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, thongtin = thongtin }, Formatting.Indented));
            }
        }
    }

    public void doitendanhmuc(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        bool quyen = false;
        int _idthumuc = 0;

        if (session != null)
        {
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["_tenmoi"]))
                {
                    //   int _idthumuc = int.Parse(context.Request["_idthumuc"]);
                    int.TryParse(context.Request["_idthumuc"], out _idthumuc);
                    string _tenmoi = context.Request["_tenmoi"];

                    var checktontai = entity.Menu_Client.Where(m => m.id_danhmuc == _idthumuc).FirstOrDefault();
                    var checkten = entity.Menu_Client.Where(x => x.id_danhmuc != _idthumuc && x.tendanhmuc == _tenmoi).FirstOrDefault();

                    if (checktontai != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { checktontai.id_danhmuc, checktontai.tendanhmuc, checktontai.link_danhmuc, checktontai.trangthai, checktontai.sothutu, checktontai.idParent, checktontai.shortcode, checktontai.duongdan, checktontai.icon }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        if (checkten == null)
                        {

                            string tenrutgon = new Libs().ConvertUrlsToLinks(_tenmoi);
                            string _shortcode = tenrutgon.Replace("-", "");


                            checktontai.tendanhmuc = _tenmoi;
                            checktontai.shortcode = _shortcode;
                            checktontai.link_danhmuc = tenrutgon;


                            List<DMNgang> _list = new List<DMNgang>();
                            _list = new Libs().getList(checktontai.idParent.Value, new List<DMNgang>());
                            string href = "";
                            for (int j = _list.Count - 1; j >= 0; j--)
                            {
                                if (_list[j].idParent.Value == 0)
                                {
                                    href = "/" + _list[j].shortcode;
                                }
                            }
                            checktontai.duongdan = href + "/" + tenrutgon;

                            entity.SaveChanges();
                            suscess = true;
                            msg = "Đổi tên thư mục thành công ";


                            Menu_Client dataJson = (Menu_Client)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(Menu_Client));
                            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checktontai.id_danhmuc, checktontai.tendanhmuc, checktontai.link_danhmuc, checktontai.trangthai, checktontai.sothutu, checktontai.idParent, checktontai.shortcode, checktontai.duongdan, checktontai.icon } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                        }
                        else
                        {
                            msg = "Tên danh mục này đã tồn tại trong hệ thống vui lòng chọn tên khác";
                        }
                    }
                    else
                    {
                        msg = "Danh mục này không tồn tại trong hệ thống";
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác dữ liệu";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void themmoidanhmuctrongmenu(HttpContext context)
    {

        bool suscess = false;

        String strPathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
        String strUrl = HttpContext.Current.Request.Url.AbsoluteUri.Replace(strPathAndQuery, "");

        int idDanhmuc = 0;
        int idcha = 0, sothutu = 0, SoChaDanhMuc = 0;
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        if (new Libs().QuyenThemMoi())
        {
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["_idcha"]) && new Libs().checkDuLieuGuiLen(context.Request["_tencon"]) && new Libs().checkDuLieuGuiLen(context.Request["_sothutu"]) && new Libs().checkDuLieuGuiLen(context.Request["SoChaDanhMuc"]))
                {
                    string tencon = context.Request["_tencon"];

                    //int idcha = int.Parse(context.Request["_idcha"]);
                    //int sothutu = int.Parse(context.Request["_sothutu"]);
                    //   string linktrang = context.Request["_linktrang"];
                    //int SoChaDanhMuc = int.Parse(context.Request["SoChaDanhMuc"]);
                    int.TryParse(context.Request["_idcha"], out idcha);
                    int.TryParse(context.Request["_sothutu"], out sothutu);
                    int.TryParse(context.Request["SoChaDanhMuc"], out SoChaDanhMuc);

                    var checkten = entity.Menu_Client.Where(m => m.tendanhmuc == tencon).FirstOrDefault();
                    if (checkten == null)
                    {
                        int a = 0;
                        int socapduocthem = 0;
                        new Libs().getRoot2(idcha, out a, out socapduocthem);
                        if (socapduocthem > SoChaDanhMuc)
                        {
                            string tenrutgon = new Libs().ConvertUrlsToLinks(tencon);
                            string _shortcode = tenrutgon.Replace("-", "");

                            Menu_Client mnClient = new Menu_Client();
                            mnClient.tendanhmuc = tencon;
                            mnClient.link_danhmuc = tenrutgon;
                            mnClient.trangthai = 1;
                            mnClient.sothutu = sothutu;
                            mnClient.idParent = idcha;
                            mnClient.shortcode = _shortcode;



                            List<DMNgang> _list = new List<DMNgang>();
                            _list = new Libs().getList(idcha, new List<DMNgang>());
                            string href = "";
                            for (int j = _list.Count - 1; j >= 0; j--)
                            {
                                //   href = href + "/" + _list[j].shortcode;

                                if (_list[j].idParent.Value == 0)
                                {
                                    href = "/" + _list[j].shortcode;
                                }
                            }
                            mnClient.duongdan = href + "/" + tenrutgon;

                            mnClient.icon = "fa fa-plus-square-o";
                            entity.Menu_Client.Add(mnClient);
                            int kq1 = entity.SaveChanges();
                            if (kq1 != 0)
                            {
                                idDanhmuc = mnClient.id_danhmuc;
                                suscess = true;
                                msg = "Thêm mới danh mục thành công ";

                                string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { mnClient.id_danhmuc, mnClient.tendanhmuc, mnClient.link_danhmuc, mnClient.trangthai, mnClient.sothutu, mnClient.idParent, mnClient.shortcode, mnClient.duongdan, mnClient.icon } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog);
                            }
                        }
                        else
                        {
                            msg = "Danh mục này chỉ được thêm tối đã " + socapduocthem + " cấp";
                        }
                    }
                    else
                    {
                        msg = "Tên danh mục này đã tồn tại vui lòng nhập tên khác";
                    }

                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác";
                }
            }
            else
            {
                msg = "Session không tồn tại";
            }
        }
        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("Menu_Client", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }

        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess, idDanhmuc = idDanhmuc }, Formatting.Indented));

    }



    public void loadkeythumucmenuclient(HttpContext context)
    {
        List<Libs.jsonmenu> oDanhMuc = new List<Libs.jsonmenu>();
        string href = string.Format("/{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));
        int id_tm = int.Parse(context.Request["id_tm"]);
        List<Libs.jsTree> data = new List<Libs.jsTree>();
        entity.Menu_Client.Where(m => m.idParent == id_tm && m.trangthai == 1).ToList().OrderByDescending(x => x.sothutu.Value).All(x =>
        {

            Libs.jsonthumuc json = new Libs.jsonthumuc();
            Libs.jsTree item = new Libs.jsTree();
            item.text = x.tendanhmuc;
            item.id = x.id_danhmuc;
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



    //public void resetmatkhau(HttpContext context)
    //{
    //    string msg = "Sảy ra lỗi trong quá trình thao tác";
    //    bool sucess = false;

    //    if (new Libs().checkDuLieuGuiLen(context.Request["matkhau"]))
    //    {
    //        string mkmoi = context.Request["matkhau"];
    //        string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri;
    //        var uri = new Uri(returnVal);
    //        string keyLink = "";
    //        int Segmentss = uri.Segments.Length - 1;
    //        keyLink = uri.Segments[Segmentss];

    //        var checkKey = entity.tbl_LogResetMatKhau.Where(m => m.malink == keyLink && m.trangthai == false).FirstOrDefault();
    //        if (checkKey != null)
    //        {
    //            DateTime dateT = DateTime.Now;
    //            DateTime ngaytao = checkKey.ngaytao.Value;
    //            DateTime ngayhethan = ngaytao.AddDays(1);

    //            if (ngayhethan > dateT)
    //            {
    //                var tk = entity.TaiKhoan.Where(xx => xx.id_taikhoan == checkKey.id_taikhoan).FirstOrDefault();
    //                if (tk != null)
    //                {
    //                    string resulf = new Libs().validateLogin(mkmoi);
    //                    if (resulf == "")
    //                    {
    //                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { tk.taikhoan1, tk.tendaydu, tk.email, tk.sodienthoai, tk.trangthaitk, tk.id_nhomadmin, tk.id_taikhoan, tk.matkhau, tk.ngaytao, tk.loaitaikhoan, tk.avatar }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

    //                        tk.matkhau = MD5.GeneratePasswordHash(mkmoi);
    //                        entity.SaveChanges();

    //                        checkKey.trangthai = true;
    //                        checkKey.matkhaumoi = MD5.GeneratePasswordHash(mkmoi);

    //                        entity.SaveChanges();
    //                        sucess = true;
    //                        msg = "Reset mật khẩu thành công ";

    //                        string mailto = tk.email;
    //                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", tk.tendaydu);
    //                        string body = string.Format("Xin chào {0} !<br />Bạn đã thực hiện reset mật khẩu thành công .<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", tk.tendaydu);
    //                        bool guimail = new Libs().sendEmail(mailto, subject, body);


    //                        string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
    //                        int idlog = new Libs().LuuLogHoatDong(tk.id_taikhoan, JsonConvert.SerializeObject(new { thongtindangky = new { checkKey.id_LogReset, checkKey.id_taikhoan, checkKey.ngaytao, checkKey.trangthai, checkKey.malink, checkKey.matkhaumoi, checkKey.matkhaucu } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
    //                        new Libs().ResetThanhCong(idlog);

    //                        TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
    //                        string vitri1 = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
    //                        int idlog1 = new Libs().LuuLogHoatDong(tk.id_taikhoan, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { tk.taikhoan1, tk.tendaydu, tk.email, tk.sodienthoai, tk.trangthaitk, tk.id_nhomadmin, tk.id_taikhoan, tk.matkhau, tk.ngaytao, tk.loaitaikhoan, tk.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
    //                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog1);
    //                    }
    //                    else
    //                    {
    //                        msg = "Reset mật khẩu thất bại ! </br>" + resulf;
    //                    }
    //                }
    //                else
    //                {
    //                    msg = "Tài khoản không tồn tại trong hệ thống";
    //                }
    //            }
    //            else
    //            {
    //                msg = "Link reset mật khẩu chỉ có hiệu lực trong 1 ngày";
    //            }
    //        }
    //        else
    //        {
    //            msg = "Vui lòng thực hiện lại reset mật khẩu";
    //        }
    //    }
    //    else
    //    {
    //        msg = "Có lỗi trong quá trình thao tác dữ liệu";
    //    }
    //    if (sucess == false)
    //    {
    //        string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
    //        int idlog = new Libs().LuuLogHoatDongResetMKFail(JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
    //        new Libs().ResetMKThatBai(idlog);
    //    }
    //    context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
    //}



    public void xacthucemailkhiquyenmatkhau(HttpContext context)
    {
        string msg = "Sảy ra lỗi trong quá trình thao tác";
        bool sucess = false;
        DateTime dateS = DateTime.Now;
        if (new Libs().checkDuLieuGuiLen(context.Request["emailcanhan"]))
        {
            string email = context.Request["emailcanhan"];
            var check = entity.TaiKhoan.Where(m => m.email == email).FirstOrDefault();

            if (check != null)
            {
                //var checksend = entity.tbl_LogResetMatKhau.Where(x => x.id_taikhoan == check.id_taikhoan && x.trangthai == false && x.ngaytao.AddDays(1) > dateS).FirstOrDefault();
                //if (checksend == null)
                //{
                sucess = true;
                msg = "Chúng tôi đã gửi link khôi phục mật khẩu vào email của bạn. Vui lòng check email để tiếp tục ";
                tbl_LogResetMatKhau reset = new tbl_LogResetMatKhau();
                reset.id_taikhoan = check.id_taikhoan;
                reset.ngaytao = DateTime.Now;
                reset.trangthai = false;
                reset.malink = MD5.RandomString(20);
                reset.matkhaucu = check.matkhau;

                entity.tbl_LogResetMatKhau.Add(reset);
                entity.SaveChanges();

                string returnVal = HttpContext.Current.Request.UrlReferrer.AbsoluteUri + "reset-mat-khau/" + reset.malink;

                string mailto = check.email;
                string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", check.tendaydu);
                string body = string.Format("Xin chào {0} !<br />Chúng tôi đã nhận được yêu cầu reset mật khẩu cá nhân của bạn trong hệ thống . <br />Chúng tôi gửi email này để xác nhận rằng bạn chính là người thực hiện gửi yêu cầu .<br />Vui lòng click vào link bên dưới để hoàn tất việc cấp lại mật khẩu . <br />{1} .<br />Nếu không phải bạn mà là ai khác vui lòng liên hệ với chúng tôi để được hỗ trợ .<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", check.tendaydu, returnVal);
                bool guimail = new Libs().sendEmail(mailto, subject, body);


                string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(check.id_taikhoan, JsonConvert.SerializeObject(new { thongtindangky = new { reset.id_LogReset, reset.id_taikhoan, reset.malink, reset.matkhaucu, reset.matkhaumoi, reset.trangthai, check.ngaytao } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().ResetThanhCong(idlog);

                //}
                //else
                //{
                //    msg = "Bạn không thể gửi thêm yêu cầu khi chưa sử dụng link mà chúng tôi cung cấp trước đó (link đã gửi chưa hết thời hạn sử dụng)";
                //}
            }
            else
            {
                msg = "Email bạn cung cấp không tồn tại trong hệ thống ";
            }
        }
        else
        {
            msg = "Xảy ra lỗi trong quá trình thao tác ";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("tbl_LogResetMatKhau", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDongResetMKFail(JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().ResetMKThatBai(idlog);
        }
        context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
    }
    public void thaydoimatkhaucanhan(HttpContext context)
    {
        string msg = "Sảy ra lỗi trong quá trình thao tác";
        bool sucess = false;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["matkhaucu"]) && new Libs().checkDuLieuGuiLen(context.Request["matkhau"]) && new Libs().checkDuLieuGuiLen(context.Request["matkhau2"]) && new Libs().checkDuLieuGuiLen(context.Request["email"]))
            {
                string mkcu = removeScriptAndCharacter.formatTextInput(context.Request["matkhaucu"]);
                string mkmoi = removeScriptAndCharacter.formatTextInput(context.Request["matkhau"]);
                string mkmoi2 = removeScriptAndCharacter.formatTextInput(context.Request["matkhau2"]);
                string email = removeScriptAndCharacter.formatTextInput(context.Request["email"]);
                if (session != null)
                {
                    string ErrorCheck = new validateform().CallValidateDoiMatKhauAdmin(mkcu, mkmoi, mkmoi2, email);
                    if (ErrorCheck == null)
                    {
                        var check = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

                        if (check != null)
                        {
                            string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.taikhoan1, check.tendaydu, check.email, check.sodienthoai, check.trangthaitk, check.id_nhomadmin, check.id_taikhoan, check.matkhau, check.ngaytao, check.loaitaikhoan, check.avatar }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                            string matkhaumahoa = MD5.GeneratePasswordHash(mkcu);
                            if (matkhaumahoa == check.matkhau)
                            {
                                if (check.email == email)
                                {
                                    //string resulf = new Libs().validateLogin(mkmoi);
                                    //if (resulf == "")
                                    //{
                                    check.matkhau = MD5.GeneratePasswordHash(mkmoi);
                                    entity.SaveChanges();
                                    sucess = true;
                                    msg = "Thay đổi mật khẩu thành công ";

                                    TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                                    string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.taikhoan1, check.tendaydu, check.email, check.sodienthoai, check.trangthaitk, check.id_nhomadmin, check.id_taikhoan, check.matkhau, check.ngaytao, check.loaitaikhoan, check.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                    string mailto = check.email;
                                    string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", check.tendaydu);
                                    string body = string.Format("Xin chào {0} !<br />Tài khoản quản trị của bạn vừa được thay đổi mật khẩu thành công . <br />Chúng tôi gửi email này để xác nhận bạn chính là người thực hiện thao tác cập nhật mật khẩu.<br />Nếu không phải bạn mà là ai khác vui lòng liên hệ với chúng tôi để được hỗ trợ .<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", check.tendaydu);
                                    bool guimail = new Libs().sendEmail(mailto, subject, body);
                                    //}
                                    //else
                                    //{
                                    //    msg = "Thay đổi mật khẩu thất bại </br>" + resulf;
                                    //}
                                }
                                else
                                {
                                    msg = "Email bạn cung cấp không trùng với email sử dụng trong hệ thống";
                                }
                            }
                            else
                            {
                                msg = "Mật khẩu cũ bạn nhập không trùng với mật khẩu trong hệ thống";
                            }
                        }
                        else
                        {
                            msg = "Tài khoản không tồn tại không tồn tại";
                        }
                    }
                    else
                    {
                        msg = ErrorCheck;
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
        }

    }

    public void capnhatthongtincanhanadmin(HttpContext context)
    {
        string msg = "Sảy ra lỗi trong quá trình thao tác";
        bool sucess = false;
        string avatarResponse = "";
        Contructor.thongtintaikhoan thongtincb;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                thongtincb = (Contructor.thongtintaikhoan)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.thongtintaikhoan));
                if (session != null)
                {
                    string errCheck = new validateform().CallValidateThongTinCaNhanAdmin(thongtincb.tendangnhap, thongtincb.tendaydu, thongtincb.email, thongtincb.sodienthoai);
                    if (errCheck == null)
                    {
                        var check = entity.TaiKhoan.Where(m => m.id_taikhoan == thongtincb.id_taikhoan && m.id_taikhoan == session.id).FirstOrDefault();
                        var checktrung = entity.TaiKhoan.Where(m => m.id_taikhoan != check.id_taikhoan && m.taikhoan1 == thongtincb.tendangnhap).FirstOrDefault();
                        var checkemail = entity.TaiKhoan.Where(m => m.id_taikhoan != check.id_taikhoan && m.email == thongtincb.email).FirstOrDefault();
                        if (check != null)
                        {
                            if (checktrung == null)
                            {
                                if (checkemail == null)
                                {
                                    string emailcu = check.email;
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.taikhoan1, check.tendaydu, check.email, check.sodienthoai, check.trangthaitk, check.id_nhomadmin, check.id_taikhoan, check.matkhau, check.ngaytao, check.loaitaikhoan, check.avatar }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                    check.taikhoan1 = removeScriptAndCharacter.formatTextInput(thongtincb.tendangnhap);
                                    check.tendaydu = removeScriptAndCharacter.formatTextInput(thongtincb.tendaydu);
                                    check.email = removeScriptAndCharacter.formatTextInput(thongtincb.email);
                                    check.sodienthoai = removeScriptAndCharacter.formatTextInput(thongtincb.sodienthoai);
                                    check.avatar = removeScriptAndCharacter.formatTextInput(thongtincb.avatar);

                                    entity.SaveChanges();
                                    sucess = true;
                                    msg = "Cập nhật thông tin thành công ";
                                    avatarResponse = thongtincb.avatar;
                                    TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                                    string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.taikhoan1, check.tendaydu, check.email, check.sodienthoai, check.trangthaitk, check.id_nhomadmin, check.id_taikhoan, check.matkhau, check.ngaytao, check.loaitaikhoan, check.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                    if (emailcu == thongtincb.email)
                                    {
                                        string mailto = check.email;
                                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", check.tendaydu);
                                        string body = string.Format("Xin chào {0} !<br />Bạn vừa thực hiện cập nhật thông tin tài khoản quản trị trong hệ thống thành công . <br />Tài khoản : {1} <br />Email : {2} <br />Họ và tên : {3} <br />Số điện thoại : {4}.<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", check.tendaydu, check.taikhoan1, check.email, check.tendaydu, check.sodienthoai);
                                        bool guimail = new Libs().sendEmail(mailto, subject, body);
                                    }
                                    else
                                    {
                                        string mailto = emailcu;
                                        string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", check.tendaydu);
                                        string body = string.Format("Xin chào {0} !<br />Bạn vừa thực hiện cập nhật thông tin tài khoản và thay đổi email sử dụng trong hệ thống thành công.<br />Chúng tôi gửi email này để xác thực lại đảm bảo người thay đổi là bạn. <br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", check.tendaydu);
                                        bool guimail = new Libs().sendEmail(mailto, subject, body);

                                        string mailto1 = check.email;
                                        string subject1 = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", check.tendaydu);
                                        string body1 = string.Format("Xin chào {0} !<br />Bạn vừa thực hiện cập nhật thông tin tài khoản quản trị trong hệ thống thành công . <br />Tài khoản : {1} <br />Email : {2} <br />Họ và tên : {3} <br />Số điện thoại : {4}.<br /> Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", check.tendaydu, check.taikhoan1, check.email, check.tendaydu, check.sodienthoai);
                                        bool guimail1 = new Libs().sendEmail(mailto1, subject1, body1);
                                    }
                                }
                                else
                                {
                                    msg = "Email bạn nhập đã tồn tại trong hệ thống vui lòng nhập email khác ";
                                }
                            }
                            else
                            {
                                msg = "Tên tài khoản đã tồn tại trong hệ thống vui lòng nhập tên khác";
                            }
                        }
                        else
                        {
                            msg = "Tài khoản không tồn tại không tồn tại";
                        }
                    }
                    else
                    {
                        msg = errCheck;
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg, avatarResponse = avatarResponse }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg, avatarResponse = avatarResponse }, Formatting.Indented));
        }
    }

    public void xoalichhienthibanner(HttpContext context)
    {

        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int idCal = 0;
        if (new Libs().checkDuLieuGuiLen(context.Request["idCal"]))
        {
            // int idCal = int.Parse(context.Request["idCal"]);
            int.TryParse(context.Request["idCal"], out idCal);
            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.tbl_ChuKyHienThiBanner.Where(m => m.id_chitietchukyhienthi == idCal).FirstOrDefault();
                    if (check != null)
                    {
                        check.trangthai = 0;
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Xóa thành công !";

                        string vitri = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_chitietchukyhienthi, check.id_quanlybanner, check.trangthai, check.mucdouutien, check.tungay, check.denngay } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogXoaThanhCong(idlog);

                    }
                    else
                    {
                        sucess = false;
                        msg = "Lịch này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void themmoilichhienthichobanner(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        if (new Libs().QuyenThemMoi())
        {
            if (session != null)
            {
                if (new Libs().checkDuLieuGuiLen(context.Request["thongtinbaner"]))
                {
                    Contructor.thongtinbanner thongtinbanner = (Contructor.thongtinbanner)JsonConvert.DeserializeObject(context.Request["thongtinbaner"], typeof(Contructor.thongtinbanner));
                    tbl_ChuKyHienThiBanner chuky = new tbl_ChuKyHienThiBanner();

                    chuky.id_quanlybanner = thongtinbanner._idBanner;
                    chuky.trangthai = 1;
                    chuky.mucdouutien = thongtinbanner._Uutien;

                    if (thongtinbanner.trangthaihienthi == "hienthi")
                    {
                        chuky.tungay = DateTime.Now;
                        chuky.denngay = DateTime.Parse(thongtinbanner.ngaydung);
                    }
                    else if (thongtinbanner.trangthaihienthi == "hengio")
                    {
                        chuky.tungay = DateTime.Parse(thongtinbanner.ngaydang);
                        chuky.denngay = DateTime.Parse(thongtinbanner.ngaydung);
                    }
                    entity.tbl_ChuKyHienThiBanner.Add(chuky);
                    int kq1 = entity.SaveChanges();
                    if (kq1 != 0)
                    {
                        sucess = true;
                        msg = "Thêm mới thành công .";

                        string vitri = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chuky.id_chitietchukyhienthi, chuky.id_quanlybanner, chuky.trangthai, chuky.mucdouutien, chuky.tungay, chuky.denngay } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                    }
                }
                else
                {
                    msg = "Có lỗi trong quá trình thao tác";
                }
            }
            else
            {
                msg = "Session không tồn tại";
            }

        }

        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void capnhatthongtinbanner(HttpContext context)
    {
        string msg = "Sảy ra lỗi trong quá trình thao tác";
        bool sucess = false;
        Contructor.thongtinbanner thongtincb;

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtinbaner"]))
            {
                thongtincb = (Contructor.thongtinbanner)JsonConvert.DeserializeObject(context.Request["thongtinbaner"], typeof(Contructor.thongtinbanner));
                if (new Libs().QuyenSuaTrongTrang())
                {
                    if (session != null)
                    {
                        if (thongtincb.duongdanfile.Trim().Length == 0)
                        {
                            msg = "Ảnh banner không dược để trống";
                        }
                        else
                        {
                            var check = entity.QuanLyBanner.Where(m => m.id_quanlybanner == thongtincb._idBanner).FirstOrDefault();
                            if (check != null)
                            {
                                var checktrung = entity.QuanLyBanner.Where(m => m.id_quanlybanner != thongtincb._idBanner && m.type == thongtincb.type && m.tenbanner == thongtincb.tenbanner).FirstOrDefault();

                                var dulieucu = entity.QuanLyBanner.Where(m => m.id_quanlybanner == thongtincb._idBanner).FirstOrDefault();
                                string jsonDuLieuCu = JsonConvert.SerializeObject(new { dulieucu.id_quanlybanner, dulieucu.id_taikhoan, dulieucu.tenbanner, dulieucu.mimetype, dulieucu.ngayupload, dulieucu.trangthai, dulieucu.vitri, dulieucu.linkbanner, dulieucu.target, dulieucu.duongdanfile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                if (checktrung != null)
                                {
                                    check.tenbanner = MD5.RandomString(5) + thongtincb.tenbanner;
                                }
                                else
                                {
                                    check.tenbanner = removeScriptAndCharacter.formatTextInput(thongtincb.tenbanner);
                                }
                                check.mimetype = new Libs().GetMimeType(thongtincb.duongdanfile);
                                check.vitri = removeScriptAndCharacter.formatTextInput(thongtincb.vitri);
                                check.linkbanner = removeScriptAndCharacter.formatTextInput(thongtincb.linkbanner);
                                check.target = removeScriptAndCharacter.formatTextInput(thongtincb.target);
                                check.duongdanfile = removeScriptAndCharacter.formatTextInput(thongtincb.duongdanfile);

                                entity.SaveChanges();
                                sucess = true;
                                msg = "Cập nhật thông tin thành công ";

                                QuanLyBanner dataJson = (QuanLyBanner)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(QuanLyBanner));
                                string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { dulieucu.id_quanlybanner, dulieucu.id_taikhoan, dulieucu.tenbanner, dulieucu.mimetype, dulieucu.ngayupload, dulieucu.trangthai, dulieucu.vitri, dulieucu.linkbanner, dulieucu.target, dulieucu.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                            }
                            else
                            {
                                msg = "Banner không tồn tại";
                            }

                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }

            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = "Có lỗi trong quá trình thao tác" }, Formatting.Indented));
        }
    }


    public void themmoibannervaohethong(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().QuyenThemMoi())
            {
                if (session != null)
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtinbaner"]))
                    {
                        Contructor.thongtinbanner thongtinbanner = (Contructor.thongtinbanner)JsonConvert.DeserializeObject(context.Request["thongtinbaner"], typeof(Contructor.thongtinbanner));
                        string tenmoicuafle;
                        string tencheck;
                        string ErrorCheck = new validateform().CallValidateThemBanner(thongtinbanner.duongdanfile, thongtinbanner.trangthaihienthi, thongtinbanner.ngaydang, thongtinbanner.ngaydung);

                        if (ErrorCheck == null)
                        {
                            if (thongtinbanner.tenbanner == "")
                            {
                                tencheck = MD5.RandomString(10);
                            }
                            else
                            {
                                tencheck = removeScriptAndCharacter.formatTextInput(thongtinbanner.tenbanner);
                            }
                            var checktrungten = entity.QuanLyBanner.Where(m => m.tenbanner == tencheck).FirstOrDefault();
                            if (checktrungten == null)
                            {
                                tenmoicuafle = tencheck;
                            }
                            else
                            {
                                tenmoicuafle = MD5.RandomString(5) + tencheck;
                            }
                            QuanLyBanner qlFile = new QuanLyBanner();
                            tbl_ChuKyHienThiBanner chuky = new tbl_ChuKyHienThiBanner();

                            qlFile.tenbanner = tenmoicuafle;
                            qlFile.mimetype = new Libs().GetMimeType(thongtinbanner.duongdanfile);
                            qlFile.ngayupload = DateTime.Now;
                            qlFile.id_taikhoan = session.id;
                            qlFile.vitri = removeScriptAndCharacter.formatTextInput(thongtinbanner.vitri);
                            qlFile.linkbanner = removeScriptAndCharacter.formatTextInput(thongtinbanner.linkbanner);
                            qlFile.target = removeScriptAndCharacter.formatTextInput(thongtinbanner.target);
                            qlFile.duongdanfile = removeScriptAndCharacter.formatTextInput(thongtinbanner.duongdanfile);
                            qlFile.trangthai = 1;
                            qlFile.type = thongtinbanner.type;
                            entity.QuanLyBanner.Add(qlFile);
                            int kq = entity.SaveChanges();
                            if (kq != 0)
                            {
                                sucess = true;
                                msg = "Thêm mới thành công .";

                                string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { qlFile.id_quanlybanner, qlFile.id_taikhoan, qlFile.tenbanner, qlFile.mimetype, qlFile.ngayupload, qlFile.trangthai, qlFile.vitri, qlFile.linkbanner, qlFile.target, qlFile.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                if (thongtinbanner.trangthaihienthi == "hienthi")
                                {
                                    chuky.tungay = DateTime.Now;
                                    chuky.denngay = DateTime.Parse(thongtinbanner.ngaydung);
                                    chuky.trangthai = 1;

                                    chuky.id_quanlybanner = qlFile.id_quanlybanner;
                                    chuky.mucdouutien = client.ToInt(thongtinbanner._Uutien);
                                    entity.tbl_ChuKyHienThiBanner.Add(chuky);
                                    entity.SaveChanges();

                                    string vitribn = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
                                    int idlogbn = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chuky.id_chitietchukyhienthi, chuky.id_quanlybanner, chuky.trangthai, chuky.tungay, chuky.denngay, chuky.mucdouutien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitribn);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlogbn);
                                }
                                else if (thongtinbanner.trangthaihienthi == "hengio")
                                {
                                    chuky.tungay = DateTime.Parse(thongtinbanner.ngaydang);
                                    chuky.denngay = DateTime.Parse(thongtinbanner.ngaydung);
                                    chuky.trangthai = 1;

                                    chuky.id_quanlybanner = qlFile.id_quanlybanner;
                                    chuky.mucdouutien = client.ToInt(thongtinbanner._Uutien);
                                    entity.tbl_ChuKyHienThiBanner.Add(chuky);
                                    entity.SaveChanges();

                                    string vitribn = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
                                    int idlogbn = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { chuky.id_chitietchukyhienthi, chuky.id_quanlybanner, chuky.trangthai, chuky.tungay, chuky.denngay, chuky.mucdouutien } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitribn);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlogbn);
                                }
                            }
                            else
                            {
                                msg = "Không tìm thấy file upload";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }



    public void danhsachLogotrongthumuc(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;


        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.QuanLyBanner.Where(m => m.trangthai != 0 && m.type == "logo").ToList().OrderByDescending(m => m.ngayupload).Select(m => new
            {
                m.id_quanlybanner,
                m.tenbanner,
                m.mimetype,
                m.ngayupload,
                m.id_taikhoan,
                m.trangthai,
                m.vitri,
                m.linkbanner,
                m.target,
                m.duongdanfile,
                button = new
                {
                    m.id_quanlybanner,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                thongtinhienthi = entity.tbl_ChuKyHienThiBanner.Where(x => x.trangthai == 1 && x.id_quanlybanner == m.id_quanlybanner).ToList().Select(x => new
                {

                    x.id_chitietchukyhienthi,
                    x.id_quanlybanner,
                    x.tungay,
                    x.denngay,
                    thoigianhienthi = x.tungay.Value.ToString("dd/MM/yyyy") + " đến " + x.denngay.Value.ToString("dd/MM/yyyy"),
                    x.mucdouutien
                }).ToList()

            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
    }
    public void danhsachBannertrongthumuc(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;


        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.QuanLyBanner.Where(m => m.trangthai == 1 && m.type == "banner").ToList().OrderByDescending(m => m.ngayupload).Select(m => new
            {
                m.id_quanlybanner,
                m.tenbanner,
                m.mimetype,
                m.ngayupload,
                m.id_taikhoan,
                m.trangthai,
                m.vitri,
                m.linkbanner,
                m.target,
                m.duongdanfile,
                button = new
                {
                    m.id_quanlybanner,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                thongtinhienthi = entity.tbl_ChuKyHienThiBanner.Where(x => x.trangthai == 1 && x.id_quanlybanner == m.id_quanlybanner).ToList().Select(x => new
                {

                    x.id_chitietchukyhienthi,
                    x.id_quanlybanner,
                    x.tungay,
                    x.denngay,
                    thoigianhienthi = x.tungay.Value.ToString("dd/MM/yyyy") + " đến " + x.denngay.Value.ToString("dd/MM/yyyy"),
                    x.mucdouutien
                }).ToList()

            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
    }
    public void loaddanhsachthumucbanner(HttpContext context)
    {

        int id_tm = -1;
        bool quyen = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }

            List<Libs.jsTree> data = new List<Libs.jsTree>();
            if (int.TryParse(context.Request["id_tm"], out id_tm))
            {
                entity.QuanLyThuMuc.Where(x => ((quyen == true) ? ((id_tm == 0 ? (x.id_quanlythumuc == 5) : (x.idParents == id_tm)) && x.trangthai == true) : ((id_tm == 0 ? (x.id_quanlythumuc == 5) : (x.idParents == id_tm && x.id_taikhoan == session.id)) && x.trangthai == true))).ToList().All(x =>
                {
                    Libs.jsonthumuc json = new Libs.jsonthumuc();
                    Libs.jsTree item = new Libs.jsTree();
                    item.text = x.tenthumuc;
                    item.id = x.id_quanlythumuc;
                    item.children = entity.QuanLyThuMuc.Where(xx => xx.idParents == x.id_quanlythumuc).Any();
                    item.data = new Libs.jsData() { child = json };
                    data.Add(item);
                    return true;
                });
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(data, Formatting.Indented));
        }
    }

    public void xoabanner(HttpContext context)
    {

        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int _idBanner = 0;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idBanner"]))
            {
                //   int _idBanner = int.Parse(context.Request["_idBanner"]);
                int.TryParse(context.Request["_idBanner"], out _idBanner);
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.QuanLyBanner.Where(m => m.id_quanlybanner == _idBanner).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa thành công !";

                            var checkdatlich = entity.tbl_ChuKyHienThiBanner.Where(x => x.id_quanlybanner == check.id_quanlybanner && x.trangthai == 1).ToList();
                            if (checkdatlich.Count > 0)
                            {
                                for (int i = 0; i < checkdatlich.Count; i++)
                                {
                                    int idDatLich = checkdatlich[i].id_chitietchukyhienthi;
                                    checkdatlich[i].trangthai = 0;
                                    entity.SaveChanges();

                                    string vitri1 = new Libs().VitriTruyCapVaIP("tbl_ChuKyHienThiBanner", new Libs().ThietBiTruyCap());
                                    int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkdatlich[i].id_chitietchukyhienthi, checkdatlich[i].id_quanlybanner, checkdatlich[i].trangthai, checkdatlich[i].tungay, checkdatlich[i].denngay } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                    new Libs().updateKieuLogXoaThanhCong(idlog1);
                                }
                            }
                            string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_quanlybanner, check.id_taikhoan, check.tenbanner, check.mimetype, check.ngayupload, check.trangthai, check.vitri, check.linkbanner, check.target, check.duongdanfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);

                        }
                        else
                        {
                            sucess = false;
                            msg = "Banner này không tồn tại ";
                        }
                    }
                    else
                    {
                        sucess = false;
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("QuanLyBanner", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }
    public void loadallmenuthemmoinhom(HttpContext context)
    {
        var danhsach = entity.tbl_Menu.Where(m => m.trangthai == 1 && m.linkmenu != null && m.duongdan != null && m.shortcode != null).ToList().Select(m => new
        {
            m.id_menu,
            m.tenmenu
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
    }

    public void loadalladminthemvaonhomquanly(HttpContext context)
    {
        var danhsach = entity.TaiKhoan.Where(m => m.trangthaitk == true && m.loaitaikhoan == 2).ToList().Select(m => new
        {
            m.taikhoan1,
            tenmenu = m.NhomAdmin.tennhom,
            m.id_taikhoan,
            m.id_nhomadmin
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
    }


    public void themmoinhomquanly(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtinadmin"], typeof(List<int>));
            List<int> danhsachmenu = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtinmenu"], typeof(List<int>));
            if (new Libs().QuyenThemMoi())
            {
                if (session != null)
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["tennhom"]))
                    {
                        string tennhom = removeScriptAndCharacter.formatTextInput(context.Request["tennhom"]);

                        string ErrorCheck = new validateform().CallValidateThemMoiNhomQuanLy(tennhom);
                        if (ErrorCheck == null)
                        {
                            var checktk = entity.NhomAdmin.Where(m => m.tennhom == tennhom).FirstOrDefault();
                            NhomAdmin nhomAd = new NhomAdmin();
                            NhomQuyen nhomQ = new NhomQuyen();
                            if (checktk == null)
                            {
                                nhomAd.tennhom = tennhom;
                                nhomAd.ngaytao = DateTime.Now;
                                nhomAd.trangthai = true;
                                entity.NhomAdmin.Add(nhomAd);
                                entity.SaveChanges();
                                sucess = true;
                                msg = "Thêm nhóm quản lý thành công ";

                                if (danhsachadmin.Count > 0)
                                {
                                    for (int i = 0; i < danhsachadmin.Count; i++)
                                    {
                                        int idAdmin = danhsachadmin[i];

                                        var checkadmin = entity.TaiKhoan.Where(m => m.id_taikhoan == idAdmin).FirstOrDefault();
                                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { checkadmin.id_taikhoan, checkadmin.taikhoan1, checkadmin.matkhau, checkadmin.tendaydu, checkadmin.email, checkadmin.sodienthoai, checkadmin.trangthaitk, checkadmin.id_nhomadmin, checkadmin.ngaytao, checkadmin.loaitaikhoan }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                        if (checkadmin != null)
                                        {
                                            checkadmin.id_nhomadmin = nhomAd.id_nhomadmin;
                                            entity.SaveChanges();

                                            TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                                            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checkadmin.id_taikhoan, checkadmin.taikhoan1, checkadmin.matkhau, checkadmin.tendaydu, checkadmin.email, checkadmin.sodienthoai, checkadmin.trangthaitk, checkadmin.id_nhomadmin, checkadmin.ngaytao, checkadmin.loaitaikhoan } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                                        }
                                    }
                                }


                                if (danhsachmenu.Count > 0)
                                {
                                    for (int i = 0; i < danhsachmenu.Count; i++)
                                    {
                                        int idMenu = danhsachmenu[i];

                                        var checkmenu = entity.tbl_Menu.Where(m => m.id_menu == idMenu && m.trangthai == 1 && m.linkmenu != null && m.duongdan != null && m.shortcode != null).FirstOrDefault();

                                        if (checkmenu != null)
                                        {
                                            nhomQ.id_menu = checkmenu.id_menu;
                                            nhomQ.id_nhomadmin = nhomAd.id_nhomadmin;
                                            nhomQ.xem = true;
                                            nhomQ.them = false;
                                            nhomQ.sua = false;
                                            nhomQ.xoa = false;
                                            nhomQ.trangthai = true;
                                            entity.NhomQuyen.Add(nhomQ);
                                            entity.SaveChanges();

                                            string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
                                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { nhomQ.id_nhomquyen, nhomQ.id_menu, nhomQ.id_nhomadmin, nhomQ.xem, nhomQ.them, nhomQ.sua, nhomQ.xoa } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                            new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                        }
                                    }
                                }


                                string vitri1 = new Libs().VitriTruyCapVaIP("NhomAdmin", new Libs().ThietBiTruyCap());
                                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { nhomAd.tennhom, nhomAd.ngaytao, nhomAd.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog1);
                            }
                            else
                            {
                                msg = "Tên nhóm đã tồn tại vui lòng chọn tên khác ";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Lỗi trong quá trình thao tác";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }

            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("NhomAdmin", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogThemMoiThatBai(idlog);

            }

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }

    }


    public void themmoimenuvaonhomquanly(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().QuyenThemMoi())
            {
                if (session != null)
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["idnhomadmin"]))
                    {
                        List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(List<int>));
                        int idnhomadmin = client.ToInt(context.Request["idnhomadmin"]);

                        var checktk = entity.NhomQuyen.Where(m => m.trangthai == true && m.id_nhomadmin == idnhomadmin).ToList().Where(x => danhsachadmin.Contains(x.id_menu.Value)).Any();
                        NhomQuyen nhomQ = new NhomQuyen();
                        if (checktk == false)
                        {
                            for (int i = 0; i < danhsachadmin.Count; i++)
                            {
                                int idMenu = danhsachadmin[i];

                                nhomQ.id_menu = idMenu;
                                nhomQ.id_nhomadmin = idnhomadmin;
                                nhomQ.xem = true;
                                nhomQ.them = false;
                                nhomQ.sua = false;
                                nhomQ.xoa = false;
                                nhomQ.trangthai = true;
                                entity.NhomQuyen.Add(nhomQ);
                                entity.SaveChanges();
                                sucess = true;
                                msg = "Thêm menu vào nhóm quản lý thành công ";

                                string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { nhomQ.id_menu, nhomQ.id_nhomadmin, nhomQ.id_nhomquyen, nhomQ.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                new Libs().updateKieuLogThemMoiThanhCong(idlog);

                            }

                        }
                        else
                        {
                            msg = "Menu này đã tồn tại trong nhóm quản lý";
                        }

                    }
                    else
                    {
                        msg = "Lỗi trong quá trình thao tác";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }

            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogThemMoiThatBai(idlog);

            }

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }
    }


    public void loadmenuchuatontaitrongquyen(HttpContext context)
    {

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["idClick"]))
            {
                int idClick = int.Parse(context.Request["idClick"]);
                var danhsachmenusd = entity.NhomQuyen.Where(x => x.id_nhomadmin == idClick && x.trangthai == true).ToList().Select(x => x.id_menu);
                var danhsach = entity.tbl_Menu.Where(m => m.trangthai == 1 && m.duongdan != null && m.shortcode != null).ToList().Where(x => !danhsachmenusd.Contains(x.id_menu)).Select(m => new
                {
                    m.id_menu,
                    m.tenmenu,
                    m.linkmenu,
                    m.vitri,
                    m.trangthai,
                    m.idParent,
                    m.id_taikhoan,
                    m.sothutu,
                    m.icon,
                    m.duongdan,
                    m.shortcode
                });
                context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
            }
        }
    }


    public void thaydoiquyenquanlylistmenu(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        bool trangthai = bool.Parse(context.Request["trangthaicheck"]);
        if (new Libs().checkDuLieuGuiLen(context.Request["danhsach"]))
        {
            List<int> danhsachmenu = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["danhsach"], typeof(List<int>));

            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    foreach (var item in danhsachmenu)
                    {

                        var check = entity.NhomQuyen.Where(zz => zz.id_nhomquyen == item && zz.trangthai == true).FirstOrDefault();
                        if (check != null)
                        {
                            check.them = trangthai;
                            check.sua = trangthai;
                            check.xoa = trangthai;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Sửa thành công !";
                        }
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        else
        {
            msg = "Lỗi khi thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);

        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void suaquyencuaadmintrongmenu(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int id_nhomquyen = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["trangthai"]) && new Libs().checkDuLieuGuiLen(context.Request["quyen"]) && new Libs().checkDuLieuGuiLen(context.Request["id_nhomquyen"]))
        {
            string quyen = context.Request["quyen"];
            // int id_nhomquyen = int.Parse(context.Request["id_nhomquyen"]);
            int.TryParse(context.Request["id_nhomquyen"], out id_nhomquyen);
            string tt = context.Request["trangthai"];
            bool trangthai = true;
            if (tt == "true")
            {
                trangthai = true;
            }
            else
            {
                trangthai = false;
            }
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.NhomQuyen.Where(m => m.id_nhomquyen == id_nhomquyen).FirstOrDefault();

                    if (check != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_nhomquyen, check.id_menu, check.id_nhomadmin, check.xem, check.them, check.sua, check.xoa, check.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        if (trangthai == true && check.xem == false)
                        {
                            check.xem = true;
                        }
                        if (quyen == "them")
                        {
                            check.them = trangthai;
                        } if (quyen == "sua")
                        {
                            check.sua = trangthai;
                        } if (quyen == "xoa")
                        {
                            check.xoa = trangthai;
                        } if (quyen == "xem")
                        {
                            if (trangthai == false)
                            {
                                check.them = trangthai;
                                check.xem = trangthai;
                                check.xoa = trangthai;
                                check.sua = trangthai;
                                check.xem = trangthai;
                            }
                            else
                            {
                                check.xem = trangthai;
                            }
                        }
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Sửa thành công !";

                        NhomQuyen dataJson = (NhomQuyen)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(NhomQuyen));
                        string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_nhomquyen, check.id_menu, check.id_nhomadmin, check.xem, check.them, check.sua, check.xoa, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                    }
                    else
                    {
                        sucess = false;
                        msg = "Nhóm quản lý này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);

        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void loaibomenukhoinhomquanly(HttpContext context)
    {

        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int id_Nhomquyen = 0;
        int id_Menu = 0;
        int id_NhomAdmin = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["id_Nhomquyen"]) && new Libs().checkDuLieuGuiLen(context.Request["id_Menu"]) && new Libs().checkDuLieuGuiLen(context.Request["id_NhomAdmin"]))
        {
            //int id_Nhomquyen = int.Parse(context.Request["id_Nhomquyen"]);
            //int id_Menu = int.Parse(context.Request["id_Menu"]);
            //int id_NhomAdmin = int.Parse(context.Request["id_NhomAdmin"]);
            int.TryParse(context.Request["id_Nhomquyen"], out id_Nhomquyen);
            int.TryParse(context.Request["id_Menu"], out id_Menu);
            int.TryParse(context.Request["id_NhomAdmin"], out id_NhomAdmin);


            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.NhomQuyen.Where(m => m.id_nhomquyen == id_Nhomquyen && m.id_menu == id_Menu && m.id_nhomadmin == id_NhomAdmin).FirstOrDefault();
                    if (check != null)
                    {
                        check.trangthai = false;
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Xóa thành công !";


                        string vitri = new Libs().VitriTruyCapVaIP("NhomQuyen", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_nhomadmin, check.id_nhomquyen, check.id_menu, check.xem, check.them, check.sua, check.xoa, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogXoaThanhCong(idlog);

                    }
                    else
                    {
                        sucess = false;
                        msg = "Admin hoặc nhóm này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }


    public void loaiboadminkhoinhomquanly(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;

        if (new Libs().checkDuLieuGuiLen(context.Request["id_Admin"]) && new Libs().checkDuLieuGuiLen(context.Request["id_Nhom"]))
        {
            int id_Admin = 0;
            int id_Nhom = 0;
            int.TryParse(context.Request["id_Admin"], out id_Admin);
            int.TryParse(context.Request["id_Nhom"], out id_Nhom);

            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.TaiKhoan.Where(m => m.id_taikhoan == id_Admin && m.id_nhomadmin == id_Nhom).FirstOrDefault();
                    if (check != null)
                    {
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.avatar, check.email, check.id_nhomadmin, check.id_taikhoan, check.loaitaikhoan, check.matkhau, check.ngaytao, check.sodienthoai, check.taikhoan1, check.tendaydu }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        check.id_nhomadmin = 1;
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Xóa thành công !";

                        TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                        string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.avatar, check.email, check.id_nhomadmin, check.id_taikhoan, check.loaitaikhoan, check.matkhau, check.ngaytao, check.sodienthoai, check.taikhoan1, check.tendaydu } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogXoaThanhCong(idlog);
                    }
                    else
                    {
                        sucess = false;
                        msg = "Admin hoặc nhóm này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void themadminvaonhom(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().QuyenSuaTrongTrang())
            {
                if (session != null)
                {
                    if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["idnhomadmin"]))
                    {
                        List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(List<int>));
                        int idnhomadmin = client.ToInt(context.Request["idnhomadmin"]);

                        var checktk = entity.NhomAdmin.Where(m => m.id_nhomadmin == idnhomadmin).FirstOrDefault();

                        if (checktk != null)
                        {
                            for (int i = 0; i < danhsachadmin.Count; i++)
                            {
                                int idadmin = danhsachadmin[i];

                                var dulieucu = entity.TaiKhoan.Where(m => m.id_taikhoan == idadmin).FirstOrDefault();
                                string jsonDuLieuCu = JsonConvert.SerializeObject(new { dulieucu.id_nhomadmin, dulieucu.id_taikhoan, dulieucu.loaitaikhoan, dulieucu.matkhau, dulieucu.ngaytao, dulieucu.sodienthoai, dulieucu.taikhoan1, dulieucu.tendaydu, dulieucu.trangthaitk }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                                var checkadmin = entity.TaiKhoan.Where(m => m.id_taikhoan == idadmin && m.trangthaitk == true && m.id_nhomadmin == 1).FirstOrDefault();

                                if (checkadmin != null)
                                {
                                    checkadmin.id_nhomadmin = idnhomadmin;
                                    entity.SaveChanges();
                                    sucess = true;
                                    msg = "Thêm admin vào nhóm quản lý thành công ";

                                    TaiKhoan dataJson = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                                    string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = checkadmin.id_nhomadmin }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                }
                            }

                        }
                        else
                        {
                            msg = "Nhóm quản lý không tồn tại ";
                        }

                    }
                    else
                    {
                        msg = "Lỗi trong quá trình thao tác";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }

            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }
    }

    public void loaddanhsachadminthemmoivaonhom(HttpContext context)
    {
        string msg = "Bạn không có quyền truy cập mục này";


        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            var danhsachadmin = entity.TaiKhoan.Where(m => m.loaitaikhoan == 2 && m.trangthaitk == true && m.id_taikhoan != session.id && m.id_nhomadmin == 1).Select(m => new
            {
                m.avatar,
                m.email,
                m.id_nhomadmin,
                tennhom = m.NhomAdmin.tennhom,
                m.id_taikhoan,
                m.loaitaikhoan,
                m.matkhau,
                m.ngaytao,
                m.sodienthoai,
                m.taikhoan1,
                m.tendaydu,
                m.trangthaitk,

            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsachadmin }, Formatting.Indented));
        }
    }


    public void xoanhomadmin(HttpContext context)
    {
        string msg = "Có lỗi trong quá trình thao tác !";
        bool sucess = false;
        int idnhom = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["idnhom"]))
        {
            //  int idnhom = int.Parse(context.Request["idnhom"]);
            int.TryParse(context.Request["idnhom"], out idnhom);
            List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["danhsach"], typeof(List<int>));

            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    var check = entity.NhomAdmin.Where(m => m.id_nhomadmin == idnhom).FirstOrDefault();
                    if (check != null)
                    {
                        check.trangthai = false;
                        entity.SaveChanges();

                        sucess = true;
                        msg = "Xóa thành công !";

                        string vitri = new Libs().VitriTruyCapVaIP("NhomAdmin", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.tennhom, check.ngaytao, check.id_nhomadmin, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogXoaThanhCong(idlog);



                        for (int i = 0; i < danhsachadmin.Count; i++)
                        {
                            int idxoa = danhsachadmin[i];
                            var tk = entity.TaiKhoan.Where(m => m.id_taikhoan == idxoa && m.id_nhomadmin == idnhom).FirstOrDefault();
                            if (tk != null)
                            {
                                tk.id_nhomadmin = 1;
                                entity.SaveChanges();
                            }
                        }
                    }
                    else
                    {
                        sucess = false;
                        msg = "Nhóm quản lý này không tồn tại ";
                    }
                }
                else
                {
                    sucess = false;
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                sucess = false;
                msg = "Bạn không có quyền với chức năng này";
            }
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("NhomAdmin", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void danhsachnhomadmin(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.NhomAdmin.Where(m => m.trangthai == true && m.id_nhomadmin != 1).ToList().OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.id_nhomadmin,
                m.tennhom,
                m.ngaytao,
                m.trangthai,
                button = new
                {
                    m.id_nhomadmin,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                },
                nhommenu = entity.NhomQuyen.Where(x => x.id_nhomadmin == m.id_nhomadmin && x.trangthai == true).ToList().Select(x => new
                {
                    x.id_nhomquyen,
                    x.xem,
                    x.sua,
                    x.xoa,
                    x.them,
                    x.id_menu,
                    tenmenu = x.tbl_Menu.tenmenu,
                    button = new
                    {
                        m.id_nhomadmin,
                        x.id_nhomquyen,
                        cn.xem,
                        cn.them,
                        cn.sua,
                        cn.xoa,
                    },
                }).ToList(),
                nhomtaikhoan = entity.TaiKhoan.Where(v => v.id_nhomadmin == m.id_nhomadmin && v.trangthaitk == true).ToList().Select(v => new
                {
                    v.id_taikhoan,
                    v.tendaydu,
                    v.taikhoan1,
                    v.email,
                    button = new
                    {
                        m.id_nhomadmin,
                        cn.xem,
                        cn.them,
                        cn.sua,
                        cn.xoa
                    },

                }).ToList()
            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }
    public void uploadFileTaiLieuServer(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string fileResponse = "";
        if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {
            int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            string dungluong = context.Request["dungluong"];
            if (session != null)
            {

                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu;
                string nhaytrang;
                int gioihandata = 1048576 * 10;

                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);
                    typeFile = Path.GetExtension(file.FileName);
                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }
                    else
                    {
                        if (typeFile == ".doc" || typeFile == ".docx" || typeFile == ".xls" || typeFile == ".pdf" || typeFile == ".xlsx" || typeFile == ".ppt")
                        {
                            tenfile = MD5.RandomString(16);
                            fileanhluu = "/ThuMucGoc/FileTaiLieuUpload/" + tenfile + typeFile;
                            duongdan = context.Server.MapPath("~" + fileanhluu);
                            file.SaveAs(duongdan);

                            // check mime type by byte file
                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsFile(ff);
                            if (ck_Type == true)
                            {
                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                //    qlFile.duongdanfile = "/path-file/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();

                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";
                                    fileResponse = qlFile.duongdanfile;
                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Định dạng file đã bị thay đổi (doc,docx,xls,pdf,ppt)";
                            }
                        }
                        else
                        {
                            msg = "Định dạng file không hợp lệ (doc,docx,xls,pdf,ppt)";
                        }
                    }
                }
                else
                {
                    msg = "Upload file không thành công";
                }

            }
            else
            {
                msg = "Session không tồn tại";
            }

        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg, fileResponse = fileResponse }, Formatting.Indented));
    }


    //tai lieu
    public void uploadFileTaiLieu(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int _idthumuc = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {
            List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(List<int>));

            //int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            int.TryParse(context.Request["_idthumuc"], out _idthumuc);

            string dungluong = context.Request["dungluong"];
            if (session != null)
            {

                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu;
                string nhaytrang;
                int gioihandata = 1048576 * 10;

                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);
                    typeFile = Path.GetExtension(file.FileName);
                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }
                    else
                    {
                        if (typeFile == ".doc" || typeFile == ".docx" || typeFile == ".xls" || typeFile == ".pdf" || typeFile == ".xlsx" || typeFile == ".ppt")
                        {
                            tenfile = MD5.RandomString(16);
                            fileanhluu = "/ThuMucGoc/FileTaiLieuUpload/" + tenfile + typeFile;
                            duongdan = context.Server.MapPath("~" + fileanhluu);
                            file.SaveAs(duongdan);


                            // check mime type by byte file
                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.CheckUpLoadHoiDap(ff);
                            if (ck_Type == true)
                            {
                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                // qlFile.duongdanfile = "/path-file/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();

                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";

                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                }
                                if (danhsachadmin.Count > 0)
                                {
                                    for (int i = 0; i < danhsachadmin.Count; i++)
                                    {
                                        tbl_QuyenSuDungFile sd = new tbl_QuyenSuDungFile();
                                        sd.id_taikhoan = danhsachadmin[i];
                                        sd.id_quanlyfileupload = qlFile.id_quanlyfileupload;
                                        sd.kieufile = "tailieu";
                                        entity.tbl_QuyenSuDungFile.Add(sd);
                                        entity.SaveChanges();

                                        sucess = true;
                                        msg = "Thêm mới thành công .";
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_QuyenSuDungFile", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { sd.id_taikhoan, sd.id_quanlyfileupload, sd.id_quyensd } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                    }
                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Định dạng file đã bị thay đổi (doc,docx,xls,pdf,ppt)";
                            }
                        }
                        else
                        {
                            msg = "Định dạng file không hợp lệ (doc,docx,xls,pdf,ppt)";
                        }
                    }
                }
                else
                {
                    msg = "Upload file không thành công";
                }
            }
            else
            {
                msg = "Session không tồn tại";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
    }


    public void danhsachtailieuduocchiase(HttpContext context)
    {
        bool quyen = false;

        bool suscess = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach1 = entity.tbl_QuyenSuDungFile.Where(m => (quyen == true) ? (m.kieufile == "tailieu") : (m.id_taikhoan == session.id && m.kieufile == "tailieu")).ToList().Select(m => new
            {
                m.QuanLyFileUpload.tenfile,
                m.QuanLyFileUpload.duongdanfile,
                m.QuanLyFileUpload.id_quanlyfileupload,
                m.QuanLyFileUpload.id_taikhoan,
                m.QuanLyFileUpload.id_quanlythumuc,
                m.QuanLyFileUpload.mimetype,
                m.QuanLyFileUpload.ngayupload,
                m.QuanLyFileUpload.dungluongfile,
                m.QuanLyFileUpload.trangthai
            }).ToList().OrderByDescending(m => m.ngayupload.Value);


            var danhsach = from a in danhsach1.Where(d => d.trangthai == true)
                           group a by new
                           {
                               a.id_quanlyfileupload
                           } into nhomfile
                           select new
                           {

                               id_quanlyfileupload = nhomfile.Key.id_quanlyfileupload,
                               tenfile = nhomfile.Select(gg => gg.tenfile).FirstOrDefault(),
                               duongdanfile = nhomfile.Select(gg => gg.duongdanfile).FirstOrDefault(),
                               id_taikhoan = nhomfile.Select(gg => gg.id_taikhoan).FirstOrDefault(),
                               id_quanlythumuc = nhomfile.Select(gg => gg.id_quanlythumuc).FirstOrDefault(),
                               mimetype = nhomfile.Select(gg => gg.mimetype).FirstOrDefault(),
                               ngayupload = nhomfile.Select(gg => gg.ngayupload).FirstOrDefault(),
                               dungluongfile = nhomfile.Select(gg => gg.dungluongfile).FirstOrDefault(),
                               trangthai = nhomfile.Select(gg => gg.trangthai).FirstOrDefault()
                           };

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }

    public void loaddanhsachthumucTailieu(HttpContext context)
    {
        int id_tm = -1;
        bool quyen = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }

            List<Libs.jsTree> data = new List<Libs.jsTree>();
            if (int.TryParse(context.Request["id_tm"], out id_tm))
            {
                entity.QuanLyThuMuc.Where(x => ((quyen == true) ? ((id_tm == 0 ? (x.id_quanlythumuc == 3) : (x.idParents == id_tm)) && x.trangthai == true) : ((id_tm == 0 ? (x.id_quanlythumuc == 3) : (x.idParents == id_tm && x.id_taikhoan == session.id)) && x.trangthai == true))).ToList().All(x =>
                {
                    Libs.jsonthumuc json = new Libs.jsonthumuc();
                    Libs.jsTree item = new Libs.jsTree();
                    item.text = x.tenthumuc;
                    item.id = x.id_quanlythumuc;
                    item.children = entity.QuanLyThuMuc.Where(xx => xx.idParents == x.id_quanlythumuc).Any();
                    item.data = new Libs.jsData() { child = json };
                    data.Add(item);
                    return true;
                });
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(data, Formatting.Indented));
        }
    }


    public void uploadFileVideoServer(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string videoResponse = "";
        if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {
            int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            string dungluong = context.Request["dungluong"];

            if (session != null)
            {

                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu;
                string nhaytrang;
                int gioihandata = 1048576 * 50;
                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);

                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }
                    else
                    {
                        if (mimeType.IndexOf("video/") >= 0)
                        {
                            typeFile = Path.GetExtension(file.FileName);
                            tenfile = MD5.RandomString(16);
                            fileanhluu = "/ThuMucGoc/VideoTaiLieuUpload/" + tenfile + typeFile;
                            duongdan = context.Server.MapPath("~" + fileanhluu);
                            file.SaveAs(duongdan);

                            // check mime type by byte file
                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsMedia(ff);
                            if (ck_Type == true)
                            {
                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                //   qlFile.duongdanfile = "/path-video/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();

                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";
                                    videoResponse = qlFile.duongdanfile;
                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Định dạng file đã bị thay đổi (mp3,wav,mp4,flv,avi)";
                            }
                        }
                        else
                        {
                            msg = "File upload không đúng định dạng (mp3,wav,mp4,flv,avi)";
                        }
                    }
                }
                else
                {
                    msg = "Tải file thất bại";
                }

            }
            else
            {
                msg = "Session không tồn tại";
            }

        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }

        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess, videoResponse = videoResponse }, Formatting.Indented));
    }

    //video
    public void uploadFileVideo(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int _idthumuc = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {
            List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(List<int>));

            // int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            int.TryParse(context.Request["_idthumuc"], out _idthumuc);

            string dungluong = context.Request["dungluong"];
            if (session != null)
            {

                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu;
                string nhaytrang;
                int gioihandata = 1048576 * 50;
                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);

                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }
                    else
                    {
                        if (mimeType.IndexOf("video/") >= 0)
                        {
                            typeFile = Path.GetExtension(file.FileName);
                            tenfile = MD5.RandomString(16);
                            fileanhluu = "/ThuMucGoc/VideoTaiLieuUpload/" + tenfile + typeFile;
                            duongdan = context.Server.MapPath("~" + fileanhluu);
                            file.SaveAs(duongdan);


                            // check mime type by byte file
                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsMedia(ff);
                            if (ck_Type == true)
                            {
                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                // qlFile.duongdanfile = "/path-video/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();

                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";

                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                }
                                if (danhsachadmin.Count > 0)
                                {
                                    for (int i = 0; i < danhsachadmin.Count; i++)
                                    {
                                        tbl_QuyenSuDungFile sd = new tbl_QuyenSuDungFile();
                                        sd.id_taikhoan = danhsachadmin[i];
                                        sd.id_quanlyfileupload = qlFile.id_quanlyfileupload;
                                        sd.kieufile = "video";
                                        entity.tbl_QuyenSuDungFile.Add(sd);
                                        entity.SaveChanges();

                                        sucess = true;
                                        msg = "Thêm mới thành công .";
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_QuyenSuDungFile", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { sd.id_taikhoan, sd.id_quanlyfileupload, sd.id_quyensd } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                    }
                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Định dạng file upload đã bị thay đổi (mp3,wav,mp4,flv,avi)";
                            }
                        }
                        else
                        {
                            msg = "File upload không đúng định dạng (mp3,wav,mp4,flv,avi)";
                        }
                    }
                }
                else
                {
                    msg = "Tải file thất bại";
                }

            }
            else
            {
                msg = "Session không tồn tại";
            }

        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }

        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }


    public void danhsachvideoduocchiase(HttpContext context)
    {
        bool quyen = false;

        bool suscess = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach1 = entity.tbl_QuyenSuDungFile.Where(m => (quyen == true) ? (m.kieufile == "video") : (m.id_taikhoan == session.id && m.kieufile == "video")).ToList().Select(m => new
            {
                m.QuanLyFileUpload.tenfile,
                m.QuanLyFileUpload.duongdanfile,
                m.QuanLyFileUpload.id_quanlyfileupload,
                m.QuanLyFileUpload.id_taikhoan,
                m.QuanLyFileUpload.id_quanlythumuc,
                m.QuanLyFileUpload.mimetype,
                m.QuanLyFileUpload.ngayupload,
                m.QuanLyFileUpload.dungluongfile,
                m.QuanLyFileUpload.trangthai
            }).ToList().OrderByDescending(m => m.ngayupload.Value);


            var danhsach = from a in danhsach1.Where(d => d.trangthai == true)
                           group a by new
                           {
                               a.id_quanlyfileupload
                           } into nhomfile
                           select new
                           {

                               id_quanlyfileupload = nhomfile.Key.id_quanlyfileupload,
                               tenfile = nhomfile.Select(gg => gg.tenfile).FirstOrDefault(),
                               duongdanfile = nhomfile.Select(gg => gg.duongdanfile).FirstOrDefault(),
                               id_taikhoan = nhomfile.Select(gg => gg.id_taikhoan).FirstOrDefault(),
                               id_quanlythumuc = nhomfile.Select(gg => gg.id_quanlythumuc).FirstOrDefault(),
                               mimetype = nhomfile.Select(gg => gg.mimetype).FirstOrDefault(),
                               ngayupload = nhomfile.Select(gg => gg.ngayupload).FirstOrDefault(),
                               dungluongfile = nhomfile.Select(gg => gg.dungluongfile).FirstOrDefault(),
                               trangthai = nhomfile.Select(gg => gg.trangthai).FirstOrDefault()
                           };

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }

    public void loaddanhsachthumucvideo(HttpContext context)
    {
        int id_tm = -1;
        bool quyen = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }

            List<Libs.jsTree> data = new List<Libs.jsTree>();
            if (int.TryParse(context.Request["id_tm"], out id_tm))
            {
                entity.QuanLyThuMuc.Where(x => ((quyen == true) ? ((id_tm == 0 ? (x.id_quanlythumuc == 2) : (x.idParents == id_tm)) && x.trangthai == true) : ((id_tm == 0 ? (x.id_quanlythumuc == 2) : (x.idParents == id_tm && x.id_taikhoan == session.id)) && x.trangthai == true))).ToList().All(x =>
                {
                    Libs.jsonthumuc json = new Libs.jsonthumuc();
                    Libs.jsTree item = new Libs.jsTree();
                    item.text = x.tenthumuc;
                    item.id = x.id_quanlythumuc;
                    item.children = entity.QuanLyThuMuc.Where(xx => xx.idParents == x.id_quanlythumuc).Any();
                    item.data = new Libs.jsData() { child = json };
                    data.Add(item);
                    return true;
                });
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(data, Formatting.Indented));
        }
    }
    public void danhsachanhduocchiase(HttpContext context)
    {
        bool quyen = false;

        bool suscess = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan.Value == 3 || checktk.loaitaikhoan.Value == 4)
            {
                quyen = true;
            }
            var danhsach1 = entity.tbl_QuyenSuDungFile.Where(m => ((quyen == true) ? (m.kieufile == "images") : (m.id_taikhoan.Value == session.id && m.kieufile == "images"))).ToList().Select(m => new
            {
                m.QuanLyFileUpload.tenfile,
                m.QuanLyFileUpload.duongdanfile,
                m.QuanLyFileUpload.id_quanlyfileupload,
                m.QuanLyFileUpload.id_taikhoan,
                m.QuanLyFileUpload.id_quanlythumuc,
                m.QuanLyFileUpload.mimetype,
                m.QuanLyFileUpload.ngayupload,
                m.QuanLyFileUpload.dungluongfile,
                m.QuanLyFileUpload.trangthai
            }).ToList().OrderByDescending(m => m.ngayupload.Value);


            var danhsach = from a in danhsach1.Where(d => d.trangthai == true)
                           group a by new
                            {
                                a.id_quanlyfileupload
                            } into nhomfile
                           select new
                           {

                               id_quanlyfileupload = nhomfile.Key.id_quanlyfileupload,
                               tenfile = nhomfile.Select(gg => gg.tenfile).FirstOrDefault(),
                               duongdanfile = nhomfile.Select(gg => gg.duongdanfile).FirstOrDefault(),
                               id_taikhoan = nhomfile.Select(gg => gg.id_taikhoan).FirstOrDefault(),
                               id_quanlythumuc = nhomfile.Select(gg => gg.id_quanlythumuc).FirstOrDefault(),
                               mimetype = nhomfile.Select(gg => gg.mimetype).FirstOrDefault(),
                               ngayupload = nhomfile.Select(gg => gg.ngayupload).FirstOrDefault(),
                               dungluongfile = nhomfile.Select(gg => gg.dungluongfile).FirstOrDefault(),
                               trangthai = nhomfile.Select(gg => gg.trangthai).FirstOrDefault()
                           };

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }
    public void uploadfileanhtuserver(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string linkResponse = "";

        if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {

            int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            string dungluong = context.Request["dungluong"];
            if (session != null)
            {
                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu = "";
                string nhaytrang;
                int gioihandata = 1048576 * 10;
                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);
                    int type = (mimeType.IndexOf("image/"));

                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }

                    else
                    {
                        if (type >= 0)
                        {

                            if (mimeType == "image/png")
                            {
                                typeFile = Path.GetExtension(file.FileName);
                                tenfile = MD5.RandomString(16);
                                fileanhluu = "/ThuMucGoc/AnhTaiLieuUpload/" + tenfile + typeFile;
                                duongdan = context.Server.MapPath("~" + fileanhluu);
                                file.SaveAs(duongdan);
                            }
                            else
                            {

                                string sImageName = file.FileName;

                                file.SaveAs(context.Server.MapPath("~/images/" + Path.GetFileName(sImageName)));

                                Bitmap bitmap = new Bitmap(context.Server.MapPath("~/images/" + Path.GetFileName(file.FileName)));

                                int iwidth = bitmap.Width;
                                int iheight = bitmap.Height;
                                bitmap.Dispose();

                                System.Drawing.Image objOptImage = new System.Drawing.Bitmap(iwidth, iheight, System.Drawing.Imaging.PixelFormat.Format16bppRgb555);
                                using (System.Drawing.Image objImg = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/images/" + sImageName)))
                                {
                                    using (System.Drawing.Graphics oGraphic = System.Drawing.Graphics.FromImage(objOptImage))
                                    {
                                        var _1 = oGraphic;
                                        System.Drawing.Rectangle oRectangle = new System.Drawing.Rectangle(0, 0, iwidth, iheight);
                                        _1.DrawImage(objImg, oRectangle);
                                    }

                                    typeFile = Path.GetExtension(sImageName);
                                    tenfile = MD5.RandomString(16);
                                    fileanhluu = "/ThuMucGoc/AnhTaiLieuUpload/" + tenfile + typeFile;

                                    objOptImage.Save(HttpContext.Current.Server.MapPath("~" + fileanhluu), System.Drawing.Imaging.ImageFormat.Jpeg);
                                    objImg.Dispose();
                                }
                                objOptImage.Dispose();
                            }

                            //abababababa
                            // check mime type by byte file
                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsImages(ff);
                            if (ck_Type == true)
                            {
                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                //   qlFile.duongdanfile = "/path-img2/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();
                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";
                                    linkResponse = qlFile.duongdanfile;
                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Kiểu file upload đã bị thay đổi (jpeg,gif,png,bmp,ico)";
                            }
                        }
                        else
                        {
                            msg = "Kiểu file upload không hợp lệ (jpeg,gif,png,bmp,ico)";
                        }
                    }
                }

            }
            else
            {
                msg = "Session không tồn tại";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess, linkResponse = linkResponse }, Formatting.Indented));
    }

    public void uploadfileanh(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        int _idthumuc = 0;

        if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]) && new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["dungluong"]))
        {
            List<int> danhsachadmin = (List<int>)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(List<int>));

            //  int _idthumuc = int.Parse(context.Request["_idthumuc"]);
            int.TryParse(context.Request["_idthumuc"], out _idthumuc);

            string dungluong = context.Request["dungluong"];
            if (session != null)
            {

                string tenfile;
                string duongdan;
                string typeFile;
                string tenanh;
                string fileanhluu = "";
                string nhaytrang;
                int gioihandata = 1048576 * 10;
                if (context.Request.Files.Count > 0)
                {
                    string tenmoicuafle;
                    HttpFileCollection files = context.Request.Files;
                    HttpPostedFile file = context.Request.Files["fileanh"];
                    string mimeType = MimeMapping.GetMimeMapping(file.FileName);
                    int type = (mimeType.IndexOf("image/"));

                    int filesize = file.ContentLength;
                    if (filesize > gioihandata)
                    {
                        msg = "Dung lượng file vượt quá quy định ";
                    }

                    else
                    {
                        if (type >= 0)
                        {

                            if (mimeType == "image/png")
                            {
                                typeFile = Path.GetExtension(file.FileName);
                                tenfile = MD5.RandomString(16);
                                fileanhluu = "/ThuMucGoc/AnhTaiLieuUpload/" + tenfile + typeFile;
                                duongdan = context.Server.MapPath("~" + fileanhluu);
                                file.SaveAs(duongdan);
                            }
                            else
                            {

                                string sImageName = file.FileName;

                                file.SaveAs(context.Server.MapPath("~/images/" + Path.GetFileName(sImageName)));

                                Bitmap bitmap = new Bitmap(context.Server.MapPath("~/images/" + Path.GetFileName(file.FileName)));

                                int iwidth = bitmap.Width;
                                int iheight = bitmap.Height;
                                bitmap.Dispose();

                                System.Drawing.Image objOptImage = new System.Drawing.Bitmap(iwidth, iheight, System.Drawing.Imaging.PixelFormat.Format16bppRgb555);
                                using (System.Drawing.Image objImg = System.Drawing.Image.FromFile(HttpContext.Current.Server.MapPath("~/images/" + sImageName)))
                                {
                                    using (System.Drawing.Graphics oGraphic = System.Drawing.Graphics.FromImage(objOptImage))
                                    {
                                        var _1 = oGraphic;
                                        System.Drawing.Rectangle oRectangle = new System.Drawing.Rectangle(0, 0, iwidth, iheight);
                                        _1.DrawImage(objImg, oRectangle);
                                    }

                                    typeFile = Path.GetExtension(sImageName);
                                    tenfile = MD5.RandomString(16);
                                    fileanhluu = "/ThuMucGoc/AnhTaiLieuUpload/" + tenfile + typeFile;

                                    objOptImage.Save(HttpContext.Current.Server.MapPath("~" + fileanhluu), System.Drawing.Imaging.ImageFormat.Jpeg);
                                    objImg.Dispose();
                                }
                                objOptImage.Dispose();
                            }

                            //abababababa

                            string link_CK = context.Server.MapPath("~" + fileanhluu);

                            FileInfo ff = new FileInfo(link_CK);
                            bool ck_Type = MimeDetective.Extension.Documents.DocumentExtensions.IsImages(ff);
                            if (ck_Type == true)
                            {

                                var checktrungten = entity.QuanLyFileUpload.Where(m => m.tenfile == file.FileName).FirstOrDefault();
                                if (checktrungten == null)
                                {
                                    tenmoicuafle = file.FileName;
                                }
                                else
                                {
                                    tenmoicuafle = MD5.RandomString(5) + file.FileName;
                                }
                                QuanLyFileUpload qlFile = new QuanLyFileUpload();
                                qlFile.tenfile = tenmoicuafle;
                                qlFile.mimetype = mimeType;
                                qlFile.ngayupload = DateTime.Now;
                                qlFile.id_quanlythumuc = _idthumuc;
                                qlFile.id_taikhoan = session.id;
                                qlFile.dungluongfile = dungluong;
                                qlFile.trangthai = true;
                                qlFile.duongdanfile = fileanhluu;
                                // qlFile.duongdanfile = "/path-img2/" + tenfile + typeFile;
                                entity.QuanLyFileUpload.Add(qlFile);
                                int kq = entity.SaveChanges();
                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";

                                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = qlFile }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);

                                }
                                if (danhsachadmin.Count > 0)
                                {
                                    for (int i = 0; i < danhsachadmin.Count; i++)
                                    {
                                        tbl_QuyenSuDungFile sd = new tbl_QuyenSuDungFile();
                                        sd.id_taikhoan = danhsachadmin[i];
                                        sd.id_quanlyfileupload = qlFile.id_quanlyfileupload;
                                        sd.kieufile = "images";
                                        entity.tbl_QuyenSuDungFile.Add(sd);
                                        entity.SaveChanges();

                                        sucess = true;
                                        msg = "Thêm mới thành công .";
                                        string vitri = new Libs().VitriTruyCapVaIP("tbl_QuyenSuDungFile", new Libs().ThietBiTruyCap());
                                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { sd.id_taikhoan, sd.id_quanlyfileupload, sd.id_quyensd } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                        new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                    }
                                }
                            }
                            else
                            {
                                if (System.IO.File.Exists(link_CK))
                                {
                                    System.IO.File.Delete(link_CK);
                                }
                                msg = "Định dạng file upload đã bị thay đổi (jpeg,gif,png,bmp,ico)";
                            }
                        }
                        else
                        {
                            msg = "Kiểu file upload không hợp lệ (jpeg,gif,png,bmp,ico)";
                        }
                    }
                }

            }
            else
            {
                msg = "Session không tồn tại";
            }
        }
        else
        {
            msg = "Có lỗi trong quá trình thao tác dữ liệu";
        }
        if (sucess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogThemMoiThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
    }

    public void xoafile(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        string msg = "Bạn không có quyền với chức năng này";
        int _idfile = 0;

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idfile"]))
            {
                // int _idfile = int.Parse(context.Request["_idfile"]);
                int.TryParse(context.Request["_idfile"], out _idfile);
                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }
                var checkquyen = entity.QuanLyFileUpload.Where(m => m.id_taikhoan == session.id && m.id_quanlyfileupload == _idfile).Any();
                if (quyen == true || checkquyen == true)
                {
                    var checkfile = entity.QuanLyFileUpload.Where(m => m.id_quanlyfileupload == _idfile).FirstOrDefault();
                    if (checkfile != null)
                    {
                        var checksudungfile = new Libs().checkfilesudung(checkfile.duongdanfile);
                        if (checksudungfile == true)
                        {
                            msg = "File đang được sử dụng bạn không thể xóa ";
                        }
                        else
                        {
                            var pathFile = context.Server.MapPath(checkfile.duongdanfile);
                            // xoa file trong thu muc
                            if (System.IO.File.Exists(pathFile))
                            {
                                System.IO.File.Delete(pathFile);
                            }
                            // xoa ban ghi trong bang quyen su dung
                            entity.tbl_QuyenSuDungFile.Where(x => x.id_quanlyfileupload == checkfile.id_quanlyfileupload).ToList().All(x =>
                            {
                                entity.tbl_QuyenSuDungFile.Remove(x);
                                return true;
                            });
                            // xoa ban ghi trong bang quan ly file
                            entity.QuanLyFileUpload.Where(x => x.id_quanlyfileupload == checkfile.id_quanlyfileupload).ToList().All(x =>
                            {
                                entity.QuanLyFileUpload.Remove(x);
                                return true;
                            });

                            suscess = entity.SaveChanges() == 1;
                            suscess = true;
                            msg = "Xóa file thành công";

                            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checkfile.tenfile, checkfile.id_quanlyfileupload, checkfile.id_quanlythumuc, checkfile.id_taikhoan, checkfile.mimetype, checkfile.ngayupload, checkfile.duongdanfile, checkfile.dungluongfile } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                    }
                    else
                    {
                        msg = "File không tồn tại ";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogXoaThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { suscess = suscess, msg = msg }, Formatting.Indented));
    }

    public void doitenfile(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        string msg = "Bạn không có quyền chỉnh sửa với file này";
        int _idfile = 0;
        int _idThumuc = 0;

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_tenfile"]) && new Libs().checkDuLieuGuiLen(context.Request["_idfile"]) && new Libs().checkDuLieuGuiLen(context.Request["_idThumuc"]))
            {

                string _tenfile = context.Request["_tenfile"];
                //int _idfile = int.Parse(context.Request["_idfile"]);
                //int _idThumuc = int.Parse(context.Request["_idThumuc"]);

                int.TryParse(context.Request["_idfile"], out _idfile);
                int.TryParse(context.Request["_idThumuc"], out _idThumuc);

                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }
                var checkquyen = entity.QuanLyFileUpload.Where(m => m.id_taikhoan == session.id && m.id_quanlyfileupload == _idfile).Any();
                var checktrungten = entity.QuanLyFileUpload.Where(m => m.id_quanlythumuc == _idThumuc && m.tenfile == _tenfile && m.id_quanlyfileupload != _idfile).Any();
                if (quyen == true || checkquyen == true)
                {
                    if (checktrungten == false)
                    {
                        var dulieucu = entity.QuanLyFileUpload.Where(m => m.id_quanlyfileupload == _idfile).Select(m => new
                        {
                            m.id_quanlyfileupload,
                            m.id_quanlythumuc,
                            m.id_taikhoan,
                            m.tenfile,
                            m.trangthai,
                            m.ngayupload,
                            m.mimetype,
                            m.duongdanfile

                        }).FirstOrDefault();
                        string jsonDuLieuCu = JsonConvert.SerializeObject(dulieucu, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                        var checkfile = entity.QuanLyFileUpload.Where(m => m.id_quanlyfileupload == _idfile).FirstOrDefault();
                        if (checkfile != null)
                        {
                            checkfile.tenfile = _tenfile;
                            entity.SaveChanges();
                            suscess = true;
                            msg = "Đổi tên file thành công";


                            QuanLyFileUpload dataJson = (QuanLyFileUpload)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(QuanLyFileUpload));
                            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { checkfile.id_quanlyfileupload, checkfile.id_quanlythumuc, checkfile.id_taikhoan, checkfile.tenfile, checkfile.duongdanfile, checkfile.dungluongfile, checkfile.mimetype, checkfile.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                        }
                        else
                        {
                            suscess = false;
                            msg = "File không tồn tại";
                        }
                    }
                    else
                    {
                        suscess = false;
                        msg = "Tên file đã tồn tại vui lòng chọn tên khác";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với file này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }

        if (suscess == false)
        {
            string vitri = new Libs().VitriTruyCapVaIP("QuanLyFileUpload", new Libs().ThietBiTruyCap());
            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg, }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
            new Libs().updateKieuLogSuaThongTinThatBai(idlog);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { suscess = suscess, msg = msg }, Formatting.Indented));
    }

    public void danhsachdulieutrongthumuc(HttpContext context)
    {
        bool quyen = false;
        int _idthumuc = int.Parse(context.Request["_idthumuc"]);


        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }
            var danhsach = entity.QuanLyFileUpload.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id)) && m.trangthai == true).ToList().Select(m => new
            {
                m.id_quanlyfileupload,
                m.tenfile,
                m.mimetype,
                m.ngayupload,
                m.id_quanlythumuc,
                m.id_taikhoan,
                m.dungluongfile,
                m.trangthai,
                m.duongdanfile
            }).ToList().OrderByDescending(m => m.ngayupload.Value);

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }

    public void coppythumuc(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        string msg = "Di chuyển không thành công ";
        int _idthumuc = 0;
        int _idparent = 0;

        if (session != null)
        {

            if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["_idparent"]))
            {


                //int _idthumuc = int.Parse(context.Request["_idthumuc"]);
                //int _idparent = int.Parse(context.Request["_idparent"]);

                int.TryParse(context.Request["_idthumuc"], out _idthumuc);
                int.TryParse(context.Request["_idparent"], out _idparent);

                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }

                var check = entity.QuanLyThuMuc.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id))).FirstOrDefault();
                if (check != null)
                {
                    List<QuanLyThuMuc> oDanhMuc = new List<QuanLyThuMuc>();
                    entity.QuanLyThuMuc.Where(m => m.id_quanlythumuc == _idthumuc).ToList().Select(x =>
                    {
                        Libs.jsonthumuc m = new Libs.jsonthumuc();
                        m.id_quanlythumuc = x.id_quanlythumuc;
                        m.tenthumuc = x.tenthumuc;
                        m.ngaytao = x.ngaytao;
                        m.id_taikhoan = x.id_taikhoan;
                        m.trangthai = x.trangthai;
                        m.idParents = x.idParents;
                        m.icon = x.icon;

                        QuanLyThuMuc thumuc = new QuanLyThuMuc();
                        thumuc.tenthumuc = x.tenthumuc;
                        thumuc.ngaytao = DateTime.Now;
                        thumuc.id_taikhoan = session.id;
                        thumuc.trangthai = true;
                        thumuc.idParents = _idparent;
                        thumuc.icon = "fa fa-folder-open";
                        entity.QuanLyThuMuc.Add(thumuc);
                        entity.SaveChanges();

                        string vitri = new Libs().VitriTruyCapVaIP("QuanLyThuMuc", new Libs().ThietBiTruyCap());
                        int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { thumuc.tenthumuc, thumuc.ngaytao, thumuc.id_quanlythumuc, thumuc.id_taikhoan, thumuc.idParents, } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                        new Libs().updateKieuLogThemMoiThanhCong(idlog);

                        new Libs().jsoncoppythumuc(m, thumuc.id_quanlythumuc);

                        oDanhMuc.Add(thumuc);
                        suscess = true;
                        msg = "Di chuyển thư mục thành công ";

                        return true;

                    }).FirstOrDefault();

                }
                else
                {
                    msg = "Bạn không có quyền với file này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }

    public void dichuyenthumuc(HttpContext context)
    {
        bool quyen = false;
        bool suscess = false;
        string msg = "Di chuyển không thành công ";
        int _idthumuc = 0, _idparent = 0;

        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["_idparent"]))
            {

                //int _idthumuc = int.Parse(context.Request["_idthumuc"]);
                //int _idparent = int.Parse(context.Request["_idparent"]);

                int.TryParse(context.Request["_idthumuc"], out _idthumuc);
                int.TryParse(context.Request["_idparent"], out _idparent);

                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }
                var check = entity.QuanLyThuMuc.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id))).FirstOrDefault();

                var dulieucu = entity.QuanLyThuMuc.Where(m => m.id_quanlythumuc == _idthumuc).Select(m => new
                {
                    m.tenthumuc,
                    m.ngaytao,
                    m.id_quanlythumuc,
                    m.id_taikhoan,
                    m.trangthai,
                    m.idParents,
                    m.icon
                }).FirstOrDefault();
                string jsonDuLieuCu = JsonConvert.SerializeObject(dulieucu, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                if (check != null)
                {
                    check.idParents = _idparent;
                    entity.SaveChanges();
                    suscess = true;
                    msg = "Di chuyển thư mục thành công ";

                    QuanLyThuMuc dataJson = (QuanLyThuMuc)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(QuanLyThuMuc));
                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyThuMuc", new Libs().ThietBiTruyCap());
                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.tenthumuc, check.ngaytao, check.id_quanlythumuc, check.id_taikhoan, check.idParents, check.trangthai, check.icon } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                }
                else
                {
                    msg = "Có lỗi phát sinh";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void doitenthumuc(HttpContext context)
    {

        bool suscess = false;
        string msg = "Thay đổi không thành công ";
        bool quyen = false;
        int _idthumuc = 0;
        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idthumuc"]) && new Libs().checkDuLieuGuiLen(context.Request["_tenmoi"]))
            {
                // int _idthumuc = int.Parse(context.Request["_idthumuc"]);

                int.TryParse(context.Request["_idthumuc"], out _idthumuc);
                string _tenmoi = context.Request["_tenmoi"];
                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }
                var check = entity.QuanLyThuMuc.Where(m => ((quyen == true) ? (m.id_quanlythumuc == _idthumuc) : (m.id_quanlythumuc == _idthumuc && m.id_taikhoan == session.id))).FirstOrDefault();
                var dulieucu = entity.QuanLyThuMuc.Where(m => m.id_quanlythumuc == _idthumuc).Select(m => new
                {
                    m.tenthumuc,
                    m.id_quanlythumuc,
                    m.id_taikhoan,
                    m.idParents,
                    m.ngaytao,
                    m.icon
                }).FirstOrDefault();
                string jsonDuLieuCu = JsonConvert.SerializeObject(dulieucu, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

                if (check != null)
                {
                    check.tenthumuc = _tenmoi;
                    entity.SaveChanges();
                    suscess = true;
                    msg = "Đổi tên thư mục thành công ";


                    QuanLyThuMuc dataJson = (QuanLyThuMuc)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(QuanLyThuMuc));
                    string vitri = new Libs().VitriTruyCapVaIP("QuanLyThuMuc", new Libs().ThietBiTruyCap());
                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.tenthumuc, check.ngaytao, check.id_quanlythumuc, check.id_taikhoan, check.idParents } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                }
                else
                {
                    msg = "Có lỗi phát sinh ";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại ";
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }


    public void xoathumuc(HttpContext context)
    {

        bool suscess = false;
        string msg = "Bạn không có quyền với chức năng này";
        bool quyen = false;
        int idnode = 0;

        if (session != null)
        {

            if (new Libs().checkDuLieuGuiLen(context.Request["_idnode"]))
            {
                // int idnode = int.Parse(context.Request["_idnode"]);

                int.TryParse(context.Request["_idnode"], out idnode);
                var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();
                if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
                {
                    quyen = true;
                }

                var check = entity.QuanLyThuMuc.Where(m => ((quyen == true) ? (m.id_quanlythumuc == idnode) : (m.id_quanlythumuc == idnode && m.id_taikhoan == session.id))).FirstOrDefault();
                string vitri = new Libs().VitriTruyCapVaIP("QuanLyThuMuc", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_quanlythumuc, check.tenthumuc } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);

                if (check != null)
                {
                    check.trangthai = false;
                    entity.SaveChanges();
                    suscess = true;
                    msg = "Xóa thư mục thành công ";
                    new Libs().updateKieuLogXoaThanhCong(idlog);

                }
                else
                {
                    new Libs().updateKieuLogXoaThatBai(idlog);
                    msg = "Xóa thất bại";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, suscess = suscess }, Formatting.Indented));
    }

    public void themmoithumuc(HttpContext context)
    {


        bool suscess = false;
        int idcha = 0;
        if (session != null)
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["_idcha"]) && new Libs().checkDuLieuGuiLen(context.Request["_tencon"]))
            {

                // int idcha = int.Parse(context.Request["_idcha"]);

                int.TryParse(context.Request["_idcha"], out idcha);
                string tencon = context.Request["_tencon"];
                QuanLyThuMuc thumuc = new QuanLyThuMuc();
                thumuc.tenthumuc = tencon;
                thumuc.ngaytao = DateTime.Now;
                thumuc.id_taikhoan = session.id;
                thumuc.trangthai = true;
                thumuc.idParents = idcha;
                thumuc.icon = "fa fa-folder-open";
                entity.QuanLyThuMuc.Add(thumuc);
                int kq = entity.SaveChanges();
                if (kq == 1)
                {
                    suscess = true;
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write(JsonConvert.SerializeObject(new { suscess = suscess, thumuc.id_quanlythumuc }, Formatting.Indented));
            }
        }
    }

    public void loaddanhsachthumucanh(HttpContext context)
    {

        int id_tm = -1;
        bool quyen = false;

        if (session != null)
        {
            var checktk = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

            if (checktk.loaitaikhoan == 3 || checktk.loaitaikhoan == 4)
            {
                quyen = true;
            }

            List<Libs.jsTree> data = new List<Libs.jsTree>();
            if (int.TryParse(context.Request["id_tm"], out id_tm))
            {
                entity.QuanLyThuMuc.Where(x => ((quyen == true) ? ((id_tm == 0 ? (x.id_quanlythumuc == 1) : (x.idParents == id_tm)) && x.trangthai == true) : ((id_tm == 0 ? (x.id_quanlythumuc == 1) : (x.idParents == id_tm && x.id_taikhoan == session.id)) && x.trangthai == true))).ToList().All(x =>
                {
                    Libs.jsonthumuc json = new Libs.jsonthumuc();
                    Libs.jsTree item = new Libs.jsTree();
                    item.text = x.tenthumuc;
                    item.id = x.id_quanlythumuc;
                    item.children = entity.QuanLyThuMuc.Where(xx => xx.idParents == x.id_quanlythumuc).Any();
                    item.data = new Libs.jsData() { child = json };
                    data.Add(item);
                    return true;
                });
            }
            context.Response.ContentType = "application/json";
            context.Response.Write(JsonConvert.SerializeObject(data, Formatting.Indented));
        }
    }



    public void xoathongtinlienket(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.lienkethoptac thongtincb = (Contructor.lienkethoptac)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.lienkethoptac));
                if (new Libs().QuyenXoaTrongTrang())
                {
                    if (session != null)
                    {
                        var check = entity.tbl_LienKetHopTac.Where(m => m.id_lienkethoptac == thongtincb.id).FirstOrDefault();
                        if (check != null)
                        {
                            check.trangthai = 0;
                            entity.SaveChanges();

                            sucess = true;
                            msg = "Xóa thành công !";

                            string vitri = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap());
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { check.id_lienkethoptac, check.tendoitac, check.avatar, check.linkdiachi, check.trangthai, check.target, check.thongtindoitac } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Liên kết không tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền với chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }

            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Có lỗi trong quá trình thao tác", sucess = sucess }, Formatting.Indented));
        }
    }


    public void capnhatthongtinlienkethoptac(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            Contructor.lienkethoptac thongtincb;
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                thongtincb = (Contructor.lienkethoptac)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.lienkethoptac));
                if (new Libs().QuyenSuaTrongTrang())
                {

                    if (session != null)
                    {
                        var check = entity.tbl_LienKetHopTac.Where(m => m.id_lienkethoptac == thongtincb.id).FirstOrDefault();
                        var checktrung = entity.tbl_LienKetHopTac.Where(m => m.id_lienkethoptac != thongtincb.id && m.tendoitac == thongtincb.tendoitac && m.linkdiachi == thongtincb.linkdiachi).FirstOrDefault();
                        if (check != null)
                        {
                            string ErrorCheck = new validateform().CallValidateThemLienKetHopTac(thongtincb.tendoitac, thongtincb.linkdiachi, thongtincb.thongtindoitac, thongtincb.avatar, thongtincb.target, thongtincb.trangthai);
                            if (ErrorCheck == null)
                            {
                                if (checktrung == null)
                                {
                                    string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_lienkethoptac, check.tendoitac, check.avatar, check.linkdiachi, check.thongtindoitac, check.target, check.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                    string nhaytrang = "";
                                    check.tendoitac = removeScriptAndCharacter.formatTextInput(thongtincb.tendoitac);
                                    check.linkdiachi = removeScriptAndCharacter.formatTextInput(thongtincb.linkdiachi);
                                    check.thongtindoitac = removeScriptAndCharacter.formatTextInput(thongtincb.thongtindoitac);
                                    check.avatar = removeScriptAndCharacter.formatTextInput(thongtincb.avatar);
                                    if (thongtincb.target == "0")
                                    {
                                        nhaytrang = "_blank";
                                    }
                                    else
                                    {
                                        nhaytrang = "_self";
                                    }
                                    check.target = nhaytrang;
                                    if (thongtincb.trangthai == "hienthi")
                                    {
                                        check.trangthai = 2;
                                    }
                                    else
                                    {
                                        check.trangthai = 1;
                                    }

                                    entity.SaveChanges();
                                    sucess = true;
                                    msg = "Cập nhật thông tin thành công ";

                                    tbl_LienKetHopTac dataJson = (tbl_LienKetHopTac)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_LienKetHopTac));
                                    string vitri = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap());
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = dataJson, dulieumoi = new { check.id_lienkethoptac, check.tendoitac, check.avatar, check.linkdiachi, check.thongtindoitac, check.target, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                                    new Libs().updateKieuLogSuaThongTinThanhCong(idlog);

                                }
                                else
                                {
                                    msg = "Tên liên kết đã tồn tại trong hệ thống";
                                }
                            }
                            else
                            {
                                msg = ErrorCheck;
                            }
                        }
                        else
                        {
                            msg = "Liên kết không tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tác dữ liệu";
            }


            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri);
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);

            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = msg }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, msg = "Có lỗi trong quá trình thao tác" }, Formatting.Indented));
        }
    }



    public void themmoilienkethoptac(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        string nhaytrang = "";

        try
        {
            if (new Libs().checkDuLieuGuiLen(context.Request["thongtin"]))
            {
                Contructor.lienkethoptac thongtincb = (Contructor.lienkethoptac)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Contructor.lienkethoptac));
                if (new Libs().QuyenThemMoi())
                {
                    if (session != null)
                    {
                        string ErrorCheck = new validateform().CallValidateThemLienKetHopTac(thongtincb.tendoitac, thongtincb.linkdiachi, thongtincb.thongtindoitac, thongtincb.avatar, thongtincb.target, thongtincb.trangthai);
                        if (ErrorCheck == null)
                        {
                            var check = entity.tbl_LienKetHopTac.Where(m => m.tendoitac == thongtincb.tendoitac && m.linkdiachi == thongtincb.linkdiachi && m.trangthai != 0).FirstOrDefault();
                            if (check == null)
                            {
                                tbl_LienKetHopTac lienket = new tbl_LienKetHopTac();
                                lienket.tendoitac = removeScriptAndCharacter.formatTextInput(thongtincb.tendoitac);
                                lienket.avatar = removeScriptAndCharacter.formatTextInput(thongtincb.avatar);
                                lienket.linkdiachi = removeScriptAndCharacter.formatTextInput(thongtincb.linkdiachi);
                                lienket.thongtindoitac = removeScriptAndCharacter.formatTextInput(thongtincb.thongtindoitac);
                                if (thongtincb.target == "0")
                                {
                                    nhaytrang = "_blank";
                                }
                                else
                                {
                                    nhaytrang = "_self";
                                }
                                lienket.target = nhaytrang;
                                if (thongtincb.trangthai == "hienthi")
                                {
                                    lienket.trangthai = 2;
                                }
                                else
                                {
                                    lienket.trangthai = 1;
                                }
                                entity.tbl_LienKetHopTac.Add(lienket);
                                int kq = entity.SaveChanges();
                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới thành công .";

                                    string vitri1 = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap()); // vitri
                                    int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { lienket.id_lienkethoptac, lienket.tendoitac, lienket.avatar, lienket.linkdiachi, lienket.thongtindoitac, lienket.target, lienket.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog1);
                                }
                            }
                            else if (check != null && check.trangthai == 0)
                            {
                                string jsonDuLieuCu = JsonConvert.SerializeObject(new { check.id_lienkethoptac, check.tendoitac, check.avatar, check.linkdiachi, check.thongtindoitac, check.target, check.trangthai }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                                check.tendoitac = removeScriptAndCharacter.formatTextInput(thongtincb.tendoitac);
                                check.avatar = removeScriptAndCharacter.formatTextInput(thongtincb.avatar);
                                check.linkdiachi = removeScriptAndCharacter.formatTextInput(thongtincb.linkdiachi);
                                check.thongtindoitac = removeScriptAndCharacter.formatTextInput(thongtincb.thongtindoitac);
                                if (thongtincb.target == "0")
                                {
                                    nhaytrang = "_blank";
                                }
                                else
                                {
                                    nhaytrang = "_self";
                                }
                                check.target = nhaytrang;
                                if (thongtincb.trangthai == "hienthi")
                                {
                                    check.trangthai = 2;
                                }
                                else
                                {
                                    check.trangthai = 1;
                                }
                                entity.SaveChanges();
                                sucess = true;
                                msg = "Thêm mới thành công .";

                                tbl_LienKetHopTac cbo = (tbl_LienKetHopTac)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(tbl_LienKetHopTac));
                                string vitri = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap()); // vitri
                                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = cbo, dulieumoi = new { check.id_lienkethoptac, check.tendoitac, check.avatar, check.linkdiachi, check.thongtindoitac, check.target, check.trangthai } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                                new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                            }
                            else
                            {
                                sucess = false;
                                msg = "Thêm mới thất bại";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Session không tồn tại";
                    }
                }
                else
                {
                    msg = "Bạn không có quyền thực hiện chức năng này";
                }
            }
            else
            {
                msg = "Có lỗi trong quá trình thao tá dữ liệu";
            }
            if (sucess == false)
            {
                string vitri1 = new Libs().VitriTruyCapVaIP("tbl_LienKetHopTac", new Libs().ThietBiTruyCap()); // vitri
                int idlog1 = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri1); // luu log lan 1
                new Libs().updateKieuLogThemMoiThatBai(idlog1);
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

    //alo
    public void danhsachlienkethoptac(HttpContext context)
    {
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));
            var danhsach = entity.tbl_LienKetHopTac.Where(m => m.trangthai != 0).ToList().OrderByDescending(m => m.id_lienkethoptac).Select(m => new
            {
                m.avatar,
                m.id_lienkethoptac,
                m.linkdiachi,
                m.target,
                m.tendoitac,
                m.thongtindoitac,
                m.trangthai,
                button = new
                {
                    m.id_lienkethoptac,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }

    }




    public void danhsachquyen(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;


        if (session != null)
        {
            var ds = entity.TaiKhoan.Where(m => m.id_taikhoan == session.id).FirstOrDefault();

            if (ds != null)
            {
                var danhsach = entity.NhomQuyen.Where(m => m.id_nhomadmin == ds.id_nhomadmin).Select(m => new
                {
                    tenmenu = m.tbl_Menu.tenmenu,
                    m.id_menu,
                    m.id_nhomadmin,
                    tennhom = m.NhomAdmin.tennhom,
                    m.them,
                    m.xem,
                    m.sua,
                    m.xoa
                }).ToList();
                if (ds != null && ds.loaitaikhoan == 2)
                {
                    sucess = true;
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, data = danhsach }, Formatting.Indented));
                }
                else if (ds.loaitaikhoan == 3 || ds.loaitaikhoan == 4)
                {
                    sucess = true;
                    var guive = (new
                    {
                        tenmenu = "Tất cả các mục trong hệ thống",
                        them = true,
                        xem = true,
                        sua = true,
                        xoa = true,
                    });
                    List<object> friendsNames = new List<object>();
                    friendsNames.Add(guive);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess, data = friendsNames }, Formatting.Indented));
                }
            }
            else
            {
                msg = "Tài khoản không tồn tại";
            }
        }
        else
        {
            msg = "Session không tồn tại";
        }
        if (sucess == false)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, data = "" }, Formatting.Indented));
        }
    }
    public void xoataikhoanadmin(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            if (new Libs().QuyenXoaTrongTrang())
            {
                if (session != null)
                {
                    if (context.Request["thongtin"] != null)
                    {
                        Libs.thongtinConvert thongtintk = (Libs.thongtinConvert)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Libs.thongtinConvert));

                        var checktk = entity.TaiKhoan.Where(m => m.taikhoan1 == thongtintk.tendangnhap || m.email == thongtintk.email).FirstOrDefault();

                        if (checktk != null)
                        {
                            checktk.trangthaitk = false;
                            entity.SaveChanges();
                            sucess = true;
                            msg = "Xóa tài khoản thành công !";


                            string mailto = checktk.email;
                            string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", checktk.tendaydu);
                            string body = string.Format("Xin chào {0} !<br /> Tài khoản quản trị của bạn với tên đăng nhập là : {1} , đã bị xóa khỏi hệ thống của chúng tôi .<br />  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", checktk.tendaydu, checktk.taikhoan1);
                            bool guimail = new Libs().sendEmail(mailto, subject, body);

                            if (!guimail)
                            {
                                msg = "Đã xóa tài khoản nhưng gửi mail không thành công";
                            }
                            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = new { checktk.id_taikhoan, checktk.taikhoan1, checktk.matkhau, checktk.tendaydu, checktk.email, checktk.sodienthoai, checktk.trangthaitk, checktk.id_nhomadmin, checktk.ngaytao, checktk.loaitaikhoan, checktk.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogXoaThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Tài khoản không tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap());
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtinxoa = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogXoaThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }
    }

    public void suathongtintaikhoanadmin(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;
        try
        {
            if (new Libs().QuyenSuaTrongTrang())
            {

                if (session != null)
                {
                    if (context.Request["thongtin"] != null)
                    {
                        Libs.thongtinConvert thongtintk = (Libs.thongtinConvert)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Libs.thongtinConvert));

                        var checktk = entity.TaiKhoan.Where(m => m.taikhoan1 == thongtintk.tendangnhap || m.email == thongtintk.email).FirstOrDefault();
                        var dulieucu = entity.TaiKhoan.Where(m => m.taikhoan1 == thongtintk.tendangnhap || m.email == thongtintk.email).FirstOrDefault();
                        string jsonDuLieuCu = JsonConvert.SerializeObject(new { dulieucu.id_taikhoan, dulieucu.taikhoan1, dulieucu.matkhau, dulieucu.tendaydu, dulieucu.email, dulieucu.sodienthoai, dulieucu.trangthaitk, dulieucu.id_nhomadmin, dulieucu.ngaytao, dulieucu.loaitaikhoan, dulieucu.avatar }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });
                        if (checktk != null)
                        {
                            checktk.id_nhomadmin = client.ToInt(thongtintk.idnhomquanly);
                            int kq = entity.SaveChanges();

                            sucess = true;
                            msg = "Cập nhật nhóm quản lý khoản thành công !";


                            string mailto = checktk.email;
                            string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", checktk.tendaydu);
                            string body = string.Format("Xin chào {0} !<br /> Tài khoản quản trị của bạn với tên đăng nhập là : {1} .<br Đã được thay đổi quyền hạn quản lý trong hệ thống />Vui lòng đăng nhập hệ thống để xem chi tiết .<br />  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", checktk.tendaydu, checktk.taikhoan1);
                            bool guimail = new Libs().sendEmail(mailto, subject, body);

                            if (!guimail)
                            {
                                msg = "Đã cập nhật tài khoản nhưng gửi mail không thành công";
                            }

                            TaiKhoan tk = (TaiKhoan)JsonConvert.DeserializeObject(jsonDuLieuCu, typeof(TaiKhoan));
                            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                            int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { dulieucu = tk, dulieumoi = new { checktk.id_taikhoan, checktk.taikhoan1, checktk.matkhau, checktk.tendaydu, checktk.email, checktk.sodienthoai, checktk.trangthaitk, checktk.id_nhomadmin, checktk.ngaytao, checktk.loaitaikhoan, checktk.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                            new Libs().updateKieuLogSuaThongTinThanhCong(idlog);
                        }
                        else
                        {
                            msg = "Tài khoản không tồn tại";
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }
            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtintk = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogSuaThongTinThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }
    }

    public void checkquyenxemtrang(HttpContext context)
    {
        bool sucess = false;
        if (new Libs().QuyenVoiTrang())
        {

            sucess = true;
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess }, Formatting.Indented));
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { sucess = sucess }, Formatting.Indented));
        }
    }
    public void themmoiadmin(HttpContext context)
    {
        string msg = "Bạn không có quyền sử dụng chức năng này ";
        bool sucess = false;

        try
        {
            if (new Libs().QuyenThemMoi())
            {
                if (session != null)
                {
                    if (context.Request["thongtin"] != null)
                    {
                        Libs.thongtinConvert thongtintk = (Libs.thongtinConvert)JsonConvert.DeserializeObject(context.Request["thongtin"], typeof(Libs.thongtinConvert));
                        string ErrorCheck = new validateform().CallValidateThemMoiAdmin(thongtintk.tendangnhap, thongtintk.matkhau, thongtintk.email, thongtintk.tendaydu);

                        if (ErrorCheck == null)
                        {
                            var checktk = entity.TaiKhoan.Where(m => m.taikhoan1 == thongtintk.tendangnhap || m.email == thongtintk.email).FirstOrDefault();

                            if (checktk == null)
                            {
                                TaiKhoan tk = new TaiKhoan();
                                tk.email = removeScriptAndCharacter.formatTextInput(thongtintk.email);
                                if (thongtintk.idnhomquanly != 0)
                                {
                                    tk.id_nhomadmin = client.ToInt(thongtintk.idnhomquanly);
                                }
                                tk.loaitaikhoan = 2;
                                tk.ngaytao = DateTime.Now;
                                tk.taikhoan1 = removeScriptAndCharacter.formatTextInput(thongtintk.tendangnhap);
                                tk.trangthaitk = true;
                                tk.tendaydu = removeScriptAndCharacter.formatTextInput(thongtintk.tendaydu);
                                tk.matkhau = MD5.GeneratePasswordHash(thongtintk.matkhau);
                                tk.avatar = "/ThuMucGoc/AnhDaiDien/icondefaulAdmin.jpg";
                                //  tk.avatar = "/path-img1/icondefaulAdmin.jpg";
                                entity.TaiKhoan.Add(tk);
                                int kq = entity.SaveChanges();

                                if (kq != 0)
                                {
                                    sucess = true;
                                    msg = "Thêm mới tài khoản thành công !";
                                    string mailto = tk.email;
                                    string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", tk.taikhoan1);
                                    string body = string.Format("Xin chào {0} !<br /> Tài khoản quản trị của bạn đã được tạo với tên đăng nhập là : {1} <br/> Mật khẩu :{2} .<br />Email đăng ký : {3} .<br />Vui lòng đăng nhập hệ thống và cập nhập thêm một số thông tin cá nhân cần thiết .<br />  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", tk.taikhoan1, tk.taikhoan1, thongtintk.matkhau, tk.email);
                                    bool guimail = new Libs().sendEmail(mailto, subject, body);

                                    if (!guimail)
                                    {
                                        msg = "Đã tạo tài khoản nhưng gửi mail không thành công";
                                    }

                                    string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                                    int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtindangky = new { tk.id_taikhoan, tk.taikhoan1, tk.matkhau, tk.tendaydu, tk.email, tk.sodienthoai, tk.trangthaitk, tk.id_nhomadmin, tk.ngaytao, tk.loaitaikhoan, tk.avatar } }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                                    new Libs().updateKieuLogThemMoiThanhCong(idlog);
                                }
                                else
                                {
                                    msg = "Thêm mới tài khoản thất bại";
                                }
                            }
                            else
                            {
                                msg = "Tên đăng nhập hoặc email đã tồn tại";
                            }
                        }
                        else
                        {
                            msg = ErrorCheck;
                        }
                    }
                    else
                    {
                        msg = "Có lỗi trong quá trình thao tác dữ liệu";
                    }
                }
                else
                {
                    msg = "Session không tồn tại";
                }
            }
            else
            {
                msg = "Bạn không có quyền với chức năng này";
            }

            if (sucess == false)
            {
                string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
                int idlog = new Libs().LuuLogHoatDong(session.id, JsonConvert.SerializeObject(new { thongtintk = msg }, Newtonsoft.Json.Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
                new Libs().updateKieuLogThemMoiThatBai(idlog);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = msg, sucess = sucess }, Formatting.Indented));
        }
        catch (Exception)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { msg = "Lỗi trong quá trình thao tác dữ liệu", sucess = sucess }, Formatting.Indented));
        }

    }
    public void danhsachnhomquyen(HttpContext context)
    {

        if (session != null)
        {

            var danhsach = entity.NhomAdmin.Where(m => m.trangthai == true).Select(m => new
            {
                m.id_nhomadmin,
                m.tennhom
            }).ToList();

            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsach }, Formatting.Indented));
        }
    }
    public void danhsachtaikhoanadmin(HttpContext context)
    {
        if (session != null)
        {
            string danhsachquyen = new Libs().MaQuyenTrongTrang(session.id);
            Libs.chucnang cn = (Libs.chucnang)JsonConvert.DeserializeObject(danhsachquyen, typeof(Libs.chucnang));

            var danhsachadmin = entity.TaiKhoan.Where(m => m.loaitaikhoan == 2 && m.trangthaitk == true && m.id_taikhoan != session.id).OrderByDescending(m => m.ngaytao).Select(m => new
            {
                m.avatar,
                m.email,
                m.id_nhomadmin,
                tennhom = m.NhomAdmin.tennhom,
                m.id_taikhoan,
                m.loaitaikhoan,
                m.matkhau,
                m.ngaytao,
                m.sodienthoai,
                m.taikhoan1,
                m.tendaydu,
                m.trangthaitk,
                button = new
                {
                    m.id_taikhoan,
                    cn.xem,
                    cn.them,
                    cn.sua,
                    cn.xoa
                }
            }).ToList();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { data = danhsachadmin }, Formatting.Indented));
        }
    }

    public void loadmenutrangadmin(HttpContext context)
    {
        List<Libs.jsonmenu> oDanhMuc = new List<Libs.jsonmenu>();
        string href = string.Format("{0}", new Libs().getSegmentsUrl(context.Request.UrlReferrer.AbsoluteUri, 1));

        entity.tbl_Menu.Where(m => m.idParent == 0 && m.trangthai == 1).ToList().OrderBy(m => m.sothutu).All(x =>
        {
            Libs.jsonmenu m = new Libs.jsonmenu();
            m.id_menu = x.id_menu;
            m.tenmenu = x.tenmenu;
            m.vitri = x.vitri;
            m.trangthai = x.trangthai;
            m.sothutu = x.sothutu;
            m.href = x.linkmenu;
            m.icon = x.icon;
            m.active = (x.linkmenu == href ? "active" : "");
            new Libs().getmenu(m);
            oDanhMuc.Add(m);
            return true;
        });
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { danhsach = oDanhMuc }, Formatting.Indented));
    }
    public void loadthongtincanhanadmin(HttpContext context)
    {
        bool success = false;
        Libs.userDangNhap uSession = (Libs.userDangNhap)context.Session["uSession"];
        if (uSession != null)
        {

            var thongtincanhan = entity.TaiKhoan.Where(m => m.id_taikhoan == uSession.id).Select(m => new
            {
                m.avatar,
                m.email,
                m.id_nhomadmin,
                m.id_taikhoan,
                m.loaitaikhoan,
                m.matkhau,
                m.ngaytao,
                m.sodienthoai,
                m.taikhoan1,
                m.tendaydu,
                m.trangthaitk,
                tennhomadmin = m.NhomAdmin.tennhom
            }).FirstOrDefault();
            if (thongtincanhan != null)
            {
                success = true;
                context.Response.ContentType = "text/plain";
                context.Response.Write(JsonConvert.SerializeObject(new { success = success, thongtincanhan = thongtincanhan }, Formatting.Indented));
            }
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonConvert.SerializeObject(new { success = success }, Formatting.Indented));
        }
    }

    public void logoutadmin(HttpContext context)
    {

        List<kenhlamviec> klv = SocketHandler.klv;

        SocketHandler.users.Where(u => u.session == session).All(m =>
        {
            m.socket.Send(JsonConvert.SerializeObject(new { logout = true }));
            var ka1 = klv.Where(x => x.tendangnhap == session.tendangnhap && x.sessionid == session.sessionid).ToList();
            foreach (var item in ka1)
            {
                klv.Remove(item);
            }
            return true;
        });

        var ka = klv.Where(x => x.tendangnhap == session.tendangnhap && x.sessionid == session.sessionid).ToList();
        foreach (var item in ka)
        {
            klv.Remove(item);
        }
        context.Session.Remove("statuslogin");
        context.Session.Remove("uSession");

        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(new { success = true, msg = "Thoát tài khoản thành công" }, Formatting.Indented));
    }

    //public void dangnhapadmin(HttpContext context)
    //{

    //    bool success = false;
    //    string msg = "";
    //    string tendangnhap = context.Request["tendangnhap"];
    //    string matkhau = context.Request["matkhau"];

    //    string[] mangcheck = "Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini".ToUpper().Split('|');
    //    var tentrinhduyet = context.Request.Browser.Browser;
    //    var thietbi = context.Request.UserAgent.ToUpper();
    //    var thietbitruycap = "Đăng nhập thông qua " + tentrinhduyet + " trên PC";

    //    // check taif khoan dang nhap chưa neu dang nhap roi thi khong cho vao nua
    //    SocketHandler.users.Where(m => m.session.tendangnhap == tendangnhap).FirstOrDefault();
    //    bool kq = mangcheck.All(m =>
    //    {
    //        bool b = true;
    //        if (thietbi.Contains(m))
    //        {
    //            thietbitruycap = "Đăng nhập thông qua " + tentrinhduyet + " trên " + m.ToLower();
    //            b = false;
    //        }
    //        return b;
    //    });
    //    string matkhaumahoa = MD5.GeneratePasswordHash(matkhau);
    //    var taikhoandangnhap = entity.TaiKhoan.Where(x => x.taikhoan1 == tendangnhap && x.matkhau == matkhaumahoa && x.trangthaitk == true && (x.loaitaikhoan == 2 || x.loaitaikhoan == 3 || x.loaitaikhoan == 4)).Select(x => new
    //    {

    //        x.id_nhomadmin,
    //        tennhom = x.NhomAdmin.tennhom,
    //        x.email,
    //        x.id_taikhoan,
    //        x.loaitaikhoan,
    //        x.matkhau,
    //        x.ngaytao,
    //        x.taikhoan1,
    //        x.trangthaitk,
    //        x.tendaydu,
    //        x.avatar,
    //        x.sodienthoai
    //    }).FirstOrDefault();


    //    if (taikhoandangnhap != null)
    //    {
    //        msg = "Đăng nhập thành công.Hệ thống sẽ tự động chuyển trang";
    //        Libs.userDangNhap uSession = new Libs.userDangNhap();
    //        // uSession.captcha = 0;
    //        uSession.id = taikhoandangnhap.id_taikhoan;
    //        uSession.tendangnhap = taikhoandangnhap.taikhoan1;
    //        uSession.tendaydu = taikhoandangnhap.tendaydu;
    //        uSession.sessionid = context.Session.SessionID;
    //        context.Session.Add("uSession", uSession);

    //        success = true;

    //        string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
    //        int idlog = new Libs().LuuLogHoatDong(uSession.id, JsonConvert.SerializeObject(new { taikhoandangnhap.id_taikhoan, tendangnhap = taikhoandangnhap.taikhoan1, taikhoandangnhap.matkhau, taikhoandangnhap.tendaydu, taikhoandangnhap.email, taikhoandangnhap.sodienthoai, taikhoandangnhap.trangthaitk, taikhoandangnhap.id_nhomadmin, taikhoandangnhap.ngaytao, taikhoandangnhap.loaitaikhoan, taikhoandangnhap.avatar }, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
    //        new Libs().LoginThanhCong(idlog);

    //    }
    //    else
    //    {
    //        //  session.captcha = 1;

    //        var checkSave = entity.TaiKhoan.Where(mm => mm.taikhoan1 == tendangnhap).FirstOrDefault();
    //        if (checkSave != null)
    //        {
    //            msg = "Đăng nhập thất bại . Vui lòng thử lại ";
    //            string vitri = new Libs().VitriTruyCapVaIP("TaiKhoan", new Libs().ThietBiTruyCap()); // vitri
    //            int idlog = new Libs().LuuLogHoatDongLoginFail(JsonConvert.SerializeObject(new { tendangnhap = tendangnhap, matkhau = matkhau, msg = msg }, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }), vitri); // luu log lan 1
    //            new Libs().LoginThatBai(idlog);
    //        }
    //        else
    //        {
    //            msg = "Tài khoản không tồn tại";
    //        }
    //    }
    //    context.Response.ContentType = "text/plain";
    //    context.Response.Write(JsonConvert.SerializeObject(new { success = success, msg = msg }, Formatting.Indented));
    //}

    public List<chitietLog> GetAllDataLogHoatDong()
    {
        List<chitietLog> danhsach = new List<chitietLog>();
        entity.tbl_LogHeThong.ToList().All(m =>
            {
                chitietLog itemabc = JsonConvert.DeserializeObject<chitietLog>(m.noidung);
                danhsach.Add(itemabc);
                return true;
            });
        return danhsach;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
public class chitietLog
{
    public string diadiem;
    public string ip;
    public string tendangnhap;
    public string matkhau;
    public int id_taikhoan;
    public DateTime thoigiantao;
    public string type;
    public string page;
    public string thietbidangnhap;
    public chitietLog()
    {
    }
}




