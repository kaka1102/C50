<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyTrangGioiThieu.aspx.cs" Inherits="SourceAdmin_module_QuanLyTrangGioiThieu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .frmdanhmuc {
            float: left;
            padding-bottom: 20px;
            width: 100%;
        }

        .andi {
            display: none !important;
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
                        <li class="active" id="lidanhsach"><a href="#danhsachbaigioithieu" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Quản lý bài viết trang giới thiệu</a></li>
                        <li class="" id="liaddnew" style="display:none"><a href="#themmoibaivietdmgt" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="frmdanhmuc" id="frmdanhmuc">
                            <div class="form-group">
                                <label for="inputEmail" class="col-sm-2 control-label">Chọn danh mục<span class="required-admin">*</span></label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="frmDropDM">
                                    </select>
                                </div>

                            </div>
                        </div>
                        <div class="tab-pane active box-body" id="danhsachbaigioithieu">
                        </div>
                        <div class="tab-pane box-body" id="themmoibaivietdmgt">
                            <form class="form-horizontal">
                                <div class="form-group" id="frm5">
                                    <label class="col-sm-2 control-label">Nội dung<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea id="noidung" class="ckeditor" name="noidung" rows="40" cols="90"></textarea>
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

        CKEDITOR.replace('noidung',
                   {
                       fullPage: false,
                       filebrowserUploadUrl: "ashx/uploadFile.ashx",
                       imageBrowser_listUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/imagebrowser/browser/browser.html",
                       filebrowserVideoBrowseUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/video/Servervideo.html",
                   });

    </script>
    <script type="text/javascript">
        var page = 'quanlygioithieu';
    </script>
</asp:Content>

