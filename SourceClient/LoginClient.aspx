<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="LoginClient.aspx.cs" Inherits="SourceClient_LoginClient" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cục C50-Bộ Công An
    </title>
    <base href="/md_aspx" />
    <link rel="shortcut icon" href="/ThuMucGoc/AnhDaiDien/logoc50.png" type="image/x-icon" />
    <link href="/GiaoDienAdmin/bootstrap/css/login.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/font-awesome.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/style.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/sweetalert2.min.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/longstyle.css" rel="stylesheet" />
    <link href="/GiaoDienAdmin/bootstrap/css/alter.css" rel="stylesheet" />

    <script src="/GiaoDienAdmin/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="/GiaoDienAdmin/bootstrap/js/bootstrap.js"></script>
    <script src="/GiaoDienAdmin/bootstrap/js/sweetalert2.js"></script>
    <script src="/GiaoDienAdmin/bootstrap/js/alter.js"></script>
    <script src="/GiaoDienAdmin/bootstrap/js/commonAlter.js"></script>
</head>
<body>
     <div id="divLogin" class="col-md-4 col-md-offset-4" style="padding-top:50px">
  <%--  <div id="divLogin" style="position: absolute; visibility: visible; top: 224px; left: 522.5px;">--%>
        <div class="gt-panel">
            <div class="gt-logo">
                <img src="/ThuMucGoc/AnhDaiDien/iconBCA.png"  style="width:130px;height:95px"/>
            </div>
            <div class="gt-title">
                <h4>Cổng thông tin - C50 Bộ Công An</h4>
            </div>
            <form>
                <div class="md-form-group float-label">
                    <input type="text" class="md-input" required="" placeholder="Tài khoản" id="tendangnhap" autocomplete="off" />
                </div>
                <div class="md-form-group float-label">
                    <input type="password" class="md-input" id="matkhau" placeholder="Mật khẩu" autocomplete="new-password" required="" />
                </div>


                <button type="button" class="btn primary btn-block p-x-md" id="btnLoginadmin">Đăng nhập</button>
                <div class="md-form-group float-label">
                    <div class="">
                        <a id="btn_reset">Quên mật khẩu</a>
                        <a id="btnCreate" style="float: right">Tạo tài khoản</a>
                    </div>
                </div>

            </form>
        </div>
        <p class="tt-foot">Cục C50 - Bộ Công An © QTW</p>
    </div>

    <div class="modal fade" id="ModalView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" id="">Quên mật khẩu</h4>
                </div>
                <div class="modal-body">
                    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Mời bạn nhập email sử dụng trong hệ thống" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btnxacthuc">Xác thực</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="ModalCreateAccount" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" id="">Tạo tài khoản</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal">
                        <label style="display: none" id="idtaikhoanadmin"></label>
                        <div class="form-group">
                            <label for="" class="col-sm-3 control-label">Tên tài khoản</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="taikhoan" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-3 control-label">Mật khẩu</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="password" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-3 control-label">Họ và tên</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="tendaydu" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-3 control-label">Email</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="diachiemail" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="" class="col-sm-3 control-label">Số điện thoại</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="sodienthoai" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger pull-left" id="btnClear">Nhập lại</button>
                    <button type="button" class="btn btn-primary" id="btnAccount">Đồng ý</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var page = "";
    </script>
 <%--   <script type="text/javascript">
        var divLogin = document.getElementById('divLogin');
        window.addEventListener('resize', function (e) {
            resize(e.target);
        });
        function resize(target) {
            var top = ((target.innerHeight / 2) - (divLogin.offsetHeight / 2));
            var left = ((target.innerWidth / 2) - (divLogin.offsetWidth / 2));
            divLogin.style.top = top + 'px';
            divLogin.style.left = left + 'px';
        }
        resize(window);
    </script>--%>
</body>
</html>

