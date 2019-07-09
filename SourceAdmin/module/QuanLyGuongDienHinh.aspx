<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyGuongDienHinh.aspx.cs" Inherits="SourceAdmin_module_QuanLyGuongDienHinh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="/GiaoDienAdmin/plugins/TagsInput/bootstrap-tagsinput.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/plugins/TagsInput/app.css" rel="stylesheet" />
    <style>
        .btn-block + .btn-block {
            margin: 0px !important;
        }

        .btn-block {
            display: inherit !important;
            width: inherit !important;
        }

        .cke_floatingtools {
            top: -36px !important;
        }

        .modal-footer {
            border-top: none !important;
        }

        .dropdown-menu {
            left: inherit !important;
            right: 0 !important;
        }

        .modal-dialog {
            width: 80% !important;
            margin: 150px auto !important;
        }

        .dataTables_length {
            display: block !important;
        }
    </style>

    <script>
        UPLOADCARE_PUBLIC_KEY = '53c577b994ac7b31cd78';
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachbaiviet" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách bài viết</a></li>
                        <li class="" id="liaddnew"><a href="#themmoibaiviet" data-toggle="tab" aria-expanded="false" id="titleupdate"><i class="fa fa-plus iconTab"></i>Thêm mới bài viết</a></li>
                        <li class="" id="lichitiet" style="display: none"><a href="#chitietbvtrongdm" data-toggle="tab" aria-expanded="false" id="titlechitiet"></a></li>
                        <li class="" id="libaivietdanhmuc" style="display: none; float: right"><a href="#chitietbvtrongdm" data-toggle="tab" aria-expanded="false" id="titledm"></a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachbaiviet">
                        </div>
                        <div class="tab-pane" id="chitietbvtrongdm">
                        </div>
                        <div class="tab-pane " id="themmoibaiviet">
                            <form class="form-horizontal">
                                <div class="form-group" id="frm1">
                                    <label for="inputName" class="col-sm-2 control-label">Tiêu đề<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tieude">
                                        <label class="control-label" id="lbl_tieude"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm2">
                                    <label for="inputEmail" class="col-sm-2 control-label">Giới thiệu<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="gioithieu" placeholder="Enter ..."></textarea>
                                        <label class="control-label" id="lbl_gioithieu"></label>
                                    </div>
                                </div>
                                <div class="form-group" id="frm3">
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-sm-12" id="groupChosefileavbv">
                                                <div class="help-block">
                                                    <button id="chosefileavbv" class="buttonBanner" type="button" value="Chọn">Chọn file</button>&nbsp&nbsp Click chọn file cần sử dụng
                                                </div>
                                            </div>
                                            <div class="col-sm-12" id="groupbv">
                                                <label id="lbl_anhdaidien" style="display: none"></label>
                                            </div>

                                            <div class="col-sm-12" style="padding-top: 15px">
                                                <div class="row">
                                                    <div id="previewavbv" class="col-sm-6">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group" id="frm4">
                                    <label for="inputEmail" class="col-sm-2 control-label">Tag<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tag" data-role="tagsinput">
                                    </div>
                                </div>
                                <br />
                                <div class="form-group" id="frm5">
                                    <label class="col-sm-2 control-label">Nội dung<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea id="txt_noidung" class="ckeditor" name="txt_noidung" rows="40" cols="90"></textarea>
                                    </div>
                                </div>

                                <div class="form-group" id="frm6">
                                    <label for="inputEmail" class="col-sm-2 control-label">Tác giả<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tacgia">
                                        <label class="control-label" id="lbl_tacgia"></label>
                                    </div>
                                </div>

                                <div class="form-group" id="frmdanhmuc">
                                    <label for="inputEmail" class="col-sm-2 control-label">Danh mục<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <div class="row" id="danhmucbaiviet">

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
                                        <div class="radio" id="radiohengio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hengio" checked="" id="hengio">Hẹn giờ hiển thị
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


    <script src="/GiaoDienAdmin/plugins/TagsInput/bootstrap-tagsinput.min.js"></script>
    <script type="text/javascript">

        CKEDITOR.replace('txt_noidung',
                   {
                       fullPage: false,
                       filebrowserUploadUrl: "ashx/uploadFile.ashx",
                       imageBrowser_listUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/imagebrowser/browser/browser.html",
                       filebrowserVideoBrowseUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/video/Servervideo.html",
                   });

    </script>

    <script type="text/javascript">
        var page = 'quanlyguongdienhinh';
    </script>
</asp:Content>

