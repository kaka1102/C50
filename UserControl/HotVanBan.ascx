<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HotVanBan.ascx.cs" Inherits="UserControl_HotVanBan" %>

<asp:Repeater ID="RepeaterTIEUDEMENU" runat="server">
    <ItemTemplate>
        <div class="title-catalog clearfix">
            <h2><a href="<%#Eval("duongdan") %>"><%#Eval("tendanhmuc") %></a></h2>
            <a href="<%#Eval("duongdan") %>"><i class="fa fa-plus-circle"></i>Tất cả văn bản</a>
        </div>
    </ItemTemplate>
</asp:Repeater>

<div class="catalog-content">
    <div class="catalog-border" id="tete">
        <asp:Repeater ID="RepeaterHOTVANBAN" runat="server">
            <ItemTemplate>
                <div class=" item-text clearfix" id="item<%# Eval("id_vanban") %>">
                    <a href="<%# Eval("linkvanban")+"-"+Eval("id_vanban")+".html" %>">
                        <img class="img-responsive" src="<%# Eval("icon") %>" />
                        <h3><%# Eval("tenvanban") %></h3>
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <script type="text/javascript">
            var sst = $('#subst h3');
            $.each(sst, function (key, val) {
                var giatri = $(this).text();
                var a = giatri.split(" ");
                if (giatri.length > 20) {
                    var splitted = giatri.split(" ", 15);
                    var chuoi = "";
                    for (i = splitted.length - 1; i >= 0; i--) {
                        chuoi = splitted[i] + " " + chuoi;
                    }
                    $(this).text(chuoi + "...")
                }
            });

            var dscheck = $('#tete div');
            $.each(dscheck, function (key, val) {
                if (key == 0 || key % 2 == 0) {
                    $(this).addClass('item-pdf');
                } else {
                    $(this).addClass('item-doc');
                }
            });
        </script>
    </div>
</div>
