<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LuotTruyCap.ascx.cs" Inherits="UserControl_LuotTruyCap" %>

<div class="widget">
    <div class="title-catalog clearfix">
        <h2>LƯỢT TRUY CẬP</h2>
    </div>
    <div class="widget-border text-center">

        <div class="total-vistit" id="totalVisit">
        </div>
        <div class="detail-visit">
            <table class="table">
                <tr>
                    <td class="text-left"><i class="fa fa-users"></i>Đang online</td>
                    <td class="text-right" id="online"></td>
                </tr>
                <tr>
                    <td class="text-left"><i class="fa fa-users"></i>Hôm qua</td>
                    <td class="text-right" id="homqua"></td>
                </tr>
                <tr>
                    <td class="text-left"><i class="fa fa-users"></i>Trong tuần</td>
                    <td class="text-right" id="trongtuan"></td>
                </tr>
                <tr>
                    <td class="text-left"><i class="fa fa-users"></i>Trong tháng</td>
                    <td class="text-right" id="trongthang"></td>
                </tr>
                <tr>
                    <td class="text-left"><i class="fa fa-users"></i>Tổng truy cập</td>
                    <td class="text-right" id="tongtruycap"><%= Application["luottruycap"] %></td>
                </tr>
            </table>
        </div>
    </div>
</div>
