<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="TinhHuongKhanCap.aspx.cs" Inherits="SourceClient_TinhHuongKhanCap" %>

<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/GuiCauHoiMoi.ascx" TagName="GuiCauHoiMoi" TagPrefix="guicauhoimoi" %>
<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>
<%@ Register Src="~/UserControl/LienKetWebsite.ascx" TagName="LKWS" TagPrefix="lkws" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="/SourceClient/js/custom-file-input.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section>
        <div class="" id="page-content">
            <div class="container">
                <div class="main-content">

                    <%--url menu--%>
                    <urlmenu:URLMENU ID="URLMENU1" runat="server" />
                    <%--url menu--%>
                    <div class="row">
                        <div class="content-left-hd col-sm-8 ">
                            <div class="content-left-hd-header">
                                <h2 id="title-search">Tìm kiếm </h2>
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Nội Dung</label>
                                        <div class="col-md-7">
                                            <%--<asp:TextBox ID="txtTenTimkiem" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                            <input type="text" id="txtTenTimkiem" class="form-control" />
                                        </div>
                                        <div class="col-md-2">
                                            <button id="Button2" class="btn btn-default form-sm" onclick="ClientClickValue(); return false;">Tìm kiếm</button>
                                            <%--<asp:Button ID="Button2" runat="server" CssClass="btn btn-default form-sm" Text="Tìm kiếm" OnClick="Button1_Click1" OnClientClick="ClientClickValue(); return false;"/>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="title-catalog clearfix">
                                <h2><a id="titleDDN">DANH SÁCH ĐƯỜNG DÂY NÓNG</a></h2>
                            </div>
                            <div class="content-left-hd-fa">
                                <div class="content-left-hd-footer">
                                    <h3 id="thongbaoketqua" runat="server"></h3>
                                    <asp:Repeater ID="Repeater4" runat="server">
                                        <ItemTemplate>
                                            <div class="title-catalog-content clearfix">
                                                <div class="title-content-hd">
                                                    <b><i class="fa fa-plus-circle"></i><%# Eval("tendonvi") %></b>
                                                </div>

                                                <p>
                                                    <%# Eval("mota") %>
                                                </p>

                                                <p>
                                                    Địa Chỉ :   <%# Eval("diachi") %>
                                                </p>

                                                <p>
                                                    Số Điện Thoại : <%# Eval("sodienthoai") %> <a href="tel:<%# Eval("sodienthoai")  %>"><i class="fa fa-phone-square"></i></a>
                                                </p>
                                                <p>
                                                    Email :   <%# Eval("email") %>
                                                </p>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div id="C1" class="c"></div>
                            </div>
                            <div class="example" id="pagin-ht">
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            </div>
                        </div>

                        <div class="content-right-hd col-md-4 col-sm-4">
                            <div id="R1" class="r"></div>
                            <%--SLIDE BOX--%>
                            <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                            <%--SLIDE BOX--%>
                            <div id="R2" class="r"></div>

                            <%--gui cau hoi moi--%>
                            <%--<guicauhoimoi:GuiCauHoiMoi ID="GuiCauHoiMoi1" runat="server" />--%>
                            <%--gui cau hoi moi--%>
                            <div id="R3" class="r"></div>
                            <%--tham do y kien--%>
                            <thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />
                            <%--tham do y kien--%>
                            <div id="R4" class="r"></div>
                            <lkws:LKWS ID="lienketwebsite" runat="server" />
                            <div id="R5" class="r"></div>
                        </div>
                    </div>

                    <div id="B1" class="b"></div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $('#titleDDN').attr('href', window.location.origin + "/tinh-huong-khan-cap/duong-day-nong");

                $('.title-catalog-content p img').removeAttr('style');
                $('.title-catalog-content p img').addClass('title-catalog-content p img');
            });


            function ClientClickValue() {
                
                var oldURL = window.location.href;
                var NEWURL = oldURL;
                var txtND = $('#txtTenTimkiem').val();

                if (txtND != "") {
                    NEWURL = replaceQueryParam("nd", txtND, oldURL);
                    oldURL = NEWURL;
                } else {
                    NEWURL = removeQueryParam("nd", '', oldURL);
                    oldURL = NEWURL;
                }

                var check = NEWURL.indexOf("?");
                if (check == "-1") { //ko co
                    var index = NEWURL.indexOf("&");
                    if (index != "-1") { //có
                        NEWURL = replaceQueryParam("statusAll", "true", oldURL);
                        NEWURL = replaceAt(NEWURL, index, "?");
                    }
                    else {
                        NEWURL = oldURL + "?statusAll=true";
                    }
                } else { //co roi
                    var checkST = NEWURL.indexOf("statusAll=true");
                    if (checkST == "-1") {
                        NEWURL = replaceQueryParam("statusAll", "true", oldURL);
                    } else {
                        NEWURL = oldURL;
                    }
                }
                window.location = NEWURL;
            }
            function removeQueryParam(param, newval, search) {
                var regex = new RegExp("([?;&])" + param + "[^&;]*[;&]?");
                var query = search.replace(regex, "$1").replace(/&$/, '');
                return query;
            }
            function replaceQueryParam(param, newval, search) {
                var regex = new RegExp("([?;&])" + param + "[^&;]*[;&]?");
                var query = search.replace(regex, "$1").replace(/&$/, '');
                return (query.length > 2 ? query + "&" : "?") + (newval ? param + "=" + newval : '');
            }
            function replaceAt(string, index, replace) {
                return string.substring(0, index) + replace + string.substring(index + 1);
            }
            //function ChangeUrl(page, value) {

            //    var url = window.location.search;
            //    var length = url.length;
            //    var index = url.indexOf("&");
            //    var chuoi = url.substring(index, length);
            //    var chuoimoi = value + chuoi;
            //    if (typeof (history.pushState) != "undefined") {

            //        var obj = { Page: page, Url: chuoimoi };
            //        history.pushState(obj, obj.Page, obj.Url);
            //    } else {
            //        alert("Browser does not support HTML5.");
            //    }
            //}
            function ChangeUrl(page, value) {

                var url = window.location.search;
                var link = "";

                var checkGet = value.indexOf("?");
                if (checkGet == 0) {
                    var checkURL = url.indexOf("?");
                    if (checkURL == 0) {
                        url = url.replace("?", "&");
                        var ckPage = url.indexOf("&page=");
                        if (ckPage == 0) {
                            var lst = url.split("&");
                            $.each(lst, function (i, v) {
                                if (v != "") {
                                    if (v.indexOf("page=") == "-1") {
                                        link += "&" + v;
                                    }
                                }
                            })
                        }
                    }
                }

                var length = link.length;
                var index = link.indexOf("&");
                var chuoi = link.substring(index, length);
                var chuoimoi = value + chuoi;

                if (typeof (history.pushState) != "undefined") {

                    var obj = { Page: page, Url: chuoimoi };
                    history.pushState(obj, obj.Page, obj.Url);
                } else {
                    alert("Browser does not support HTML5.");
                }
            }
            function setdata(idControl, value) {
                $('#' + idControl).val(value);
            }
        </script>
    </section>


    <script type="text/javascript">
        var page = 'pagetinhhuongkhancap';
    </script>
</asp:Content>

