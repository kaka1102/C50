<%@ Page ValidateRequest="false" EnableViewState="false" MaintainScrollPositionOnPostback="true" Title="" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="HoiDap.aspx.cs" Inherits="SourceClient_HoiDap" %>

<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/GuiCauHoiMoi.ascx" TagName="GuiCauHoiMoi" TagPrefix="guicauhoimoi" %>
<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>

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
                                <h2 id="title-search">Tìm kiếm câu hỏi </h2>
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Nội Dung</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="txtTenTimkiem" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group" id="form-search-question">
                                        <label class="col-md-2 control-label">Lĩnh Vực</label>
                                        <div class="col-md-9">
                                            <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="tenchuyenmuc" DataValueField="id_chuyenmuc" AppendDataBoundItems="True">
                                                <asp:ListItem Text="-- tất cả --" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT id_chuyenmuc, tenchuyenmuc, id_danhmuc, trangthai, linkchuyenmuc FROM tbl_ChuyenMucLuaChon WHERE (id_danhmuc = 12) AND (trangthai = 1)"></asp:SqlDataSource>
                                        </div>
                                    </div>
                                    <div class="form-group" id="uSend" runat="server">
                                        <label class="col-md-2 control-label">Người gửi</label>
                                        <div class="col-md-9">
                                            <asp:TextBox ID="nguoigui" CssClass="form-control" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group" id="datetoSend" runat="server">
                                        <label class="col-md-2 control-label">Từ ngày</label>
                                        <div class="col-md-3">
                                            <div class='input-group date' id='datetimepicker1'>
                                                <asp:TextBox ID="tungay" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-md-3 control-label">Đến ngày</label>
                                        <div class="col-md-3">
                                            <div class='input-group date' id='datetimepicker2'>
                                                <asp:TextBox ID="denngay" CssClass="form-control" ClientIDMode="Static" runat="server"></asp:TextBox>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-offset-3 col-md-9 ">
                                            <asp:Button ID="Button1" runat="server" CssClass="btn btn-default form-sm" Text="Gửi yêu cầu" OnClick="Button1_Click1" OnClientClick="ClientClickValue(); return false;" />
                                            <button type="button" id="tim-nang-cao" class="btn btn-link">TÌM KIẾM NÂNG CAO</button>
                                            <asp:HiddenField ID="hdfTypeSubmit" ClientIDMode="Static" runat="server" Value="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="C1" class="c"></div>
                            <div class="title-catalog clearfix">
                                <h2>DANH SÁCH CÂU HỎI - TRẢ LỜI</h2>
                            </div>
                            <div class="content-left-hd-fa">
                                <div class="content-left-hd-footer">
                                    <h3 id="thongbaoketqua" runat="server"></h3>
                                    <asp:Repeater ID="Repeater4" runat="server">
                                        <ItemTemplate>
                                            <div class="title-catalog-content clearfix">
                                                <div class="title-content-hd">
                                                    <b><i class="fa fa-question-circle"></i><%# Eval("tieudecauhoi") %></b>
                                                </div>

                                                <p>
                                                    <%# Eval("cauhoi") %>
                                                </p>
                                                <span>Gửi Bởi : <%# Eval("tendaydu") %></span>
                                                <a href="<%# Eval("linkcauhoi")+"-"+Eval("id_cauhoitraloi")+".html" %>" class="showmes"><i class="fa fa-quote-left"></i>xem câu trả lời</a>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                            </div>
                            <div class="example" id="pagin-ht">
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                <%--  <ul id="ulPage" runat="server">
                                    <li>
                                        <input id="pageDau" runat="server" type="button" value="Đầu" />&nbsp;
                                        <input id="pageTruoc" runat="server" type="button" value="Trước" />
                                    </li>
                                    <li id="noidungPage" runat="server"></li>

                                    <li>
                                        <input id="pageSau" runat="server" type="button" value="Sau" />
                                        <input id="pageCuoi" runat="server" type="button" value="Cuối" />
                                    </li>

                                </ul>--%>
                            </div>
                            <div id="C2" class="c"></div>
                        </div>

                        <div class="content-right-hd col-md-4 col-sm-4">
                            <div id="R1" class="r"></div>
                            <div class="widget">
                                <div class="content-right-tags">
                                    <div class="title-catalog clearfix">
                                        <h2>DANH MỤC CÂU HỎI</h2>
                                    </div>
                                    <div class="content-right-footer">
                                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataDanhMucCauHoi">
                                            <ItemTemplate>
                                                <button type="button" class="btn btn-success"><%# Eval("tenchuyenmuc") %>  </button>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:SqlDataSource runat="server" ID="SqlDataDanhMucCauHoi" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [tbl_ChuyenMucLuaChon] WHERE ([id_danhmuc] = @id_danhmuc)AND (trangthai = 1)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="id_danhmuc" DefaultValue="12" Name="id_danhmuc" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                            </div>
                            <div id="R2" class="r"></div>
                            <div class="widget">
                                <ul class="nav nav-tabs nav-justified responsive nav-tabs-cus">
                                    <li class="active"><a href="#home-test-new">CÂU HỎI MỚI NHẤT</a></li>
                                    <li><a href="#profile-test-new">CÂU HỎI XEM NHIỀU</a></li>
                                </ul>

                                <div class="tab-content responsive tab-content-cus">
                                    <div class="tab-pane tab-pane-cus active" id="home-test-new">
                                        <ul>
                                            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataCauHoiMoiNhat">
                                                <ItemTemplate>
                                                    <li><a href="<%# Eval("linkcauhoi")+"-"+Eval("id_cauhoitraloi")+".html" %>"><i class="fa fa-caret-right"></i>&nbsp; <%# Eval("tieudecauhoi") %></a></li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlDataCauHoiMoiNhat" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>'
                                                SelectCommand="SELECT top(5) * FROM [tbl_CauhoiTraLoi] WHERE ([trangthai] = @trangthai) ORDER BY [ngayhoi] DESC">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="trangthai" DefaultValue="2" Name="trangthai" Type="Int32"></asp:QueryStringParameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ul>
                                    </div>
                                    <div class="tab-pane tab-pane-cus" id="profile-test-new">
                                        <ul>
                                            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataCauHoiXemNhieu">
                                                <ItemTemplate>
                                                    <li><a href="<%# Eval("linkcauhoi")+"-"+Eval("id_cauhoitraloi")+".html" %>"><i class="fa fa-caret-right"></i>&nbsp; <%# Eval ("tieudecauhoi") %> </a></li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlDataCauHoiXemNhieu" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT top(5) * FROM [tbl_CauhoiTraLoi] ORDER BY [luotxem] DESC"></asp:SqlDataSource>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div id="R3" class="r"></div>
                            <%--gui cau hoi moi--%>
                            <guicauhoimoi:GuiCauHoiMoi ID="GuiCauHoiMoi1" runat="server" />
                            <%--gui cau hoi moi--%>
                            <div id="R4" class="r"></div>
                            <%--tham do y kien--%>
                            <thamdoykien:ThamDoYKien ID="ThamDoYKien1" runat="server" />
                            <%--tham do y kien--%>
                            <div id="R5" class="r"></div>
                            <div id="R6" class="r"></div>
                            <div id="R7" class="r"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>


            function ClientClickValue() {
                var oldURL = window.location.href;
                var NEWURL = oldURL;
                var txtND = $('#ContentPlaceHolder1_txtTenTimkiem').val();
                var txtLV = $('#ContentPlaceHolder1_DropDownList1').val();
                var txtTG = $('#ContentPlaceHolder1_nguoigui').val();
                var txtTN = $('#tungay').val();
                var txtDN = $('#denngay').val();

                if (txtND != "") {
                    NEWURL = replaceQueryParam("nd", txtND, oldURL);
                    oldURL = NEWURL;
                } else {
                    NEWURL = removeQueryParam("nd", '', oldURL);
                    oldURL = NEWURL;
                }
                if (txtLV != 0) {
                    NEWURL = replaceQueryParam("lv", txtLV, oldURL);
                    oldURL = NEWURL;
                }
                else {
                    NEWURL = removeQueryParam("lv", '', oldURL);
                    oldURL = NEWURL;
                }
                if (txtTG != "") {
                    NEWURL = replaceQueryParam("tg", txtTG, oldURL);
                    oldURL = NEWURL;
                }
                else {
                    NEWURL = removeQueryParam("tg", '', oldURL);
                    oldURL = NEWURL;
                }
                if (txtTN != "") {
                    NEWURL = replaceQueryParam("ds", txtTN, oldURL);
                    oldURL = NEWURL;
                }
                else {
                    NEWURL = removeQueryParam("ds", '', oldURL);
                    oldURL = NEWURL;
                }
                if (txtDN != "") {
                    NEWURL = replaceQueryParam("de", txtDN, oldURL);
                    oldURL = NEWURL;
                }
                else {
                    NEWURL = removeQueryParam("de", '', oldURL);
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
    </section>
    <script type="text/javascript">
        var page = 'pagehoidap';
    </script>
</asp:Content>

