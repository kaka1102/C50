<%@ Page ValidateRequest="false" Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="NhomAdmin.aspx.cs" Inherits="SourceAdmin_module_NhomAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #tb_danhsachadmintrongnhom_length {
            display: block !important;
        }

        #tb_thongtinchitietnhomadmin_length {
            display: block !important;
        }

        .box-header {
            text-align: center;
        }

            .box-header h3 {
                color: #ffffff !important;
            }

        .tab-content > .active {
            padding: 30px;
        }

        .box-header {
            padding: 20px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs" id="ulmenu">
                        <li class="active" id="lidanhsach"><a href="#danhsachnhomadmin" data-toggle="tab" aria-expanded="false"><i class="fa  fa-list-ul iconTab"></i>Danh sách nhóm quản lý</a></li>
                        <li class="" id="liaddnew"><a href="#themmoinhomadmin" data-toggle="tab" aria-expanded="false"><i class="fa fa-plus iconTab"></i>Thêm mới nhóm</a></li>
                    </ul>
                    <div class="tab-content" id="frmnoidung">
                        <div class="tab-pane active box-body" id="danhsachnhomadmin">
                        </div>
                        <div class="tab-pane " id="themmoinhomadmin">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Tên nhóm<span class="required-admin">*</span></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="tennhom">
                                        <label class="control-label" id="lbl_tennhom"></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Chọn Admin<span class="required-admin">*</span></label>
                                    <div class="col-md-10">
                                        <div class="box box-info">
                                            <div class="box-header"> Mỗi tài khoản chỉ được quản lý một nhóm
                                                <div class="pull-right box-tools">
                                                   
                                                    <button type="button" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="box-body pad" id="chonAdmin">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputName" class="col-sm-2 control-label">Chọn Menu<span class="required-admin">*</span></label>
                                    <div class="col-md-10">
                                        <div class="box box-info">
                                            <div class="box-header">
                                                <div class="pull-right box-tools">
                                                    <button type="button" class="btn btn-info btn-sm" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="box-body pad" id="chonMenu">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-5">
                                        <button type="button" class="btn btn-block btn-primary btn-flat IconButtonPage" id="btnThemmoi"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>
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
        var page = 'nhomadmin';
    </script>
</asp:Content>

