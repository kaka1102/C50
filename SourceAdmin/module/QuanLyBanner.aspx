<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyBanner.aspx.cs" Inherits="SourceAdmin_module_QuanLyBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">
        <div class="panel-container">
            <div class="panel-right">

                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs" id="ulmenu">
                                <li class="active" id="lidanhsach"><a href="#danhsachbanner" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách banner</a></li>
                                <li class="" id="liaddnew"><a href="#themmoibanner" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                            </ul>
                            <div class="tab-content" id="frmnoidung">
                                <div class="tab-pane active box-body" id="danhsachbanner">
                                </div>
                                <div class="tab-pane " id="themmoibanner">
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="col-sm-12" style="padding-top: 20px">
                                                    <div class="row">
                                                        <div class="col-sm-9" id="groupChosefile">
                                                            <div class="">
                                                                <button id="chosefile" class="buttonBanner" type="button" value="Chọn" title="Kích thước đề nghị :Banner trên 1366 x 150px ,Banner dưới 1366 x 500px">Chọn ảnh</button>
                                                                Click chọn banner cần sử dụng<span class="required-admin">*</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-3" id="buttonbanneractive">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <div class="row">
                                                        <div class="col-sm-7" id="groupBanner">
                                                            <label id="lblLinkBanner" style="display: none"></label>
                                                        </div>
                                                        <div class="" style="padding-top: 15px">
                                                            <div id="previewbanner" class="col-sm-6">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-sm-12" style="padding-top: 20px">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <div class="box box-info">
                                                                <div class="box-header">
                                                                    Thông tin banner
                                                                    <div class="pull-right box-tools">
                                                                        <button type="button" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                                                            <i class="fa fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <div class="box-body pad" id="chonMenu">
                                                                    <form class="form-horizontal">
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Tên banner</label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="tenbanner" placeholder="Đặt lại tên cho file vừa chọn">
                                                                                <label class="control-label" id="lbl_tenbanner"></label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Vị trí hiển thị</label>
                                                                            <div class="col-sm-8">
                                                                                <select class="form-control" id="vitri">
                                                                                    <option value="Banner trên">Banner trên</option>
                                                                                    <option value="Banner dưới">Banner dưới</option>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Link banner</label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text" class="form-control" id="linkbanner" placeholder="Nhập link khi click vào banner sẽ chuyển đến">
                                                                                <label class="control-label" id="lbl_linkbanner"></label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="inputName" class="col-sm-4 control-label">Target</label>
                                                                            <div class="col-sm-8">
                                                                                <select class="form-control" id="target">
                                                                                    <option value="blank">blank</option>
                                                                                    <option value="self">self</option>
                                                                                    <option value="parent">parent</option>
                                                                                    <option value="top">top</option>
                                                                                </select>
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
                                                                            </div>

                                                                        </div>
                                                                        <div id="toanthoigian">
                                                                            <div class="form-group" id="ngaybatdau" style="display: none">
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

                                                                            <div class="form-group" id="ngayketthucc">
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
        var page = 'quanlybanner';
    </script>

</asp:Content>

