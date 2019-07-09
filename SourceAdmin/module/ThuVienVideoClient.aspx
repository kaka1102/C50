<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="ThuVienVideoClient.aspx.cs" Inherits="SourceAdmin_module_ThuVienVideoClient" %>

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
                        <li class="active" id="lidanhsach"><a href="#danhsachalbumanh" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách album video</a></li>
                        <li class="" id="liaddnew"><a href="#themmoialbumanh" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới Album video</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#themmoialbumanh" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chi tiết Album video</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachalbumanh">
                        </div>
                        <div class="tab-pane box-body" id="themmoialbumanh">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tiêu đề<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tieude">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Giới thiệu<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="gioithieu" placeholder="Enter ..."></textarea>
                                    </div>
                                </div>
                                <div class="form-group" id="frm5">
                                    <label class="col-sm-2 control-label">Nội dung<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea id="txt_noidung" class="ckeditor" name="txt_noidung" rows="40" cols="90"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Tác giả<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tacgia">
                                    </div>
                                </div>

                                <div class="form-group" style="display: none" id="frmShowIMG">
                                    <label class="col-sm-2 control-label">Danh sách video</label>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div id="showImg">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Chọn file<span class="required-admin">*</span></label>
                                    <div class="col-sm-10" id="groupChosefileVideo">
                                        <div class="help-block">
                                            <button id="chosefileVideo" class="buttonVideo" type="button" value="Chọn">Click chọn nhiều video</button>&nbsp&nbsp Click chọn file cần sử dụng
                                        </div>
                                    </div>
                                    <div class="col-sm-10 pull-right" >
                                        <div class="row" id="groupFileVideo">
                                           
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="frmtrangthai">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="true" id="hienthi">Hiển thị
                                            </label>
                                        </div>
                                        <div class="radio" id="rdoLuunhap">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="" id="luunhap">Chỉ lưu
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="">
                                    <label for="inputEmail" class="col-sm-2 control-label">Danh mục</label>
                                    <div class=" col-sm-10">
                                        <select class="form-control" id="frmCheckBox">
                                        </select>
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
        var page = 'thuvienvideoclient';
    </script>
</asp:Content>

