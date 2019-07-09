<%@ Page ValidateRequest="false" Title=""  EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="KetQuaTimKiem.aspx.cs" Inherits="SourceClient_KetQuaTimKiem" %>

<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /*.gsc-control-cse div {
            height: 35px !important;
        }*/

        .cse .gsc-search-button input.gsc-search-button-v2, input.gsc-search-button-v2 {
            width: 40px !important;
            height: 36px !important;
        }

        .gsib_a {
            padding: 0px !important;
        }

        /*.gcsc-branding {
            display: none !important;
        }

        .gsc-above-wrapper-area-container {
            display: none !important;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">
                        <div id="C1" class="c"></div>
                        <script>
                            (function () {
                                var cx = '006337765584730473638:ytwaauhsxd0';
                                var gcse = document.createElement('script');
                                gcse.type = 'text/javascript';
                                gcse.async = true;
                                gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
                                var s = document.getElementsByTagName('script')[0];


                                s.parentNode.insertBefore(gcse, s);
                                gcse.onload = function () {
                                    setTimeout(function () {
                                        var a = $('input[type=text].gsc-input')[0];
                                        a.onkeydown = function () { if (event.keyCode == 13) { window.location = window.location.origin + '/tim-kiem' + '?q=' + this.value; return false } };
                                        var a = $('.gsc-search-button input[type=image]');
                                        var srcIMG = a[0].src.replace(a[0].src, '/SourceClient/img/icon-search.png');
                                        var cc = a.attr('src', srcIMG);
                                    }, 2000);
                                };
                            })();
                        </script>
                        <gcse:search></gcse:search>
                        <div id="C2" class="c"></div>
                    </div>
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <%--box web--%>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                        <%--box web--%>
                        <div id="R2" class="r"></div>
                        <%--thoi tiet--%>
                        <thoitietgiavang:ThoiTietGiaVang ID="ThoiTietGiaVang1" runat="server" />
                        <%--thoi tiet--%>
                        <div id="R3" class="r"></div>

                        <%--tham do y kien--%>
                        <thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />
                        <%--tham do y kien--%>
                        <div id="R4" class="r"></div>
                        <%--luot truy cap--%>
                        <luottruycap:LuotTruyCap ID="LuotTruyCap1" runat="server" />
                        <%--luot truy cap--%>
                        <div id="R5" class="r"></div>
                        <div id="R6" class="r"></div>
                        <div id="R7" class="r"></div>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <script type="text/javascript">
        var page = 'timkiemgoogle';
    </script>
</asp:Content>

