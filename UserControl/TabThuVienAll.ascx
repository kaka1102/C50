<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TabThuVienAll.ascx.cs" Inherits="UserControl_TabThuVienAll" %>

<div class="tab-library">
    <div class="btn-group btn-sort btn-sort-lib">
        <button type="button" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
            Sắp xếp theo<span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu">
            <li><a href="/thu-vien/orderby-name">Tên</a></li>
            <li><a href="/thu-vien/orderby-date">Ngày đăng</a></li>
            <li><a href="/thu-vien/orderby-view">Lượt xem</a></li>
        </ul>
    </div>
    <ul class="nav nav-tabs-lib kaka">
        <li class="active" id="liLib"><a href="/thu-vien">THƯ VIỆN</a></li>
        <li id="liImg"><a href="/thu-vien/hinh-anh">HÌNH ẢNH</a></li>
        <li id="liVideo"><a href="/thu-vien/video">VIDEO</a></li>
    </ul>

    <div class="tab-content responsive tab-content-lib">

        <div class="tab-pane tab-pane-lib active" id="library">
            <div class="library-content">
                <div class="row">
                    <asp:Repeater ID="RepeaterTHUVIENALL" runat="server">
                        <ItemTemplate>
                            <div class="item-library col-sm-4">
                                <div class="item-library-bg clearfix">
                                    <div class="item-library-img">
                                        <a href="<%#Eval("linlthuvien") %>">
                                            <%# Eval("loaithuvien").ToString() == "thuvienanh"? "<img class=\"img-responsive\" src='"+Eval("avatar") +"' />":"<video><source src='"+Eval("avatar")+"' type=\"video/ogg\"></video>" %>
                                    </div>
                                    <div class="item-library-des">
                                        <a href="<%#Eval("linlthuvien") %>">
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
        </div>
    </div>
    <%--  <script type="text/javascript">
        $(document).ready(function () {
            var link = window.location.pathname;
            if (link == "/thu-vien/hinh-anh") {

                $('#liImg').addClass('active');
                $('#liLib').removeClass('active');
                $('#liVideo').removeClass('active');

                $('#library').removeClass('active');
                $('#hinhanh').addClass('active');
                $('#video').removeClass('active');
            } else if (link == "/thu-vien/video") {

                $('#liImg').removeClass('active');
                $('#liLib').removeClass('active');
                $('#liVideo').addClass('active');

                $('#library').removeClass('active');
                $('#hinhanh').removeClass('active');
                $('#video').addClass('active');
            } else {

                $('#liImg').removeClass('active');
                $('#liLib').addClass('active');
                $('#liVideo').removeClass('active');

                $('#library').addClass('active');
                $('#hinhanh').removeClass('active');
                $('#video').removeClass('active');
            }

        });

      
    </script>--%>

    <script>
        var page = 'pagethuvien';
        $(document).ready(function () {


            var kt = $('#pagin-ht').attr("data-kt");

            if (kt == 'true') {
                var base = $("#hdfTypeSubmit").val();
                if (base == 'false') {
                    $("#uSend").hide();
                    $("#date-to-date").hide();
                    $("#searchIn").hide();
                    $("#tim-nang-cao").values = "TÌM ĐƠN GIẢN";
                    $("#hdfTypeSubmit").val('true');
                }
                else {
                    $("#uSend").show();
                    $("#date-to-date").show();
                    $("#searchIn").show();
                    $("#tim-nang-cao").values = "TÌM NÂNG CAO";
                    $("#hdfTypeSubmit").val('false');
                }
            }
            else {
                var base = $("#hdfTypeSubmit").val();
                if (base == 'true') {
                    $("#uSend").hide();
                    $("#date-to-date").hide();
                    $("#searchIn").hide();
                    $("#tim-nang-cao").values = "TÌM ĐƠN GIẢN";
                }
                else {
                    $("#uSend").show();
                    $("#date-to-date").show();
                    $("#searchIn").show();
                    $("#tim-nang-cao").values = "TÌM NÂNG CAO";
                }
            }

            $('.title-catalog-content p img').removeAttr('style');
            $('.title-catalog-content p img').addClass('title-catalog-content p img');
            var d = document.getElementById('pagin-ht').outerHTML;

            d = d.replace(/<span/g, "<li");
            d = d.replace(/<\/span>/g, "</li>");
            d = d.replace("<div>", "<ul>");
            d = d.replace("</div>", "</ul>");
            d = d.replace("<div class=\"example\" id=\"pagin-ht\">", "");
            d = d.replace("<div class=\"pagination pagination-ht\">", "");
            d = d.replace(/<\/div>/g, "");
            //d = d.replace(/-/g, "");
            d = d.replace(/<li style=\"paddingleft:10\">/g, "");
            d = d.replace(/<li style=\"paddingleft:5\">/g, "");

            document.getElementById('pagin-ht').innerHTML = d;

        });
    </script>
</div>
