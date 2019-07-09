<%@ Page ValidateRequest="false" EnableViewState="false" Title="" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="LienHe.aspx.cs" Inherits="SourceClient_LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
    <%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
    <%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
    <%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>

    <style>
        #map_canvas {
            width: 99%;
            height: 463px;
            border: solid 1px #ccc;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">
                        <div id="C1" class="c"></div>
                        <div class="head-content">
                            <ul class="mn-content clearfix">
                                <li><a id="TTURL">Trang Chủ<i class="fa fa-angle-right"></i></a>
                                </li>

                                <li><a href="/lien-he">Liên hệ<i class="fa fa-angle-right"></i></a> </li>

                            </ul>
                        </div>
                        <div class="info-footer">
                            <span class="title_footer">Cục Cảnh sát Phòng, Chống Tội Phạm Sử Dụng Công Nghệ Cao- Bộ Công An</span>
                            <p style="text-align: center">Địa chỉ: Số 47 Phạm Văn Đồng, TP - Hà Nội</p>
                            <p style="text-align: center">Địa chỉ: Số 258 Nguyễn Trãi, Q I - TP - HCM</p>
                            <p style="text-align: center">Email: bbtw@canhsat.vn</p>
                            <p style="text-align: center">Số điện thoại 069.2321154</p>
                        </div>
                        <div id="map_canvas"></div>
                        <div id="C2" class="c"></div>
                    </div>
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <%--box web--%>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                        <%--box web--%>
                        <div id="R2" class="r"></div>
                        <%--thoi tiet--%>
                        <%--<thoitietgiavang:ThoiTietGiaVang ID="ThoiTietGiaVang1" runat="server" />--%>
                        <%--thoi tiet--%>
                        <div id="R3" class="r"></div>

                        <div id="R4" class="r"></div>
                        <%--tham do y kien--%>
                        <%--<thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />--%>
                        <%--tham do y kien--%>
                        <div id="R5" class="r"></div>
                        <%--luot truy cap--%>
                        <luottruycap:LuotTruyCap ID="LuotTruyCap1" runat="server" />
                        <%--luot truy cap--%>
                        <div id="R6" class="r"></div>
                        <div id="R7" class="r"></div>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <script type="text/javascript">
        var page = 'lienhe';
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script>
        function initialize() {
            var myLatlng = new google.maps.LatLng(21.0485867, 105.7777816);
            var myLatlng2 = new google.maps.LatLng(10.7619965, 106.6870217);
            var mapOptions = {
                zoom: 9,
                center: myLatlng,
                bottom: myLatlng2
            };

            var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

            var contentString = "<table><tr><th>Số 47 Phạm Văn Đồng, TP - Hà Nội</th></table>";
            var infowindow = new google.maps.InfoWindow({
                content: contentString
            });
 
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: 'Địa chỉ trụ sở tại Hà Nội'
            });
            var marker2 = new google.maps.Marker({
                position: myLatlng2,
                map: map,
                title: 'Địa chỉ trụ sở tại số 258 Nguyễn Trãi, Q I - TP - HCM'
            });
            infowindow.open(map, marker);
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</asp:Content>

