<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XacMinhLogin.aspx.cs" Inherits="SourceAdmin_module_XacMinhLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
                    <h4>Xác minh tài khoản đăng nhập</h4>
                </div>
                <form runat="server">
                    <div class="md-form-group float-label">
                        <asp:TextBox ID="maxacminh" CssClass="md-input" ToolTip="Nhập mã xác minh vừa được gửi vào mail" placeholder="Nhập mã xác minh" ValidateRequestMode="Enabled" autocomplete="off" runat="server"></asp:TextBox>
                    </div>
                    <div class="md-form-group float-label">
                    <label style="text-align:center;float:left;width:100%;color: brown;">Mã xác minh đã được gửi vào email khi đăng nhập</label>
                    </div>

                    <asp:Button ID="btnLoginadmin"  runat="server" Text="Đồng ý" CssClass="btn primary btn-block p-x-md" OnClick="btnLoginadmin_Click"/>
                </form>

            </div>
            <p class="tt-foot">Cục C50 - Bộ Công An © QTW</p>
        </div>

    </div>
    <script type="text/javascript">
        var page = "xacminhdangnhap";
    </script>
</body>
    
</html>
