<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="LogHeThong.aspx.cs" Inherits="SourceAdmin_module_LogHeThong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .dataTables_length {
            display: block !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#tabletest" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách log hệ thống</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidunglienket">
                        <div class="tab-pane active box-body" id="tabletest">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="taobaocao"><i class="fa fa-refresh iconButtonPage" aria-hidden="true"></i>TẠO BÁO CÁO</button>
    </section>

    <div class="modal fade" id="ModalLogHeThong" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="box box-warning box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title" id="titleBC"></h3>
                </div>
                <div class="box-body" id="bodyBC">
                    <div id="toanthoigian">
                        <div class="form-group" id="ngaybatdau">
                            <label for="inputName" class="col-sm-4 control-label">Ngày bắt đầu </label>
                            <div class="col-sm-8 form-group" id="batdautime">
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <input type="text" class="form-control pull-right" id="fullDateStart">
                                </div>
                            </div>
                        </div>

                        <div class="form-group" id="ngayketthucc">
                            <label for="inputName" class="col-sm-4 control-label" id="">Ngày kết thúc</label>
                            <div class="col-sm-8 form-group" id="ketthutime">
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <input type="text" class="form-control pull-right" id="fullDateEnd">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" id="footerBC">
                    <button type="button" class="btn btn-danger btn-flat pull-left iconbuttonthoatModal" id="btnHuy" data-dismiss="modal"><i class="fa fa-times iconiModal" aria-hidden="true"></i>Thoát</button>
                     <button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnCreateBC" data-dismiss="modal"><i class="fa fa-file-excel-o iconButtonPage" aria-hidden="true"></i>Xuất Excel</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var page = 'loghethong';
    </script>
</asp:Content>




