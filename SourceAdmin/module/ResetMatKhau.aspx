<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeFile="ResetMatKhau.aspx.cs" Inherits="SourceAdmin_module_ResetMatKhau" %>

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
                    <h4>Reset Mật Khẩu  - C50 Bộ Công An</h4>
                </div>
                <form runat="server" action="" id="kakakakak">
                    <div class="md-form-group float-label">
                        <asp:TextBox ID="mkmoi" TextMode="Password" CssClass="md-input" placeholder="Mật khẩu" ValidateRequestMode="Enabled" autocomplete="new-password" runat="server"></asp:TextBox>
                    </div>
                    <div class="md-form-group float-label">
                        <asp:TextBox ID="mkmoi2" TextMode="Password" CssClass="md-input" placeholder="Nhập lại mật khẩu" ValidateRequestMode="Enabled" autocomplete="new-password" runat="server"></asp:TextBox>
                    </div>
                    <asp:Panel ID="pn_capchar" runat="server" Visible="false">
                        <div class="col-sm-12" style="padding-bottom: 20px; top: 0px; left: 0px;">
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
                    <asp:Button ID="btnLoginadmin" runat="server" Text="Đồng ý" CssClass="btn primary btn-block p-x-md" OnClick="btnLoginadmin_Click" ClientIDMode="Static" />

                    <div class="md-form-group float-label">
                        <div class=""><a id="btn_backLogin">Quay về trang login</a></div>
                    </div>
                </form>
            </div>
            <p class="tt-foot">Cục C50 - Bộ Công An © QTW</p>
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
        $('#btn_backLogin').click(function () {
            window.location = window.location.origin + "/admin";
        });
        $("#kakakakak").attr("action", window.location.pathname);

        $('#btnLoginadmin').click(function () {

            $('.loader-parent').removeAttr('style');
        });
        $(document).keydown(function (event) {
            var KeyCodeWinDown = event.keyCode;
            if (KeyCodeWinDown == 13 && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == false) {
                $('#btnLoginadmin').click();
            } else if (KeyCodeWinDown == 13 && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == true) {
                $('.swal2-confirm swal2-styled button').click();
            }
        });
        var page = "";
    </script>
</body>
</html>
