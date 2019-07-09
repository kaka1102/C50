<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyHuongDanXuLyTinhHuong.aspx.cs" Inherits="SourceAdmin_module_QuanLyHuongDanXuLyTinhHuong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                        <li class="active" id="lidanhsach"><a href="#danhsachtinhhuong" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách tình huống</a></li>
                        <li class="" id="liaddnew"><a href="#themmoitinhhuong" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#themmoitinhhuong" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Thông tin chi tiết tình huống và cách xử lý</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachtinhhuong">
                        </div>
                        <div class="tab-pane " id="themmoitinhhuong">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tiêu đề<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                         <input type="text" class="form-control" id="tieude" placeholder="Enter ..." />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tình huống<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                         <textarea class="form-control" rows="3" id="tinhhuong" placeholder="Enter ..."></textarea>
                                    </div>
                                </div>
                                <div class="form-group" id="frm5">
                                    <label class="col-sm-2 control-label">Cách xử lý<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea id="txt_noidung" class="ckeditor" name="txt_noidung" rows="40" cols="90"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="" id="hienthi">Hiển thị
                                            </label>
                                        </div>
                                        <div class="radio" id="radiohengio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hengio" checked="true" id="hengio">Chỉ lưu
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10" id="frmButton">
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

        CKEDITOR.replace('txt_noidung',
                   {
                       fullPage: false,
                       filebrowserUploadUrl: "ashx/uploadFile.ashx",
                       imageBrowser_listUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/imagebrowser/browser/browser.html",
                       filebrowserVideoBrowseUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/video/Servervideo.html",
                   });

    </script>
    <script type="text/javascript">
        var page = 'quanlyhuongdansulytinhhuong';
    </script>
</asp:Content>

