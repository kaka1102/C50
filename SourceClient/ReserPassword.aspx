<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReserPassword.aspx.cs" Inherits="SourceClient_ReserPassword" %>

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
   <%-- <div id="divLogin" style="position: absolute; visibility: visible; top: 224px; left: 522.5px;">--%>
        <div class="gt-panel">
            <div class="gt-logo">
              <img src="/ThuMucGoc/AnhDaiDien/iconBCA.png"  style="width:130px;height:95px"/>
            </div>
            <div class="gt-title">
                <h4>Reset Mật Khẩu  - C50 Bộ Công An</h4>
            </div>
            <form>
                <div class="md-form-group float-label">
                    <input type="password" class="md-input" required="" placeholder="Mật khẩu" id="mkmoi" autocomplete="off" />
                </div>
                <div class="md-form-group float-label">
                    <input type="password" class="md-input" id="mkmoi2" placeholder="Nhập lại mật khẩu" required="" />
                </div>
                <button type="button" class="btn primary btn-block p-x-md" id="btnLoginadmin">Đồng ý</button>
            </form>
        </div>
        <p class="tt-foot">Cục C50 - Bộ Công An © QTW</p>
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

