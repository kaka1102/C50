function createmenu() { }
$(function () {
    $("#menuadmin ul").first().removeClass("treeview-menu"), $("#menuadmin ul").first().addClass("sidebar-menu");
    var t = (window.location.pathname, []),
        e = document.querySelector("li.active");
    for (t.push(e) ; e.parentNode && "menuadmin" != e.id;) t.unshift(e.parentNode), e = e.parentNode;
    $.each(t, function (t, e) {
        if ("LI" == e.tagName) {
            $(this).addClass("active");
            var n = $(this).parent().prev().find("i.fa-plus");
            void 0 != n[0] && (n.removeClass("fa-plus"), n.addClass("fa-minus"))
        }
    }), $(".treeview-menu li").click(function () {
        var t = $("#menuadmin li");
        if ($.each(t, function () {
                if ("active" != $(this)[0].className) {
                    var t = $(this).find("i.fa-minus");
                    void 0 != t[0] ? (t.removeClass("fa-minus"), t.addClass("fa-plus")) : (t.removeClass("fa-plus"), t.addClass("fa-minus"))
        }
        }), "" == $(this)[0].className) {
            var e = $(this).find("ul");
            if (void 0 != e[0]) {
                var n = $(this).find("i.fa-plus");
                if (void 0 != n[0]) n.removeClass("fa-plus"), n.addClass("fa-minus");
                else {
                    var a = $(this).find("i.fa-minus");
                    a.removeClass("fa-minus"), a.addClass("fa-plus")
                }
            }
        } else console.log("da active")
    })
}), $(function () {
    $(".select2").select2(), $("#datemask").inputmask("dd/mm/yyyy", {
        placeholder: "dd/mm/yyyy"
    }), $("#datemask2").inputmask("mm/dd/yyyy", {
        placeholder: "mm/dd/yyyy"
    }), $("[data-mask]").inputmask(), $("#reservation").daterangepicker(), $("#reservationtime").daterangepicker({
        timePicker: !0,
        timePickerIncrement: 30,
        format: "MM/DD/YYYY h:mm A"
    }), $("#daterange-btn").daterangepicker({
        ranges: {
            Today: [moment(), moment()],
            Yesterday: [moment().subtract(1, "days"), moment().subtract(1, "days")],
            "Last 7 Days": [moment().subtract(6, "days"), moment()],
            "Last 30 Days": [moment().subtract(29, "days"), moment()],
            "This Month": [moment().startOf("month"), moment().endOf("month")],
            "Last Month": [moment().subtract(1, "month").startOf("month"), moment().subtract(1, "month").endOf("month")]
        },
        startDate: moment().subtract(29, "days"),
        endDate: moment()
    }, function (t, e) {
        $("#daterange-btn span").html(t.format("MMMM D, YYYY") + " - " + e.format("MMMM D, YYYY"))
    }), $("#fullDateStart").datepicker({
        autoclose: !0
    }), $("#fullDateEnd").datepicker({
        autoclose: !0
    }), $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
        checkboxClass: "icheckbox_minimal-blue",
        radioClass: "iradio_minimal-blue"
    }), $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
        checkboxClass: "icheckbox_minimal-red",
        radioClass: "iradio_minimal-red"
    }), $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
        checkboxClass: "icheckbox_flat-green",
        radioClass: "iradio_flat-green"
    }), $(".my-colorpicker1").colorpicker(), $(".my-colorpicker2").colorpicker(), $(".timepicker").timepicker({
        showInputs: !1
    });

    var t = "";
    var protocol = window.location.protocol;
    if (protocol == "http:") {
        t = new WebSocket("ws://" + window.location.host + "/SourceAdmin/ashx/Socket.ashx");
    } else {
        t = new WebSocket("wss://" + window.location.host + "/SourceAdmin/ashx/Socket.ashx");
    }

   // var t = new WebSocket("wss://" + window.location.host + "/SourceAdmin/ashx/Socket.ashx");
    t.onmessage = function (t) {
        var e = JSON.parse(t.data);
        e.newlogin && (swal("Thông báo ", "Tài khoản của bạn được đăng nhập ở một nơi khác", "warning"), $.getJSON("/SourceAdmin/ashx/XuLyAdmin.ashx", {
            type: "logoutadmin"
        }, function (t) {
            t.success ? swal("Thông báo ", t.msg, "success") : swal("Thông báo ", "Có lỗi trong quá trình thao tác", "error")
        })), e.logout && window.location.reload(), e.pageLoad && (window.location.href = window.location.origin + "/admin")
    }
}), $("#btnLogout").click(function () {
    $("#btnLogout").attr("disabled", "true"), swal({
        title: "Thoát khỏi hệ thống",
        text: "Bạn có chắc sẽ thoát khỏi hệ thống không ?",
        type: "question",
        showCancelButton: !0,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Vâng, tôi đồng ý !",
        cancelButtonText: "Không. cảm ơn!"
    }).then(function () {
        setTimeout(function () {
            $.getJSON("/SourceAdmin/ashx/XuLyAdmin.ashx", {
                type: "logoutadmin"
            }, function (t) {
                $("#btnLogout").removeAttr("disabled"), t.success ? window.location.href = window.location.origin + "/admin" : swal("Thông báo ", t.msg, "success")
            })
        }, 1e3)
    }, function (t) {
        "cancel" === t && swal("Hủy bỏ ", "Lệnh thao tác đã bị hủy bỏ ", "info"), $("#btnLogout").removeAttr("disabled")
    })
}), $("#btnProfile").click(function () {
    window.location = window.location.origin + "/thong-tin-ca-nhan"
}), $("#linklogoadmin").attr("href", window.location.origin + "/index-admin");