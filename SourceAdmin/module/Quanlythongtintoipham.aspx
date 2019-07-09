<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="Quanlythongtintoipham.aspx.cs" Inherits="SourceAdmin_module_Quanlythongtintoipham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .thongtincanhantoipham {
            padding-top: 30px;
        }

        #titletoipham h3 {
            text-align: center;
        }

        #tb_thongtintienancuatoipham_length {
            display: block !important;
        }

        #thongtintienancuatoipham {
            padding-top: 20px;
        }

        .modal-dialog {
            width: 70% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachtoipham" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách tội phạm</a></li>
                        <li class="" id="liaddnew"><a href="#themmoithoipham" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#themmoithoipham" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Thông tin chi tiết tội phạm</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachtoipham">
                        </div>
                        <div class="tab-pane " id="themmoithoipham">
                            <div id="thongtintienancuatoipham">
                            </div>
                            <div id="thongtincanhan" class="thongtincanhantoipham">
                                <div id="titletoipham">
                                    <h3>Thông tin cá nhân</h3>
                                </div>
                                <div>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label for="inputName" class="col-sm-2 control-label">Họ và tên<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="hoten">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label">Ngày sinh<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="date" class="form-control" id="ngaysinh">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label">Số CMND<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="sochungminhthu">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label">Hộ khẩu thường trú<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="hokhauthuongtru">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label">Quê quán<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="quequan">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail" class="col-sm-2 control-label">Biệt danh</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="bietdanh">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">Ảnh tội phạm</label>
                                            <div class="col-sm-10">
                                                <div class="row">
                                                    <div class="col-sm-12" id="groupChosefileToiPham">
                                                        <div class="help-block">
                                                            <button id="chosefile" class="button123" type="button" value="Chọn">Chọn file</button>&nbsp&nbsp Click chọn file cần sử dụng
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6" id="groupFileToiPham">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="frmHinhthuc">
                                            <label for="inputEmail" class="col-sm-2 control-label">Hình thức phạm tội<span class="required-admin">*</span></label>
                                            <div class=" col-sm-10">
                                                <select class="form-control" id="frmHinhThucPhamToi">
                                                    <option value="0">--Lựa chọn phương thức phạm tội--</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group" id="frmNgayluhs">
                                            <label for="inputEmail" class="col-sm-2 control-label">Ngày lưu hồ sơ<span class="required-admin">*</span></label>
                                            <div class="col-sm-10">
                                                <input type="date" class="form-control" id="ngayluuhoso">
                                            </div>
                                        </div>
                                        <div class="form-group" id="frmtrangthai">
                                            <label for="inputEmail" class="col-sm-2 control-label">Tình trạng hồ sơ</label>
                                            <div class=" col-sm-10" id="frmTinhTrang">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optionsRadios" value="dathuan" checked id="dathuan">Đã thụ án
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optionsRadios" value="chuathuan" id="chuathuan">Chưa thụ án
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
            </div>
        </div>


        <div class="modal fade" id="ModalToiPham" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title" id="ToiPhamTitle"></h3>
                    </div>
                    <div class="box-body" id="ToiPhamBody">
                        <form class="form-horizontal" style="padding-top: 20px">
                            <div class="form-group" id="">
                                <label for="inputEmail" class="col-sm-3 control-label">Hình thức phạm tội<span class="required-admin">*</span></label>
                                <div class=" col-sm-7">
                                    <select class="form-control" id="frmHinhThucPhamToimodal">
                                        <option value="0">--Lựa chọn phương thức phạm tội--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group" id="">
                                <label for="inputEmail" class="col-sm-3 control-label">Ngày lưu hồ sơ<span class="required-admin">*</span></label>
                                <div class="col-sm-7">
                                    <input type="date" class="form-control" id="ngayluuhosomodal">
                                </div>
                            </div>
                            <div class="form-group" id="">
                                <label for="inputEmail" class="col-sm-3 control-label">Tình trạng hồ sơ</label>
                                <div class=" col-sm-7" id="frmTinhTrangmodal">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" value="dathuan" checked id="idthuan">Đã thụ án
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" value="chuathuan" id="idchuathuan">Chưa thụ án
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer" id="ToiPhamFT">
                        <button type="button" class="btn btn-danger btn-flat pull-left" id="btnCances" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i>Thoát</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'quanlythongtintoipham';
    </script>
</asp:Content>

