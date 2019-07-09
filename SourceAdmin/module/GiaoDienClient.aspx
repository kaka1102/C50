<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="GiaoDienClient.aspx.cs" Inherits="SourceAdmin_module_GiaoDienClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
        #dragTree {
            padding: 10px;
        }

        /*.content {
            padding-top: 50px !important;
        }*/

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
    </style>
   <%-- <link href="/GiaoDienAdmin/cssFolder/csschiakhung.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/window.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/cssFolder/windowall.css" rel="stylesheet" />

    <script src="/GiaoDienAdmin/cssFolder/windowall.js"></script>
    <script src="/GiaoDienAdmin/cssFolder/window_defaulf.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <section class="content">
        <div class="panel-container">
            <div class="panel-left  box box-primary ">
                <div class="box-header with-border">
                    <h3 class="box-title">Quản lý menu client</h3>
                </div>
                <div id="dragTree">
                </div>
            </div>
            <div class="splitter">
            </div>
        </div>
    </section>
       <script type="text/javascript">
           var page = 'menutrongtrang';
    </script>
</asp:Content>

