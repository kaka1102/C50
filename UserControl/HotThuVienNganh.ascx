<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotThuVienNganh.ascx.cs" Inherits="UserControl_HotThuVienNganh" %>



<div class="tab-library">
    <asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
        <ItemTemplate>
            <div class="btn-group btn-sort btn-sort-lib-home">
                <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>&nbsp;Xem thêm</a>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <ul class="nav nav-tabs responsive nav-tabs-lib-home">
        <li class="active"><a href="#library">THƯ VIỆN</a></li>
        <li><a href="#hinhanh">HÌNH ẢNH</a></li>
        <li><a href="#video">VIDEO</a></li>
    </ul>

    <div class="tab-content responsive tab-content-lib">

        <%--danh sach tong--%>
        <div class="tab-pane tab-pane-lib active" id="library">
            <div class="catalog-content">
                <div class="catalog-border catalog-padding">
                    <div class="row">
                        <asp:Repeater ID="RepeaterHOTTHUVIENNGANH" runat="server">
                            <ItemTemplate>
                                <div class="col-md-6 clearfix item-news">
                                    <div class="item-news-border">
                                        <div class="img-news">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>">

                                                <%# Eval("loaithuvien").ToString() == "thuvienanh"? "<img class=\"img-responsive\" src='"+Eval("avatar") +"' />":"<video><source src='"+Eval("avatar")+"' type=\"video/ogg\"></video>" %>

                                                <%# Eval("loaithuvien").ToString() == "thuvienanh"? "<span class=\"type-post\"><i class=\"fa fa-camera\"></i></span>":"<span class=\"type-post\"><i class=\"fa fa-play\"></i></span>" %>

                                                <%--<span class="type-post"><i class="fa <%# Eval("loaithuvien").ToString() == "thuvienanh"? "fa-camera":"fa-play" %>"></i></span>--%>
                                            </a>
                                        </div>
                                        <div class="img-news-des">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>"><%#Eval("tieude") %></a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <%--danh sach hinh anh--%>

        <div class="tab-pane tab-pane-lib" id="hinhanh">
            <div class="catalog-content">
                <div class="catalog-border catalog-padding">
                    <div class="row">
                        <asp:Repeater ID="RepeaterHOTTHUVIENANH" runat="server">
                            <ItemTemplate>
                                <div class="col-md-6 clearfix item-news">
                                    <div class="item-news-border">
                                        <div class="img-news">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>">
                                                <img class="img-responsive" src="<%#Eval("avatar") %>" alt="" />
                                                <span class="type-post"><i class="fa fa-camera"></i></span>
                                            </a>
                                        </div>
                                        <div class="img-news-des">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>"><%#Eval("tieude") %></a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <%--danh sach video--%>

        <div class="tab-pane tab-pane-lib" id="video">
            <div class="catalog-content">
                <div class="catalog-border catalog-padding">
                    <div class="row">
                        <asp:Repeater ID="RepeaterHOTTHUVIENVIDEO" runat="server">
                            <ItemTemplate>
                                <div class="col-md-6 clearfix item-news">
                                    <div class="item-news-border">
                                        <div class="img-news">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>">
                                                <video>
                                                    <source src="<%#Eval("avatar") %>" type="video/mp4">
                                                </video>
                                                <span class="type-post"><i class="fa fa-play"></i></span>
                                            </a>
                                        </div>
                                        <div class="img-news-des">
                                            <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>"><%#Eval("tieude") %></a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
