<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyTinBaoCongDan.aspx.cs" Inherits="SourceAdmin_module_QuanLyTinBaoCongDan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .modal-dialog {
            width: 80% !important;
        }

        #tb_danhsachtinbaocd_length {
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
                        <li class="active" id="lidanhsach"><a href="#danhsachtinbaocd" data-toggle="tab" aria-expanded="false">Danh sách tin báo công dân</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active  box-body" id="danhsachtinbaocd">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <script type="text/javascript">
        var page = 'quanlytinbaocongdan';
    </script>
</asp:Content>

