<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="TinTucSuKien.aspx.cs" Inherits="SourceClient_TinTucSuKien" %>

<%@ Register Src="~/UserControl/SliderNewPostMenu.ascx" TagName="SliderNewPostMenu" TagPrefix="uc1" %>
<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>
<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

                        <%--slider new post--%>
                        <uc1:SliderNewPostMenu ID="SliderNewPostMenuTinTuc" runat="server" />
                        <%--slider new post--%>
                        <div id="C1" class="c"></div>
                        <div class="row content-tt-sk">
                            <asp:Repeater ID="RepeaterDANHMUCTINTUCSUKIEN" runat="server" OnItemDataBound="RepeaterDANHMUCTINTUCSUKIEN_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-sm-6 item-tt-sk">
                                        <div class="title-catalog clearfix">
                                            <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
                                        </div>
                                        <div class="border-tt-sk">
                                            <a class="tt-sk-img" href="<%#Eval("top.linkbaiviet")+"-"+Eval("top.id_vitribv")+".html" %>">
                                                <img src="<%#Eval("top.avatar") %>" class="img-responsive" alt="" /></a>
                                            <a href="<%#Eval("top.linkbaiviet")+"-"+Eval("top.id_vitribv")+".html" %>">
                                                <h3><%#Eval("top.tieude") %></h3>
                                            </a>
                                            <span class="date-time-news"><i class="fa fa-clock-o"></i>(<%#Eval("top.ngaydang") %>)</span>
                                            <div class="list-tt-sk">
                                                <ul class="clearfix">
                                                    <asp:Repeater ID="RepeaterDanhSachBaiViet" runat="server">
                                                        <ItemTemplate>
                                                            <li>
                                                                <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>"><%#Eval("tieude") %></a>
                                                                <span class="date-time-news"><i class="fa fa-clock-o"></i><%#Eval("ngaydang") %></span>
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </div>

                                        </div>

                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <div class="col-sm-6 item-tt-sk">
                                <div id="R7" class="r"></div>
                            </div>
                        </div>
                        <div id="C2" class="c"></div>

                    </div>
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
                    </div>
                </div>
                <div class="">
                    <div id="B1" class="b"></div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'pagetintuc';
    </script>
</asp:Content>

