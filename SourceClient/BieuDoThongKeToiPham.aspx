<%@ Page ValidateRequest="false" EnableViewState="false" Title="" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="BieuDoThongKeToiPham.aspx.cs" Inherits="SourceClient_BieuDoThongKeToiPham" %>


<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/HotLienKetWebSite.ascx" TagName="HotLienKetWebSite" TagPrefix="hotlienketwebsite" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
<%@ Register Src="~/UserControl/ThamDoYKien.ascx" TagName="ThamDoYKien" TagPrefix="thamdoykien" %>
<%@ Register Src="~/UserControl/LuotTruyCap.ascx" TagName="LuotTruyCap" TagPrefix="luottruycap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <section id="page-content">
        <div class="container">
            <div class="main-content">
                <div class="row">
                    <div class="left-content col-sm-8">
                        <div id="C1" class="c"></div>
                        <div class="col-sm-12" id="formbieudo">
                            <h3 style="text-align: center; font-weight: bold">BIỂU ĐỒ THỐNG KÊ TỘI PHẠM THEO NĂM</h3>
                        </div>
                        <div id="C2" class="c"></div>

                        <div class="col-sm-12" id="thongketheohinhthucphamtoi">
                            <h3 style="text-align: center; font-weight: bold">BIỂU ĐỒ THỐNG KÊ TỘI PHẠM THEO HÌNH THỨC PHẠM TỘI</h3>
                        </div>
                        <div id="C3" class="c"></div>
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

                <%--lien ket website--%>
                <hotlienketwebsite:HotLienKetWebSite ID="HotLienKetWebSite1" runat="server" />
                <%--lien ket website--%>
                <div id="B1" class="b"></div>
            </div>
        </div>

    </section>


    <script type="text/javascript">
        var page = "bieudothongketoipham";
    </script>
</asp:Content>

