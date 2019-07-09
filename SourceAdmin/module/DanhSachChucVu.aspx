<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="DanhSachChucVu.aspx.cs" Inherits="SourceAdmin_module_DanhSachChucVu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachchucvu" data-toggle="tab" aria-expanded="false">Danh sách chức vụ</a></li>
                        <li class="" id="liaddnew"><a href="#themmoichucvu" data-toggle="tab" aria-expanded="false">Thêm mới</a></li>
                        <li class="" id="lidetails" style="display: none"><a href="#themmoicanbo" data-toggle="tab" aria-expanded="false">Thông tin chi tiết chức vụ</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachchucvu">
                        </div>
                        <div class="tab-pane " id="themmoichucvu">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tên chức vụ</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tenchucvu">
                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label for="inputEmail" class="col-sm-2 control-label">Chức vụ cấp trên</label>
                                    <div class="col-sm-10">
                                        <select class="form-control" id="chucvu">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10" id="frmButtonCanbo">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var page = 'danhsachchucvu';
    </script>
</asp:Content>

