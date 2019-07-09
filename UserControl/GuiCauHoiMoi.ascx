<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GuiCauHoiMoi.ascx.cs" Inherits="UserControl_GuiCauHoiMoi" %>
<div class="loader-parent" id="loaddingpage" style="display: none" runat="server">
    <div class="loader"></div>
</div>
<div class="widget">
    <div class="content-right-form">

        <div class="title-catalog clearfix">
            <h2>GỬI CÂU HỎI MỚI</h2>
        </div>
        <div class="widget-border">
            <div>
                <p>Lưu ý "<b>Họ Tên</b>" sẽ được dùng để tra cứu câu trả lời  theo tiêu chí "<b>người gửi</b>" trong form tìm kiếm câu hỏi"</p>
            </div>

            <div class="form-horizontal form-question" id="form-question">
                <div class="form-group">
                    <label class="col-lg-3">Họ Tên<i class="fa-required">*</i></label>
                    <div class="col-lg-9">
                        <input id="hoten" type="text" class="form-control" runat="server" />
                    </div>
                    <asp:Label ID="loihoten" runat="server" Text=""></asp:Label>
                </div>
                <div class="form-group">
                    <label class="col-lg-3">Email<i class="fa-required">*</i></label>
                    <div class="col-lg-9">
                        <asp:TextBox ID="email" type="Email" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <asp:Label ID="loiemail" runat="server" Text=""></asp:Label>
                </div>
                <div class="form-group">
                    <label class="col-lg-3">Tiêu đề<i class="fa-required">*</i></label>
                    <div class="col-lg-9">
                        <input id="tieude" type="text" class="form-control" runat="server" />
                    </div>
                    <asp:Label ID="lrlErrtieude" runat="server" Text=""></asp:Label>

                </div>
                <div class="form-group">
                    <label class="col-lg-3">Đính kèm</label>
                    <div class="col-lg-9">
                        <input type="file" id="file" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/pdf,image/jpeg,image/png" class="inputfile inputfile-1"/>
                        <%--<asp:FileUpload ID="file"  AccessKey="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/pdf,image/jpeg,image/png" runat="server" CssClass="inputfile inputfile-1" data-multiple-caption="{count} files selected" multiple />--%>
                        <%--<input type="file" name="file[]" id="file" runat="server" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" multiple />--%>
                        <label for="file">
                            <span>Chọn File đính kèm</span>
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-lg-3">Danh mục<i class="fa-required">*</i></label>
                    <div class="col-lg-9">
                        <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server" DataSourceID="SqlDataChuyenMucHoiDap" DataTextField="tenchuyenmuc" DataValueField="id_chuyenmuc" AppendDataBoundItems="true">
                            <asp:ListItem Text="--Chọn--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="loichon" runat="server" Text=""></asp:Label>

                        <asp:SqlDataSource runat="server" ID="SqlDataChuyenMucHoiDap" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [tbl_ChuyenMucLuaChon] WHERE (([trangthai] = @trangthai) AND ([id_danhmuc] = @id_danhmuc))">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="trangthai" DefaultValue="true" Name="trangthai" Type="Boolean"></asp:QueryStringParameter>
                                <asp:QueryStringParameter QueryStringField="id_danhmuc" DefaultValue="12" Name="id_danhmuc" Type="Int32"></asp:QueryStringParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                </div>

                <div class="form-group">
                    <label class="col-lg-12">Nội dung câu hỏi<i class="fa-required">*</i></label>
                    <div class="col-lg-12">
                        <asp:TextBox TextMode="MultiLine" class="form-control" ID="noidung" Width="100%" MaxLength="10" runat="server" cols="20" Rows="5"></asp:TextBox>
                        <asp:Label ID="loinoidung" runat="server" Text=""></asp:Label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-lg-3">Captcha<i class="fa-required">*</i></label>
                    <div class="col-lg-9">
                        <div class="ccRaovat" style="background-color: White; display: inline-block; margin-bottom: 15px;">
                            <img id="CaptchaQues" src="/SourceClient/ashx/Captcha.ashx" alt="Captcha" border="0" width="128" height="31" />
                        </div>
                        <div style="height: 40px;">
                            <input type="text" id="txtCapchaQues" runat="server" maxlength="5" />
                            <input type="image" id="layerClickQues" title="Click đây để tải hình mới!" width="50" height="40" src="/ThuMucGoc/AnhDaiDien/icon-refresh.png"
                                onclick="reloadcapchaguicauhoi(); return false" style="border-width: 0px; display: inline-block; margin-bottom: -16px;" />
                            <label id="lblErrThamdo"></label>
                        </div>
                        <asp:Label ID="loicaptcha" runat="server" Text="">

                        </asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3"></label>
                    <div class="col-lg-9 text-right">
                        <%--<asp:Button ID="gui" runat="server" Text="Gửi" CssClass="btn btn-primary" OnClick="gui_Click" />--%>
                        <button type="button" id="btnGuiCauhoi" class="btn btn-primary">Gửi</button>
                        <button type="reset" id="btnresetform" class="btn btn-primary">Nhập lại</button>
                    </div>
                    <asp:Label ID="loi" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    $('#btnGuiCauhoi').click(function () {
        var cauhoi = $('#ContentPlaceHolder1_GuiCauHoiMoi1_noidung').val();
        var email1 = $('#ContentPlaceHolder1_GuiCauHoiMoi1_email').val();
        var tendaydu = $('#ContentPlaceHolder1_GuiCauHoiMoi1_hoten').val();
        var tieudecauhoi = $('#ContentPlaceHolder1_GuiCauHoiMoi1_tieude').val();
        var chon = $('#ContentPlaceHolder1_GuiCauHoiMoi1_DropDownList2').val();
        var textcaptcha = $('#ContentPlaceHolder1_GuiCauHoiMoi1_txtCapchaQues').val();
        var check = true;

        if (tendaydu == "") {
            check == false;
            swal('Thông báo ', "Họ tên không được để trống", 'error')
        } else if (email1 == "") {
            check == false;
            swal('Thông báo ', "Email không được để trống", 'error')
        }
        else if (tieudecauhoi == "") {
            check == false;
            swal('Thông báo ', "Tiêu đề không được để trống", 'error')
        }
        else if (chon == 0) {
            check == false;
            swal('Thông báo ', "Danh mục không được để trống", 'error')
        }
        else if (cauhoi == "") {
            check == false;
            swal('Thông báo ', "Nội dung câu hỏi không được để trống", 'error')
        }
        else if (textcaptcha == "") {
            check == false;
            swal('Thông báo ', "Captcha không được để trống", 'error')
        }
        else {
            var objSend = {
                cauhoi: cauhoi,
                email1: email1,
                tendaydu: tendaydu,
                tieudecauhoi: tieudecauhoi,
                chon: chon,
                textcaptcha: textcaptcha,
                pathFile: $('#file').val()
            }
            var fm_data = new FormData();
            fm_data.append('filedinhkem', $('#file')[0].files[0]);
            fm_data.append("objSend", JSON.stringify(objSend));
            fm_data.append("type", "guicauhoi");


            swal({
                title: 'Thông báo',
                text: "Bạn có chắc sẽ gửi nội dung như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function checkAccept(kq) {
                $('#btnGuiCauhoi').attr('disabled');
                $.ajax({
                    type: "POST",
                    url: "/SourceClient/ashx/Clientxuly.ashx",
                    data: fm_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            $('#btnresetform').click();
                            $('#layerClickQues').click();
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('#btnGuiCauhoi').removeAttr('disabled');
                    }
                });
            }, function dismiss(result) {
                if (result === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh gửi đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('#btnGuiCauhoi').removeAttr('disabled');
            });
        }
    });

</script>
