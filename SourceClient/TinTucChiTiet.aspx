<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="TinTucChiTiet.aspx.cs" Inherits="SourceClient_TinTucChiTiet" %>

<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>

<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            padding-bottom: 15px;
            border-bottom: 1px solid #d7d7d7;
            float: left;
            width: 100%;
            margin-top: 15px;
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
        .detail-post-content img{max-width:100% }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="fb-root"></div>



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
                                        <li><a href="<%#Eval("duongdan") %>"><%#Eval("ten") %><i class="fa fa-angle-right"> </i></a></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>

                        <span class="date-time-news" id="datePost" runat="server"></span>

                        <div class="detail-post">
                            <h2 runat="server" id="tieude"></h2>
                        </div>
                        <%--  <div class="nhungplugin" id="formplugin" runat="server">
                            <a id="twit" target="_blank">
                                <img src="https://simplesharebuttons.com/images/somacro/twitter.png" alt="Twitter" />
                            </a>
                            <div class="g-plusone" data-size="medium" data-annotation="bubble" data-width="0" id="g1"></div>
                            <div class="fb-share-button" id="sharefb1" data-share="true"
                                data-layout="button_count">
                            </div>
                            <div class="fb-like" id="buttonlikefbtop"
                                data-layout="button_count"
                                data-action="like">
                            </div>
                        </div>--%>
                        <div class="detail-post-content">
                            <p class="hot-tit">
                                <b runat="server" id="gioithieu"></b>
                            </p>
                            <p runat="server" id="noidung"></p>
                            <p class="auther-post">
                                <b id="tacgia" runat="server"></b>
                                <b class="pull-right" id="filedinhkem" runat="server"></b>
                            </p>
                        </div>
                        <div class="row">
                            <div class="previous-post col-sm-6 col-xs-6" runat="server" id="baitruoc">
                            </div>
                            <div class="next-post col-sm-6 col-xs-6 text-right" runat="server" id="baisau">
                            </div>
                        </div>
                        <div class="nhungplugin" id="formplugin1" runat="server">
                            <a id="twit2" target="_blank">
                                <img src="https://simplesharebuttons.com/images/somacro/twitter.png" alt="Twitter" />
                            </a>
                           <%-- <div class="g-plusone" data-size="medium" data-annotation="bubble" id="g2"></div>--%>
                            <div class="fb-share-button" id="sharefb"
                                data-layout="button_count">
                            </div>
                            <div class="fb-like" id="buttonlikefb"
                                data-layout="button_count"
                                data-action="like">
                            </div>
                        </div>
                        <div id="C3" class="c"></div>
                        <div class="tag-post">
                            <ul class="clearfix" style="margin-bottom: 30px;" id="tagbaiviet" runat="server">
                                <asp:Repeater ID="RepeaterTAG" runat="server">
                                    <ItemTemplate>
                                        <li><a href=""><%#Eval("Tag") %></a></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                        <%--<div class="fb-comments" id="fbcomment" data-width="100%" data-numposts="5"></div>--%>
                        <div id="C2" class="c"></div>
                        <div class="title-catalog clearfix" id="baivietlienquan" runat="server">
                        </div>
                        <div class="link-web">
                            <div id="owl-linkweb" class="owl-carousel owl-theme">
                                <asp:Repeater ID="RepeaterBaiVietLienQuan" runat="server">
                                    <ItemTemplate>
                                        <div class="item">
                                            <div class="item-catalog clearfix">
                                                <a href="<%#Eval("link")+"-"+Eval("id_vitribv")+".html" %>">
                                                    <img src="<%#Eval("avatar") %>" class="img-responsive" /></a>
                                                <a href="<%#Eval("link")+"-"+Eval("id_vitribv")+".html" %>">
                                                    <h3 class="text-justify"><%#Eval("title") %></h3>
                                                </a>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div id="C1" class="c"></div>
                    </div>
                    <!-- end left-content-->
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
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
                    </div>
                    <!--end right-sideber-->
                </div>
                <!--end row-->
            </div>
            <!--end main-->
        </div>
    </section>
    <!--end page-content-->
    <script type="text/javascript">
        var link = window.location.href;

        $('#fbcomment').attr('data-href', link);
        $('#sharefb').attr('data-href', link);
        $('#sharefb1').attr('data-href', link);
        $('#buttonlikefbtop').attr('data-href', link);
        $('#buttonlikefb').attr('data-href', link);
        $('#buttonfb1').attr('data-href', link);

        //twit
        $('#twit').attr('href', "https://twitter.com/share?url=" + link);
        $('#twit2').attr('href', "https://twitter.com/share?url=" + link);
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
        var page = 'pagechitietbaiviettintuc';
    </script>
    <script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=126451364585101";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

</asp:Content>


