<%@ WebHandler Language="C#" Class="uploadFile" %>

using System;
using System.Web;
using System.IO;
public class uploadFile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        HttpPostedFile file = context.Request.Files["upload"];
        bool success = false;
        if (file.ContentLength > 0)
        {
            string fname = Guid.NewGuid().ToString();// tên hình ảnh mới
            string fileExt = Path.GetExtension(file.FileName);// lấy đuôi file (.png hay là .jpg)
            string filePath = string.Format("/ThuMucGoc/AnhDaiDien/{0}{1}", fname, fileExt);
            if (File.Exists(context.Server.MapPath("~" + filePath)))
                File.Delete(context.Server.MapPath("~" + filePath));
            file.SaveAs(context.Server.MapPath("~" + filePath));
            success = File.Exists(context.Server.MapPath("~" + filePath));
            context.Response.ContentType = "text/html; charset=utf-8";
            context.Response.Write(string.Format(@"<script type='text/javascript'>
                                                    window.parent.CKEDITOR.tools.callFunction('0', '" + (filePath) + "', '');</script>"));
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}