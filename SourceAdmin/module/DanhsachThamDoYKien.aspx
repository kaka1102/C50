<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="DanhsachThamDoYKien.aspx.cs" Inherits="SourceAdmin_module_DanhsachThamDoYKien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .bootstrap-timepicker-widget.dropdown-menu.open {
            left: 20% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachalbumanh" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách câu hỏi thăm dò</a></li>
                        <li class="" id="liaddnew"><a href="#themmoialbumanh" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới câu hỏi</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#themmoialbumanh" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chi tiết câu hỏi và đáp án</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachalbumanh">
                        </div>
                        <div class="tab-pane box-body" id="themmoialbumanh">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Câu hỏi <span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="cauhoi" placeholder="Nội dung câu hỏi không quá 500 ký tự..."></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trả lời <span class="required-admin">*</span></label>
                                    <div class=" col-sm-10">
                                        <select class="form-control" id="frmHinhThucTraLoi">
                                            <option id="drop00">--Lựa chọn phương thức trả lời--</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" id="formgrdapan" style="display: none">
                                    <label for="inputEmail" class="col-sm-2 control-label">Tạo đáp án</label>
                                    <div class=" col-sm-10" id="formdapan">
                                    </div>
                                </div>
                                <div class="form-group" id="frmtrangthai">
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>
                                    <div class=" col-sm-10" id="frmHienthi">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="true" id="hienthi">Hiển thị ngay
                                            </label>
                                            <label id="lblHienthingay"></label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="datlich" checked="" id="datlich">Đặt lịch hiển thị
                                            </label>
                                            <label id="lblTuNgay"></label>
                                            <label id="lblDenNgay"></label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="" id="luunhap">Chỉ lưu
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="formDatLich">
                                    <div class=" col-sm-12" id="frmLich">
                                        <div id="toanthoigianbatdau" style="display: none;">
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-2 control-label">Thời gian bắt đầu </label>
                                                <div class="col-sm-5" id="batdautime">
                                                    <div class="input-group date">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" class="form-control pull-right" id="fullDateStart">
                                                    </div>
                                                </div>
                                                <div class="bootstrap-timepicker col-sm-4">
                                                    <div class="form-group">
                                                        <div class="col-sm-12" id="giophutbatdau">
                                                            <div class="input-group">
                                                                <div class="input-group-addon">
                                                                    <i class="fa fa-clock-o"></i>
                                                                </div>
                                                                <input type="text" class="form-control timepicker" id="timeStart">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="toanthoigianketthuc" style="display: none;">
                                            <div class="form-group">
                                                <label for="inputName" class="col-sm-2 control-label">Thời gian kết thúc </label>
                                                <div class="col-sm-5" id="ketthuctime">
                                                    <div class="input-group date">
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-calendar"></i>
                                                        </div>
                                                        <input type="text" class="form-control pull-right" id="fullDateEnd">
                                                    </div>
                                                </div>
                                                <div class="bootstrap-timepicker col-sm-4">
                                                    <div class="form-group">
                                                        <div class="col-sm-12" id="giophutketthuc">
                                                            <div class="input-group">
                                                                <div class="input-group-addon">
                                                                    <i class="fa fa-clock-o"></i>
                                                                </div>
                                                                <input type="text" class="form-control timepicker" id="timeEnd">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

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
        var page = 'thamdoykien';
    </script>
</asp:Content>

