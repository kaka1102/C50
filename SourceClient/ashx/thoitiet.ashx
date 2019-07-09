<%@ WebHandler Language="C#" Class="thoitiet" %>

using System;
using System.Web;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using System.Linq;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web.SessionState;
using System.Reflection;

public class thoitiet : IHttpHandler
{
    DataC50Entities entity = new DataC50Entities();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            tbl_TinhThanh tinhthanh = new tbl_TinhThanh();
            tbl_Thongtinthoitiet thongtinthoitiet = new tbl_Thongtinthoitiet();

            context.Response.ContentType = "application/json";
            context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
            var codeid = context.Request["code"];
            string tenTinh = "";
            if (!string.IsNullOrEmpty(codeid))
            {
                string dateN = DateTime.Now.ToString("dd/MM/yyyy");

                //  var checkTinhThanh = entity.tbl_TinhThanh.Where(m => m.codeID == codeid && m.ngayluu == dateN).FirstOrDefault();  code dung
                var checkTinhThanh = entity.tbl_TinhThanh.Where(m => m.codeID == codeid).FirstOrDefault();  //dung tam
                if (checkTinhThanh == null)
                {
                    //xoa
                    var xoaThongtincu = entity.tbl_Thongtinthoitiet.Where(x => x.CodeId == codeid).ToList();
                    if (xoaThongtincu != null)
                    {
                        foreach (var item in xoaThongtincu)
                        {
                            entity.tbl_Thongtinthoitiet.Remove(item);
                            entity.SaveChanges();
                        }
                    }
                    var xoabangTinh = entity.tbl_TinhThanh.Where(x => x.codeID == codeid).ToList();
                    if (xoabangTinh != null)
                    {
                        foreach (var item in xoabangTinh)
                        {
                            entity.tbl_TinhThanh.Remove(item);
                            entity.SaveChanges();
                        }
                    }

                    // get data
                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://vtvapi1.cnnd.vn/handlers/weather.ashx?type=date&top=5&codeId=" + codeid + "&date=0");
                    request.Method = "POST";
                    request.Headers.Add("Origin", "http://vtv.vn");
                    request.Referer = "http://vtv.vn/du-bao-thoi-tiet.htm";
                    request.Accept = "application/json, text/javascript, */*; q=0.01";

                    string rt = "";
                    using (request.GetRequestStream())
                    using (var HTTP = request.GetResponse())
                    {
                        using (var streamReader = new StreamReader(HTTP.GetResponseStream()))
                        {
                            rt = streamReader.ReadToEnd();

                        }
                    }

                    // luu lai


                    List<Contructor.thoitiet> thoitiet = (List<Contructor.thoitiet>)JsonConvert.DeserializeObject(rt, typeof(List<Contructor.thoitiet>));
                    foreach (var item in thoitiet)
                    {
                        tenTinh = item.LocationName;
                        thongtinthoitiet.ClassName = item.ClassName;
                        thongtinthoitiet.CodeId = item.CodeId;
                        thongtinthoitiet.Date = item.Date;
                        thongtinthoitiet.DayNumber = item.DayNumber;
                        thongtinthoitiet.DayText = item.DayText;
                        thongtinthoitiet.FullDate = item.FullDate;
                        thongtinthoitiet.High = item.High;
                        thongtinthoitiet.Humidity = item.Humidity;
                        thongtinthoitiet.Id = item.Id;
                        thongtinthoitiet.LocationName = item.LocationName;
                        thongtinthoitiet.Low = item.Low;
                        thongtinthoitiet.Status = item.Status;
                        thongtinthoitiet.Sunrise = item.Sunrise;
                        thongtinthoitiet.Sunset = item.Sunset;
                        thongtinthoitiet.Temperature = item.Temperature;
                        thongtinthoitiet.Time = item.Time;
                        thongtinthoitiet.WeatherDate = item.WeatherDate;
                        thongtinthoitiet.Wind = item.Wind;

                        entity.tbl_Thongtinthoitiet.Add(thongtinthoitiet);
                        entity.SaveChanges();
                    }

                    tinhthanh.TenTinh = tenTinh;
                    tinhthanh.codeID = codeid;
                    tinhthanh.ngayluu = dateN;
                    entity.tbl_TinhThanh.Add(tinhthanh);
                    entity.SaveChanges();

                    context.Response.Write(rt);
                }
                else
                {
                    var getAllThoitiet = entity.tbl_Thongtinthoitiet.Where(m => m.CodeId == checkTinhThanh.codeID).ToList();
                    //   context.Response.Write(getAllThoitiet);
                    context.Response.Write(JsonConvert.SerializeObject(getAllThoitiet, Formatting.Indented));
                }
            }
        }
        catch (Exception)
        {
            string codeid = "2347727";
            var getAllThoitiet = entity.tbl_Thongtinthoitiet.Where(m => m.CodeId == codeid).ToList();
            context.Response.Write(JsonConvert.SerializeObject(getAllThoitiet, Formatting.Indented));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}