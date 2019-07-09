﻿<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="QuanLyHinhThucPhamToi.aspx.cs" Inherits="SourceAdmin_module_QuanLyHinhThucPhamToi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachhinhthucphamtoi" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách hình thức phạm tội</a></li>
                        <li class="" id="liaddnew"><a href="#themmoihinhthucphamtoi" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới</a></li>
                        <li class="" id="liadetails" style="display: none"><a href="#themmoihinhthucphamtoi" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Thông tin chi tiết tiết</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachhinhthucphamtoi">
                        </div>
                        <div class="tab-pane " id="themmoihinhthucphamtoi">
                            <div id="thongtincanhan" class="thongtincanhantoipham" style="padding-top:20px">
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label for="inputName" class="col-sm-4 control-label">Tên hình thức phạm tội <span class="required-admin">*</span></label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control" id="hinhthucphamtoi">
                                            </div>
                                        </div>
                                        <div class="form-group" id="frmtrangthai">
                                            <label for="inputEmail" class="col-sm-4 control-label">Dùng trong thống kê biểu đồ không ?</label>
                                            <div class=" col-sm-8" id="frmTinhTrang">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optionsRadios" value="codung" checked id="codung">Sử dụng trong thống kê vẽ biểu đồ
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="optionsRadios" value="khongdung" id="khongdung">Không sử dụng
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-4 col-sm-8" id="frmButton">
                                            </div>
                                        </div>
                                    </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'quanlyhinhthucphamtoi';
    </script>
</asp:Content>

