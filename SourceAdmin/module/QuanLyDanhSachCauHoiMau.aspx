<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyDanhSachCauHoiMau.aspx.cs" Inherits="SourceAdmin_module_QuanLyDanhSachCauHoiMau" %>

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
                        <li class="active" id="lidanhsach"><a href="#danhsachcauhoitraloimau" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách câu hỏi - trả lời</a></li>
                        <li class="" id="liaddnew"><a href="#themoicauhoivacautraloi" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới câu hỏi - trả lời</a></li>
                        <li class="" id="lichitiet" style="display: none"><a href="#themoicauhoivacautraloi" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chi tiết câu hỏi - trả lời</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active  box-body" id="danhsachcauhoitraloimau">
                        </div>
                        <div class="tab-pane  box-body" id="themoicauhoivacautraloi">

                            <form class="form-horizontal" id="frmAll">
                                 <div class="form-group" id="frm1">
                                    <label for="inputName" class="col-sm-2 control-label">Tiêu đề<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tieudecauhoi">
                                    </div>
                                </div>
                                <div class="form-group" id="frm1">
                                    <label for="inputName" class="col-sm-2 control-label">Nội dung<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="cauhoi">
                                    </div>
                                </div>
                                <div class="form-group" id="frm5">
                                    <label class="col-sm-2 control-label">Trả lời<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea id="txt_noidung" class="ckeditor" name="txt_noidung" rows="40" cols="90"></textarea>
                                    </div>
                                </div>
                                <div class="form-group" id="frm8">
                                    <label class="col-sm-2 control-label">File đính kèm</label>
                                    <div class="col-sm-10">
                                        <button id="chosefile" type="button" value="Chọn">File đính kèm ( nếu có )</button>
                                        Chọn file hoặc coppy link chứa file vào ô bên dưới
                                    </div>
                                </div>
                                <div class="form-group" id="frm9">
                                    <label for="inputEmail" class="col-sm-2 control-label"></label>
                                    <div class="col-sm-10" id="dowloadf">
                                        <input type="text" class="form-control" id="duongdan">
                                    </div>
                                </div>


                                <div class="form-group" id="frmdanhmuc">
                                    <label for="inputEmail" class="col-sm-2 control-label">Danh mục</label>
                                    <div class="col-sm-10" >
                                        <div class="row" id="danhmuccauhoi">

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="frmtrangthai">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="" id="hienthi">Hiển thị
                                            </label>
                                        </div>
                                        <div class="radio" id="radiohengio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hengio" checked="" id="hengio">Chỉ lưu
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

        CKEDITOR.replace('txt_noidung',
                   {
                       fullPage: false,
                       filebrowserUploadUrl: "ashx/uploadFile.ashx",
                       imageBrowser_listUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/imagebrowser/browser/browser.html",
                       filebrowserVideoBrowseUrl: "../../GiaoDienAdmin/plugins/ckeditor/plugins/video/Servervideo.html",
                   });

    </script>
    <script type="text/javascript">
        var page = 'danhsachcauhoimau';
    </script>
</asp:Content>

