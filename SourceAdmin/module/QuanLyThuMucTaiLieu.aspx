<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyThuMucTaiLieu.aspx.cs" Inherits="SourceAdmin_module_QuanLyThuMucTaiLieu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
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
            width: 300px !important;
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

        .popup_msg {
            position: absolute;
            z-index: 10;
            display: none;
        }
    </style>

    <link href="/GiaoDienAdmin/cssFolder/csschiakhung.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/window.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/windowall.css" rel="stylesheet" />


    <script src="/GiaoDienAdmin/cssFolder/windowall.js"></script>
    <script src="/GiaoDienAdmin/cssFolder/window_defaulf.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class="panel-container">
            <div class="panel-left  box box-primary ">
                <div class="box-header with-border">
                    <h3 class="box-title">THƯ MỤC TÀI LIỆU</h3>
                </div>
                <div id="dragTree">
                </div>
            </div>
            <div class="splitter">
            </div>
            <div class="panel-right">

                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs" id="ulmenu">
                                <li class="active" id="lidanhsach"><a href="#danhsachanhhienthi" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách file</a></li>
                                <li class="" id="liaddnew" style="display: none"><a href="#uploadvaothumuc" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Upload</a></li>
                            </ul>
                            <div class="tab-content" id="frmnoidung">
                                <div class="tab-pane active box-body" id="danhsachanhhienthi">
                                    <div class="nav-tabs-custom">

                                        <div class="x-panel x-fit-item x-panel-default" style="width: 100%; height: 700px; margin: 0px;" role="presentation" id="fileManager">
                                            <div id="fileManager-bodyWrap" data-ref="bodyWrap" class="x-panel-bodyWrap" role="presentation">
                                                <div id="fileManager-body" data-ref="body" class="x-panel-body x-panel-body-default x-border-layout-ct x-panel-body-default x-docked-noborder-top x-docked-noborder-right x-docked-noborder-bottom x-docked-noborder-left" role="presentation" style="width: 100%; height: 100%; left: 0px; top: 0px;">
                                                    <div class="x-container x-border-item x-box-item x-container-default" style="border-width: 0px; margin: 0px; width: 100%; right: auto; /* left: 205px; *//* top: 190px; */height: 100%;" role="presentation" id="ext-comp-1065">
                                                        <div class="x-component x-dataview x-unselectable x-grid-body x-fit-item x-component-default x-scroller" role="listbox" aria-hidden="false" aria-disabled="false" aria-multiselectable="true" id="dataview-1066" tabindex="0" data-componentid="dataview-1066" style="overflow: auto; margin: 0px; width: 100%; height: 100%;">
                                                            <ul class="x-items" id="dataimages">
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane " id="uploadvaothumuc"  style="    min-height: 400px;padding-top:20px">
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <input type="file" id="anhdaidien" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-powerpoint,application/pdf" title="Chọn file từ máy tính (Dung lượng < 10 Mb)" />
                                                <div class="" style="padding-top: 15px">
                                                    <div id="thongtin" class="col-sm-12">
                                                        <h5 id="name-vid"></h5>
                                                        <p id="size-vid"></p>
                                                        <p id="type-vid"></p>
                                                        <p id="kicthuoc" style="display: none"></p>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12" style="padding-top: 20px;">
                                                    <div class="box box-danger" id="chiasesudung">
                                                        <div class="box-header with-border">
                                                            <h3 class="box-title">Chia sẻ</h3>
                                                        </div>
                                                        <div class="box-body">
                                                            <div class="row">
                                                                <div id="chontatca">
                                                                    <div class="checkbox col-xs-12">
                                                                        <label>
                                                                            <input id="listAdmin" type="checkbox" />Chọn tất cả
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="checkbox col-md-12" id="danhsachadmin">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUploadFile"><i class="fa fa-upload iconButtonPage" aria-hidden="true" ></i>Upload</button>
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
    <div>
        <ul class="vakata-context jstree-contextmenu jstree-default-contextmenu popup_msg" id="popuup_div">
            <li><a id="deleteimg"><i class="fa fa-trash-o"></i><span class="vakata-contextmenu-sep">&nbsp;</span>Xóa file</a></li>
            <li><a id="renameimg"><i class="fa fa-edit"></i><span class="vakata-contextmenu-sep">&nbsp;</span>Đổi tên</a></li>
        </ul>
    </div>


    <script type="text/javascript">
        var page = 'quanlythumuctailieu';
    </script>
</asp:Content>

