<%@ Page Title="" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="SourceAdmin_module_404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="padding-bottom: 80px; padding-top: 80px">
        <h3 style="text-align: center; font-weight: bold; color: crimson"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>Không thể tìm thấy đường dẫn này</h3>
        <div style="float: left; padding-bottom: 20px; padding-top: 20px; width: 100%">
            <span style="text-align: center; width: 100%; float: left; font-size: 16px">Bạn có thể click <a id="linkweb">vào đây</a> để quay về trang chủ</span>
        </div>
    </div>
    <script type="text/javascript">
        var page = "trangloi";
        var url = location.origin;
        $('#linkweb').attr('href', url);
    </script>
</asp:Content>

