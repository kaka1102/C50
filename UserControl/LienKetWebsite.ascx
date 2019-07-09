<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LienKetWebsite.ascx.cs" Inherits="UserControl_LienKetWebsite" %>


<div class="widget">
    <div class="title-catalog clearfix" style="padding-bottom: 3px">
        <h2>LIÊN KẾT WEBSITE</h2>
    </div>
    <div class="navigation">
        <ul>
            <asp:Repeater ID="RepeaterBOXLIENKETWEB" runat="server">
                <ItemTemplate>
                    <li class="li-bg-mail">
                        <a href="<%# Eval("linkdiachi") %>" target="_blank">
                            <img class="img-responsive"  title="<%# Eval("tendoitac") %>" src="<%# Eval("avatar") %>"></a>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</div>
