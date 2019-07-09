<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="ThuVien-ChiTiet.aspx.cs" Inherits="SourceClient_ThuVien_ChiTiet" %>


<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>
<%@ Register Src="~/UserControl/HotThuVienNganh.ascx" TagName="HotThuVienNganh" TagPrefix="hotthuviennganh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="/SourceClient/navicon/amazingslider-1.css" rel="stylesheet" />
    <style type="text/css">
        .filedk {
            float: right;
            width: 50%;
        }

            .filedk b {
                float: right;
                width: 100%;
            }

                .filedk b a {
                    float: right;
                    width: 100%;
                }


        .nhungplugin {
            padding-bottom: 5px;
            border-bottom: 1px solid #d7d7d7;
            float: left;
            width: 100%;
        }

        .fb_iframe_widget {
            font-size: 1px;
        }

        .nhungplugin img {
            vertical-align: top;
            width: 20px;
            height: 20px;
        }

        #___plusone_1 {
            width: 60px !important;
        }

        #___plusone_0 {
            width: 60px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="fb-root"></div>
    <script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=126451364585101";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>



    <div style="text-align: center; position: absolute">
        <div class="fb-comments" id="buttonfb1" data-width="100%" data-numposts="5"></div>
    </div>
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">
                        <div class="head-content">
                            <ul class="mn-content clearfix">
                                <li><a id="URLDetail">Trang Chủ<i class="fa fa-angle-right"></i></a>
                                </li>
                                <asp:Repeater ID="RepeaterUrlMenuDetail" runat="server">
                                    <ItemTemplate>
                                        <li><%#Eval("ten") %><i class="fa fa-angle-right"> </i></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                        <div class="content-detail-lib">
                            <span class="date-time-news" id="datePost" runat="server"></span>

                            <div class="slider-lib" id="anhthuvien" runat="server">
                                <div id="amazingslider-wrapper-1" style="display: block; position: relative; max-width: 723px; margin: 0px auto -4px;">
                                    <div id="amazingslider-1" style="display: block; position: relative; margin: 0 auto;">
                                        <ul class="amazingslider-slides" style="display: none;">
                                            <asp:Repeater ID="RepeaterSliderThuVienChiTiet" runat="server">
                                                <ItemTemplate>
                                                    <li>
                                                        <%# Eval("loaithuvien").ToString() == "thuvienanh"? "<img class=\"img-responsive\" src='"+Eval("duongdanfile") +"' />":"<video  preload='none' src='"+Eval("duongdanfile")+"'></video>" %>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <h2 id="title" runat="server"></h2>
                            <p id="gioithieu" runat="server">
                            </p>
                            <p id="noidung" runat="server">
                            </p>

                            <p class="auther-post">
                                <b id="tacgia" runat="server"></b>
                            </p>
                            <div class="nhungplugin">
                                <a id="twit2" target="_blank">
                                    <img src="https://simplesharebuttons.com/images/somacro/twitter.png" alt="Twitter" />
                                </a>
                                <%--<div class="g-plusone" data-size="medium" data-annotation="bubble" data-width="0" id="g1"></div>--%>
                                <div class="fb-share-button" id="sharefb1" data-share="true"
                                    data-layout="button_count">
                                </div>
                                <div class="fb-like" id="buttonlikefbtop"
                                    data-layout="button_count"
                                    data-action="like">
                                </div>
                            </div>
                        </div>
                        <div id="C1" class="c"></div>
                        <%--<div class="fb-comments" data-href="https://www.facebook.com/Quantriwebhanoi/?fref=ts" data-width="100%" data-numposts="5"></div>--%>
                        <div id="C2" class="c"></div>
                        <div class="title-catalog title-catalog-bg clearfix">
                            <ul class="cata-item library-list-title kaka">
                                <li class="active"><a id="liLib">THƯ VIỆN</a></li>
                                <li><a id="liImg">HÌNH ẢNH</a></li>
                                <li><a id="liVideo">VIDEO</a></li>
                            </ul>

                            <div class="btn-group btn-sort">
                                <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                    Sắp xếp theo<span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a id="ordername">Tên</a></li>
                                    <li><a id="orderdate">Ngày đăng</a></li>
                                    <li><a id="orderview">Lượt xem</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="library-content">
                            <div class="row">
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
                        <div id="C3" class="c"></div>
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
    <script src="/SourceClient/navicon/amazingslider.js"></script>
    <script src="/SourceClient/navicon/initslider-1.js"></script>
    <script type="text/javascript">
        var page = 'pagethuvienchitiet';
        var path = window.location.pathname;

        //  $('.kaka .active a').css('background-color', 'red');
        var urlParams = new URLSearchParams(window.location.search);

        var QID = urlParams.getAll('id');
        var QAction = urlParams.getAll('action');
        var QTab = "";
        QTab = urlParams.getAll('tab');
        if (QTab == "") {
            QTab = "lib";
        }
        $('#ordername').attr('href', path + "?tab=" + QTab + "&action=order-name");
        $('#orderdate').attr('href', path + "?tab=" + QTab + "&action=order-date");
        $('#orderview').attr('href', path + "?tab=" + QTab + "&action=order-view");


        $('#liLib').attr('href', path + "?tab=lib");
        $('#liImg').attr('href', path + "?tab=img");
        $('#liVideo').attr('href', path + "?tab=video");


        //facebook
        var link = window.location.href;

        $('#sharefb').attr('data-href', link);
        $('#sharefb1').attr('data-href', link);
        $('#buttonlikefbtop').attr('data-href', link);
        $('#buttonlikefb').attr('data-href', link);
        $('#buttonfb1').attr('data-href', link);


        //g+
        //$('div#___plusone_0').css('width', '60px !important')
        //$('#g1').attr('data-href', link);
        //$('#g2').attr('data-href', link);
        //window.___gcfg = { lang: 'vi' };
        //(function () {
        //    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
        //    po.src = 'https://apis.google.com/js/platform.js';
        //    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
        //})();
    </script>
</asp:Content>

