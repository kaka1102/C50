<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="Thongtincanhan.aspx.cs" Inherits="SourceAdmin_module_Thongtincanhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#thongtincanhan" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Thông tin cá nhân</a></li>
                        <li class="" id="lidoimatkhau"><a href="#doimatkhaucanhan" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Đổi mật khẩu</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active" id="thongtincanhan">
                            <form class="form-horizontal">
                                <label style="display: none" id="idtaikhoanadmin"></label>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Tên tài khoản<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="taikhoan">
                                        <label class="control-label" id="lbl_taikhoan"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Họ và tên<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tendaydu">
                                        <label class="control-label" id="lbl_tendaydu"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Email<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="diachiemail">
                                        <label class="control-label" id="lbl_email"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Số điện thoại<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="sodienthoai">
                                        <label class="control-label" id="lbl_sodienthoai"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Nhóm admin : </label>
                                    <div class="col-sm-10">
                                        <label class="control-label" id="id_nhomadmin"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-2 control-label">
                                        <div class="row">
                                            <label for="">Ảnh đại diện</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="help-block">
                                                    <button id="chosefileAvartarAdmin" class="buttonBanner" type="button" value="Chọn">Chọn file</button>&nbsp &nbsp Click để chọn file cần sử dụng
                                                </div>
                                            </div>
                                            <div class="col-sm-12" style="padding-top: 15px">
                                                <div class="row">
                                                    <div id="prevAvatarAdmin" class="col-sm-6">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-12" style="display: none">
                                                <label id="lblAvatarAdmin"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdate"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane" id="doimatkhaucanhan">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Mật khẩu cũ<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" placeholder="Mời bạn nhập mật khẩu đang sử dụng" id="mkcu">
                                        <label class="control-label" id="lbl_mkcu"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Mật khẩu mới<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" placeholder="Mời bạn nhập mật khẩu mới lớn hơn 6 ký tự" id="mkmoi">
                                        <label class="control-label" id="lbl_mkmoi1"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Nhập lại mật khẩu<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" placeholder="Mời bạn nhập lại mật khẩu mới" id="mkmoi2">
                                        <label class="control-label" id="lbl_mkmoi2"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="" class="col-sm-2 control-label">Địa chỉ email<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" placeholder="Mời bạn nhập email đang sử dụng trong hệ thống" id="emailhethong">
                                        <label class="control-label" id="lbl_emailhethong"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChange"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        var page = 'thongtincanhan';
    </script>
</asp:Content>

