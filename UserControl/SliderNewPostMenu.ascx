<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SliderNewPostMenu.ascx.cs" Inherits="UserControl_SliderNewPostMenu" %>
<link href="/SourceClient/css/slider-jssor.css" rel="stylesheet" />
<script src="/SourceClient/js/jssor.slider-23.1.5.min.js"></script>

<div class="slider">
    <div id="jssor_1" style="position: relative; margin: 0 auto; top: 0px; left: 0px; width: 732px; height: 352px; overflow: hidden; visibility: hidden; background-color: #000000;">
        <!-- Loading Screen -->
        <div data-u="loading" style="position: absolute; top: 0px; left: 0px; background-color: rgba(0, 0, 0, 0.7);"></div>
        <div data-u="slides" style="cursor: default; position: relative; top: 0px; left: 0px; width: 534px; height: 352px; overflow: hidden;">
         
            <asp:Repeater ID="RepeaterSlider1" runat="server">
                <ItemTemplate>
                    <div class="item-jssor-slider">
                        <a href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                            <img data-u="image" src="<%# Eval("avatar") %>" alt="" class="img-responsive" />
                        </a>
                        <div class="carousel-caption">
                            <a href="<%# Eval("linkbaiviet")+"-"+Eval("id_vitribv")+".html" %>">
                                <p><%# Eval("tieude") %></p>
                            </a>
                            <span>6/6</span>
                        </div>
                        <div data-u="thumb" class="jssor-thumb">
                            <img class="i" src="<%# Eval("avatar") %>" />
                            <div class="t"><%# Eval("tieude") %></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <img data-u="add" src="" title="Jssor Slider" style="display: block; opacity: 0; position: absolute; top: 0; right: 0; width: 16px; height: 16px; z-index: 1000;" />
        </div>
        <!-- Thumbnail Navigator -->
        <div data-u="thumbnavigator" class="jssort11-198-74" style="position: absolute; right: 0px; top: 0px; font-family: Arial, Helvetica, sans-serif; -moz-user-select: none; -webkit-user-select: none; -ms-user-select: none; user-select: none; width: 198px; height: 352px;" data-autocenter="2">
            <!-- Thumbnail Item Skin Begin -->
            <div data-u="slides" style="cursor: default;">
                <div data-u="prototype" class="p">
                    <div data-u="thumbnailtemplate" class="tp"></div>
                </div>
            </div>
            <!-- Thumbnail Item Skin End -->
        </div>
        <!-- Arrow Navigator -->
        <span data-u="arrowleft" class="jssora08l" style="top: 0px; right: 0px; width: 198px; height: 28px;">
            <img src="/SourceClient/img/icon-angle-up.png" />
        </span>
        <span data-u="arrowright" class="jssora08r" style="bottom: 0px; right: 0px; width: 198px; height: 28px;">
            <img src="/SourceClient/img/icon-angle-down.png" />
        </span>
    </div>
</div>
<script type="text/javascript">jssor_1_slider_init();</script>
<script type="text/javascript">

    var span = $('.item-jssor-slider span');
    var a = span.length;
    $.each(span, function (key, value) {
        $(this).text(key + 1 + "/" + a);
    });
</script>
