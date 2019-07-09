<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotHopTacQuocTe.ascx.cs" Inherits="UserControl_HotHopTacQuocTe" %>

<asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
    <ItemTemplate>
        <div class="title-catalog clearfix">
            <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
            <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>Tất cả tin</a>
        </div>
    </ItemTemplate>
</asp:Repeater>

<div class="catalog-content">
    <div class="row">
        <asp:Repeater ID="RepeaterHOPTACQUOCTE" runat="server" OnItemDataBound="RepeaterHOPTACQUOCTE_ItemDataBound">
            <ItemTemplate>
                <div class="col-sm-6">
                    <img class="img-responsive fixhtqt" src="<%# Eval("avatar") %>" />
                </div>
                <div class="col-sm-6">
                    <div class="description-news">
                        <a class="title-news" href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                            <h2><%# Eval("tieude") %></h2>
                        </a>
                        <p>
                            <%# Eval("gioithieu") %>
                        </p>
                    </div>
                    <div class="list-news">
                        <ul>
                            <asp:Repeater ID="RepeaterListHopTacQuocTe" runat="server">
                                <ItemTemplate>
                                    <li><a href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                        <p><%# Eval("tieude") %> </p>
                                    </a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
