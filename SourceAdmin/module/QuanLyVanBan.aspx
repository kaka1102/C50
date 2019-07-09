<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyVanBan.aspx.cs" Inherits="SourceAdmin_module_QuanLyVanBan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachvanban" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách văn bản</a></li>
                        <li class="" id="liaddnew"><a href="#themmoivanban" data-toggle="tab" aria-expanded="false" id="titleAdd"><i class="fa fa-plus iconTab"></i>Thêm mới văn bản</a></li>
                        <li class="" style="display: none" id="liupdate"><a href="#themmoivanban" data-toggle="tab" aria-expanded="false" id="titleupdate"><i class="fa fa-edit iconTab"></i>Sửa thông tin văn bản</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung1">
                        <div class="tab-pane active box-body" id="danhsachvanban">
                        </div>
                        <div class="tab-pane " id="themmoivanban">
                            <form class="form-horizontal">
                                <div class="form-group" id="frm1">
                                    <label for="inputName" class="col-sm-2 control-label">Tên văn bản<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tenvanban">
                                        <label class="control-label" id="lbl_tenvanban"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm2">
                                    <label for="inputEmail" class="col-sm-2 control-label">Số ký hiệu<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="sokyhieu">
                                        <label class="control-label" id="lbl_sokyhieu"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm4">
                                    <label for="inputEmail" class="col-sm-2 control-label">Ngày ban hành<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="date" class="form-control" id="ngaybanhanh">
                                    </div>
                                </div>
                                <br />
                                <div class="form-group" id="frm6">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trích yếu<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="10" id="trichyeu" placeholder="Enter ..."></textarea>
                                        <label class="control-label" id="lbl_trichyeu"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm7">
                                    <label for="inputEmail" class="col-sm-2 control-label">Nội dung<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="10" id="noidung" placeholder="Enter ..."></textarea>
                                        <label class="control-label" id="lbl_noidung"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm8">
                                    <label class="col-sm-2 control-label">Chọn văn bản<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <button id="chosefile" type="button" value="Chọn">File văn bản đính kèm</button>
                                        Chọn file văn bản cần sử dụng
                                    </div>
                                </div>
                                <div class="form-group" id="frm9">
                                    <label for="inputEmail" class="col-sm-2 control-label"></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="duongdan" disabled="disabled">
                                        <label class="control-label" id="lbl_duongdan"></label>
                                    </div>
                                </div>

                                <div class="form-group" id="frmcoquan">
                                    <label for="inputEmail" class="col-sm-2 control-label">Nơi ban hành<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <div class="row" id="coquanbanhanh">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="frmloaivb">
                                    <label for="inputEmail" class="col-sm-2 control-label">Loại văn bản<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <div class="row" id="loaivanban">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="frmtrangthai">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="true" id="hienthi">Hiển thị ngay
                                            </label>
                                        </div>
                                        <div class="radio" id="rdoLuunhap">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="" id="luunhap">Lưu nháp bài viết
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10" id="frmbutton">
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
        var page = 'quanlyvanban';
    </script>
</asp:Content>

