<%@ WebHandler Language="C#" Class="Socket" %>

using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Web.WebSockets;

public class Socket : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        if (context.IsWebSocketRequest)
        {
            var session = (Libs.userDangNhap)context.Session["uSession"];
            context.AcceptWebSocketRequest(new SocketHandler(session));
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}