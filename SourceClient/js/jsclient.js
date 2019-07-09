var rt = [];

//if (window.location.protocol == "http:")
//    window.location.protocol = "https:";
//if (window.location.port != "")
//    window.location.port = "";

function valND(noidungtinbao) {
    var mk = /^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀẾưăạảấầẩẫậắằẳẵặẹẻẽềềếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-\s.,?!:;&@()-=+]{2,500}$/;
    return mk.test(noidungtinbao);
}
function reloadcapcha() {
    $('#layerClick2').attr("src", "/ThuMucGoc/AnhDaiDien/icon-ajax-loader1.png");
    setTimeout(function () {
        $("#Captcha").attr({ src: '/SourceClient/ashx/Captcha.ashx?t=' + new Date().getTime() });
        $('#layerClick2').attr({ src: "/ThuMucGoc/AnhDaiDien/icon-refresh.png" });
    }, 500);
}
function reloadcapchaguicauhoi() {
    $('#layerClickQues').attr("src", "/ThuMucGoc/AnhDaiDien/icon-ajax-loader1.png");
    setTimeout(function () {
        $("#CaptchaQues").attr({ src: '/SourceClient/ashx/Captcha.ashx?t=' + new Date().getTime() });
        $('#layerClickQues').attr({ src: "/ThuMucGoc/AnhDaiDien/icon-refresh.png" });
    }, 500);
}
function GetThongTin(id, obj) {
    var checkkytu = true;
    $('#lblErrThamdo').text("");
    $('.lblKQ').text("");
    $('#txtCapcha').val('');
    var bbt = $(obj).parent().find("input, textarea");
    rt = [];
    $.each(bbt, function (key, val) {
        if (val.type == "radio") {
            if (val.checked) {
                rt.push(val.value);
            }
        }
        if (val.type == "checkbox") {

            if (val.checked)
                rt.push(val.value);
        }
        if (val.type == "textarea") {
            rt.push(val.value);
            var giatri = val.value;
            if (!valND(giatri)) {
                checkkytu = false;
                swal(
                        'Thông báo',
                        'Nội dung không chứa ký tự đặc biệt và từ 1-2000 ký tự !',
                        'error'
                    )
            }
        }
    });
    $("#Captcha").attr({ src: '/SourceClient/ashx/Captcha.ashx?t=' + new Date().getTime() });
    if (rt == "") {
        swal(
               'Thông báo',
               'Bạn chưa chọn câu trả lời !',
               'error'
             )
    } else {
        if (checkkytu == true) {
            setTimeout(function () {
                $('#ModalFolder').modal('show');
                $('#btnsubmittraloi').unbind("click");
                $('#btnsubmittraloi').click(function () {

                    var captcha = $('#txtCapcha').val();
                    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'chechCaptchaformthamdo', id: id, captcha: captcha, listDA: JSON.stringify(rt) }, function (data) {
                        if (data.check) {
                            $('.lblKQ').text(data.msg);
                            $('#lblErrThamdo').text("");
                            $('#ModalFolder').modal('hide');
                            //format
                            $.each(bbt, function (key, val) {
                                if (val.type == "radio") {
                                    val.checked = false;
                                }
                                if (val.type == "checkbox") {
                                    val.checked = false;
                                }
                                if (val.type == "textarea") {
                                    val.value = "";
                                }
                            });

                            // show kết quả khảo sát
                            $('#bodyKQ').empty();
                            $('#bodyKQ').append('<h3>' + data.msg + '</h3>');
                            $('#bodyKQ').append('<h3>Câu hỏi : ' + data.thongtincauhoi.cauhoi + '</h3>');
                            if (data.thongtincauhoi.id_hinhthuctraloi == 3) {
                                $('#bodyKQ').append('<label>Có tất cả ' + data.thongtincauhoi.tongsocautraloi + ' câu trả lời</label>');
                            } else {
                                $.each(data.thongtincauhoi.danhsachdapan, function (k, val) {
                                    $('#bodyKQ').append('<label>' + val.noidungtraloi + '</label> ---- <label>' + val.demcautraloi + ' Câu trả lời</label> </br>')

                                });
                            }

                            $('#ModalKQ').modal('show');

                        } else {
                            if (data.msg == "Bạn đã trả lời câu hỏi này rồi") {
                                $('#ModalFolder').modal('hide');
                                $('#bodyKQ').empty();
                                $('#bodyKQ').append('<h3>' + data.msg + '</h3>');
                                $('#bodyKQ').append('<h3>Câu hỏi : ' + data.thongtincauhoi.cauhoi + '</h3>');
                                if (data.thongtincauhoi.id_hinhthuctraloi == 3) {
                                    $('#bodyKQ').append('<label>Có tất cả ' + data.thongtincauhoi.tongsocautraloi + ' câu trả lời</label>');
                                } else {
                                    $.each(data.thongtincauhoi.danhsachdapan, function (k, val) {
                                        $('#bodyKQ').append('<label>' + val.noidungtraloi + '</label> ---- <label>' + val.demcautraloi + ' Câu trả lời</label> </br>')

                                    });
                                }
                                $('#ModalKQ').modal('show');
                            } else {
                                $('#lblErrThamdo').text(data.msg);
                                $("#Captcha").attr({ src: '/SourceClient/ashx/Captcha.ashx?t=' + new Date().getTime() });
                            }
                        }
                    });
                });
            }, 230);
        }
    }
}
function XemThongKe(id, obj) {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'XemThongKeDapAnCauHoi', id: id }, function (data) {
        if (data.thongtincauhoi != null) {

            // show kết quả khảo sát
            $('#bodyKQ').empty();
            $('#bodyKQ').append('<h3>Câu hỏi : ' + data.thongtincauhoi.cauhoi + '</h3>');
            if (data.thongtincauhoi.id_hinhthuctraloi == 3) {
                $('#bodyKQ').append('<label>Có tất cả ' + data.thongtincauhoi.tongsocautraloi + ' câu trả lời</label>');
            } else {
                $.each(data.thongtincauhoi.danhsachdapan, function (k, val) {
                    $('#bodyKQ').append('<label>' + val.noidungtraloi + '</label> ---- <label>' + val.demcautraloi + ' Câu trả lời</label> </br>')
                });
            }
            $('#ModalKQ').modal('show');

        } else {
            $('#bodyKQ').empty();
            $('#bodyKQ').append('<h3>Không có thống kê !</h3>');
        }
    });
}

var link = window.location.origin;

$('#frmToGiac').attr('href', link + "/to-giac");
//$('#frmDuongDayNong').attr('href', link + "/tinh-huong-khan-cap/duong-day-nong");
$('#frmDuongDayNong').attr('href', "tel: 0692321154");
$('#frmVanBan').attr('href', link + "/van-ban");
$('#frmThongKe').attr('href', link + "/bieu-do-thong-ke");
$('#TTURL').attr('href', link);
$('#URLDetail').attr('href', link);

var linkweb = window.location.origin;

$('#menutrangchu').attr("href", linkweb);
$('#menusodoweb').attr("href", linkweb + "/so-do-web");
$('#menulienhe').attr("href", linkweb + "/lien-he");
$('#menudangnhap').attr("href", linkweb);
// tim kiem google
$('#btnSearchMobile').click(function () {

    var pathname = window.location.origin;
    var tukhoa = $('#txtsearchMobile').val();
    if (tukhoa == "") {
        tukhoa = "";
    }
    window.location = pathname + "/tim-kiem" + "?q=" + tukhoa;
});

// tim kiem google
$('#btnSearch').click(function () {

    var pathname = window.location.origin;
    var tukhoa = $('#txtSearchall').val();
    if (tukhoa == "") {
        tukhoa = "a";
    }
    window.location = pathname + "/tim-kiem" + "?q=" + tukhoa;
});


var pathname = window.location.origin;
$('.diachilink').attr("href", pathname);
var $ul = $('.sub-menu-mobi li');
var a = $ul.parent();
var b = a.parent();
$.each(b, function (key, value) {
    $(this).addClass('has-sub');
    $(this).find("a:first").append('<i class="i-down fa fa-caret-down"></i>');
});




//LOAD QUẢNG CÁO

$(document).ready(function () {
    function initADS() {

    }
    var left = [];
    document.querySelectorAll(".l").forEach(function (v, i) {
        left.push(v.id);
    });
    var right = [];
    document.querySelectorAll(".r").forEach(function (v, i) {
        right.push(v.id);
    });
    var center = [];
    document.querySelectorAll(".c").forEach(function (v, i) {
        center.push(v.id);
    });
    var bottom = [];
    document.querySelectorAll(".b").forEach(function (v, i) {
        bottom.push(v.id);
    });
    var data = {
        type: "loadADS",
        left: left,
        right: right,
        center: center,
        bottom: bottom
    }
    jsonPost(data).then(function (json) {
        $.each(json, function (i, v) {
            $.each(v, function (index, val) {
                $('#' + val.name).append('<a href="' + val.linkquangcao + '" target="_blank"><img src="' + val.manguon + '"/></a>');
                $('#' + val.name).append('<button id="' + val.name + index + '" title="Đóng" type="button" onclick="onClickbutton(this)";><i class="fa fa-times"></i></button>');
            });
        });

    });

});



function jsonPost(data) {
    return new Promise(function (resolve, reject) {
        var frm = new FormData();
        Object.keys(data).map(function (key, index) {
            frm.append(key, data[key]);
        });

        var xhr = new XMLHttpRequest();
        xhr.onload = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var result = JSON.parse(xhr.response);
                resolve(result);
            }
            else {
                reject(Error(xhr.statusText));
            }
        };
        xhr.onerror = function () {
            reject(Error("Lỗi mạng"));
        };
        xhr.open("POST", "/SourceClient/ashx/Clientxuly.ashx", true);
        xhr.setRequestHeader("Cache-Control", "no-cache");
        xhr.send(frm);
    });
}


function onClickbutton(aa) {
    var parent = $('#' + aa.id).parent().remove();
}

