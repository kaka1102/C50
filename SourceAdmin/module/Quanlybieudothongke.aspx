<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="Quanlybieudothongke.aspx.cs" Inherits="SourceAdmin_module_Quanlybieudothongke" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .frmdate12 {
            padding-bottom: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachbieudothongke" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách biểu đồ thống kê</a></li>
                        <li class="" id="liaddnew"><a href="#thongtinchitietvebieudo" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#thongtinchitietvebieudo" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Thông tin chi tiết</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachbieudothongke">
                        </div>
                        <div class="tab-pane " id="thongtinchitietvebieudo">
                            <div style="padding-top: 20px">
                                <form class="form-horizontal">
                                    <div class="form-group">
                                        <label for="inputName" class="col-sm-2 control-label">Tên biểu đồ<span class="required-admin">*</span></label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="tenbieudo">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail" class="col-sm-2 control-label">Loại biểu đồ<span class="required-admin">*</span></label>
                                        <div class=" col-sm-10">
                                            <select class="form-control" id="frmLoaiBieuDo">
                                                <option value="0">--Lựa chọn loại biểu đồ--</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail" class="col-sm-2 control-label">Đơn vị thời gian<span class="required-admin">*</span></label>
                                        <div class=" col-sm-10">
                                            <select class="form-control" id="frmDonViThoiGian">
                                                <option value="0">--Lựa chọn đơn vị thời gian--</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group" id="frmShowThoigian">
                                    </div>
                                    <div class="form-group" id="frmtrangthai">
                                        <label for="inputEmail" class="col-sm-2 control-label">Trạng thái biểu đồ</label>
                                        <div class=" col-sm-10" id="frmTrangThai">
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios" value="hienthi" checked id="hienthi">Hiển thị
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label>
                                                    <input type="radio" name="optionsRadios" value="chiluu" id="chiluu">Chỉ lưu
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-8" id="frmButton">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </section>
    

    <script type="text/javascript">
        var page = 'quanlybieudothongke';
    </script>
</asp:Content>

