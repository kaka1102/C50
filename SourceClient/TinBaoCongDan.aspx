<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="TinBaoCongDan.aspx.cs" Inherits="SourceClient_TinBaoCongDan" %>

<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
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
                                <h2 id="title-search">Tìm kiếm </h2>
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Nội Dung</label>
                                        <div class="col-md-7">
                                            <asp:TextBox ID="txtTenTimkiem" runat="server" class="form-control"></asp:TextBox>

                                        </div>
                                        <div class="col-md-2">
                                            <asp:Button ID="Button2" runat="server" CssClass="btn btn-default form-sm" Text="Tìm kiếm"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="title-catalog clearfix">
                                <h2>DANH SÁCH TIN BÁO</h2>
                            </div>
                            <div class="content-left-hd-fa">
                                <div class="content-left-hd-footer">

                                    <asp:Repeater ID="RepeaterDANHSACHTINBAOCONGDAN" runat="server">
                                        <ItemTemplate>
                                            <div class="title-catalog-content clearfix">
                                                <div class="title-content-hd">
                                                    <b><i class="fa fa-question-circle"></i><%# Eval("tieude") %></b>
                                                </div>

                                                <p>
                                                    <%# Eval("noidungtinbao") %>
                                                </p>
                                                <span>Gửi Bởi : <%# Eval("hoten") %></span>
                                                <a href="<%# Eval("linktinbao") %>" class="showmes"><i class="fa fa-quote-left"></i>xem câu trả lời</a>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                            </div>
                            <div class="example" id="pagin-ht" data-kt="<%=kt %>">
                               <%-- <cc1:CollectionPager ID="CollectionPager1"
                                    FirstText="Đầu"
                                    BackText="Trước"
                                    LabelText=""
                                    LastText="Cuối"
                                    NextText="Sau"
                                    ShowFirstLast="True"
                                    SliderSize="5" PagingMode="QueryString"
                                    runat="server" BackNextLinkSeparator="" BackNextLocation="Split"
                                    PageNumbersDisplay="Numbers" ResultsLocation="None"
                                    BackNextDisplay="Buttons" ControlCssClass="pagination pagination-ht" PageNumbersSeparator="" OnClick="CollectionPager1_Click" PageSize="3" QueryStringKey="page">
                                </cc1:CollectionPager>--%>
                            </div>
                        </div>

                        <div class="content-right-hd col-md-4 col-sm-4">

                            <%--SLIDE BOX--%>
                            <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                            <%--SLIDE BOX--%>


                            <div class="widget">
                                <div class="content-right-form">

                                    <div class="title-catalog clearfix">
                                        <h2>GỬI CÂU HỎI MỚI</h2>
                                    </div>
                                    <div class="widget-border">
                                        <div>
                                            <p>Lưu ý "<b>Họ Tên</b>" sẽ được dùng để tra cứu câu trả lời  theo tiêu chí "<b>người gửi</b>" trong form tìm kiếm câu hỏi"</p>
                                        </div>

                                        <div class="form-horizontal form-question" id="form-question">
                                            <div class="form-group">
                                                <label class="col-lg-3">Họ Tên<i class="fa-required">*</i></label>
                                                <div class="col-lg-9">
                                                    <input id="hoten" type="text" class="form-control" runat="server" />
                                                </div>
                                                <asp:Label ID="loihoten" runat="server" Text=""></asp:Label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-3">Email<i class="fa-required">*</i></label>
                                                <div class="col-lg-9">
                                                    <asp:TextBox ID="email" type="Email" CssClass="form-control" runat="server"></asp:TextBox>
                                                </div>
                                                <asp:Label ID="loiemail" runat="server" Text=""></asp:Label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-3">Tiêu đề<i class="fa-required">*</i></label>
                                                <div class="col-lg-9">
                                                    <input id="tieude" type="text" class="form-control" runat="server" />
                                                </div>
                                                <asp:Label ID="lrlErrtieude" runat="server" Text=""></asp:Label>

                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-3">Đính kèm</label>
                                                <div class="col-lg-9">
                                                    <asp:FileUpload ID="file" runat="server" CssClass="inputfile inputfile-1" data-multiple-caption="{count} files selected" multiple />
                                                    <%--<input type="file" name="file[]" id="file" runat="server" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" multiple />--%>
                                                    <label for="file">
                                                        <span>Chọn File đính kèm</span>
                                                    </label>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-lg-3">Danh mục<i class="fa-required">*</i></label>
                                                <div class="col-lg-9">
                                                    <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server" DataSourceID="SqlDataChuyenMucHoiDap" DataTextField="tenchuyenmuc" DataValueField="id_chuyenmuc" AppendDataBoundItems="true">
                                                        <asp:ListItem Text="--Chọn--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:Label ID="loichon" runat="server" Text=""></asp:Label>

                                                    <asp:SqlDataSource runat="server" ID="SqlDataChuyenMucHoiDap" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [tbl_ChuyenMucLuaChon] WHERE (([trangthai] = @trangthai) AND ([id_danhmuc] = @id_danhmuc))">
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter QueryStringField="trangthai" DefaultValue="true" Name="trangthai" Type="Boolean"></asp:QueryStringParameter>
                                                            <asp:QueryStringParameter QueryStringField="id_danhmuc" DefaultValue="12" Name="id_danhmuc" Type="Int32"></asp:QueryStringParameter>
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-lg-6">
                                                    <div class="captchar">
                                                        <div class="g-recaptcha" data-sitekey="6LeRxB4UAAAAAJ0sxQ21zuzUWdGs51D8f4MKhHxD" style="transform: scale(1.05); transform-origin: 0 0;">
                                                        </div>

                                                    </div>
                                                    <asp:Label ID="loicaptcha" runat="server" Text="">

                                                    </asp:Label>
                                                </div>
                                            </div>
                                            <div class="">
                                                <label class="">Nội dung câu hỏi<i class="fa-required">*</i></label>
                                                <asp:TextBox TextMode="MultiLine" class="form-control" ID="noidung" Width="100%" MaxLength="10" runat="server" cols="20" Rows="5"></asp:TextBox>
                                                <asp:Label ID="loinoidung" runat="server" Text=""></asp:Label>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-lg-3"></label>
                                                <div class="col-lg-9 text-right">
                                                    <asp:Button ID="gui" runat="server" Text="Gửi" CssClass="btn btn-primary" />
                                                    <button type="reset" class="btn btn-primary">Nhập lại</button>
                                                </div>
                                                <asp:Label ID="loi" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="title-catalog clearfix">
                                <h2>THĂM DÒ Ý KIẾN</h2>
                            </div>
                            <div class="widget-border widget-bg">
                                <h3 class="question"><b>Khi đối tượng đột nhập vào nhà, dùng hung khí khống chế bạn và yêu cầu đưa tài sản thì bạn sẽ:</b></h3>
                                <form>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">
                                            1. Tỏ ra phục tùng, làm theo yêu cầu của đối tượng.
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                            2. Lợi dụng sơ hở của đối tượng chạy vào phòng, chốt khóa trái cửa hoặc bỏ chạy ra khỏi nhà, tri hô và báo Công an
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option3">
                                            3. Giả bị ngất xỉu và để đối tượng lấy tài sản rồi bỏ đi.
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option4">
                                            4. Lợi dụng đối tượng sơ hở, bấm chuông báo động, sử dụng các vật dụng có sẵn tấn công lại đối tượng.
                                        </label>
                                    </div>
                                    <button class="btn-vote" type="submit" name="btnVote">Bình chọn</button>
                                    <button class="btn-view-result" type="submit" name="btnVote">Xem kết quả</button>
                                </form>
                            </div>
                        </div>
                        <!--end widget-->
                    </div>
                </div>
            </div>
        </div>
        <script>
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
    </section>


    <script type="text/javascript">
        var page = 'pagetinbaocongdan';
    </script>
</asp:Content>

