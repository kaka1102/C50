<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="LienKetHopTac.aspx.cs" Inherits="SourceAdmin_module_LienKetHopTac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachlienket" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách liên kết hợp tác</a></li>
                        <li class="" id="liaddnew" style="display: none"><a href="#themmoilienkethoptac" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidunglienket">
                        <div class="tab-pane active box-body" id="danhsachlienket">
                        </div>
                        <div class="tab-pane " id="themmoilienkethoptac">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tên đối tác<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tendoitac">
                                        <label class="control-label" id="lbl_tendoitac"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Link website<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="linkdiachi">
                                        <label class="control-label" id="lbl_linkdiachi"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Thông tin đối tác<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" rows="3" id="thongtindoitac" placeholder="Enter ..."></textarea>
                                        <label class="control-label" id="lbl_thongtindoitac"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Hiển thị</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="dropdowHienThi">
                                            <option>Hiển thị ở tab mới</option>
                                            <option>Hiển thị ở tab hiện tại</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <div class="col-sm-12" id="groupChosefileLKHT">
                                                <div class="help-block">
                                                    <button id="chosefile" class="buttonLKHT" type="button" value="Chọn">Chọn file</button>&nbsp &nbsp Click chọn file cần sử dụng
                                                </div>
                                            </div>
                                            <div class="col-sm-12" id="" style="display: none">
                                                <label id="lblLinkLKHT"></label>
                                            </div>

                                            <div class="col-sm-12" style="padding-top: 15px">
                                                <div class="row">
                                                    <div id="previewLKHT" class="col-sm-6">
                                                    </div>
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
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="" id="hienthi">Hiển thị ngay
                                            </label>
                                        </div>
                                        <div class="radio" id="rdoLuunhap">
                                            <label>
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="true" id="luunhap">Lưu nháp 
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoilienket"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>
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
        var page = 'lienkethoptac';
    </script>
</asp:Content>

