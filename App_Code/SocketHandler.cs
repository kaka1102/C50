using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using Microsoft.Web.WebSockets;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web.UI;

public class SocketHandler : WebSocketHandler
{

    string ComputerName = System.Environment.MachineName;
    string ip = HttpContext.Current.Request.UserHostAddress;
    string Agent = HttpContext.Current.Request.UserAgent;    //Request.UserAgent;

    public static List<kenhlamviec> klv = new List<kenhlamviec>();

    public static List<Blocklist> blocklist = new List<Blocklist>();
    public static List<useronline> users = new List<useronline>();
    public static SocketHandler currentSK;
    public Libs.userDangNhap session { get; set; }
    public useronline user { get; set; }
    public kenhlamviec kenh { get; set; }
    public SocketHandler(Libs.userDangNhap ss)
    {
        this.session = ss;
        currentSK = this;
    }

    public override void OnOpen()
    {
        if (session != null)
        {

            users.Where(m => m.session.tendangnhap == session.tendangnhap && m.session.sessionid != session.sessionid).All(m =>
            {
                m.socket.Send(JsonConvert.SerializeObject(new { newlogin = true }));
                return true;
            });

            useronline u = new useronline();
            u.session = session;
            u.socket = this;
            user = u;
            users.Add(u);

            var check = klv.Where(m => m.sessionid == session.sessionid || m.tendangnhap == session.tendangnhap).FirstOrDefault();
            if (check == null)
            {
                kenhlamviec k = new kenhlamviec();
                k.id = session.id;
                k.sessionid = session.sessionid;
                k.tendangnhap = session.tendangnhap;
                k.tendaydu = session.tendaydu;
                k.ip = ip;
                k.Agent = Agent;
                k.Tooken = session.Tooken;
                k.ComputerName = ComputerName;
                kenh = k;
                klv.Add(k);
            }
        }
    }

    public override void OnMessage(string message)
    {

    }

    public override void OnClose()
    {
        //Xóa client
        users.Remove(user);
        klv.Remove(kenh);
    }
    public static void send(string msg)
    {
        if (currentSK != null)
        {
            currentSK.Send(msg);
        }

    }
    public static void closeSocket()
    {

        //   string idSession = 
        //var check = klv.Where(m => m.sessionid == idSession).ToList().All(m =>
        //{
        //    klv.Remove(m);
        //    return true;
        //});
    }
}


public class useronline
{
    public Libs.userDangNhap session { get; set; }

    public SocketHandler socket { get; set; }
}
public class Blocklist
{
    public string url { get; set; }
    public string sessionid { get; set; }
    public int numberrequest { get; set; }
}
public class kenhlamviec
{
    public SocketHandler socketKLV { get; set; }
    public int id { get; set; }
    public string tendaydu { get; set; }
    public string tendangnhap { get; set; }
    public string sessionid { get; set; }

    public string Tooken { get; set; }
    public string ip { get; set; }
    public string Agent { get; set; }
    public string ComputerName { get; set; }
    public string maxacminh { get; set; }
    [System.ComponentModel.DefaultValue(false)]
    public bool trangthaixacminh { get; set; }

    [System.ComponentModel.DefaultValue(0)]
    public int solannhapma { get; set; }
}