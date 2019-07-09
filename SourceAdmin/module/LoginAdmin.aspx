<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="LoginAdmin.aspx.cs" Inherits="SourceAdmin_module_Login12" %>

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
    <style>
        .body-login {
            width: 100%;
            height: auto;
            float: left;
        }

        .loader-parent {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: rgba(166, 187, 145, 0.45);
            opacity: 0.5;
            text-align: center;
            display: inline-block;
            z-index: 99999;
        }

        .loader {
            border: 10px solid #f3f3f3;
            border-radius: 50%;
            border-top: 10px solid blue;
            border-right: 10px solid green;
            border-bottom: 10px solid red;
            border-left: 10px solid pink;
            width: 70px;
            height: 70px;
            -webkit-animation: spin 2s linear infinite;
            animation: spin 2s linear infinite;
            display: inline-block;
            margin-top: 20%;
        }

        @-webkit-keyframes spin {
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body style="position: relative;">
    <div class="body-login">
        <div class="loader-parent" id="loaddingpage" style="display: none" runat="server">
            <div class="loader"></div>
        </div>
        <div id="divLogin" class="col-md-4 col-md-offset-4" style="padding-top: 50px">
            <div class="gt-panel">
                <div class="gt-logo">
                    <img src="/ThuMucGoc/AnhDaiDien/logoc50.png" />
                </div>
                <div class="gt-title">
                    <h4>Quản lý hệ thống - C50 Bộ Công An</h4>
                </div>
                <form runat="server" action="">
                    <div class="md-form-group float-label">
                        <asp:TextBox ID="username" CssClass="md-input" placeholder="Tài khoản" ValidateRequestMode="Enabled" autocomplete="off" runat="server"></asp:TextBox>
                    </div>
                    <div class="md-form-group float-label">
                        <asp:TextBox ID="password" TextMode="Password" CssClass="md-input" placeholder="Mật khẩu" ValidateRequestMode="Enabled" autocomplete="new-password" runat="server"></asp:TextBox>
                    </div>

                    <asp:Panel ID="pn_capchar" runat="server" Visible="false">
                        <div class="col-sm-12" style="padding-bottom: 20px;">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="row">
                                        <asp:TextBox ID="txtCapcha" MaxLength="5" Width="100px" runat="server"></asp:TextBox>
                                        <label id="lblErrThamdo"></label>
                                    </div>
                                </div>
                                <div class="ccRaovat col-sm-8" style="background-color: White; display: inline-block;">
                                    <div class="row">
                                        <img id="Captcha" src="/SourceAdmin/ashx/captchalogin.ashx" alt="Captcha" border="0" width="128" height="31" />
                                        <img id="layerClick2" title="Click đây để tải hình mới!" width="45" height="45" src="/ThuMucGoc/AnhDaiDien/icon-refresh.png"
                                            style="border-width: 0px; display: inline-block; margin-bottom: -16px; margin-left: 10px;" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Button ID="btnLoginadmin" runat="server" Text="Đăng nhập" CssClass="btn primary btn-block p-x-md" OnClick="btnLoginadmin_Click" />
                    <div class="md-form-group float-label">
                        <div class=""><a id="btn_reset">Quên mật khẩu</a></div>
                    </div>

                </form>

            </div>
            <p class="tt-foot">Cục C50 - Bộ Công An © QTW</p>
        </div>

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
                    <button type="button" class="btn  btn-danger btn-flat pull-left iconthoatModal" id="btnCances" data-dismiss="modal"><i class="fa fa-times iconiModal" aria-hidden="true"></i>Thoát</button>
                    <button type="button" class="btn btn-primary pull-right" id="btnxacthuc"><i class="fa fa-check iconiModal"></i>Xác thực</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $('#layerClick2').click(function () {
            reloadcapcha();
        });
        function reloadcapcha() {
            $('#layerClick2').attr("src", "/ThuMucGoc/AnhDaiDien/icon-ajax-loader1.png");
            setTimeout(function () {
                $("#Captcha").attr({ src: '/SourceAdmin/ashx/captchalogin.ashx?t=' + new Date().getTime() });
                $('#layerClick2').attr({ src: "/ThuMucGoc/AnhDaiDien/icon-refresh.png" });
            }, 500);
        }
        function isEmailAdmin(email) {
            var re = /^(([^<>&#$!()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(email);
        }
        $('#btnLoginadmin').click(function () {
            $('.loader-parent').removeAttr('style');
        });
        $('#btn_reset').click(function () {
            $('#ModalView').modal('show');
            $('#btnxacthuc').unbind('click');
            $('#btnxacthuc').click(function () {
                var check = true;

                var emailcanhan = $('#exampleInputEmail1').val();
                if (emailcanhan == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập email !');
                    return check = false;
                }
                else if (!isEmailAdmin(emailcanhan) && emailcanhan != "") {
                    common.showNotification('top', 'right', 'Email vừa nhập không đúng !');
                    return check = false;
                }
                if (check) {
                    $('#btnxacthuc').attr('disabled', 'true');

                    swal({
                        title: 'Xác thực email',
                        text: "Bạn có chắc đây là email mà bạn đã đăng ký trong hệ thống không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xacthucemailkhiquyenmatkhau', emailcanhan: emailcanhan }, function (thongtinadmin) {
                            if (thongtinadmin.sucess == true) {

                                swal('Thông báo ', thongtinadmin.msg, 'success')
                                $('#btnCances').click();
                            } else {
                                swal('Thông báo ', thongtinadmin.msg, 'error')
                            }
                            $('.loader-parent').css('display', 'none');
                            $('#btnxacthuc').removeAttr('disabled', 'true');
                        });

                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh xác thực đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnxacthuc').removeAttr('disabled', 'true');
                    });
                }
            });

        });

        $(document).keydown(function (event) {
            var KeyCodeWinDown = event.keyCode;
            if (KeyCodeWinDown == 13 && $('#ModalView').hasClass('in') == false && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == false) {
                $('#btnLoginadmin').click();
            } else if (KeyCodeWinDown == 13 && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == true) {
                $('.swal2-confirm swal2-styled button').click();
            }
        });
        if (window.history && window.history.pushState) {

            window.history.pushState('forward', null, './admin');

            $(window).on('popstate', function () {
                window.location.reload();
            });
        }
        var page = "";
    </script>
</body>

</html>

