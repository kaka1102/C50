using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_GuiCauHoiMoi : System.Web.UI.UserControl
{
    DataC50Entities timkiem = new DataC50Entities();
    bool loadPage = false;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gui_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    bool checkFileUpload = true;
        //    int gioihandata = 1048576 * 10;
        //    string tenfile;
        //    string duongdan;
        //    string fileanhluu = "";

        //    string session = Page.Session["captcha"].ToString();
        //    int idtaikhoan = 0;
        //    int id_chuyenmuc = Convert.ToInt32(DropDownList2.SelectedItem.Value);

        //    string filedinhkem = file.PostedFile.FileName;


        //    string cauhoi = noidung.Text;
        //    string email1 = email.Text;
        //    string tendaydu = hoten.Value;
        //    string tieudecauhoi = tieude.Value;
        //    string chon = loichon.Text;
        //    string textcaptcha = txtCapchaQues.Value;

        //    TaiKhoan taikhoan = new TaiKhoan();

        //    string ErrCheck = new validateform().CallValidateGuiCauHoiMoi(tendaydu, email1, tieudecauhoi, cauhoi, textcaptcha, session);
        //    if (ErrCheck == null)
        //    {
        //        if (filedinhkem != "")
        //        {
        //            string mimeType = MimeMapping.GetMimeMapping(file.FileName);
        //            string typeFile = Path.GetExtension(file.FileName);
        //            int type = (mimeType.IndexOf("image/"));
        //            long filesize = file.FileContent.Length;

        //            if (filesize > gioihandata)
        //            {
        //                checkFileUpload = false;
        //                loaddingpage.Attributes.CssStyle.Add("display", "none");
        //                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Dung lượng file vượt quá quy định', 'error')", true);
        //            }
        //            else
        //            {
        //              var ck =  new validateform().IsDocFile(file.FileName);

        //                if ((typeFile == ".doc" || typeFile == ".docx" || typeFile == ".zip" || typeFile == ".xls" || typeFile == ".pdf" || typeFile == ".txt" || typeFile == ".xlsx" || type == 0))
        //                {
        //                    tenfile = MD5.RandomString(16);
        //                    fileanhluu = "/ThuMucGoc/NguoiDung/" + tenfile + typeFile;
        //                    duongdan = Page.Server.MapPath("~" + fileanhluu);
        //                    file.SaveAs(duongdan);
        //                }
        //                else
        //                {
        //                    checkFileUpload = false;
        //                    loaddingpage.Attributes.CssStyle.Add("display", "none");
        //                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','File đính kèm không hợp lệ (doc,docx,zip,xls,pdf,txt,jpg,jpeg,gif,png)', 'error')", true);
        //                }
        //            }
        //        }
        //        //////
        //        if (checkFileUpload == true)
        //        {
        //            var checkchuyenmuc = timkiem.tbl_ChuyenMucLuaChon.Where(x => x.id_chuyenmuc == id_chuyenmuc && x.trangthai == true && x.id_danhmuc == 12).FirstOrDefault();
        //            if (checkchuyenmuc != null)
        //            {
        //                var checktench = timkiem.tbl_CauhoiTraLoi.Where(m => m.cauhoi == cauhoi && m.trangthai != 0).FirstOrDefault();
        //                if (checktench != null)
        //                {
        //                    cauhoi = cauhoi + "-" + MD5.RandomString(10);
        //                }

        //                var kiemtra = timkiem.TaiKhoan.Where(m => m.email == email1).FirstOrDefault();

        //                if (kiemtra == null)
        //                {
        //                    taikhoan.tendaydu = removeScriptAndCharacter.formatTextInput(tendaydu);
        //                    taikhoan.email = removeScriptAndCharacter.formatTextInput(email1);
        //                    taikhoan.trangthaitk = true;
        //                    taikhoan.ngaytao = DateTime.Now;
        //                    taikhoan.loaitaikhoan = 1;
        //                    taikhoan.avatar = "/ThuMucGoc/AnhDaiDien/iconClientDefault.jpg";

        //                    timkiem.TaiKhoan.Add(taikhoan);
        //                    timkiem.SaveChanges();

        //                    idtaikhoan = taikhoan.id_taikhoan;
        //                }
        //                else
        //                {
        //                    idtaikhoan = kiemtra.id_taikhoan;
        //                };



        //                tbl_CauhoiTraLoi cauhoitraloi = new tbl_CauhoiTraLoi();
        //                cauhoitraloi.tieudecauhoi = removeScriptAndCharacter.formatTextInput(tieudecauhoi);
        //                cauhoitraloi.cauhoi = removeScriptAndCharacter.formatTextInput(cauhoi);
        //                cauhoitraloi.ngayhoi = DateTime.Now;
        //                cauhoitraloi.trangthai = 1;
        //                cauhoitraloi.id_chuyenmuc = id_chuyenmuc;
        //                cauhoitraloi.loaicauhoi = "nguoidung";
        //                cauhoitraloi.id_nguoihoi = idtaikhoan;
        //                cauhoitraloi.luotxem = 0;
        //                if (filedinhkem != "")
        //                {
        //                    cauhoitraloi.fileQuestion = fileanhluu;
        //                }
        //                cauhoitraloi.statusRepQuestion = false;

        //                timkiem.tbl_CauhoiTraLoi.Add(cauhoitraloi);
        //                timkiem.SaveChanges();

        //                var ttnguoigui = timkiem.TaiKhoan.Where(mm => mm.id_taikhoan == idtaikhoan).FirstOrDefault();

        //                if (ttnguoigui != null)
        //                {
        //                    string mailto = ttnguoigui.email;
        //                    string subject = string.Format("Xin chào  : {0}. Đây là thông báo của ban quản trị C50", ttnguoigui.tendaydu);
        //                    string body = string.Format("Xin chào {0} !<br /> Bạn đã gửi câu hỏi tới ban quản trị C50 thành công.<br />Chúng tôi sẽ xem xét nội dung và trả lời bạn theo email này trong thời gian sớm nhất.</br>  Mọi thắc mắc vui lòng liên hệ với chúng tôi để được giải đáp .<br />Trân trọng cảm ơn ! <br />Ban Quản Trị C50 .", ttnguoigui.tendaydu);
        //                    bool guimail = new Libs().sendEmail(mailto, subject, body);
        //                    loaddingpage.Attributes.CssStyle.Add("display", "none");
        //                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Chúng tôi sẽ gửi câu trả lời qua email cho bạn sớm nhất .', 'success')", true);
        //                }
        //                else
        //                {
        //                    loaddingpage.Attributes.CssStyle.Add("display", "none");
        //                    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Gửi email không thành công.', 'success')", true);
        //                }
        //                noidung.Text = "";
        //                email.Text = "";
        //                hoten.Value = "";
        //                tieude.Value = "";
        //                txtCapchaQues.Value = "";

        //            }
        //            else
        //            {
        //                loaddingpage.Attributes.CssStyle.Add("display", "none");
        //                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','Chuyên mục bạn chọn không tồn tại', 'error')", true);

        //            }
        //        }
        //        //////
        //    }
        //    else
        //    {
        //        loaddingpage.Attributes.CssStyle.Add("display", "none");
        //        Page.ClientScript.RegisterStartupScript(this.GetType(), "", "swal('Thông báo ','" + ErrCheck + "', 'error')", true);
        //    }
        //}
        //catch (Exception)
        //{
        //    Response.Redirect("/hoi-dap");
        //}
    }
}