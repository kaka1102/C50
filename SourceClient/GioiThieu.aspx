<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="GioiThieu.aspx.cs" Inherits="SourceClient_GioiThieu" %>

<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="/SourceClient/css/cssTrung.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section>
        <div class="" id="page-content">
            <div class="container">
                <div class="main-content">

                    <%--url menu--%>
                    <urlmenu:URLMENU ID="URLMENU1" runat="server" />
                    <%--url menu--%>

                    <div class="row">
                        <div class="content-left col-sm-3 ">
                            <div class="table-mn" id="loadmenuleft">
                                <h2 id="titleMenuGT" name="titleMenuGT" runat="server">Thông tin chung</h2>
                                <ul id="menuc2">
                                    <asp:Repeater ID="menuItem" runat="server">
                                        <ItemTemplate>
                                            <li><a href="<%# Eval("LinkBaiViet") %>"><i class="fa fa-star"></i><%# Eval("TenDanhMuc") %></a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                            <div>
                                <div id="L1" class="l"></div>
                                <div id="L2" class="l"></div>
                                <div id="L3" class="l"></div>
                            </div>
                        </div>
                        <div class="content-right col-sm-9" id="chitietbv">
                            <h2 id="tieudebv" runat="server">Lãnh đạo cục Cảnh sát phòng chống tội phạm công nghệ cao c50</h2>
                            <div class="tree clearfix">
                                <ul class="clearfix" id="sodocanbo">
                                </ul>
                            </div>
                            <div id="C1" class="c"></div>
                            <div id="C2" class="c"></div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'pagegioithieu';
    </script>
</asp:Content>

