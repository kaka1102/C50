var curentPage = 0;
function validateHoTen(tendaydu) {
    var mk = /^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀẾưăạảấầẩẫậắằẳẵặẹẻẽềềếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-\s]{0,50}$/;
    return mk.test(tendaydu);
}
function validateTaikhoan(taikhoan) {
    var ten = /^[a-zA-Z0-9\s]{4,30}$/;
    return ten.test(taikhoan);
}
function validateMKadmin(matkhau) {
    var ten = /^(([^<>()\[\]\\.,;:\s"]+(\.[^<>()\[\]\\.,;:\s"]+)*)|(".+")){4,30}$/;
    return ten.test(matkhau);
}
function validateDiaChi(diachi) {
    var mk = /^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀẾưăạảấầẩẫậắằẳẵặẹẻẽềềếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-\s.,]{1,100}$/;
    return mk.test(diachi);
}
function validatePhone(sdt) {
    var phoneNumberPattern = /^(01[0123456789]|09)[0-9]{8}$/;
    return phoneNumberPattern.test(sdt);
}
function isEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
function validateND(noidungtinbao) {
    var mk = /^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀẾưăạảấầẩẫậắằẳẵặẹẻẽềềếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-\s.,?!:;&@()-=+]{1,2000}$/;
    return mk.test(noidungtinbao);
}

function validateNDTKVB(noidungtinbao) {
    var mk = /^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀẾưăạảấầẩẫậắằẳẵặẹẻẽềềếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ-\s.,?!:;&@()-=+]{0,100}$/;
    return mk.test(noidungtinbao);
}


$(function () {
    if (page != undefined) {
        switch (page) {
            case 'pagegioithieu':
                initpagegioithieu();
                break;
            case 'pagevanban':
                initpagevanban();
                break;
            case 'pagetogiac':
                initpagetogiac();
                break;
            case 'bieudothongketoipham':
                initbieudothongketoipham();
                break;
            case 'sodoweb':
                initsodoweb();
                break;
            case 'pagetinhhuongkhancap':
                initpagetinhhuongkhancap();
                break;

        }
    }
});

// TINH HUỐNG KHẤN CẤP

function initpagetinhhuongkhancap() {
    //  loadalltinhhuongkhancp();
};

function loadalltinhhuongkhancp() {
    //$.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadalltinhhuongkhancap' }, function (data) {
    //    console.log(data);

    //    if(data.data!=null){
    //        var total;
    // if (data.total % 8 == 0)
    //{
    //    total = total / 8;
    //}
    //else
    //{
    //    total = (total / 8) + 1;
    //}
    //var pageHTML = "";
    //var url = "";

    //if (!string.IsNullOrEmpty(noidung))
    //{
    //    url = url + @"&nd=" + noidung + "";
    //}
    //url = url + "&status=true";

    //// phân trang

    //pageHTML = new returnHTMLPage().outputHTMLPage(total, currPage, url);

    //txtTenTimkiem.Text = noidung;

    //noidungPage.InnerHtml = pageHTML;
    //int pageTr = 0;
    //int pageS = 0;
    //if (currPage == 1)
    //{
    //    pageTr = 1;
    //}
    //else
    //{
    //    pageTr = currPage - 1;
    //}
    //if (currPage == total)
    //{
    //    pageS = total;
    //}
    //else
    //{
    //    pageS = currPage + 1;
    //}
    //pageDau.Attributes.Add("onclick", "window.location = '" + path + "?page=1" + url + "';");
    //pageCuoi.Attributes.Add("onclick", "window.location = '" + path + "?page=" + total + "" + url + "';");
    //pageTruoc.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageTr + "" + url + "';");
    //pageSau.Attributes.Add("onclick", "window.location = '" + path + "?page=" + pageS + "" + url + "';");
    //}
    //else {
    //    $('#ulPage').css("style", "display:none");
    //    $('#thongbaoketqua').text("Không có kết quả !");
    //    $('#noidungPage').empty();
    //   // ulPage.Attributes.Add("style", "display:none");
    ////    var pageHTML = "";
    ////    noidungPage.InnerHtml = pageHTML;
    ////    Repeater4.Visible = false;
    //    //thongbaoketqua.InnerText = "Không có kết quả !";
    //}
    //   });
}



// SƠ ĐỒ WEB

function initsodoweb() {
    LoadSoDoWeb();

};
function detectmob() {
    if (window.innerWidth <= 800 && window.innerHeight <= 600) {
        return true;
    } else {
        return false;
    }
}
function LoadSoDoWeb() {
    var $menuthumuc = $('#dragTree');
    var link = window.location.href;
    var check = detectmob();
    $menuthumuc.jstree({
        'core': {
            'data': {
                'url': function (node) {
                    return node.id === '#' ? '/SourceClient/ashx/Clientxuly.ashx?type=loadsodoweb&id_tm=0' : '/SourceClient/ashx/Clientxuly.ashx?type=loadsodoweb&id_tm=' + node.id;
                },
                'data': function (node) {
                    return {
                        'id': node.id,
                        types: {
                            'default': {
                                'icon': node.icon,
                            },
                        },
                    };
                },
            },
            'themes': {
                'responsive': true,
            },
        },
    })
         .bind("loaded.jstree", function (event, data) {
             $(this).jstree("open_all");
         })
    .bind("dblclick.jstree", function (data) {
        if (check == false) {
            window.location = data.target.href;
        }
    })
    .bind("click.jstree", function (data) {
        if (check == true) {
            window.location = data.target.href;
        }
    });



}

// BIỂU ĐỒ THỐNG KÊ TỘI PHẠM

function initbieudothongketoipham() {
    loadbieudo();
    loadbieudotheohinhthucphamtoi();
};

function loadbieudo() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadallbieudotrongtrang' }, function (data) {
        $.each(data.data, function (index, val) {
            $('#formbieudo').append('<div style="width: 100%; height: 500px;padding-bottom:20px">\
                                        <canvas id="bieudo'+ index + '" width="800" height="450"></canvas>\
                                    </div>');
            new Chart(document.getElementById("bieudo" + index), {
                type: val.Typebieudo,
                data: {
                    labels: val.DataY,
                    datasets: [
                      {
                          label: "Số vụ",
                          backgroundColor: val.ListColor,
                          data: val.DataX,
                          //   fill: false
                      }
                    ]
                },
                options: {
                    legend: { display: false },
                    title: {
                        display: true,
                        text: val.Tenbieudo
                    }
                }
            });
        });
    });
}


function loadbieudotheohinhthucphamtoi() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadbieudotheohinhthucphamtoi' }, function (data) {
        $.each(data.data, function (index, val) {
            if (val.IdDonviTG == 3) {
                $('#thongketheohinhthucphamtoi').append('<div style="width: 100%; height: 500px;padding-bottom:20px">\
                                        <canvas id="bieudohinhthuc'+ index + '" width="800" height="450"></canvas>\
                                    </div>');
                new Chart(document.getElementById("bieudohinhthuc" + index), {
                    type: 'bar',
                    data: {
                        labels: val.DataY,
                        datasets: [
                          {
                              label: val.ListTheoQuy[0].Hinhthucphamtoi,
                              backgroundColor: val.ListTheoQuy[0].ListColor[0],
                              data: val.ListTheoQuy[0].DataX
                          }, {
                              label: val.ListTheoQuy[1].Hinhthucphamtoi,
                              backgroundColor: val.ListTheoQuy[1].ListColor[0],
                              data: val.ListTheoQuy[1].DataX
                          }, {
                              label: val.ListTheoQuy[2].Hinhthucphamtoi,
                              backgroundColor: val.ListTheoQuy[2].ListColor[0],
                              data: val.ListTheoQuy[2].DataX
                          }
                          , {
                              label: val.ListTheoQuy[3].Hinhthucphamtoi,
                              backgroundColor: val.ListTheoQuy[3].ListColor[0],
                              data: val.ListTheoQuy[3].DataX
                          }
                          , {
                              label: val.ListTheoQuy[4].Hinhthucphamtoi,
                              backgroundColor: val.ListTheoQuy[4].ListColor[0],
                              data: val.ListTheoQuy[4].DataX
                          }
                        ]
                    },
                    options: {
                        title: {
                            display: true,
                            text: val.Tenbieudo
                        }
                    }
                });
            } else {
                $('#thongketheohinhthucphamtoi').append('<div style="width: 100%; height: 500px;padding-bottom:20px">\
                                        <canvas id="bieudohinhthuc'+ index + '" width="800" height="450"></canvas>\
                                    </div>');
                new Chart(document.getElementById("bieudohinhthuc" + index), {
                    type: val.Typebieudo,
                    data: {
                        labels: val.DataY,
                        datasets: [
                          {
                              label: "Số vụ",
                              backgroundColor: val.ListColor,
                              data: val.DataX,
                              //  fill: false
                          }
                        ]
                    },
                    options: {
                        title: {
                            display: true,
                            text: val.Tenbieudo
                        }
                    }
                });

            }

        });
    });
}

//TỐ GIÁC TỘI PHẠM
function initpagetogiac() {
    guithongtintogiactoipham();
};

function guithongtintogiactoipham() {

    $('#btnGuithongtintogiac').click(function () {

        var check = true;
        var hoten = $('#hoten').val();
        var email = $('#email').val();
        var dienthoai = $('#dienthoai').val();
        var diachi = $('#diachi').val();
        var tieude = $('#tieude').val();
        var noidungtinbao = $('#noidungtinbao').val();
        var id_chuyenmuc = $('#ContentPlaceHolder1_DropDownListChuyenmuc').val();
        var diaban = $("#diaban option:selected").text();


        if (hoten != "" && !validateHoTen(hoten)) {
            $('#lblErrhoten').text("Họ tên không chứa các ký tự đặc biệt và từ 5-50 ký tự");
            return check == false;
        }
        else {
            $('#lblErrhoten').text("");
        }

        if (email != "" && !isEmail(email)) {
            $('#lblErremail').text("Email bạn nhập không đúng định dạng");
            return check == false;
        }
        else {
            $('#lblErremail').text("");
        }

        if (dienthoai != "" && !validatePhone(dienthoai)) {
            $('#lblErrsdt').text("Số điện thoại không đúng định dạng");
            return check == false;
        }
        else {
            $('#lblErrsdt').text("");
        }

        if (diachi != "" && !validateDiaChi(diachi)) {
            $('#lblErrdiachi').text("Địa chỉ không chứa ký tự đặc biệt và nhỏ hơn 100 ký tự");
            return check == false;
        }
        else {
            $('#lblErrdiachi').text("");
        }

        if (!validateDiaChi(tieude)) {
            $('#lblErrtieude').text("Tiêu đề không chứa ký tự đặc biệt và từ 1-100 ký tự");
            return check == false;
        }
        else {
            $('#lblErrtieude').text("");
        }
        if (id_chuyenmuc == 0 || id_chuyenmuc == "") {
            $('#lblErrchuyenmuc').text("Mời bạn chọn chuyên mục");
            return check == false;
        }
        else {
            $('#lblErrchuyenmuc').text("");
        }

        if (diaban != "" && !validateDiaChi(diaban)) {
            $('#lblErrdiaban').text("Địa bàn không chứa ký tự đặc biệt và nhỏ hơn 100 ký tự");
            return check == false;
        }
        else {
            $('#lblErrdiaban').text("");
        }
        if (!validateND(noidungtinbao)) {
            $('#lblErrnoidung').text("Nội dung không chứa ký tự đặc biệt và từ 1-2000 ký tự");
            return check == false;
        }
        else {
            $('#lblErrnoidung').text("");
        }
        if (check == true) {
            var thongtin = {
                hoten: hoten,
                email: email,
                dienthoai: dienthoai,
                diachi: diachi,
                tieude: tieude,
                noidungtinbao: noidungtinbao,
                id_chuyenmuc: id_chuyenmuc,
                diaban: diaban
            }
            $('.btnGuithongtintogiac').attr('disabled', 'true');
            swal({
                title: 'Gửi thông tin',
                text: "Bạn có chắc sẽ gửi thông tin này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'guithongtintogiac', thongtin: JSON.stringify(thongtin) }, function (data) {
                    if (data.sucess == true) {

                        $('#hoten').val("");
                        $('#email').val("");
                        $('#dienthoai').val("");
                        $('#diachi').val("");
                        $('#tieude').val("");
                        $('#noidungtinbao').val("");
                        $('#ContentPlaceHolder1_DropDownListChuyenmuc').val(0);
                        $("#diaban").val("2347727");
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh gửi đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.btnGuithongtintogiac').removeAttr('disabled');
            });
        }
    });

    $('#btnHuytogiac').click(function () {
        $('#hoten').val("");
        $('#email').val("");
        $('#dienthoai').val("");
        $('#diachi').val("");
        $('#tieude').val("");
        $('#noidungtinbao').val("");
        $('#ContentPlaceHolder1_DropDownListChuyenmuc').val(0);
        $("#diaban").val("2347727");
    });
}

// TRANG VĂN BẢN

function initpagevanban() {
    loadmenutrangvanban();
    loaddanhsachvanban();
    loaddanhsachcoquanbanhanh();
    loaddanhsachlinhvuc();
    $(document).ready(function () {
        $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadvanbantheodanhmucluachon' }, function (data) {
            var $card_content = $('#danhsachvanban');
            if (curentPage == 0) {
                $card_content.empty();
                $table = $('<table />', {
                    class: 'table table-bordered cell-border table-hover',
                    id: 'tb_danhsachvanban',
                    html: '<thead>\
                                    <tr class="bg-primary">\
                                        <th style="width: 20%;text-align: center">SỐ/KÍ HIỆU</th>\
                                        <th style="text-align: center">TÊN VĂN BẢN</th>\
                                        <th style="width: 20%;text-align: center">NGÀY BAN HÀNH</th>\
                                    </tr></thead><tbody></tbody>\
                                    <tfoot></tfoot>'
                }).appendTo($card_content);

                $('#tb_danhsachvanban').DataTable({
                    data: data.danhsach,
                    "columns": [
                            {
                                data: "sokyhieu",
                            },
                            {
                                data: "dsvb",
                                mRender: function (data) {
                                    if (data.tenvanban.length > 200) {
                                        data = "<a href='" + data.linkvanban + "-" + data.id_vanban + ".html'>" + data.tenvanban.substring(0, 200) + "</a>";
                                    } else {
                                        data = "<a href='" + data.linkvanban + "-" + data.id_vanban + ".html'>" + data.tenvanban + "</a>";
                                    }
                                    return data;
                                }
                            },
                            {
                                data: "ngay",
                            },
                    ],
                    "pagingType": "full_numbers",
                    initComplete: function (settings, json) {
                    },
                });
                $('#tb_danhsachvanban').parent().addClass('box-body table-responsive');
            }
        });
    });
}


function loaddanhsachlinhvuc() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loaddanhsachlinhvuc' }, function (data) {
        if (data.data != null) {
            $('#DropDownListLinhvuc').append("<option value='0'>----Tất cả----</option>");
            $.each(data.data, function (i, v) {
                $('#DropDownListLinhvuc').append("<option value='" + v.id_danhmuc + "'>" + v.tendanhmuc + "</option>");
            });
        }
    });
}

function loaddanhsachcoquanbanhanh() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loaddanhsachcoquanbanhanh' }, function (data) {
        if (data.data != null) {
            $('#DropDownListCoQuanBanHanh').append("<option value='0'>----Tất cả----</option>");
            $.each(data.data, function (i, v) {
                $('#DropDownListCoQuanBanHanh').append("<option value='" + v.id_danhmuc + "'>" + v.tendanhmuc + "</option>");
            });
        }
    });
}
function loaddanhsachvanban() {
    var $card_content = $('#danhsachvanban');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered cell-border table-hover',
            id: 'tb_danhsachvanban',
            html: '<thead>\
                        <tr class="bg-primary">\
                            <th style="width: 23%;text-align: center">SỐ/KÍ HIỆU</th>\
                            <th style="text-align: center">TÊN VĂN BẢN</th>\
                            <th style="width: 20%;text-align: center">NGÀY BAN HÀNH</th>\
                        </tr></thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);

        var table = $table.DataTable({
            ajax: '/SourceClient/ashx/Clientxuly.ashx?type=loaddanhsachvanban',
            "columns": [
                    {
                        data: "sokyhieu",
                    },
                    {
                        data: "ds",
                        mRender: function (data) {
                            if (data.tenvanban.length > 200) {
                                data = "<a href='" + data.linkvanban + "-" + data.id_vanban + ".html'>" + data.tenvanban.substring(0, 200) + "</a>";
                            } else {
                                data = "<a href='" + data.linkvanban + "-" + data.id_vanban + ".html'>" + data.tenvanban + "</a>";
                            }
                            return data;
                        }
                    },
                    {
                        data: "ngaybanhanh",
                    },
            ],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },

        });

        $('#tb_danhsachvanban').parent().addClass('box-body table-responsive');
        $('#btnTimKiem').click(function () {
            timkiemvanban();
        });
    }

}
function timkiemvanban() {
    var noidung = $('#noidungvb').val();
    //var coquanbanhanh = $('#ContentPlaceHolder1_DropDownListCoQuanBanHanh').val();
    //var linhvuc = $('#ContentPlaceHolder1_DropDownListLinhvuc').val();
    var coquanbanhanh = $('#DropDownListCoQuanBanHanh').val();
    var linhvuc = $('#DropDownListLinhvuc').val();
    var nambanhanh = $('#dropyear').val();
    if (!validateNDTKVB(noidung)) {
        common.showNotification('top', 'right', 'Nội dung tìm kiếm không hợp lệ !');
    } else {
        $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'timkiemvanban', noidung: noidung, coquanbanhanh: coquanbanhanh, linhvuc: linhvuc, nambanhanh: nambanhanh }, function (data) {

            var $card_content = $('#danhsachvanban');
            if (curentPage == 0) {
                $card_content.empty();
                $table = $('<table />', {
                    class: 'table table-bordered cell-border table-hover',
                    id: 'tb_danhsachvanban',
                    html: '<thead>\
                                    <tr class="bg-primary">\
                                        <th style="width: 20%;text-align: center">SỐ/KÍ HIỆU</th>\
                                        <th style="text-align: center">TÊN VĂN BẢN</th>\
                                        <th style="width: 20%;text-align: center">NGÀY BAN HÀNH</th>\
                                    </tr></thead><tbody></tbody>\
                                    <tfoot></tfoot>'
                }).appendTo($card_content);

                $('#tb_danhsachvanban').DataTable({
                    data: data.data,
                    "columns": [
                            {
                                data: "sokyhieu",
                            },
                             {
                                 data: "ds",
                                 mRender: function (data) {
                                     if (data.tenvanban.length > 200) {
                                         data = "<a href='" + data.linkvanban + "?id=" + data.id_vanban + "'>" + data.tenvanban.substring(0, 200) + "</a>";
                                     } else {
                                         data = "<a href='" + data.linkvanban + "?id=" + data.id_vanban + "'>" + data.tenvanban + "</a>";
                                     }
                                     return data;
                                 }
                             },
                            {
                                data: "ngaybanhanh",
                            },
                    ],
                    initComplete: function (settings, json) {
                    },
                });
            }
        });
    }
}
function loadmenutrangvanban() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadmenutrangvanban' }, function (data) {
        var giatri = data.danhsach[0].danhsach;

        if (giatri.length > 0) {
            $.each(giatri, function (key, value) {
                $('#menuvanban').append('<div class="content-left-vb-text">\
                                            <h2>'+ value.tendanhmuc + '</h2>\
                                        </div>\
                                        <div class="content-left-vb-menu" id="menucon">\
                                        </div>');
                if (value.danhsach.length > 0) {
                    var parent = $('#menucon');
                    taomenutrangvanban(value.danhsach).appendTo(parent);
                }
            });
        }

        var aa = $('#menucon ul li ul li i');
        $.each(aa, function (key, value) {
            $(this).addClass('fa fa-plus');
        });


    });
}

function taomenutrangvanban(danhsach) {
    var $ul = $('<ul/>');
    $.each(danhsach, function (key, value) {
        var $li = $('<li><a href="' + value.duongdan + '"><i class=""></i>' + value.tendanhmuc + '</a></li>').appendTo($ul);
        if (value.danhsach.length > 0) {
            taomenutrangvanban(value.danhsach).appendTo($li);
        }
        return $li;
    });
    return $ul;
}
//TRANG GIỚI THIỆU

function initpagegioithieu() {
    loaddanhsachsodo();

}
function loaddanhsachsodo() {
    $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'loadsodolanhdao' }, function (data) {
        if (data.danhsach == null) {
            $('#sodocanbo').empty();
            $('#sodocanbo').append('<h3>Không có sơ đồ cán bộ lãnh đạo </h3>');
        } else {
            if (window.location.pathname == "/gioi-thieu/lanh-dao-cuc") {
                var $ul = $('#sodocanbo');
                $ul.append('<div class="ten-cap-bac">\
                                    <h2>' + data.danhsach.tenchucvu + '</h2>\
                                </div>');

                $.each(data.danhsach.thongtincanbo, function (key, value) {
                    $('#sodocanbo').append('<li style="width: 100%">\
                                                    <div class="border-ld">\
                                                        ' + value.quanham + '\
                                                        <div class="img-ld">\
                                                            <a href=""><img src="' + value.anhdaidien + '" class="img-responsive" alt="" /></a>\
                                                        </div>\
                                                        <div class="info-ld">\
                                                            <a href=""><h3>'+ value.tencanbo + '</h3></a>\
                                                            <p>Sinh ngày: ' + value.ngaysinh + '</p>\
                                                        </div>\
                                                    </div>\
                                           </li>');
                });
                if (data.danhsach.danhsach.length > 0) {
                    taosodo(data.danhsach.danhsach);
                }
            }
        }
    });
}
function taosodo(danhsach) {
    var $ul = $('#sodocanbo li:first');
    if (danhsach[0].danhsach.length > 0 && danhsach[0].thongtincanbo.length >= 1) {
        $ul.append('<ul class="clearfix">\
                        <div class="ten-cap-bac">\
                            <h2>' + danhsach[0].tenchucvu + '</h2>\
                        </div>\
                    </ul>');
    }

    $.each(danhsach[0].thongtincanbo, function (vt, giatri) {
        $('#sodocanbo ul:last ').append('<li>\
                                            <div class="border-ld">\
                                                ' + giatri.quanham + '\
                                                <div class="img-ld">\
                                                    <a href=""><img src="' + giatri.anhdaidien + '" class="img-responsive" alt="" /></a>\
                                                </div>\
                                                <div class="info-ld">\
                                                    <a href=""><h3>' + giatri.tencanbo + '</h3></a>\
                                                    <p>Sinh ngày: ' + giatri.ngaysinh + '</p>\
                                                </div>\
                                                </div>\
                                        </li>');
    });

    if (danhsach[0].danhsach.length > 0 && danhsach[0].thongtincanbo.length >= 1) {
        taosodo(danhsach[0].danhsach);
    }
}

