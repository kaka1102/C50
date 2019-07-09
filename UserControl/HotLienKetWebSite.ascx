<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotLienKetWebSite.ascx.cs" Inherits="UserControl_HotLienKetWebSite" %>

<div class="title-catalog clearfix">
    <h2>LIÊN KẾT WEBSITE</h2>
</div>

<div class="link-web">
    <div id="owl-linkweb" class="owl-carousel owl-theme">
        <asp:Repeater ID="RepeaterLIENKETWEBSITE" runat="server">
            <ItemTemplate>
                <div class="item">
                    <a href="<%# Eval("linkdiachi") %>" target="_blank">
                        <img class="img-responsive" title="<%# Eval("tendoitac") %>" src="<%# Eval("avatar") %>"></a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
