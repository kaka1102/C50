<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SliderDanhMuc.ascx.cs" Inherits="UserControl_SliderDanhMuc" %>

<div class="hot-post-slider">
    <div id="owl-hot-post" class="owl-carousel owl-theme">
        <asp:Repeater ID="RepeaterDanhMucTinTuc" runat="server">
            <ItemTemplate>
                <div class="owl-item">
                    <div class="item">
                        <div class="item-slider-hot-post clearfix">
                            <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                <img src="<%#Eval("avartar") %>" alt="" class="img-responsive"></a>
                            <div class="item-slider-info">
                                <a href="<%#Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                    <h2><%#Eval("tieude") %></h2>
                                </a>
                                <span class="date-time-news"><i class="fa fa-clock-o"></i><%#Eval("ngaydang") %></span>
                                <p><%#Eval("gioithieu") %></p>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
