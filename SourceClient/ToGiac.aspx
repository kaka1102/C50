<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="ToGiac.aspx.cs" Inherits="SourceClient_ToGiac" %>


<%@ Register Src="~/UserControl/FormBoxWebsite.ascx" TagName="FormBoxWebsite" TagPrefix="uc2" %>
<%@ Register Src="~/UserControl/ThoiTietGiaVang.ascx" TagName="ThoiTietGiaVang" TagPrefix="thoitietgiavang" %>
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
                           <div id="C2" class="c"></div>
                        <div class="content-detail-lib">
                            <p>
                                Khi thông báo hoặc tố giác tội phạm, đề nghị bạn cung cấp các thông tin về thời gian (ngày, giờ), 
                                        địa điểm, nội dung tin báo, tố giác; mô tả chi tiết đối tượng (nếu có thể); thông tin về những 
                                        người chứng kiến (nếu có thể). Những nội dung thông tin không phù hợp sẽ tự động bị hủy bỏ.
                            </p>
                            <p>
                                Thông tin về người báo tin không bắt buộc phải cung cấp. Nếu người báo tin cung cấp thông tin cá nhân; 
                                        các thông tin này sẽ được giữ bí mật và đảm bảo chỉ sử dụng vào mục đích phòng chống tội phạm của 
                                        lực lượng cảnh sát.
                            </p>
                            <p>Cảm ơn sự hợp tác của bạn!</p>
                            <br />
                            <br />
                            <div class="form-horizontal bg-info" style="padding: 20px">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Họ và tên</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="" id="hoten" />
                                        <label id="lblErrhoten"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Email</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="" id="email" />
                                        <label id="lblErremail"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Điện thoại</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="" id="dienthoai" />
                                        <label id="lblErrsdt"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Địa chỉ người gửi</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="" id="diachi" />
                                        <label id="lblErrdiachi"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Tiêu đề (*)</label>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" placeholder="" id="tieude" />
                                        <label id="lblErrtieude"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Chuyên mục (*)</label>
                                    <div class="col-md-5">
                                        <asp:DropDownList CssClass="form-control" ID="DropDownListChuyenmuc" runat="server" DataSourceID="SqlDataSourceLoadChuyenMuc" DataTextField="tenchuyenmuc" DataValueField="id_chuyenmuc" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Chọn" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <label id="lblErrchuyenmuc"></label>
                                    </div>
                                </div>
                                <asp:SqlDataSource ID="SqlDataSourceLoadChuyenMuc" runat="server" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [tbl_ChuyenMucLuaChon] WHERE (([id_danhmuc] = @id_danhmuc) AND ([trangthai] = @trangthai))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="11" Name="id_danhmuc" Type="Int32"></asp:Parameter>
                                        <asp:Parameter DefaultValue="true" Name="trangthai" Type="Boolean"></asp:Parameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Địa bàn (*)</label>
                                    <div class="col-md-5">
                                        <select class="form-control" id="diaban">
                                            <option value="2347703">Bến Tre</option>
                                            <option value="2347704">Cao Bằng</option>
                                            <option value="2347707">Hải Phòng</option>
                                            <option value="2347708">Lai Châu</option>
                                            <option value="2347709">Lâm Đồng</option>
                                            <option value="2347710">Long An</option>
                                            <option value="2347711">Quảng Nam</option>
                                            <option value="2347712">Quảng Ninh</option>
                                            <option value="2347713">Sơn La</option>
                                            <option value="2347714">Tây Ninh</option>
                                            <option value="2347715">Thanh Hóa</option>
                                            <option value="2347716">Thái Bình</option>
                                            <option value="2347717">Tiền Giang</option>
                                            <option value="2347718">Lạng Sơn</option>
                                            <option value="2347719">An Giang</option>
                                            <option value="2347720">Đắc Nông</option>
                                            <option value="2347721">Đồng Nai</option>
                                            <option value="2347722">Đồng Tháp</option>
                                            <option value="2347723">Kiên Giang</option>
                                            <option value="2347727" selected="selected">Hà Nội</option>
                                            <option value="2347728">TP.Hồ Chí Minh</option>
                                            <option value="2347729">Bà Rịa - Vũng Tầu</option>
                                            <option value="2347730">Bình Định</option>
                                            <option value="2347731">Bình Thuận</option>
                                            <option value="2347732">Cần Thơ</option>
                                            <option value="2347733">Gia Lại</option>
                                            <option value="2347734">Hà Giang</option>
                                            <option value="2347735">Hà Tây</option>
                                            <option value="2347736">Hà Tĩnh</option>
                                            <option value="2347737">Hòa Bình</option>
                                            <option value="2347738">Khánh Hòa</option>
                                            <option value="2347740">Lào Cai</option>
                                            <option value="2347741">Hà Nam</option>
                                            <option value="2347742">Nghệ An</option>
                                            <option value="2347743">Ninh Bình</option>
                                            <option value="2347744">Ninh Thuận</option>
                                            <option value="2347745">Phú Yên</option>
                                            <option value="2347746">Quảng Bình</option>
                                            <option value="2347747">Quảng Trị</option>
                                            <option value="2347748">Sóc Trăng</option>
                                            <option value="2347749">Thừa - Thiên - Hếu</option>
                                            <option value="2347750">Trà Vinh</option>
                                            <option value="2347751">Tuyên Quang</option>
                                            <option value="2347752">Vĩnh Long</option>
                                            <option value="2347753">Yên Bái</option>
                                            <option value="20070076">Kon Tum</option>
                                            <option value="20070077">Quảng Ngãi</option>
                                            <option value="20070078">Bình Dương</option>
                                            <option value="20070079">Hưng Yên</option>
                                            <option value="20070080">Hải Dương</option>
                                            <option value="20070081">Bạc Liêu</option>
                                            <option value="20070082">Cà mau</option>
                                            <option value="20070083">Thái Nguyên</option>
                                            <option value="20070084">Bắc Cạn</option>
                                            <option value="20070085">Đà Nẵng</option>
                                            <option value="20070086">Bình Phước</option>
                                            <option value="20070087">Bắc Giang</option>
                                            <option value="20070088">Bắc Ninh</option>
                                            <option value="20070089">Nam Định</option>
                                            <option value="20070090">Vĩnh Phúc</option>
                                            <option value="20070091">Phú Thọ</option>
                                            <option value="28301718">Điện Biên</option>
                                            <option value="28301719">Đắc Nông</option>
                                            <option value="28301720">Hậu Giang</option>
                                        </select>
                                        <label id="lblErrdiaban"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nội Dung (*)</label>
                                    <div class="col-md-9">
                                        <textarea class="form-control" style="width: 100%" rows="6" id="noidungtinbao"></textarea>
                                        <label id="lblErrnoidung"></label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-offset-3 col-md-9 ">
                                        <button type="button" class="btn btn-default form-sm" id="btnGuithongtintogiac">Gửi</button>
                                        <button type="button" class="btn btn-link" id="btnHuytogiac">Hủy</button>
                                        <label>(*) Dữ liệu phải nhập</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                          <div id="C1" class="c"></div>
                    </div>
                    <div class="right-sidebar col-sm-4">
                        <div id="R1" class="r"></div>
                        <%--SLIDE BOX--%>
                        <uc2:FormBoxWebsite ID="FormBoxWebsiteindex" runat="server" />
                        <%--SLIDE BOX--%>
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
                </div>
                <div id="B1" class="b"></div>
            </div>

        </div>
    </section>
    <script type="text/javascript">
        var page = 'pagetogiac';
    </script>
</asp:Content>


