<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="SourceClient_index" %>

<%@ Register Src="~/UserControl/SliderNewPostMenu.ascx" TagName="SliderNewPostMenu" TagPrefix="uc1" %>
<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/HotTinTucSuKien.ascx" TagName="HotTinTucSuKien" TagPrefix="hottintuc" %>
<%@ Register Src="~/UserControl/HotVanBan.ascx" TagName="HotVanBan" TagPrefix="hotvanban" %>
<%@ Register Src="~/UserControl/HotHopTacQuocTe.ascx" TagName="HotHopTacQuocTe" TagPrefix="hothoptacquocte" %>
<%@ Register Src="~/UserControl/HotGuongDienHinh.ascx" TagName="HotGuongDienHinh" TagPrefix="hotguongdienhinh" %>
<%@ Register Src="~/UserControl/HotCanhBaoNguoiDan.ascx" TagName="HotCanhBaoNguoiDan" TagPrefix="hotcanhbaocongdan" %>
<%--<%@ Register Src="~/UserControl/HotTinBaoCongAn.ascx" TagName="HotTinBaoCongAn" TagPrefix="hottinbaocongan" %>--%>
<%@ Register Src="~/UserControl/HotLienKetWebSite.ascx" TagName="HotLienKetWebSite" TagPrefix="hotlienketwebsite" %>
<%@ Register Src="~/UserControl/HotThuVienNganh.ascx" TagName="HotThuVienNganh" TagPrefix="hotthuviennganh" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row" style="margin-left: -20px; margin-right: -20px;">
                    <div class="left-content col-sm-8">
                        <%--SLIDER--%>
                        <uc1:SliderNewPostMenu ID="SliderNewPostMenuIndex" runat="server" />
                        <%--SLIDER--%>
                        <div id="C1" class="c"></div>
                        <%--/tin tuc su kien/--%>
                        <hottintuc:HotTinTucSuKien ID="HotTinTucSuKien1" runat="server" />
                        <%--/tin tuc su kien/--%>

                        <%--/canh bao cong dan/--%>
                        <hotcanhbaocongdan:HotCanhBaoNguoiDan ID="HotCanhBaoNguoiDan1" runat="server" />
                        <%--/canh bao cong dan/--%>

                        <div id="C2" class="c"></div>
                        <%--van ban--%>
                        <hotvanban:HotVanBan ID="HotVanBan1" runat="server" />
                        <%--van ban--%>
                        <div id="C3" class="c"></div>
                        <%--hop tac quoc te--%>
                        <hothoptacquocte:HotHopTacQuocTe ID="HotHopTacQuocTe1" runat="server" />
                        <%--hop tac quoc te--%>
                        <div id="C4" class="c"></div>
                        <%--guong dien hinh--%>
                        <hotguongdienhinh:HotGuongDienHinh ID="HotGuongDienHinh1" runat="server" />
                        <%--guong dien hinh--%>
                        <div id="C5" class="c"></div>
                        <%--tin bao cong an--%>
                        <%--<hottinbaocongan:HotTinBaoCongAn ID="HotTinBaoCongAn1" runat="server" />--%>
                        <%--tin bao cong an--%>

                        <%--thu vien nganh--%>
                        <hotthuviennganh:HotThuVienNganh ID="HotThuVienNganh1" runat="server" />
                       
                        <%--thu vien nganh--%>
                        <div id="C6" class="c"></div>
                        <div id="C7" class="c"></div>
                    </div>
                    <!-- end left-content-->
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

                <%--lien ket website--%>
                <hotlienketwebsite:HotLienKetWebSite ID="HotLienKetWebSite1" runat="server" />
                <%--lien ket website--%>

                <div id="B1" class="b"></div>
            </div>
        </div>

    </section>

    <script type="text/javascript">
        var page = 'pageindex';
    </script>
</asp:Content>

