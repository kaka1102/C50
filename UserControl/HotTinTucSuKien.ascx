<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotTinTucSuKien.ascx.cs" Inherits="UserControl_HotTinTucSuKien" %>


<asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
    <ItemTemplate>
        <div class="title-catalog clearfix">
            <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
            <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>Tất cả tin</a>
        </div>
    </ItemTemplate>
</asp:Repeater>

<div class="row catalog-content" runat="server" id="subst">
    <asp:Repeater ID="rptNews" runat="server">
        <ItemTemplate>
            <div class="col-xs-6 col-md-3 item-catalog clearfix">
                <a href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                    <img src="<%# Eval("avatar") %>" alt="" class="img-responsive" />
                </a>
                <a href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                    <h3 class="text-justify"><%# Eval("tieude") %></h3>
                </a>

            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
