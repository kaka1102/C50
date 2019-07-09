<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyAdmin.aspx.cs" Inherits="SourceAdmin_module_QuanLyAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /*.content {
            padding-top: 50px !important;
        }*/

        .btn-block + .btn-block {
            margin: 0px !important;
        }

        .btn-block {
            display: inherit !important;
            width: inherit !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach">
                            <a href="#danhsachtaikhoan" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách tài khoản</a>
                        </li>
                        <li class="" id="liaddnew">
                            <a href="#themmoitaikhoan" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachtaikhoan">
                        </div>
                        <div class="tab-pane " id="themmoitaikhoan">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tài khoản<span class="required-admin">*</span></label>

                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="taikhoan">
                                        <label class="control-label" id="lbl_taikhoan"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Mật khẩu<span class="required-admin">*</span></label>

                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" id="makhau">
                                        <label class="control-label" id="lbl_matkhau"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Họ và tên <span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tendaydu">
                                        <label class="control-label" id="lbl_tendaydu"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Email<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="emailadmin">
                                        <label class="control-label" id="lbl_email"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Nhóm quản lý</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="dropDownList">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-5">
                                        <button type="button" class="btn btn-block btn-primary btn-flat IconButtonPage" id="btnThemmoi"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>
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
        var page = 'quanlytaikhoan';
    </script>
</asp:Content>

