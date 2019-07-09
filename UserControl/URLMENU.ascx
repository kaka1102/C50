<%@ Control Language="C#" AutoEventWireup="true" CodeFile="URLMENU.ascx.cs" Inherits="UserControl_URLMENU" %>


<div class="head-content">
    <ul class="mn-content clearfix">
        <li><a id="TTURL">Trang Chủ<i class="fa fa-angle-right"></i></a>
        </li>
        <asp:Repeater ID="RepeaterURLMenu" runat="server">
            <ItemTemplate>
                <li><a href="<%#Eval("duongdan") %>"> <%#Eval("ten") %><i class="fa fa-angle-right"></i></a> </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
