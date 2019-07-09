<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="DanhSachCanBo.aspx.cs" Inherits="SourceAdmin_module_DanhSachCanBo" %>

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
                        <li class="active" id="lidanhsach"><a href="#danhsachcanbo" data-toggle="tab" aria-expanded="false">Danh sách cán bộ</a></li>
                        <li class="" id="liaddnew"><a href="#themmoicanbo" data-toggle="tab" aria-expanded="false">Thêm mới</a></li>
                        <li class="" id="lidetails" style="display: none"><a href="#themmoicanbo" data-toggle="tab" aria-expanded="false">Thông tin chi tiết cán bộ</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachcanbo">
                        </div>
                        <div class="tab-pane " id="themmoicanbo">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Họ và tên</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tencanbo">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Chức vụ</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="chucvu">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Đơn vị công tác</label>
                                    <div class="col-sm-10">
                                        <input list="dsdonvicongtac" name="browser" class="form-control" id="donvicongtac">
                                        <datalist id="dsdonvicongtac"></datalist>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Thông tin</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="thongtinlienhe" placeholder="Enter ..."></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Quân hàm</label>
                                    <div class="col-sm-10">
                                        <input list="lsquanham" name="browser" class="form-control" id="quanham">
                                        <datalist id="lsquanham"></datalist>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Ngày sinh</label>
                                    <div class="col-sm-10">
                                        <input type="date" class="form-control" id="ngaysinh">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Quê quán</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="quequan">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện</label>
                                    <div class="col-sm-10">
                                        <div class="col-sm-12">
                                            <div class="col-sm-3" id="groupChosefileCanBo">
                                                <div class="help-block">
                                                    <button id="chosefile" class="buttonCanBo" type="button" value="Chọn">Chọn ảnh đại diện</button>
                                                </div>
                                            </div>
                                            <div class="col-sm-9" id="groupFileCanBo">
                                                <label id="lblLinkCanBo"></label>
                                            </div>

                                            <div class="col-sm-12" style="padding-top: 15px">
                                                <div id="previewCanBo" class="col-sm-6">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="frmtrangthai">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="true" id="hienthi">Đang hoạt động
                                            </label>
                                        </div>
                                        <div class="radio" id="rdoLuunhap">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="" id="luunhap">Đã nghỉ
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10" id="frmButtonCanbo">
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
        var page = 'danhsachcanbo';
    </script>
</asp:Content>

