<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyDuongDayNong.aspx.cs" Inherits="SourceAdmin_module_QuanLyDuongDayNong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachduongdaynong" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách đường dây nóng</a></li>
                        <li class="" id="liaddnew"><a href="#themmoiduongdaynong" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                        <li class="" id="liadetails" style="display:none"><a href="#themmoiduongdaynong" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Thông tin chi tiết đường dây nóng</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachduongdaynong">
                        </div>
                        <div class="tab-pane " id="themmoiduongdaynong">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tên đơn vị<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tendonvi">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Số điện thoại<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="sodienthoai">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Email<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="emailduongdaynong">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Mô tả<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="mota" placeholder="Enter ..."></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Địa chỉ<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="diachi">
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
        var page = 'quanlyduongdaynong';
    </script>
</asp:Content>

