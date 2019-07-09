<%@ Page ValidateRequest="false" Title="" EnableViewState="false" Language="C#" MasterPageFile="~/MT_Client.master" AutoEventWireup="true" CodeFile="VanBan.aspx.cs" Inherits="SourceClient_VanBan" %>

<%@ Register Src="~/UserControl/URLMENU.ascx" TagName="URLMENU" TagPrefix="urlmenu" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        table.dataTable thead .sorting {
            background-image: none !important;
        }

        table.dataTable thead > tr > th {
            padding-right: 0px;
            padding-left: 0px;
        }

            table.dataTable thead > tr > th:first-child {
                border-right: solid 1px #ffffff;
            }

            table.dataTable thead > tr > th:last-child {
                border-left: solid 1px #ffffff;
            }

        table.dataTable tbody > tr > td {
            font-size: 16px;
        }
    </style>
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
                        <div class="content-left-vb col-sm-3">
                            <div id="menuvanban"></div>
                            <div>
                                <div id="L1" class="l"></div>
                                <div id="L2" class="l"></div>
                                <div id="L3" class="l"></div>
                            </div>
                        </div>

                        <div class="content-right-vb col-sm-9">
                            <div class="content-right-vb-top clearfix">
                                <h2><b>Tìm văn bản</b> </h2>
                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Nội Dung</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="noidungvb" onkeydown="if (event.keyCode == 13) {timkiemvanban(); return false}" placeholder="Nội Dung Tìm Kiếm" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Cơ quan ban hành</label>
                                        <div class="col-sm-8">
                                            <select class="form-control" id="DropDownListCoQuanBanHanh">
                                            </select>
                                        </div>


                                        <%-- <div class="col-sm-8">
                                            <asp:DropDownList CssClass="form-control" ID="DropDownListCoQuanBanHanh" runat="server" DataSourceID="SqlDataSourceCoQuanBanHanh" DataTextField="tendanhmuc" DataValueField="id_danhmuc" AppendDataBoundItems="True">
                                                <asp:ListItem Text="Tất cả" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceCoQuanBanHanh" runat="server" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [Menu_Client] WHERE (([idParent] = @idParent) AND ([trangthai] = @trangthai))">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="85" Name="idParent" Type="Int32"></asp:Parameter>
                                                    <asp:Parameter DefaultValue="1" Name="trangthai" Type="Int32"></asp:Parameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>--%>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Lĩnh Vực</label>
                                        <div class="col-sm-8">
                                            <select class="form-control" id="DropDownListLinhvuc">
                                            </select>
                                        </div>
                                        <%-- <div class="col-sm-8">
                                            <asp:DropDownList CssClass="form-control" ID="DropDownListLinhvuc" runat="server" DataSourceID="SqlDataSourceLinhVuc" DataTextField="tendanhmuc" DataValueField="id_danhmuc" AppendDataBoundItems="True">
                                                <asp:ListItem Text="Tất cả" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSourceLinhVuc" runat="server" ConnectionString='<%$ ConnectionStrings:DataC50ConnectionString %>' SelectCommand="SELECT * FROM [Menu_Client] WHERE (([trangthai] = @trangthai) AND ([idParent] = @idParent))">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="1" Name="trangthai" Type="Int32"></asp:Parameter>
                                                    <asp:Parameter DefaultValue="86" Name="idParent" Type="Int32"></asp:Parameter>
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>--%>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3  control-label">Năm ban hành</label>
                                        <div class="col-sm-8">
                                            <select class="form-control" id="dropyear">
                                                <option value="chonnam">Chọn năm</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-3 col-sm-10 ">
                                            <button type="button" class="btn btn-default form-sm" id="btnTimKiem">Tìm Kiếm</button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="content-right-vb-bottom" id="danhsachvanban">
                            </div>
                            <div>
                                <div id="C1" class="c"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <script type="text/javascript">
        var year = new Date($.now()).getFullYear();
        var check = 1900;
        for (i = year; i > check ; i--) {
            $('#dropyear').append('<option value="' + i + '">' + i + '</option>');
        }
    </script>
    <script type="text/javascript">
        var page = 'pagevanban';
    </script>
</asp:Content>

