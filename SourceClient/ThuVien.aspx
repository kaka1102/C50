<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="ThuVien.aspx.cs" Inherits="SourceClient_ThuVien" %>


<%@ Register Src="~/UserControl/TabThuVienAll.ascx" TagName="TabThuVienAll" TagPrefix="tabthuvienall" %>
<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>
<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">


                        <%--url menu--%>
                        <urlmenu:URLMENU ID="URLMENU1" runat="server" />
                        <%--url menu--%>

                        <div class="content-left-hd-header">
                            <h2 id="title-search">Tìm kiếm</h2>
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nội Dung</label>
                                    <div class="col-md-9">
                                        <div class="input-group stylish-input-group">
                                            <%--<asp:TextBox CssClass="form-control" ID="noidung" runat="server"></asp:TextBox>--%>
                                              <input type="text" id="noidung" class="form-control" />
                                            <span class="input-group-addon">
                                                   <button id="btnTimKiem" style="background-color:#2c7baf!important" class="btn btn-primary form-sm" onclick="ClientClickValue(); return false;">Tìm kiếm</button>
                                                <%--<asp:Button ID="btnTimKiem" runat="server" Text="Gửi" CssClass="btn btn-primary" OnClick="btnTimKiem_Click" OnClientClick="ClientClickValue(); return false;" />--%>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-library">
                            <div class="btn-group btn-sort btn-sort-lib">
                                <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                    Sắp xếp theo<span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a id="ordername">Tên</a></li>
                                    <li><a id="orderdate">Ngày đăng</a></li>
                                    <li><a id="orderview">Lượt xem</a></li>
                                </ul>
                            </div>
                            <ul class="nav nav-tabs-lib kaka">
                                <li class="active" id="liLib"><a href="/thu-vien">THƯ VIỆN</a></li>
                                <li id="liImg"><a href="/thu-vien/hinh-anh">HÌNH ẢNH</a></li>
                                <li id="liVideo"><a href="/thu-vien/video">VIDEO</a></li>
                            </ul>

                            <div class="tab-content-lib">

                                <div class="tab-pane tab-pane-lib active" id="library">
                                    <div class="library-content">
                                        <div class="row">
                                            <h3 id="thongbaoketqua" runat="server"></h3>
                                            <asp:Repeater ID="RepeaterTHUVIENALL" runat="server">
                                                <ItemTemplate>
                                                    <div class="item-library col-sm-4">
                                                        <div class="item-library-bg clearfix">
                                                            <div class="item-library-img">
                                                                <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html"  %>">
                                                                    <%# Eval("loaithuvien").ToString() == "thuvienanh"? "<img class=\"img-responsive\" src='"+Eval("avatar") +"' />":"<video><source src='"+Eval("avatar")+"' type=\"video/ogg\"></video>" %>
                                                            </div>
                                                            <div class="item-library-des">
                                                                <a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html"  %>">
                                                                    <h3><%#Eval("tieude") %></h3>
                                                                </a>
                                                                <div class="view-date clearfix">
                                                                    <span class="view"><%#Eval("luotxem") %> lượt xem</span>
                                                                    <span class="date-post"><%#Eval("thoigian") %></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                                <div class="example" id="pagin-ht">
                                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                </div>
                            </div>
                        </div>

                        <div id="C1" class="c"></div>
                    </div>
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <%--user control--%>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                        <%--user control--%>
                        <div id="R2" class="r"></div>
                        <div class="widget">
                            <ul class="nav nav-tabs nav-justified responsive nav-tabs-cus">
                                <li class="active"><a href="#home-test-new">ĐƯỢC XEM NHIỀU</a></li>
                                <li><a href="#profile-test-new">MỚI NHẤT</a></li>
                            </ul>

                            <div class="tab-content responsive tab-content-cus">
                                <div class="tab-pane tab-pane-lib tab-pane-cus active" id="home-test-new">
                                    <ul>
                                        <asp:Repeater ID="RepeaterLibNew" runat="server" DataSourceID="SqlDataSourceLibNew">
                                            <ItemTemplate>
                                                <li><a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>"><i class="<%# Eval("loaithuvien").ToString() == "thuvienanh"? "fa fa-camera":"fa fa-youtube-play" %>"></i><%#Eval("tieude") %> </a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource ID="SqlDataSourceLibNew" runat="server" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT top(4) * FROM [tbl_ThuVienClient] WHERE ([trangthaithuvien] = @trangthaithuvien) ORDER BY [luotxem] DESC">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="2" Name="trangthaithuvien" Type="Int32"></asp:Parameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ul>
                                </div>
                                <div class="tab-pane tab-pane-lib tab-pane-cus" id="profile-test-new">
                                    <ul>
                                        <asp:Repeater ID="RepeaterLibView" runat="server" DataSourceID="SqlDataSourceLibView">
                                            <ItemTemplate>
                                                <li><a href="<%#Eval("linlthuvien")+"-"+Eval("id_thuvien")+".html" %>"><i class="<%# Eval("loaithuvien").ToString() == "thuvienanh"? "fa fa-camera":"fa fa-youtube-play" %>"></i><%#Eval("tieude") %> </a></li>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:SqlDataSource ID="SqlDataSourceLibView" runat="server" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT top(4) * FROM [tbl_ThuVienClient] WHERE ([trangthaithuvien] = @trangthaithuvien) ORDER BY [ngayupload] DESC">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="2" Name="trangthaithuvien" Type="Int32"></asp:Parameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div id="R3" class="r"></div>

                        <div id="R4" class="r"></div>
                        <%--tham do y kien--%>
                        <thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />
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
    <script>
        var page = 'pagethuvien';

        var path = window.location.pathname;
        $('#ordername').attr('href', path + "?orderby-name");
        $('#orderdate').attr('href', path + "?orderby-date");
        $('#orderview').attr('href', path + "?orderby-view");
        $(document).ready(function () {

            $('.title-catalog-content p img').removeAttr('style');
            $('.title-catalog-content p img').addClass('title-catalog-content p img');

        });

        function ClientClickValue() {
            var oldURL = window.location.href;
            var NEWURL = oldURL;
            var txtND = $('#noidung').val();

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
        function setdata(idControl, value) {
            $('#' + idControl).val(value);
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
    </script>
</asp:Content>

