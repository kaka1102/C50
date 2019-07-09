<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotTinBaoCongAn.ascx.cs" Inherits="UserControl_HotTinBaoCongAn" %>

<asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
    <ItemTemplate>
        <div class="title-catalog clearfix">
            <h2><%#Eval("tendanhmuc") %></h2>
            <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>Tất cả tin</a>
        </div>
    </ItemTemplate>
</asp:Repeater>

<div class="catalog-content">
    <div class="catalog-border catalog-padding">
        <div class="row">
            <asp:Repeater ID="RepeaterTINBAOCONGAN" runat="server">
                <ItemTemplate>
                    <div class="col-sm-6">
                        <div class="description-news">
                            <div class="list-news-time">
                                <a href="<%# Eval ("linktinbao") %>"><%# Eval ("tieude") %> </a>
                                <span class="date-time-news"><i class="fa fa-clock-o"></i>(<%# Eval ("ngaygui") %>)</span>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
