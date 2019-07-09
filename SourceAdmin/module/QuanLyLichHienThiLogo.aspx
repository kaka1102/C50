<%@ Page  ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyLichHienThiLogo.aspx.cs" Inherits="SourceAdmin_module_QuanLyLichHienThiLogo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        #tb_danhsachchuky_length {
            display: block !important;
        }


        .modal-dialog {
            width: 80% !important;
        }

      

        .box-header {
            padding: 20px !important;
        }

        .modal-footer {
            border-top: none !important;
        }
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section class="content">
        <div class="panel-container">
            <div class="panel-right">
                <div class="row">
                    <div class="col-md-12">
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs" id="ulmenu">
                                <li class="active" id="lidanhsach"><a href="#danhsachbanner" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách Logo</a></li>
                            </ul>
                            <div class="tab-content" id="frmnoidung">
                                <div class="tab-pane active box-body" id="danhsachbanner">
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
                                <div class="tab-pane " id="danhsachchukyhienthicuabanner">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        var page = 'quanlylichhienthilogo';
    </script>
</asp:Content>

