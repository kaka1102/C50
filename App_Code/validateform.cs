using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Runtime.InteropServices;
public class validateform
{
    DataC50Entities entity = new DataC50Entities();
    public bool IsPdfFile(HttpPostedFile filePath)
    {
        bool isPdfFile = false;
        string pdfHeader = "%PDF";
        string pdfFooter = "%%EOF";

        BinaryReader b = new BinaryReader(filePath.InputStream);
        byte[] fileInfo = b.ReadBytes(filePath.ContentLength);

        byte[] headerBuffer = new byte[4];
        byte[] footerBuffer = new byte[5];

        Array.Copy(fileInfo, 0, headerBuffer, 0, 4);
        Array.Copy(fileInfo, fileInfo.Length - 6, footerBuffer, 0, 5);
        string ckHeader = Encoding.ASCII.GetString(headerBuffer);
        string ckFooter = Encoding.ASCII.GetString(footerBuffer);

        if (ckHeader == pdfHeader && ckFooter == pdfFooter)
        {
            isPdfFile = true;
        }

        return isPdfFile;
    }
    public bool IsDocFile(HttpPostedFile filePath)
    {
        bool isDocFile = false;
        string msOfficeHeader = "PK";
        string docSubHeader = "EC-A5-C1-00";
        // D0 CF 11 E0 A1 B1 1A E1
        BinaryReader b = new BinaryReader(filePath.InputStream);
        byte[] fileInfo = b.ReadBytes(filePath.ContentLength);

        byte[] headerBuffer = new byte[2];
        byte[] footerBuffer = new byte[5];

        Array.Copy(fileInfo, 0, headerBuffer, 0, 2);
        Array.Copy(fileInfo, fileInfo.Length - 6, footerBuffer, 0, 5);
        string ckHeader = Encoding.ASCII.GetString(headerBuffer);
        string ckFooter = Encoding.ASCII.GetString(footerBuffer);
        //&& ckFooter == docSubHeader
        if (ckHeader == msOfficeHeader)
        {
            isDocFile = true;
        }
        return isDocFile;



    }
    public bool IsMP4(HttpPostedFile filePath)
    {
        bool IsMP4 = false;
        byte[] DOC = { 208, 207, 17, 224, 161, 177, 26, 225 };

        BinaryReader b = new BinaryReader(filePath.InputStream);
        byte[] fileInfo = b.ReadBytes(filePath.ContentLength);

        // string type = FileValidation.getMimeFromFile(fileInfo);

        byte[] buffer = new byte[256];
        using (MemoryStream fs = new MemoryStream(fileInfo))
        {
            if (fs.Length >= 256)
                fs.Read(buffer, 0, 256);
            else
                fs.Read(buffer, 0, (int)fs.Length);
        }

        byte[] headerBuffer = new byte[8];
        Array.Copy(fileInfo, 0, headerBuffer, 0, 8);


        //byte[] footerBuffer = new byte[5];

        //Array.Copy(fileInfo, 0, headerBuffer, 0, 2);
        //Array.Copy(fileInfo, fileInfo.Length - 6, footerBuffer, 0, 5);

        string hex = BitConverter.ToString(headerBuffer).Replace("-", string.Empty);

        string ckKey = Encoding.ASCII.GetString(DOC);
        string ckHeader = Encoding.ASCII.GetString(headerBuffer);

        if(DOC == headerBuffer){
            IsMP4 = true;
        }

        if (ckHeader == ckKey)
        {
            IsMP4 = true;
        }
        return IsMP4;
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

            string mime = "";
            return mime;
            //try
            //{
            //    UInt32 mimetype = default(UInt32);
            //    FindMimeFromData(0, null, buffer, 256, null, 0, out mimetype, 0);
            //    IntPtr mimeTypePtr = new IntPtr(mimetype);
            //    //string mime = Marshal.PtrToStringUni(mimeTypePtr);// loi
            //    //string mime = Marshal.PtrToStringUni(mimeTypePtr);
            //    //Marshal.FreeCoTaskMem(mimeTypePtr);
            //    return mime;
            //}
            //catch (Exception e)
            //{
            //    return e.Message;
            //}
        }
    }



    public string CheckHoTen(string name)
    {
        bool strName = Regex.IsMatch(name, "^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
            "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
            "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]{0,50}$");
        if (!strName)
        {
            return "Họ tên không chứa các ký tự đặc biệt và nhỏ hơn 50 ký tự";
        }

        return null;
    }
    public string CheckHoTenRequited(string name)
    {
        bool strName = Regex.IsMatch(name, "^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
            "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
            "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]{5,50}$");
        if (!strName)
        {
            return "Họ tên không chứa các ký tự đặc biệt và từ 5 - 50 ký tự";
        }

        return null;
    }
    public string CheckDiaChi(string diachi)
    {
        bool strDiachi = Regex.IsMatch(diachi, "^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
          "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
          "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,-]{0,100}$");
        if (!strDiachi)
        {
            return "Địa chỉ không chứa ký tự đặc biệt và nhỏ hơn 100 ký tự";
        }
        return null;
    }
    public string CheckDiaChiRequited(string diachi)
    {
        bool strDiachi = Regex.IsMatch(diachi, "^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
        "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
        "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,-]{1,100}$");
        if (!strDiachi)
        {
            return "Địa chỉ không chứa ký tự đặc biệt và từ 1 - 100 ký tự";
        }
        return null;
    }
    public string CheckDiaBan(string diaban)
    {
        bool strDiaban = Regex.IsMatch(diaban, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                                 "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                                 "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s,.-]{0,100}$");
        if (!strDiaban)
        {
            return "Địa bàn không chứa ký tự đặc biệt và nhỏ hơn 100 ký tự";
        }
        return null;
    }
    public string CheckDiaBanRequited(string diaban)
    {
        bool strDiaban = Regex.IsMatch(diaban, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                                 "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                                 "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s,.-]{1,100}$");
        if (!strDiaban)
        {
            return "Địa bàn không chứa ký tự đặc biệt và từ 1 - 100 ký tự";
        }
        return null;
    }
    public string CheckTieuDeRequited(string tieude)
    {
        bool strTieude = Regex.IsMatch(tieude, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                              "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                              "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s,.-]{1,100}$");
        if (!strTieude)
        {
            return "Tiêu đề không chứa ký tự đặc biệt và từ 1 - 100 ký tự";
        }
        return null;
    }
    public string CheckTaikhoanRequited(string taikhoan)
    {
        bool strTK = Regex.IsMatch(taikhoan, @"^[a-zA-Z0-9\s]{6,30}$");
        if (!strTK)
        {
            return "Tài khoản không chứa ký tự đặc biệt và từ 6 - 30 ký tự";
        }
        return null;
    }

    public string CheckMKadminRequited(string matkhau)
    {

        bool strMatkhau = Regex.IsMatch(matkhau, "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=\\S+$).{10,16}$");
        if (!strMatkhau)
        {
            return "Mật khẩu từ 10 - 16 ký tự và bắt buộc phải có chữ thường, in hoa, và 1 trong số các ký tự !@#$%^&* ";
        }
        return null;
    }
    public string CheckEmailRequited(string emailString)
    {
        bool isEmail = Regex.IsMatch(emailString, @"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
        if (!isEmail)
        {
            return "Bạn chưa nhập email hoặc email bạn nhập không chính xác";
        }
        return null;
    }
    public string CheckEmail(string emailString)
    {
        if (emailString == "")
        {
            return null;
        }
        else
        {

            bool isEmail = Regex.IsMatch(emailString, "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
            if (!isEmail)
            {
                return "Bạn chưa nhập email hoặc email bạn nhập không chính xác";
            }
        }

        return null;
    }
    public string CheckPhoneReqiuted(string phoneString)
    {
        bool isPhone = Regex.IsMatch(phoneString, @"^(01[0123456789]|09)[0-9]{8}$");
        if (!isPhone)
        {
            return "Bạn chưa nhập số điện thoại hoặc nhập không đúng định dạng";
        }
        return null;
    }
    public string CheckPhone(string phoneString)
    {
        if (phoneString == "")
        {
            return null;
        }
        else
        {
            bool isPhone = Regex.IsMatch(phoneString, @"^(01[0123456789]|09)[0-9]{8}$");
            if (!isPhone)
            {
                return "Bạn chưa nhập số điện thoại hoặc nhập không đúng định dạng";
            }
        }
        return null;
    }
    public string CheckCMTRequited(string name)
    {
        bool strName = Regex.IsMatch(name, "^[0-9]{9,12}$");
        if (!strName)
        {
            return "Chứng minh thư là dạng số và từ 9-12 ký tự";
        }

        return null;
    }
    public string CheckNoiDungRequited(string noidungString)
    {
        bool isNoidung = Regex.IsMatch(noidungString, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                             "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                             "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,?!:;&@()-=+]{1,2000}$");
        if (!isNoidung)
        {
            return "Nội dung không chứa ký tự đặc biệt và từ 1-2000 ký tự";
        }
        return null;
    }
    public string CheckTenNhom(string tennhom)
    {
        bool strDiachi = Regex.IsMatch(tennhom, "^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
          "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
          "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,-]{0,100}$");
        if (!strDiachi)
        {
            return "Tên nhóm không chứa ký tự đặc biệt và nhỏ hơn 100 ký tự";
        }
        return null;
    }

    // check khong de trong
    public string CheckTieuDeCauHoi(string tieudech)
    {
        if (tieudech.Trim().Length == 0 || tieudech.Length > 100)
        {
            return "Tiêu đề không được để trống và từ 1 - 100 ký tự";
        }
        return null;
    }
    public string CheckNoiDungCauHoi(string noidungch)
    {
        if (noidungch.Trim().Length == 0)
        {
            return "Mời bạn nhập nội dung câu hỏi";
        }
        return null;
    }
    public string CheckNoiDungCauTraLoi(string noidungtl)
    {
        if (noidungtl.Trim().Length == 0)
        {
            return "Mời bạn nhập nội dung câu trả lời";
        }
        return null;
    }
    public string CheckTieuDeBV(string tieudebv)
    {
        if (tieudebv.Trim().Length == 0 || tieudebv.Length > 500)
        {
            return "Tiêu đề không được để trống và từ 1 - 500 ký tự";
        }
        return null;
    }
    public string CheckGioiThieuBV(string gioithieubv)
    {
        if (gioithieubv.Trim().Length == 0 || gioithieubv.Length > 500)
        {
            return "Phần giới thiệu không được để trống và từ 1 - 500 ký tự";
        }
        return null;
    }
    public string CheckAnhDaiDienBV(string anhdaidienbv)
    {
        if (anhdaidienbv.Trim().Length == 0)
        {
            return "Mời bạn chọn ảnh đại diện cho bài viết";
        }
        return null;
    }
    public string CheckTag(string tag)
    {
        if (tag.Trim().Length == 0)
        {
            return "Mời bạn nhập từ khóa cho bài viết";
        }
        return null;
    }
    public string CheckNoiDungBV(string noidungbv)
    {
        if (noidungbv.Trim().Length == 0)
        {
            return "Mời bạn nhập nội dung cho bài viết";
        }
        return null;
    }
    public string CheckTacGiaBV(string tacgiabv)
    {
        if (tacgiabv.Trim().Length == 0 || tacgiabv.Length > 150)
        {
            return "Tác giả bài viết không được để trống và từ 1 - 150 ký tự";
        }
        return null;
    }
    public string CheckTenDonVi(string tendv)
    {
        if (tendv.Trim().Length == 0)
        {
            return "Mời bạn nhập tên đơn vị";
        }
        return null;
    }

    public string CheckTinhHuong(string tinhhuong)
    {
        if (tinhhuong.Trim().Length == 0)
        {
            return "Mời bạn nhập tình huống";
        }
        return null;
    }
    public string CheckCachXuLy(string cachxuly)
    {
        if (cachxuly.Trim().Length == 0)
        {
            return "Mời bạn nhập cách xử lý";
        }
        return null;
    }

    public string CheckTenDoiTac(string tendt)
    {
        if (tendt.Trim().Length == 0)
        {
            return "Mời bạn nhập tên đối tác";
        }
        return null;
    }
    public string CheckURL(string url)
    {
        bool isURL = Regex.IsMatch(url, @"^http(s)?://([\w-]+.)+[\w-]+(/[\w- ./?%&=])?$");
        if (!isURL)
        {
            return "Mời bạn nhập link website liên kết";
        }
        return null;
    }
    public string CheckThongTindoiTac(string noidungString)
    {
        bool isNoidung = Regex.IsMatch(noidungString, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                             "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                             "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,?!:;&@()-=+]{1,2000}$");
        if (!isNoidung)
        {
            return "Nội dung không chứa ký tự đặc biệt và từ 1-2000 ký tự";
        }
        return null;
    }
    public string CheckHoKhau(string noidungString)
    {
        bool isNoidung = Regex.IsMatch(noidungString, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                             "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                             "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,?!:;&@()-=+]{1,200}$");
        if (!isNoidung)
        {
            return "Hộ khẩu không chứa ký tự đặc biệt và từ 1-200 ký tự";
        }
        return null;
    }

    public string CheckQueQuan(string noidungString)
    {
        bool isNoidung = Regex.IsMatch(noidungString, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                             "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                             "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,?!:;&@()-=+]{1,100}$");
        if (!isNoidung)
        {
            return "Quê quán không chứa ký tự đặc biệt và từ 1-100 ký tự";
        }
        return null;
    }
    public string CheckHinhThucPhamToi(string noidungString)
    {
        bool isNoidung = Regex.IsMatch(noidungString, @"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶ" +
                                             "ẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợ" +
                                             "ụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.,?!:;&@()-=+]{1,100}$");
        if (!isNoidung)
        {
            return "Tên hình thức phạm tội không chứa ký tự đặc biệt và từ 1-100 ký tự";
        }
        return null;
    }


    public string CallValidateThemMoiHinhThucPhamToi(string hinhthucphamtoi, string trangthaithongke)
    {
        string error = null;

        string ht = CheckHinhThucPhamToi(hinhthucphamtoi);
        if (ht != null)
        {
            return error = ht;
        }
        if (trangthaithongke == "")
        {
            return error = "Mời bạn chọn trạng thái sử dụng thống kê";
        }
        return error;
    }
    public string CallValidateUpdateThongTinToiPham(string hoten, string ngaysinh, string sochungminhthu, string hokhauthuongtru, string quequan)
    {
        string error = null;

        string ht = CheckHoTenRequited(hoten);
        if (ht != null)
        {
            return error = ht;
        }

        if (ngaysinh.Trim().Length == 0)
        {
            return error = "Mời bạn nhập ngày sinh";
        }
        string cmt = CheckCMTRequited(sochungminhthu);
        if (cmt != null)
        {
            return error = cmt;
        }
        string hk = CheckHoKhau(hokhauthuongtru);
        if (hk != null)
        {
            return error = hk;
        }
        string qq = CheckQueQuan(quequan);
        if (qq != null)
        {
            return error = qq;
        }
        return error;
    }
    public string CallValidateThemMoiHoSoToiPham(int id_hinhthucphamtoi, string ngayluuhoso, string tinhtranghoso)
    {
        string error = null;

        if (id_hinhthucphamtoi == 0 || id_hinhthucphamtoi == null)
        {
            return error = "Mời bạn chọn  hình thức phạm tội";
        }
        if (ngayluuhoso == "")
        {
            return error = "Mời bạn nhập ngày lưu hồ sơ";
        }
        if (tinhtranghoso == "")
        {
            return error = "Mời bạn chọn tình trạng hồ sơ";
        }
        return error;
    }
    public string CallValidateThemMoiToiPham(string hoten, string ngaysinh, string sochungminhthu, string hokhauthuongtru, string quequan, int id_hinhthucphamtoi, string ngayluuhoso, string tinhtranghoso)
    {
        string error = null;

        string ht = CheckHoTenRequited(hoten);
        if (ht != null)
        {
            return error = ht;
        }

        if (ngaysinh.Trim().Length == 0)
        {
            return error = "Mời bạn nhập ngày sinh";
        }
        string cmt = CheckCMTRequited(sochungminhthu);
        if (cmt != null)
        {
            return error = cmt;
        }
        string hk = CheckHoKhau(hokhauthuongtru);
        if (hk != null)
        {
            return error = hk;
        }
        string qq = CheckQueQuan(quequan);
        if (qq != null)
        {
            return error = qq;
        }

        if (id_hinhthucphamtoi == 0 || id_hinhthucphamtoi == null)
        {
            return error = "Mời bạn chọn  hình thức phạm tội";
        }
        if (ngayluuhoso == "")
        {
            return error = "Mời bạn nhập ngày lưu hồ sơ";
        }
        if (tinhtranghoso == "")
        {
            return error = "Mời bạn chọn tình trạng hồ sơ";
        }
        return error;
    }
    public string CallValidateThemBanner(string duongdanfile, string trangthaihienthi, string ngaydang, string ngaydung)
    {
        string error = null;

        if (duongdanfile.Trim().Length == 0)
        {
            return error = "Mời bạn chọn banner cần upload";
        }
        if (trangthaihienthi == "hengio" && (ngaydang.Trim().Length == 0 || ngaydung.Trim().Length == 0))
        {
            return error = "Mời bạn nhập ngày bắt đầu và kết thúc hiển thị banner";
        }
        if (trangthaihienthi == "hienthi" && ngaydung.Trim().Length == 0)
        {
            return error = "Mời bạn nhập ngày kết thúc hiển thị banner";
        }
        return error;
    }
    public string CallValidateThemLienKetHopTac(string tendoitac, string linkdiachi, string thongtindoitac, string avatar, string target, string trangthai)
    {
        string error = null;
        string cktd = CheckTenDoiTac(tendoitac);
        if (cktd != null)
        {
            return error = cktd;
        }
        string ckGT = CheckURL(linkdiachi);
        if (ckGT != null)
        {
            return error = ckGT;
        }

        string cknd = CheckThongTindoiTac(thongtindoitac);
        if (cknd != null)
        {
            return error = cknd;
        }
        if (avatar.Trim().Length == 0)
        {
            return error = "Mời bạn chọn ảnh đại diện cho liên kết";
        }
        if (trangthai == "")
        {
            return error = "Bạn chưa chọn trạng thái";
        }
        return error;
    }
    public string CallValidateThemMoiCauHoiThamDo(string cauhoi, int id_hinhthuctraloi, List<string> listDapAn, string trangthai, string tungay, string denngay, string ngayketthuc)
    {
        string error = null;

        string ckch = CheckNoiDungCauHoi(cauhoi);
        if (ckch != null)
        {
            return error = ckch;
        }
        if (id_hinhthuctraloi != 3 && listDapAn.Count == 0)
        {
            return error = "Mời bạn nhập câu trả lời";
        }
        if (trangthai == "")
        {
            return error = "Trạng thái hiển thị chưa được chọn";
        }
        if (trangthai == "hienthi" && ngayketthuc == " ")
        {
            return error = "Mời bạn chọn ngày kết thúc thăm dò ý kiến cho câu hỏi";
        }
        if (trangthai == "datlich" && (tungay == " " || denngay == " "))
        {
            return error = "Mời bạn chọn đủ ngày bắt đầu và kết thúc thăm dò ý kiến của câu hỏi";
        }

        return error;
    }
    public string CallValidateUpdateAlbumAnh(string tieudebv, string gioithieubv, string tacgiabv, string noidungbv)
    {
        string error = null;

        string cktd = CheckTieuDeBV(tieudebv);
        if (cktd != null)
        {
            return error = cktd;
        }
        string ckGT = CheckGioiThieuBV(gioithieubv);
        if (ckGT != null)
        {
            return error = ckGT;
        }

        string cknd = CheckNoiDungBV(noidungbv);
        if (cknd != null)
        {
            return error = cknd;
        }
        string cktg = CheckTacGiaBV(tacgiabv);
        if (cktg != null)
        {
            return error = cktg;
        }

        return error;
    }
    public string CallValidateThemAlbumAnh(string tieudebv, string gioithieubv, string tacgiabv, string noidungbv, List<string> listImages)
    {
        string error = null;
        string cktd = CheckTieuDeBV(tieudebv);
        if (cktd != null)
        {
            return error = cktd;
        }
        string ckGT = CheckGioiThieuBV(gioithieubv);
        if (ckGT != null)
        {
            return error = ckGT;
        }

        string cknd = CheckNoiDungBV(noidungbv);
        if (cknd != null)
        {
            return error = cknd;
        }
        string cktg = CheckTacGiaBV(tacgiabv);
        if (cktg != null)
        {
            return error = cktg;
        }
        if (listImages.Count == 0)
        {
            return error = "Mời bạn chọn file cho Album";
        }
        return error;
    }
    public string CallValidateUpdateTinhHuongKhanCap(int idtinhhuong, string tieude, string tinhhuong, string cachxuly)
    {
        string error = null;

        int idddn = client.ToInt(idtinhhuong);
        if (idddn == 0)
        {
            return error = "Tình huống bạn chọn không tồn tại";
        }
        string tdv = CheckTieuDeCauHoi(tieude);
        if (tdv != null)
        {
            return error = tdv;
        }
        string ckth = CheckTinhHuong(tinhhuong);
        if (ckth != null)
        {
            return error = ckth;
        }
        string ckxl = CheckCachXuLy(cachxuly);
        if (ckxl != null)
        {
            return error = ckxl;
        }
        return error;
    }
    public string CallValidateThemMoiTinhHuongKhanCap(string tieude, string tinhhuong, string cachxuly)
    {
        string error = null;

        string tdv = CheckTieuDeCauHoi(tieude);
        if (tdv != null)
        {
            return error = tdv;
        }
        string ckth = CheckTinhHuong(tinhhuong);
        if (ckth != null)
        {
            return error = ckth;
        }
        string ckxl = CheckCachXuLy(cachxuly);
        if (ckxl != null)
        {
            return error = ckxl;
        }
        return error;
    }
    public string CallValidateUpdateDuongDayNong(int id_dstongdai, string tendonvi, string sodienthoai, string email, string mota, string diachi)
    {
        string error = null;
        int idddn = client.ToInt(id_dstongdai);
        if (idddn == 0)
        {
            return error = "Đường dây nóng bạn chọn không tồn tại";
        }
        string tdv = CheckTenDonVi(tendonvi);
        if (tdv != null)
        {
            return error = tdv;
        }
        string cksdt = CheckPhoneReqiuted(sodienthoai);
        if (cksdt != null)
        {
            return error = cksdt;
        }
        string ckemail = CheckEmailRequited(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string ckmota = CheckGioiThieuBV(mota);
        if (ckmota != null)
        {
            return error = ckmota;
        }
        string ckdiachi = CheckDiaChiRequited(diachi);
        if (ckdiachi != null)
        {
            return error = ckdiachi;
        }
        return error;
    }
    public string CallValidateThemDuongDayNong(string tendonvi, string sodienthoai, string email, string mota, string diachi)
    {
        string error = null;

        string tdv = CheckTenDonVi(tendonvi);
        if (tdv != null)
        {
            return error = tdv;
        }
        string cksdt = CheckPhoneReqiuted(sodienthoai);
        if (cksdt != null)
        {
            return error = cksdt;
        }
        string ckemail = CheckEmailRequited(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string ckmota = CheckGioiThieuBV(mota);
        if (ckmota != null)
        {
            return error = ckmota;
        }
        string ckdiachi = CheckDiaChiRequited(diachi);
        if (ckdiachi != null)
        {
            return error = ckdiachi;
        }
        return error;
    }
    public string CallValidateThemBaiViet(string tieudebv, string gioithieubv, string anhdaidienbv, string tag, string noidungbv, string tacgiabv, string hinhthuchienthi, List<int> dsadminShare, string ngaydatlich)
    {
        string error = null;
        string cktd = CheckTieuDeBV(tieudebv);
        if (cktd != null)
        {
            return error = cktd;
        }
        string ckGT = CheckGioiThieuBV(gioithieubv);
        if (ckGT != null)
        {
            return error = ckGT;
        }
        string ckavatar = CheckAnhDaiDienBV(anhdaidienbv);
        if (ckavatar != null)
        {
            return error = ckavatar;
        }
        string cktag = CheckTag(tag);
        if (cktag != null)
        {
            return error = cktag;
        }
        string cknd = CheckNoiDungBV(noidungbv);
        if (cknd != null)
        {
            return error = cknd;
        }
        string cktg = CheckTacGiaBV(tacgiabv);
        if (cktg != null)
        {
            return error = cktg;
        }
        if (hinhthuchienthi == "hienthi" && dsadminShare.Count == 0)
        {
            return error = "Mời bạn chọn danh mục cho bài viết";
        }
        if (hinhthuchienthi == "hengio" && ngaydatlich.Trim().Length == 0)
        {
            return error = "Mời bạn nhập ngày giờ hiển thị cho bài viết";
        }
        return error;
    }

    public string CallValidateUpdateBaiViet(string tieudebv, string gioithieubv, string anhdaidienbv, string tag, string noidungbv, string tacgiabv, int id_baiviet)
    {
        string error = null;
        string cktd = CheckTieuDeBV(tieudebv);
        if (cktd != null)
        {
            return error = cktd;
        }
        string ckGT = CheckGioiThieuBV(gioithieubv);
        if (ckGT != null)
        {
            return error = ckGT;
        }
        string ckavatar = CheckAnhDaiDienBV(anhdaidienbv);
        if (ckavatar != null)
        {
            return error = ckavatar;
        }
        string cktag = CheckTag(tag);
        if (cktag != null)
        {
            return error = cktag;
        }
        string cknd = CheckNoiDungBV(noidungbv);
        if (cknd != null)
        {
            return error = cknd;
        }
        string cktg = CheckTacGiaBV(tacgiabv);
        if (cktg != null)
        {
            return error = cktg;
        }
        int idbv = client.ToInt(id_baiviet);
        if (idbv == 0)
        {
            return error = "Có lỗi trong quá trình thao tác vui lòng thực hiện lại";
        }
        return error;
    }
    public string CallValidateThemVanBan(string tenvanban, string sokyhieu, string ngaybanhanh, string trichyeu, string noidung, string duongdanfile, int id_coquanbanhanh, int id_loaivanban)
    {
        string error = null;
        if (tenvanban.Trim().Length == 0)
        {
            return error = "Mời bạn nhập tên văn bản";
        }
        if (sokyhieu.Trim().Length == 0 || sokyhieu.Length > 500)
        {
            return error = "Ký hiệu văn bản không được để trống và từ 1 - 500 ký tự";
        }
        if (ngaybanhanh.ToString().Trim().Length == 0)
        {
            return error = "Mời bạn chọn ngày ban hành văn bản";
        }
        if (trichyeu.Trim().Length == 0)
        {
            return error = "Mời bạn nhập trích yếu của văn bản";
        }
        if (noidung.Trim().Length == 0)
        {
            return error = "Mời bạn nhập nội dung cho văn bản";
        }
        if (duongdanfile.Trim().Length == 0 || duongdanfile.Length > 200)
        {
            return error = "Mời bạn chọn file đính kèm của văn bản";
        }
        int idcq = client.ToInt(id_coquanbanhanh);
        if (idcq == 0)
        {
            return error = "Mời bạn chọn cơ quan ban hành cho văn bản";
        }
        int idlvb = client.ToInt(id_loaivanban);
        if (idlvb == 0)
        {
            return error = "Mời bạn chọn loại văn bản";
        }

        return error;
    }
    public string CallValidateUpdateVanBan(int id_vanban, string tenvanban, string sokyhieu, string ngaybanhanh, string trichyeu, string noidung, string duongdanfile, int id_coquanbanhanh, int id_loaivanban)
    {
        string error = null;

        int idvb = client.ToInt(id_vanban);
        if (idvb == 0)
        {
            return error = "Văn bản không tồn tại";
        }
        if (tenvanban.Trim().Length == 0)
        {
            return error = "Mời bạn nhập tên văn bản";
        }
        if (sokyhieu.Trim().Length == 0 || sokyhieu.Length > 500)
        {
            return error = "Ký hiệu văn bản không được để trống và từ 1 - 500 ký tự";
        }
        if (ngaybanhanh.ToString().Trim().Length == 0)
        {
            return error = "Mời bạn chọn ngày ban hành văn bản";
        }
        if (trichyeu.Trim().Length == 0)
        {
            return error = "Mời bạn nhập trích yếu của văn bản";
        }
        if (noidung.Trim().Length == 0)
        {
            return error = "Mời bạn nhập nội dung cho văn bản";
        }
        if (duongdanfile.Trim().Length == 0 || duongdanfile.Length > 200)
        {
            return error = "Mời bạn chọn file đính kèm của văn bản";
        }
        int idcq = client.ToInt(id_coquanbanhanh);
        if (idcq == 0)
        {
            return error = "Mời bạn chọn cơ quan ban hành cho văn bản";
        }
        int idlvb = client.ToInt(id_loaivanban);
        if (idlvb == 0)
        {
            return error = "Mời bạn chọn loại văn bản";
        }

        return error;
    }

    public string CallValidateThemBVGioiThieu(string noidung)
    {
        string error = null;
        string cknd = CheckNoiDungBV(noidung);
        if (cknd != null)
        {
            return error = cknd;
        }
        return error;
    }
    public string CallValidateThemCauHoiMau(string tieudecauhoi, string cauhoi, string traloi, int id_chuyenmuc, string trangthaihienthi)
    {
        string error = null;

        string td = CheckTieuDeCauHoi(tieudecauhoi);
        if (td != null)
        {
            return error = td;
        }
        string ch = CheckNoiDungCauHoi(cauhoi);
        if (ch != null)
        {
            return error = ch;
        }
        string tl = CheckNoiDungCauTraLoi(traloi);
        if (tl != null)
        {
            return error = tl;
        }

        int idcq = client.ToInt(id_chuyenmuc);
        if (idcq == 0)
        {
            return error = "Mời bạn chọn chuyên mục";
        }

        if (trangthaihienthi.Trim().Length == 0)
        {
            return error = "Mời bạn chọn trạng thái hiển thị";
        }
        return error;
    }
    public string CallValidateUpdateCauHoiMau(int id_cauhoi, string tieudecauhoi, string cauhoi, string traloi, int id_chuyenmuc, string trangthaihienthi)
    {
        string error = null;
        int idch = client.ToInt(id_cauhoi);
        if (idch == 0)
        {
            return error = "Câu hỏi không tồn tại";
        }

        string td = CheckTieuDeCauHoi(tieudecauhoi);
        if (td != null)
        {
            return error = td;
        }
        string ch = CheckNoiDungCauHoi(cauhoi);
        if (ch != null)
        {
            return error = ch;
        }
        string tl = CheckNoiDungCauTraLoi(traloi);
        if (tl != null)
        {
            return error = tl;
        }

        int idcq = client.ToInt(id_chuyenmuc);
        if (idcq == 0)
        {
            return error = "Mời bạn chọn chuyên mục";
        }

        if (trangthaihienthi.Trim().Length == 0)
        {
            return error = "Mời bạn chọn trạng thái hiển thị";
        }
        return error;
    }

    public string CallValidatethongtintogiac(string hoten, string email, string dienthoai, string diachi, string tieude, string diaban, string noidungtinbao)
    {
        string error = null;

        string ht = CheckHoTen(hoten);
        if (ht != null)
        {
            return error = ht;
        }
        string ckemail = CheckEmail(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string cksdt = CheckPhone(dienthoai);
        if (cksdt != null)
        {
            return error = cksdt;
        }
        string ckdiachi = CheckDiaChi(diachi);
        if (ckdiachi != null)
        {
            return error = ckdiachi;
        }

        string ckdiaban = CheckDiaBanRequited(diaban);
        if (ckdiaban != null)
        {
            return error = ckdiaban;
        }
        string cktieude = CheckTieuDeRequited(tieude);
        if (cktieude != null)
        {
            return error = cktieude;
        }
        string cknd = CheckNoiDungRequited(noidungtinbao);
        if (cknd != null)
        {
            return error = cknd;
        }


        return error;
    }

    public string CallValidateGuiCauHoiMoi(string tendaydu, string email1, string tieudecauhoi, string noidung, string textcaptcha, string session)
    {
        string error = null;

        string ht = CheckHoTenRequited(tendaydu);
        if (ht != null)
        {
            return error = ht;

        }
        string ckemail = CheckEmailRequited(email1);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string cktieude = CheckTieuDeRequited(tieudecauhoi);
        if (cktieude != null)
        {
            return error = cktieude;
        }



        string cknd = CheckNoiDungRequited(noidung);
        if (cknd != null)
        {
            return error = cknd;
        }
        if (textcaptcha == session)
        {
            return null;
        }
        else
        {
            return error = "Mã xác nhận không chính xác";
        }

        return error;
    }

    public string CallValidateGuiCauHoiMoiClient(string tendaydu, string email1, string tieudecauhoi, int iddanhmuc, string noidung, string textcaptcha, string session)
    {
        string error = null;

        string ht = CheckHoTenRequited(tendaydu);
        if (ht != null)
        {
            return error = ht;

        }
        string ckemail = CheckEmailRequited(email1);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string cktieude = CheckTieuDeRequited(tieudecauhoi);
        if (cktieude != null)
        {
            return error = cktieude;
        }
        var checkchuyenmuc = entity.tbl_ChuyenMucLuaChon.Where(x => x.id_chuyenmuc == iddanhmuc && x.trangthai == true && x.id_danhmuc == 12).FirstOrDefault();
        if (checkchuyenmuc == null)
        {
            return error = "Chuyên mục bạn chọn không tồn tại";
        }

        string cknd = CheckNoiDungRequited(noidung);
        if (cknd != null)
        {
            return error = cknd;
        }
        if (textcaptcha == session)
        {
            return null;
        }
        else
        {
            return error = "Mã xác nhận không chính xác";
        }

        return error;
    }
    public string CallValidateThamDoYKien(string noidung)
    {
        string error = null;
        string cknd = CheckNoiDungRequited(noidung);
        if (cknd != null)
        {
            return error = cknd;
        }
        return error;
    }

    public string CallValidateThongTinCaNhanAdmin(string tendangnhap, string tendaydu, string email, string sodienthoai)
    {
        string error = null;

        string cktaikhoan = CheckTaikhoanRequited(tendangnhap);
        if (cktaikhoan != null)
        {
            return error = cktaikhoan;
        }

        string ht = CheckHoTenRequited(tendaydu);
        if (ht != null)
        {
            return error = ht;

        }
        string ckemail = CheckEmailRequited(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }

        string cknd = CheckPhoneReqiuted(sodienthoai);
        if (cknd != null)
        {
            return error = cknd;
        }
        return error;
    }
    public string CallValidateDoiMatKhauAdmin(string matkhaucu, string matkhau, string matkhau2, string email)
    {
        string error = null;
        if (matkhaucu == null)
        {
            return error = "Mời bạn nhập mật khẩu đang sử dụng";
        }

        string mk = CheckMKadminRequited(matkhau);
        if (mk != null)
        {
            return error = mk;

        }
        if (matkhau2 != matkhau || matkhau2 == null)
        {
            return error = "Nhập lại mật khẩu không chính xác";
        }
        string ckemail = CheckEmailRequited(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        return error;
    }

    public string CallValidateThemMoiAdmin(string tendangnhap, string matkhau, string email, string tendaydu)
    {
        string error = null;

        string cktaikhoan = CheckTaikhoanRequited(tendangnhap);
        if (cktaikhoan != null)
        {
            return error = cktaikhoan;
        }
        string mk = CheckMKadminRequited(matkhau);
        if (mk != null)
        {
            return error = mk;

        }
        string ckemail = CheckEmailRequited(email);
        if (ckemail != null)
        {
            return error = ckemail;
        }
        string ht = CheckHoTenRequited(tendaydu);
        if (ht != null)
        {
            return error = ht;

        }
        return error;
    }

    public string CallValidateThemMoiNhomQuanLy(string tennhom)
    {
        string error = null;

        string cktennhom = CheckTenNhom(tennhom);
        if (cktennhom != null)
        {
            return error = cktennhom;
        }

        return error;
    }


}
