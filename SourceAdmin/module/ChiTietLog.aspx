<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="ChiTietLog.aspx.cs" Inherits="SourceAdmin_ChiTietLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">
        <div class="box box-info">
            <div class="box-header">
            </div>
            <form class="form-horizontal">
                <div class="box-body">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">ID Log <span class="required-admin">*</span></label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" id="idloght" onkeydown="if (event.keyCode == 13) {timkiemlogtheoid(); return false}" placeholder="Mời bạn nhập id log muốn tìm kiếm ">
                        </div>
                        <div class="col-sm-3">
                            <button type="button" id="timkiemlog" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-search iconButtonPage" aria-hidden="true"></i>Tìm kiếm</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">Chọn bảng log</label>
                        <div class="col-sm-7">
                            <select class="form-control" id="danhsachbanglog">
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>



        <div class="panel-container">
            <div class="panel-right">
                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs" id="ulmenu">
                                <li class="active" id="lilog"><a href="#frmthongtin" data-toggle="tab" aria-expanded="false"><i class="fa fa-info-circle iconTab"></i>Thông tin log</a></li>
                                <li class="" id="lidata"><a href="#frmData" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Dữ liệu thao tác</a></li>
                                <li id="livitri"><a href="#frmVitri" data-toggle="tab" aria-expanded="false"><i class="fa fa-map-marker iconTab"></i>Vị trí truy cập</a></li>
                            </ul>
                            <div class="tab-content" id="frmnoidung">
                                <div class="tab-pane active box-body" id="frmthongtin"></div>
                                <div class="tab-pane  box-body" id="frmData"></div>
                                <div class="tab-pane box-body" id="frmVitri"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'chitietloghethong';
    </script>
</asp:Content>

