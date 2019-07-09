<%@ WebHandler Language="C#" Class="captchalogin" %>

using System;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Text;
using System.Drawing.Imaging;
using System.Web.SessionState;

public class captchalogin : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        string[] fonts = { "Arial Black", "Lucida Sans Unicode", "Comic Sans MS" };
        const byte LENGTH = 4;
        const string chars = "EBAY123456789";

        using (Bitmap bmp = new Bitmap(78, 22))
        {

            using (Graphics g = Graphics.FromImage(bmp))
            {

                // Tạo nền cho ảnh dạng sóng
                HatchBrush brush = new HatchBrush(HatchStyle.Wave, Color.Beige, Color.White);
                g.FillRegion(brush, g.Clip);

                // Lưu chuỗi captcha trong quá trình tạo
                StringBuilder strCaptcha = new StringBuilder();
                Random rand = new Random();

                for (int i = 0; i < LENGTH; i++)
                {
                    // Lấy kí tự ngẫu nhiên từ mảng chars
                    string str = chars[rand.Next(chars.Length)].ToString();
                    strCaptcha.Append(str);

                    // Tạo font với tên font ngẫu nhiên chọn từ mảng fonts
                    Font font = new Font(fonts[rand.Next(fonts.Length)], 12, FontStyle.Regular);

                    // Lấy kích thước của kí tự
                    SizeF size = g.MeasureString(str, font);

                    // Vẽ kí tự đó ra ảnh tại vị trí tăng dần theo i, vị trí top ngẫu nhiên
                    g.DrawString(str, font,
                    Brushes.DimGray, i * size.Width + 9, rand.Next(0, 2));
                    font.Dispose();
                }

                // Lưu captcha vào session
                context.Session.Add("captchalogin", strCaptcha.ToString());

                // Ghi ảnh trực tiếp ra luồng xuất theo định dạng gif
                context.Response.ContentType = "image/GIF";
                bmp.Save(context.Response.OutputStream, ImageFormat.Gif);
            }
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