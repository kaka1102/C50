<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="IndexAdmin.aspx.cs" Inherits="SourceAdmin_module_IndexAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-sm-12 col-lg-12 col-md-12 col-xs-12">
        <div class="row">
            <div class="bg-indexadmin">
                <div class="logo-p-index">
                    <div class="col-sm-2 col-sm-offset-5 col-xs-2 col-xs-offset-5">
                        <div class="row">
                            <img src="/SourceClient/img/logo.png" class="img-responsive" />
                        </div>
                    </div>
                </div>
                <div class="title1-p-index">
                    <div class="col-sm-offset-1 col-sm-10 col-md-offset-1 col-md-10 col-lg-offset-1 col-lg-10">
                        <span>HỆ THỐNG QUẢN TRỊ WEBSITE CỦA CỤC CẢNH SÁT PHÒNG,</span>
                    </div>
                </div>
                <div class="title2-p-index">
                    <div class="col-sm-offset-1 col-sm-10 col-md-offset-1 col-md-10 col-lg-offset-1 col-lg-10">
                        <span>CHỐNG TỘI PHẠM SỬ DỤNG CÔNG NGHỆ CAO</span>
                    </div>
                </div>
                <div class="title-admin-index">
                    <span id="helloadmin" runat="server"></span>
                </div>
                 <div class="title3-p-index">
                    <div class="col-sm-offset-1 col-sm-10 col-md-offset-1 col-md-10 col-lg-offset-1 col-lg-10">
                        <span>Mọi truy cập bất hợp pháp sẽ bị xử lý theo quy định của pháp luật</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var page = "indexadmin";
    </script>
</asp:Content>

