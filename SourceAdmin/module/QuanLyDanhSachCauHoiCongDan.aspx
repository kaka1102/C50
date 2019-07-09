<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyDanhSachCauHoiCongDan.aspx.cs" Inherits="SourceAdmin_module_QuanLyDanhSachCauHoiCongDan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .modal-dialog {
            width: 80% !important;
        }

        .form-horizontal .control-label {
            padding-left: 20px;
            text-align: left !important;
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
                        <li class="active" id="lidanhsach"><a href="#dscauhoitraloicongdan" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách câu hỏi - trả lời phản hồi công dân</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active  box-body" id="dscauhoitraloicongdan">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <div class="modal fade" id="ModalCauhoi" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="box box-warning box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title" id="tieudeCauhoi"></h3>
                </div>
                <div class="box-body" id="bodyCauhoi">
                    <form class="form-horizontal">
                        <div class="form-group" id="frm1">
                            <div class="col-sm-6">
                                <label for="inputName" class="col-sm-12 control-label" id="lbltennguoigui"></label>
                                <label for="inputName" class="col-sm-12 control-label" id="lblemailnguoigui"></label>
                                <label for="inputName" class="col-sm-12 control-label" id="lblngayguicauhoi"></label>
                            </div>
                            <div class="col-sm-6" id="frmdinhkemgui">
                                <label for="inputName" class="col-sm-12 control-label" id="lblchuyenmuc"></label>
                                <label for="inputName" class="col-sm-4 control-label" id="lblfiledinhkem">File đính kèm : </label>
                                <a id="duongdanlink" class="col-sm-8 control-label" download></a>
                            </div>
                        </div>
                         <div class="form-group" id="frmtieude">
                            <label for="inputName" class="col-sm-2 control-label">Tiêu đề</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="3" id="tieudecauhoi" placeholder=""></textarea>
                            </div>
                        </div>
                        <div class="form-group" id="frmdiachi">
                            <label for="inputName" class="col-sm-2 control-label">Câu hỏi</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="3" id="cauhoi" placeholder=""></textarea>
                            </div>
                        </div>
                        <div class="form-group" id="frmtraloi">
                            <label class="col-sm-2 control-label">Trả lời<span class="required-admin">*</span></label>
                            <div class="col-sm-10">
                                <textarea id="txt_noidung" class="ckeditor" name="txt_noidung" rows="30" cols="90"></textarea>
                            </div>
                        </div>
                        <div class="form-group" id="frm8">
                            <label class="col-sm-2 control-label">Chọn file đính kèm</label>
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
                            <div class="col-sm-10">
                                <div class="row" id="danhmuccauhoi">

                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="frmtrangthai">
                            <label for="inputEmail" class="col-sm-2 control-label">Trạng thái hiển thị</label>
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
                    </form>
                </div>
                <div class="modal-footer" id="footerCauhoi">
                    <button type="button" class="btn btn-danger btn-flat pull-left" id="btnCances" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i>Thoát</button>
                </div>
            </div>
        </div>
    </div>




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
        var page = 'danhsachcauhoicongdan';
    </script>
</asp:Content>

