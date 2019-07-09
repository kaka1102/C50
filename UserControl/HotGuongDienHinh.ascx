<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotGuongDienHinh.ascx.cs" Inherits="UserControl_HotGuongDienHinh" %>
<asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
    <ItemTemplate>
        <div class="title-catalog clearfix">
            <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
            <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>Tất cả tin</a>
        </div>
    </ItemTemplate>
</asp:Repeater>




<div class="catalog-content">
    <div class="catalog-border">
        <div class="catalog-bg">
            <div class="row">
                <asp:Repeater ID="RepeaterHOTDUONGDIENHINH" runat="server">
                    <ItemTemplate>
                        <div class="col-sm-5 col-md-4 thumbnail-catalog">
                            <img class="img-responsive img-thumbnail" src="<%# Eval("avatar") %>" alt="" />
                        </div>
                        <div class="col-sm-7 col-md-8">
                            <div class="description-news">
                                <a class="title-news" href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                    <h2 class="title-news-plus"><%# Eval("tieude") %></h2>
                                </a>
                                <span class="date-time-news"><i class="fa fa-clock-o"></i>(<%# Eval("ngaydang") %>)</span>
                                <p>
                                    <%# Eval("gioithieu") %>
                                </p>
                                <a class="read-more" href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">Chi tiết<i class="fa fa-angle-double-right"></i></a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>
