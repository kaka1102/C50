<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuangCao.aspx.cs" Inherits="SourceAdmin_module_QuangCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .abcabc {
            right: 0 !important;
        }

        #dragTree {
            padding: 10px;
        }
        .btn-block + .btn-block {
            margin: 0px !important;
        }

        .btn-block {
            display: inherit !important;
            width: inherit !important;
        }

        .modal-dialog {
            width: 80% !important;
            margin: 150px auto !important;
        }

        .x-item-textbox {
            width: 96px;
            border: none;
            text-align: center;
        }

        .panel-right {
            padding: 0px !important;
        }

        .nav-tabs-custom {
            box-shadow: none !important;
        }

        .x-grid-body {
            border-width: 0px;
            border-style: none !important;
        }

        #chiasesudung {
            padding-top: 10px;
        }

        .box-header {
            padding: 20px !important;
        }

        .dropdown-menu {
            left: inherit !important;
            right: 0 !important;
        }
    </style>
    <link href="/GiaoDienAdmin/cssFolder/csschiakhung.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/window.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/windowall.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">
        <div class="panel-container">
            <div class="panel-right">

                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs" id="ulmenu">
                                <li class="active" id="lidanhsachdangchay"><a href="#danhsachquangcaodangchay" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách quảng cáo</a></li>
                                <li class="" id="lithemmoi"><a href="#themmoiquangcao" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới quảng cáo</a></li>
                                <li class="" id="liupdate" style ="display:none"><a href="#themmoiquangcao" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Cập nhật thông tin</a></li>
                            </ul>
                            <div class="tab-content" id="frmnoidung">
                                <div class="tab-pane active  box-body" id="danhsachquangcaodangchay">
                                </div>

                                <div class="tab-pane " id="themmoiquangcao" style="padding-top:20px">
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="col-sm-9">
                                                    <input type="file" id="anhdaidien" accept="image/*" title="Chọn ảnh từ máy tính"/>
                                                    <div class="" style="padding-top: 15px">
                                                       <div class="row">
                                                            <div id="preview" class="col-sm-6">
                                                        </div>
                                                        <div id="thongtinanh" class="col-sm-6">
                                                            <p id="name"></p>
                                                            <p id="size"></p>
                                                            <p id="type"></p>
                                                            <p id="kicthuoc" style="display: none"></p>
                                                            <p id="width"></p>
                                                            <p id="height"></p>
                                                        </div>

                                                       </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3" id="frmbutton">
                                                    
                                                </div>
                                                <div class="col-sm-12" style="padding-top: 20px">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <div class="box box-info">
                                                                <div class="box-header">
                                                                    Thông tin quảng cáo
                                                                    <div class="pull-right box-tools">
                                                                        <button type="button" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                                                            <i class="fa fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <div class="box-body pad" id="chonMenu">
                                                                    <form class="form-horizontal">
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Link quảng cáo <span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="linkquangcao" placeholder="Link quảng cáo">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Tên quảng cáo <span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="tenquangcao" placeholder="Tên quảng cáo">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Đơn vị đặt<span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="donvidat" placeholder="Tên đơn vị đặt quảng cáo ">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Thông tin<span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <textarea class="form-control" rows="3" id="thongtin" placeholder="Thông tin  ..."></textarea>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Vị trí đặt trong trang<span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <select class="form-control" id="vitri">
                                                                                    <option value="khong">Chọn vị trí hiển thị</option>
                                                                                    <option value="C">Giữa trang</option>
                                                                                    <option value="B">Dưới trang</option>
                                                                                    <option value="R">Phải trang</option>
                                                                                    <option value="L">Trái trang</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group" style="display: none" id="fromDiemDat">
                                                                            <label for="inputName" class="col-sm-4 control-label">Điểm đặt quảng cáo </label>
                                                                            <div class="col-sm-8">
                                                                                <select class="form-control" id="diemdattrongtrang">
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Ưu tiên hiển thị<span class="required-admin">*</span></label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="uutienhienthi" placeholder="Nhập số , số càng lớn chế độ ưu tiên càng cao">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group" id="frmtrangthai">
                                                                            <label for="inputEmail" class="col-sm-4 control-label">Trạng thái</label>
                                                                            <div class=" col-sm-8" id="frmHienthi">
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
                                                                                        <input type="radio" name="optionsRadios" value="luunhap" checked="" id="luunhap">Lưu nháp quảng cáo
                                                                                    </label>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                        <div id="toanthoigian" style="display: none">
                                                                            <div class="form-group" id="ngaybatdau">
                                                                                <label for="inputName" class="col-sm-4 control-label">Ngày bắt đầu <span class="required-admin">*</span></label>
                                                                                <div class="col-sm-8" id="batdautime">
                                                                                    <div class="input-group date">
                                                                                        <div class="input-group-addon">
                                                                                            <i class="fa fa-calendar"></i>
                                                                                        </div>
                                                                                        <input type="text" class="form-control pull-right" id="fullDateStart">
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <label for="inputName" class="col-sm-4 control-label" id="">Ngày kết thúc<span class="required-admin">*</span></label>
                                                                                <div class="col-sm-8" id="ketthutime">
                                                                                    <div class="input-group date">
                                                                                        <div class="input-group-addon">
                                                                                            <i class="fa fa-calendar"></i>
                                                                                        </div>
                                                                                        <input type="text" class="form-control pull-right" id="fullDateEnd">
                                                                                    </div>
                                                                                </div>
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
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        var page = 'quanlyquangcao';
    </script>

</asp:Content>

