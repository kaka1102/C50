$(document).ready(function () {
    $("#owl-linkweb").owlCarousel({
        itemsCustom: [
            [0, 1],
            [320, 1],
            [600, 3],
            [700, 4],
            [1000, 4],
            [1200, 4],
            [1400, 4],
            [1600, 4]
        ],
        pagination: false,
        navigation: false,
        autoPlay: true
    });

    $("#owl-hot-post").owlCarousel({
        itemsCustom: [
            [0, 1],
            [320, 1],
            [600, 1],
            [700, 1],
            [1000, 1],
            [1200, 1],
            [1400, 1],
            [1600, 1]
        ],
        pagination: false,
        navigation: false,
        autoPlay: true
    });

    $("#owl-question").owlCarousel({
        itemsCustom: [
            [0, 1],
            [320, 1],
            [600, 1],
            [700, 1],
            [1000, 1],
            [1200, 1],
            [1400, 1],
            [1600, 1]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        autoPlay: false
    });
    $("#owl-slider-lib").owlCarousel({
        itemsCustom: [
            [0, 1],
            [320, 1],
            [600, 1],
            [700, 1],
            [1000, 1],
            [1200, 1],
            [1400, 1],
            [1600, 1]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"],
        autoPlay: true
    });
});
$(document).ready(function () {
    $('#nav-mobi li.has-sub>a').on('click', function () {
        $(this).removeAttr('href');
        var element = $(this).parent('li');
        if (element.hasClass('open')) {
            element.removeClass('open');
            element.find('li').removeClass('open');
            element.find('ul').slideUp();
        } else {
            element.addClass('open');
            element.children('ul').slideDown();
            element.siblings('li').children('ul').slideUp();
            element.siblings('li').removeClass('open');
            element.siblings('li').find('li').removeClass('open');
            element.siblings('li').find('ul').slideUp();
        }
    });
});
$(document).ready(function () {
    $('ul.nav.nav-tabs  a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });

    (function ($) {
        // Test for making sure event are maintained
        $('.js-alert-test').click(function () {
            alert('Button Clicked: Event was maintained');
        });
        fakewaffle.responsiveTabs(['xs', 'sm']);
    })(jQuery);

});
$(document).ready(function () {
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-17600125-2', 'openam.github.io');
    ga('send', 'pageview');
});

$(document).ready(function () {
    $("#tim-nang-cao").click(function () {
        var base = $("#hdfTypeSubmit").val();
        if (base == 'false') {
            $("#ContentPlaceHolder1_uSend").hide();
            $("#ContentPlaceHolder1_datetoSend").hide();
            $("#searchIn").hide();
            $("#tim-nang-cao").values = "TÌM ĐƠN GIẢN";
            $("#hdfTypeSubmit").val('true');
        }
        else {
            $("#ContentPlaceHolder1_uSend").show();
            $("#ContentPlaceHolder1_datetoSend").show();
            $("#searchIn").show();
            $("#tim-nang-cao").values = "TÌM NÂNG CAO";
            $("#hdfTypeSubmit").val('false');
        }
    });
});

$(document).ready(function () {
    $('#datetimepicker1').datepicker({
        autoclose: true
    });
});



$(document).ready(function () {
    $('#datetimepicker2').datepicker({
        autoclose: true
    });
});
$(document).ready(function () {
    // Hàm active tab nào đó
    function activeTab(obj) {
        // Lấy href của tab để show content tương ứng
        var id = $(obj).find('a').attr('href');

        // Ẩn hết nội dung các tab đang hiển thị
        $('.tab-item').hide();

        // Hiển thị nội dung của tab hiện tại
        $(id).show();
    }

    // Sự kiện click đổi tab
    $('#B li').click(function () {
        activeTab(this);
        return false;
    });

    // Active tab đầu tiên khi trang web được chạy
    activeTab($('#B li:first-child'));
});


//Fixed menu
$(document).ready(function () {
    var stickyHeaderTop = $('#main-menu-page').offset().top;
    $(window).scroll(function () {
        if ($(window).scrollTop() > stickyHeaderTop) {
            $('#main-menu-page').css({ position: 'fixed', top: '0px' });
            $('#main-menu-page').css('display', 'block');
            $('#main-menu-page').addClass('fixed-menu');
        } else {
            $('#main-menu-page').css('position', 'static');
            $('#main-menu-page').removeClass('fixed-menu');
        }
    });
})
//Thư viện tabs
$(document).ready(function () {
    var link = window.location.pathname;
    if (link == "/thu-vien/hinh-anh") {
        $('.kaka li').removeClass('active');
        $('#liImg').addClass('active');
    }
    if (link == "/thu-vien") {
        $('.kaka li').removeClass('active');
        $('#liLib').addClass('active');
    }
    if (link == "/thu-vien/video") {
        $('.kaka li').removeClass('active');
        $('#liVideo').addClass('active');
    }

    $('.kaka li').click(function () {
        $('.kaka li').removeClass('active');
        $(this).addClass('active');

    });

    var link2 = window.location.search;

    if (link2 == "?tab=img" || link2.indexOf('?tab=img') == 0) {
        $('.kaka li').removeClass('active');
        $('#liImg').parent().addClass('active');
    }
    if (link2 == "?tab=lib" || link2.indexOf('?tab=lib') == 0) {
        $('.kaka li').removeClass('active');
        $('#liLib').parent().addClass('active');
    }
    if (link2 == "?tab=video" || link2.indexOf('?tab=video') == 0) {
        $('.kaka li').removeClass('active');
        $('#liVideo').parent().addClass('active');
    }
});
$(document).ready(function () {
    loadthoitiet('2347727');
    // số người online
    var wss = "";
    var protocol = window.location.protocol;
    if (protocol == "http:") {
        wss = new WebSocket('ws://pmeeting.vn/ashx/counter.ashx', "ahihi");
    } else {
        wss = new WebSocket('wss://pmeeting.vn/ashx/counter.ashx', "ahihi");
    }

    wss.onmessage = function (e) {

        var data = JSON.parse(e.data);
        $("#online").text(data.online);
        $('#homqua').text(data.yesterday);
        $("#trongtuan").text(data.week);
        $('#trongthang').text(data.month);
        $("#tongtruycap").text(data.total);

        var dem = JSON.stringify(data.total);
        if (dem != undefined) {
            $('#totalVisit').empty();
            var a = dem.split("");
            length = a.length;
            var b = [];
            if (a.length < 7) {
                var dem = 7 - length;
                for (i = 0; i < dem; i++) {
                    b.push(0);
                }
            }
            $.each(a, function (i, val) {
                b.push(val);
            });
            for (j = 0 ; j < b.length ; j++) {
                $('#totalVisit').append(' <span>' + b[j] + '</span>');
            }
        }
    }
})

function loadthoitiet(tt) {
    $('#listing').empty();
    var xhr = new XMLHttpRequest();
    xhr.open("GET", window.location.origin + "/SourceClient/ashx/thoitiet.ashx?code=" + tt, true);
    xhr.onload = function () {
        if (xhr.status == 200 && xhr.readyState == 4) {
            var data = JSON.parse(xhr.responseText);
            $('#dc').text(data[0].Temperature + "°C");
            $('#humidity').text(data[0].Humidity + "%");
            $('#note').text(data[0].Low + "°C" + " - " + data[0].High + "°C");
            $('#dnote').text(data[0].Status);
            var classimg = getCssByStatus(data[0].Status);
            var oldclass = $('#iconw').attr('data-class');

            $('#iconw').removeClass(oldclass)
            $('#iconw').addClass(classimg);
            $('#iconw').attr('data-class', classimg);


            $('#city').text($("#thoitiet option:selected").text());

            for (i = 1 ; i <= 3 ; i++) {

                var classimg = getCssByStatus(data[i].Status);

                var str = '<li class="last-line">';
                str += '<p class="title">' + data[i].FullDate + '</p>';
                str += '<p class="photo"><span class="ic-weather classimg ' + classimg + '"></span></p>';
                str += '<p class="temp">' + data[i].Low + "°C" + " - " + data[i].High + "°C" + '</p>';
                str += '<p class="note"> ' + data[i].Status + '</p>';
                str += '</li>';
                $("#listing").append(str);
            }
        }
    }
    xhr.send();
}
function getCssByStatus(a) {
    if (/(bão|mưa giông|giông|mưa đá|sấm|sấm chớp)+/.test(a)) {
        return "muato"
    }
    if (/(tuyết|mưa đá|mưa tuyết)+/.test(a)) {
        return "muatuyet"
    }
    if (/(nắng to|nắng)+/.test(a)) {
        return "nang"
    }
    if (/(chiều mưa|tối mưa|sáng mưa|sáng có mưa|mưa phùn|mưa bụi|mưa)+/.test(a)) {
        return "mua"
    }
    return "binhthuong";
}

$('#btnabcabc').click(function () {
    setTimeout(function () {
        $('#ModalFolder').modal('show');
    });
});


