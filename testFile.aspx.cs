using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.InteropServices;
using System.IO;
using Microsoft.Win32;
using System.Text.RegularExpressions;

public partial class testFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void FileUpload1_Click(object sender, EventArgs e)
    {
        //byte[] fileBytes = FileUpload1.FileBytes;
        //string mimeType = FileUpload1.PostedFile.ContentType;
        //if (FileValidation.IsValidFileType(fileBytes))
        //    Label1.Text = "This is a valid file type";
        //else
        //    Label1.Text = "This is not a valid file type";
    }

    public class FileValidation
    {
        public static bool IsValidFileType(byte[] fileByteContent)
        {
            bool isValid = false;
            string mimetypeOfFile = string.Empty;

            byte[] buffer = new byte[256];
            using (MemoryStream fs = new MemoryStream(fileByteContent))
            {
                if (fs.Length >= 256)
                    fs.Read(buffer, 0, 256);
                else
                    fs.Read(buffer, 0, (int)fs.Length);
            }
            try
            {
                System.UInt32 mimetype;
                FindMimeFromData(0, null, buffer, 256, null, 0, out mimetype, 0);
                System.IntPtr mimeTypePtr = new IntPtr(mimetype);
                mimetypeOfFile = Marshal.PtrToStringUni(mimeTypePtr);
                Marshal.FreeCoTaskMem(mimeTypePtr);

            }
            catch (Exception e)
            {

            }

            if (!string.IsNullOrEmpty(mimetypeOfFile))
            {
                switch (mimetypeOfFile.ToLower())
                {
                    case "application/msword": // for .doc  estension
                        isValid = true;
                        break;
                    case "application/vnd.openxmlformats-officedocument.wordprocessingml.document": // for .docx  estension
                        isValid = true;
                        break;
                    case "application/vnd.ms-excel": // for .xls  estension
                        isValid = true;
                        break;
                    case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": // for  .xlsx estension
                        isValid = true;
                        break;
                    case "application/vnd.ms-powerpoint":// for .ppt estension
                        isValid = true;
                        break;
                    case "application/vnd.openxmlformats-officedocument.presentationml.presentation":// for .pptx estension
                        isValid = true;
                        break;
                    case "image/jpeg"://jpeg and jpg both
                        isValid = true;
                        break;
                    case "image/pjpeg"://jpeg and jpg both
                        isValid = true;
                        break;
                    case "image/png":// for .png estension
                        isValid = true;
                        break;
                    case "image/x-png":// for .png estension
                        isValid = true;
                        break;
                    case "image/gif":// for .gif estension
                        isValid = true;
                        break;
                }
            }

            return isValid;

        }


        [DllImport(@"urlmon.dll", CharSet = CharSet.Auto)]
        private extern static System.UInt32 FindMimeFromData(
            System.UInt32 pBC,
            [MarshalAs(UnmanagedType.LPStr)] System.String pwzUrl,
            [MarshalAs(UnmanagedType.LPArray)] byte[] pBuffer,
            System.UInt32 cbSize,
            [MarshalAs(UnmanagedType.LPStr)] System.String pwzMimeProposed,
            System.UInt32 dwMimeFlags,
            out System.UInt32 ppwzMimeOut,
            System.UInt32 dwReserverd
        );

        public static string getMimeFromFile(byte[] byteArray)
        {

            byte[] buffer = new byte[256];
            using (MemoryStream fs = new MemoryStream(byteArray))
            {
                if (fs.Length >= 256)
                    fs.Read(buffer, 0, 256);
                else
                    fs.Read(buffer, 0, (int)fs.Length);
            }
            try
            {
                UInt32 mimetype = default(UInt32);
                FindMimeFromData(0, null, buffer, 256, null, 0, out mimetype, 0);
                IntPtr mimeTypePtr = new IntPtr(mimetype);
                //string mime = Marshal.PtrToStringUni(mimeTypePtr);// loi
                string mime = Marshal.PtrToStringUni(mimeTypePtr);
                Marshal.FreeCoTaskMem(mimeTypePtr);
                return mime;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //byte[] fileBytes = FileUpload1.FileBytes;
        //string mimeType = FileUpload1.PostedFile.ContentType;

        //string type = FileValidation.getMimeFromFile(fileBytes);
        //Label1.Text = type;
        //if (FileValidation.IsValidFileType(fileBytes))
        //    Label1.Text = "dung";
        //else
        //    Label1.Text = "sai";

        //string dd = Server.MapPath("~ThuMucGoc/NguoiDung/1111111111.doc");
        //FileInfo ff = new FileInfo(dd);
        //string type = GetMimeType(ff);

        string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/ThuMucGoc/TMT/") + fileName);
        string name = Server.MapPath("~/ThuMucGoc/TMT/") + fileName;

        FileInfo ff = new FileInfo(name);
        bool a = MimeDetective.Extension.Documents.DocumentExtensions.IsMedia(ff);
        if (a == true)
        {
            Label1.Text = "ok";
        }
        else
        {
            Label1.Text = "none";
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {

        string headerPDF = "25-50-44-46";
        bool check = false;

        string fileName = Path.GetFileName(FileUpload2.PostedFile.FileName);
        FileUpload2.PostedFile.SaveAs(Server.MapPath("~/ThuMucGoc/TMT/") + fileName);
        string name = Server.MapPath("~/ThuMucGoc/TMT/") + fileName;
        FileInfo file = new FileInfo(name);


        // c1
        //byte[] fileBytes = new byte[file.Length];

        //using (FileStream fss = file.OpenRead())
        //{
        //    int b = 0;
        //    for (int i = 0; i < file.Length; i++)
        //    {
        //        fileBytes[i] = (byte)((b = fss.ReadByte()) == -1 ? 0 : b);
        //        if (b == -1)
        //            break;
        //    }
        //}

        //byte[] buffer = new byte[4];
        //using (MemoryStream fs = new MemoryStream(fileBytes))
        //{
        //    fs.Read(buffer, 0, 4);
        //}
        //string hex = BitConverter.ToString(buffer);

        //if (hex == headerPDF)
        //{
        //    Label4.Text = "ok";
        //}
        //else
        //{
        //    Label4.Text = "none";
        //}


        bool a = MimeDetective.Extension.Documents.DocumentExtensions.IsFile(file);
        if (a == true)
        {
            Label4.Text = "ok";
        }
        else
        {
            Label4.Text = "none";
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {

        string fileName = Path.GetFileName(FileUpload3.PostedFile.FileName);
        FileUpload3.PostedFile.SaveAs(Server.MapPath("~/ThuMucGoc/TMT/") + fileName);
        string name = Server.MapPath("~/ThuMucGoc/TMT/") + fileName;

        FileInfo ff = new FileInfo(name);
        bool a = MimeDetective.Extension.Documents.DocumentExtensions.IsImages(ff);
        if (a == true)
        {
            Label6.Text = "ok";
        }
        else
        {
            Label6.Text = "none";
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {

        string a = "ashdkahskdas asd asd asd asd a sd scRipT asdkasd á da scripT sda sd á da sd ád";
        string b = "<<script><script>scrip</script><script><script>t</script></script></script>script><%abc(); %><</scrip>/</script>script>";
        string c = "<img src='' width='20px' height='20px' onerror=\"alert('aloo')\"></img>";
        string m = "<%abc(); %>";
        

        string v = removeScriptAndCharacter.formatTextInput(a);
        string g = removeScriptAndCharacter.replateScript(b);
        string g1 = removeScriptAndCharacter.replateScript(m);
        //c = Regex.Replace(
        //                      c,
        //                      @"(<[\s\S]*?) on.*?\=(['""])[\s\S]*?\2([\s\S]*?>)",
        //                      delegate(Match match)
        //                      {
        //                          return String.Concat(match.Groups[1].Value, match.Groups[3].Value);
        //                      }, RegexOptions.Compiled | RegexOptions.IgnoreCase);
        string r = removeScriptAndCharacter.replateScript(c);

        string result = System.Text.RegularExpressions.Regex.Replace(a, "script", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);

        //Label8.Text = r;
        Label9.Text = g;
        //Literal1.Text = g;
        df.InnerHtml ="<%" + HttpUtility.HtmlDecode("Page.ClientScript.RegisterStartupScript(this.GetType(), \"\", \"alert('aaaa')\", true);")+ "%>";
       /// Page.ClientScript.RegisterStartupScript(this.GetType(), "", "alert('aaaa')", true);
    }

    public void abc()
    {
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "alert('aaaa')", true);
    }
}