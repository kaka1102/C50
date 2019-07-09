<%@ Page ValidateRequest="false" EnableViewState="false" Title="" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="DanhSach-TinTuc-SuKien.aspx.cs" Inherits="SourceClient_TinTuc_SuKien_TinHoatDongCuc" %>


<%@ Register Src="~/UserControl/SliderDanhMuc.ascx" TagName="SliderDanhMuc" TagPrefix="danhmuc" %>
<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>
<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="/SourceClient/js/custom-file-input.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">
                        <%--url menu--%>
                        <urlmenu:URLMENU ID="URLMENU1" runat="server" />
                        <%--url menu--%>

                        <%--slider--%>
                        <danhmuc:SliderDanhMuc ID="SliderDanhMuc" runat="server" />
                        <%--slider--%>
                        <div id="C1" class="c"></div>

                        <asp:Repeater ID="RepeaterDANHSACHTINTUCSUKIEN" runat="server">
                            <ItemTemplate>
                                <div class="title-catalog title-catalog-bg clearfix">
                                    <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
                                    <ul class="nav nav-tabs nav-tabs-lib navbar-right hidden-xs">

                                        <li><a data-toggle="tab" href="#detail"><span class="glyphicon glyphicon-th-list"></span></a></li>
                                        <li class="active"><a data-toggle="tab" href="#list"><span class="glyphicon glyphicon-th"></span></a></li>
                                    </ul>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <div class="tab-content">
                            <div id="list" class="tab-pane fade in active">
                                <div class="type-list-view clearfix">
                                    <h3 id="thongbaoketqua" runat="server"></h3>
                                    <asp:Repeater ID="RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB1" runat="server">
                                        <ItemTemplate>
                                            <div class="type-list-post col-sm-6">
                                                <div class="type-list-content">
                                                    <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                                        <img src="<%#Eval("avatar") %>" class="img-responsive" /></a>
                                                    <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                                        <h3><%#Eval("tieude") %></h3>
                                                    </a>
                                                    <span class="date-time-news"><i class="fa fa-clock-o"></i><%#Eval("ngaydang") %></span>
                                                    <p><%#Eval("gioithieu") %></p>
                                                </div>

                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div class="example" id="pagin-ht">
                                    <asp:Literal ID="Literal1" runat="server">
                                    </asp:Literal>
                                   <%-- <ul id="ulPage" runat="server">
                                        <li>
                                            <input id="pageDau" runat="server" type="button" value="Đầu" />&nbsp;
                                        <input id="pageTruoc" runat="server" type="button" value="Trước" />
                                        </li>
                                        <li id="noidungPage" runat="server"></li>

                                        <li>
                                            <input id="pageSau" runat="server" type="button" value="Sau" />
                                            <input id="pageCuoi" runat="server" type="button" value="Cuối" />
                                        </li>

                                    </ul>--%>
                                </div>
                            </div>
                            <div id="detail" class="tab-pane fade">
                                <div class="type-detail-view">
                                    <h3 id="thongbaoketqua2" runat="server"></h3>
                                    <asp:Repeater ID="RepeaterDANHSACHBAIVIETDANHMUCTINTUCTAB2" runat="server">
                                        <ItemTemplate>
                                            <div class="type-detail-post">
                                                <div class="row">
                                                    <div class="img-detil-post col-sm-5">
                                                        <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                                            <img src="<%#Eval("avatar") %>" class="img-responsive" /></a>
                                                    </div>
                                                    <div class="type-detail-des col-sm-7">
                                                        <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                                            <h3><%#Eval("tieude") %></h3>
                                                        </a>
                                                        <span class="date-time-news"><i class="fa fa-clock-o"></i><%#Eval("ngaydang") %></span>
                                                        <p><%#Eval("gioithieu") %></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div class="example" id="pagin-ht2">
                                    <asp:Literal ID="Literal2" runat="server"></asp:Literal>
                                    <%--<ul id="ulPage1" runat="server">
                                        <li>
                                            <input id="pageDau1" runat="server" type="button" value="Đầu" />&nbsp;
                                        <input id="pageTruoc1" runat="server" type="button" value="Trước" />
                                        </li>
                                        <li id="noidungPage1" runat="server"></li>

                                        <li>
                                            <input id="pageSau1" runat="server" type="button" value="Sau" />
                                            <input id="pageCuoi1" runat="server" type="button" value="Cuối" />
                                        </li>

                                    </ul>--%>
                                </div>
                            </div>
                        </div>
                        <div id="C2" class="c"></div>
                    </div>
                    <!-- end left-content-->
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <%--SLIDE BOX--%>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                        <%--SLIDE BOX--%>
                        <div id="R2" class="r"></div>
                        <%--thoi tiet--%>
                        <thoitietgiavang:ThoiTietGiaVang ID="ThoiTietGiaVang1" runat="server" />
                        <%--thoi tiet--%>

                        <div id="R3" class="r"></div>
                        <div id="R4" class="r"></div>
                        <%--tham do y kien--%>
                        <thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />
                        <%--tham do y kien--%>
                        <div id="R5" class="r"></div>
                        <%--luot truy cap--%>
                        <luottruycap:LuotTruyCap ID="LuotTruyCap1" runat="server" />
                        <%--luot truy cap--%>
                        <div id="R6" class="r"></div>
                        <div id="R7" class="r"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {

            //var d = document.getElementById('pagin-ht').outerHTML;

            //d = d.replace(/<span/g, "<li");
            //d = d.replace(/<\/span>/g, "</li>");
            //d = d.replace("<div>", "<ul>");
            //d = d.replace("</div>", "</ul>");
            //d = d.replace("<div class=\"example\" id=\"pagin-ht\">", "");
            //d = d.replace("<div class=\"pagination pagination-ht\">", "");
            //d = d.replace(/<\/div>/g, "");
            //d = d.replace(/<li style=\"paddingleft:10\">/g, "");
            //d = d.replace(/<li style=\"paddingleft:5\">/g, "");
            //document.getElementById('pagin-ht').innerHTML = d;

            //var d2 = document.getElementById('pagin-ht2').outerHTML;
            //d2 = d2.replace(/<span/g, "<li");
            //d2 = d2.replace(/<\/span>/g, "</li>");
            //d2 = d2.replace("<div>", "<ul>");
            //d2 = d2.replace("</div>", "</ul>");
            //d2 = d2.replace("<div class=\"example\" id=\"pagin-ht2\">", "");
            //d2 = d2.replace("<div class=\"pagination pagination-ht\">", "");
            //d2 = d2.replace(/<\/div>/g, "");
            //d2 = d2.replace(/<li style=\"paddingleft:10\">/g, "");
            //d2 = d2.replace(/<li style=\"paddingleft:5\">/g, "");
            //document.getElementById('pagin-ht2').innerHTML = d2;

        });
    </script>
    <script type="text/javascript">
        var page = 'pagedanhsachtintuc';
    </script>
</asp:Content>

