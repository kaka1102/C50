var curentPage = 0;
var linkWebC50 = window.location.origin;



/// tim theo gia tri trong list obj  >> tra ve gia tri theo key
Array.prototype.filterObjects = function (key, value) {
    return this.filter(function (x) { return x[key] === value; })
}

function validateAcountAdmin(val) {
    var re = /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{10,16}$/;
    return re.test(val);
}


// bat loi nhap ky tu
function isEmailAdmin(email) {
    var re = /^(([^<>&#$!()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

//function validateMKadmin(matkhau) {
//    var ten = /^(([^<>&#$!()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+")){6,30}$/;
//    return ten.test(matkhau);
//}
function validateMKadmin(matkhau) {
    var ten = /^(([^<>()\[\]\\.,;:\s"]+(\.[^<>()\[\]\\.,;:\s"]+)*)|(".+")){6,30}$/;
    return ten.test(matkhau);
}

function validateTaikhoan(taikhoan) {
    var ten = /^[a-zA-Z0-9\s]{6,30}$/;
    return ten.test(taikhoan);
}

function valTextboxValue(giatri) {
    var mk = /^(([^<>&$#!()\[\]\\"])){1,500}$/;
    return mk.test(giatri);
}

function validateHoTen(tendaydu) {
    var mk = /^(([^<>&#$!()\[\]\\.,;:"])){6,40}$/;
    return mk.test(tendaydu);
}
function validateTime(time) {
    var ten = /^(2[0-3]|[01]?[0-9]):([0-5]?[0-9]):([0-5]?[0-9])$/;
    return ten.test(time);
}
function validateURL(linkwebsite) {
    var urlRegex = /\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i;
    return urlRegex.test(linkwebsite);
}
function validateCMT(socmtnd) {
    var socmt = /^[0-9]{9,12}$/;
    return socmt.test(socmtnd);
}
function validatePhone(sdt) {
    var phoneNumberPattern = /^(01[0123456789]|09)[0-9]{8}$/;
    return phoneNumberPattern.test(sdt);
}
function isEmail(email) {
    var re = /^(([^<>&$#*!()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

// bat loi nhap ky tu
function validateMatkhau(matkhau) {
    var mk = /^.{6,30}$/;
    return mk.test(matkhau);
}



function makeid() {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for (var i = 0; i < 5; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}


var idtrunggian = "";
var $loading = $('<div/>', {
    class: 'loading',
    html: '<div id="nest6"></div>'
}).appendTo('body');
var _idfile = "";
var trangthaiF2 = false, trangthaiRename = false, idRename = null, trangthaidelete = false;
var giatri, giatritimkiem, name, duoi;
var idDanhmucSel, SoChaDanhMuc;
var RootBV = false, RootHopTacQT = false, RootGuongDienHinh = false;
var idDMDefault, iddmGT;
var stringTookenServer;
$(function () {
    if (page != undefined) {
        $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'getTookenByServer' }, function (danhsach) {
            stringTookenServer = "";
            if (danhsach != "") {
                stringTookenServer = danhsach.tooken;
            }
            else {
                stringTookenServer = "tooken fail";
            }
        });
        switch (page) {
            case 'quanlytaikhoan':
                initTaiKhoan();
                break;
            case 'trangchuadmin':
                initQuyenHanAdmin();
                break;
            case 'danhsachcanbo':
                initCanBoLanhDao();
                break;
            case 'lienkethoptac':
                initLienKetHopTac();
                break;
            case 'quanlythumucanh':
                initQuanLyThuMucAnh();
                break;
            case 'quanlythumucvideo':
                initQuanLyThuMucVideo();
                break;
            case 'quanlythumuctailieu':
                initQuanLyThuMucTaiLieu();
                break;
            case 'nhomadmin':
                initNhomAdmin();
                break;
            case 'quanlybanner':
                initBanner();
                break;
            case 'lichhienthibanner':
                initLichHienThiBanner();
                break;
            case 'quanlyquangcao':
                initQuangCao();
                break;
            case 'thongtincanhan':
                initThongtincanhan();
                break;
            case 'menutrongtrang':
                initQuanLyMenuTrongClient();
                break;
            case 'quanlybaiviet':
                initQuanLyBaiViet();
                break;
            case 'quanlyvanban':
                initQuanLyVanBan();
                break;
            case 'quanlygioithieu':
                initQuanLyTrangGioiThieu();
                break;
            case 'quanlyhoptacquocte':
                initQuanLyHopTacQuocTe();
                break;
            case 'quanlyguongdienhinh':
                initQuanLyGuongDienHinh();
                break;
            case 'quanlytinbaocongdan':
                initQuanLyTinBaoCongDan();
                break;
            case 'danhsachcauhoimau':
                initQuanLyCauHoiMau();
                break;
            case 'danhsachcauhoicongdan':
                initQuanLyCauHoiCongDan();
                break;
            case 'quanlyduongdaynong':
                initQuanLyDuongDayNong();
                break;
            case 'quanlyhuongdansulytinhhuong':
                initQuanLyHuongDanXuLyTinhHuong();
                break;
            case 'thuvienanhclient':
                initQuanLyThuVien();
                break;
            case 'danhsachchucvu':
                initDanhSachChucVu();
                break;
            case 'thuvienvideoclient':
                initQuanLyThuVienVideo();
                break;
            case 'thamdoykien':
                initQuanLyThamDoYKien();
                break;
            case 'quanlythongtintoipham':
                initQuanLyThongTinToiPham();
                break;
            case 'quanlyhinhthucphamtoi':
                initQuanLyHinhThucPhamToi();
                break;
            case 'quanlybieudothongke':
                initQuanLyBieuDo();
                break;
            case 'loghethong':
                initLog();
                break;
            case 'dangnhapadmin':
                initdangnhapadmin();
                break;
            case 'resetmatkhau':
                initresetmatkhau();
                break;
            case 'quanlylogowebsite':
                initquanlylogowebsite();
                break;
            case 'quanlylichhienthilogo':
                initquanlylichhienthilogo();
                break;
            case 'chitietloghethong':
                initChiTietLog();
                break;
            case 'danhsachdanhmuccauhoi':
                initdanhsachdanhmuccauhoi();
                break;
            case 'danhsachcanhbaonguoidan':
                initcanhbaonguoidan();
                break;
        }

    }
});



// CẢNH BÁO NGƯỜI DÂN - ok
function initcanhbaonguoidan() {
    curentPage = 0;
    loadimage();
    danhsachdanhmuccanhbaonguoidan();
    loadAlldanhsachbaivietcanhbaonguoidan();
    $('#chosefileavbv').click(function () {
        window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
    });
    $('#liaddnew').click(function () {
        $('#frmbutton').empty();
        $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoibaiviet"><i class="fa fa-plus iconButtonPage"></i>Thêm bài viết</button>');
        if (RootGuongDienHinh == true) {
            var a = $('#danhmucbaiviet').find('div[name="cha"]').remove();
        }
        themoibaivietcanhbaonguoidan();
    });

    $('#lidanhsach').click(function () {
        $('#tb_danhsachbaiviet').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietcanhbaonguoidan&id=0').load();
    });
}


function loadAlldanhsachbaivietcanhbaonguoidan() {
    var $card_content = $('#danhsachbaiviet');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbaiviet',
            html: '<thead>\
                            <th></th>\
                            <th>Tiêu đề</th>\
                            <th>Tác giả</th>\
                            <th>Ngày tạo</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbaiviet').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietcanhbaonguoidan&id=0',
            "columns": [
                  { data: "ngaythang" },
                  {
                      data: "tieude",
                      mRender: function (data) {
                          if (data.length > 40) {
                              data = data.substring(0, 40) + "...";
                          }
                          return data;
                      }
                  },
                  { data: "tacgia" },
                  { data: "ngaytao" },
                  {
                      data: "button", "width": "105px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-list-ul iconButton btnDSDM" aria-hidden="true" rel="tooltip" title="Danh mục hiển thị"></i>\
                                         <i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>';
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietcanhbaonguoidan&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tag.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_baiviet) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietcanhbaonguoidan&id=" + u.item.id_baiviet;
                                settings.id = u.item.id_baiviet;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachbaiviet').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbaiviet').DataTable();
        $('#tb_danhsachbaiviet_length').remove();

        $('#liaddnew').click(function () {
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#rdoLuunhap').css("display", "block");
            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");

            var dscheck = $('#danhmucbaiviet input');
            $.each(dscheck, function (key, val) {
                $(this).prop("disabled", false);
                $(this).prop('checked', false);
            });
            $('#hienthi').prop('checked', true);
            //  themoibaiviet();
        });
        $('#lidanhsach').click(function () {

            $('#lidanhsach').addClass('active');
            $('#danhsachbaiviet').addClass('active');
            $('#lichitiet').removeClass('active');
            $('#lichitiet').css('display', 'none');
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'block');
            $('#themmoibaiviet').removeClass('active');
            $('#titleupdate').html('<i class="fa fa-plus iconTab"></i>Thêm mới bài viết');
            $('#frmdanhmuc').css("display", "block");
            $('#frmtrangthai').css("display", "block");
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#previewavbv').html('');
            $('#lbl_anhdaidien').text('');
            //$('#name').html('');
            //$('#size').html('');
            //$('#type').html('');
            $('#tieude').val('');
            $('#gioithieu').val('');
            $('#tacgia').val('');
            $('#ngayvagio').text('');
            CKEDITOR.instances['txt_noidung'].setData('');
            var a = $('#danhmucbaiviet').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
            var b = $('.bootstrap-tagsinput').find('span');
            $.each(b, function (key, val) {
                $(this).remove();
            });
            $('#tag').tagsinput('removeAll');
        });
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");
            $('#lidanhsach').removeClass('active');
            $('#danhsachbaiviet').removeClass('active');
            $('#liaddnew').addClass('active');
            $('#themmoibaiviet').addClass('active');
            $('#titleupdate').html('<i class="fa fa-edit iconTab"></i>Sửa thông tin bài viết');
            $('#frmdanhmuc').css("display", "none");
            $('#frmtrangthai').css("display", "none");

            $('#btnUpdateBaiviet').remove();
            $('#btnChonDangMuc').remove();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateBaiviet"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            $('#btnThemmoibaiviet').remove();

            $('#previewavbv').empty();
            $('#previewavbv').append('<img src="' + data.avatar + '" width="100px" height="100px">');
            $('#lbl_anhdaidien').text(data.avatar);

            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            var splitted = data.tag.split(",");
            var inputVal = "";
            $.each(splitted, function (key, value) {
                inputVal += value + ",";
                var focusssInput = $(".bootstrap-tagsinput input").val(inputVal);
                focusssInput.focus();
            });


            capnhatthongtinbaiviettintuc(id_baiviet);
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa bài viết',
                text: "Bạn có chắc sẽ xóa bài viết này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabaiviettintuc', id_baiviet: id_baiviet }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabaiviettintuc', id_baiviet: id_baiviet }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });

        });
        table.on('click', 'i.btnDSDM', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            if (data.trangthaibaiviet == 2) {
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').removeClass('active');
                $('#liaddnew').css('display', 'none');
                $('#lichitiet').addClass('active');
                $('#lichitiet').css('display', 'block');
                $('#themmoibaiviet').addClass('active');
                $('#titlechitiet').html('<i class="fa fa-edit iconTab"></i>Chọn danh mục hiển thị bài viết');
                $('#rdoLuunhap').css("display", "none");
                $('#hienthi').prop('checked', true);
                var dscheck = $('#danhmucbaiviet input');
                $.each(dscheck, function (key, val) {
                    $(this).attr("disabled", false);
                });
                $('#btnUpdateBaiviet').remove();
                $('#btnChonDangMuc').remove();
                $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChonDangMuc"><i class="fa fa-save iconButtonPage"></i>Đồng ý</button>');
                $('#btnThemmoibaiviet').remove();

                $('#frm1').css("display", "none");
                $('#frm2').css("display", "none");
                $('#frm3').css("display", "none");
                $('#frm4').css("display", "none");
                $('#frm5').css("display", "none");
                $('#frm6').css("display", "none");

                themmoidanhmucvalichhienthichobaiviet(id_baiviet);
            } else {
                $('#libaivietdanhmuc').css("display", "block");
                $('#libaivietdanhmuc').addClass('active');
                $('#chitietbvtrongdm').addClass('active');
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').css('display', 'none');
                var tenbaiviet = data.tieude;
                if (tenbaiviet.length > 50) {
                    tenbaiviet = tenbaiviet.substring(0, 50) + "...";
                }
                $('#titledm').html('<i class="fa fa-edit iconTab"></i>' + tenbaiviet);
                loadthongtinchitietbaiviettintuc(data);
            }

        });
    }
}

function themoibaivietcanhbaonguoidan() {
    $("input:radio[name=optionsRadios]").on("click", function () {
        if ($(this)[0].id == "hengio") {
            $('#btnok').remove();
            $('#titleherader').remove();
            $('#loaidatlich').remove();
            $('#lblHinhthuc').remove();
            $('#dateend').remove();
            $('#timeend').remove();
            $('#uutien').remove();
            $('#laptheogio').remove();
            $('#lblBatDau').remove();
            $('#lblKetthu').remove();
            $('#lichuutien').remove();
            $('#form1').remove();
            $('#form2').remove();

            $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Chọn lịch</button>');
            $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                $('#titleModal').html("Đặt lịch hiển thị cho bài viêt");
            });
            //
            var _TenLich = "";
            $('#batdau').empty();
            $('#ketthu').empty();
            $('#toanthoigian').css('display', 'block');

            setTimeout(function () {
                $('#ModalLichHienthi').modal('show');
                $('#btnok').click(function () {
                    $('#ngayvagio').remove();
                    var gio = $('#timeStart').val();
                    var ngay = $('#fullDateStart').val();
                    $('#btnCances').click();
                    $('#radiohengio').append('<label id="ngayvagio">' + ngay + " " + gio + '</label>');
                });

            }, 230);
        } else {
            $('#ngayvagio').empty();
        }
    });


    var check = true;
    var dsadminShare = new Array();
    var hinhthuchienthi = "";
    var tag = "";

    $('#rdoLuunhap').css("display", "block");

    $('#btnThemmoibaiviet').click(function () {
        dsadminShare = [];
        tag = "";
        hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var avatar = $('#lbl_anhdaidien').text();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        var tacgia = $('#tacgia').val();
        tag = $('#tag').val();
        var ngaydatlich = $('#ngayvagio').text();

        var dscheck = $('#danhmucbaiviet input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề bài viết !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập phần giới thiệu bài viết !');
            return check = false;
        } else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện cho bài viết !');
            return check = false;
        }
        else if (tag == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập từ khóa cho bài viết !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hienthi" && dsadminShare.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
            return check = false;
        }

        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                avatar: avatar,
                noidung: noidung,
                tacgia: tacgia,
                tag: tag,
                ngaydatlich: ngaydatlich,
                hinhthuchienthi: hinhthuchienthi,
                idRoot: 115 //id root menu client
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('dsdanhmuc', JSON.stringify(dsadminShare));
            fd_data.append('type', 'themmoibaiviet');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaiviet').DataTable();


            $('#btnThemmoibaiviet').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            $('#previewavbv').html('');
                            $('#lbl_anhdaidien').text('');
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            $('#ngayvagio').text('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            var a = $('#danhmucbaiviet').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                            var b = $('.bootstrap-tagsinput').find('span');
                            $.each(b, function (key, val) {
                                $(this).remove();
                            });
                            $('#tag').tagsinput('removeAll');
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoibaiviet').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoibaiviet').removeAttr('disabled');
            });
        }
    });
}

function danhsachdanhmuccanhbaonguoidan() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdanhmuccanhbaonguoidan' }, function (data) {
        createcheckboxcanhbaonguoidan(data);
    });
}
function createcheckboxcanhbaonguoidan(data) {
    var $danhmuc = $('#danhmucbaiviet');
    $.each(data.danhsach, function (x2, value) {
        if (value.idParent == 0) {
            if ($(this)[0].danhsach.length > 0) {
                RootGuongDienHinh = true;
            }
        }
        if (value.trangthai == 1) {
            var $li = $('<div/>', {
                class: 'checkbox col-xs-4',
                html: '<label><input data-idadmin="' + JSON.stringify(value.id_danhmuc) + '" id="iddm' + value.id_danhmuc + '" type="checkbox" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
            if (value.danhsach != null && value.trangthai == 1) {
                if (value.danhsach.length > 0) {
                    createcheckboxcanhbaonguoidan(value);
                }
            }
        }
        return $li;
    });
    var ds = $('#danhmucbaiviet div');
    ds.first().attr('name', 'cha');
    return $danhmuc;
}



// QUẢN LÝ CHUYÊN MỤC HỎI ĐÁP - ok

function initdanhsachdanhmuccauhoi() {
    curentPage = 0;

    loadallDSdanhmuccaucoi();

    $('#liaddnew').click(function () {
        $('#hinhthucphamtoi').val('');
        themmoidanhmuchoidap();
    });
    $('#lidanhsach').click(function () {

        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#themmoihinhthucphamtoi').removeClass('active');
    });
}

function loadallDSdanhmuccaucoi() {
    var $card_content = $('#danhsachhinhthucphamtoi');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachhinhthucphamtoi',
            html: '<thead>\
                            <th>Tên danh mục</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachhinhthucphamtoi').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadallDSdanhmuccaucoi',
            "columns": [
                  {
                      data: "tenchuyenmuc",
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết danh mục"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa danh mục"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết danh mục"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa danh mục"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "bSort": false,
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachhinhthucphamtoi').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachhinhthucphamtoi').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_chuyenmuc = data.id_chuyenmuc;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa danh mục hỏi đáp',
                text: "Bạn có chắc sẽ xóa danh mục hỏi đáp này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {


                jsonPost({ type: 'xoadanhmuchoidap', id_chuyenmuc: id_chuyenmuc }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoadanhmuchoidap', id_chuyenmuc: id_chuyenmuc }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_chuyenmuc = data.id_chuyenmuc;

            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateData"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#themmoihinhthucphamtoi').addClass('active');

            $('#lidanhsach').removeClass('active');
            $('#danhsachhinhthucphamtoi').removeClass('active');

            $('#hinhthucphamtoi').val(data.tenchuyenmuc);
            capnhatthongtindanhmuchoidap(id_chuyenmuc);
        });
    }
}

function capnhatthongtindanhmuchoidap(id_chuyenmuc) {

    var table = $('#tb_danhsachhinhthucphamtoi').DataTable();
    $('#btnUpdateData').click(function () {
        var tenchuyenmuc = $('#hinhthucphamtoi').val();

        if (!valTextboxValue(tenchuyenmuc)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên danh mục hỏi đáp và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else {
            var thongtin = {
                tenchuyenmuc: tenchuyenmuc,
                id_chuyenmuc: id_chuyenmuc
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtindanhmuchoidap');
            fd_data.append("stringTookenClient", stringTookenServer);

            $('#btnUpdateData').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('#btnUpdateData').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('#btnUpdateData').removeAttr('disabled');
            });
        }
    });
}

function themmoidanhmuchoidap() {
    var check = true;

    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnAddNewTP"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');
    $('#btnAddNewTP').click(function () {

        var tenchuyenmuc = $('#hinhthucphamtoi').val();

        if (!valTextboxValue(tenchuyenmuc)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên danh mục hỏi đáp và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else {
            var thongtin = {
                tenchuyenmuc: tenchuyenmuc
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoidanhmuchoidap');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachhinhthucphamtoi').DataTable();

            $('#btnAddNewTP').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#hinhthucphamtoi').val('');
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('#btnAddNewTP').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('#btnAddNewTP').removeAttr('disabled');
            });
        }
    });
}





//QUẢN LÝ LỊCH HIỂN THỊ LOGO -ok

function initquanlylichhienthilogo() {
    curentPage = 0;
    hienthidanhsachLogovaLich();
}

function hienthidanhsachLogovaLich() {

    var $card_content = $('#danhsachbanner');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbanner',
            html: '<thead>\
                            <th>Tên Logo</th>\
                            <th>Vị trí</th>\
                            <th>Hình ảnh</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbanner').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachLogotrongthumuc',
            "columns": [
                  { data: "tenbanner" },
                  { data: "vitri" },
                  {
                      data: "duongdanfile",
                      render: function (url, type, full) {
                          return '<img style="height:80px; max-width:300px" src="' + url + '"/>';
                      }
                  },
                   {
                       data: "button", "width": "105px",
                       mRender: function (data) {
                           var $dtooltip = $('<div/>', {
                               html: '<i class="fa fa-pencil-square-o iconButton btnDanhsach" aria-hidden="true" rel="tooltip" title="Danh sách lịch hiển thị"></i>'
                           });
                           return $dtooltip.html();
                       }
                   },
            ],
            "pagingType": "full_numbers",
            "order": [[0, 'asc']],
            "bSort": false,
        });
        var parent11 = $('#tb_danhsachbanner').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbanner').DataTable();
        table.on('click', 'i.btnDanhsach', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var _idBanner = data.id_quanlybanner;
            $('#lidanhsach').removeClass('active');
            $('#danhsachbanner').removeClass('active');
            $('#ulmenu').append('<li class="active" id="lichukyhienthi"><a href="#danhsachchukyhienthicuabanner" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chu kỳ hiển thị của logo</a></li>');
            $('#danhsachchukyhienthicuabanner').addClass('active');

            //load
            var danhsach = $('#danhsachchukyhienthicuabanner');
            danhsach.empty();
            $table = $('<table />', {
                class: 'table table-bordered table-hover',
                id: 'tb_danhsachchuky',
                html: '<thead>\
                            <th>Thời gian</th>\
                            <th>Mức ưu tiên</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
            }).appendTo(danhsach);

            $('#tb_danhsachchuky').DataTable({
                data: data.thongtinhienthi,
                "columns": [
                      { data: "thoigianhienthi" },
                      { data: "mucdouutien" },
                       {
                           data: "id_chitietchukyhienthi", "width": "80px",
                           mRender: function (data) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-trash-o iconButton btnDellCal" aria-hidden="true" rel="tooltip" title="Xóa lịch hiển thị"></i>'
                               });
                               return $dtooltip.html();
                           }
                       },
                ],
                "pagingType": "full_numbers",
                "order": [[0, 'asc']],
                "bSort": false,
            });
            var parent112222 = $('#tb_danhsachchuky').parent().addClass('box-body table-responsive no-padding');
            var table2 = $('#tb_danhsachchuky').DataTable();
            table2.on('click', 'i.btnDellCal', function () {

                var closestRow2 = $(this).closest('tr');
                var data = table2.row(closestRow2).data();
                var idCal = data.id_chitietchukyhienthi;

                swal({
                    title: 'Xóa lịch ',
                    text: "Bạn có muốn xóa lịch hiển thị này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    $('.loader-parent').removeAttr('style');

                    jsonPost({ type: 'xoalichhienthibanner', idCal: idCal }).then(function (kq) {
                    //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoalichhienthibanner', idCal: idCal }, function (kq) {
                        if (kq.sucess) {
                            swal('Thông báo ', kq.msg, 'success')
                        }
                        else {
                            swal('Thông báo ', kq.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        var table3 = $('#tb_danhsachbanner').DataTable();
                        var tableHienthi = $('#tb_danhsachchuky').DataTable();
                        table3.ajax.reload(function (json) {
                            var itemcha = json.data.filterObjects('id_quanlybanner', _idBanner);
                            if (itemcha.length > 0) {
                                tableHienthi.clear().draw();
                                tableHienthi.rows.add(itemcha[0].thongtinhienthi).draw()
                            }
                        });
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                    }
                    $('.loader-parent').css('display', 'none');
                });

            });

            $('#tb_danhsachchuky_length label').remove();
            $('#tb_danhsachchuky_length').append('<button type="button" id="btnthemmoilich" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm mới lịch</button>');

            $('#btnthemmoilich').click(function () {
                $('#btnok').remove();
                $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');
                $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                    $('#titleModal').html("Thêm mới lịch hiển thị cho logo");
                });

                $('input:radio[name=optionsRadios]').change(function () {
                    var trangthai = $(this).context.value;
                    if (trangthai == "hengio") {
                        $('#ngaybatdau').css('display', 'block');
                        $('#ngayketthucc').css('display', 'block');
                        $('#toanthoigian').css('display', 'block');
                    }
                    else if (trangthai == "hienthi") {
                        $('#toanthoigian').css('display', 'block');
                        $('#ngaybatdau').css('display', 'none');
                        $('#ngayketthucc').css('display', 'block');
                    }
                });

                setTimeout(function () {
                    $('#ModalLichHienthi').modal('show');
                    $('#btnok').click(function () {
                        themmoilichhienthiLogo(_idBanner);
                    });
                }, 230);
            });
        });
        $('#lidanhsach').click(function () {
            $('#lidanhsach').addClass('active');
            $('#danhsachbanner').addClass('active');

            $('#lichukyhienthi').remove();
            $('#danhsachchukyhienthicuabanner').removeClass('active');
        });
    }
}
function themmoilichhienthiLogo(_idBanner) {

    var check = true;
    var _Uutien = $('#uutienhienthi').val();
    var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();
    if (trangthaihienthi == "hienthi") {
        var ngaydung = $('#fullDateEnd').val();
    } else if (trangthaihienthi == "hengio") {
        var ngaydang = $('#fullDateStart').val();
        var ngaydung = $('#fullDateEnd').val();
    }
    if (!$.isNumeric(_Uutien) || _Uutien < 0) {
        check = false;
        $loading.remove();
        common.showNotification('top', 'right', 'Ưu tiên hiển thị phải là dạng số dương');
    } else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc logo !');
        return check == false;
    }
    else if (trangthaihienthi == "hienthi" && ngaydung == "") {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc logo !');
        return check == false;
    }

    var thongtinbaner = {
        _idBanner: _idBanner,
        ngaydang: ngaydang,
        ngaydung: ngaydung,
        trangthaihienthi: trangthaihienthi,
        _Uutien: _Uutien
    }

    var fd_data = new FormData();
    fd_data.append('type', 'themmoilichhienthichobanner');
    fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
    fd_data.append("stringTookenClient", stringTookenServer);

    if (check) {

        $('#btnok').attr('disabled', 'true');
        swal({
            title: 'Thêm mới thông tin',
            text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess == true) {
                        $('#uutienhienthi').val('');
                        $('#fullDateEnd').val('');
                        $('#fullDateStart').val('');
                        $('#btnCances').click();
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    var table = $('#tb_danhsachbanner').DataTable();
                    var tableHienthi = $('#tb_danhsachchuky').DataTable();
                    table.ajax.reload(function (json) {
                        var itemcha = json.data.filterObjects('id_quanlybanner', _idBanner);
                        if (itemcha.length > 0) {
                            tableHienthi.clear().draw();
                            tableHienthi.rows.add(itemcha[0].thongtinhienthi).draw()
                        }
                    });
                    $('#btnok').removeAttr('disabled');
                }
            });

        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh thêm mới đã bị hủy bỏ ',
                  'info'
                )
            }
            $('.loader-parent').css('display', 'none');
            $('#btnok').removeAttr('disabled');
        });


    }
}


//QUẢN LÝ LOGO WEBSITE - ok

function initquanlylogowebsite() {
    curentPage = 0;
    hienthidanhsachLogo();

    var button = $('#groupChosefile .buttonLogo');
    $.each(button, function (key, val) {
        $(this).click(function () {
            idClick = "";
            idClick = $(this).context.id;
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });

    $('#lidanhsach').click(function () {
        $('#target option').removeAttr('selected');
        $('#vitri option').removeAttr('selected');
    });
    $('#liaddnew').click(function () {
        $('#previewbanner').html('');
        $('#lblLinkBanner').text('');

        $('#target option').removeAttr('selected');
        $('#vitri option').removeAttr('selected');


        $('#uutienhienthi').val('');
        $('#fullDateStart').val('');
        $('#fullDateEnd').val('');
        $('#ngaybatdau').css('display', 'none');
        $('#ngayketthucc').css('display', 'block');
        $('#tenbanner').val('');
        $('#linkbanner').val('');
        $('input:radio[value=hienthi]').prop('checked', true);
        $('#toanthoigian').css('display', 'block');
        $('#frmtrangthai').css('display', 'block');
        $('#buttonbanneractive').empty();
        $('#buttonbanneractive').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage  pull-right" id="btnUploadFile"><i class="fa fa-plus iconButtonPage"></i>Thêm Logo</button>');
        themmoiLogoClient();
    });

}
function hienthidanhsachLogo() {
    var $card_content = $('#danhsachbanner');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbanner',
            html: '<thead>\
                            <th></th>\
                            <th>Tên Logo</th>\
                            <th>Vị trí</th>\
                            <th>Hình ảnh</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbanner').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachLogotrongthumuc',
            "columns": [
                 { data: "ngayupload" },
                  { data: "tenbanner" },
                  { data: "vitri" },
                  {
                      data: "duongdanfile",
                      render: function (url, type, full) {
                          return '<img style="height:80px; max-width:300px" src="' + url + '"/>';
                      }
                  },
                   {
                       data: "button", "width": "105px",
                       mRender: function (data) {
                           if (data.sua == true && data.xoa == true) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-pencil-square-o iconButton btnDetails" rel="tooltip" title="Chi tiết logo"></i>\
                                          <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa logo"></i>'
                               });
                               return $dtooltip.html();
                           }
                           else if (data.xoa == true) {
                               return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa logo"></i>';
                           }
                           else if (data.sua == true) {
                               return data = '<i class="fa fa-pencil-square-o iconButton btnDetails" rel="tooltip" title="Chi tiết logo"></i>';
                           }
                           return data = '';
                       }
                   },
            ],
            initComplete: function (settings, json) {
            },
            "columnDefs": [
                  {
                      "targets": [0],
                      "visible": false
                  }
            ],
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachbanner').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbanner').DataTable();

        table.on('click', 'i.btnDetails', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();

            $('#buttonbanneractive').empty();
            $('#buttonbanneractive').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdatebanner"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#lblLinkBanner').text('');
            $('#previewbanner').html('');

            $('#toanthoigian').css('display', 'none');
            $('#lidanhsach').removeClass('active');
            $('#danhsachbanner').removeClass('active');
            $('#themmoibanner').addClass('active');
            $('#ulmenu').append('<li class="active" id="details"><a href="#themmoibanner" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Sửa thông tin logo</a></li>');

            $('#frmtrangthai').css('display', 'none');
            $('#tenbanner').val(data.tenbanner);
            $('#linkbanner').val(data.linkbanner);
            $('#lblLinkBanner').text(data.duongdanfile);
            $('#previewbanner').html("<img src='" + data.duongdanfile + "'style='max-width:300px; height:100px'/>")

            if (data.vitri == "Logo trên") {
                $('#vitri').val('Logo trên');
            } else {
                $('#vitri').val('Logo dưới');
            }

            if (data.target == "blank") {
                $('#target').val('blank');
            } else if (data.target == "self") {
                $('#target').val('self');
            } else if (data.target == "parent") {
                $('#target').val('parent');
            } else {
                $('#target').val('top');
            }


            $('#liaddnew').click(function () {
                $('#suathongtinbanner').removeClass('active');
                $('#details').remove();
            });
            $('#lidanhsach').click(function () {
                $('#suathongtinbanner').removeClass('active');
                $('#details').remove();
            });

            $('#btnUpdatebanner').click(function () {

                var check = true;

                var duongdanfile = $('#lblLinkBanner').text();
                var tenbanner = $('#tenbanner').val();
                var linkbanner = $('#linkbanner').val();
                var vitri = $('#vitri').val();
                var target = $('#target').val();
                var _idBanner = data.id_quanlybanner;

                var thongtinbaner = {
                    _idBanner: _idBanner,
                    tenbanner: tenbanner,
                    linkbanner: linkbanner,
                    vitri: vitri,
                    target: target,
                    duongdanfile: duongdanfile,
                    type: "logo"
                }
                var fd_data = new FormData();
                fd_data.append('type', 'capnhatthongtinbanner');
                fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
                fd_data.append("stringTookenClient", stringTookenServer);

                if (!valTextboxValue(tenbanner)) {
                    check = false;
                    $loading.remove();
                    common.showNotification('top', 'right', 'Tên logo không chứa ký tự đặc biệt !');
                }
                if (check) {

                    $('#btnUpdatebanner').attr('disabled', 'true');
                    swal({
                        title: 'Cập nhật thông tin logo',
                        text: "Bạn có muốn thay đổi thông tin logo này không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.ajax({
                            type: "POST",
                            url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                            data: fd_data,
                            contentType: false,
                            processData: false,
                            success: function (kq) {
                                var data = JSON.parse(kq);
                                if (data.sucess == true) {
                                    var table = $('#tb_danhsachbanner').DataTable();
                                    table.ajax.reload();
                                    swal('Thông báo ', data.msg, 'success')
                                } else {
                                    swal('Thông báo ', data.msg, 'error')
                                }
                                $('.loader-parent').css('display', 'none');
                                $('#btnUpdatebanner').removeAttr('disabled');
                                $('#details').remove();
                                $('#themmoibanner').removeClass('active');
                                $('#lidanhsach').addClass('active');
                                $('#danhsachbanner').addClass('active');
                            }
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh cập nhật đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdatebanner').removeAttr('disabled');
                    });
                }

            });
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var _idBanner = data.id_quanlybanner;
            swal({
                title: 'Xóa logo ?',
                text: "Bạn có muốn xóa logo này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabanner', _idBanner: _idBanner }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabanner', _idBanner: _idBanner }, function (kq) {
                    if (kq.sucess) {
                        table.ajax.reload();
                        swal('Thông báo ', kq.msg, 'success')
                    }
                    else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
            });
        });
    }
}

function themmoiLogoClient() {
    $('input:radio[name=optionsRadios]').change(function () {
        var trangthai = $(this).context.value;
        if (trangthai == "hienthi") {
            $('#toanthoigian').css('display', 'block');
            $('#ngaybatdau').css('display', 'none');
            $('#ngayketthucc').css('display', 'block');
        }
        else {
            $('#ngaybatdau').css('display', 'block');
            $('#ngayketthucc').css('display', 'block');
            $('#toanthoigian').css('display', 'block');
        }
    });
    $('#btnUploadFile').click(function () {

        var check = true;
        var duongdanfile = $('#lblLinkBanner').text();
        var tenbanner = $('#tenbanner').val();
        var linkbanner = $('#linkbanner').val();
        var vitri = $('#vitri').val();
        var target = $('#target').val();

        var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        if (trangthaihienthi == "hienthi") {
            var ngaydung = $('#fullDateEnd').val();
        } else if (trangthaihienthi == "hengio") {
            var ngaydang = $('#fullDateStart').val();
            var ngaydung = $('#fullDateEnd').val();
        }

        if (duongdanfile == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn logo cần upload');
        } else if (tenbanner != "") {
            if (!valTextboxValue(tenbanner)) {
                check = false;
                $loading.remove();
                common.showNotification('top', 'right', 'Tên logo không được chứa ký tự đặc biệt !');
            }
        }
        else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc logo !');
            return check == false;
        }
        else if (trangthaihienthi == "hienthi" && ngaydung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc logo !');
            return check == false;
        }
        var thongtinbaner = {

            tenbanner: tenbanner,
            linkbanner: linkbanner,
            vitri: vitri,
            target: target,
            duongdanfile: duongdanfile,
            trangthaihienthi: trangthaihienthi,
            ngaydang: ngaydang,
            ngaydung: ngaydung,
            type: "logo"
        }

        var fd_data = new FormData();
        fd_data.append('type', 'themmoibannervaohethong');
        fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
        fd_data.append("stringTookenClient", stringTookenServer);

        if (check) {

            $('#btnUploadFile').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess == true) {
                            $('#previewbanner').html('');
                            $('#lblLinkBanner').text('');
                            $('#target option').removeAttr('selected');
                            $('#vitri option').removeAttr('selected');
                            $('#uutienhienthi').val('');
                            $('#fullDateStart').val('');
                            $('#fullDateEnd').val('');
                            $('#fromDiemDat').css('display', 'none');
                            $('#ngaybatdau').css('display', 'none');
                            $('#ngayketthucc').val('');
                            $('#ngayketthucc').css('display', 'block');
                            $('input:radio[value=hienthi]').prop('checked', true);

                            var table = $('#tb_danhsachbanner').DataTable();
                            table.ajax.reload();
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUploadFile').removeAttr('disabled');
                        $('#tenbanner').val('');
                        $('#linkbanner').val('');
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUploadFile').removeAttr('disabled');
            });
        }
    });
}



//reset mat khau admin  ===> bỏ
function initresetmatkhau() {
    $('#btnLoginadmin').click(function () {
        var matkhau = $('#mkmoi').val();
        var matkhau2 = $('#mkmoi2').val();

        var check = true;

        if (!validateAcountAdmin(matkhau)) {
            common.showNotification('top', 'right', 'Mật khẩu phải chứa ký tự đặc biệt, chữ in hoa và lớn hơn 10 ký tự !');
            return check = false;
        }
        else if (matkhau2 != matkhau) {
            common.showNotification('top', 'right', 'Nhập lại mật khẩu không chính xác !');
            return check = false;
        }

        if (check) {
            $('#btnLoginadmin').attr('disabled', 'true');
            swal({
                title: 'Cập nhật mật khẩu mới',
                text: "Bạn có muốn cập nhật mật khẩu mới như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'resetmatkhau', matkhau: matkhau }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        $('#mkmoi').val('');
                        $('#mkmoi2').val('');
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('#btnLoginadmin').removeAttr('disabled');
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('#btnLoginadmin').removeAttr('disabled');
            });
        }
    });

    $('#btn_backLogin').click(function () {
        window.location = window.location.origin + "/admin";
    });
}

// dang nhap admin va reset mat khau admin ===>>> bỏ
function initdangnhapadmin() {
    //$('#btnLoginadmin').unbind();
    //$('#btnLoginadmin').click(function () {
    //     loginadmin();
    //});
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

                   // jsonPost({ type: 'xacthucemailkhiquyenmatkhau', emailcanhan: emailcanhan }).then(function (thongtinadmin) {
                    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xacthucemailkhiquyenmatkhau', emailcanhan: emailcanhan }, function (thongtinadmin) {
                        if (thongtinadmin.sucess == true) {
                            swal('Thông báo ', thongtinadmin.msg, 'success')
                            $('#btnCances').click();
                        } else {
                            swal('Thông báo ', thongtinadmin.msg, 'error')
                        }
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
                    $('#btnxacthuc').removeAttr('disabled', 'true');
                });
            }
        });

    });

    $(document).keydown(function (event) {
        var KeyCodeWinDown = event.keyCode;
        if (KeyCodeWinDown == 13 && $('#ModalView').hasClass('in') == false && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == false) {
            //  $('#btnLoginadmin').unbind();
            //  loginadmin();
            $('#btnLoginadmin').click();
        } else if (KeyCodeWinDown == 13 && $('.swal2-shown').hasClass('swal2-container swal2-fade swal2-shown') == true) {
            $('.swal2-confirm swal2-styled button').click();
        }
    });

}
//hàm này bỏ
function loginadmin() {
    var tendangnhap = $('#tendangnhap').val();
    var matkhau = $('#matkhau').val();
    var thongbao1 = '';
    var thongbao2 = '';
    var thongbao3 = '';
    var thongbao4 = '';
    var maxLeng = 6;
    var maxLengPass = 10;

    var check = true;
    if (tendangnhap == "") {
        common.showNotification('top', 'right', 'Tên đăng nhập không được để trống !');
        return check = false;
    }
    else if (tendangnhap.length < maxLeng) {
        common.showNotification('top', 'right', 'Tên đăng nhập phải lớn hơn 6 ký tự !');
        return check = false;
    }
    else if (!validateAcountAdmin(matkhau)) {
        common.showNotification('top', 'right', 'Mật khẩu phải chứa ký tự đặc biệt, chữ in hoa và lớn hơn 10 ký tự !');
        return check = false;
    }
    else {
        $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'dangnhapadmin', tendangnhap: tendangnhap, matkhau: matkhau }, function (dangnhapadmin) {
            if (dangnhapadmin.success) {
                window.location = window.location.origin + "/index-admin";
            } else {
                swal('Thông báo ', dangnhapadmin.msg, 'error')
            }
        });
    }
}





// log hệ thống

function initLog() {
    curentPage = 0;
    loadallLog();
    $('#taobaocao').click(function () {
        $('#ModalLogHeThong').modal('show');
        $('#titleBC').empty();
        $('#titleBC').text("Chọn thời gian xuất báo cáo");

    });
    $('#btnCreateBC').click(function () {

        var action = $('#frmChonLog').val();
        var ngaybatdau = $('#fullDateStart').val();
        var ngayketthuc = $('#fullDateEnd').val();
        $('.loader-parent').removeAttr('style');
        $.getJSON('/SourceAdmin/ashx/createExcell.ashx?type=' + action + '&timestart=' + ngaybatdau + '&timeend=' + ngayketthuc, function (data) {
            if (data.sucess) {
                $('#fullDateStart').val('');
                $('#fullDateEnd').val('');
                swal('Thông báo ', 'Tạo báo cáo thành công ', 'success')
                window.location = data.url;
            } else {
                swal('Thông báo ', 'Tạo báo cáo thất bại', 'error')
            }
            $('.loader-parent').css('display', 'none');
        });
    });

    var table = $('#tb_tabletestbang').DataTable();

    $('#frmChonLog').change(function () {
        $('#tb_tabletestbang_filter input').val('');
        $('#tb_tabletestbang_filter input').autocomplete('destroy');
        var type = $('#frmChonLog').val();
        $('.loader-parent').removeAttr('style');

        table.ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=' + type + "&id=0").load(function (json) {

            if (table.settings()[0].aanFeatures.f[0]) {
                var fnFilter = $(table.settings()[0].aanFeatures.f[0].querySelector('input'));
                fnFilter.val('');
                fnFilter.keyup();
                $('.loader-parent').css('display', 'none');
            }
        });
    });

    $('#lidanhsach').click(function () {
        var type = $('#frmChonLog').val();
        table.ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=' + type + "&id=0").load();
    });
}


function loadallLog() {
    var $card_content = $('#tabletest');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_tabletestbang',
            html: '<thead>\
                            <th>Type</th>\
                            <th>Thời gian</th>\
                            <th>Tên</th>\
                            <th>IP</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        var table = $('#tb_tabletestbang').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=login&id=0',
            "columns": [
                    {
                        data: "type",
                        mRender: function (type) {
                            if (type == "suathongtinthanhcong") {
                                type = "Sửa thông tin thành công";
                            }
                            else if (type == "suathongtinthatbai") {
                                type = "Sửa thất bại";
                            }
                            else if (type == "resetmatkhauthanhcong") {
                                type = "Reset mật khẩu thành công";
                            }
                            else if (type == "resetmatkhauthatbai") {
                                type = "Reset mật khẩu thất bại";
                            }
                            else if (type == "loginthanhcong") {
                                type = "Login thành công";
                            }
                            else if (type == "loginthatbai") {
                                type = "Login thất bại";
                            }
                            else if (type == "themmoithongtinthanhcong") {
                                type = "Thêm mới thành công";
                            }
                            else if (type == "themmoithongtinthatbai") {
                                type = "Thêm mới thất bại";
                            }
                            else if (type == "xoathongtinthanhcong") {
                                type = "Xóa thành công";
                            }
                            else if (type == "xoathongtinthatbai") {
                                type = "Xóa thất bại";
                            }
                            else if (type == "nguoidungthaotacthanhcong") {
                                type = "Người dùng thao tác thành công";
                            }
                            else if (type == "thaotacnguoidungthatbai") {
                                type = "Người dùng thao tác thất bại";
                            } else {
                                type = "Lỗi";
                            }
                            return type;
                        }
                    },

                    {
                        data: "ngaygio",
                    },
                    {
                        data: "tenadmin",
                    },
                      {
                          data: "vitrihoatdong",
                          mRender: function (data) {
                              var list = JSON.parse(data);
                              return list.ip;
                          }
                      },
                     {
                         data: "id_loghethong", "width": "80px",
                         mRender: function (data) {
                             var $dtooltip = $('<div/>', {
                                 html: '<i class="fa fa-info-circle iconButton btnnoidung" aria-hidden="true" rel="tooltip" title="Chi tiết hoạt động"></i>\
                                        <i class="fa fa-map-marker iconButton btntruycap" aria-hidden="true" rel="tooltip" title="Chi tiết vị trí"></i>'
                             });
                             return $dtooltip.html();
                         }
                     },

            ],
            drawCallback: function (settings) {

                var idtype = settings.ajax;

                var url = new URL(window.location.origin + idtype);
                var type = url.searchParams.get("idtype");

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    var width = fnFilter[0].clientWidth - 22;
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=" + type + "&id=0";
                        settings.id = 0;
                    }
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(table.ajax.json().data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.ngaytao.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.type.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tenadmin.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.vitrihoatdong.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_loghethong) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=" + type + "&id=" + u.item.id_loghethong;
                                settings.id = u.item.id_loghethong;
                                table.ajax.reload();
                            }
                        },
                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tenadmin + '</div><div class="noidung2">' + item.type + '</div>'
                        }).appendTo(ul);
                    };
                }



            },
            "pagingType": "full_numbers",
            "bSort": false,
            "bServerSide": true,
            initComplete: function (settings, json) {
                // tim kiếm

                var idtype = settings.ajax;

                var url = new URL(window.location.origin + idtype);
                var type = url.searchParams.get("idtype");

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    var width = fnFilter[0].clientWidth - 22;
                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });

                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.ngaytao.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.type.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tenadmin.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.vitrihoatdong.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_loghethong) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalllog&idtype=" + type + "&id=" + u.item.id_loghethong;
                                settings.id = u.item.id_loghethong;
                                table.ajax.reload();
                            }
                        },
                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tenadmin + '</div><div class="noidung2">' + item.type + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
        });
        var parent = $('#tb_tabletestbang').parent().addClass('box-body table-responsive');
        table.on('click', 'i.btnnoidung', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_loghethong = data.id_loghethong;
            var thongtin = JSON.parse(data.noidung);
            setTimeout(function () {
                $('#ModalFolder').modal('show');
                $('#modalFolBody').empty();
                $('#tieudeModel').empty();
                $('#tieudeModel').text("Dữ liệu thao tác");
                var str = '<label for="male">' + thongtin.noidung + '</label>';
                $.each(thongtin, function (i, v) {
                    //1 obj
                    if (!isObject(v)) {
                        var str = '<label for="male">' + i + ': </label>' + v + '</br>';
                        $('#modalFolBody').append(str);
                    } else {
                        if (i == "thongtindangky") {
                            $.each(v, function (index, value) {
                                if (value != "") {
                                    var str = '<label for="male">' + index + ' : </label>' + value + '</br>';
                                    $('#modalFolBody').append(str);
                                }
                            });
                        }
                        else if (i == "thongtinxoa") {
                            $.each(v, function (index1, value1) {
                                if (value1 != "") {
                                    var str = '<label for="male">' + index1 + ' : </label>' + value1 + '</br>';
                                    $('#modalFolBody').append(str);
                                }
                            });
                        }
                        else if (i == "dulieucu") {
                            $('#modalFolBody').append('<h4 style="text-align: center;">--- Dữ liệu cũ ---<h4>');
                            $.each(v, function (index1, value1) {
                                if (value1 != "") {
                                    var str = '<label for="male">' + index1 + ' : </label>' + value1 + '</br>';
                                    $('#modalFolBody').append(str);
                                }
                            });
                        }
                        else if (i == "dulieumoi") {
                            $('#modalFolBody').append('<h4 style="text-align: center;">--- Dữ liệu mới ---<h4>');
                            $.each(v, function (index2, value2) {
                                if (value2 != "") {
                                    var str = '<label for="male">' + index2 + ' :</label> ' + value2 + '</br>';
                                    $('#modalFolBody').append(str);
                                }
                            });
                        }
                        else {
                            var str = '<label for="male">' + i + ' : </label>' + v + '</br>';
                            $('#modalFolBody').append(str);
                        }
                    }
                });
            }, 230);
        });

        table.on('click', 'i.btntruycap', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_loghethong = data.id_loghethong;
            var truycap = JSON.parse(data.vitrihoatdong);
            setTimeout(function () {
                $('#ModalFolder').modal('show');
                $('#modalFolBody').empty();
                $('#tieudeModel').empty();
                $('#tieudeModel').text("Thông tin truy cập");
                var str = '<label for="male">' + truycap.vitrihoatdong + '</label>';
                $.each(truycap, function (index, value) {
                    if (index == "loginthanhcong") {
                        $.each(index, function (i, v) {
                            var str = '<label for="male">' + i + ' : ' + v + '</label></br>';
                            $('#modalFolBody').append(str);
                        });
                    } else {
                        var str = '<label for="male">' + index + ' : ' + value + '</label></br>';
                        $('#modalFolBody').append(str);
                    }
                })
            }, 230);
        });

        $('#tb_tabletestbang_length').empty();
        $('#tb_tabletestbang_length').append('<label>Chọn kiểu \
                                                  <select class="form-control" id=frmChonLog>\
                                                    <option value="login">Login</option>\
                                                    <option value="reset">Reset mật khẩu</option>\
                                                    <option value="addnew">Thêm thông tin</option>\
                                                    <option value="update">Sửa thông tin</option>\
                                                    <option value="delete">Xóa thông tin</option>\
                                                    <option value="nguoidung">Người dùng</option>\
                                                  </select></label>');
    }
}

function isObject(val) {
    return val instanceof Object;
}



//CHI TIÊT LOG HỆ THỐNG
var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};
function initChiTietLog() {
    curentPage = 0;
    loaddanhsachbanglog();
    $(document).ready(function () {
        var type = getUrlParameter('type');
        var idlog = getUrlParameter('idlog');
        var tablelog = getUrlParameter('tablelog');
        getdataLog(type, idlog, tablelog);

        console.log(type);
        console.log(idlog);
        console.log(tablelog);
    });
    $('#timkiemlog').click(function () {
        timkiemlogtheoid();
    });
}
function timkiemlogtheoid() {
    var type = "chitietlog";
    var idlog = $('#idloght').val();
    var tablelog = $('#danhsachbanglog').val();

    var sucess = true;
    if (!$.isNumeric(idlog)) {
        common.showNotification('top', 'right', 'ID log là dạng số !');
        sucess = false;
    }
    if (sucess) {
        getdataLog(type, idlog, tablelog);
    }
}

function getdataLog(type, idlog, tablelog) {
    $('.loader-parent').removeAttr('style');
    $.getJSON('/SourceAdmin/ashx/Handler.ashx?type=' + type, { idlog: idlog, tablelog: tablelog }, function (data) {
        if (data.sucess == false) {
            common.showNotification('top', 'right', 'Không tìm thấy dữ liệu !');
        } else {
            var idtk = data.data.id_taikhoan;
            if (idtk == null) {
                idtk = 0;
            }
            var tentk = data.data.tentaikhoan;
            if (tentk == null) {
                tentk = "Ẩn danh";
            }
            $('#frmthongtin').empty();
            $('#frmVitri').empty();
            $('#frmData').empty();
            $('#frmthongtin').append('<label for="male">ID log : </label>' + data.data.id_loghethong + '</br>\
                                        <label for="male">ID tài khoản : </label>' + idtk + '</br>\
                                        <label for="male">Tên tài khoản : </label>' + tentk + '</br>\
                                        <label for="male">Ngày tạo : </label>' + data.data.ngaytao + '</br>\
                                        <label for="male">Type log : </label>' + data.data.type + '</br>');

            var vitri = JSON.parse(data.data.vitrihoatdong);
            $.each(vitri, function (index, value) {
                var vt = '<label for="male">' + index + ': </label>' + value + '</br>';
                $('#frmVitri').append(vt);
            });
            var noidung = JSON.parse(data.data.noidung);
            $.each(noidung, function (i, v) {
                if (!isObject(v) && v != "") {
                    var str = '<label for="male">' + i + ': </label>' + v + '</br>';
                    $('#frmData').append(str);
                }
                else {
                    if (i == "thongtindangky") {
                        $.each(v, function (index, value) {
                            var str = '<label for="male">' + index + ' : </label>' + value + '</br>';
                            $('#frmData').append(str);
                        });
                    }
                    else if (i == "thongtinxoa") {
                        $.each(v, function (index1, value1) {
                            var str = '<label for="male">' + index1 + ' : </label>' + value1 + '</br>';
                            $('#frmData').append(str);
                        });
                    }
                    else if (i == "dulieucu") {
                        $('#frmData').append('<h4 style="text-align: center;">--- Dữ liệu cũ ---<h4>');
                        $.each(v, function (index1, value1) {
                            if (value1 != "") {
                                var value = document.createElement("div");
                                value.html = value1;
                                var str = '<label for="male">' + index1 + ' : </label>' + value.html + '</br>';
                                $('#frmData').append(str);
                            }
                        });
                    }
                    else if (i == "dulieumoi") {
                        $('#frmData').append('<h4 style="text-align: center;">--- Dữ liệu mới ---<h4>');
                        $.each(v, function (index2, value2) {
                            if (value2 != "") {
                                var str = '<label for="male">' + index2 + ' :</label> ' + value2 + '</br>';
                                $('#frmData').append(str);
                            }
                        });
                    }
                    else {
                        var str = '<label for="male">' + i + ' : </label>' + v + '</br>';
                        $('#frmData').append(str);
                    }
                }
            });

        }
        $('.loader-parent').css('display', 'none');
    });
}

function loaddanhsachbanglog() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachbanglog' }, function (data) {
        $.each(data, function (key, val) {
            $('#danhsachbanglog').append('<option value="' + val.tenbanglog + '">' + val.tenbanglog + '</option>');
        });
    });
}

// QUẢN LÝ BIỂU ĐỒ THÔNG KÊ SỐ LIỆU - ok

function initQuanLyBieuDo() {
    curentPage = 0;
    loadloaibieudo();
    loaddonvivebieudo();
    loaddanhsachbieudo();
    $('#liaddnew').click(function () {

        $('#tenbieudo').val('');

        $('#frmDonViThoiGian option').removeAttr('selected');
        $('#frmLoaiBieuDo option').removeAttr('selected');

        $('#frmDonViThoiGian').val("0");
        $('#frmLoaiBieuDo').val("0");

        $('#frmDonViThoiGian').prop("disabled", false);
        $('#frmLoaiBieuDo').prop("disabled", false);

        $('#hienthi').prop('checked', true);
        $('#frmShowThoigian').empty();

        taomoibieudo();
    });
    $('#lidanhsach').click(function () {

        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#themmoihinhthucphamtoi').removeClass('active');

        $('#frmDonViThoiGian').prop("disabled", false);
        $('#frmLoaiBieuDo').prop("disabled", false);

        $('#tenbieudo').val('');
        $('#frmDonViThoiGian option').removeAttr('selected');
        $('#frmLoaiBieuDo option').removeAttr('selected');
        $('#frmDonViThoiGian').val("0");
        $('#frmLoaiBieuDo').val("0");
        $('#hienthi').prop('checked', true);
        $('#frmShowThoigian').empty();
    });
}

function loaddanhsachbieudo() {
    var $card_content = $('#danhsachbieudothongke');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbieudothongke',
            html: '<thead>\
                            <th>Tên biểu đồ</th>\
                            <th>Loại biểu đồ</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbieudothongke').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbieudo',
            "columns": [
                  {
                      data: "tenbieudo",
                  },
                    {
                        data: "loaibieudo",
                    },
                  {
                      data: "trangthai",
                      mRender: function (data) {
                          if (data == 2) {
                              data = "Hiển thị";
                          } else {
                              data = "Chỉ lưu";
                          }
                          return data;
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết biểu đồ"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa biểu đồ"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết biểu đồ"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa biểu đồ"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "pagingType": "full_numbers",
            "bSort": false,
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachbieudothongke').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbieudothongke').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_bieudo = data.id_bieudo;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa biểu đồ',
                text: "Bạn có chắc sẽ xóa biểu đồ này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabieudo', id_bieudo: id_bieudo }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabieudo', id_bieudo: id_bieudo }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });

        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_bieudo = data.id_bieudo;
            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdatebando"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#thongtinchitietvebieudo').addClass('active');

            $('#lidanhsach').removeClass('active');
            $('#danhsachbieudothongke').removeClass('active');


            $('#tenbieudo').val(data.tenbieudo);

            if (data.trangthai == 1) {
                $("#chiluu").prop("checked", true);
            } else {
                $("#hienthi").prop("checked", true);
            }



            $('#frmLoaiBieuDo').val(data.id_loaibieudo);
            $('#frmLoaiBieuDo').attr('disabled', true);

            $('#frmDonViThoiGian').val(data.id_donvitg);
            $('#frmDonViThoiGian').attr('disabled', true);

            if (data.id_donvitg == 2 || data.id_donvitg == 3) {
                $('#frmShowThoigian').empty();
                $('#frmShowThoigian').append('<div>\
                                                 <label for="inputEmail" class="col-sm-2 control-label">Nhập thời gian <span class="required-admin">*</span></label>\
                                                 <div class="col-sm-10">\
                                                       <input type="text" class="form-control" id="tuthoigian" value="' + data.tuthoigian + '" placeholder="Năm là dạng số , vd: 2012"/>\
                                                </div>\
                                           </div>');
            } else if (data.id_donvitg == 1) {
                $('#frmShowThoigian').empty();
                $('#frmShowThoigian').append('<div class="row">\
                                                <div class="col-sm-12" style="padding-bottom:15px">\
                                                     <label for="inputEmail" class="col-sm-2 control-label">Năm bắt đầu<span class="required-admin">*</span></label>\
                                                     <div class="col-sm-10">\
                                                           <input type="text" class="form-control" id="tuthoigian" value="' + data.tuthoigian + '" placeholder="Năm là dạng số , vd: 2001"/>\
                                                    </div>\
                                               </div>\
                                               <div class="col-sm-12" style="padding-bottom:15px">\
                                                     <label for="inputEmail" class="col-sm-2 control-label">Năm kết thúc<span class="required-admin">*</span></label>\
                                                     <div class="col-sm-10">\
                                                           <input type="text" class="form-control" id="denthoigian" value="' + data.denthoigian + '" placeholder="Năm là dạng số , vd: 2016"/>\
                                                    </div>\
                                               </div>\
                                         </div>');
            } else {
                $('#frmShowThoigian').empty();
            }


            capnhatthongtinbieudo(data);
        });
    }
}

function capnhatthongtinbieudo(data) {
    var check = true;
    var trangthai;
    var tuthoigian;
    var denthoigian;
    var tenbieudo;
    var id_donvitg;
    var id_loaibieudo;
    var id_bieudo;

    $('#btnUpdatebando').click(function () {
        tuthoigian = "";
        denthoigian = "";
        tenbieudo = "";
        id_donvitg = "";
        id_loaibieudo = "";
        id_bieudo = "";

        id_bieudo = data.id_bieudo;
        tenbieudo = $('#tenbieudo').val();
        trangthai = $("#frmTrangThai input[type='radio']:checked").val();

        id_donvitg = data.id_donvitg;
        id_loaibieudo = data.id_loaibieudo;


        if (id_donvitg == 2 || id_donvitg == 3) {
            tuthoigian = $('#tuthoigian').val();
            denthoigian = 0;
        } else if (id_donvitg == 1) {
            tuthoigian = $('#tuthoigian').val();
            denthoigian = $('#denthoigian').val();
        } else {
            tuthoigian = "";
            denthoigian = "";
        }

        if (!valTextboxValue(tenbieudo)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên biểu đồ và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else if (id_loaibieudo == "" || id_loaibieudo == "0") {
            common.showNotification('top', 'right', 'Mời bạn chọn loại biểu đồ !');
            return check = false;
        }
        else if (id_donvitg == "" || id_donvitg == "0") {
            common.showNotification('top', 'right', 'Mời bạn chọn đơn vị thời gian  !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && tuthoigian == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập năm cần thống kê !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && (!$.isNumeric(tuthoigian))) {
            common.showNotification('top', 'right', 'Mốc thời gian phải là dạng số 1!');
            return check = false;
        }
        else if (id_donvitg == 1 && (tuthoigian == "" || denthoigian == "")) {
            common.showNotification('top', 'right', 'Mời bạn nhập đủ thời gian bắt đầu và thời gian kết thúc !');
            return check = false;
        }
        else if ((id_donvitg == 1) && (!$.isNumeric(tuthoigian) && !$.isNumeric(denthoigian))) {
            common.showNotification('top', 'right', 'Mốc thời gian phải là dạng số !');
            return check = false;
        }
        else if ((id_donvitg == 1) && (tuthoigian.length > 4 || denthoigian.length > 4 || tuthoigian.length < 4 || denthoigian.length < 4)) {
            common.showNotification('top', 'right', 'Nhập sai định dạng mốc thời gian !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && (tuthoigian.length > 4 || tuthoigian.length < 4)) {
            common.showNotification('top', 'right', 'Nhập sai định dạng mốc thời gian !');
            return check = false;
        }
        else if (trangthai == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn trạng thái cho biểu đồ !');
            return check = false;
        }
        else {
            var thongtin = {
                tenbieudo: tenbieudo,
                id_donvitg: id_donvitg,
                trangthai: trangthai,
                id_loaibieudo: id_loaibieudo,
                tuthoigian: tuthoigian,
                denthoigian: denthoigian,
                id_bieudo: id_bieudo
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinbieudo');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbieudothongke').DataTable();


            $('#btnUpdatebando').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdatebando').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdatebando').removeAttr('disabled');
            });
        }
    });
}

function taomoibieudo() {
    var check = true;
    var trangthai;
    var tuthoigian;
    var denthoigian;
    var tenbieudo;
    var id_donvitg;
    var id_loaibieudo;
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnthemmoibieudo"><i class="fa fa-plus iconButtonPage"></i>Thêm biểu đồ</button>');
    $('#frmDonViThoiGian').change(function () {

        var idDonVi = $('#frmDonViThoiGian').val();

        if (idDonVi == 2 || idDonVi == 3) {
            $('#frmShowThoigian').empty();
            $('#frmShowThoigian').append('<div>\
                                                 <label for="inputEmail" class="col-sm-2 control-label">Nhập thời gian<span class="required-admin">*</span></label>\
                                                 <div class="col-sm-10">\
                                                       <input type="text" class="form-control" id="tuthoigian" placeholder="Năm là dạng số , vd: 2012"/>\
                                                </div>\
                                           </div>');
        } else if (idDonVi == 1) {
            $('#frmShowThoigian').empty();
            $('#frmShowThoigian').append('<div class="row">\
                                                <div class="col-sm-12" style="padding-bottom:15px">\
                                                     <label for="inputEmail" class="col-sm-2 control-label">Năm bắt đầu<span class="required-admin">*</span></label>\
                                                     <div class="col-sm-10">\
                                                           <input type="text" class="form-control" id="tuthoigian" placeholder="Năm là dạng số , vd: 2001"/>\
                                                    </div>\
                                               </div>\
                                               <div class="col-sm-12" style="padding-bottom:15px">\
                                                     <label for="inputEmail" class="col-sm-2 control-label">Năm kết thúc<span class="required-admin">*</span></label>\
                                                     <div class="col-sm-10">\
                                                           <input type="text" class="form-control" id="denthoigian" placeholder="Năm là dạng số , vd: 2016"/>\
                                                    </div>\
                                               </div>\
                                         </div>');
        } else {
            $('#frmShowThoigian').empty();
        }
    });

    $('#btnthemmoibieudo').click(function () {
        tuthoigian = "";
        denthoigian = "";
        tenbieudo = "";
        id_donvitg = "";
        id_loaibieudo = "";
        tenbieudo = $('#tenbieudo').val();
        trangthai = $("#frmTrangThai input[type='radio']:checked").val();

        id_donvitg = $('#frmDonViThoiGian').val();
        id_loaibieudo = $('#frmLoaiBieuDo').val();


        if (id_donvitg == 2 || id_donvitg == 3) {
            tuthoigian = $('#tuthoigian').val();
            denthoigian = 0;
        } else if (id_donvitg == 1) {
            tuthoigian = $('#tuthoigian').val();
            denthoigian = $('#denthoigian').val();
        } else {
            tuthoigian = "";
            denthoigian = "";
        }

        if (!valTextboxValue(tenbieudo)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên biểu đồ và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else if (id_loaibieudo == "" || id_loaibieudo == "0") {
            common.showNotification('top', 'right', 'Mời bạn chọn loại biểu đồ !');
            return check = false;
        }
        else if (id_donvitg == "" || id_donvitg == "0") {
            common.showNotification('top', 'right', 'Mời bạn chọn đơn vị thời gian  !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && tuthoigian == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập năm cần thống kê !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && (!$.isNumeric(tuthoigian))) {
            common.showNotification('top', 'right', 'Mốc thời gian phải là dạng số 1!');
            return check = false;
        }
        else if (id_donvitg == 1 && (tuthoigian == "" || denthoigian == "")) {
            common.showNotification('top', 'right', 'Mời bạn nhập đủ thời gian bắt đầu và thời gian kết thúc !');
            return check = false;
        }
        else if ((id_donvitg == 1) && (!$.isNumeric(tuthoigian) && !$.isNumeric(denthoigian))) {
            common.showNotification('top', 'right', 'Mốc thời gian phải là dạng số !');
            return check = false;
        }
        else if ((id_donvitg == 1) && (tuthoigian.length > 4 || denthoigian.length > 4 || tuthoigian.length < 4 || denthoigian.length < 4)) {
            common.showNotification('top', 'right', 'Nhập sai định dạng mốc thời gian !');
            return check = false;
        }
        else if ((id_donvitg == 2 || id_donvitg == 3) && (tuthoigian.length > 4 || tuthoigian.length < 4)) {
            common.showNotification('top', 'right', 'Nhập sai định dạng mốc thời gian !');
            return check = false;
        }
        else if (trangthai == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn trạng thái cho biểu đồ !');
            return check = false;
        }
        else {
            var thongtin = {
                tenbieudo: tenbieudo,
                id_donvitg: id_donvitg,
                trangthai: trangthai,
                id_loaibieudo: id_loaibieudo,
                tuthoigian: tuthoigian,
                denthoigian: denthoigian
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoibieudothongke');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbieudothongke').DataTable();

            $('#btnthemmoibieudo').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                            $('#tenbieudo').val('');
                            $('#frmDonViThoiGian option').removeAttr('selected');
                            $('#frmLoaiBieuDo option').removeAttr('selected');

                            $('#frmDonViThoiGian').val("0");
                            $('#frmLoaiBieuDo').val("0");
                            $('#hienthi').prop('checked', true);
                            $('#frmShowThoigian').empty();

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnthemmoibieudo').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnthemmoibieudo').removeAttr('disabled');
            });
        }
    });
}

function loaddonvivebieudo() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddonvivebieudo' }, function (data) {
        $.each(data, function (key, val) {
            $('#frmDonViThoiGian').append('<option value="' + val.id_donvitg + '">' + val.tendonvi + '</option>');
        });
    });
}
function loadloaibieudo() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadloaibieudo' }, function (data) {
        $.each(data, function (key, val) {
            $('#frmLoaiBieuDo').append('<option value="' + val.id_loaibieudo + '">' + val.tenloaibieudo + '</option>');
        });
    });
}

// QUẢN LÝ HÌNH THỨC PHẠM TỘI -ok

function initQuanLyHinhThucPhamToi() {
    curentPage = 0;

    loadallHinhThucPhamToi();

    $('#liaddnew').click(function () {

        $('#hinhthucphamtoi').val('');
        $('#codung').prop('checked', true);

        themmoihinhthucphamtoi();
    });
    $('#lidanhsach').click(function () {

        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#themmoihinhthucphamtoi').removeClass('active');
    });
}

function loadallHinhThucPhamToi() {
    var $card_content = $('#danhsachhinhthucphamtoi');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachhinhthucphamtoi',
            html: '<thead>\
                            <th>Hình thức phạm tội</th>\
                            <th>Trạng thái sử dụng trong biểu đồ</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachhinhthucphamtoi').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadallHinhThucPhamToi',
            "columns": [
                  {
                      data: "hinhthucphamtoi",
                  },
                  {
                      data: "trangthaithongke",
                      mRender: function (data) {
                          if (data == true) {
                              data = "Sử dụng trong thống kê vẽ biểu đồ";
                          } else {
                              data = "Không sử dụng";
                          }
                          return data;
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết hình thức phạm tội"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa hình thức phạm tội"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết hình thức phạm tội"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa hình thức phạm tội"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "bSort": false,
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachhinhthucphamtoi').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachhinhthucphamtoi').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_hinhthucphamtoi = data.id_hinhthucphamtoi;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa hình thức phạm tội',
                text: "Bạn có chắc sẽ xóa hình thức phạm tội này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoahinhthucphamtoi', id_hinhthucphamtoi: id_hinhthucphamtoi }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoahinhthucphamtoi', id_hinhthucphamtoi: id_hinhthucphamtoi }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_hinhthucphamtoi = data.id_hinhthucphamtoi;

            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateData"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#themmoihinhthucphamtoi').addClass('active');

            $('#lidanhsach').removeClass('active');
            $('#danhsachhinhthucphamtoi').removeClass('active');


            $('#hinhthucphamtoi').val(data.hinhthucphamtoi);
            if (data.trangthaithongke == true) {
                $("#codung").prop("checked", true);
            } else {
                $("#khongdung").prop("checked", true);
            }

            capnhatthongtinhinhthucphamtoi(id_hinhthucphamtoi);
        });
    }
}

function capnhatthongtinhinhthucphamtoi(id_hinhthucphamtoi) {

    var trangthaithongke;
    var table = $('#tb_danhsachhinhthucphamtoi').DataTable();
    $('#btnUpdateData').click(function () {

        trangthaithongke = "";

        var hinhthucphamtoi = $('#hinhthucphamtoi').val();

        trangthaithongke = $("#frmTinhTrang input[type='radio']:checked").val();

        if (!valTextboxValue(hinhthucphamtoi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên hình thức phạm tội và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else if (trangthaithongke == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn tình trạng !');
            return check = false;
        }
        else {
            var thongtin = {
                hinhthucphamtoi: hinhthucphamtoi,
                trangthaithongke: trangthaithongke,
                id_hinhthucphamtoi: id_hinhthucphamtoi
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinhinhthucphamtoi');
            fd_data.append("stringTookenClient", stringTookenServer);

            $('#btnUpdateData').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateData').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateData').removeAttr('disabled');
            });
        }
    });
}

function themmoihinhthucphamtoi() {
    var check = true;
    var trangthaithongke = "";

    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnAddNewTP"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');
    $('#btnAddNewTP').click(function () {

        var hinhthucphamtoi = $('#hinhthucphamtoi').val();
        trangthaithongke = $("#frmTinhTrang input[type='radio']:checked").val();


        if (!valTextboxValue(hinhthucphamtoi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên hình thức phạm tội và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (trangthaithongke == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn trạng thái sử dụng thống kê !');
            return check = false;
        }
        else {
            var thongtin = {
                hinhthucphamtoi: hinhthucphamtoi,
                trangthaithongke: trangthaithongke
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoihinhthucphamtoi');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachhinhthucphamtoi').DataTable();

            $('#btnAddNewTP').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#hinhthucphamtoi').val('');
                            $('#codung').prop('checked', true);
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnAddNewTP').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnAddNewTP').removeAttr('disabled');
            });
        }
    });
}

//QUẢN LÝ THÔNG TIN TỘI PHẠM - ok
function initQuanLyThongTinToiPham() {
    curentPage = 0;


    loadhinhthucphamtoi();
    loaddanhsachtoipham();
    var button = $('#groupChosefileToiPham .button123');
    $.each(button, function (key, val) {
        $(this).click(function () {
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });

    $('#liaddnew').click(function () {
        $('#titletoipham').css('display', 'none');
        $('#thongtintienancuatoipham').css('display', 'none');
        $('#frmHinhthuc').css('display', 'block');
        $('#frmNgayluhs').css('display', 'block');
        $('#frmtrangthai').css('display', 'block');

        $('#hoten').val('');
        $('#ngaysinh').val('');
        $('#sochungminhthu').val('');
        $('#hokhauthuongtru').val('');
        $('#quequan').val('');
        $('#bietdanh').val('');
        $('#ngayluuhoso').val('');
        $('#frmHinhThucPhamToi option').removeAttr('selected');

        $('#dathuan').prop('checked', true);
        $('#groupFileToiPham').empty();
        themmoitoipham();
    });
    $('#lidanhsach').click(function () {
        $('#titletoipham').css('display', 'none');
        $('#frmHinhThucPhamToi option').removeAttr('selected');
        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#themmoithoipham').removeClass('active');
        $('#tb_danhsachtoipham').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachtoipham&id=0').load();
    });
}

function loaddanhsachtoipham() {
    var $card_content = $('#danhsachtoipham');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachtoipham',
            html: '<thead>\
                            <th>Họ tên</th>\
                            <th>Hộ khẩu thường trú</th>\
                            <th>Số CMND</th>\
                            <th>Số án</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachtoipham').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachtoipham&id=0',
            "columns": [
                  {
                      data: "hoten",
                  },
                  {
                      data: "hokhauthuongtru",
                  },
                   {
                       data: "sochungminhthu",
                   },
                   {
                       data: "soan",
                   },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết tội phạm"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa thông tin và hồ sơ tội phạm"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết tội phạm"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa thông tin và hồ sơ tội phạm"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachtoipham&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.hoten.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.hokhauthuongtru.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.sochungminhthu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.quequan.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.bietdanh.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_toipham) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachtoipham&id=" + u.item.id_toipham;
                                settings.id = u.item.id_toipham;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.hoten + '</div><div class="noidung1">' + item.quequan + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[3, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachtoipham').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachtoipham').DataTable();
        var listXoa = new Array();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_toipham = data.id_toipham;

            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa tội phạm',
                text: "Bạn có chắc sẽ xóa thông tin về tội phạm này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoathongtintoipham', id_toipham: id_toipham }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoathongtintoipham', id_toipham: id_toipham }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_toipham = data.id_toipham;

            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnCapnhatthongtintoipham"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#themmoithoipham').addClass('active');

            $('#lidanhsach').removeClass('active');
            $('#danhsachtoipham').removeClass('active');

            $('#thongtintienancuatoipham').css('display', 'block');
            $('#titletoipham').css('display', 'block');
            $('#frmHinhthuc').css('display', 'none');
            $('#frmNgayluhs').css('display', 'none');
            $('#frmtrangthai').css('display', 'none');

            var ngayS = data.ngaysinh.substring(0, 10);

            $('#hoten').val(data.hoten);
            $('#ngaysinh').val(ngayS);
            $('#sochungminhthu').val(data.sochungminhthu);
            $('#hokhauthuongtru').val(data.hokhauthuongtru);
            $('#quequan').val(data.quequan);
            $('#bietdanh').val(data.bietdanh);
            if (data.hinhanh == null) {
                $('#groupFileToiPham').empty();
                $('#groupFileToiPham').append('<label>Không có ảnh hiển thị</label>');

            } else {
                $('#groupFileToiPham').empty();
                $('#groupFileToiPham').append('<label style="display:none">ok</label><img width="100%" style="padding-bottom: 5px;" height="150px" id="' + makeid() + '" src="' + data.hinhanh + '"/>');

            }


            loadthongtintienancuatoipham(data);

            capnhatthongtincanhantoipham(id_toipham);

            themmoihosoantoipham(data);
        });
    }
}

function themmoihosoantoipham(data) {
    var id_toipham = data.id_toipham;
    $('#btnThemmoihosoan').click(function () {
        id_toipham = "";
        id_toipham = data.id_toipham;

        $('#ngayluuhosomodal').val('');
        $('#frmHinhThucPhamToimodal option').removeAttr('selected');

        $('#ModalToiPham').on('show.bs.modal', function (event) {
            $('#ToiPhamTitle').html("Thêm mới hồ sơ án tội phạm");
            $('#btnThem').remove();
            $('#btnCapnhatan').remove();
            $('#ToiPhamFT').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnThem"><i class="fa fa-plus iconButtonPage"></i>Thêm hồ sơ án</button>');
        });

        setTimeout(function () {
            $('#ModalToiPham').modal('show');
            $('#btnThem').click(function () {

                var check = true;
                var tinhtranghoso = "";
                idClick = "";
                idClick = data.id_toipham;
                var ngayluuhoso = $('#ngayluuhosomodal').val();
                //var id_hinhthucphamtoi = $('#frmHinhThucPhamToimodal option:selected').attr('id');
                var id_hinhthucphamtoi = $('#frmHinhThucPhamToimodal option:selected').attr('value');


                tinhtranghoso = $("#frmTinhTrangmodal input[type='radio']:checked").val();
                if (id_hinhthucphamtoi == "0" || id_hinhthucphamtoi == "") {
                    common.showNotification('top', 'right', 'Mời bạn chọn  hình thức phạm tội !');
                    return check = false;
                }
                else if (ngayluuhoso == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập ngày lưu hồ sơ !');
                    return check = false;
                }
                else if (tinhtranghoso == "") {
                    common.showNotification('top', 'right', 'Mời bạn chọn tình trạng hồ sơ !');
                    return check = false;
                }
                else {
                    var thongtin = {
                        ngayluuhoso: ngayluuhoso,
                        id_hinhthucphamtoi: id_hinhthucphamtoi,
                        tinhtranghoso: tinhtranghoso,
                        id_toipham: id_toipham
                    }
                    var fd_data = new FormData();
                    fd_data.append('thongtin', JSON.stringify(thongtin));
                    fd_data.append('type', 'themmoihosoancuatoipham');
                    fd_data.append("stringTookenClient", stringTookenServer);

                    var table = $('#tb_danhsachtoipham').DataTable();
                    var tablehoso = $('#tb_thongtintienancuatoipham').DataTable();

                    $('#btnThem').attr('disabled', 'true');
                    swal({
                        title: 'Thêm mới thông tin',
                        text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.ajax({
                            type: "POST",
                            url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                            data: fd_data,
                            contentType: false,
                            processData: false,
                            success: function (kq) {
                                var data = JSON.parse(kq);
                                if (data.suscess) {

                                    $('#ngayluuhosomodal').val('');
                                    $('#frmHinhThucPhamToimodal option').removeAttr('selected');
                                    $('#idthuan').prop('checked', true);
                                    $('#btnCances').click();
                                    swal('Thông báo ', data.msg, 'success')

                                } else {
                                    swal('Thông báo ', data.msg, 'error')
                                }
                                $('.loader-parent').css('display', 'none');
                                table.ajax.reload(function (json) {
                                    var itemcha = json.data.filterObjects('id_toipham', idClick);
                                    if (itemcha.length > 0) {
                                        tablehoso.clear().draw();
                                        tablehoso.rows.add(itemcha[0].danhsachan).draw()
                                    }
                                });
                                $('#btnThem').removeAttr('disabled');
                            }
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh thêm mới đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThem').removeAttr('disabled');
                    });

                }

            });
        }, 230);
    });
}
function themmoitoipham() {

    var check = true;
    var tinhtranghoso = "";
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoitoipham"><i class="fa fa-plus iconButtonPage"></i>Thêm tội phạm</button>');
    $('#btnThemmoitoipham').click(function () {
        var hoten = $('#hoten').val();
        var ngaysinh = $('#ngaysinh').val();
        var sochungminhthu = $('#sochungminhthu').val();
        var hokhauthuongtru = $('#hokhauthuongtru').val();
        var quequan = $('#quequan').val();
        var bietdanh = $('#bietdanh').val();
        var ngayluuhoso = $('#ngayluuhoso').val();
        var id_hinhthucphamtoi = $('#frmHinhThucPhamToi option:selected').attr('value');
        var hinhanh = "";
        tinhtranghoso = $("#frmTinhTrang input[type='radio']:checked").val();


        var file = $('#groupFileToiPham img');
        if (file[0] != undefined) {
            var idArrt = file[0].id;
            hinhanh = $('#' + idArrt).attr('src');
        }


        if (!validateHoTen(hoten)) {
            common.showNotification('top', 'right', 'Mời bạn họ tên tội phạm và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (ngaysinh == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày sinh  !');
            return check = false;
        }
        else if (!validateCMT(sochungminhthu)) {
            common.showNotification('top', 'right', 'Mời bạn nhập số chứng minh nhân dân !');
            return check = false;
        }
        else if (!valTextboxValue(hokhauthuongtru)) {
            common.showNotification('top', 'right', 'Mời bạn nhập hộ khẩu thường trú và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (!valTextboxValue(quequan)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quê quán và không chứa ký tự đặc biệt !');
            return check = false;
        }
        else if (id_hinhthucphamtoi == "0" || id_hinhthucphamtoi == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn  hình thức phạm tội !');
            return check = false;
        }
        else if (ngayluuhoso == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày lưu hồ sơ !');
            return check = false;
        }
        else if (tinhtranghoso == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn tình trạng hồ sơ !');
            return check = false;
        }
        else {
            var thongtin = {
                hoten: hoten,
                ngaysinh: ngaysinh,
                sochungminhthu: sochungminhthu,
                hokhauthuongtru: hokhauthuongtru,
                quequan: quequan,
                bietdanh: bietdanh,
                ngayluuhoso: ngayluuhoso,
                id_hinhthucphamtoi: id_hinhthucphamtoi,
                tinhtranghoso: tinhtranghoso,
                hinhanh: hinhanh

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoithongtintoipham');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachtoipham').DataTable();

            $('#btnThemmoitoipham').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                            $('#hoten').val('');
                            $('#ngaysinh').val('');
                            $('#sochungminhthu').val('');
                            $('#hokhauthuongtru').val('');
                            $('#quequan').val('');
                            $('#bietdanh').val('');
                            $('#ngayluuhoso').val('');
                            $('#frmHinhThucPhamToi option').removeAttr('selected');
                            $('#dathuan').prop('checked', true);
                            $('#groupFileToiPham').empty();

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoitoipham').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoitoipham').removeAttr('disabled');
            });

        }
    });
}

function loadhinhthucphamtoi() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadhinhthucphamtoi' }, function (data) {
        $.each(data, function (key, val) {
            $('#frmHinhThucPhamToi').append('<option value="' + val.id_hinhthucphamtoi + '">' + val.hinhthucphamtoi + '</option>');
            $('#frmHinhThucPhamToimodal').append('<option value="' + val.id_hinhthucphamtoi + '">' + val.hinhthucphamtoi + '</option>');

        });
    });
}
function loadthongtintienancuatoipham(data) {
    var $card_content = $('#thongtintienancuatoipham');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_thongtintienancuatoipham',
            html: '<thead>\
                            <th>Hình thức phạm tội</th>\
                            <th>Ngày lưu hồ sơ</th>\
                            <th>Tình trạng hồ sơ</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_thongtintienancuatoipham').DataTable({
            data: data.danhsachan,
            "columns": [
                  {
                      data: "hinhthucphamtoi",
                  },
                  {
                      data: "ngayluuhoso", "width": "25%",
                  },
                    {
                        data: "tinhtranghoso", "width": "20%",
                        mRender: function (data) {
                            if (data == 1) {
                                data = "Chưa thụ án";
                            } else {
                                data = "Đã thụ án";
                            }
                            return data;
                        }
                    },
                      {
                          data: "button", "width": "80px",
                          mRender: function (data) {
                              if (data.sua == true && data.xoa == true) {
                                  var $dtooltip = $('<div/>', {
                                      html: '<i class="fa fa-pencil-square-o iconButton btnDetailAn" aria-hidden="true" rel="tooltip" title="Xem chi tiết hồ sơ án"></i>\
                                             <i class="fa fa-trash-o iconButton btnDeleteAn" aria-hidden="true" rel="tooltip" title="Xóa hồ sơ án"></i>'
                                  });
                                  return $dtooltip.html();
                              }
                              else if (data.sua == true) {
                                  return data = '<i class="fa fa-pencil-square-o iconButton btnDetailAn" aria-hidden="true" rel="tooltip" title="Xem chi tiết hồ sơ án"></i>';
                              }
                              else if (data.xoa == true) {
                                  return data = '<i class="fa fa-trash-o iconButton btnDeleteAn" aria-hidden="true" rel="tooltip" title="Xóa hồ sơ án"></i>';
                              }
                              return data = '';
                          }
                      },
            ],
            "pagingType": "full_numbers",
            "bSort": false,
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_thongtintienancuatoipham').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_thongtintienancuatoipham').DataTable();
        $('#tb_thongtintienancuatoipham_length label').remove();
        $('#tb_thongtintienancuatoipham_length').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoihosoan"><i class="fa fa-plus iconButtonPage"></i>Thêm mới hồ sơ</button>');

        table.on('click', 'i.btnDeleteAn', function () {

            var tableParent = $('#tb_danhsachtoipham').DataTable();
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_hoso = data.button.id_hoso;
            var id_toipham = data.button.id_toipham;
            idClick = "";
            idClick = data.button.id_toipham;

            $('.btnDeleteAn').attr('disabled', 'true');

            swal({
                title: 'Xóa hồ sơ án',
                text: "Bạn có chắc sẽ xóa hồ sơ án tội phạm này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoahosoancuatoipham', id_hoso: id_hoso, id_toipham: id_toipham }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoahosoancuatoipham', id_hoso: id_hoso, id_toipham: id_toipham }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDeleteAn').removeAttr('disabled');
                    tableParent.ajax.reload(function (json) {
                        var itemcha = json.data.filterObjects('id_toipham', idClick);
                        if (itemcha.length > 0) {
                            table.clear().draw();
                            table.rows.add(itemcha[0].danhsachan).draw()
                        }
                    });
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDeleteAn').removeAttr('disabled');
            });
        });

        table.on('click', 'i.btnDetailAn', function () {


            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_hoso = data.button.id_hoso;
            var id_toipham = data.button.id_toipham;
            var tinhtranghoso = "";
            idClick = "";
            $('#ModalToiPham').on('show.bs.modal', function (event) {
                $('#ToiPhamTitle').html("Cập nhật thông tin hồ sơ án ");
                $('#btnThem').remove();
                $('#btnCapnhatan').remove();
                $('#ToiPhamFT').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnCapnhatan"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            });

            setTimeout(function () {
                $('#ModalToiPham').modal('show');
                $('#frmHinhThucPhamToimodal').val(data.id_hinhthucphamtoi);
                if (data.tinhtranghoso == 1) {
                    $("#idchuathuan").prop("checked", true);
                } else {
                    $("#idthuan").prop("checked", true);
                }

                var dateHS = data.ngayluuhoso.substring(0, 10);

                $('#ngayluuhosomodal').val(dateHS);

                $('#btnCapnhatan').click(function () {
                    var tableParent = $('#tb_danhsachtoipham').DataTable();
                    tinhtranghoso = "";
                    var ngayluuhoso = $('#ngayluuhosomodal').val();

                    // var id_hinhthucphamtoi = $('#frmHinhThucPhamToimodal option:selected').attr('id');
                    var id_hinhthucphamtoi = $('#frmHinhThucPhamToimodal option:selected').attr('value');

                    tinhtranghoso = $("#frmTinhTrangmodal input[type='radio']:checked").val();
                    idClick = data.button.id_toipham;

                    if (id_hinhthucphamtoi == "0" || id_hinhthucphamtoi == "") {
                        common.showNotification('top', 'right', 'Mời bạn chọn  hình thức phạm tội !');
                        return check = false;
                    }
                    else if (ngayluuhoso == "") {
                        common.showNotification('top', 'right', 'Mời bạn nhập ngày lưu hồ sơ !');
                        return check = false;
                    }
                    else if (tinhtranghoso == "") {
                        common.showNotification('top', 'right', 'Mời bạn chọn tình trạng hồ sơ!');
                        return check = false;
                    }
                    else {
                        var thongtin = {
                            ngayluuhoso: ngayluuhoso,
                            id_hinhthucphamtoi: id_hinhthucphamtoi,
                            tinhtranghoso: tinhtranghoso,
                            id_hoso: id_hoso,
                            id_toipham: id_toipham
                        }
                        var fd_data = new FormData();
                        fd_data.append('thongtin', JSON.stringify(thongtin));
                        fd_data.append('type', 'capnhatthongtinhosoantoipham');
                        fd_data.append("stringTookenClient", stringTookenServer);

                        $('#btnCapnhatan').attr('disabled', 'true');
                        swal({
                            title: 'Cập nhật thông tin',
                            text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Vâng, tôi đồng ý !',
                            cancelButtonText: 'Không. cảm ơn!'
                        }).then(function () {
                            $('.loader-parent').removeAttr('style');
                            $.ajax({
                                type: "POST",
                                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                                data: fd_data,
                                contentType: false,
                                processData: false,
                                success: function (kq) {
                                    var data = JSON.parse(kq);
                                    if (data.sucess) {
                                        $('#btnCances').click();
                                        swal('Thông báo ', data.msg, 'success')
                                    } else {
                                        swal('Thông báo ', data.msg, 'error')
                                    }
                                    $('.loader-parent').css('display', 'none');
                                    $('#btnCapnhatan').removeAttr('disabled');
                                    tableParent.ajax.reload(function (json) {
                                        var itemcha = json.data.filterObjects('id_toipham', idClick);
                                        if (itemcha.length > 0) {
                                            table.clear().draw();
                                            table.rows.add(itemcha[0].danhsachan).draw()
                                        }
                                    });
                                }
                            });

                        }, function (dismiss) {
                            if (dismiss === 'cancel') {
                                swal(
                                  'Hủy bỏ ',
                                  'Lệnh cập nhật đã bị hủy bỏ ',
                                  'info'
                                )
                            }
                            $('.loader-parent').css('display', 'none');
                            $('#btnCapnhatan').removeAttr('disabled');
                        });
                    }
                });

            }, 230);
        });
    }
}

function capnhatthongtincanhantoipham(id_toipham) {
    var check = true;

    $('#btnCapnhatthongtintoipham').click(function () {

        var hoten = $('#hoten').val();
        var ngaysinh = $('#ngaysinh').val();
        var sochungminhthu = $('#sochungminhthu').val();
        var hokhauthuongtru = $('#hokhauthuongtru').val();
        var quequan = $('#quequan').val();
        var bietdanh = $('#bietdanh').val();
        var hinhanh = "";
        var getlabel = $('#groupFileToiPham label');
        var checklabel = getlabel[0].textContent;

        if (checklabel == "ok") {
            var file = $('#groupFileToiPham img');
            var idArrt = file[0].id;
            hinhanh = $('#' + idArrt).attr('src');
        }

        if (!validateHoTen(hoten)) {
            common.showNotification('top', 'right', 'Mời bạn họ tên tội phạm và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (ngaysinh == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày sinh  !');
            return check = false;
        }
        else if (!validateCMT(sochungminhthu)) {
            common.showNotification('top', 'right', 'Mời bạn nhập số chứng minh nhân dân !');
            return check = false;
        }
        else if (!valTextboxValue(hokhauthuongtru)) {
            common.showNotification('top', 'right', 'Mời bạn nhập hộ khẩu thường trú và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (!valTextboxValue(quequan)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quê quán và không chứa ký tự đặc biệt !');
            return check = false;
        }

        else {
            var thongtin = {
                hoten: hoten,
                ngaysinh: ngaysinh,
                sochungminhthu: sochungminhthu,
                hokhauthuongtru: hokhauthuongtru,
                quequan: quequan,
                bietdanh: bietdanh,
                id_toipham: id_toipham,
                hinhanh: hinhanh

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincanhantoipham');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachtoipham').DataTable();


            $('#btnCapnhatthongtintoipham').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnCapnhatthongtintoipham').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnCapnhatthongtintoipham').removeAttr('disabled');
            });
        }
    });
}

// QUẢN LÝ THĂM DÒ Ý KIẾN - ok

function initQuanLyThamDoYKien() {
    curentPage = 0;

    $('#liaddnew').click(function () {
        $('#cauhoi').val('');
        $('#luunhap').prop('checked', true);
        $('#lblHienthingay').text('');
        $('#lblTuNgay').text('');
        $('#lblDenNgay').text('');
        $('#fullDateStart').val('');
        $('#timeStart').val('');
        $('#fullDateEnd').val('');
        $('#timeEnd').val('');
        $('#toanthoigianbatdau').css('display', 'none');
        $('#toanthoigianketthuc').css('display', 'none');
        $('#formDatLich').css('display', 'none');
        $('#formdapan').empty();
        $('#formgrdapan').css('display', 'none');
        $('#frmHinhThucTraLoi option').removeAttr('selected');

        $('#themmoialbumanh').addClass('active');
        themmoicauhoithamdoykien();
        $('#frmShowIMG').css('display', 'none');
    });
    $('#lidanhsach').click(function () {
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#liaddnew').css('display', 'block');
        $('#themmoialbumanh').removeClass('active');


        $('#cauhoi').val('');
        //  $('#frmHinhThucTraLoi option[id="drop00"]').attr("selected", "selected");
        $('#frmHinhThucTraLoi option').removeAttr('selected');
        $('#luunhap').prop('checked', true);
        $('#lblHienthingay').text('');
        $('#lblTuNgay').text('');
        $('#lblDenNgay').text('');
        $('#fullDateStart').val('');
        $('#timeStart').val('');
        $('#fullDateEnd').val('');
        $('#timeEnd').val('');
        $('#toanthoigianbatdau').css('display', 'none');
        $('#toanthoigianketthuc').css('display', 'none');
        $('#formDatLich').css('display', 'none');
        $('#formdapan').empty();
        $('#formgrdapan').css('display', 'none');
        $('#tb_danhsachalbumanh').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachcauhoithamdoykien&id=0').load();
    });

    loadhinhthuctraloithamdoykien();

    $('#frmtrangthai input:radio').change(function () {
        var trangthai = $(this)[0].id;
        if (trangthai == "hienthi") {
            $('#formDatLich').css('display', 'block');
            $('#toanthoigianbatdau').css('display', 'none');
            $('#toanthoigianketthuc').css('display', 'block');
        } else if (trangthai == "datlich") {
            $('#formDatLich').css('display', 'block');
            $('#toanthoigianbatdau').css('display', 'block');
            $('#toanthoigianketthuc').css('display', 'block');
        } else {
            $('#toanthoigianbatdau').css('display', 'none');
            $('#toanthoigianketthuc').css('display', 'none');
            $('#formDatLich').css('display', 'none');
        }
    });

    loaddanhsachcauhoithamdoykien();
}

function themmoicauhoithamdoykien() {
    $('#frmHinhThucTraLoi').prop('disabled', false);
    var trangthai;
    var check = true;
    var listDapAn = new Array();
    var trangthai = "";
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="addnew"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');

    $('#frmHinhThucTraLoi').change(function () {
        $('#formdapan').empty();
        //var idFrmHinhThuc = $('#frmHinhThucTraLoi option:selected').attr('id');
        var idFrmHinhThuc = $('#frmHinhThucTraLoi option:selected').attr('value');


        if (idFrmHinhThuc == "drop00") {
            $('#formdapan').empty();
            $('#formgrdapan').css('display', 'none');
        } else if (idFrmHinhThuc == 1 || idFrmHinhThuc == 2) {
            $('#formdapan').empty();
            $('#formgrdapan').css('display', 'block');
            $('#formdapan').append('<button id="btnCreateAnser" type="button">Thêm đáp án</button> Nội dung đáp án không chứa ký tự đặc biệt nếu có sẽ tự động xóa\
                                    <label id="lblThongbaotaomoi"></label>\
                                        <div class="row">\
                                            <div id="frmaddnewAnser" class="col-sm-12">\
                                                <div class="row">\
                                                    <div class="col-sm-10">\
                                                        <input id="'+ makeid() + '" type="text" class="form-control help-block">\
                                                    </div>\
                                                    <div class="col-sm-2">\
                                                        <button type="button" id="' + makeid() + '" class="btn btn-primary btn-flat IconXoaCauHoi form-control help-block"><i class="fa fa-trash-o iconButtonPage"></i>Xóa</button>\
                                                    </div>\
                                                </div>\
                                            </div>\
                                        </div>');

            $('#btnCreateAnser').click(function () {
                var dem = $('#frmaddnewAnser button');
                if (dem.length <= 5) {
                    $('#frmaddnewAnser').append('<div class="row">\
                                                    <div class="col-sm-10">\
                                                        <input id="' + makeid() + '" type="text" class="form-control help-block">\
                                                    </div>\
                                                    <div class="col-sm-2">\
                                                        <button type="button" id="' + makeid() + '" class="btn btn-primary btn-flat IconXoaCauHoi form-control help-block"><i class="fa fa-trash-o iconButtonPage"></i>Xóa</button>\
                                                    </div>\
                                                </div>');
                } else {
                    $('#lblThongbaotaomoi').text("Chỉ có thể tạo tối đa 6 đáp án");
                }
                var xoa = $('#frmaddnewAnser button');
                $.each(xoa, function (key, val) {
                    $('#frmaddnewAnser button').click(function () {
                        if (xoa.length <= 6) {
                            $('#lblThongbaotaomoi').text('');
                        }
                        var a = $(this).parent();
                        a.parent().remove();
                        a.remove();
                        $(this).remove();
                    });

                });
            });
        } else {
            $('#formdapan').empty();
            $('#formgrdapan').css('display', 'none');
        }
    });


    $('#addnew').click(function () {
        listDapAn = [];
        var cauhoi = $('#cauhoi').val();
        //  var id_hinhthuctraloi = $('#frmHinhThucTraLoi option:selected').attr('id');
        var id_hinhthuctraloi = $('#frmHinhThucTraLoi option:selected').attr('value');


        var txtdapan = $('#frmaddnewAnser input');
        $.each(txtdapan, function (key, val) {
            var idtxtDapan = val.id;
            var duongdan = $('#' + idtxtDapan).val();
            if (!valTextboxValue(duongdan)) {
                $(this).parent().parent().remove();
            } else {
                listDapAn.push(duongdan);
            }
        });
        trangthai = $("#frmHienthi input[type='radio']:checked").val();

        var ngaybd = $('#fullDateStart').val();
        var giobd = $('#timeStart').val();
        var ngaykt = $('#fullDateEnd').val();
        var giokt = $('#timeEnd').val();

        if (trangthai == "hienthi") {
            $('#lblHienthingay').text(ngaykt + " " + giokt);
        } else if (trangthai == "datlich") {
            $('#lblTuNgay').text(ngaybd + " " + giobd);
            $('#lblDenNgay').text(ngaykt + " " + giokt);
        } else {
            $('#lblHienthingay').text('');
            $('#lblTuNgay').text('');
            $('#lblDenNgay').text('');
        }
        var ngayketthuc = $('#lblHienthingay').text();

        var tungay = $('#lblTuNgay').text();
        var denngay = $('#lblDenNgay').text();

        if (!valTextboxValue(cauhoi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (id_hinhthuctraloi == "" || id_hinhthuctraloi == "drop00") {
            common.showNotification('top', 'right', 'Mời bạn chọn hình thức trả lời cho câu hỏi !');
            return check = false;
        }
        else if (listDapAn.length <= 0 && id_hinhthuctraloi != 3) {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        }
        else if (trangthai == "") {
            common.showNotification('top', 'right', 'Trạng thái hiển thị chưa được chọn !');
            return check = false;
        } else if (trangthai == "hienthi" && ngayketthuc == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ngày kết thúc thăm dò ý kiến cho câu hỏi !');
            return check = false;
        }
        else if (trangthai == "datlich" && (tungay == "" || denngay == "")) {
            common.showNotification('top', 'right', 'Mời bạn chọn đủ ngày bắt đầu và kết thúc thăm dò ý kiến của câu hỏi !');
            return check = false;
        }
        else {
            var thongtin = {
                cauhoi: cauhoi,
                id_hinhthuctraloi: id_hinhthuctraloi,
                trangthai: trangthai,
                ngayketthuc: ngayketthuc,
                tungay: tungay,
                denngay: denngay
            }
            var fd_data = new FormData();
            fd_data.append('listDapAn', JSON.stringify(listDapAn));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoicauhoithamdoykien');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachalbumanh').DataTable();

            $('#addnew').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#cauhoi').val('');
                            //    $('#frmHinhThucTraLoi option[id="drop00"]').attr("selected", "selected");
                            $('#frmHinhThucTraLoi option').removeAttr('selected');
                            $('#luunhap').prop('checked', true);
                            $('#lblHienthingay').text('');
                            $('#lblTuNgay').text('');
                            $('#lblDenNgay').text('');
                            $('#fullDateStart').val('');
                            $('#timeStart').val('');
                            $('#fullDateEnd').val('');
                            $('#timeEnd').val('');
                            $('#toanthoigianbatdau').css('display', 'none');
                            $('#toanthoigianketthuc').css('display', 'none');
                            $('#formDatLich').css('display', 'none');
                            $('#formdapan').empty();
                            $('#formgrdapan').css('display', 'none');

                        } else {
                            // $('#frmaddnewAnser').empty();
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#addnew').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#addnew').removeAttr('disabled');
            });

        }
    });


}

function loadhinhthuctraloithamdoykien() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadhinhthuctraloithamdoykien' }, function (data) {
        $.each(data, function (key, val) {
            $('#frmHinhThucTraLoi').append('<option value="' + val.id_hinhthuctraloi + '">' + val.hinhthuctraloi + '</option>');
        });
    });
}

function loaddanhsachcauhoithamdoykien() {
    var $card_content = $('#danhsachalbumanh');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachalbumanh',
            html: '<thead>\
                            <th>Câu hỏi</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachalbumanh').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachcauhoithamdoykien&id=0',
            "columns": [
                  {
                      data: "cauhoi",
                  },
                  {
                      data: "trangthai", "width": "20%",
                      mRender: function (data) {
                          if (data == 3) {
                              data = "Đặt lịch";
                          } else if (data == 2) {
                              data = "Hiển thị";
                          } else {
                              data = "Chỉ lưu";
                          }
                          return data;
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết câu hỏi"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết câu hỏi"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachcauhoithamdoykien&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            "bSort": false,
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.cauhoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.hinhthuctraloi.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_cauhoithamdo) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachcauhoithamdoykien&id=" + u.item.id_cauhoithamdo;
                                settings.id = u.item.id_cauhoithamdo;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.cauhoi + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
        });
        var parent = $('#tb_danhsachalbumanh').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachalbumanh').DataTable();
        var listXoa = new Array();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoithamdo = data.id_cauhoithamdo;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa tình huống',
                text: "Bạn có chắc sẽ xóa phiếu thăm dò này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoaphieuthamdoykien', id_cauhoithamdo: id_cauhoithamdo }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoaphieuthamdoykien', id_cauhoithamdo: id_cauhoithamdo }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoithamdo = data.id_cauhoithamdo;
            listXoa = [];
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#liaddnew').css('display', 'none');
            $('#themmoialbumanh').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachalbumanh').removeClass('active');

            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateDetails"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');


            $('#cauhoi').val(data.cauhoi);
            $('#frmHinhThucTraLoi').val(data.id_hinhthuctraloi);
            $('#frmHinhThucTraLoi').attr('disabled', true);

            if (data.id_hinhthuctraloi == "drop00") {
                $('#formdapan').empty();
                $('#formgrdapan').css('display', 'none');
            } else if (data.id_hinhthuctraloi == 1 || data.id_hinhthuctraloi == 2) {
                $('#formdapan').empty();
                $('#formgrdapan').css('display', 'block');
                $('#formdapan').append('<button id="btnCreateAnser" type="button">Thêm đáp án</button> Nội dung đáp án không chứa ký tự đặc biệt nếu có sẽ tự động xóa\
                                    <label id="lblThongbaotaomoi"></label>\
                                        <div class="row">\
                                            <div id="frmaddnewAnser" class="col-sm-12">\
                                            </div>\
                                        </div>');
                $.each(data.danhsachdapan, function (key, val) {
                    $('#frmaddnewAnser').append('<div class="row">\
                                                    <div class="col-sm-10">\
                                                        <input id="' + val.id_dapanthamdo + '" type="text" value="' + val.noidungtraloi + '" class="form-control help-block">\
                                                    </div>\
                                                    <div class="col-sm-2">\
                                                        <button type="button" id="' + makeid() + '" class="btn btn-primary btn-flat IconXoaCauHoi form-control help-block"><i class="fa fa-trash-o iconButtonPage"></i>Xóa</button>\
                                                    </div>\
                                                </div>');

                });

                $('#btnCreateAnser').click(function () {
                    var dem = $('#frmaddnewAnser button');
                    if (dem.length <= 5) {
                        $('#frmaddnewAnser').append('<div class="row">\
                                                            <div class="col-sm-10">\
                                                                <input id="' + makeid() + '" type="text" class="form-control help-block">\
                                                            </div>\
                                                            <div class="col-sm-2">\
                                                                <button type="button" id="' + makeid() + '" class="btn btn-primary btn-flat IconXoaCauHoi form-control help-block"><i class="fa fa-trash-o iconButtonPage"></i>Xóa</button>\
                                                            </div>\
                                                        </div>');
                    } else {
                        $('#lblThongbaotaomoi').text("Chỉ có thể tạo tối đa 6 đáp án");
                    }

                    $('#frmaddnewAnser button').click(function () {

                        var a = $(this).parent();
                        a.parent().remove();
                        a.remove();
                        $(this).remove();

                    });
                });
                $('#frmaddnewAnser button').click(function () {

                    var a = $(this).parent();
                    var idDapanXoa = a.prev().children()[0].id;
                    listXoa.push(idDapanXoa);
                    a.parent().remove();
                    a.remove();
                    $(this).remove();
                });

            } else {
                $('#formdapan').empty();
                $('#formgrdapan').css('display', 'none');
            }
            if (data.trangthai == 3) {
                $("#datlich").prop("checked", true);
                $('#toanthoigianbatdau').css('display', 'block');
                $('#toanthoigianketthuc').css('display', 'block');

                var datestart = new Date(data.ngaybatdau);
                var ngaystart = (datestart.getMonth() + 1) + '/' + (datestart.getDate()) + '/' + datestart.getFullYear();
                $('#fullDateStart').val(ngaystart);

                var timestart = data.ngayketthuc.substring(11, 16);
                $('#timeStart').val(timestart);


                var dateend = new Date(data.ngayketthuc);
                var ngayend = (dateend.getMonth() + 1) + '/' + (dateend.getDate()) + '/' + dateend.getFullYear();
                $('#fullDateEnd').val(ngayend);

                var timeend = data.ngayketthuc.substring(11, 16);
                $('#timeEnd').val(timeend);
            } else if (data.trangthai == 2) {
                $("#hienthi").prop("checked", true);
                $('#toanthoigianbatdau').css('display', 'none');
                $('#toanthoigianketthuc').css('display', 'block');


                var dateend = new Date(data.ngayketthuc);
                var ngayend = (dateend.getMonth() + 1) + '/' + (dateend.getDate()) + '/' + dateend.getFullYear();
                $('#fullDateEnd').val(ngayend);

                var timeend = data.ngayketthuc.substring(11, 16);
                $('#timeEnd').val(timeend);
            }
            else {
                $("#luunhap").prop("checked", true);
                $('#toanthoigianbatdau').css('display', 'none');
                $('#toanthoigianketthuc').css('display', 'none');
            }

            capnhatthongtincauhoithamdoykien(id_cauhoithamdo, listXoa);
        });
    }
}

function capnhatthongtincauhoithamdoykien(id_cauhoithamdo, listXoa) {


    var trangthai;
    var check = true;
    var listDapAn = new Array();
    var trangthai = "";
    $('#btnUpdateDetails').click(function () {

        listDapAn = [];
        var cauhoi = $('#cauhoi').val();
        var id_hinhthuctraloi = $('#frmHinhThucTraLoi option:selected').attr('value');

        var txtdapan = $('#frmaddnewAnser input');
        $.each(txtdapan, function (key, val) {
            var idtxtDapan = val.id;
            var duongdan = $('#' + idtxtDapan).val();
            if (!valTextboxValue(duongdan)) {
                $(this).parent().parent().remove();
            } else {
                listDapAn.push(duongdan);
            }
        });
        trangthai = $("#frmHienthi input[type='radio']:checked").val();

        var ngaybd = $('#fullDateStart').val();
        var giobd = $('#timeStart').val();
        var ngaykt = $('#fullDateEnd').val();
        var giokt = $('#timeEnd').val();

        if (trangthai == "hienthi") {
            $('#lblHienthingay').text(ngaykt + " " + giokt);
        } else if (trangthai == "datlich") {
            $('#lblTuNgay').text(ngaybd + " " + giobd);
            $('#lblDenNgay').text(ngaykt + " " + giokt);
        } else {
            $('#lblHienthingay').text('');
            $('#lblTuNgay').text('');
            $('#lblDenNgay').text('');
        }
        var ngayketthuc = $('#lblHienthingay').text();

        var tungay = $('#lblTuNgay').text();
        var denngay = $('#lblDenNgay').text();

        if (!valTextboxValue(cauhoi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi và không chứa ký tự đặc biệt !');
            return check = false;
        } else if (id_hinhthuctraloi == "" || id_hinhthuctraloi == "drop00") {
            common.showNotification('top', 'right', 'Mời bạn chọn hình thức trả lời cho câu hỏi !');
            return check = false;
        }
        else if (listDapAn.length <= 0 && id_hinhthuctraloi != 3) {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        }
        else if (trangthai == "") {
            common.showNotification('top', 'right', 'Trạng thái hiển thị chưa được chọn !');
            return check = false;
        } else if (trangthai == "hienthi" && ngayketthuc == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ngày kết thúc thăm dò ý kiến cho câu hỏi !');
            return check = false;
        }
        else if (trangthai == "datlich" && (tungay == "" || denngay == "")) {
            common.showNotification('top', 'right', 'Mời bạn chọn đủ ngày bắt đầu và kết thúc thăm dò ý kiến của câu hỏi !');
            return check = false;
        }
        else {
            var thongtin = {
                cauhoi: cauhoi,
                id_hinhthuctraloi: id_hinhthuctraloi,
                trangthai: trangthai,
                ngayketthuc: ngayketthuc,
                tungay: tungay,
                denngay: denngay,
                id_cauhoithamdo: id_cauhoithamdo
            }
            var fd_data = new FormData();
            fd_data.append('listXoa', JSON.stringify(listXoa));
            fd_data.append('listDapAn', JSON.stringify(listDapAn));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincauhoithamdoykien');
            fd_data.append("stringTookenClient", stringTookenServer);


            var table = $('#tb_danhsachalbumanh').DataTable();


            $('#btnUpdateDetails').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateDetails').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateDetails').removeAttr('disabled');
            });
        }
    });
}


//QUẢN LÝ TRANG THƯ VIỆN VIDEO - ok


function initQuanLyThuVienVideo() {
    curentPage = 0;

    var button = $('#groupChosefileVideo .buttonVideo');
    $.each(button, function (key, val) {
        $(this).click(function () {
            window.open(window.location.origin + "/file-video", "Chọn file upload", "height=600,width=1000");
        });
    });

    $('#liaddnew').click(function () {
        $('#themmoialbumanh').addClass('active');
        $('#frmCheckBox option').removeAttr('selected');
        themmmoiAlbumVideo();
        $('#frmShowIMG').css('display', 'none');
    });
    $('#lidanhsach').click(function () {
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#liaddnew').css('display', 'block');
        $('#themmoialbumanh').removeClass('active');
        $('#frmCheckBox option').removeAttr('selected');
        $('#tieude').val('');
        $('#gioithieu').val('');
        $('#tacgia').val('');
        CKEDITOR.instances['txt_noidung'].setData('');
        $('#hienthi').prop('checked', true);
        $('#groupFile').empty();
        $('#groupFileVideo').empty();
        $('#tb_danhsachalbumanh').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumVideo&id=0').load();
    });

    loaddanhsachdanhmuccuaalbumanh();
    danhsachAlbumVideo();
}

function danhsachAlbumVideo() {
    var $card_content = $('#danhsachalbumanh');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachalbumanh',
            html: '<thead>\
                            <th></th>\
                            <th>Tên Album</th>\
                            <th>Thuộc danh mục</th>\
                            <th>SL video</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachalbumanh').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumVideo&id=0',
            "columns": [
                  { data: "ngayupload" },
                  {
                      data: "tieude",
                  },
                  { data: "tendanhmuc", "width": "20%", },
                  { data: "soluonganh", "width": "10%", },
                  {
                      data: "trangthaithuvien", "width": "15%",
                      mRender: function (data) {
                          if (data == 2) {
                              data = "Hiển thị";
                          } else {
                              data = "Chỉ lưu";
                          }
                          return data;
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết album"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa album"></i>'
                              });
                              return $dtooltip.html();
                          } else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết album"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa album"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
             {
                 "targets": [0],
                 "visible": false,
                 "searchable": false
             },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumVideo&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tendanhmuc.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_thuvien) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumVideo&id=" + u.item.id_thuvien;
                                settings.id = u.item.id_thuvien;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachalbumanh').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachalbumanh').DataTable();
        var listXoa = new Array();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_thuvien = data.id_thuvien;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa Album',
                text: "Bạn có chắc sẽ xóa album này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoaalbumanh', id_thuvien: id_thuvien }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoaalbumanh', id_thuvien: id_thuvien }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_thuvien = data.id_thuvien;
            listXoa = [];

            $('#frmShowIMG').css('display', 'block');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#liaddnew').css('display', 'none');
            $('#themmoialbumanh').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachalbumanh').removeClass('active');

            $('#showImg').empty();
            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateDetails"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');


            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            if (data.trangthaithuvien == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#luunhap").prop("checked", true);
            }
            $('#frmCheckBox').val(data.id_danhmuc);

            $.each(data.danhsachanh, function (key, val) {
                $('#showImg').append('<div class="col-sm-4" style="margin-bottom: 10px;"><div class="row"><video id="' + val.id_chitietthuvien + '" src="' + val.duongdanfile + '" class="class="col-sm-10"" width="100%" height="120px" controls>\
         <source src="'+ val.duongdanfile + '" type="video/mp4">\
         </video><i class="fa fa-trash-o iconButton iconremove" aria-hidden="true" rel="tooltip" title="Xóa khỏi album"></i></div></div>');
            });


            $('.buttonxoa').click(function () {
                var tk = $('#showImg video');
                if (tk.length == 1) {
                    $('#showImg').append('<label class="control-label">Đã xóa hết video trong album</label>');
                }
            });

            $('#showImg i').click(function () {
                listXoa.push($(this).prev()[0].id);
                $(this).parent().parent().remove();
                //   $(this).remove();
            });
            capnhatthongtinAlbumVideo(id_thuvien, listXoa);
        });
    }
}


function capnhatthongtinAlbumVideo(id_thuvien, listXoa) {
    var trangthai;
    var check = true;
    var listImages = new Array();
    var trangthaithuvien = "";


    $('#btnUpdateDetails').click(function () {
        listImages = [];
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var tacgia = $('#tacgia').val();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        trangthaithuvien = $("#frmHienthi input[type='radio']:checked").val();
        var id_danhmuc = $('#frmCheckBox option:selected').attr('value');

        var file = $('#groupFileVideo video');
        $.each(file, function (key, val) {
            var idArrt = val.id;
            var duongdan = $('#' + idArrt).attr('src');
            listImages.push(duongdan);

        });


        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề cho Album !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả cho Album !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả của Album !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung giới thiệu về Album !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                tacgia: tacgia,
                trangthaithuvien: trangthaithuvien,
                noidung: noidung,
                id_danhmuc: id_danhmuc,
                id_thuvien: id_thuvien
            }
            var fd_data = new FormData();
            fd_data.append('listImages', JSON.stringify(listImages));
            fd_data.append('listXoa', JSON.stringify(listXoa));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinalbumanh');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachalbumanh').DataTable();

            $('#btnUpdateDetails').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        table.ajax.reload();
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateDetails').removeAttr('disabled');
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateDetails').removeAttr('disabled');
            });
        }
    });

}

function getLinkVideoServer(link) {

    $('#groupFileVideo').append('<div class="help-block col-sm-4"><div class="row"><video id="' + makeid() + '" src="' + link + '" width="100%" height="120px" controls>\
         <source src="'+ link + '" type="video/mp4">\
         </video><i class="fa fa-trash-o iconButton iconremove" aria-hidden="true" rel="tooltip" title="Xóa khỏi album"></i></div></div>');

    var xoa = $('#groupFileVideo i');
    $.each(xoa, function (key, val) {
        $('#groupFileVideo i').click(function () {
            $(this).parent().parent().remove();
        });
    });
}

function themmmoiAlbumVideo() {
    var trangthai;
    var check = true;
    var listImages = new Array();
    var trangthaithuvien = "";
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="addnew"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');

    $('#addnew').click(function () {
        listImages = [];
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var tacgia = $('#tacgia').val();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        trangthaithuvien = $("#frmHienthi input[type='radio']:checked").val();
        var id_danhmuc = $('#frmCheckBox option:selected').attr('value');

        var file = $('#groupFileVideo video');
        $.each(file, function (key, val) {
            var idArrt = val.id;
            var duongdan = $('#' + idArrt).attr('src');
            listImages.push(duongdan);

        });
        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề cho Album !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả cho Album !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả của Album !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung giới thiệu về Album !');
            return check = false;
        } else if (listImages.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn video cho Album !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                tacgia: tacgia,
                trangthaithuvien: trangthaithuvien,
                noidung: noidung,
                id_danhmuc: id_danhmuc
            }
            var fd_data = new FormData();
            fd_data.append('listImages', JSON.stringify(listImages));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoithuvienVideoClient');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachalbumanh').DataTable();


            $('#addnew').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            $('#hienthi').prop('checked', true);
                            $('#groupFileVideo').empty();

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#addnew').removeAttr('disabled');
                        $('#frmCheckBox option').removeAttr('selected');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#addnew').removeAttr('disabled');
            });

        }
    });

}

//QUẢN LÝ TRANG THƯ VIỆN ẢNH - ok

function initQuanLyThuVien() {
    curentPage = 0;

    var button = $('#groupChosefile .button123');
    $.each(button, function (key, val) {
        $(this).click(function () {
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });

    $('#liaddnew').click(function () {
        $('#themmoialbumanh').addClass('active');
        $('#frmCheckBox option').removeAttr('selected');
        themmmoialbumsanh();
        $('#frmShowIMG').css('display', 'none');
    });
    $('#lidanhsach').click(function () {
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#liaddnew').css('display', 'block');
        $('#themmoialbumanh').removeClass('active');
        $('#frmCheckBox option').removeAttr('selected');
        $('#tieude').val('');
        $('#gioithieu').val('');
        $('#tacgia').val('');
        CKEDITOR.instances['txt_noidung'].setData('');
        $('#hienthi').prop('checked', true);
        $('#groupFile').empty();
        $('#tb_danhsachalbumanh').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumAnh&id=0').load();
    });

    loaddanhsachdanhmuccuaalbumanh();
    danhsachAlbumAnh();
}

function themmmoialbumsanh() {
    var trangthai;
    var check = true;
    var listImages = new Array();
    var trangthaithuvien = "";
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="addnew"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');

    $('#addnew').click(function () {
        listImages = [];
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var tacgia = $('#tacgia').val();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        trangthaithuvien = $("#frmHienthi input[type='radio']:checked").val();
        var id_danhmuc = $('#frmCheckBox option:selected').attr('value');

        var file = $('#groupFile img');
        $.each(file, function (key, val) {
            var idArrt = val.id;
            var duongdan = $('#' + idArrt).attr('src');
            listImages.push(duongdan);
        });

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề cho Album !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả cho Album !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả của Album !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung giới thiệu về Album !');
            return check = false;
        } else if (listImages.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh cho Album !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                tacgia: tacgia,
                trangthaithuvien: trangthaithuvien,
                noidung: noidung,
                id_danhmuc: id_danhmuc
            }
            var fd_data = new FormData();
            fd_data.append('listImages', JSON.stringify(listImages));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoithuvienanhClient');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachalbumanh').DataTable();

            $('#addnew').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            $('#hienthi').prop('checked', true);
                            $('#groupFile').empty();

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#frmCheckBox option').removeAttr('selected');
                        $('#addnew').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#addnew').removeAttr('disabled');
            });
        }
    });

}

function loaddanhsachdanhmuccuaalbumanh() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachdanhmuccuaalbumanh' }, function (data) {
        $.each(data, function (key, val) {
            $('#frmCheckBox').append('<option value="' + val.id_danhmuc + '">' + val.tendanhmuc + '</option>');
        });
    });
}

function danhsachAlbumAnh() {
    var $card_content = $('#danhsachalbumanh');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachalbumanh',
            html: '<thead>\
                            <th></th>\
                            <th>Tên Album</th>\
                            <th>Thuộc danh mục</th>\
                            <th>SL ảnh</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachalbumanh').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumAnh&id=0',
            "columns": [
                  { data: "ngayupload" },
                  {
                      data: "tieude",
                  },
                  { data: "tendanhmuc", "width": "20%", },
                  { data: "soluonganh", "width": "10%", },
                  {
                      data: "trangthaithuvien", "width": "15%",
                      mRender: function (data) {
                          if (data == 2) {
                              data = "Hiển thị";
                          } else {
                              data = "Chỉ lưu";
                          }
                          return data;
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết album"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa album"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết album"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa album"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
             {
                 "targets": [0],
                 "visible": false,
                 "searchable": false
             },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumAnh&id=0";
                        settings.id = 0;
                    }
                }
            },

            "pagingType": "full_numbers",
            initComplete: function (settings, json) {


                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tendanhmuc.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_thuvien) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachAlbumAnh&id=" + u.item.id_thuvien;
                                settings.id = u.item.id_thuvien;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachalbumanh').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachalbumanh').DataTable();
        var listXoa = new Array();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_thuvien = data.id_thuvien;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa Album',
                text: "Bạn có chắc sẽ xóa album này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoaalbumanh', id_thuvien: id_thuvien }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoaalbumanh', id_thuvien: id_thuvien }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_thuvien = data.id_thuvien;
            listXoa = [];

            $('#frmShowIMG').css('display', 'block');
            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#liaddnew').css('display', 'none');
            $('#themmoialbumanh').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachalbumanh').removeClass('active');

            $('#showImg').empty();
            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateDetails"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');




            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            if (data.trangthaithuvien == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#luunhap").prop("checked", true);
            }
            $('#frmCheckBox').val(data.id_danhmuc);

            $.each(data.danhsachanh, function (key, val) {
                $('#showImg').append('<div class="col-sm-4" style="margin-bottom: 10px;"><div class="row"><img class="col-sm-10" id="' + val.id_chitietthuvien + '" src ="' + val.duongdanfile + '" style="width:80%;height:120px"/><i class="fa fa-trash-o iconButton buttonxoa" aria-hidden="true" rel="tooltip" title="Xóa bỏ ảnh"></i></div></div>');
            });

            $('.buttonxoa').click(function () {
                var tk = $('#showImg img');
                if (tk.length == 1) {
                    $('#showImg').append('<label class="control-label">Đã xóa hết ảnh trong album</label>');
                }
            });

            $('#showImg i').click(function () {
                listXoa.push($(this).prev()[0].id);
                $(this).parent().parent().remove();
            });
            capnhatthongtinalbumanh(id_thuvien, listXoa);
        });
    }
}

function capnhatthongtinalbumanh(id_thuvien, listXoa) {
    var trangthai;
    var check = true;
    var listImages = new Array();
    var trangthaithuvien = "";

    $('#btnUpdateDetails').click(function () {
        listImages = [];
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var tacgia = $('#tacgia').val();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        trangthaithuvien = $("#frmHienthi input[type='radio']:checked").val();
        var id_danhmuc = $('#frmCheckBox option:selected').attr('value');

        var file = $('#groupFile img');
        $.each(file, function (key, val) {
            var idArrt = val.id;
            var duongdan = $('#' + idArrt).attr('src');
            listImages.push(duongdan);
        });


        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề cho Album !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả cho Album !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả của Album !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung giới thiệu về Album !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                tacgia: tacgia,
                trangthaithuvien: trangthaithuvien,
                noidung: noidung,
                id_danhmuc: id_danhmuc,
                id_thuvien: id_thuvien
            }
            var fd_data = new FormData();
            fd_data.append('listImages', JSON.stringify(listImages));
            fd_data.append('listXoa', JSON.stringify(listXoa));
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinalbumanh');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachalbumanh').DataTable();

            $('#btnUpdateDetails').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateDetails').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateDetails').removeAttr('disabled');
            });
        }
    });

}

//QUẢN LÝ TRANG HƯỚNG DẪN XỬ LÝ TÌNH HUỐNG - ok

function initQuanLyHuongDanXuLyTinhHuong() {
    curentPage = 0;
    loadallhuongdanxulytinhhuong();


    $('#liaddnew').click(function () {

        $('#themmoitinhhuong').addClass('active');
        $('#btnUpdateDetails').remove();
        $('#btnThemmoitinhhuong').remove();
        $('#frmButton').empty();
        $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoitinhhuong"><i class="fa fa-plus iconButtonPage"></i>Thêm tình huống</button>');
        themmoitinhhuongsuly();
    });
    $('#lidanhsach').click(function () {
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#liaddnew').css('display', 'block');
        $('#themmoitinhhuong').removeClass('active');

        $('#tieude').val('');
        $('#tinhhuong').val('');
        CKEDITOR.instances['txt_noidung'].setData();
        $('#hengio').prop('checked', true);

        $('#tb_danhsachtinhhuong').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachtinhhuong&id=0').load();
    });
}
function loadallhuongdanxulytinhhuong() {
    var $card_content = $('#danhsachtinhhuong');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachtinhhuong',
            html: '<thead>\
                            <th></th>\
                            <th>Tình huống</th>\
                            <th>Hướng dẫn</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachtinhhuong').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachtinhhuong&id=0',
            "columns": [
                  { data: "ngaytao" },
                  {
                      data: "dsguive", "width": "30%",
                      mRender: function (data) {
                          if (data.tinhhuong.length > 20) {
                              data.tinhhuong = data.tinhhuong.substring(0, 20) + "....";
                          }
                          if (data.trangthai == 2) {
                              return "<span>" + data.tinhhuong + "</span>";
                          }
                          else {
                              return data.tinhhuong;
                          }
                      }
                  },
                  {
                      data: "dsguive", "width": "40%",
                      mRender: function (data) {
                          if (data.cachxuly.length > 100) {
                              data.cachxuly = data.cachxuly.substring(0, 100) + "....";
                          }
                          if (data.trangthai == 2) {
                              return "<span>" + data.cachxuly + "</span>";
                          }
                          else {
                              return data.cachxuly;
                          }
                      }
                  },
                   {
                       data: "dsguive",
                       mRender: function (data) {
                           var text = "";
                           if (data.trangthai == 2) {
                               text = "Hiển thị";
                           } else {
                               text = "Chỉ lưu";
                           }
                           if (data.trangthai == 2) {
                               return "<span>" + text + "</span>";
                           }
                           else {
                               return text;
                           }
                       }
                   },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết liên lạc"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên lạc"></i>'
                              });
                              return $dtooltip.html();
                          } else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết liên lạc"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên lạc"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
             {
                 "targets": [0],
                 "visible": false,
                 "searchable": false
             },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachtinhhuong&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {

                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tinhhuong.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.cachxuly.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.ngaytao.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_huongdan) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachtinhhuong&id=" + u.item.id_huongdan;
                                settings.id = u.item.id_huongdan;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachtinhhuong').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachtinhhuong').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_huongdan = data.id_huongdan;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa tình huống',
                text: "Bạn có chắc sẽ xóa tình huống này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoahuongdantinhhuongsayra', id_huongdan: id_huongdan }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoahuongdantinhhuongsayra', id_huongdan: id_huongdan }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_huongdan = data.id_huongdan;

            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#liaddnew').css('display', 'none');
            $('#themmoitinhhuong').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachtinhhuong').removeClass('active');

            $('#btnUpdateDetails').remove();
            $('#btnThemmoitinhhuong').remove();
            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateDetails"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#tinhhuong').val(data.tinhhuong);
            $('#tieude').val(data.tieude);
            CKEDITOR.instances['txt_noidung'].setData(data.cachxuly);

            if (data.trangthai == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#hengio").prop("checked", true);
            }

            capnhatthongtintinhhuongvacachxuly(id_huongdan);
        });
    }
}
function capnhatthongtintinhhuongvacachxuly(id_huongdan) {
    var trangthai;
    var check = true;

    $('#btnUpdateDetails').click(function () {

        var tieude = $('#tieude').val();
        var tinhhuong = $('#tinhhuong').val();
        trangthai = $("#frmHienthi input[type='radio']:checked").val();
        var cachxuly = CKEDITOR.instances['txt_noidung'].getData();

        if (tinhhuong == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tình huống !');
            return check = false;
        } else if (cachxuly == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập cách xử lý !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                tinhhuong: tinhhuong,
                cachxuly: cachxuly,
                trangthai: trangthai,
                id_huongdan: id_huongdan
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtintinhhuongvacachxuly');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachtinhhuong').DataTable();

            $('#btnUpdateDetails').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateDetails').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateDetails').removeAttr('disabled');
            });
        }
    });

}
function themmoitinhhuongsuly() {
    var trangthai;
    var check = true;

    $('#btnThemmoitinhhuong').click(function () {

        var tieude = $('#tieude').val();
        var tinhhuong = $('#tinhhuong').val();
        trangthai = $("#frmHienthi input[type='radio']:checked").val();
        var cachxuly = CKEDITOR.instances['txt_noidung'].getData();


        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề !');
            return check = false;
        }
        else if (tinhhuong == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tình huống !');
            return check = false;
        } else if (cachxuly == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập cách xử lý !');
            return check = false;
        }
        else {
            var thongtin = {
                tieude: tieude,
                tinhhuong: tinhhuong,
                cachxuly: cachxuly,
                trangthai: trangthai
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmmoitinhhuongvacachxuly');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachtinhhuong').DataTable();

            $('#btnThemmoitinhhuong').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                            $('#tieude').val('');
                            $('#tinhhuong').val('');
                            CKEDITOR.instances['txt_noidung'].setData();
                            $('#hengio').prop('checked', true);
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoitinhhuong').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoitinhhuong').removeAttr('disabled');
            });
        }
    });


}


//QUẢN LÝ TRANG TÌNH HUỐNG KHẨN CẤP - ĐƯỜNG DÂY NÓNG -ok

function initQuanLyDuongDayNong() {
    curentPage = 0;
    loadalldanhsachduongdaynong();

    $('#liaddnew').click(function () {
        $('#themmoiduongdaynong').addClass('active');
        themmoiduongdaynong();
    });
    $('#lidanhsach').click(function () {
        $('#liadetails').removeClass('active');
        $('#liadetails').css('display', 'none');
        $('#liaddnew').css('display', 'block');
        $('#themmoiduongdaynong').removeClass('active');

        $('#tendonvi').val('');
        $('#sodienthoai').val('');
        $('#emailduongdaynong').val('');
        $('#mota').val('');
        $('#diachi').val('');
        $('#hengio').prop('checked', true);

        $('#tb_danhsachduongdaynong').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachduongdaynong&id=0').load();
    });
}

function loadalldanhsachduongdaynong() {
    var $card_content = $('#danhsachduongdaynong');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachduongdaynong',
            html: '<thead>\
                            <th>Tên đơn vị</th>\
                            <th>Số điện thoại</th>\
                            <th>Mô tả</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachduongdaynong').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachduongdaynong&id=0',
            "columns": [
                  {
                      data: "dsguive",
                      mRender: function (data) {
                          if (data.tendonvi.length > 50) {
                              data.tendonvi = data.tendonvi.substring(0, 50) + "....";
                          }
                          if (data.trangthai == 2) {
                              return "<span>" + data.tendonvi + "</span>";

                          }
                          else {
                              return data.tendonvi;
                          }
                      }
                  },
                  {
                      data: "dsguive",
                      mRender: function (data) {
                          if (data.trangthai == 2) {
                              return "<span>" + data.sodienthoai + "</span>";
                          }
                          else {
                              return data.sodienthoai;
                          }
                      }

                  },
                  {
                      data: "dsguive", "width": "35%",
                      mRender: function (data) {
                          if (data.mota.length > 100) {
                              data.mota = data.mota.substring(0, 100) + "....";
                          }
                          if (data.trangthai == 2) {
                              return "<span>" + data.mota + "</span>";

                          }
                          else {
                              return data.mota;
                          }
                      }
                  },
                  {
                      data: "dsguive",
                      mRender: function (data) {
                          var text = "";
                          if (data.trangthai == 2) {
                              text = "Hiển thị";
                          } else {
                              text = "Chỉ lưu";
                          }
                          if (data.trangthai == 2) {
                              return "<span>" + text + "</span>";
                          }
                          else {
                              return text;
                          }
                      }
                  },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết liên lạc"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên lạc"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnDetail" aria-hidden="true" rel="tooltip" title="Xem chi tiết liên lạc"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên lạc"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachduongdaynong&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {

                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.email.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.sodienthoai.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.diachi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tendonvi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.mota.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_dstongdai) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachduongdaynong&id=" + u.item.id_dstongdai;
                                settings.id = u.item.id_dstongdai;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tendonvi + '</div><div class="noidung2">' + item.sodienthoai + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachduongdaynong').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachduongdaynong').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_dstongdai = data.id_dstongdai;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa liên lạc',
                text: "Bạn có chắc sẽ xóa liên lạc này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoalienlacduongdaynong', id_dstongdai: id_dstongdai }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoalienlacduongdaynong', id_dstongdai: id_dstongdai }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnDetail', function () {
            $('#duongdanlink').removeAttr('href');
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_dstongdai = data.id_dstongdai;

            $('#liadetails').addClass('active');
            $('#liadetails').css('display', 'block');
            $('#liaddnew').css('display', 'none');
            $('#themmoiduongdaynong').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachduongdaynong').removeClass('active');
            $('#btnUpdateDetails').remove();
            $('#btnThemmoiLienlac').remove();
            $('#frmButton').empty();
            $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateDetails"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#tendonvi').val(data.tendonvi);
            $('#sodienthoai').val(data.sodienthoai);
            $('#emailduongdaynong').val(data.email);
            $('#mota').val(data.mota);
            $('#diachi').val(data.diachi);

            if (data.trangthai == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#hengio").prop("checked", true);
            }

            capnhatthongtinduongdaynong(id_dstongdai);
        });
    }
}

function themmoiduongdaynong() {
    var trangthai;
    var check = true;
    $('#btnUpdateDetails').remove();
    $('#btnThemmoiLienlac').remove();
    $('#frmButton').empty();
    $('#frmButton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoiLienlac"><i class="fa fa-plus iconButtonPage"></i>Thêm liên lạc</button>');

    $('#btnThemmoiLienlac').click(function () {

        var tendonvi = $('#tendonvi').val();
        trangthai = $("#frmHienthi input[type='radio']:checked").val();

        var sodienthoai = $('#sodienthoai').val();
        var email = $('#emailduongdaynong').val();
        var mota = $('#mota').val();
        var diachi = $('#diachi').val();

        if (tendonvi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tên đơn vị !');
            return check = false;
        } else if (!validatePhone(sodienthoai)) {
            common.showNotification('top', 'right', 'Mời bạn nhập số điện thoại !');
            return check = false;
        } else if (!isEmail(email)) {
            common.showNotification('top', 'right', 'Email không hợp lệ!');
            return check = false;
        }
        else if (mota == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả !');
            return check = false;
        }
        else if (diachi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập địa chỉ !');
            return check = false;
        }
        else {
            var thongtin = {
                tendonvi: tendonvi,
                sodienthoai: sodienthoai,
                email: email,
                mota: mota,
                diachi: diachi,
                trangthai: trangthai
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themoilienlacduongdaynong');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachduongdaynong').DataTable();

            $('#btnThemmoiLienlac').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#tendonvi').val('');
                            $('#sodienthoai').val('');
                            $('#emailduongdaynong').val('');
                            $('#mota').val('');
                            $('#diachi').val('');
                            $('#hengio').prop('checked', true);
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoiLienlac').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoiLienlac').removeAttr('disabled');
            });
        }
    });


}
function capnhatthongtinduongdaynong(id_dstongdai) {
    var trangthai;
    var check = true;
    $('#btnUpdateDetails').click(function () {

        var tendonvi = $('#tendonvi').val();
        trangthai = $("#frmHienthi input[type='radio']:checked").val();

        var sodienthoai = $('#sodienthoai').val();
        var email = $('#emailduongdaynong').val();
        var mota = $('#mota').val();
        var diachi = $('#diachi').val();

        if (tendonvi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tên đơn vị !');
            return check = false;
        } else if (!validatePhone(sodienthoai)) {
            common.showNotification('top', 'right', 'Mời bạn nhập số điện thoại !');
            return check = false;
        } else if (!isEmail(email)) {
            common.showNotification('top', 'right', 'Email không hợp lệ !');
            return check = false;
        }
        else if (mota == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mô tả !');
            return check = false;
        }
        else if (diachi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập địa chỉ !');
            return check = false;
        }
        else {
            var thongtin = {
                tendonvi: tendonvi,
                sodienthoai: sodienthoai,
                email: email,
                mota: mota,
                diachi: diachi,
                trangthai: trangthai,
                id_dstongdai: id_dstongdai
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinduongdaynong');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachduongdaynong').DataTable();

            $('#btnUpdateDetails').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateDetails').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateDetails').removeAttr('disabled');
            });
        }
    });


}

//QUẢN LÝ TRANG CÂU HỎI CÔNG DÂN - ok
function initQuanLyCauHoiCongDan() {
    curentPage = 0;
    loadalldanhsachcauhoicuacongdan();
    getAdllDanhmucCauhoi();

    $('#chosefile').click(function () {
        window.open(window.location.origin + "/file-vb", "Chọn file upload", "height=600,width=1000");
    });
    $('#lidanhsach').click(function () {
        $('#tb_dscauhoitraloicongdan').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachcauhoicuacongdan&id=0').load();
    });
}
function loadalldanhsachcauhoicuacongdan() {

    var $card_content = $('#dscauhoitraloicongdan');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_dscauhoitraloicongdan',
            html: '<thead>\
                            <th></th>\
                            <th>Câu hỏi</th>\
                            <th>Trạng thái</th>\
                            <th>Sử dụng</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_dscauhoitraloicongdan').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachcauhoicuacongdan&id=0',
            "columns": [
                  { data: "ngayhoi" },
                  {
                      data: "dsguive",
                      mRender: function (data) {

                          if (data.cauhoi.length > 100) {
                              data.cauhoi = data.cauhoi.substring(0, 100) + "....";
                          }
                          if (data.statusRepQuestion == false) {
                              return "<span style='font-weight: bold'>" + data.cauhoi + "</span>";

                          }
                          else {
                              return data.cauhoi;
                          }
                      }
                  },
                   {
                       data: "dsguive", "width": "17%",
                       mRender: function (data) {
                           var text = "";
                           if (data.statusRepQuestion == true) {
                               text = "Đã trả lời";
                           } else {
                               text = "Chưa trả lời";
                           }
                           if (data.statusRepQuestion == false) {
                               return "<span style='font-weight: bold'>" + text + "</span>";

                           }
                           else {
                               return text;
                           }
                       }
                   }, {
                       data: "dsguive", "width": "13%",
                       mRender: function (data) {
                           var text = "";
                           if (data.trangthai == 1) {
                               text = "Đang lưu";
                           } else {
                               text = "Đang hiển thị";
                           }
                           if (data.statusRepQuestion == false) {
                               return "<span style='font-weight: bold'>" + text + "</span>";

                           }
                           else {
                               return text;
                           }
                       }
                   },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true && data.statusRepQuestion == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnRep" aria-hidden="true" rel="tooltip" title="Xem chi tiết câu hỏi"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>'
                              });
                              return $dtooltip.html();
                          } else if (data.sua == true && data.xoa == true && data.statusRepQuestion == false) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-reply iconButton btnRep" aria-hidden="true" rel="tooltip" title="Xem và trả lời câu hỏi"></i>\
                                          <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachcauhoicuacongdan&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.cauhoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieudecauhoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.traloi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tenchuyenmuc.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tennguoihoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.emailnguoihoi.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_cauhoitraloi) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachcauhoicuacongdan&id=" + u.item.id_cauhoitraloi;
                                settings.id = u.item.id_cauhoitraloi;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieudecauhoi + '</div><div class="noidung2">' + item.tenchuyenmuc + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_dscauhoitraloicongdan').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_dscauhoitraloicongdan').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoitraloi = data.id_cauhoitraloi;

            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa câu hỏi',
                text: "Bạn có chắc sẽ xóa câu hỏi này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoacauhoitraloimau', id_cauhoitraloi: id_cauhoitraloi }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoacauhoitraloimau', id_cauhoitraloi: id_cauhoitraloi }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnRep', function () {
            $('#duongdanlink').removeAttr('href');
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoitraloi = data.id_cauhoitraloi;

            $('#ModalCauhoi').on('show.bs.modal', function (event) {
            });
            setTimeout(function () {
                $('#ModalCauhoi').modal('show');
                $('#lbltennguoigui').text("Tên người gửi : " + data.tennguoihoi);
                $('#lblemailnguoigui').text("Email : " + data.emailnguoihoi);
                $('#lblngayguicauhoi').text("Ngày gửi : " + data.dateQues);
                $('#lblchuyenmuc').text("Chuyên mục : " + data.tenchuyenmuc);
                $('#tieudecauhoi').attr('disabled', true);
                $('#cauhoi').attr('disabled', true);
                if (data.statusRepQuestion == false) {
                    $('#tieudeCauhoi').text('Trả lời câu hỏi công dân');
                    $('#btnRepQuesPep').remove();
                    $('#btnDetailsQues').remove();
                    $('#footerCauhoi').append(' <button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnRepQuesPep"><i class="fa fa-mail-reply iconButtonPage"></i>Gửi trả lời</button>');
                } else {
                    $('#tieudeCauhoi').text('Chi tiết tin nhắn công dân');
                    $('#btnRepQuesPep').remove();
                    $('#btnDetailsQues').remove();
                    $('#footerCauhoi').append(' <button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnDetailsQues"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
                }
                if (data.fileQuestion != "") {
                    $('#duongdanlink').text('Tải về');
                    $('#duongdanlink').attr('href', data.fileQuestion);
                } else {
                    $('#duongdanlink').text('Không có ');
                }
                $('#tieudecauhoi').val(data.tieudecauhoi);
                $('#cauhoi').val(data.cauhoi);
                $('#duongdan').val(data.filedinhkem);
                CKEDITOR.instances['txt_noidung'].setData(data.traloi);
                if (data.trangthai == 2) {
                    $("#hienthi").prop("checked", true);
                } else {
                    $("#hengio").prop("checked", true);
                }
                var dschuyenmuc = $('#danhmuccauhoi input:radio');
                $.each(dschuyenmuc, function (key, val) {
                    var idArrt = val.id;
                    var idadm = $('#' + idArrt).data('iddmch');
                    if (idadm == data.id_chuyenmuc) {
                        $(this).prop("checked", true);
                    }
                });

                capnhatthongtincauhoitraloicuacongdan(id_cauhoitraloi);

            }, 230);
        });
    }
}

function capnhatthongtincauhoitraloicuacongdan(id_cauhoitraloi) {
    var trangthaihienthi;
    var check = true;

    $('#btnDetailsQues').click(function () {

        var filedinhkem = $('#duongdan').val();

        var _idTagDM = $("#danhmuccauhoi input[type='radio']:checked").attr('id');
        var id_chuyenmuc = $('#' + _idTagDM).data('iddmch');

        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        var tieudecauhoi = $('#tieudecauhoi').val();
        var cauhoi = $('#cauhoi').val();
        var traloi = CKEDITOR.instances['txt_noidung'].getData();


        if (tieudecauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề câu hỏi !');
            return check = false;
        }
        else if (cauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi !');
            return check = false;
        } else if (traloi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        } else if (id_chuyenmuc == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else if (trangthaihienthi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        } else if (id_cauhoitraloi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else {
            $('#btnDetailsQues').attr('disabled', true);
            var thongtin = {
                id_chuyenmuc: id_chuyenmuc,
                trangthaihienthi: trangthaihienthi,
                cauhoi: cauhoi,
                traloi: traloi,
                filedinhkem: filedinhkem,
                id_cauhoitraloi: id_cauhoitraloi,
                tieudecauhoi: tieudecauhoi,
                tentacvu: "updatedata"

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincauhoitraloimau');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_dscauhoitraloicongdan').DataTable();

            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnDetailsQues').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnDetailsQues').removeAttr('disabled');
            });
        }
    });

    $('#btnRepQuesPep').click(function () {

        var filedinhkem = $('#duongdan').val();

        var _idTagDM = $("#danhmuccauhoi input[type='radio']:checked").attr('id');
        var id_chuyenmuc = $('#' + _idTagDM).data('iddmch');

        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        var tieudecauhoi = $('#tieudecauhoi').val();
        var cauhoi = $('#cauhoi').val();
        var traloi = CKEDITOR.instances['txt_noidung'].getData();

        if (tieudecauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề câu hỏi !');
            return check = false;
        }
        else if (cauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi !');
            return check = false;
        } else if (traloi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        } else if (id_chuyenmuc == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else if (trangthaihienthi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        } else if (id_cauhoitraloi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else {
            $('#btnRepQuesPep').attr('disabled', true);
            var thongtin = {
                id_chuyenmuc: id_chuyenmuc,
                trangthaihienthi: trangthaihienthi,
                cauhoi: cauhoi,
                traloi: traloi,
                filedinhkem: filedinhkem,
                id_cauhoitraloi: id_cauhoitraloi,
                tieudecauhoi: tieudecauhoi,
                tentacvu: "traloicauhoi"

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincauhoitraloimau');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_dscauhoitraloicongdan').DataTable();

            swal({
                title: 'Gửi câu trả lời',
                text: "Bạn có chắc sẽ gửi câu trả lời như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnRepQuesPep').removeAttr('disabled');
                        table.ajax.reload();
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
                $('.loader-parent').css('display', 'none');
                $('#btnRepQuesPep').removeAttr('disabled');
            });
        }
    });
}

//QUẢN LÝ TRANG CÂU HỎI MẪU - ok
function initQuanLyCauHoiMau() {
    curentPage = 0;
    getAllDanhSachCauHoiTraLoiMau();

    getAdllDanhmucCauhoi();

    $('#chosefile').click(function () {
        window.open(window.location.origin + "/file-vb", "Chọn file upload", "height=600,width=1000");
    });
    $('#lidanhsach').click(function () {
        $('#lichitiet').removeClass('active');
        $('#lichitiet').css('display', 'none');
        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');

        $('#themoicauhoivacautraloi').removeClass('active');
        $('#danhsachcauhoitraloimau').addClass('active');
        $('#lidanhsach').addClass('active');

        $('#tb_danhsachcauhoitraloimau').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachcauhoitraloimau&id=0').load();
    });

    $('#liaddnew').click(function () {
        $('#dowloadf a').remove();
        $('#tieude').val('');
        $('#duongdan').val('');
        $('#cauhoi').val('');
        $('#tieudecauhoi').val('');
        CKEDITOR.instances['txt_noidung'].setData('');
        themoicauhoitraloimau();
    });
}

function getAllDanhSachCauHoiTraLoiMau() {
    var $card_content = $('#danhsachcauhoitraloimau');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachcauhoitraloimau',
            html: '<thead>\
                            <th></th>\
                            <th>Câu hỏi</th>\
                            <th>Danh mục</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachcauhoitraloimau').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachcauhoitraloimau&id=0',
            "columns": [
                  { data: "ngayhoi" },
                  {
                      data: "cauhoi",
                      mRender: function (data) {
                          if (data.length > 100) {
                              data = data.substring(0, 100) + "....";
                          }
                          return data;
                      }
                  },
                   {
                       data: "tenchuyenmuc", "width": "25%",
                   }, {
                       data: "trangthai", "width": "13%",
                       mRender: function (data) {
                           if (data == 1) {
                               data = "Chỉ lưu";
                           } else {
                               data = "Hiển thị";
                           }
                           return data;
                       }
                   },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnChitietcauhoimau" aria-hidden="true" rel="tooltip" title="Xem chi tiết câu hỏi"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnChitietcauhoimau" aria-hidden="true" rel="tooltip" title="Xem chi tiết câu hỏi"></i>';
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa câu hỏi"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachcauhoitraloimau&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {

                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tieudecauhoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.cauhoi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.traloi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.ngay.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tennguoitraloi.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tenchuyenmuc.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_cauhoitraloi) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachcauhoitraloimau&id=" + u.item.id_cauhoitraloi;
                                settings.id = u.item.id_cauhoitraloi;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieudecauhoi + '</div><div class="noidung2">' + item.tennguoihoi + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem

            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachcauhoitraloimau').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachcauhoitraloimau').DataTable();
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoitraloi = data.id_cauhoitraloi;

            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa câu hỏi',
                text: "Bạn có chắc sẽ xóa câu hỏi này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoacauhoitraloimau', id_cauhoitraloi: id_cauhoitraloi }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoacauhoitraloimau', id_cauhoitraloi: id_cauhoitraloi }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'i.btnChitietcauhoimau', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_cauhoitraloi = data.id_cauhoitraloi;

            $('#btnCapnhatCHTL').remove();
            $('#btnThemmoiCauhoi').remove();
            $('#frmbutton').empty();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnCapnhatCHTL"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            $('#lichitiet').addClass('active');
            $('#liaddnew').css('display', 'none');
            $('#lichitiet').css('display', 'block');
            $('#themoicauhoivacautraloi').addClass('active');
            $('#danhsachcauhoitraloimau').removeClass('active');
            $('#lidanhsach').removeClass('active');
            $('#dowloadf a').remove();

            if (data.filedinhkem != null) {
                $('#dowloadf').append('<a href="' + data.filedinhkem + '" id="duongdanlink" download>dowload file</a>');
            }
            $('#duongdan').val(data.filedinhkem);
            $('#tieudecauhoi').val(data.tieudecauhoi);
            $('#cauhoi').val(data.cauhoi);
            CKEDITOR.instances['txt_noidung'].setData(data.traloi);
            if (data.trangthai == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#hengio").prop("checked", true);
            }
            var dschuyenmuc = $('#danhmuccauhoi input:radio');
            $.each(dschuyenmuc, function (key, val) {
                var idArrt = val.id;
                var idadm = $('#' + idArrt).data('iddmch');
                if (idadm == data.id_chuyenmuc) {
                    $(this).prop("checked", true);
                }
            });

            capnhatthongtincauhoitraloimau(id_cauhoitraloi);
        });
    }
}

function capnhatthongtincauhoitraloimau(id_cauhoitraloi) {

    var trangthaihienthi;
    var check = true;


    $('#btnCapnhatCHTL').click(function () {

        var filedinhkem = $('#duongdan').val();

        var _idTagDM = $("#danhmuccauhoi input[type='radio']:checked").attr('id');
        var id_chuyenmuc = $('#' + _idTagDM).data('iddmch');

        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        var tieudecauhoi = $('#tieudecauhoi').val();
        var cauhoi = $('#cauhoi').val();
        var traloi = CKEDITOR.instances['txt_noidung'].getData();

        if (tieudecauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề câu hỏi !');
            return check = false;
        }
        else if (cauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi !');
            return check = false;
        } else if (traloi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        } else if (id_chuyenmuc == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else if (trangthaihienthi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        } else if (id_cauhoitraloi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else {
            var thongtin = {
                id_chuyenmuc: id_chuyenmuc,
                trangthaihienthi: trangthaihienthi,
                cauhoi: cauhoi,
                traloi: traloi,
                filedinhkem: filedinhkem,
                id_cauhoitraloi: id_cauhoitraloi,
                tieudecauhoi: tieudecauhoi,
                tentacvu: "updatedatamau"

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincauhoitraloimau');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachcauhoitraloimau').DataTable();

            $('#btnCapnhatCHTL').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnCapnhatCHTL').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnCapnhatCHTL').removeAttr('disabled');
            });

        }
    });
}
function getAdllDanhmucCauhoi() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'getAdllDanhmucCauhoi' }, function (data) {
        createradioCauhoiTraLoi(data);
    });
}
function createradioCauhoiTraLoi(data) {
    var $danhmuc = $('#danhmuccauhoi');
    $.each(data.data, function (x2, value) {
        if (value.trangthai == true) {
            var $li = $('<div/>', {
                class: 'radio col-xs-4',
                html: '<label><input name="rdbCauHoiTraLoi" data-iddmch="' + JSON.stringify(value.id_chuyenmuc) + '" id="iddm' + value.id_chuyenmuc + '" type="radio" />' + value.tenchuyenmuc + '</label>'
            }).appendTo($danhmuc);
        }
        return $li;
    });
    $("#danhmuccauhoi input:radio[name=rdbCauHoiTraLoi]:first").prop('checked', true);
    return $danhmuc;
}
function themoicauhoitraloimau() {
    var trangthaihienthi;
    var check = true;
    $('#btnCapnhatCHTL').remove();
    $('#btnThemmoiCauhoi').remove();
    $('#frmbutton').empty();
    $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoiCauhoi"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');

    $('#btnThemmoiCauhoi').click(function () {

        var tieudecauhoi = $('#tieudecauhoi').val();
        var filedinhkem = $('#duongdan').val();
        var _idTagDM = $("#danhmuccauhoi input[type='radio']:checked").attr('id');
        var id_chuyenmuc = $('#' + _idTagDM).data('iddmch');
        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        var cauhoi = $('#cauhoi').val();
        var traloi = CKEDITOR.instances['txt_noidung'].getData();

        if (tieudecauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề câu hỏi !');
            return check = false;
        }
        else if (cauhoi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu hỏi !');
            return check = false;
        }
        else if (traloi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập câu trả lời !');
            return check = false;
        } else if (id_chuyenmuc == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else if (trangthaihienthi == "") {
            common.showNotification('top', 'right', 'Có lỗi với dữ liệu !');
            return check = false;
        }
        else {
            var thongtin = {
                id_chuyenmuc: id_chuyenmuc,
                trangthaihienthi: trangthaihienthi,
                cauhoi: cauhoi,
                traloi: traloi,
                filedinhkem: filedinhkem,
                tieudecauhoi: tieudecauhoi

            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoicauhoitraloimau');
            fd_data.append("stringTookenClient", stringTookenServer);


            var table = $('#tb_danhsachcauhoitraloimau').DataTable();

            $('#btnThemmoiCauhoi').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#tieudecauhoi').val('');
                            $('#cauhoi').val('');
                            $('#duongdan').val('');
                            CKEDITOR.instances['txt_noidung'].setData('');

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoiCauhoi').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoiCauhoi').removeAttr('disabled');
            });
        }

    });


}

//QUẢN LÝ TRANG TIN BÁO CÔNG DÂN - ok
function initQuanLyTinBaoCongDan() {
    curentPage = 0;
    danhsachtinbaocongdan();
}
function danhsachtinbaocongdan() {
    var $card_content = $('#danhsachtinbaocd');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachtinbaocd',
            html: '<thead>\
                            <th></th>\
                            <th>Địa bàn</th>\
                            <th>Ngày gửi</th>\
                            <th>Nội dung</th>\
                            <th>Trạng thái</th>\
                            <th></th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachtinbaocd').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachtinbaocongdan',
            "columns": [
                  { data: "ngaygui" },
                  {
                      data: "dsguive", "width": "15%",
                      mRender: function (data) {
                          if (data.trangthaixem == false) {
                              return "<span style='font-weight: bold'>" + data.diaban + "</span>";

                          } else {
                              return data.diaban;
                          }
                      }
                  },
                  {
                      data: "dsguive", "width": "13%",
                      mRender: function (data) {
                          if (data.trangthaixem == false) {
                              return "<span style='font-weight: bold'>" + data.ngay + "</span>";

                          } else {
                              return data.ngay;
                          }
                      }
                  },
                   {
                       data: "dsguive", "width": "40%",
                       mRender: function (data) {
                           if (data.noidungtinbao.length > 200) {
                               data.noidungtinbao = data.noidungtinbao.substring(0, 200) + "......<a href='#'>Xem thêm</a>";
                           }
                           if (data.trangthaixem == false) {
                               return "<span style='font-weight: bold'>" + data.noidungtinbao + "</span>";

                           }
                           else {
                               return data.noidungtinbao;
                           }
                       }
                   },
                   {
                       data: "trangthaihienthi", "width": "15%",
                       mRender: function (data) {
                           if (data == 1) {
                               data = "Chỉ lưu";
                           } else {
                               data = "Đang hiển thị";
                           }
                           return data;
                       }
                   },
                  {
                      data: "button",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<button type="button" rel="tooltip" title="Xem chi tiết tin báo" class="btn btn-block btn-primary btnChitietTinbao">Chi tiết</button>\
                                          <button type="button" rel="tooltip" title="Xóa tin báo" class="btn btn-block btn-danger btnDelete">Xóa</button>'
                              });
                              return $dtooltip.html();
                          } else if (data.sua == true) {
                              return data = '<button type="button" rel="tooltip" title="Xem chi tiết tin báo" class="btn btn-block btn-primary btnChitietTinbao">Chi tiết</button>';
                          }
                          else if (data.xoa == true) {
                              return data = '<button type="button" rel="tooltip" title="Xóa tin báo" class="btn btn-block btn-danger btnDelete">Xóa</button>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                if (json.demsoluong > 0) {
                    $('#tb_danhsachtinbaocd_length').empty();
                    $('#tb_danhsachtinbaocd_length').append('<label>Có ' + json.demsoluong + ' tin báo chưa đọc </label>');
                } else {
                    $('#tb_danhsachtinbaocd_length').empty();
                }

            },
            "order": [[0, 'desc']],
        });
        var parent = $('#tb_danhsachtinbaocd').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachtinbaocd').DataTable();
        $('#tb_danhsachtinbaocd_length label').remove();
        table.on('click', 'button.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_tinbao = data.id_tinbao;

            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa tin báo',
                text: "Bạn có chắc sẽ xóa tin báo này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {

                jsonPost({ type: 'xoatinbaocongdan', id_tinbao: id_tinbao }).then(function (thongtinadmin) {
               // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoatinbaocongdan', id_tinbao: id_tinbao }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.btnDelete').removeAttr('disabled');
                    //   table.ajax.reload();
                    danhsachtinbaocongdan();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.btnDelete').removeAttr('disabled');
            });
        });
        table.on('click', 'button.btnChitietTinbao', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_tinbao = data.id_tinbao;
            var idchuyenmuc = data.id_chuyenmuc;
            $('#ModalFolder').on('show.bs.modal', function (event) {
                $('#btnUpdatethongtin').remove();
                $('#modelSuDung_ft').append('<button type="button" class="btn btn-block btn-primary pull-right" id="btnUpdatethongtin" >Cập nhật thông tin</button>');
                $('#modalFolBody').empty();
                $('#tieudeModel').html("Xem thông tin chi tiết tin báo công dân");
                $('#modalFolBody').append('<form class="form-horizontal">\
                                <div class="form-group" id="frm1">\
                                    <label for="inputName" class="col-sm-2 control-label">Họ tên</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="hoten">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmemail">\
                                    <label for="inputName" class="col-sm-2 control-label">Email</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="emailcondan">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmdienthoai">\
                                    <label for="inputName" class="col-sm-2 control-label">Điện thoại</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="dienthoai">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmdiachi">\
                                    <label for="inputName" class="col-sm-2 control-label">Địa chỉ người gửi</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="diachi">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmid_danhmuc">\
                                    <label for="inputName" class="col-sm-2 control-label">Chuyên mục</label>\
                                    <div class="col-sm-8">\
                                      <select class="form-control" id="tenchuyenmuc">\
                                      </select>\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmid_diaban">\
                                    <label for="inputName" class="col-sm-2 control-label">Địa bàn</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="diaban">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmid_tieude">\
                                    <label for="inputName" class="col-sm-2 control-label">Tiêu đề</label>\
                                    <div class="col-sm-8">\
                                        <input type="text" class="form-control" id="tieude">\
                                    </div>\
                                </div>\
                                <div class="form-group" id="frmnoidungtinbao">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Nội dung</label>\
                                    <div class="col-sm-8">\
                                        <textarea class="form-control" rows="15" id="noidungtinbao" placeholder=""></textarea>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>\
                                    <div class=" col-sm-10" id="frmHienthi">\
                                        <div class="radio">\
                                            <label>\
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="" id="hienthi">Hiển thị\
                                            </label>\
                                        </div>\
                                        <div class="radio" id="radiohengio">\
                                            <label>\
                                                <input type="radio" name="optionsRadios" value="hengio" checked="true" id="hengio">Chỉ lưu\
                                            </label>\
                                        </div>\
                                    </div>\
                                </div>\
                            </form>');
            });

            setTimeout(function () {
                $('#ModalFolder').modal('show');

                $('#hoten').val(data.hoten);
                $('#emailcondan').val(data.email);
                $('#dienthoai').val(data.dienthoai);
                $('#diachi').val(data.diachi);
                $('#tenchuyenmuc').val(data.tenchuyenmuc);
                $('#diaban').val(data.diaban);
                $('#tieude').val(data.tieude);
                $('#noidungtinbao').val(data.noidung);

                if (data.trangthaihienthi == 2) {
                    $("#hienthi").prop("checked", true);
                } else {
                    $("#hengio").prop("checked", true);
                }

                $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachdanhmuctinbaocongdan' }, function (data) {
                    if (data.sucess) {
                        $('#tenchuyenmuc').empty();
                        $.each(data.data, function (key, val) {
                            $('#tenchuyenmuc').append('<option id="' + val.id_chuyenmuc + '">' + val.tenchuyenmuc + '</option>');
                        })
                    } else {
                        $('#tenchuyenmuc').append('<option>Không có chuyên mục</option>');
                    }
                    $('#tenchuyenmuc option[id="' + idchuyenmuc + '"]').attr("selected", "selected");
                });


                capnhatthongtintinbaocongdan(id_tinbao);
            }, 230);
            if (data.trangthaixem == false) {

                jsonPost({ type: 'capnhattinhtrangxemcuatinbao', id_tinbao: id_tinbao }).then(function (data) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'capnhattinhtrangxemcuatinbao', id_tinbao: id_tinbao }, function (data) {
                    if (data.sucess) {
                        danhsachtinbaocongdan();
                    } else {
                        swal("Thông báo", data.msg, 'error');
                    }
                });
            }

        });
    }
}
function capnhatthongtintinbaocongdan(id_tinbao) {

    var trangthaihienthi;
    var check = true;
    $('#btnUpdatethongtin').click(function () {

        var hoten = $('#hoten').val();
        var email = $('#emailcondan').val();
        var dienthoai = $('#dienthoai').val();
        var diachi = $('#diachi').val();
        var diaban = $('#diaban').val();
        var tieude = $('#tieude').val();
        var noidungtinbao = $('#noidungtinbao').val();
        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();
        var id_chuyenmuc = $('#tenchuyenmuc option:selected').attr('id');

        if (hoten == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập họ tên !');
            return check = false;
        } else if (!validatePhone(dienthoai)) {
            common.showNotification('top', 'right', 'Mời bạn nhập số điện thoại !');
            return check = false;
        } else if (!isEmail(email)) {
            common.showNotification('top', 'right', 'Email không hợp lệ !');
            return check = false;
        }
        else if (diachi == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập địa chỉ !');
            return check = false;
        }
        else if (id_chuyenmuc == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn chuyên mục !');
            return check = false;
        } else if (diaban == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập địa bàn !');
            return check = false;
        }
        else if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề !');
            return check = false;
        }
        else if (noidungtinbao == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung tin báo !');
            return check = false;
        }
        else {

            var thongtin = {
                id_tinbao: id_tinbao,
                hoten: hoten,
                email: email,
                dienthoai: dienthoai,
                diachi: diachi,
                diaban: diaban,
                tieude: tieude,
                noidungtinbao: noidungtinbao,
                trangthaihienthi: trangthaihienthi,
                id_chuyenmuc: id_chuyenmuc
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtintinbaocongdan');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachtinbaocd').DataTable();
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.suscess) {
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    table.ajax.reload();
                }
            });
        }
    });

}


//QUẢN LÝ TRANG GƯƠNG ĐIỂN HÌNH - ok
function initQuanLyGuongDienHinh() {
    curentPage = 0;
    loadimage();
    danhsachdanhmucGUONGDIENHINH();
    loadAlldanhsachbaivietGUONGDIENHINH();
    $('#chosefileavbv').click(function () {
        window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
    });
    $('#liaddnew').click(function () {
        $('#frmbutton').empty();
        $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoibaiviet"><i class="fa fa-plus iconButtonPage"></i>Thêm bài viết</button>');
        if (RootGuongDienHinh == true) {
            var a = $('#danhmucbaiviet').find('div[name="cha"]').remove();
        }
        themoibaivietGUONGDIENHINH();
    });

    $('#lidanhsach').click(function () {
        $('#tb_danhsachbaiviet').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietGUONGDIENHINH&id=0').load();
    });
}

function danhsachdanhmucGUONGDIENHINH() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdanhmucGUONGDIENHINH' }, function (data) {
        createcheckboxGUONGDIENHINH(data);
    });
}
function loadAlldanhsachbaivietGUONGDIENHINH() {
    var $card_content = $('#danhsachbaiviet');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbaiviet',
            html: '<thead>\
                            <th></th>\
                            <th>Tiêu đề</th>\
                            <th>Tác giả</th>\
                            <th>Ngày tạo</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbaiviet').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietGUONGDIENHINH&id=0',
            "columns": [
                  { data: "ngaythang" },
                  {
                      data: "tieude",
                      mRender: function (data) {
                          if (data.length > 40) {
                              data = data.substring(0, 40) + "...";
                          }
                          return data;
                      }
                  },
                  { data: "tacgia" },
                  { data: "ngaytao" },
                  {
                      data: "button", "width": "105px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-list-ul iconButton btnDSDM" aria-hidden="true" rel="tooltip" title="Danh mục hiển thị"></i>\
                                         <i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>';
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietGUONGDIENHINH&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                var a = json.data[0].button.them;
                if (a == false) {
                    $('#themmoibaiviet').remove();
                    $('#liaddnew').remove();
                    $('#liaddnew').click(function () {
                        swal('Thông báo', 'Bạn không có quyền thực hiện chức năng này', 'warning')
                        $('#liaddnew').removeClass('active');
                    });
                } else {
                    $('#liaddnew').css("display", "block")
                }



                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tag.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_baiviet) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadAlldanhsachbaivietGUONGDIENHINH&id=" + u.item.id_baiviet;
                                settings.id = u.item.id_baiviet;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachbaiviet').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbaiviet').DataTable();
        $('#tb_danhsachbaiviet_length').remove();

        $('#liaddnew').click(function () {
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#rdoLuunhap').css("display", "block");
            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");

            var dscheck = $('#danhmucbaiviet input');
            $.each(dscheck, function (key, val) {
                $(this).prop("disabled", false);
                $(this).prop('checked', false);
            });
            $('#hienthi').prop('checked', true);
            //  themoibaiviet();
        });
        $('#lidanhsach').click(function () {

            $('#lidanhsach').addClass('active');
            $('#danhsachbaiviet').addClass('active');
            $('#lichitiet').removeClass('active');
            $('#lichitiet').css('display', 'none');
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'block');
            $('#themmoibaiviet').removeClass('active');
            $('#titleupdate').html('<i class="fa fa-plus iconTab"></i>Thêm mới bài viết');
            $('#frmdanhmuc').css("display", "block");
            $('#frmtrangthai').css("display", "block");
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#previewavbv').html('');
            $('#lbl_anhdaidien').text('');
            //$('#name').html('');
            //$('#size').html('');
            //$('#type').html('');
            $('#tieude').val('');
            $('#gioithieu').val('');
            $('#tacgia').val('');
            $('#ngayvagio').text('');
            CKEDITOR.instances['txt_noidung'].setData('');
            var a = $('#danhmucbaiviet').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
            var b = $('.bootstrap-tagsinput').find('span');
            $.each(b, function (key, val) {
                $(this).remove();
            });
            $('#tag').tagsinput('removeAll');
        });
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");
            $('#lidanhsach').removeClass('active');
            $('#danhsachbaiviet').removeClass('active');
            $('#liaddnew').addClass('active');
            $('#themmoibaiviet').addClass('active');
            $('#titleupdate').html('<i class="fa fa-edit iconTab"></i>Sửa thông tin bài viết');
            $('#frmdanhmuc').css("display", "none");
            $('#frmtrangthai').css("display", "none");

            $('#btnUpdateBaiviet').remove();
            $('#btnChonDangMuc').remove();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateBaiviet"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            $('#btnThemmoibaiviet').remove();

            $('#previewavbv').empty();
            $('#previewavbv').append('<img src="' + data.avatar + '" width="100px" height="100px">');
            $('#lbl_anhdaidien').text(data.avatar);

            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            var splitted = data.tag.split(",");
            var inputVal = "";
            $.each(splitted, function (key, value) {
                inputVal += value + ",";
                var focusssInput = $(".bootstrap-tagsinput input").val(inputVal);
                focusssInput.focus();
            });


            capnhatthongtinbaiviettintuc(id_baiviet);
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa bài viết',
                text: "Bạn có chắc sẽ xóa bài viết này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabaiviettintuc', id_baiviet: id_baiviet }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabaiviettintuc', id_baiviet: id_baiviet }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });

        });
        table.on('click', 'i.btnDSDM', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            if (data.trangthaibaiviet == 2) {
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').removeClass('active');
                $('#liaddnew').css('display', 'none');
                $('#lichitiet').addClass('active');
                $('#lichitiet').css('display', 'block');
                $('#themmoibaiviet').addClass('active');
                $('#titlechitiet').html('<i class="fa fa-edit iconTab"></i>Chọn danh mục hiển thị bài viết');
                $('#rdoLuunhap').css("display", "none");
                $('#hienthi').prop('checked', true);
                var dscheck = $('#danhmucbaiviet input');
                $.each(dscheck, function (key, val) {
                    $(this).attr("disabled", false);
                });
                $('#btnUpdateBaiviet').remove();
                $('#btnChonDangMuc').remove();
                $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChonDangMuc"><i class="fa fa-save iconButtonPage"></i>Đồng ý</button>');
                $('#btnThemmoibaiviet').remove();

                $('#frm1').css("display", "none");
                $('#frm2').css("display", "none");
                $('#frm3').css("display", "none");
                $('#frm4').css("display", "none");
                $('#frm5').css("display", "none");
                $('#frm6').css("display", "none");

                themmoidanhmucvalichhienthichobaiviet(id_baiviet);
            } else {
                $('#libaivietdanhmuc').css("display", "block");
                $('#libaivietdanhmuc').addClass('active');
                $('#chitietbvtrongdm').addClass('active');
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').css('display', 'none');
                var tenbaiviet = data.tieude;
                if (tenbaiviet.length > 50) {
                    tenbaiviet = tenbaiviet.substring(0, 50) + "...";
                }
                $('#titledm').html('<i class="fa fa-edit iconTab"></i>' + tenbaiviet);
                loadthongtinchitietbaiviettintuc(data);
            }

        });
    }
}

function themoibaivietGUONGDIENHINH() {
    $("input:radio[name=optionsRadios]").on("click", function () {
        if ($(this)[0].id == "hengio") {
            $('#btnok').remove();
            $('#titleherader').remove();
            $('#loaidatlich').remove();
            $('#lblHinhthuc').remove();
            $('#dateend').remove();
            $('#timeend').remove();
            $('#uutien').remove();
            $('#laptheogio').remove();
            $('#lblBatDau').remove();
            $('#lblKetthu').remove();
            $('#lichuutien').remove();
            $('#form1').remove();
            $('#form2').remove();

            $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Chọn lịch</button>');
            $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                $('#titleModal').html("Đặt lịch hiển thị cho bài viêt");
            });
            //
            var _TenLich = "";
            $('#batdau').empty();
            $('#ketthu').empty();
            $('#toanthoigian').css('display', 'block');

            setTimeout(function () {
                $('#ModalLichHienthi').modal('show');
                $('#btnok').click(function () {
                    $('#ngayvagio').remove();
                    var gio = $('#timeStart').val();
                    var ngay = $('#fullDateStart').val();
                    $('#btnCances').click();
                    $('#radiohengio').append('<label id="ngayvagio">' + ngay + " " + gio + '</label>');
                });

            }, 230);
        } else {
            $('#ngayvagio').empty();
        }
    });


    var check = true;
    var dsadminShare = new Array();
    var hinhthuchienthi = "";
    var tag = "";

    $('#rdoLuunhap').css("display", "block");

    $('#btnThemmoibaiviet').click(function () {
        dsadminShare = [];
        tag = "";
        hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var avatar = $('#lbl_anhdaidien').text();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        var tacgia = $('#tacgia').val();
        tag = $('#tag').val();
        var ngaydatlich = $('#ngayvagio').text();

        var dscheck = $('#danhmucbaiviet input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề bài viết !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập phần giới thiệu bài viết !');
            return check = false;
        } else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện cho bài viết !');
            return check = false;
        }
        else if (tag == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập từ khóa cho bài viết !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hienthi" && dsadminShare.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
            return check = false;
        }

        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                avatar: avatar,
                noidung: noidung,
                tacgia: tacgia,
                tag: tag,
                ngaydatlich: ngaydatlich,
                hinhthuchienthi: hinhthuchienthi,
                idRoot: 10 //id root menu client
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('dsdanhmuc', JSON.stringify(dsadminShare));
            fd_data.append('type', 'themmoibaiviet');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaiviet').DataTable();


            $('#btnThemmoibaiviet').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {

                            $('#previewavbv').html('');
                            $('#lbl_anhdaidien').text('');
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            $('#ngayvagio').text('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            var a = $('#danhmucbaiviet').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                            var b = $('.bootstrap-tagsinput').find('span');
                            $.each(b, function (key, val) {
                                $(this).remove();
                            });
                            $('#tag').tagsinput('removeAll');
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoibaiviet').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoibaiviet').removeAttr('disabled');
            });
        }
    });
}
function createcheckboxGUONGDIENHINH(data) {
    var $danhmuc = $('#danhmucbaiviet');
    $.each(data.danhsach, function (x2, value) {
        if (value.idParent == 0) {
            if ($(this)[0].danhsach.length > 0) {
                RootGuongDienHinh = true;
            }
        }
        if (value.trangthai == 1) {
            var $li = $('<div/>', {
                class: 'checkbox col-xs-4',
                html: '<label><input data-idadmin="' + JSON.stringify(value.id_danhmuc) + '" id="iddm' + value.id_danhmuc + '" type="checkbox" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
            if (value.danhsach != null && value.trangthai == 1) {
                if (value.danhsach.length > 0) {
                    createcheckboxGUONGDIENHINH(value);
                }
            }
        }
        return $li;
    });
    var ds = $('#danhmucbaiviet div');
    ds.first().attr('name', 'cha');
    return $danhmuc;
}

//QUẢN LÝ TRANG HỢP TÁC QUỐC TẾ - ok
function initQuanLyHopTacQuocTe() {
    curentPage = 0;
    loadimage();
    danhsachdanhmuchoptacquocte();

    loadAlldanhsachbaiviethoptacquocte();
    $('#chosefileavbv').click(function () {
        window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
    });
    $('#liaddnew').click(function () {
        if (RootHopTacQT == true) {
            var a = $('#danhmucbaiviet').find('div[name="cha"]').remove();
        }
        themoibaivietLienKetHopTac();
    });

    $('#lidanhsach').click(function () {
        $('#tb_danhsachbaiviet').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbaiviethoptacquocte&id=0').load();
    });
}
function danhsachdanhmuchoptacquocte() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachdanhmuchoptacquocte' }, function (data) {
        createcheckboxLienKetHopTac(data);
    });
}
function loadAlldanhsachbaiviethoptacquocte() {
    var $card_content = $('#danhsachbaiviet');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbaiviet',
            html: '<thead>\
                            <th></th>\
                            <th>Tiêu đề</th>\
                            <th>Tác giả</th>\
                            <th>Ngày tạo</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbaiviet').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbaiviethoptacquocte&id=0',
            "columns": [
                  { data: "ngaythang" },
                  {
                      data: "tieude",
                      mRender: function (data) {
                          if (data.length > 40) {
                              data = data.substring(0, 40) + "...";
                          }
                          return data;
                      }
                  },
                  { data: "tacgia", "width": "20%", },
                  { data: "ngaytao", "width": "20%", },
                  {
                      data: "button", "width": "105px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-list-ul iconButton btnDSDM" aria-hidden="true"  rel="tooltip" title="Danh mục hiển thị"></i>\
                                         <i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>';
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbaiviethoptacquocte&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                var a = json.data[0].button.them;
                if (a == false) {
                    $('#themmoibaiviet').remove();
                    $('#liaddnew').remove();
                    $('#liaddnew').click(function () {
                        swal('Thông báo', 'Bạn không có quyền thực hiện chức năng này', 'warning')
                        $('#liaddnew').removeClass('active');
                    });
                } else {
                    $('#liaddnew').css("display", "block")
                }

                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tag.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_baiviet) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbaiviethoptacquocte&id=0" + u.item.id_baiviet;
                                settings.id = u.item.id_baiviet;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem



            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachbaiviet').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbaiviet').DataTable();
        $('#tb_danhsachbaiviet_length').remove();

        $('#liaddnew').click(function () {
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#rdoLuunhap').css("display", "block");
            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");

            var dscheck = $('#danhmucbaiviet input');
            $.each(dscheck, function (key, val) {
                $(this).prop("disabled", false);
                $(this).prop('checked', false);
            });
            $('#hienthi').prop('checked', true);
            //  themoibaiviet();
        });
        $('#lidanhsach').click(function () {

            $('#lidanhsach').addClass('active');
            $('#danhsachbaiviet').addClass('active');
            $('#lichitiet').removeClass('active');
            $('#lichitiet').css('display', 'none');
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'block');
            $('#themmoibaiviet').removeClass('active');
            $('#titleupdate').html('<i class="fa fa-plus iconTab"></i>Thêm mới bài viết');
            $('#frmdanhmuc').css("display", "block");
            $('#frmtrangthai').css("display", "block");
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#previewavbv').html('');
            $('#lbl_anhdaidien').text('');
            //$('#name').html('');
            //$('#size').html('');
            //$('#type').html('');
            $('#tieude').val('');
            $('#gioithieu').val('');
            $('#tacgia').val('');
            $('#ngayvagio').text('');
            CKEDITOR.instances['txt_noidung'].setData('');
            var a = $('#danhmucbaiviet').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
            var b = $('.bootstrap-tagsinput').find('span');
            $.each(b, function (key, val) {
                $(this).remove();
            });
            $('#tag').tagsinput('removeAll');
        });
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");
            $('#lidanhsach').removeClass('active');
            $('#danhsachbaiviet').removeClass('active');
            $('#liaddnew').addClass('active');
            $('#themmoibaiviet').addClass('active');
            $('#titleupdate').html('<i class="fa fa-edit iconTab"></i>Sửa thông tin bài viết');
            $('#frmdanhmuc').css("display", "none");
            $('#frmtrangthai').css("display", "none");

            $('#btnUpdateBaiviet').remove();
            $('#btnChonDangMuc').remove();
            $('#frmbutton').empty();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateBaiviet"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            $('#btnThemmoibaiviet').remove();

            $('#previewavbv').empty();
            $('#previewavbv').append('<img src="' + data.avatar + '" width="100px" height="100px">');

            $('#lbl_anhdaidien').text(data.avatar);
            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            var splitted = data.tag.split(",");
            var inputVal = "";
            $.each(splitted, function (key, value) {
                inputVal += value + ",";
                var focusssInput = $(".bootstrap-tagsinput input").val(inputVal);
                focusssInput.focus();
            });
            capnhatthongtinbaiviettintuc(id_baiviet);
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa bài viết',
                text: "Bạn có chắc sẽ xóa bài viết này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabaiviettintuc', id_baiviet: id_baiviet }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabaiviettintuc', id_baiviet: id_baiviet }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });

        });
        table.on('click', 'i.btnDSDM', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            if (data.trangthaibaiviet == 2) {
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').removeClass('active');
                $('#liaddnew').css('display', 'none');
                $('#lichitiet').addClass('active');
                $('#lichitiet').css('display', 'block');
                $('#themmoibaiviet').addClass('active');
                $('#titlechitiet').html('<i class="fa fa-edit iconTab"></i>Chọn danh mục hiển thị bài viết');
                $('#rdoLuunhap').css("display", "none");
                $('#hienthi').prop('checked', true);
                var dscheck = $('#danhmucbaiviet input');
                $.each(dscheck, function (key, val) {
                    $(this).attr("disabled", false);
                });
                $('#btnUpdateBaiviet').remove();
                $('#btnChonDangMuc').remove();
                $('#frmbutton').empty();
                $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChonDangMuc"><i class="fa fa-save iconButtonPage"></i>Đồng ý</button>');
                $('#btnThemmoibaiviet').remove();

                $('#frm1').css("display", "none");
                $('#frm2').css("display", "none");
                $('#frm3').css("display", "none");
                $('#frm4').css("display", "none");
                $('#frm5').css("display", "none");
                $('#frm6').css("display", "none");

                themmoidanhmucvalichhienthichobaiviet(id_baiviet);
            } else {
                $('#libaivietdanhmuc').css("display", "block");
                $('#libaivietdanhmuc').addClass('active');
                $('#chitietbvtrongdm').addClass('active');
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').css('display', 'none');
                var tenbaiviet = data.tieude;
                if (tenbaiviet.length > 50) {
                    tenbaiviet = tenbaiviet.substring(0, 50) + "...";
                }
                $('#titledm').html('<i class="fa fa-edit iconTab"></i>' + tenbaiviet);
                loadthongtinchitietbaiviettintuc(data);
            }

        });
    }
}
function themoibaivietLienKetHopTac() {
    $("input:radio[name=optionsRadios]").on("click", function () {
        if ($(this)[0].id == "hengio") {
            $('#btnok').remove();
            $('#titleherader').remove();
            $('#loaidatlich').remove();
            $('#lblHinhthuc').remove();
            $('#dateend').remove();
            $('#timeend').remove();
            $('#uutien').remove();
            $('#laptheogio').remove();
            $('#lblBatDau').remove();
            $('#lblKetthu').remove();
            $('#lichuutien').remove();
            $('#form1').remove();
            $('#form2').remove();

            $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Chọn lịch</button>');
            $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                $('#titleModal').html("Đặt lịch hiển thị cho bài viêt");
            });
            //
            var _TenLich = "";
            $('#batdau').empty();
            $('#ketthu').empty();
            $('#toanthoigian').css('display', 'block');

            setTimeout(function () {
                $('#ModalLichHienthi').modal('show');
                $('#btnok').click(function () {
                    $('#ngayvagio').remove();
                    var gio = $('#timeStart').val();
                    var ngay = $('#fullDateStart').val();
                    $('#btnCances').click();
                    $('#radiohengio').append('<label id="ngayvagio">' + ngay + " " + gio + '</label>');
                });

            }, 230);
        } else {
            $('#ngayvagio').empty();
        }
    });


    var check = true;
    var dsadminShare = new Array();
    var hinhthuchienthi = "";
    var tag = "";
    $('#frmbutton').empty();
    $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoibaiviet"><i class="fa fa-plus iconButtonPage"></i>Thêm bài viết</button>');
    $('#rdoLuunhap').css("display", "block");

    $('#btnThemmoibaiviet').click(function () {
        dsadminShare = [];
        tag = "";
        hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var avatar = $('#lbl_anhdaidien').text();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        var tacgia = $('#tacgia').val();
        tag = $('#tag').val();
        var ngaydatlich = $('#ngayvagio').text();

        var dscheck = $('#danhmucbaiviet input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề bài viết !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập phần giới thiệu bài viết !');
            return check = false;
        } else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện cho bài viết !');
            return check = false;
        }
        else if (tag == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập từ khóa cho bài viết !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hienthi" && dsadminShare.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
            return check = false;
        }

        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                avatar: avatar,
                noidung: noidung,
                tacgia: tacgia,
                tag: tag,
                ngaydatlich: ngaydatlich,
                hinhthuchienthi: hinhthuchienthi,
                idRoot: 9
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('dsdanhmuc', JSON.stringify(dsadminShare));
            fd_data.append('type', 'themmoibaiviet');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaiviet').DataTable();


            $('#btnThemmoibaiviet').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            $('#previewavbv').html('');
                            $('#lbl_anhdaidien').text('');
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            $('#ngayvagio').text('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            var a = $('#danhmucbaiviet').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                            var b = $('.bootstrap-tagsinput').find('span');
                            $.each(b, function (key, val) {
                                $(this).remove();
                            });
                            $('#tag').tagsinput('removeAll');

                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoibaiviet').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoibaiviet').removeAttr('disabled');
            });
        }
    });
}
function createcheckboxLienKetHopTac(data) {
    var $danhmuc = $('#danhmucbaiviet');
    $.each(data.danhsach, function (x2, value) {
        if (value.idParent == 0) {
            if ($(this)[0].danhsach.length > 0) {
                RootHopTacQT = true;
            }
        }
        if (value.trangthai == 1) {
            var $li = $('<div/>', {
                class: 'checkbox col-xs-4',
                html: '<label><input data-idadmin="' + JSON.stringify(value.id_danhmuc) + '" id="iddm' + value.id_danhmuc + '" type="checkbox" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
            if (value.danhsach != null && value.trangthai == 1) {
                if (value.danhsach.length > 0) {
                    createcheckboxLienKetHopTac(value);
                }
            }
        }
        return $li;
    });
    var ds = $('#danhmucbaiviet div');
    ds.first().attr('name', 'cha');
    return $danhmuc;
}



//QUẢN LÝ TRANG GIỚI THIỆU --ok

function initQuanLyTrangGioiThieu() {
    curentPage = 0;

    $('#liaddnew').click(function () {

        $('#themmoibaivietdmgt').addClass('active');
        $('#danhsachbaigioithieu').removeClass('active');
        $('#frmdanhmuc').addClass('andi');

    });

    $('#lidanhsach').click(function () {
        $('#themmoibaivietdmgt').removeClass('active');
        $('#danhsachbaigioithieu').addClass('active');
        $('#frmdanhmuc').removeClass('andi');
        $('#liaddnew').css('display', 'none');
        CKEDITOR.instances['noidung'].setData('');
        $('#liupdate').remove();
    });
    loaddanhmuctranggioithieu();
    themmoibaiviettranggioithieu();
}
function loaddanhmuctranggioithieu() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhmuctranggioithieu' }, function (data) {
        $.each(data.data, function (x2, value) {
            $('#frmDropDM').append(' <option data-idDM="' + JSON.stringify(value.id_danhmuc) + '" id="id' + value.id_danhmuc + '">' + value.tendanhmuc + '</option>');
        });
        var idDMDefault = $('#frmDropDM option:selected').attr('id');
        var iddm_df = $('#' + idDMDefault).data('iddm');
        loaddanhsachbaivietcuadanhmucgioithieu(iddm_df);

        $('#frmDropDM').change(function () {
            var idDMSelect = $('#frmDropDM option:selected').attr('id');
            var iddm_sl = $('#' + idDMSelect).data('iddm');
            loaddanhsachbaivietcuadanhmucgioithieu(iddm_sl);

        });

    });

}

function loaddanhsachbaivietcuadanhmucgioithieu(idDM) {
    var $card_content = $('#danhsachbaigioithieu');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbaigioithieu',
            html: '<thead>\
                            <th>Bài viết</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbaigioithieu').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachbaivietcuadanhmucgioithieu&idDM=' + idDM,
            "columns": [
                  { data: "tendanhmuc" },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          return data = '';
                      }
                  },
            ],
            "pagingType": "full_numbers",
            "bSort": false,
            initComplete: function (settings, json) {
                if (json.data.length > 0) {
                    $('#liaddnew').css('display', 'none');
                } else {
                    $('#liaddnew').css('display', 'block');
                }
            }
        });
        var parent = $('#tb_danhsachbaigioithieu').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbaigioithieu').DataTable();
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var idBV = data.id_baivietGT;
            $('#liaddnew').css('display', 'none');
            $('#frmdanhmuc').addClass('andi');
            $('#ulmenu').append(' <li class="active" id="liupdate"><a href="#themmoibaivietdmgt" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chỉnh sửa thông tin bài viết</a></li>');

            $('#themmoibaivietdmgt').addClass('active');

            $('#lidanhsach').removeClass('active');
            $('#danhsachbaigioithieu').removeClass('active');
            $('#frmbutton').empty();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnSaves"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            CKEDITOR.instances['noidung'].setData(data.noidung);

            capnhatthongtinbvgt(idBV);

        });

    }

}

function capnhatthongtinbvgt(id_baivietGT) {

    var check = true;

    $('#btnSaves').click(function () {

        var noidung = CKEDITOR.instances['noidung'].getData();
        if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else {
            var thongtin = {
                noidung: noidung,
                id_baivietGT: id_baivietGT
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinbvgt');
            fd_data.append("stringTookenClient", stringTookenServer);
            
            var table = $('#tb_danhsachbaigioithieu').DataTable();

            $('#btnSaves').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnSaves').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnSaves').removeAttr('disabled');
            });

        }
    });
}
function themmoibaiviettranggioithieu() {
    var check = true;
    $('#frmbutton').empty();
    $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemGioithieu"><i class="fa fa-plus iconButtonPage"></i>Thêm bài viết</button>');

    $('#btnThemGioithieu').click(function () {
        idDMDefault = "";
        iddmGT = "";
        idDMDefault = $('#frmDropDM option:selected').attr('id');
        iddmGT = $('#' + idDMDefault).data('iddm');
        var noidung = CKEDITOR.instances['noidung'].getData();

        if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else {
            var thongtin = {
                noidung: noidung,
                iddmGT: iddmGT
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoibaivietgioithieu');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaigioithieu').DataTable();

            $('#btnThemGioithieu').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemGioithieu').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemGioithieu').removeAttr('disabled');
            });

        }
    });
}


//QUẢN LÝ VĂN BẢN - ok


function initQuanLyVanBan() {
    loaddanhsachvanbantronghethong();

    loaddanhsachcoquanbanhanh();
    loaddanhsachloaivanban();
    $('#chosefile').click(function () {
        window.open(window.location.origin + "/file-vb", "Chọn file upload", "height=600,width=1000");
    });

    $('#lidanhsach').click(function () {
        $('#liupdate').removeClass('active');
        $('#liupdate').css('display', 'none')
        $('#liaddnew').removeClass('active');
        $('#liaddnew').css('display', 'block');
        $('#themmoivanban').removeClass('active');
        $('#lidanhsach').addClass('active');
        $('#danhsachvanban').addClass('active');
        $('#tb_danhsachvanban').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachvanbantronghethong&id=0').load();
    });
    $('#liaddnew').click(function () {
        $('#liupdate').removeClass('active');
        $('#liupdate').css('display', 'none')
        $('#liaddnew').addClass('active');
        $('#liaddnew').css('display', 'block');
        $('#themmoivanban').addClass('active');
        $('#lidanhsach').removeClass('active');
        $('#danhsachvanban').removeClass('active');
        $('#frmbutton').empty();
        $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoivanban"><i class="fa fa-plus iconButtonPage"></i>Thêm văn bản</button>');
        themmoivanban();

        $('#tenvanban').val('');
        $('#sokyhieu').val('');
        $('#ngaybanhanh').val('');
        $('#trichyeu').val('');
        $('#noidung').val('');
        $('#duongdan').val('');
    });


}
function loaddanhsachcoquanbanhanh() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachcoquanbanhanh' }, function (data) {
        createCoquan(data);
    });
}
function loaddanhsachloaivanban() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachloaivanban' }, function (data) {
        createLoaiVB(data);
    });
}

function createCoquan(data) {
    var $danhmuc = $('#coquanbanhanh');
    $.each(data.data, function (x2, value) {
        if (value.trangthai == 1) {
            var $li = $('<div />', {
                class: 'radio col-xs-4',
                html: '<label><input name="rdbCoQuan" value = "' + value.tendanhmuc + '" data-idcoquan="' + JSON.stringify(value.id_danhmuc) + '" id="idcq' + value.id_danhmuc + '" type="radio" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
        }
        return $li;
    });
    $("#coquanbanhanh input:radio[name=rdbCoQuan]:first").prop('checked', true);
    return $danhmuc;
}

function createLoaiVB(data) {
    var $danhmuc = $('#loaivanban');
    $.each(data.data, function (x2, value) {
        if (value.trangthai == 1) {
            var $li = $('<div />', {
                class: 'radio col-xs-4',
                html: '<label><input name="rdbLoaiVB" value = "' + value.tendanhmuc + '" data-idloaivb="' + JSON.stringify(value.id_danhmuc) + '" id="idlvb' + value.id_danhmuc + '" type="radio" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
        }
        return $li;
    });
    $("#loaivanban input:radio[name=rdbLoaiVB]:first").prop('checked', true);
    return $danhmuc;
}


function getLinkFile(link) {
    $('#duongdan').val(link);
}

function themmoivanban() {

    var trangthaihienthi;
    var check = true;
    var dsDM = new Array();
    $('#btnThemmoivanban').click(function () {
        dsDM = [];
        var tenvanban = $('#tenvanban').val();
        var sokyhieu = $('#sokyhieu').val();
        var ngaybh = $('#ngaybanhanh').val();
        var trichyeu = $('#trichyeu').val();
        var noidung = $('#noidung').val();
        var duongdanfile = $('#duongdan').val();
        var idcoquan = $("#coquanbanhanh input[type='radio']:checked").attr('id');
        var idloaivb = $("#loaivanban input[type='radio']:checked").attr('id');

        var id_coquanbanhanh = $('#' + idcoquan).data('idcoquan');
        var id_loaivanban = $('#' + idloaivb).data('idloaivb');

        trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        if (tenvanban == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tên văn bản !');
            return check = false;
        } else if (sokyhieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập số ký hiệu văn bản !');
            return check = false;
        } else if (ngaybh == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ngày ban hành văn bản !');
            return check = false;
        }
        else if (trichyeu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập trích yếu của văn bản !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho văn bản !');
            return check = false;
        }
        else if (duongdanfile == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn file đính kèm của văn bản !');
            return check = false;
        }
        else if (id_coquanbanhanh == "") {
            common.showNotification('top', 'right', 'Văn bản chưa được cơ quan ban hành !');
            return check = false;
        }
        else if (id_loaivanban == "") {
            common.showNotification('top', 'right', 'Mời chọn loại văn bản !');
            return check = false;
        }
        else {
            var thongtin = {
                tenvanban: tenvanban,
                sokyhieu: sokyhieu,
                ngaybh: ngaybh,
                trichyeu: trichyeu,
                noidung: noidung,
                duongdanfile: duongdanfile,
                trangthaihienthi: trangthaihienthi,
                id_coquanbanhanh: id_coquanbanhanh,
                id_loaivanban: id_loaivanban
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoivanban');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachvanban').DataTable();

            $('#btnThemmoivanban').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#tenvanban').val('');
                            $('#sokyhieu').val('');
                            $('#ngaybanhanh').val('');
                            $('#trichyeu').val('');
                            $('#noidung').val('');
                            $('#duongdan').val('');

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoivanban').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoivanban').removeAttr('disabled');
            });
        }
    });


}
function loaddanhsachvanbantronghethong() {
    var $card_content = $('#danhsachvanban');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachvanban',
            html: '<thead>\
                            <th></th>\
                            <th>Tên văn bản</th>\
                            <th>Số ký hiệu</th>\
                            <th>Nơi ban hành</th>\
                            <th>Loại văn bản</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachvanban').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachvanbantronghethong&id=0',
            "columns": [
                  { data: "ngaythang" },
                  {
                      data: "tenvanban",
                      mRender: function (data) {
                          if (data.length > 40) {
                              data = data.substring(0, 40) + "...";
                          }
                          return data;
                      }
                  },
                  { data: "sokyhieu" },
                  {
                      data: "coquanbanhanh"
                  },
                   {
                       data: "loaivanban",
                   },
                   {
                       data: "trangthai",
                       mRender: function (data) {
                           if (data == 1) {
                               data = "Chỉ lưu";
                           } else {
                               data = "Hiển thị";
                           }
                           return data;
                       }
                   },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>\
                              <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>';
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa bài viết"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachvanbantronghethong&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tenvanban.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.sokyhieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.trichyeu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.kieuvanban.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.ngaybanhanh.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.coquanbanhanh.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.loaivanban.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_vanban) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachvanbantronghethong&id=" + u.item.id_vanban;
                                settings.id = u.item.id_vanban;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tenvanban + '</div><div class="noidung2">' + item.coquanbanhanh + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachvanban').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachvanban').DataTable();
        var check = true;
        var dsDM = new Array();
        var trangthaihienthi = "";
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_vanban = data.id_vanban;
            var _IDViTriCoQuan = data.id_coquanbanhanh;
            var _IDViTriLoaiVB = data.id_loaivanban;
            trangthaihienthi = "";
            $('#liupdate').addClass('active');
            $('#liupdate').css('display', 'block')
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#themmoivanban').addClass('active');
            $('#lidanhsach').removeClass('active');
            $('#danhsachvanban').removeClass('active');
            $('#frmbutton').empty();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateVB"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#tenvanban').val(data.tenvanban);
            $('#sokyhieu').val(data.sokyhieu);
            $('#ngaybanhanh').val(data.ngaybanhanh);
            $('#trichyeu').val(data.trichyeu);
            $('#noidung').val(data.noidung);
            $('#duongdan').val(data.duongdanfile);

            if (data.trangthai == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#luunhap").prop("checked", true);
            }

            var idcoquan = $("#coquanbanhanh input[type='radio']");
            $.each(idcoquan, function (key1, val1) {
                var id = val1.id;
                var idCQ = $('#' + id).data('idcoquan');
                if (idCQ == _IDViTriCoQuan) {
                    $("#" + id).prop('checked', true);
                }
            });


            var idloaivb = $("#loaivanban input[type='radio']");
            $.each(idloaivb, function (key2, val2) {
                var idvb = val2.id;
                var idVB = $('#' + idvb).data('idloaivb');
                if (idVB == _IDViTriLoaiVB) {
                    $("#" + idvb).prop('checked', true);
                }
            });

            $('#btnUpdateVB').click(function () {
                var tenvanban = $('#tenvanban').val();
                var sokyhieu = $('#sokyhieu').val();
                var ngaybh = $('#ngaybanhanh').val();
                var trichyeu = $('#trichyeu').val();
                var noidung = $('#noidung').val();
                var duongdanfile = $('#duongdan').val();
                var idcoquan = $("#coquanbanhanh input[type='radio']:checked").attr('id');
                var idloaivb = $("#loaivanban input[type='radio']:checked").attr('id');

                trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

                var idCQ = $('#' + idcoquan).data('idcoquan');
                var idVB = $('#' + idloaivb).data('idloaivb');

                if (tenvanban == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập tên văn bản !');
                    return check = false;
                } else if (sokyhieu == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập số ký hiệu văn bản !');
                    return check = false;
                } else if (ngaybh == "") {
                    common.showNotification('top', 'right', 'Mời bạn chọn ngày ban hành văn bản !');
                    return check = false;
                }
                else if (trichyeu == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập trích yếu của văn bản !');
                    return check = false;
                }
                else if (noidung == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho văn bản !');
                    return check = false;
                }
                else if (duongdanfile == "") {
                    common.showNotification('top', 'right', 'Mời bạn chọn file đính kèm của văn bản !');
                    return check = false;
                }
                else if (idCQ == "" || idVB == "") {
                    common.showNotification('top', 'right', 'Văn bản chưa được chọn danh mục !');
                    return check = false;
                }
                else {
                    var thongtin = {
                        tenvanban: tenvanban,
                        sokyhieu: sokyhieu,
                        ngaybh: ngaybh,
                        trichyeu: trichyeu,
                        noidung: noidung,
                        duongdanfile: duongdanfile,
                        id_vanban: id_vanban,
                        _IDViTriCoQuan: _IDViTriCoQuan,
                        _IDViTriLoaiVB: _IDViTriLoaiVB,
                        idCQ: idCQ,
                        idVB: idVB,
                        trangthaihienthi: trangthaihienthi
                    }
                    var fd_data = new FormData();
                    fd_data.append('thongtin', JSON.stringify(thongtin));
                    fd_data.append('type', 'capnhatthongtinvanban');
                    fd_data.append("stringTookenClient", stringTookenServer);

                    var table = $('#tb_danhsachvanban').DataTable();

                    $('#btnUpdateVB').attr('disabled', 'true');
                    swal({
                        title: 'Cập nhật thông tin',
                        text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.ajax({
                            type: "POST",
                            url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                            data: fd_data,
                            contentType: false,
                            processData: false,
                            success: function (kq) {
                                var data = JSON.parse(kq);
                                if (data.suscess) {
                                    swal('Thông báo ', data.msg, 'success')
                                    $('#tenvanban').val('');
                                    $('#sokyhieu').val('');
                                    $('#ngaybanhanh').val('');
                                    $('#trichyeu').val('');
                                    $('#noidung').val('');
                                    $('#duongdan').val('');

                                } else {
                                    swal('Thông báo ', data.msg, 'error')
                                }
                                $('.loader-parent').css('display', 'none');
                                $('#btnUpdateVB').removeAttr('disabled');
                                table.ajax.reload();
                            }
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh cập nhật đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateVB').removeAttr('disabled');
                    });

                }
            });
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_vanban;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa văn bản',
                text: "Bạn có chắc sẽ xóa văn bản này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoavanban', id_baiviet: id_baiviet }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoavanban', id_baiviet: id_baiviet }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });

        });

    }
}

// QUẢN LÝ VÀ THÊM MỚI BÀI VIẾT -ok
function initQuanLyBaiViet() {
    curentPage = 0;
    loaddanhsachbaiviet();
    loadimage();
    loaddanhsachdanhmucthembaiviet();

    $('#chosefileavbv').click(function () {
        window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
    });
    $('#liaddnew').click(function () {
        $('#frmbutton').empty();
        $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnThemmoibaiviet"><i class="fa fa-plus iconButtonPage"></i>Thêm bài viết</button>');
        if (RootBV == true) {
            var a = $('#danhmucbaiviet').find('div[name="cha"]').remove();
        }
        themoibaiviet();
    });
    $('#lidanhsach').click(function () {
        $('#tb_danhsachbaiviet').DataTable().ajax.url('/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachbaiviet&id=0').load();
    });
}
function loaddanhsachdanhmucthembaiviet() {

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachdanhmuctintuc' }, function (data) {
        createcheckbox(data);
    });
}
function createcheckbox(data) {
    var $danhmuc = $('#danhmucbaiviet');
    $.each(data.danhsach, function (x2, value) {
        if (value.idParent == 0) {
            if ($(this)[0].danhsach.length > 0) {
                RootBV = true;
            }
        }
        if (value.trangthai == 1) {
            var $li = $('<div/>', {
                class: 'checkbox col-xs-4',
                html: '<label><input data-idadmin="' + JSON.stringify(value.id_danhmuc) + '" id="iddm' + value.id_danhmuc + '" type="checkbox" />' + value.tendanhmuc + '</label>'
            }).appendTo($danhmuc);
            if (value.danhsach != null && value.trangthai == 1) {
                if (value.danhsach.length > 0) {
                    createcheckbox(value);
                }
            }
        }
        return $li;
    });
    var ds = $('#danhmucbaiviet div');
    ds.first().attr('name', 'cha');
    return $danhmuc;
}
function themoibaiviet() {
    $("input:radio[name=optionsRadios]").on("click", function () {
        if ($(this)[0].id == "hengio") {
            $('#btnok').remove();
            $('#titleherader').remove();
            $('#loaidatlich').remove();
            $('#lblHinhthuc').remove();
            $('#dateend').remove();
            $('#timeend').remove();
            $('#uutien').remove();
            $('#laptheogio').remove();
            $('#lblBatDau').remove();
            $('#lblKetthu').remove();
            $('#lichuutien').remove();
            $('#form1').remove();
            $('#form2').remove();

            $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Chọn lịch</button>');
            $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                $('#titleModal').html("Đặt lịch hiển thị cho bài viêt");
            });
            //
            var _TenLich = "";
            $('#batdau').empty();
            $('#ketthu').empty();
            $('#toanthoigian').css('display', 'block');

            setTimeout(function () {
                $('#ModalLichHienthi').modal('show');
                $('#btnok').click(function () {
                    $('#ngayvagio').remove();
                    var gio = $('#timeStart').val();
                    var ngay = $('#fullDateStart').val();
                    $('#btnCances').click();
                    $('#radiohengio').append('<label id="ngayvagio">' + ngay + " " + gio + '</label>');
                });

            }, 230);
        } else {
            $('#ngayvagio').empty();
        }
    });
    var check = true;
    var dsadminShare = new Array();
    var hinhthuchienthi = "";
    var tag = "";

    $('#rdoLuunhap').css("display", "block");

    $('#btnThemmoibaiviet').click(function () {
        dsadminShare = [];
        tag = "";
        hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var avatar = $('#lbl_anhdaidien').text();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        var tacgia = $('#tacgia').val();
        tag = $('#tag').val();
        var ngaydatlich = $('#ngayvagio').text();


        var dscheck = $('#danhmucbaiviet input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề bài viết !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập phần giới thiệu bài viết !');
            return check = false;
        } else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện cho bài viết !');
            return check = false;
        }
        else if (tag == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập từ khóa cho bài viết !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hienthi" && dsadminShare.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
            return check = false;
        }

        else {
            var thongtin = {
                tieude: tieude,
                gioithieu: gioithieu,
                avatar: avatar,
                noidung: noidung,
                tacgia: tacgia,
                tag: tag,
                ngaydatlich: ngaydatlich,
                hinhthuchienthi: hinhthuchienthi,
                idRoot: 3
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('dsdanhmuc', JSON.stringify(dsadminShare));
            fd_data.append('type', 'themmoibaiviet');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaiviet').DataTable();


            $('#btnThemmoibaiviet').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            $('#previewavbv').html('');
                            $('#lbl_anhdaidien').text('');
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            $('#ngayvagio').text('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            var a = $('#danhmucbaiviet').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                            var b = $('.bootstrap-tagsinput').find('span');
                            $.each(b, function (key, val) {
                                $(this).remove();
                            });
                            $('#tag').tagsinput('removeAll');
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoibaiviet').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoibaiviet').removeAttr('disabled');
            });
        }
    });
}

function loaddanhsachbaiviet() {
    var $card_content = $('#danhsachbaiviet');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbaiviet',
            html: '<thead>\
                            <th></th>\
                            <th>Tiêu đề</th>\
                            <th>Tác giả</th>\
                            <th>Ngày tạo</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        var table = $('#tb_danhsachbaiviet').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachbaiviet&id=0',

            "columns": [
                  { data: "ngaythang" },
                  {
                      data: "tieude",
                      mRender: function (data) {
                          if (data.length > 40) {
                              data = data.substring(0, 40) + "...";
                          }
                          return data;
                      }
                  },
                  { data: "tacgia" },
                  { data: "ngaytao" },
                  {
                      data: "button", "width": "105px",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-list-ul btnDSDM iconButton" aria-hidden="true" rel="tooltip" title="Danh mục hiển thị"></i>\
                                         <i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true"  rel="tooltip" title="Sửa bài viết"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<i class="fa fa-trash-o btnDelete iconButton" aria-hidden="true" rel="tooltip" title="Xóa bài viết"></i>';
                          }
                          else if (data.sua == true) {
                              return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true"  rel="tooltip" title="Sửa bài viết"></i>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
               {
                   "targets": [0],
                   "visible": false,
                   "searchable": false
               },
            ],
            drawCallback: function (settings) {

                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));
                    if (settings.id != 0 && settings.id != undefined) {
                        fnFilter.keyup();
                        settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachbaiviet&id=0";
                        settings.id = 0;
                    }
                }
            },
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                // tim kiếm
                if (settings.aanFeatures.f[0]) {
                    var fnFilter = $(settings.aanFeatures.f[0].querySelector('input'));

                    var width = fnFilter[0].clientWidth - 22;

                    var source = [];
                    $.each(json.data, function (key, value) {
                        $.each(value, function (key2, value2) {
                            if (typeof value2 !== 'object') {
                                source.push(value2);
                            }
                        });
                    });
                    fnFilter.autocomplete({
                        source: function (req, responseFn) {
                            var words = req.term.split(' ')
                            var resultsOfSearchTitle = $.grep(json.data, function (data, index) {
                                return words.every(function (word) {
                                    if (data.tacgia.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.noidung.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tieude.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.gioithieu.toLowerCase().indexOf(word.toLowerCase()) != -1 || data.tag.toLowerCase().indexOf(word.toLowerCase()) != -1) {
                                        return true;
                                    }
                                    return false;
                                });
                            });
                            responseFn(resultsOfSearchTitle.slice(0, 5));
                        },
                        select: function (e, u) {
                            if (u.item.id_baiviet) {
                                settings.ajax = "/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachbaiviet&id=" + u.item.id_baiviet;
                                settings.id = u.item.id_baiviet;
                                table.ajax.reload();
                            }
                        },

                    }).data("ui-autocomplete")._renderItem = function (ul, item) {
                        return $("<li>", {
                            class: "noidung1",
                            html: '<div class="noidung1" style="width:' + width + 'px">' + item.tieude + '</div><div class="noidung2">' + item.tacgia + '</div>'
                        }).appendTo(ul);
                    };

                }
                // tim kiem
            },
            "order": [[0, 'desc']],
            "bSort": false,
            "bServerSide": true,
        });
        var parent = $('#tb_danhsachbaiviet').parent().addClass('box-body table-responsive no-padding');

        $('#tb_danhsachbaiviet_length').remove();

        $('#liaddnew').click(function () {
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#rdoLuunhap').css("display", "block");
            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");

            var dscheck = $('#danhmucbaiviet input');
            $.each(dscheck, function (key, val) {
                $(this).prop("disabled", false);
                $(this).prop('checked', false);
            });
            $('#hienthi').prop('checked', true);
            //  themoibaiviet();
        });
        $('#lidanhsach').click(function () {

            table.ajax.reload();
            $('#lidanhsach').addClass('active');
            $('#danhsachbaiviet').addClass('active');
            $('#lichitiet').removeClass('active');
            $('#lichitiet').css('display', 'none');
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'block');
            $('#themmoibaiviet').removeClass('active');
            $('#titleupdate').html('<i class="fa fa-plus iconTab"></i> Thêm mới bài viết');
            $('#frmdanhmuc').css("display", "block");
            $('#frmtrangthai').css("display", "block");
            $('#libaivietdanhmuc').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').css("display", "none");
            $('#previewavbv').html('');
            $('#lbl_anhdaidien').text('');
            //$('#name').html('');
            //$('#size').html('');
            //$('#type').html('');
            $('#tieude').val('');
            $('#gioithieu').val('');
            $('#tacgia').val('');
            $('#ngayvagio').text('');
            CKEDITOR.instances['txt_noidung'].setData('');
            var a = $('#danhmucbaiviet').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
            var b = $('.bootstrap-tagsinput').find('span');
            $.each(b, function (key, val) {
                $(this).remove();
            });
            $('#tag').tagsinput('removeAll');
        });
        table.on('click', 'i.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            $('#frm1').css("display", "block");
            $('#frm2').css("display", "block");
            $('#frm3').css("display", "block");
            $('#frm4').css("display", "block");
            $('#frm5').css("display", "block");
            $('#frm6').css("display", "block");
            $('#lidanhsach').removeClass('active');
            $('#danhsachbaiviet').removeClass('active');
            $('#liaddnew').addClass('active');
            $('#themmoibaiviet').addClass('active');
            $('#titleupdate').html('<i class="fa fa-edit iconTab"></i> Sửa thông tin bài viết');
            $('#frmdanhmuc').css("display", "none");
            $('#frmtrangthai').css("display", "none");

            $('#btnUpdateBaiviet').remove();
            $('#btnChonDangMuc').remove();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdateBaiviet"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
            $('#btnThemmoibaiviet').remove();

            $('#previewavbv').empty();
            $('#previewavbv').append('<img src="' + data.avatar + '" width="100px" height="100px">');
            $('#lbl_anhdaidien').text(data.avatar);
            $('#tieude').val(data.tieude);
            $('#gioithieu').val(data.gioithieu);
            $('#tacgia').val(data.tacgia);
            CKEDITOR.instances['txt_noidung'].setData(data.noidung);
            var splitted = data.tag.split(",");
            var inputVal = "";
            $.each(splitted, function (key, value) {
                inputVal += value + ",";
                var focusssInput = $(".bootstrap-tagsinput input").val(inputVal);
                focusssInput.focus();
            });
            capnhatthongtinbaiviettintuc(id_baiviet);
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;
            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa bài viết',
                text: "Bạn có chắc sẽ xóa bài viết này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabaiviettintuc', id_baiviet: id_baiviet }).then(function (thongtinadmin) {
             //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabaiviettintuc', id_baiviet: id_baiviet }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                    table.ajax.reload();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnDelete').removeAttr('disabled');
            });

        });
        table.on('click', 'i.btnDSDM', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_baiviet = data.id_baiviet;

            if (data.trangthaibaiviet == 2) {
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').removeClass('active');
                $('#liaddnew').css('display', 'none');
                $('#lichitiet').addClass('active');
                $('#lichitiet').css('display', 'block');
                $('#themmoibaiviet').addClass('active');
                $('#titlechitiet').html('<i class="fa fa-edit iconTab"></i>Chọn danh mục hiển thị bài viết');
                $('#rdoLuunhap').css("display", "none");
                $('#hienthi').prop('checked', true);
                var dscheck = $('#danhmucbaiviet input');
                $.each(dscheck, function (key, val) {
                    $(this).attr("disabled", false);
                });
                $('#btnUpdateBaiviet').remove();
                $('#btnChonDangMuc').remove();
                $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChonDangMuc"><i class="fa fa-save iconButtonPage"></i>Đồng ý</button>');

                $('#btnThemmoibaiviet').remove();

                $('#frm1').css("display", "none");
                $('#frm2').css("display", "none");
                $('#frm3').css("display", "none");
                $('#frm4').css("display", "none");
                $('#frm5').css("display", "none");
                $('#frm6').css("display", "none");

                themmoidanhmucvalichhienthichobaiviet(id_baiviet);
            } else {
                $('#libaivietdanhmuc').css("display", "block");
                $('#libaivietdanhmuc').addClass('active');
                $('#chitietbvtrongdm').addClass('active');
                $('#lidanhsach').removeClass('active');
                $('#danhsachbaiviet').removeClass('active');
                $('#liaddnew').css('display', 'none');
                var tenbaiviet = data.tieude;
                if (tenbaiviet.length > 50) {
                    tenbaiviet = tenbaiviet.substring(0, 50) + "...";
                }
                $('#titledm').html('<i class="fa fa-edit iconTab"></i>' + tenbaiviet);
                loadthongtinchitietbaiviettintuc(data);
            }

        });
    }
}
function capnhatthongtinbaiviettintuc(id_baiviet) {

    $('#btnUpdateBaiviet').click(function () {
        var check = true;

        var tag = "";

        var tieude = $('#tieude').val();
        var gioithieu = $('#gioithieu').val();
        var avatar = $('#lbl_anhdaidien').text();
        var noidung = CKEDITOR.instances['txt_noidung'].getData();
        var tacgia = $('#tacgia').val();
        tag = $('#tag').val();

        if (tieude == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tiêu đề bài viết !');
            return check = false;
        } else if (gioithieu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập phần giới thiệu bài viết !');
            return check = false;
        }
        else if (tag == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập từ khóa cho bài viết !');
            return check = false;
        }
        else if (noidung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập nội dung cho bài viết !');
            return check = false;
        }
        else if (tacgia == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập tác giả cho bài viết !');
            return check = false;
        } else if (id_baiviet == "") {
            common.showNotification('top', 'right', 'Có lỗi trong quá trình thao tác vui lòng thực hiện lại !');
            return check = false;
        }
        else {
            var thongtin = {
                id_baiviet: id_baiviet,
                tieude: tieude,
                gioithieu: gioithieu,
                noidung: noidung,
                tacgia: tacgia,
                tag: tag,
                avatar: avatar
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinbaiviettintuc');
            fd_data.append("stringTookenClient", stringTookenServer);


            var table = $('#tb_danhsachbaiviet').DataTable();

            $('#btnUpdateBaiviet').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#previewavbv').html('');
                            $('#lbl_anhdaidien').val('');
                            $('#tieude').val('');
                            $('#gioithieu').val('');
                            $('#tacgia').val('');
                            $('#ngayvagio').text('');
                            CKEDITOR.instances['txt_noidung'].setData('');
                            var b = $('.bootstrap-tagsinput').find('span');
                            $.each(b, function (key, val) {
                                $(this).remove();
                            });
                            $('#tag').tagsinput('removeAll');

                            $('#lidanhsach').addClass('active');
                            $('#danhsachbaiviet').addClass('active');
                            $('#liaddnew').removeClass('active');
                            $('#themmoibaiviet').removeClass('active');
                            $('#titleupdate').html('<i class="fa fa-plus iconTab"></i>Thêm mới bài viết');
                            $('#frmdanhmuc').css("display", "block");
                            $('#frmtrangthai').css("display", "block");

                            $('#btnUpdateBaiviet').css("display", "none");
                            $('#btnThemmoibaiviet').css("display", "block");
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdateBaiviet').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUpdateBaiviet').removeAttr('disabled');
            });
        }
    });
}
function loadthongtinchitietbaiviettintuc(data) {
    var $card_content = $('#chitietbvtrongdm');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_chitietbvtrongdm',
            html: '<thead>\
                            <th>Danh mục đang hiển thị</th>\
                            <th>Trạng thái</th>\
                            <th>Ngày đăng</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_chitietbvtrongdm').DataTable({
            data: data.danhsach,
            "columns": [
                  {
                      data: "tendanhmuc",
                      mRender: function (data) {
                          if (data == "") {
                              data = "Chưa hiển thị ở danh mục nào";
                          }
                          return data;
                      }
                  },
                  {
                      data: "trangthaibaiviet",
                      mRender: function (data) {
                          if (data == 1) {
                              data = "Đang hiển thị";
                          } if (data == 2) {
                              data = "Đang hẹn giờ đăng";
                          } if (data == 3) {
                              data = "Lưu nháp chưa có lịch đăng";
                          }
                          return data;
                      }
                  },
                   {
                       data: "time"
                   },
                  {
                      data: "details", "width": "105px",
                      mRender: function (data) {

                          var $dtooltip = $('<div/>', {
                              html: '<i class="fa fa-trash-o iconButton btnRemove" aria-hidden="true"  rel="tooltip" title="Xóa bài viết"></i>'
                          });
                          return $dtooltip.html();
                      }
                  },

            ],
            "pagingType": "full_numbers",
            "bSort": false,
        });
        $('#tb_chitietbvtrongdm_length label').remove();
        $('#tb_chitietbvtrongdm_length').append('<button type="button" id="btnChonDM" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm danh mục</button>');

        var parent = $('#tb_chitietbvtrongdm').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_chitietbvtrongdm').DataTable();
        var table_danhsachbaiviet = $('#tb_danhsachbaiviet').DataTable();
        var dsDM = new Array();
        var _ListMoi = new Array();
        table.on('click', 'i.btnRemove', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_vitribv = data.id_vitribv;

            var id_baiviet = data.id_baiviet;
            $('.btnRemove').attr('disabled', 'true');
            swal({
                title: 'Xóa bài viết trong danh mục',
                text: "Bạn có chắc sẽ xóa bài viết khỏi danh mục này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabaiviettrongdanhmuctintuc', id_vitribv: id_vitribv }).then(function (thongtinadmin) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabaiviettrongdanhmuctintuc', id_vitribv: id_vitribv }, function (thongtinadmin) {

                    if (thongtinadmin.sucess == true) {
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnRemove').removeAttr('disabled');
                    table_danhsachbaiviet.ajax.reload(function (json) {
                        var itemcha = json.data.filterObjects('id_baiviet', id_baiviet);
                        if (itemcha.length > 0) {
                            table.clear().draw();
                            table.rows.add(itemcha[0].danhsach).draw()
                        }
                    });
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('.btnRemove').removeAttr('disabled');
            });

        });
        $('#btnChonDM').click(function () {
            dsDM = [];
            var _listIDDM = data.danhsach;
            var dscheck = $('#danhmucbaiviet input');
            var id_baiviet = data.id_baiviet;

            $.each(_listIDDM, function (key, val) {
                dsDM.push(val.id_danhmuc);
            });
            $.each(dscheck, function (key, val) {
                var idArrt = val.id;
                var idadm = $('#' + idArrt).data('idadmin');
                $(this).attr("disabled", false);
            });
            $.each(dscheck, function (key, val) {
                var idArrt = val.id;
                var idadm = $('#' + idArrt).data('idadmin');
                for (i = 0 ; i < dsDM.length; i++) {
                    if (dsDM[i] == idadm) {
                        $(this).attr("disabled", true);
                        $(this).prop('checked', true);
                    }
                }
            });
            $('#lidanhsach').removeClass('active');
            $('#danhsachbaiviet').removeClass('active');
            $('#chitietbvtrongdm').removeClass('active');
            $('#libaivietdanhmuc').removeClass('active');
            $('#libaivietdanhmuc').css('display', 'none');
            $('#liaddnew').removeClass('active');
            $('#liaddnew').css('display', 'none');
            $('#lichitiet').addClass('active');
            $('#lichitiet').css('display', 'block');
            $('#themmoibaiviet').addClass('active');
            $('#titlechitiet').html('<i class="fa fa-edit iconTab"></i>Chọn danh mục hiển thị bài viết');
            $('#rdoLuunhap').css("display", "none");
            $('#hienthi').prop('checked', true);
            $('#btnUpdateBaiviet').remove();
            $('#btnChonDangMuc').remove();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnChonDangMuc"><i class="fa fa-save iconButtonPage"></i>Đồng ý</button>');
            $('#btnThemmoibaiviet').remove();

            $('#frm1').css("display", "none");
            $('#frm2').css("display", "none");
            $('#frm3').css("display", "none");
            $('#frm4').css("display", "none");
            $('#frm5').css("display", "none");
            $('#frm6').css("display", "none");


            var _listDMNew = new Array();
            var hinhthuchienthi;
            $('#btnChonDangMuc').click(function () {
                var dmCheck = $('#danhmucbaiviet input:checked');
                _listDMNew = [];
                _ListMoi = [];
                hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
                var ngaydatlich = $('#ngayvagio').text();
                $.each(dmCheck, function (key, val) {
                    var idArrt = val.id;
                    var idadm = $('#' + idArrt).data('idadmin');
                    _listDMNew.push(idadm);
                });
                $.each(_listDMNew, function (key, val) {
                    for (i = 0 ; i < dsDM.length; i++) {
                        if (val == dsDM[i]) {
                            _listDMNew.splice($.inArray(val, _listDMNew), 1);
                        }
                    }
                });
                if (_listDMNew.length == 0) {
                    common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
                    return check = false;
                }
                else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
                    common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
                    return check = false;
                }
                else {
                    var thongtin = {
                        ngaydatlich: ngaydatlich,
                        hinhthuchienthi: hinhthuchienthi,
                        id_baiviet: id_baiviet
                    }
                    var fd_data = new FormData();
                    fd_data.append('thongtin', JSON.stringify(thongtin));
                    fd_data.append('dsdanhmuc', JSON.stringify(_listDMNew));
                    fd_data.append('type', 'themmoidanhmucvalichhienthichobaiviet');
                    fd_data.append("stringTookenClient", stringTookenServer);

                    $('#btnChonDangMuc').attr('disabled', 'true');
                    swal({
                        title: 'Thêm mới thông tin',
                        text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.ajax({
                            type: "POST",
                            url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                            data: fd_data,
                            contentType: false,
                            processData: false,
                            success: function (kq) {
                                var data = JSON.parse(kq);
                                if (data.suscess) {
                                    swal('Thông báo ', data.msg, 'success')
                                    $('#ngayvagio').text('');
                                    $('#liaddnew').removeClass('active');
                                    $('#liaddnew').css('display', 'block');
                                    $('#themmoibaiviet').removeClass('active');
                                    $('#lidanhsach').addClass('active');
                                    $('#danhsachbaiviet').addClass('active');
                                    $('#lichitiet').removeClass('active');
                                    $('#lichitiet').css('display', 'none');
                                } else {
                                    swal('Thông báo ', data.msg, 'error')
                                }
                                $('.loader-parent').css('display', 'none');
                                _listDMNew = [];
                                _ListMoi = [];
                                table_danhsachbaiviet.ajax.reload(function (json) {
                                    var itemcha = json.data.filterObjects('id_baiviet', id_baiviet);
                                    if (itemcha.length > 0) {
                                        table.clear().draw();
                                        table.rows.add(itemcha[0].danhsach).draw()
                                    }
                                });
                                $('#btnChonDangMuc').removeAttr('disabled');
                            }
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh thêm mới đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnChonDangMuc').removeAttr('disabled');
                    });
                }
            });
        });

    }
}
function themmoidanhmucvalichhienthichobaiviet(id_baiviet) {
    var check = true;
    var dsadminShare = new Array();
    var hinhthuchienthi = "";


    $('#btnChonDangMuc').click(function () {
        dsadminShare = [];
        hinhthuchienthi = $("#frmHienthi input[type='radio']:checked").val();
        var ngaydatlich = $('#ngayvagio').text();

        var dscheck = $('#danhmucbaiviet input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });


        if (dsadminShare.length == 0) {
            common.showNotification('top', 'right', 'Mời bạn chọn danh mục cho bài viết !');
            return check = false;
        }
        else if (hinhthuchienthi == "hengio" && ngaydatlich == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày giờ hiển thị cho bài viết !');
            return check = false;
        }

        else {
            var thongtin = {
                id_baiviet: id_baiviet,
                ngaydatlich: ngaydatlich,
                hinhthuchienthi: hinhthuchienthi
            }
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('dsdanhmuc', JSON.stringify(dsadminShare));
            fd_data.append('type', 'themmoidanhmucvalichhienthichobaiviet');
            fd_data.append("stringTookenClient", stringTookenServer);

            var table = $('#tb_danhsachbaiviet').DataTable();

            $('#btnChonDangMuc').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#ngayvagio').text('');
                            var dscheck = $('#danhmucbaiviet input');
                            $.each(dscheck, function (key, val) {
                                $(this).prop('checked', false);
                            });
                            $('#lidanhsach').addClass('active');
                            $('#danhsachbaiviet').addClass('active');
                            $('#liaddnew').removeClass('active');
                            $('#liaddnew').css('display', 'block');
                            $('#themmoibaiviet').removeClass('active');
                            $('#lichitiet').removeClass('active');
                            $('#lichitiet').css('display', 'none');

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnChonDangMuc').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnChonDangMuc').removeAttr('disabled');
            });
        }
    });
}




//QUẢN LÝ MENU TRONG TRANG CLIENT -ok
var node_cut, tinhtranghienthi;
var iconChon = "fa fa-check-square-o";
var iconCances = "fa fa-ban";
var vitri_Top, vitri_Left, vitri_Bottom;
function initQuanLyMenuTrongClient() {
    curentPage = 0;
    loadkeythumucmenuclient();

}
function loadkeythumucmenuclient() {
    SoChaDanhMuc = "";
    $(window).resize(function () {
        var h = Math.max($(window).height() - 0, 420);
        $('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
    }).resize();
    var $menuthumuc = $('#dragTree');
    var $dragTree = $('#dragTree');
    $('#ModalFolder').on('show.bs.modal', function (event) {
        $('#btnok').remove();
        $('#modalFolBody').empty();
        $('#modelSuDung_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');
        $('#modalFolBody').append('<form class="form-horizontal">\
            <div class="box-body">\
               <div class="form-group">\
                  <label for="inputEmail3" class="col-sm-2 control-label">Tên danh mục</label>\
                  <div class="col-sm-10">\
                    <input type="text" class="form-control" id="tendanhmuc" placeholder="Mời bạn nhập tên danh mục">\
                  </div>\
                </div>\
                <div class="form-group">\
                  <label for="inputPassword3" class="col-sm-2 control-label">Số thứ tự</label>\
                  <div class="col-sm-10">\
                    <input type="text" class="form-control" id="sothutu" placeholder="Vị trí hiển thị của danh mục trong menu">\
                  </div>\
                </div>\
              </div>\
              </form>');

    });
    $menuthumuc.jstree({
        'core': {
            'data': {
                'url': function (node) {
                    return node.id === '#' ? '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadkeythumucmenuclient&id_tm=0' : '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadkeythumucmenuclient&id_tm=' + node.id;
                },
                'data': function (node) {
                    return {
                        'id': node.id, types: {
                            'default': {
                                'icon': node.icon
                            }
                        }
                    };
                }
            },
            'check_callback': function (o, n, p, i, m) {
                if (m && m.dnd && m.pos !== 'i') { return false; }

                if (o === "move_node" || o === "copy_node") {
                    if (this.get_node(n).parent === this.get_node(p).id) { return false; }
                }
                return true;
            },
            'themes': {
                'responsive': false
            }
        },
        'contextmenu': {
            'items': function (node) {
                var node_selected = $('#dragTree').jstree('get_selected', true);
                var _nodeGoc = node_selected[0].parent;
                var arrMenu = {};
                arrMenu.add = {
                    label: 'Thêm mới',
                    icon: 'fa fa-plus-circle',
                    action: function (data) {
                        $('#ModalFolder').modal('show');
                        $('#tieudeModel').html('Tạo mới danh mục');
                        $('#btnok').click(function () {
                            var check = true;
                            var tendanhmuc = $('#tendanhmuc').val();
                            var sothutu = $('#sothutu').val();
                            if (tendanhmuc.length < 1) {
                                common.showNotification('top', 'right', 'Mời bạn nhập tên cho danh mục !');
                                return check = false;
                            }
                            else if (!($.isNumeric(sothutu)) || sothutu <= 0) {
                                common.showNotification('top', 'right', 'Vị trí hiển thị là dạng số và lớn hơn 0!');
                                return check = false;
                            }
                            if (check) {
                                swal({
                                    title: 'Thêm mới danh mục',
                                    text: "Bạn có muốn thêm mới danh mục với thông tin như trên không ?",
                                    type: 'question',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Vâng, tôi đồng ý !',
                                    cancelButtonText: 'Không. cảm ơn!'
                                }).then(function () {
                                    var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                                    inst.create_node(obj, { icon: 'fa fa-plus-square-o' }, "last", function (new_node) {
                                        new_node.text = $('#tendanhmuc').val();
                                    });
                                    $menuthumuc.jstree(true).refresh();
                                }, function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal(
                                          'Hủy bỏ ',
                                          'Lệnh thêm mới đã bị hủy bỏ ',
                                          'info'
                                        )
                                    }
                                });
                            }
                            $('#btnHuy').click();
                        });
                    }
                };

                if (_nodeGoc == '#') {
                    arrMenu.paste = {
                        label: 'Dán',
                        icon: 'fa fa-clipboard',
                        action: function (b) {
                            var c = $.jstree.reference(b.reference), d = c.get_node(b.reference); c.paste(d)
                        },
                        _disabled: function () {
                            return (node_cut == undefined);
                        }
                    };
                }
                else {
                    arrMenu.edit = {
                        label: 'Sửa',
                        icon: 'fa fa-pencil-square-o',
                        action: function (obj) {
                            $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadthongtindanhmuctheoID', idDanhmucSel: idDanhmucSel }, function (kq) {
                                $('#tendanhmuc').val(kq.thongtin.tendanhmuc);
                                $('#sothutu').val(kq.thongtin.sothutu);
                            });
                            $('#ModalFolder').modal('show');
                            $('#tieudeModel').html('Chỉnh sửa thông tin danh mục');

                            $('#btnok').click(function () {
                                var check = true;
                                var tendanhmuc = $('#tendanhmuc').val();
                                var sothutu = $('#sothutu').val();
                                if (tendanhmuc.length < 1) {
                                    common.showNotification('top', 'right', 'Mời bạn nhập tên cho danh mục !');
                                    return check = false;
                                }
                                if (!($.isNumeric(sothutu))) {
                                    common.showNotification('top', 'right', 'Vị trí hiển thị là dạng số dương !');
                                    return check = false;
                                }
                                if (check) {
                                    swal({
                                        title: 'Cập nhật thông tin',
                                        text: "Bạn có muốn cập nhật thông tin như trên không ?",
                                        type: 'question',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Vâng, tôi đồng ý !',
                                        cancelButtonText: 'Không. cảm ơn!'
                                    }).then(function () {

                                        jsonPost({ type: 'capnhatthongtindanhmuc', idDanhmucSel: idDanhmucSel, tendanhmuc: tendanhmuc, sothutu: sothutu }).then(function (kq) {
                                        //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'capnhatthongtindanhmuc', idDanhmucSel: idDanhmucSel, tendanhmuc: tendanhmuc, sothutu: sothutu }, function (kq) {
                                            if (kq.suscess) {
                                                $menuthumuc.jstree(true).refresh();
                                                swal('Thông báo ', kq.msg, 'success')
                                            } else {
                                                swal('Thông báo ', kq.msg, 'error')
                                            }
                                        });
                                    }, function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal(
                                              'Hủy bỏ ',
                                              'Lệnh cập nhật đã bị hủy bỏ ',
                                              'info'
                                            )
                                        }
                                    });
                                }

                                $('#btnHuy').click();
                            });
                        }
                    };
                    arrMenu.delete = {
                        label: 'Xóa',
                        icon: 'fa fa-trash-o',
                        action: function (b) {
                            var c = $.jstree.reference(b.reference),
                                      d = c.get_node(b.reference);
                            c.is_selected(d) ? c.delete_node(c.get_selected()) : c.delete_node(d)
                        }
                    };

                    arrMenu.subTacvu = {
                        label: 'Tác vụ',
                        icon: 'fa fa-cogs',
                        submenu: {
                            cut: {
                                label: 'Cut',
                                icon: "fa fa-scissors",
                                action: function (b) {
                                    node_cut = b
                                    var c = $.jstree.reference(b.reference),
                                             d = c.get_node(b.reference);
                                    c.is_selected(d) ? c.cut(c.get_top_selected()) : c.cut(d)
                                }
                            },
                            paste: {
                                label: 'Dán',
                                icon: 'fa fa-clipboard',
                                action: function (b) {
                                    var c = $.jstree.reference(b.reference), d = c.get_node(b.reference); c.paste(d)
                                },
                                _disabled: function () {
                                    return (node_cut == undefined);
                                }
                            }
                        }
                    };
                }


                arrMenu.subVitri = {
                    label: 'Vị trí hiển thị',
                    icon: 'fa fa-outdent',
                    submenu: {
                        top: {
                            id: 'menutren',
                            action: function (b) {
                                var tenmenu = b.item.id;
                                swal({
                                    title: 'Thay đổi quyền hiển thị',
                                    text: "Bạn có muốn thay đổi quyền hiển thị của danh mục này không ?",
                                    type: 'question',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Vâng, tôi đồng ý !',
                                    cancelButtonText: 'Không. cảm ơn!'
                                }).then(function () {

                                    jsonPost({ type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }).then(function (kq) {
                                    //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }, function (kq) {

                                        if (kq.suscess) {
                                            swal('Thông báo', kq.msg, 'success')
                                        } else {
                                            swal('Thông báo', kq.msg, 'error')
                                        }
                                        $menuthumuc.jstree(true).refresh();
                                    });
                                }, function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal(
                                          'Hủy bỏ ',
                                          'Lệnh cập nhật đã bị hủy bỏ ',
                                          'info'
                                        )
                                        $menuthumuc.jstree(true).refresh();
                                    }
                                });
                            },
                        },
                        left: {
                            id: 'menutrai',
                            action: function (b) {
                                var tenmenu = b.item.id;
                                swal({
                                    title: 'Thay đổi quyền hiển thị',
                                    text: "Bạn có muốn thay đổi quyền hiển thị của danh mục này không ?",
                                    type: 'question',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Vâng, tôi đồng ý !',
                                    cancelButtonText: 'Không. cảm ơn!'
                                }).then(function () {

                                    jsonPost({ type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }).then(function (kq) {
                                    //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }, function (kq) {

                                        if (kq.suscess) {
                                            swal('Thông báo', kq.msg, 'success')
                                        } else {
                                            swal('Thông báo', kq.msg, 'error')
                                        }
                                        $menuthumuc.jstree(true).refresh();
                                    });
                                }, function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal(
                                          'Hủy bỏ ',
                                          'Lệnh cập nhật đã bị hủy bỏ ',
                                          'info'
                                        )
                                        $menuthumuc.jstree(true).refresh();
                                    }
                                });
                            }
                        },
                        bottom: {
                            id: 'menuduoi',
                            action: function (b) {
                                var tenmenu = b.item.id;
                                swal({
                                    title: 'Thay đổi quyền hiển thị',
                                    text: "Bạn có muốn thay đổi quyền hiển thị của danh mục này không ?",
                                    type: 'question',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Vâng, tôi đồng ý !',
                                    cancelButtonText: 'Không. cảm ơn!'
                                }).then(function () {

                                    jsonPost({ type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }).then(function (kq) {
                                 //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoitrangthaihienthimenu', idDanhmucSel: idDanhmucSel, tenmenu: tenmenu }, function (kq) {

                                        if (kq.suscess) {
                                            swal('Thông báo', kq.msg, 'success')
                                        } else {
                                            swal('Thông báo', kq.msg, 'error')
                                        }
                                        $menuthumuc.jstree(true).refresh();
                                    });
                                }, function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal(
                                          'Hủy bỏ ',
                                          'Lệnh cập nhật đã bị hủy bỏ ',
                                          'info'
                                        )
                                        $menuthumuc.jstree(true).refresh();
                                    }
                                });
                            }
                        }
                    }
                };
                if (node_selected[0].original.menutop == true) {
                    arrMenu.subVitri.submenu.top.icon = 'fa fa-check-square-o';
                    arrMenu.subVitri.submenu.top.label = 'Hiển thị menu trên';
                } else {
                    arrMenu.subVitri.submenu.top.icon = 'fa fa-times';
                    arrMenu.subVitri.submenu.top.label = 'Không hiển thị ở menu trên';
                }
                if (node_selected[0].original.menuleft == true) {
                    arrMenu.subVitri.submenu.left.icon = 'fa fa-check-square-o';
                    arrMenu.subVitri.submenu.left.label = 'Hiển thị menu trái';
                } else {
                    arrMenu.subVitri.submenu.left.icon = 'fa fa-times';
                    arrMenu.subVitri.submenu.left.label = 'Không hiển thị ở menu trái';
                }

                if (node_selected[0].original.menubottom == true) {
                    arrMenu.subVitri.submenu.bottom.icon = 'fa fa-check-square-o';
                    arrMenu.subVitri.submenu.bottom.label = 'Hiển thị menu dưới';
                } else {
                    arrMenu.subVitri.submenu.bottom.icon = 'fa fa-times';
                    arrMenu.subVitri.submenu.bottom.label = 'Không hiển thị ở menu dưới';
                }
                return arrMenu;
            }
        },
        'plugins': ['state', 'dnd', 'types', 'contextmenu', 'unique'],
    }).bind('select_node.jstree', function (e, data) {
        var _idthumuc = "";
        var node_selected = $('#dragTree').jstree('get_selected', true);
        var idPar = node_selected[0].parent;
        var idMe = node_selected[0].id;
        idDanhmucSel = node_selected[0].id;
        SoChaDanhMuc = data.node.parents.length - 1;
    })

        .on('create_node.jstree', function (e, data) {
            var _idcha = data.parent;
            var _tencon = data.node.text;
            var _sothutu = $('#sothutu').val();

            jsonPost({ type: 'themmoidanhmuctrongmenu', SoChaDanhMuc: SoChaDanhMuc, _idcha: _idcha, _tencon: _tencon, _sothutu: _sothutu }).then(function (kq) {
            //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoidanhmuctrongmenu', SoChaDanhMuc: SoChaDanhMuc, _idcha: _idcha, _tencon: _tencon, _sothutu: _sothutu }, function (kq) {
                if (kq.suscess) {
                    idtrunggian = kq.idDanhmuc;
                    swal('Thông báo', kq.msg, 'success')
                } else {
                    data.instance.refresh();
                    swal('Thông báo', kq.msg, 'error')
                }
            });
        })
        .on('rename_node.jstree', function (e, data) {
            var _idthumuc = "";
            var _tenmoi = data.text;
            if (idtrunggian == "") {
                _idthumuc = data.node.id;
            } else {
                _idthumuc = idtrunggian;
            }
            swal({
                title: 'Đổi tên thư mục ?',
                text: "Bạn sẽ dùng tên mới này cho thư mục ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {

                jsonPost({ type: 'doitendanhmuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'doitendanhmuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }, function (kq) {
                    if (kq.suscess) {
                        idtrunggian = "";
                    }
                    $menuthumuc.jstree(true).refresh();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                    $menuthumuc.jstree(true).refresh();
                }
            });
        })
        .on('delete_node.jstree', function (e, data) {
            var _idnode = data.node.id;

            swal({
                title: 'Xóa danh mục',
                text: "Bạn có muốn xóa danh mục này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {

                jsonPost({ type: 'xoadanhmuc', _idnode: _idnode }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoadanhmuc', _idnode: _idnode }, function (kq) {
                    if (kq.suscess) {
                        swal('Thông báo', kq.msg, 'success')
                    } else {
                        swal('Thông báo', kq.msg, 'error')
                    }
                    $menuthumuc.jstree(true).refresh();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                    $menuthumuc.jstree(true).refresh();
                }
            });

        })
        .on('move_node.jstree', function (e, data) {
            var _idthumuc = data.node.id;
            var _idparent = data.parent;

            swal({
                title: 'Di chuyển danh mục',
                text: "Bạn có chắc sẽ di chuyển đến danh mục này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {

                jsonPost({ type: 'dichuyendanhmuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'dichuyendanhmuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                    if (kq.suscess) {
                        node_cut = undefined;
                        swal('Thông báo', kq.msg, 'success')
                    } else {
                        swal('Thông báo', kq.msg, 'error')
                    }
                    $menuthumuc.jstree(true).refresh();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                    $menuthumuc.jstree(true).refresh();
                }
            });
        })
        .on('changed.jstree', function (e, data) {
            if (data && data.selected && data.selected.length) {
                $.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
                    if (d && typeof d.type !== 'undefined') {
                        $('#data .content').hide();
                        switch (d.type) {
                            case 'text':
                            case 'txt':
                            case 'md':
                            case 'htaccess':
                            case 'log':
                            case 'sql':
                            case 'php':
                            case 'js':
                            case 'json':
                            case 'css':
                            case 'html':
                                $('#data .code').show();
                                $('#code').val(d.content);
                                break;
                            case 'png':
                            case 'jpg':
                            case 'jpeg':
                            case 'bmp':
                            case 'gif':
                                $('#data .image img').one('load', function () { $(this).css({ 'marginTop': '-' + $(this).height() / 2 + 'px', 'marginLeft': '-' + $(this).width() / 2 + 'px' }); }).attr('src', d.content);
                                $('#data .image').show();
                                break;
                            default:
                                $('#titleFolder').html(d.content).show();
                                break;
                        }
                    }
                });
            }
            else {
                $('#titleFolder').hide();
                $('#titleFolder').html('Select a file from the tree.').show();
            }
        });

}

// THAY ĐỔI THÔNG TIN CÁ NHÂN -xong
function initThongtincanhan() {
    curentPage = 0;
    loadimage();

    $('#chosefileAvartarAdmin').click(function () {
        idClick = "";
        idClick = $(this).context.id;
        window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
    });

    loadthongtincanhanadmin();
    updatethongincanhanadmin();
}
function loadthongtincanhanadmin() {
    $('.loader-parent').removeAttr('style');
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadthongtincanhanadmin' }, function (thongtinadmin) {
        if (thongtinadmin.success) {
            $('#taikhoan').val(thongtinadmin.thongtincanhan.taikhoan1);
            $('#tendaydu').val(thongtinadmin.thongtincanhan.tendaydu);
            $('#diachiemail').val(thongtinadmin.thongtincanhan.email);
            $('#sodienthoai').val(thongtinadmin.thongtincanhan.sodienthoai);
            $('#idtaikhoanadmin').text(thongtinadmin.thongtincanhan.id_taikhoan);
            $('#lblAvatarAdmin').text(thongtinadmin.thongtincanhan.avatar);
            $('#prevAvatarAdmin').html("<img src='" + thongtinadmin.thongtincanhan.avatar + "' width='200px' height='100px' />")



            if ((thongtinadmin.thongtincanhan.tennhomadmin == null || thongtinadmin.thongtincanhan.tennhomadmin == "") && (thongtinadmin.thongtincanhan.loaitaikhoan == 2)) {
                $('#id_nhomadmin').html("Không có nhóm quản lý");
            } else if ((thongtinadmin.thongtincanhan.tennhomadmin == null || thongtinadmin.thongtincanhan.tennhomadmin == "") && (thongtinadmin.thongtincanhan.loaitaikhoan == 3 || thongtinadmin.thongtincanhan.loaitaikhoan == 4)) {
                $('#id_nhomadmin').html("Quản lý toàn bộ website");
            }
            else {
                $('#id_nhomadmin').html(thongtinadmin.thongtincanhan.tennhomadmin);
            }
            $('#lidoimatkhau').click(function () {
                var id_taikhoan = thongtinadmin.thongtincanhan.id_taikhoan;
                $('#lidanhsach').removeClass('active');
                $('#thongtincanhan').removeClass('active');

                $('#lidoimatkhau').addClass('active');
                $('#doimatkhaucanhan').addClass('active');

                doimatkhaucanhan(id_taikhoan);
            });

        } else {
            window.location.href = window.location.origin + "/admin";
        }
        $('.loader-parent').css('display', 'none');
    });
}

function updatethongincanhanadmin() {
    $('#btnUpdate').unbind();
    $('#btnUpdate').click(function () {
        var id_taikhoan = $('#idtaikhoanadmin').text();
        var tendangnhap = $('#taikhoan').val();
        var tendaydu = $('#tendaydu').val();
        var email = $('#diachiemail').val();
        var sodienthoai = $('#sodienthoai').val();
        var avatar = $('#lblAvatarAdmin').text();
        var check = true;


        if (!validateTaikhoan(tendangnhap)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Tên tài khoản lớn hơn 6 ký tự và không chứa ký tự đặc biệt');
        } else if (!validateHoTen(tendaydu)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời nhận họ tên đầy đủ');
        } else if (!isEmail(email)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Nhập email sai');
        } else if (!validatePhone(sodienthoai)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Nhập số điện thoại sai');
        }
        var thongtin = { id_taikhoan: id_taikhoan, tendangnhap: tendangnhap, tendaydu: tendaydu, email: email, sodienthoai: sodienthoai, avatar: avatar }

        var fd_data = new FormData();
        fd_data.append('type', 'capnhatthongtincanhanadmin');
        fd_data.append('thongtin', JSON.stringify(thongtin));
        fd_data.append("stringTookenClient", stringTookenServer);

        if (check == true) {
            $('#btnUpdate').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có muốn cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess == true) {
                            $('#avatarAD').empty();
                            $('#avatarAD').append('<img src="' + data.avatarResponse + '" class="img-circle">');

                            swal('Thông báo ', data.msg, 'success')
                            //    window.location.href = window.location.origin + "/trang-chu-admin";

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnUpdate').removeAttr('disabled');
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('#btnUpdate').removeAttr('disabled');
                $('.loader-parent').css('display', 'none');
            });
        }
    });
}
function doimatkhaucanhan(id_taikhoan) {
    $('#btnChange').unbind();
    $('#btnChange').click(function () {
        var matkhaucu = $('#mkcu').val();
        var matkhau = $('#mkmoi').val();
        var matkhau2 = $('#mkmoi2').val();
        var email = $('#emailhethong').val();
        var check = true;

        if (matkhaucu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập mật khẩu đang sử dụng !');
            return check = false;
        }
        else if (!validateAcountAdmin(matkhau)) {
            common.showNotification('top', 'right', 'Mật khẩu phải chứa ký tự đặc biệt, chữ in hoa và lớn hơn 10 ký tự !');
            return check = false;
        }
        else if (matkhau2 != matkhau) {
            common.showNotification('top', 'right', 'Nhập lại mật khẩu không chính xác !');
            return check = false;
        }
        else if (!isEmail(email)) {
            common.showNotification('top', 'right', 'Nhập email không chính xác !');
            return check = false;
        }

        if (check) {
            $('#btnChange').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có muốn cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'thaydoimatkhaucanhan', matkhaucu: matkhaucu, matkhau: matkhau, matkhau2: matkhau2, email: email }).then(function (thongtinadmin) {
               // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoimatkhaucanhan', matkhaucu: matkhaucu, matkhau: matkhau, matkhau2: matkhau2, email: email }, function (thongtinadmin) {
                    if (thongtinadmin.sucess == true) {
                        $('#mkcu').val('');
                        $('#mkmoi').val('');
                        $('#mkmoi2').val('');
                        $('#emailhethong').val('');
                        swal('Thông báo ', thongtinadmin.msg, 'success')
                    } else {
                        swal('Thông báo ', thongtinadmin.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('#btnChange').removeAttr('disabled');
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnChange').removeAttr('disabled');
            });
        }
    });
}

// QUẢN LÝ QUẢNG CÁO -xong
function initQuangCao() {
    curentPage = 0;
    loadimage();
    loadvitridatquangcao();
    loaddanhsachquangcao();
    $('#lidanhsachdangchay').click(function () {

        $('#lidanhsachdangchay').addClass('active');
        $('#lithemmoi').css('display', 'block');
        $('#lithemmoi').removeClass('active');
        $('#liupdate').removeClass('active');
        $('#liupdate').css('display', 'none');
        $('#danhsachquangcaodangchay').addClass('active');
        $('#themmoiquangcao').removeClass('active');

        $('#anhdaidien').val('');
        $('#preview').empty();
        $('#name').text('');
        $('#size').text('');
        $('#type').text('');
        $('#kicthuoc').text('');
        $('#width').text('');
        $('#height').text('');

        $('#linkquangcao').val('');
        $('#tenquangcao').val('');
        $('#donvidat').val('');
        $('#thongtin').val('');
        $('#tilexuathien').val('');
        $('#vitri').val('khong');
        $('#uutienhienthi').val('');
        $('#fullDateStart').val('');
        $('#fullDateEnd').val('');
        $('#fromDiemDat').css('display', 'none');
        $('#ngaybatdau').css('display', 'none');

        $('input:radio[value=luunhap]').prop('checked', true);
    });

    $('#lithemmoi').click(function () {
        $('#frmbutton').empty();
        $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnUploadFile"><i class="fa fa-plus iconButtonPage"></i>Thêm quảng cáo</button>');
        themmoiquangcao();
    });

}

function loadvitridatquangcao() {
    $('#vitri').change(function () {
        var vitrihienthi = $(this).context.value;
        if (vitrihienthi != "khong") {
            $('#fromDiemDat').css('display', 'block');
            $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadvitridatquangcao', key: vitrihienthi }, function (data) {
                $('#diemdattrongtrang').empty();
                $.each(data.data, function (i, v) {
                    $('#diemdattrongtrang').append('<option value="' + v.name + '">' + v.name + " - " + v.mota + '</option>');
                });
            });
        } else {
            $('#fromDiemDat').css('display', 'none');
        }
    });

    $('input:radio[name=optionsRadios]').change(function () {
        var trangthai = $(this).context.value;
        if (trangthai == "luunhap") {
            $('#toanthoigian').css('display', 'none');
        }
        else if (trangthai == "hienthi") {
            $('#toanthoigian').css('display', 'block');
            $('#ngaybatdau').css('display', 'none');
        }
        else {
            $('#ngaybatdau').css('display', 'block');
            $('#toanthoigian').css('display', 'block');
        }
    });
}
function themmoiquangcao() {
    var width, height, size;
    $('#anhdaidien').change(function () {
        width = 0, height = 0, size = 0;
        size = this.files[0].size;
        var _URL = window.URL || window.webkitURL;
        var file, img;
        if ((file = this.files[0])) {
            img = new Image();
            img.onload = function () {
                width = this.width;
                height = this.height;
                $('#width').text("Chiều rộng  : " + this.width + "px");
                $('#height').text("Chiều cao  : " + this.height + "px");
            };
            img.src = _URL.createObjectURL(file);
        }
    });

    $('#btnUploadFile').click(function () {

        var check = true;
        var dungluong = 1024 * 1024 * 10;
        var tenquangcao = $('#tenquangcao').val();
        var donvidat = $('#donvidat').val();
        var thongtin = $('#thongtin').val();
        var tilexuathien = $('#uutienhienthi').val();

        var vitri = $('#vitri').val();
        var diemdattrongtrang = $('#diemdattrongtrang').val();

        var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();
        var filequangcao = $('#anhdaidien').val();
        var linkquangcao = $('#linkquangcao').val();


        if (trangthaihienthi == "hienthi") {
            var ngaydung = $('#fullDateEnd').val();
        } else if (trangthaihienthi == "hengio") {
            var ngaydang = $('#fullDateStart').val();
            var ngaydung = $('#fullDateEnd').val();
        }
        if (filequangcao == "") {
            common.showNotification('top', 'right', 'Bạn chưa chọn file quảng cáo !');
            return check == false;
        }
        else if (vitri == "C" && (width > 730 || height > 150)) {
            common.showNotification('top', 'right', 'Chiều rộng < 730px & Chiều cao < 150px !');
            return check == false;
        }
        else if (vitri == "B" && (width > 1100 || height > 150)) {
            common.showNotification('top', 'right', 'Chiều rộng < 1100px & Chiều cao < 150px  !');
            return check == false;
        }
        else if (vitri == "R" && width > 318) {
            common.showNotification('top', 'right', 'Chiều rộng < 318px & Chiều cao auto !');
            return check == false;
        }
        else if (vitri == "L" && width > 252) {
            common.showNotification('top', 'right', 'Chiều rộng < 252px & Chiều cao auto !');
            return check == false;
        }
        else if (size > dungluong) {
            common.showNotification('top', 'right', 'File upload chỉ được < 10Mb');
            return check == false;
        }
        else if (!validateURL(linkquangcao)) {
            common.showNotification('top', 'right', 'Link quảng cáo không đúng định dạng !');
            return check == false;
        }
        else if (!valTextboxValue(tenquangcao)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên quảng cáo và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(donvidat)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên đơn vị đặt quảng cáo và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(thongtin)) {
            common.showNotification('top', 'right', 'Mời bạn nhập thông tin và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!$.isNumeric(tilexuathien)) {
            common.showNotification('top', 'right', 'Nhập ưu tiên dạng số và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (vitri == "khong") {
            common.showNotification('top', 'right', 'Mời bạn chọn vị trí hiển thị cho quảng cáo !');
            return check == false;
        }
        else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc quảng cáo !');
            return check == false;
        }
        else if (trangthaihienthi == "hienthi" && ngaydung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc quảng cáo !');
            return check == false;
        }
        else {
            var thongtinqc = {
                tenquangcao: tenquangcao,
                donvidat: donvidat,
                thongtin: thongtin,
                linkquangcao: linkquangcao,
                tilexuathien: tilexuathien,
                diemdattrongtrang: diemdattrongtrang,
                trangthaihienthi: trangthaihienthi,
                ngaydang: ngaydang,
                ngaydung: ngaydung
            };

            var fd_data = new FormData();
            fd_data.append('thongtinqc', JSON.stringify(thongtinqc));
            fd_data.append('fileanh', $('#anhdaidien')[0].files[0]);
            fd_data.append('type', 'themmoiquangcao');
            fd_data.append("stringTookenClient", stringTookenServer);


            var table = $('#tb_danhsachquangcaodangchay').DataTable();
            $('#btnUploadFile').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.suscess) {
                            swal('Thông báo ', data.msg, 'success')

                            $('#anhdaidien').val('');
                            $('#preview').empty();
                            $('#name').text('');
                            $('#size').text('');
                            $('#type').text('');
                            $('#kicthuoc').text('');
                            $('#width').text('');
                            $('#height').text('');

                            $('#linkquangcao').val('');
                            $('#tenquangcao').val('');
                            $('#donvidat').val('');
                            $('#thongtin').val('');
                            $('#tilexuathien').val('');
                            $('#vitri').val('khong');
                            $('#uutienhienthi').val('');
                            $('#fullDateStart').val('');
                            $('#fullDateEnd').val('');
                            $('#fromDiemDat').css('display', 'none');
                            $('#ngaybatdau').css('display', 'none');

                            $('input:radio[value=luunhap]').prop('checked', true);
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        table.ajax.reload();
                        $('#btnUploadFile').removeAttr('disabled');
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUploadFile').removeAttr('disabled');
            });
        }

    });
}

function loaddanhsachquangcao() {
    var $card_content = $('#danhsachquangcaodangchay');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachquangcaodangchay',
            html: '<thead>\
                            <th>Tên quảng cáo</th>\
                            <th>Đơn vị đặt</th>\
                            <th>Trạng thái</th>\
                            <th>Vị trí</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachquangcaodangchay').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachquangcao',
            "columns": [
                   { data: "tenquangcao" },
                   { data: "donvidat" },
                   { data: "trangthai" },
                   { data: "mota" },
                  {
                      data: "button", "width": "80px",
                      mRender: function (data) {
                          var $dtooltip = $('<div/>', {
                              html: '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa quảng cáo"></i>\
                                     <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa quảng cáo"></i>'
                          });
                          return $dtooltip.html();
                      }
                  },
            ],
            "bSort": false,
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachquangcaodangchay').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachquangcaodangchay').DataTable();

        table.on('click', 'i.btnUpdate', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var idquangcao = data.id_quangcao;
            var width, height, size;
            $('#frmbutton').empty();
            $('#frmbutton').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnUpdateQC"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#lidanhsachdangchay').removeClass('active');
            $('#lithemmoi').css('display', 'none');

            $('#liupdate').css('display', 'block');
            $('#liupdate').addClass('active');

            $('#danhsachquangcaodangchay').removeClass('active');
            $('#themmoiquangcao').addClass('active');

            $('#preview').html("<img src='" + data.manguon + "' width='300px' height='150px' />");

            $('#preview img').load(function () {
                width = this.naturalWidth;
                height = this.naturalHeight;

                var obj = new XMLHttpRequest();
                obj.open('HEAD', data.manguon, true);
                obj.onreadystatechange = function () {
                    if (obj.readyState == 4) {
                        if (obj.status == 200) {
                            size = obj.getResponseHeader('Content-Length');
                        } else {
                            alert('ERROR');
                        }
                    }
                };
                obj.send(null);
            });

            $('#tenquangcao').val(data.tenquangcao);
            $('#donvidat').val(data.donvidat);
            $('#thongtin').val(data.thongtin);
            $('#uutienhienthi').val(data.tilexuathien);

            $('#vitri').val(data.type);
            $('#fromDiemDat').css('display', 'block');

            $('#diemdattrongtrang').empty();
            $.each(data.list, function (i, v) {
                $('#diemdattrongtrang').append('<option value="' + v.name + '">' + v.name + " - " + v.mota + '</option>');
                $('#diemdattrongtrang').val(data.name);
            });

            $('#linkquangcao').val(data.linkquangcao);
            if (data.trangthaihienthi == 1) {
                $("input[name=optionsRadios][value='luunhap']").prop('checked', true);
            } else if (data.trangthaihienthi == 2) {
                $('#toanthoigian').css('display', 'block');
                $("input[name=optionsRadios][value='hienthi']").prop('checked', true);
                $('#fullDateStart').val(data.ngaydang);
                $('#fullDateEnd').val(data.ngaydung);
            }

            $('#anhdaidien').change(function () {
                width = 0, height = 0, size = 0;
                size = this.files[0].size;
                var _URL = window.URL || window.webkitURL;
                var file, img;
                if ((file = this.files[0])) {
                    img = new Image();
                    img.onload = function () {
                        width = this.width;
                        height = this.height;
                        $('#width').text("Chiều rộng  : " + this.width + "px");
                        $('#height').text("Chiều dài  : " + this.height + "px");
                    };
                    img.src = _URL.createObjectURL(file);
                }
            });


            $('#btnUpdateQC').click(function () {
                updatethongtinquangcao(width, height, size, data.manguon, data.id_quangcao);
            });

        });

        table.on('click', 'i.btnDelete', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var idquangcao = data.id_quangcao;
            swal({
                title: 'Xóa quảng cáo',
                text: "Bạn có muốn xóa quảng cáo này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoaquangcao', idquangcao: idquangcao }).then(function (kq) {
               // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoaquangcao', idquangcao: idquangcao }, function (kq) {
                    if (kq.sucess) {
                        swal('Thông báo ', kq.msg, 'success')
                        table.ajax.reload();
                    }
                    else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                });

            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
            });
        });
    }
}

function updatethongtinquangcao(width, height, size, src, id_quangcao) {

    var check = true;
    var dungluong = 1024 * 1024 * 10;
    var tenquangcao = $('#tenquangcao').val();
    var donvidat = $('#donvidat').val();
    var thongtin = $('#thongtin').val();
    var tilexuathien = $('#uutienhienthi').val();

    var vitri = $('#vitri').val();
    var diemdattrongtrang = $('#diemdattrongtrang').val();

    var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();
    var filequangcao = $('#anhdaidien').val();
    var linkquangcao = $('#linkquangcao').val();
    if (filequangcao == "") {
        filequangcao = src;
    }

    if (trangthaihienthi == "hienthi") {
        var ngaydung = $('#fullDateEnd').val();
    } else if (trangthaihienthi == "hengio") {
        var ngaydang = $('#fullDateStart').val();
        var ngaydung = $('#fullDateEnd').val();
    }
    if (filequangcao == "") {
        common.showNotification('top', 'right', 'Bạn chưa chọn file quảng cáo !');
        return check == false;
    }
    else if (vitri == "C" && (width > 730 || height > 150)) {
        common.showNotification('top', 'right', 'Chiều rộng < 730px & Chiều cao < 150px !');
        return check == false;
    }
    else if (vitri == "B" && (width > 1100 || height > 150)) {
        common.showNotification('top', 'right', 'Chiều rộng < 1100px & Chiều cao < 150px  !');
        return check == false;
    }
    else if (vitri == "R" && width > 318) {
        common.showNotification('top', 'right', 'Chiều rộng < 318px & Chiều cao auto !');
        return check == false;
    }
    else if (vitri == "L" && width > 252) {
        common.showNotification('top', 'right', 'Chiều rộng < 252px & Chiều cao auto !');
        return check == false;
    }
    else if (size > dungluong) {
        common.showNotification('top', 'right', 'File upload chỉ được < 10Mb');
        return check == false;
    }
    else if (!validateURL(linkquangcao)) {
        common.showNotification('top', 'right', 'Link quảng cáo không đúng định dạng !');
        return check == false;
    }
    else if (!valTextboxValue(tenquangcao)) {
        common.showNotification('top', 'right', 'Mời bạn nhập tên quảng cáo và không chứa ký tự đặc biệt !');
        return check == false;
    }
    else if (!valTextboxValue(donvidat)) {
        common.showNotification('top', 'right', 'Mời bạn nhập tên đơn vị đặt quảng cáo và không chứa ký tự đặc biệt !');
        return check == false;
    }
    else if (!valTextboxValue(thongtin)) {
        common.showNotification('top', 'right', 'Mời bạn nhập thông tin và không chứa ký tự đặc biệt !');
        return check == false;
    }
    else if (!$.isNumeric(tilexuathien)) {
        common.showNotification('top', 'right', 'Nhập ưu tiên dạng số và không chứa ký tự đặc biệt !');
        return check == false;
    }
    else if (vitri == "khong") {
        common.showNotification('top', 'right', 'Mời bạn chọn vị trí hiển thị cho quảng cáo !');
        return check == false;
    }
    else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc quảng cáo !');
        return check == false;
    }
    else if (trangthaihienthi == "hienthi" && ngaydung == "") {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc quảng cáo !');
        return check == false;
    }
    else {
        var thongtinqc = {
            id_quangcao: id_quangcao,
            tenquangcao: tenquangcao,
            donvidat: donvidat,
            thongtin: thongtin,
            linkquangcao: linkquangcao,
            tilexuathien: tilexuathien,
            diemdattrongtrang: diemdattrongtrang,
            trangthaihienthi: trangthaihienthi,
            ngaydang: ngaydang,
            ngaydung: ngaydung,
            filequangcao: filequangcao
        };

        var fd_data = new FormData();
        fd_data.append('thongtinqc', JSON.stringify(thongtinqc));
        fd_data.append('fileanh', $('#anhdaidien')[0].files[0]);
        fd_data.append('type', 'updatethongtinquangcao');
        fd_data.append("stringTookenClient", stringTookenServer);


        var table = $('#tb_danhsachquangcaodangchay').DataTable();
        $('#btnUpdateQC').attr('disabled', 'true');
        swal({
            title: 'Cập nhật thông tin',
            text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.suscess) {
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    table.ajax.reload();
                    $('#btnUpdateQC').removeAttr('disabled');
                }
            });
        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh cập nhật đã bị hủy bỏ ',
                  'info'
                )
            }
            $('.loader-parent').css('display', 'none');
            $('#btnUpdateQC').removeAttr('disabled');
        });

    }
}


//QUẢN LÝ LỊCH HIỂN THỊ BANNER-xong

function initLichHienThiBanner() {
    curentPage = 0;
    hienthidanhsachBannertheothumucVaChuKyHienThi();
}

function hienthidanhsachBannertheothumucVaChuKyHienThi() {

    var $card_content = $('#danhsachbanner');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbanner',
            html: '<thead>\
                            <th>Tên banner</th>\
                            <th>Vị trí</th>\
                            <th>Hình ảnh</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbanner').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachBannertrongthumuc',
            "columns": [
                  { data: "tenbanner" },
                  { data: "vitri" },
                  {
                      data: "duongdanfile",
                      render: function (url, type, full) {
                          return '<img style="height:80px; max-width:300px" src="' + url + '"/>';
                      }
                  },
                   {
                       data: "button", "width": "110px",
                       mRender: function (data) {
                           var $dtooltip = $('<div/>', {
                               html: '<i class="fa fa-pencil-square-o iconButton btnDanhsach" aria-hidden="true" rel="tooltip" title="Danh sách lịch hiển thị"></i>'
                           });
                           return $dtooltip.html();
                       }
                   },
            ],
            "pagingType": "full_numbers",
            "order": [[0, 'asc']],
            "bSort": false,
        });
        var parent11 = $('#tb_danhsachbanner').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbanner').DataTable();
        table.on('click', 'i.btnDanhsach', function () {
            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var _idBanner = data.id_quanlybanner;
            $('#lidanhsach').removeClass('active');
            $('#danhsachbanner').removeClass('active');
            $('#ulmenu').append('<li class="active" id="lichukyhienthi"><a href="#danhsachchukyhienthicuabanner" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Chu kỳ hiển thị của banner</a></li>');
            $('#danhsachchukyhienthicuabanner').addClass('active');

            //load
            var danhsach = $('#danhsachchukyhienthicuabanner');
            danhsach.empty();
            $table = $('<table />', {
                class: 'table table-bordered table-hover',
                id: 'tb_danhsachchuky',
                html: '<thead>\
                            <th>Thời gian</th>\
                            <th>Mức ưu tiên</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
            }).appendTo(danhsach);

            $('#tb_danhsachchuky').DataTable({
                data: data.thongtinhienthi,
                "columns": [
                      { data: "thoigianhienthi" },
                      { data: "mucdouutien" },
                       {
                           data: "id_chitietchukyhienthi", "width": "110px",
                           mRender: function (data) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-trash-o iconButton btnDellCal" aria-hidden="true" rel="tooltip" title="Xóa lịch hiển thị"></i>'
                               });
                               return $dtooltip.html();
                           }
                       },
                ],
                "pagingType": "full_numbers",
                "order": [[0, 'asc']],
                "bSort": false,
            });
            var parent112222 = $('#tb_danhsachchuky').parent().addClass('box-body table-responsive no-padding');
            var table2 = $('#tb_danhsachchuky').DataTable();
            table2.on('click', 'i.btnDellCal', function () {

                var closestRow2 = $(this).closest('tr');
                var data = table2.row(closestRow2).data();
                var idCal = data.id_chitietchukyhienthi;

                swal({
                    title: 'Xóa lịch ',
                    text: "Bạn có muốn xóa lịch hiển thị này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    $('.loader-parent').removeAttr('style');

                    jsonPost({ type: 'xoalichhienthibanner', idCal: idCal }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoalichhienthibanner', idCal: idCal }, function (kq) {
                        if (kq.sucess) {
                            swal('Thông báo ', kq.msg, 'success')
                        }
                        else {
                            swal('Thông báo ', kq.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        var table3 = $('#tb_danhsachbanner').DataTable();
                        var tableHienthi = $('#tb_danhsachchuky').DataTable();
                        table3.ajax.reload(function (json) {
                            var itemcha = json.data.filterObjects('id_quanlybanner', _idBanner);
                            if (itemcha.length > 0) {
                                tableHienthi.clear().draw();
                                tableHienthi.rows.add(itemcha[0].thongtinhienthi).draw()
                            }
                        });
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                    }
                    $('.loader-parent').css('display', 'none');
                });

            });

            $('#tb_danhsachchuky_length label').remove();
            $('#tb_danhsachchuky_length').append('<button type="button" id="btnthemmoilich" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm mới lịch</button>');

            $('#btnthemmoilich').click(function () {
                $('#btnok').remove();
                $('#modelCal_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');
                $('#ModalLichHienthi').on('show.bs.modal', function (event) {
                    $('#titleModal').html("Thêm mới lịch hiển thị cho banner");
                });

                $('input:radio[name=optionsRadios]').change(function () {
                    var trangthai = $(this).context.value;
                    if (trangthai == "hengio") {
                        $('#ngaybatdau').css('display', 'block');
                        $('#ngayketthucc').css('display', 'block');
                        $('#toanthoigian').css('display', 'block');
                    }
                    else if (trangthai == "hienthi") {
                        $('#toanthoigian').css('display', 'block');
                        $('#ngaybatdau').css('display', 'none');
                        $('#ngayketthucc').css('display', 'block');
                    }
                });

                setTimeout(function () {
                    $('#ModalLichHienthi').modal('show');
                    $('#btnok').click(function () {
                        themmoilichhienthi(_idBanner);
                    });
                }, 230);
            });
        });
        $('#lidanhsach').click(function () {
            $('#lidanhsach').addClass('active');
            $('#danhsachbanner').addClass('active');

            $('#lichukyhienthi').remove();
            $('#danhsachchukyhienthicuabanner').removeClass('active');
        });
    }
}
function themmoilichhienthi(_idBanner) {

    var check = true;
    var _Uutien = $('#uutienhienthi').val();
    var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();
    if (trangthaihienthi == "hienthi") {
        var ngaydung = $('#fullDateEnd').val();
    } else if (trangthaihienthi == "hengio") {
        var ngaydang = $('#fullDateStart').val();
        var ngaydung = $('#fullDateEnd').val();
    }
    if (!$.isNumeric(_Uutien) || _Uutien < 0) {
        check = false;
        $loading.remove();
        common.showNotification('top', 'right', 'Ưu tiên hiển thị phải là dạng số dương');
    } else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc banner !');
        return check == false;
    }
    else if (trangthaihienthi == "hienthi" && ngaydung == "") {
        common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc banner !');
        return check == false;
    }

    var thongtinbaner = {
        _idBanner: _idBanner,
        ngaydang: ngaydang,
        ngaydung: ngaydung,
        trangthaihienthi: trangthaihienthi,
        _Uutien: _Uutien
    }

    var fd_data = new FormData();
    fd_data.append('type', 'themmoilichhienthichobanner');
    fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
    fd_data.append("stringTookenClient", stringTookenServer);

    if (check) {

        $('#btnok').attr('disabled', 'true');
        swal({
            title: 'Thêm mới thông tin',
            text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess == true) {
                        $('#uutienhienthi').val('');
                        $('#fullDateEnd').val('');
                        $('#fullDateStart').val('');
                        $('#btnCances').click();
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    var table = $('#tb_danhsachbanner').DataTable();
                    var tableHienthi = $('#tb_danhsachchuky').DataTable();
                    table.ajax.reload(function (json) {
                        var itemcha = json.data.filterObjects('id_quanlybanner', _idBanner);
                        if (itemcha.length > 0) {
                            tableHienthi.clear().draw();
                            tableHienthi.rows.add(itemcha[0].thongtinhienthi).draw()
                        }
                    });

                    $('#btnok').removeAttr('disabled');
                }
            });
        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh thêm mới đã bị hủy bỏ ',
                  'info'
                )
            }
            $('.loader-parent').css('display', 'none');
            $('#btnok').removeAttr('disabled');
        });
    }
}

// GET LINK IMAGES SERVER

function getLinkImages(link) {

    //bai viet
    $('#lbl_anhdaidien').text(link);
    $('#previewavbv').html("<img src='" + link + "' width='200px' height='100px' />")

    //admin
    $('#lblAvatarAdmin').text(link);
    $('#prevAvatarAdmin').html("<img src='" + link + "' width='200px' height='100px' />")

    //banner
    $('#lblLinkBanner').text(link);
    $('#previewbanner').html("<img src='" + link + "'style='max-width:300px; height:100px'/>")


    $('#lblLinkLKHT').text(link);
    $('#previewLKHT').html("<img src='" + link + "' width='200px' height='100px' />")

    $('#lblLinkLKHT1').text(link);
    $('#previewLKHT1').html("<img src='" + link + "' width='200px' height='100px' />")

    $('#lblLinkCanBo').text(link);
    $('#previewCanBo').html("<img src='" + link + "' width='200px' height='100px' />")
    $('#groupFileToiPham').empty();
    $('#groupFileToiPham').append('<label style="display:none">ok</label><img width="100%" style="padding-bottom: 5px;" height="150px" id="' + makeid() + '" src="' + link + '"/>');

    $('#groupFile').append('<div class="help-block col-sm-3"><img width="100%" style="padding-bottom: 5px;" height="100px" id="' + makeid() + '" src="' + link + '"/><i class="fa fa-trash-o iconremove buttonxoa iconButton" aria-hidden="true" rel="tooltip" title="Xóa bỏ ảnh"></i></div>');
    var xoa = $('#groupFile i');
    $.each(xoa, function (key, val) {
        $('#groupFile i').click(function () {

            var a = $(this).prev();
            a.parent().remove();
            $(this).prev().remove();
            $(this).remove();
        });
    });
}

//QUẢN LÝ BANNER -xong
function initBanner() {
    curentPage = 0;
    hienthidanhsachBanner();
    var button = $('#groupChosefile .buttonBanner');
    $.each(button, function (key, val) {
        $(this).click(function () {
            idClick = "";
            idClick = $(this).context.id;
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });

    $('#liaddnew').click(function () {
        $('#previewbanner').html('');
        $('#lblLinkBanner').text('');

        $('#target option').removeAttr('selected');
        $('#vitri option').removeAttr('selected');


        $('#uutienhienthi').val('');
        $('#fullDateStart').val('');
        $('#fullDateEnd').val('');
        $('#ngaybatdau').css('display', 'none');
        $('#ngayketthucc').css('display', 'block');
        $('#tenbanner').val('');
        $('#linkbanner').val('');
        $('input:radio[value=hienthi]').prop('checked', true);
        $('#toanthoigian').css('display', 'block');
        $('#frmtrangthai').css('display', 'block');
        $('#buttonbanneractive').empty();
        $('#buttonbanneractive').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage pull-right" id="btnUploadFile"><i class="fa fa-plus iconButtonPage"></i>Thêm banner</button>');
        themmoibannerclient();
    });

}



function hienthidanhsachBanner() {
    var $card_content = $('#danhsachbanner');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachbanner',
            html: '<thead>\
                            <th>Tên banner</th>\
                            <th>Vị trí</th>\
                            <th>Hình ảnh</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachbanner').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachBannertrongthumuc',
            "columns": [
                  { data: "tenbanner" },
                  { data: "vitri" },
                  {
                      data: "duongdanfile",
                      render: function (url, type, full) {
                          return '<img style="height:80px; max-width:300px" src="' + url + '"/>';
                      }
                  },
                   {
                       data: "button", "width": "110px",
                       mRender: function (data) {
                           if (data.sua == true && data.xoa == true) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-pencil-square-o iconButton btnDetails" rel="tooltip" title="Chi tiết banner"></i>\
                                          <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa banner"></i>'
                               });
                               return $dtooltip.html();
                           }
                           else if (data.xoa == true) {
                               return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa banner"></i>';
                           }
                           else if (data.sua == true) {
                               return data = '<i class="fa fa-pencil-square-o iconButton btnDetails" rel="tooltip" title="Chi tiết banner"></i>';
                           }
                           return data = '';
                       }
                   },
            ],
            initComplete: function (settings, json) {
            },
            "order": [[0, 'asc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachbanner').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachbanner').DataTable();

        table.on('click', 'i.btnDetails', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();

            $('#buttonbanneractive').empty();
            $('#buttonbanneractive').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnUpdatebanner"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>');

            $('#lblLinkBanner').text('');
            $('#previewbanner').html('');

            $('#toanthoigian').css('display', 'none');
            $('#lidanhsach').removeClass('active');
            $('#danhsachbanner').removeClass('active');
            $('#themmoibanner').addClass('active');
            $('#ulmenu').append('<li class="active" id="details"><a href="#themmoibanner" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Sửa thông tin banner</a></li>');

            $('#frmtrangthai').css('display', 'none');
            $('#tenbanner').val(data.tenbanner);
            $('#linkbanner').val(data.linkbanner);
            $('#lblLinkBanner').text(data.duongdanfile);
            $('#previewbanner').html("<img src='" + data.duongdanfile + "'style='max-width:300px; height:100px'/>")

            if (data.vitri == "Banner trên") {
                $('#vitri').val('Banner trên');
            } else {
                $('#vitri').val('Banner dưới');
            }

            if (data.target == "blank") {
                $('#target').val('blank');
            } else if (data.target == "self") {
                $('#target').val('self');
            } else if (data.target == "parent") {
                $('#target').val('parent');
            } else {
                $('#target').val('top');
            }


            $('#liaddnew').click(function () {
                $('#suathongtinbanner').removeClass('active');
                $('#details').remove();
            });
            $('#lidanhsach').click(function () {
                $('#target option').removeAttr('selected');
                $('#vitri option').removeAttr('selected');

                $('#suathongtinbanner').removeClass('active');
                $('#details').remove();
            });

            $('#btnUpdatebanner').click(function () {

                var check = true;

                var duongdanfile = $('#lblLinkBanner').text();
                var tenbanner = $('#tenbanner').val();
                var linkbanner = $('#linkbanner').val();
                var vitri = $('#vitri').val();
                var target = $('#target').val();
                var _idBanner = data.id_quanlybanner;

                var thongtinbaner = {
                    _idBanner: _idBanner,
                    tenbanner: tenbanner,
                    linkbanner: linkbanner,
                    vitri: vitri,
                    target: target,
                    duongdanfile: duongdanfile,
                    type: "banner"
                }
                var fd_data = new FormData();
                fd_data.append('type', 'capnhatthongtinbanner');
                fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
                fd_data.append("stringTookenClient", stringTookenServer);


                if (!valTextboxValue(tenbanner)) {
                    check = false;
                    $loading.remove();
                    common.showNotification('top', 'right', 'Tên banner không chứa ký tự đặc biệt !');
                }
                if (check) {
                    $('#btnUpdatebanner').attr('disabled', 'true');
                    swal({
                        title: 'Cập nhật thông tin banner',
                        text: "Bạn có muốn thay đổi thông tin banner này không ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        $('.loader-parent').removeAttr('style');
                        $.ajax({
                            type: "POST",
                            url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                            data: fd_data,
                            contentType: false,
                            processData: false,
                            success: function (kq) {
                                var data = JSON.parse(kq);
                                if (data.sucess == true) {
                                    var table = $('#tb_danhsachbanner').DataTable();
                                    table.ajax.reload();
                                    swal('Thông báo ', data.msg, 'success')
                                } else {
                                    swal('Thông báo ', data.msg, 'error')
                                }
                                $('.loader-parent').css('display', 'none');
                                $('#btnUpdatebanner').removeAttr('disabled');
                                $('#details').remove();
                                $('#themmoibanner').removeClass('active');
                                $('#lidanhsach').addClass('active');
                                $('#danhsachbanner').addClass('active');
                            }
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh cập nhật đã bị hủy bỏ ',
                              'info'
                            )
                        }
                        $('#btnUpdatebanner').removeAttr('disabled');
                        $('.loader-parent').css('display', 'none');
                    });
                }

            });
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var _idBanner = data.id_quanlybanner;

            $('.btnDelete').attr('disabled', 'true');
            swal({
                title: 'Xóa banner ?',
                text: "Bạn có muốn xóa banner này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoabanner', _idBanner: _idBanner }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoabanner', _idBanner: _idBanner }, function (kq) {
                    if (kq.sucess) {
                        table.ajax.reload();
                        swal('Thông báo ', kq.msg, 'success')
                    }
                    else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('.btnDelete').removeAttr('disabled');
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.btnDelete').removeAttr('disabled');
                $('.loader-parent').css('display', 'none');
            });
        });
    }
}

function themmoibannerclient() {
    $('input:radio[name=optionsRadios]').change(function () {
        var trangthai = $(this).context.value;
        if (trangthai == "hienthi") {
            $('#toanthoigian').css('display', 'block');
            $('#ngaybatdau').css('display', 'none');
            $('#ngayketthucc').css('display', 'block');
        }
        else {
            $('#ngaybatdau').css('display', 'block');
            $('#ngayketthucc').css('display', 'block');
            $('#toanthoigian').css('display', 'block');
        }
    });
    $('#btnUploadFile').click(function () {

        var check = true;
        var duongdanfile = $('#lblLinkBanner').text();
        var tenbanner = $('#tenbanner').val();
        var linkbanner = $('#linkbanner').val();
        var vitri = $('#vitri').val();
        var target = $('#target').val();

        var trangthaihienthi = $("#frmHienthi input[type='radio']:checked").val();

        if (trangthaihienthi == "hienthi") {
            var ngaydung = $('#fullDateEnd').val();
        } else if (trangthaihienthi == "hengio") {
            var ngaydang = $('#fullDateStart').val();
            var ngaydung = $('#fullDateEnd').val();
        }

        if (duongdanfile == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn banner cần upload');
        } else if (tenbanner != "") {
            if (!valTextboxValue(tenbanner)) {
                check = false;
                $loading.remove();
                common.showNotification('top', 'right', 'Tên banner không được chứa ký tự đặc biệt !');
            }
        }
        else if (trangthaihienthi == "hengio" && (ngaydang == "" || ngaydung == "")) {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày bắt đầu và kết thúc banner !');
            return check == false;
        }
        else if (trangthaihienthi == "hienthi" && ngaydung == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày kết thúc banner !');
            return check == false;
        }
        var thongtinbaner = {

            tenbanner: tenbanner,
            linkbanner: linkbanner,
            vitri: vitri,
            target: target,
            duongdanfile: duongdanfile,
            trangthaihienthi: trangthaihienthi,
            ngaydang: ngaydang,
            ngaydung: ngaydung,
            type: "banner"
        }

        var fd_data = new FormData();
        fd_data.append('type', 'themmoibannervaohethong');
        fd_data.append('thongtinbaner', JSON.stringify(thongtinbaner));
        fd_data.append("stringTookenClient", stringTookenServer);

        if (check) {

            $('#btnUploadFile').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess == true) {
                            $('#previewbanner').html('');
                            $('#lblLinkBanner').text('');

                            $('#target option').removeAttr('selected');
                            $('#vitri option').removeAttr('selected');

                            $('#uutienhienthi').val('');
                            $('#fullDateStart').val('');
                            $('#fullDateEnd').val('');
                            $('#fromDiemDat').css('display', 'none');
                            $('#ngaybatdau').css('display', 'none');
                            $('#ngayketthucc').css('display', 'block');
                            $('input:radio[value=hienthi]').prop('checked', true);

                            var table = $('#tb_danhsachbanner').DataTable();
                            table.ajax.reload();
                            swal('Thông báo ', data.msg, 'success')
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#tenbanner').val('');
                        $('#linkbanner').val('');
                        $('#btnUploadFile').removeAttr('disabled');
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnUploadFile').removeAttr('disabled');
            });
        }
    });
}

//QUẢN LÝ NHÓM ADMIN -xong
function initNhomAdmin() {
    curentPage = 0;
    loadall_nhomadmin();
    themmoinhomquanly();
}
function loadallAdminthemmoivaonhom() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadalladminthemvaonhomquanly' }, function (kq) {
        var bodyRadio = $('#chonAdmin');
        bodyRadio.empty();
        $('<div />', {
            class: 'row',
            html: '<div class="checkbox col-md-12" id="danhsachadminchon">\
                        <div class="checkbox col-xs-12" id="chontatca">\
                            <label>\
                                <input id="listAdminchon" type="checkbox">Chọn tất cả\
                            </label>\
                        </div>\
                  </div>'
        }).appendTo(bodyRadio);
        $.each(kq.data, function (key, val) {
            $('#danhsachadminchon').append('<div class="checkbox col-xs-12 col-md-6"> <label><input data-idadmin="' + JSON.stringify(val.id_taikhoan) + '" id="idadmin' + val.id_taikhoan + '" type="checkbox" />' + val.taikhoan1 + "-" + val.tenmenu + ' </label></div>');
        });
        $('#listAdminchon').change(function () {
            if ($(this).prop("checked")) {
                var a = $('#danhsachadminchon').find('input');
                $.each(a, function (key, val) {
                    $(this).prop('checked', true);
                });
            } else {
                var a = $('#danhsachadminchon').find('input');
                $.each(a, function (key, val) {
                    $(this).prop('checked', false);
                });
            }
        });
    });
}
function loadallMenuThemmoinhom() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadallmenuthemmoinhom' }, function (kq) {
        var modalbodytb = $('#chonMenu');
        modalbodytb.empty();
        $('<div />', {
            class: 'row',
            html: '<div class="checkbox col-md-12" id="danhsachmenu">\
                        <div class="checkbox col-xs-12" id="chontatca">\
                            <label>\
                                <input id="listMenuchon" type="checkbox">Chọn tất cả\
                            </label>\
                        </div>\
                  </div>'
        }).appendTo(modalbodytb);
        $.each(kq.data, function (key, val) {
            $('#danhsachmenu').append('<div class="checkbox col-xs-12 col-md-6"> <label><input data-idmenu="' + JSON.stringify(val.id_menu) + '" id="idmenu' + val.id_menu + '" type="checkbox" />' + val.tenmenu + '</label></div>');
        })
        $('#listMenuchon').change(function () {
            if ($(this).prop("checked")) {
                var a = $('#danhsachmenu').find('input');
                $.each(a, function (key, val) {
                    $(this).prop('checked', true);
                });
            } else {
                var a = $('#danhsachmenu').find('input');
                $.each(a, function (key, val) {
                    $(this).prop('checked', false);
                });
            }
        });
    });




}
function themmoinhomquanly() {
    loadallAdminthemmoivaonhom();
    loadallMenuThemmoinhom();


    $('#btnThemmoi').click(function () {
        var check = true;
        var tennhom = $('#tennhom').val();

        var _dsAdmin = new Array();
        var _dscheckAdmin = $('#danhsachadminchon input:checked');

        $.each(_dscheckAdmin, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            if (idArrt != "listAdminchon") { _dsAdmin.push(idadm); }
        });

        var _dsMenu = new Array();
        var _dscheckMenu = $('#danhsachmenu input:checked');
        $.each(_dscheckMenu, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idmenu');
            if (idArrt != "listMenuchon") { _dsMenu.push(idadm); }
        });

        if (!validateHoTen(tennhom)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn nhập tên nhóm và không chứa ký tự đặc biệt');
        }

        if (check) {
            $('#btnThemmoi').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'themmoinhomquanly', tennhom: tennhom, thongtinmenu: JSON.stringify(_dsMenu), thongtinadmin: JSON.stringify(_dsAdmin) }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoinhomquanly', tennhom: tennhom, thongtinmenu: JSON.stringify(_dsMenu), thongtinadmin: JSON.stringify(_dsAdmin) }, function (kq) {
                    if (kq.sucess == true) {
                        var table = $('#tb_danhsachnhomadmin').DataTable();
                        table.ajax.reload();
                        $('#tennhom').val('');
                        swal('Thông báo ', kq.msg, 'success')
                    } else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('#btnThemmoi').removeAttr('disabled');
                    loadallAdminthemmoivaonhom();
                    loadallMenuThemmoinhom();
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoi').removeAttr('disabled');
            });

        }
    });
}


function loadall_nhomadmin() {

    var $card_content = $('#danhsachnhomadmin');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachnhomadmin',
            html: '<thead>\
                            <th>Tên nhóm</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachnhomadmin').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachnhomadmin',
            "columns": [
                  { data: "tennhom" },
                  {
                      data: "button", "width": "120px",
                      mRender: function (data) {
                          if (data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<i class="fa fa-users iconButton btnCTAdmin " aria-hidden="true" rel="tooltip" title="Danh sách admin trong nhóm"></i>\
                                         <i class="fa fa-list-ol iconButton btnChitiet" aria-hidden="true" rel="tooltip" title="Danh sách menu nhóm quản lý"></i>\
                                         <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa"></i>'
                              });
                              return $dtooltip.html();
                          }
                          return data = '<i class="fa fa-users iconButton btnCTAdmin " aria-hidden="true" rel="tooltip" title="Danh sách admin trong nhóm"></i>\
                                         <i class="fa fa-list-ol iconButton btnChitiet" aria-hidden="true" rel="tooltip" title="Danh sách menu nhóm quản lý"></i>';
                      }
                  },
            ],
            "bSort": false,
            "order": [[0, 'asc']],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachnhomadmin').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachnhomadmin').DataTable();
        var datathongtin = null;
        var idClick = 0;

        table.on('click', 'i.btnCTAdmin', function () {
            datathongtin = "";
            idClick = "";
            var closestRow = $(this).closest('tr');
            datathongtin = table.row(closestRow).data();
            idClick = datathongtin.id_nhomadmin;


            $('#lidanhsach').removeClass('active');
            $('#danhsachnhomadmin').removeClass('active');

            $('#ulmenu').append('<li class="active" id="dsadmin"><a href="#danhsachadmintrongnhom" data-toggle="tab" aria-expanded="false" id="tennhomadmin"></a></li>');
            $('#frmnoidung').append('<div class="tab-pane  active" id="danhsachadmintrongnhom"></div>');
            $('#tennhomadmin').html('<i class="fa fa-edit iconTab"></i>' + datathongtin.tennhom);
            var thongtinchitietnhomadmin = $('#danhsachadmintrongnhom');

            thongtinchitietnhomadmin.empty();

            $tablethongtinchitietnhomadmin = $('<table />', {
                class: 'table table-bordered table-hover',
                id: 'tb_danhsachadmintrongnhom',
                html: '<thead>\
                            <th>Tài khoản</th>\
                            <th>Họ tên</th>\
                            <th>Email</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
            }).appendTo(thongtinchitietnhomadmin);

            var tableAdmin = $('#tb_danhsachadmintrongnhom').DataTable({
                data: datathongtin.nhomtaikhoan,
                "columns": [
                      { data: "taikhoan1" },
                      { data: "tendaydu" },
                      { data: "email" },
                      {
                          data: "button", "width": "105px",
                          mRender: function (data) {
                              if (data.xoa == true) {
                                  return data = '<i class="fa fa-trash-o iconButton btnRemove" aria-hidden="true" rel="tooltip" title="Xóa khỏi nhóm"></i>'
                              } else {
                                  return data = "";
                              }
                          }
                      },
                ],
                "pagingType": "full_numbers",
                "order": [[0, 'asc']],
                "bSort": false,
            });

            $('#tb_danhsachadmintrongnhom_length').append('<button type="button" id="btnthemmoitk" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm tài khoản</button>');
            var parent2 = $('#tb_danhsachadmintrongnhom').parent().addClass('box-body table-responsive no-padding');
            var tableAdmin = $('#tb_danhsachadmintrongnhom').DataTable();
            $('#liaddnew').click(function () {
                $('#dsadmin').remove();
                $('#danhsachadmintrongnhom').remove();
            });
            $('#lidanhsach').click(function () {
                $('#dsadmin').remove();
                $('#danhsachadmintrongnhom').remove();
            });

            $('#tb_danhsachadmintrongnhom_length label').remove();

            $('#btnthemmoitk').click(function () {
                $('#btnok').remove();
                $('#btnAddMenu').remove();
                loadtaikhoanadminchuaconhomquanly();
                $('#modelSuDung_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnok"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');

                $('#ModalFolder').on('show.bs.modal', function (event) {
                    //    $('#btnok').html("Thêm mới");
                    $('#listAdmin').change(function () {
                        if ($(this).prop("checked")) {
                            var a = $('#danhsachadmin').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', true);
                            });
                        } else {
                            var a = $('#danhsachadmin').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                        }
                    });

                });
                setTimeout(function () {
                    $('#ModalFolder').modal('show');
                    $('#btnok').click(function () {
                        themmoitaikhoan(datathongtin, idClick);
                    });
                }, 230);
            });
            //xoa
            tableAdmin.on('click', 'i.btnRemove', function () {

                var closestRow = $(this).closest('tr');
                var dataadmin = tableAdmin.row(closestRow).data();
                var id_Admin = dataadmin.id_taikhoan;
                var id_Nhom = datathongtin.id_nhomadmin;

                swal({
                    title: 'Loại bỏ admin khỏi nhóm quản lý',
                    text: "Bạn có muốn xóa admin nhóm quản lý này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    $('.loader-parent').removeAttr('style');

                    jsonPost({ type: 'loaiboadminkhoinhomquanly', id_Admin: id_Admin, id_Nhom: id_Nhom }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaiboadminkhoinhomquanly', id_Admin: id_Admin, id_Nhom: id_Nhom }, function (kq) {
                        if (kq.sucess) {
                            swal('Thông báo ', kq.msg, 'success')
                        }
                        else {
                            swal('Thông báo ', kq.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        table.ajax.reload(function (json) {
                            var itemcha = json.data.filterObjects('id_nhomadmin', idClick);
                            if (itemcha.length > 0) {
                                tableAdmin.clear().draw();
                                tableAdmin.rows.add(itemcha[0].nhomtaikhoan).draw()
                            }
                        });
                    });

                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                    }
                    $('.loader-parent').css('display', 'none');
                });

            });

        });

        table.on('click', 'i.btnChitiet', function () {

            datathongtin = "";
            idClick = "";
            var closestRow = $(this).closest('tr');
            datathongtin = table.row(closestRow).data();
            idClick = datathongtin.id_nhomadmin;
            $('#lidanhsach').removeClass('active');
            $('#danhsachnhomadmin').removeClass('active');

            $('#ulmenu').append('<li class="active" id="thongtinchitiet"><a href="#thongtinchitietnhomadmin" data-toggle="tab" aria-expanded="false" id="tennhomadmin"></a></li>');
            $('#frmnoidung').append('<div class="tab-pane  active" id="thongtinchitietnhomadmin"></div>');
            $('#tennhomadmin').html('<i class="fa fa-edit iconTab"></i>' + datathongtin.tennhom);
            var thongtinchitietnhomadmin = $('#thongtinchitietnhomadmin');

            thongtinchitietnhomadmin.empty();

            $tablethongtinchitietnhomadmin = $('<table />', {
                class: 'table table-bordered table-hover',
                id: 'tb_thongtinchitietnhomadmin',
                html: '<thead>\
                            <th>Tên menu</th>\
                            <th>Thêm</th>\
                            <th>Sửa</th>\
                            <th>Xóa</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
            }).appendTo(thongtinchitietnhomadmin);
            var tableMenu = $('#tb_thongtinchitietnhomadmin').DataTable({
                data: datathongtin.nhommenu,
                "columns": [
                      { data: "tenmenu" },
                      {
                          data: "them", mRender: function (data) {
                              if (data == true) {
                                  data = "<div class='checkbox col-xs-3'><input id='them' type='checkbox' checked></div>";
                              } else {
                                  data = "<div class='checkbox col-xs-3'><input id='them' type='checkbox'></div>";
                              }
                              return data;
                          }
                      },
                      {
                          data: "sua", mRender: function (data) {
                              if (data == true) {
                                  data = "<div class='checkbox col-xs-3'><input id='sua' type='checkbox' checked></div>";
                              } else {
                                  data = "<div class='checkbox col-xs-3'><input id='sua' type='checkbox'></div>";
                              }
                              return data;
                          }
                      },
                      {
                          data: "xoa", mRender: function (data) {
                              if (data == true) {
                                  data = "<div class='checkbox col-xs-3'><input id='xoa' type='checkbox' checked></div>";
                              } else {
                                  data = "<div class='checkbox col-xs-3'><input id='xoa' type='checkbox'></div>";
                              }
                              return data;
                          }
                      },
                        {
                            data: "button", "width": "80px",
                            mRender: function (data) {
                                if (data.xoa == true) {
                                    return data = '<i class="fa fa-trash-o iconButton btnRemoveMenu" aria-hidden="true" rel="tooltip" title="Xóa khỏi nhóm"></i>'
                                }
                                else {
                                    return data = "";
                                }
                            }
                        },
                ],
                "pagingType": "full_numbers",
                "order": [[0, 'asc']],
                "bSort": false,
            });
            var parent3 = $('#tb_thongtinchitietnhomadmin').parent().addClass('box-body table-responsive no-padding');
            if (datathongtin.button.sua == false) {
                $('#tb_thongtinchitietnhomadmin input').attr("disabled", "disabled");
            }

            $('#liaddnew').click(function () {
                $('#thongtinchitietnhomadmin').removeClass('active');
                $('#thongtinchitiet').remove();
            });

            $('#lidanhsach').click(function () {
                $('#thongtinchitietnhomadmin').remove();
                $('#thongtinchitiet').remove();
            });
            //xoa menu
            tableMenu.on('click', 'i.btnRemoveMenu', function () {

                var closestRow = $(this).closest('tr');
                var dataMenu = tableMenu.row(closestRow).data();
                var id_Nhomquyen = dataMenu.id_nhomquyen;
                var id_Menu = dataMenu.id_menu;
                var id_NhomAdmin = dataMenu.button.id_nhomadmin;

                swal({
                    title: 'Xóa menu khỏi nhóm quản lý',
                    text: "Bạn có muốn xóa menu khỏi nhóm quản lý này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    $('.loader-parent').removeAttr('style');

                    jsonPost({ type: 'loaibomenukhoinhomquanly', id_Nhomquyen: id_Nhomquyen, id_Menu: id_Menu, id_NhomAdmin: id_NhomAdmin }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaibomenukhoinhomquanly', id_Nhomquyen: id_Nhomquyen, id_Menu: id_Menu, id_NhomAdmin: id_NhomAdmin }, function (kq) {
                        if (kq.sucess) {
                            swal('Thông báo ', kq.msg, 'success')
                        }
                        else {
                            swal('Thông báo ', kq.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        table.ajax.reload(function (json) {
                            var itemcha = json.data.filterObjects('id_nhomadmin', idClick);
                            if (itemcha.length > 0) {
                                tableMenu.clear().draw();
                                tableMenu.rows.add(itemcha[0].nhommenu).draw()
                            }
                        });
                    });

                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                    }
                    $('.loader-parent').css('display', 'none');
                });

            });
            //sua
            tableMenu.on('click', 'input:checkbox', function () {
                var closestRow = $(this).closest('tr');
                var dataMenu = tableMenu.row(closestRow).data();
                var trangthai = $(this).change().context.checked;
                var quyen = $(this).change().context.id;
                var id_nhomquyen = dataMenu.id_nhomquyen;
                var dataCu = "";
                var ten = $(this);

                if (quyen == "them") {
                    dataCu = dataMenu.them;
                }
                //if (quyen == "xem") {
                //    dataCu = dataMenu.xem;
                //}
                if (quyen == "sua") {
                    dataCu = dataMenu.sua;
                }
                if (quyen == "xoa") {
                    dataCu = dataMenu.xoa;
                }
                swal({
                    title: 'Thay đổi quyền quản lý với menu',
                    text: "Bạn có muốn thay đổi quyền quản lý với menu này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    $('.loader-parent').removeAttr('style');

                    jsonPost({ type: 'suaquyencuaadmintrongmenu', trangthai: trangthai, quyen: quyen, id_nhomquyen: id_nhomquyen }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'suaquyencuaadmintrongmenu', trangthai: trangthai, quyen: quyen, id_nhomquyen: id_nhomquyen }, function (kq) {
                        if (kq.sucess) {
                            swal('Thông báo ', kq.msg, 'success')
                        }
                        else {
                            swal('Thông báo ', kq.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        table.ajax.reload(function (json) {
                            var itemcha = json.data.filterObjects('id_nhomadmin', idClick);
                            if (itemcha.length > 0) {
                                tableMenu.clear().draw();
                                tableMenu.rows.add(itemcha[0].nhommenu).draw()
                            }
                        });
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                    }
                    $('.loader-parent').css('display', 'none');
                    ten.prop('checked', dataCu);
                });
            });
            //them
            $('#tb_thongtinchitietnhomadmin_length label').remove();
            if (datathongtin.button.them == true) {
                if (datathongtin.button.sua == true) {
                    $('#tb_thongtinchitietnhomadmin_length').empty();
                    $('#tb_thongtinchitietnhomadmin_length').append('<div class="col-sm-8"><div class="row"><button type="button" id="btnthemmoimenu123" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm menu</button></div></div><div class="col-sm-4"><div class="row"><label><input type="checkbox" id="checkallQuyenMenu"> Thay đổi tất cả</label></div></div>');

                } else {
                    $('#tb_thongtinchitietnhomadmin_length').empty();
                    $('#tb_thongtinchitietnhomadmin_length').append('<div class="col-sm-8"><div class="row"><button type="button" id="btnthemmoimenu123" class="btn btn-primary btn-flat IconButtonPage"><i class="fa fa-plus iconButtonPage"></i>Thêm menu</button></div></div>');

                }
            }
            $('#btnthemmoimenu123').click(function () {
                $('#btnAddMenu').remove();
                $('#btnok').remove();
                loadmenu_khongtontaitrongquyendethemmoi(idClick);
                $('#modelSuDung_ft').append('<button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnAddMenu"><i class="fa fa-plus iconButtonPage"></i>Thêm mới</button>');
                $('#ModalFolder').on('show.bs.modal', function (event) {

                    $('#listMenu').change(function () {
                        if ($(this).prop("checked")) {
                            var a = $('#danhsachmenu12').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', true);
                            });
                        } else {
                            var a = $('#danhsachmenu12').find('input');
                            $.each(a, function (key, val) {
                                $(this).prop('checked', false);
                            });
                        }
                    });
                });

                setTimeout(function () {
                    $('#ModalFolder').modal('show');
                    $('#btnAddMenu').click(function () {
                        themmoimenu_vaoquyenquanly(datathongtin, idClick);
                    });
                }, 230);
            });

            var lstIDMenu = [];
            var trangthaicheck = false;

            $('#checkallQuyenMenu').change(function () {
                var status = $(this).context.checked;
                var lstCk = $('#tb_thongtinchitietnhomadmin input:checkbox');

                $.each(datathongtin.nhommenu, function (ii, vv) {
                    lstIDMenu.push(vv.id_nhomquyen);
                });

                if (status == true) {
                    trangthaicheck = true;

                    if (lstIDMenu.length > 0) {
                        swal({
                            title: 'Thay đổi quyền quản lý menu ?',
                            text: "Bạn có muốn thay đổi quyền quản lý menu này không ?",
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Vâng, tôi đồng ý !',
                            cancelButtonText: 'Không. cảm ơn!'
                        }).then(function () {

                            jsonPost({ type: 'thaydoiquyenquanlylistmenu', trangthaicheck: trangthaicheck, danhsach: JSON.stringify(lstIDMenu) }).then(function (kq) {
                           // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoiquyenquanlylistmenu', trangthaicheck: trangthaicheck, danhsach: JSON.stringify(lstIDMenu) }, function (kq) {
                                if (kq.sucess) {
                                    swal('Thông báo ', kq.msg, 'success')
                                    table.ajax.reload();

                                    $.each(lstCk, function (i, v) {
                                        $(this).prop("checked", true);
                                    });
                                }
                                else {
                                    swal('Thông báo ', kq.msg, 'error')
                                }
                            });

                        }, function (dismiss) {
                            if (dismiss === 'cancel') {
                                swal(
                                  'Hủy bỏ ',
                                  'Lệnh thay đổi đã bị hủy bỏ ',
                                  'info'
                                )
                                if (status == true) {
                                    $('#checkallQuyenMenu').prop("checked", false);
                                } else {
                                    $('#checkallQuyenMenu').prop("checked", true);
                                }

                            }
                        });
                    }
                }
                if (status == false) {
                    trangthaicheck = false;

                    if (lstIDMenu.length > 0) {
                        swal({
                            title: 'Thay đổi quyền quản lý menu ?',
                            text: "Bạn có muốn thay đổi quyền quản lý menu này không ?",
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Vâng, tôi đồng ý !',
                            cancelButtonText: 'Không. cảm ơn!'
                        }).then(function () {

                            jsonPost({ type: 'thaydoiquyenquanlylistmenu', trangthaicheck: trangthaicheck, danhsach: JSON.stringify(lstIDMenu) }).then(function (kq) {
                            //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'thaydoiquyenquanlylistmenu', trangthaicheck: trangthaicheck, danhsach: JSON.stringify(lstIDMenu) }, function (kq) {
                                if (kq.sucess) {
                                    swal('Thông báo ', kq.msg, 'success')
                                    table.ajax.reload();

                                    $.each(lstCk, function (i1, v1) {
                                        $(this).prop("checked", false);
                                    });

                                }
                                else {
                                    swal('Thông báo ', kq.msg, 'error')
                                }
                            });

                        }, function (dismiss) {
                            if (dismiss === 'cancel') {
                                swal(
                                  'Hủy bỏ ',
                                  'Lệnh thay đổi đã bị hủy bỏ ',
                                  'info'
                                )
                                if (status == true) {
                                    $('#checkallQuyenMenu').prop("checked", false);
                                } else {
                                    $('#checkallQuyenMenu').prop("checked", true);
                                }
                            }
                        });
                    }
                }
            });
        });

        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var dsadmin = new Array();
            var idnhom = data.id_nhomadmin;

            data.nhomtaikhoan.forEach(function (item) {
                dsadmin.push(item.id_taikhoan);
            });

            swal({
                title: 'Xóa nhóm quản lý ?',
                text: "Bạn có muốn xóa nhóm quản lý này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');

                jsonPost({ type: 'xoanhomadmin', idnhom: idnhom, danhsach: JSON.stringify(dsadmin) }).then(function (kq) {
                //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoanhomadmin', idnhom: idnhom, danhsach: JSON.stringify(dsadmin) }, function (kq) {
                    if (kq.sucess) {
                        swal('Thông báo ', kq.msg, 'success')
                        table.ajax.reload();
                    }
                    else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                });

            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
            });
        });
    }

}
function loadtaikhoanadminchuaconhomquanly() {
    $('#ModalFolder').find('.box-body').empty();
    var modalbodytb = $('#ModalFolder').find('.box-body');
    $('<div />', {
        class: 'row',
        html: '<div class="checkbox col-md-12" id="danhsachadmin">\
               </div>'
    }).appendTo(modalbodytb);

    $('#tieudeModel').html("Thêm mới admin vào nhóm quản lý");
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddanhsachadminthemmoivaonhom' }, function (danhsach) {
        if (danhsach.data == 0) {
            $('#danhsachadmin').empty();
            $('#danhsachadmin').append('<p>Tất cả admin trong hệ thống đều có nhóm quản lý </p>');
            $('#btnok').remove();
        } else {
            $('#danhsachadmin').empty();
            $('#danhsachadmin').append('<div class="checkbox col-xs-12" id="chontatca">\
                                            <label>\
                                                <input id="listAdmin" type="checkbox">Chọn tất cả\
                                            </label>\
                                        </div>');

            $.each(danhsach.data, function (key, val) {
                $('#danhsachadmin').append('<div class="checkbox col-xs-3"> <label><input data-idadmin="' + JSON.stringify(val.id_taikhoan) + '" id="idadmin' + val.id_taikhoan + '" type="checkbox" />' + val.taikhoan1 + '</label></div>');
            })
        }
    });
}
function themmoitaikhoan(datathongtin, idClick) {

    var idnhomadmin = datathongtin.id_nhomadmin;
    var dsadminShare = new Array();
    var dscheck = $('#danhsachadmin input:checked');
    $.each(dscheck, function (key, val) {
        var idArrt = val.id;
        var idadm = $('#' + idArrt).data('idadmin');
        if (idArrt != "listAdmin") { dsadminShare.push(idadm); }
    });
    if (dsadminShare != "") {
        $('.loader-parent').removeAttr('style');
        jsonPost({ type: 'themadminvaonhom', idnhomadmin: idnhomadmin, thongtin: JSON.stringify(dsadminShare) }).then(function (kq) {
       // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themadminvaonhom', idnhomadmin: idnhomadmin, thongtin: JSON.stringify(dsadminShare) }, function (kq) {

            if (kq.sucess == true) {
                swal('Thông báo ', kq.msg, 'success')
            } else {
                swal('Thông báo ', kq.msg, 'error')
            }
            $('#btnHuy').click();
            $('.loader-parent').css('display', 'none');
            idnhomadmin = "";
            dsadminShare = [];
            var table = $('#tb_danhsachnhomadmin').DataTable();
            var tableAdmin = $('#tb_danhsachadmintrongnhom').DataTable();
            table.ajax.reload(function (json) {
                var itemcha = json.data.filterObjects('id_nhomadmin', idClick);
                if (itemcha.length > 0) {
                    tableAdmin.clear().draw();
                    tableAdmin.rows.add(itemcha[0].nhomtaikhoan).draw()
                }
            });
        });

    } else {
        $loading.remove();
        common.showNotification('top', 'right', 'Mời bạn chọn admin ');
    }
}

function loadmenu_khongtontaitrongquyendethemmoi(idClick) {
    $('#ModalFolder').find('.box-body').empty();
    var modalbodytb12 = $('#modalFolBody');
    $('<div />', {
        class: 'row',
        html: '<div class="checkbox col-md-12" id="danhsachmenu12">\
               </div>'
    }).appendTo(modalbodytb12);

    $('#tieudeModel').html("Thêm mới menu vào quyền quản lý");

    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loadmenuchuatontaitrongquyen', idClick: idClick }, function (danhsach) {

        if (danhsach.data == 0) {
            $('#danhsachmenu12').empty();
            $('#danhsachmenu12').append('<p>Không có menu nào </p>');
            $('#btnAddMenu').remove();
        } else {
            $('#danhsachmenu12').empty();
            $('#danhsachmenu12').append('<div class="checkbox col-xs-12" id="chontatca">\
                                            <label>\
                                                <input id="listMenu" type="checkbox">Chọn tất cả\
                                            </label>\
                                        </div>');

            $.each(danhsach.data, function (key, val) {
                $('#danhsachmenu12').append('<div class="checkbox col-xs-4"> <label><input data-idadmin="' + JSON.stringify(val.id_menu) + '" id="idadmin' + val.id_menu + '" type="checkbox" />' + val.tenmenu + '</label></div>');
            })
        }
    });

}
function themmoimenu_vaoquyenquanly(datathongtin, idClick) {

    var idnhomadmin = datathongtin.id_nhomadmin;
    var dsadminShare = new Array();
    var dscheck = $('#danhsachmenu12 input:checked');

    $.each(dscheck, function (key, val) {
        var idArrt = val.id;
        var idadm = $('#' + idArrt).data('idadmin');
        if (idArrt != "listMenu") { dsadminShare.push(idadm); }
    });

    if (dsadminShare != "") {
        $('.loader-parent').removeAttr('style');
        jsonPost({ type: 'themmoimenuvaonhomquanly', idnhomadmin: idnhomadmin, thongtin: JSON.stringify(dsadminShare) }).then(function (kq) {
       // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoimenuvaonhomquanly', idnhomadmin: idnhomadmin, thongtin: JSON.stringify(dsadminShare) }, function (kq) {

            if (kq.sucess == true) {
                swal('Thông báo ', kq.msg, 'success')
            } else {
                swal('Thông báo ', kq.msg, 'error')
            }
            $('.loader-parent').css('display', 'none');
            $('#btnHuy').click();
            idnhomadmin = "";
            dsadminShare = [];
            var table = $('#tb_danhsachnhomadmin').DataTable();
            var tableAdmin = $('#tb_thongtinchitietnhomadmin').DataTable();
            table.ajax.reload(function (json) {
                var itemcha = json.data.filterObjects('id_nhomadmin', idClick);
                if (itemcha.length > 0) {
                    tableAdmin.clear().draw();
                    tableAdmin.rows.add(itemcha[0].nhommenu).draw()
                }
            });
        });

    } else {
        $loading.remove();
        common.showNotification('top', 'right', 'Mời bạn chọn menu cần thêm mới ');
    }
}


//QUẢN LÝ THƯ MỤC TÀI LIỆU
function initQuanLyThuMucTaiLieu() {
    curentPage = 0;
    loadthumuctailieu();
    uploadthumucTailieu();

    loadFileOther();
    $(".panel-left").resizable({
        handleSelector: ".splitter",
        resizeHeight: false
    });
    $(".panel-top").resizable({
        handleSelector: ".splitter-horizontal",
        resizeWidth: false
    });

    document.body.onclick = function (e) {
        if (e.srcElement.tagName != "I" && e.srcElement.id != "deleteimg" && e.srcElement.id != "renameimg") {
            $('#popuup_div').hide();
        }
    }
}
function loadthumuctailieu() {

    $(function () {
        $(window).resize(function () {
            var h = Math.max($(window).height() - 0, 420);
            $('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
        }).resize();
        var $menuthumuc = $('#dragTree');
        var $dragTree = $('#dragTree');
        $menuthumuc.jstree({
            'core': {
                'data': {
                    'url': function (node) {
                        return node.id === '#' ? '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucTailieu&id_tm=0' : '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucTailieu&id_tm=' + node.id;
                    },
                    'data': function (node) {
                        return { 'id': node.id };
                    }
                },
                'check_callback': function (o, n, p, i, m) {
                    if (m && m.dnd && m.pos !== 'i') { return false; }

                    if (o === "move_node" || o === "copy_node") {
                        if (this.get_node(n).parent === this.get_node(p).id) { return false; }
                    }
                    return true;
                },
                'themes': {
                    'responsive': false
                }
            },
            'sort': function (a, b) {
                return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
            },
            'contextmenu': {
                'items': function (node) {
                    var tmp = $.jstree.defaults.contextmenu.items();
                    delete tmp.create.action;

                    var node_selected = $('#dragTree').jstree('get_selected', true);
                    var _nodeGoc = node_selected[0].parent;


                    if (_nodeGoc == "#") {
                        delete tmp.rename;
                        delete tmp.remove;
                        //    delete tmp.ccp;
                    }

                    tmp.create.label = "Thêm mới thư mục";
                    tmp.create.submenu = {
                        "create_folder": {
                            "separator_after": true,
                            "label": "Thư mục mới",
                            "action": function (data) {
                                var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                                inst.create_node(obj, { type: "default" }, "last", function (new_node) {
                                    setTimeout(function () { inst.edit(new_node); }, 0);
                                });
                            }
                        },
                        //"create_file": {
                        //    "label": "Thêm ảnh",
                        //    "action": function (data) {
                        //        var inst = $.jstree.reference(data.reference),
                        //            obj = inst.get_node(data.reference);
                        //        inst.create_node(obj, { type: "file" }, "last", function (new_node) {
                        //            setTimeout(function () { inst.edit(new_node); }, 0);
                        //        });
                        //    }
                        //}
                    };
                    if (this.get_type(node) === "file") {
                        delete tmp.create;
                    }
                    return tmp;
                }
            },
            'types': {
                'default': {
                    'icon': 'fa fa-folder'
                },
                'file': {
                    'icon': 'fa fa-file'
                }
            },
            'unique': {
                'duplicate': function (name, counter) {
                    return name + ' ' + counter;
                }
            },
            'plugins': ['state', 'dnd', 'sort', 'types', 'contextmenu', 'unique']
        }).bind('select_node.jstree', function (e, data) {
            var _idthumuc = "";
            var node_selected = $('#dragTree').jstree('get_selected', true);
            var idPar = node_selected[0].parent;
            var idMe = node_selected[0].id;

            // fix cứng thu mục tai lieu =3
            if (idPar == "#" && idMe == 3) {
                hienthidanhsach_Tailieuduocchiase();
            }
            else {
                hienthidanhsach_Tailieutheothumuc();
            }

            $('#liaddnew').removeClass('active');
            $('#uploadvaothumuc').removeClass('active');
            $('#lidanhsach').addClass('active');
            $('#danhsachanhhienthi').addClass('active');

        })

           .on('create_node.jstree', function (e, data) {

               var _idcha = data.parent;
               var _tencon = data.node.text;
               jsonPost({ type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }).then(function (kq) {
            //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }, function (kq) {
                   if (kq.suscess) {
                       idtrunggian = kq.id_quanlythumuc;
                   }
               });
               $.get('?operation=create_node', { 'type': data.node.type, 'id': data.node.parent, 'text': data.node.text })
                   .done(function (d) {
                       //   data.instance.set_id(data.node, d.id);
                   })
                   .fail(function () {
                       data.instance.refresh();
                   });
           })
            .on('rename_node.jstree', function (e, data) {

                var _idthumuc = "";
                var _tenmoi = data.text;

                if (idtrunggian == "") {
                    _idthumuc = data.node.id;
                } else {
                    _idthumuc = idtrunggian;
                }
                if (!valTextboxValue(_tenmoi)) {
                    $menuthumuc.jstree(true).refresh();
                    $loading.remove();
                    common.showNotification('top', 'right', 'Tên thư mục không chứa ký tự đặc biệt !');
                }

                else {

                    swal({
                        title: 'Đổi tên thư mục ?',
                        text: "Bạn sẽ dùng tên mới này cho thư mục ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        jsonPost({ type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }).then(function (kq) {
                      //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }, function (kq) {
                            if (kq.suscess) {
                                idtrunggian = "";
                            }
                            $menuthumuc.jstree(true).refresh();
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh xóa đã bị hủy bỏ ',
                              'info'
                            )
                            $menuthumuc.jstree(true).refresh();
                        }
                    });
                }
            })
            .on('delete_node.jstree', function (e, data) {
                var _idnode = data.node.id;

                swal({
                    title: 'Xóa thư mục ?',
                    text: "Bạn có muốn xóa thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {

                    jsonPost({ type: 'xoathumuc', _idnode: _idnode }).then(function (kq) {
                //    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoathumuc', _idnode: _idnode }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });

            })
            .on('move_node.jstree', function (e, data) {
                var _idthumuc = data.node.id;
                var _idparent = data.parent;

                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ di chuyển đến thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {

                    jsonPost({ type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                  //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
            .on('copy_node.jstree', function (e, data) {

                var _idthumuc = data.original.id;
                var _idparent = data.parent;
                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ coppy vào thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {

                    jsonPost({ type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                 //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
            .on('changed.jstree', function (e, data) {
                if (data && data.selected && data.selected.length) {
                    $.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
                        if (d && typeof d.type !== 'undefined') {
                            $('#data .content').hide();
                            switch (d.type) {
                                case 'text':
                                case 'txt':
                                case 'md':
                                case 'htaccess':
                                case 'log':
                                case 'sql':
                                case 'php':
                                case 'js':
                                case 'json':
                                case 'css':
                                case 'html':
                                    $('#data .code').show();
                                    $('#code').val(d.content);
                                    break;
                                case 'png':
                                case 'jpg':
                                case 'jpeg':
                                case 'bmp':
                                case 'gif':
                                    $('#data .image img').one('load', function () { $(this).css({ 'marginTop': '-' + $(this).height() / 2 + 'px', 'marginLeft': '-' + $(this).width() / 2 + 'px' }); }).attr('src', d.content);
                                    $('#data .image').show();
                                    break;
                                default:
                                    $('#titleFolder').html(d.content).show();
                                    break;
                            }
                        }
                    });
                }
                else {
                    $('#titleFolder').hide();
                    $('#titleFolder').html('Select a file from the tree.').show();
                }
            });
    });
}
function hienthidanhsach_Tailieutheothumuc() {
    $('#liaddnew').removeAttr('style');
    var node_selected = $('#dragTree').jstree('get_selected', true);
    var idPar = node_selected[0];
    var _idthumuc = idPar.id;
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdulieutrongthumuc', _idthumuc: _idthumuc }, function (kq) {
        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var iconFile = "";
            if (item.mimetype == "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
                iconFile = "iconFile.png";
            }
            else if (item.mimetype == "application/pdf") {
                iconFile = "pdf.jpg";
            }
            else if (item.mimetype == "application/msword") {
                iconFile = "iconWord.png";
            }
            else if (item.mimetype == "application/x-zip-compressed") {
                iconFile = "iconWinrar.png";
            } else {
                iconFile = "fileOther.jpg";
            }
            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon' id='ext-element-22'>\
                            <span class='x-item-thumbnail'>\
                                  <div id='embedURL' class='html5gallery' data-html5player='true' data-fancybox data-src='//docs.google.com/viewer?embedded=true&url=" + linkWebC50 + item.duongdanfile + "' data-webm='" + item.duongdanfile + "' data-title='" + item.tenfile + "'>\
                                    <img class='b-lazy b-loaded x-select-target fancybox' src='/ThuMucGoc/AnhDaiDien/"+ iconFile + "' width='90px' height='90px' id='ext-element-21'>\
                                  </div>\
                            </span>\
                        </span>\
                        <input class='x-item-textbox' value='" + item.tenfile + "' readonly type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);



            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li.click(function () {
                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };
            idex++;
        });
    });
}
function hienthidanhsach_Tailieuduocchiase() {
    $('#liaddnew').attr('style', 'display:none')
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachtailieuduocchiase' }, function (kq) {
        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var iconFile = "";
            if (item.mimetype == "application/vnd.openxmlformats-officedocument.wordprocessingml.document") {
                iconFile = "iconFile.png";
            }
            else if (item.mimetype == "application/pdf") {
                iconFile = "pdf.jpg";
            }
            else if (item.mimetype == "application/msword") {
                iconFile = "word.png";
            } else {
                iconFile = "fileOther.jpg";
            }

            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon' id='ext-element-22'>\
                            <span class='x-item-thumbnail'>\
                                  <div id='embedURL' class='html5gallery' data-html5player='true' data-fancybox data-src='//docs.google.com/viewer?embedded=true&url=" + linkWebC50 + item.duongdanfile + "' data-webm='" + item.duongdanfile + "' data-title='" + item.tenfile + "'>\
                                    <img class='b-lazy b-loaded x-select-target fancybox' src='/ThuMucGoc/AnhDaiDien/"+ iconFile + "' width='90px' height='90px' id='ext-element-21'>\
                                  </div>\
                            </span>\
                        </span>\
                        <input class='x-item-textbox' value='" + item.tenfile + "' readonly type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);

            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li.click(function () {
                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };
            idex++;
        });
    });
}
function uploadthumucTailieu() {
    var _idthumuc = '';
    var check = true;
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachtaikhoanadmin' }, function (danhsach) {
        $('#danhsachadmin').empty();
        $.each(danhsach.data, function (key, val) {
            $('#danhsachadmin').append(' <div class="checkbox col-xs-3"> <label><input data-idadmin="' + JSON.stringify(val.id_taikhoan) + '" id="idadmin' + val.id_taikhoan + '" type="checkbox" />' + val.taikhoan1 + '</label></div>');
        })
    });

    $('#listAdmin').change(function () {
        if ($(this).prop("checked")) {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', true);
            });
        } else {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
        }
    });

    $('#btnUploadFile').click(function () {
        _idthumuc = "";
        var node_selected = $('#dragTree').jstree('get_selected', true);
        _idthumuc = node_selected[0].id;
        var dsadminShare = new Array();
        var anhdaidien = $('#anhdaidien').val();
        var dungluong = $('#kicthuoc').text();
        var tenfile = $('#name-vid').text();

        var dscheck = $('#danhsachadmin input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        var fd_data = new FormData();
        fd_data.append('thongtin', JSON.stringify(dsadminShare));
        fd_data.append('type', 'uploadFileTaiLieu');
        fd_data.append('fileanh', $('#anhdaidien')[0].files[0]);
        fd_data.append('_idthumuc', _idthumuc);
        fd_data.append('dungluong', dungluong);
        fd_data.append("stringTookenClient", stringTookenServer);


        if (anhdaidien == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn file cần upload');
        } else if (_idthumuc == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn folder');
        } else if (!valTextboxValue(tenfile)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Tên folder không chứa ký tự đặc biệt ');
        }

        if (check) {
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess) {
                        swal('Thông báo ', data.msg, 'success')
                        $('#preview').html('');
                        $('#anhdaidien').val('');
                        $('#name-vid').html('');
                        $('#size-vid').html('');
                        $('#type-vid').html('');
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                }
            });
        }
    });
    $('#lidanhsach').click(function () {
        $('#lidanhsach').addClass('active');
        $('#danhsachanhhienthi').addClass('active');

        $('#liaddnew').removeClass('active');
        $('#uploadvaothumuc').removeClass('active');

        hienthidanhsach_Tailieutheothumuc(_idthumuc);
    });
}



//QUẢN LÝ THƯ MỤC VIDEO
function initQuanLyThuMucVideo() {
    curentPage = 0;
    loadthumucvideo();
    uploadthumucVideo();
    loadvideo();
    $(".panel-left").resizable({
        handleSelector: ".splitter",
        resizeHeight: false
    });
    $(".panel-top").resizable({
        handleSelector: ".splitter-horizontal",
        resizeWidth: false
    });

    document.body.onclick = function (e) {
        if (e.srcElement.tagName != "I" && e.srcElement.id != "deleteimg" && e.srcElement.id != "renameimg") {
            $('#popuup_div').hide();
        }
    }
}
function loadthumucvideo() {

    $(function () {
        $(window).resize(function () {
            var h = Math.max($(window).height() - 0, 420);
            $('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
        }).resize();
        var $menuthumuc = $('#dragTree');
        var $dragTree = $('#dragTree');
        $menuthumuc.jstree({
            'core': {
                'data': {
                    'url': function (node) {
                        return node.id === '#' ? '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucvideo&id_tm=0' : '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucvideo&id_tm=' + node.id;
                    },
                    'data': function (node) {
                        return { 'id': node.id };
                    }
                },
                'check_callback': function (o, n, p, i, m) {
                    if (m && m.dnd && m.pos !== 'i') { return false; }

                    if (o === "move_node" || o === "copy_node") {
                        if (this.get_node(n).parent === this.get_node(p).id) { return false; }
                    }
                    return true;
                },
                'themes': {
                    'responsive': false
                }
            },
            'sort': function (a, b) {
                return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
            },
            'contextmenu': {
                'items': function (node) {
                    var tmp = $.jstree.defaults.contextmenu.items();
                    delete tmp.create.action;

                    var node_selected = $('#dragTree').jstree('get_selected', true);
                    var _nodeGoc = node_selected[0].parent;


                    if (_nodeGoc == "#") {
                        delete tmp.rename;
                        delete tmp.remove;
                        //    delete tmp.ccp;
                    }

                    tmp.create.label = "Thêm mới thư mục";
                    tmp.create.submenu = {
                        "create_folder": {
                            "separator_after": true,
                            "label": "Thư mục mới",
                            "action": function (data) {
                                var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                                inst.create_node(obj, { type: "default" }, "last", function (new_node) {
                                    setTimeout(function () { inst.edit(new_node); }, 0);
                                });
                            }
                        },
                        //"create_file": {
                        //    "label": "Thêm ảnh",
                        //    "action": function (data) {
                        //        var inst = $.jstree.reference(data.reference),
                        //            obj = inst.get_node(data.reference);
                        //        inst.create_node(obj, { type: "file" }, "last", function (new_node) {
                        //            setTimeout(function () { inst.edit(new_node); }, 0);
                        //        });
                        //    }
                        //}
                    };
                    if (this.get_type(node) === "file") {
                        delete tmp.create;
                    }
                    return tmp;
                }
            },
            'types': {
                'default': {
                    'icon': 'fa fa-folder'
                },
                'file': {
                    'icon': 'fa fa-file'
                }
            },
            'unique': {
                'duplicate': function (name, counter) {
                    return name + ' ' + counter;
                }
            },
            'plugins': ['state', 'dnd', 'sort', 'types', 'contextmenu', 'unique']
        }).bind('select_node.jstree', function (e, data) {
            var _idthumuc = "";
            var node_selected = $('#dragTree').jstree('get_selected', true);
            var idPar = node_selected[0].parent;
            var idMe = node_selected[0].id;

            // fix cứng thu mục video =2
            if (idPar == "#" && idMe == 2) {
                hienthidanhsach_videoduocchiase();
            }
            else {
                hienthidanhsach_Videotheothumuc();
            }

            $('#liaddnew').removeClass('active');
            $('#uploadvaothumuc').removeClass('active');
            $('#lidanhsach').addClass('active');
            $('#danhsachanhhienthi').addClass('active');

        })

            .on('create_node.jstree', function (e, data) {

                var _idcha = data.parent;
                var _tencon = data.node.text;
                jsonPost({ type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }).then(function (kq) {
             //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }, function (kq) {
                    if (kq.suscess) {
                        idtrunggian = kq.id_quanlythumuc;
                    }
                });
                $.get('?operation=create_node', { 'type': data.node.type, 'id': data.node.parent, 'text': data.node.text })
                    .done(function (d) {
                        //   data.instance.set_id(data.node, d.id);
                    })
                    .fail(function () {
                        data.instance.refresh();
                    });
            })
            .on('rename_node.jstree', function (e, data) {

                var _idthumuc = "";
                var _tenmoi = data.text;

                if (idtrunggian == "") {
                    _idthumuc = data.node.id;
                } else {
                    _idthumuc = idtrunggian;
                }
                if (!valTextboxValue(_tenmoi)) {
                    $menuthumuc.jstree(true).refresh();
                    $loading.remove();
                    common.showNotification('top', 'right', 'Tên thư mục không chứa ký tự đặc biệt !');
                }

                else {

                    swal({
                        title: 'Đổi tên thư mục ?',
                        text: "Bạn sẽ dùng tên mới này cho thư mục ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        jsonPost({ type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }).then(function (kq) {
                       // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }, function (kq) {
                            if (kq.suscess) {
                                idtrunggian = "";
                            }
                            $menuthumuc.jstree(true).refresh();
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh xóa đã bị hủy bỏ ',
                              'info'
                            )
                            $menuthumuc.jstree(true).refresh();
                        }
                    });
                }
            })
            .on('delete_node.jstree', function (e, data) {
                var _idnode = data.node.id;

                swal({
                    title: 'Xóa thư mục ?',
                    text: "Bạn có muốn xóa thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    jsonPost({ type: 'xoathumuc', _idnode: _idnode }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoathumuc', _idnode: _idnode }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });

            })
            .on('move_node.jstree', function (e, data) {
                var _idthumuc = data.node.id;
                var _idparent = data.parent;

                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ di chuyển đến thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    jsonPost({ type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                  //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
            .on('copy_node.jstree', function (e, data) {

                var _idthumuc = data.original.id;
                var _idparent = data.parent;
                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ coppy vào thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {

                    jsonPost({ type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                    //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
            .on('changed.jstree', function (e, data) {
                if (data && data.selected && data.selected.length) {
                    $.get('?operation=get_content&id=' + data.selected.join(':'), function (d) {
                        if (d && typeof d.type !== 'undefined') {
                            $('#data .content').hide();
                            switch (d.type) {
                                case 'text':
                                case 'txt':
                                case 'md':
                                case 'htaccess':
                                case 'log':
                                case 'sql':
                                case 'php':
                                case 'js':
                                case 'json':
                                case 'css':
                                case 'html':
                                    $('#data .code').show();
                                    $('#code').val(d.content);
                                    break;
                                case 'png':
                                case 'jpg':
                                case 'jpeg':
                                case 'bmp':
                                case 'gif':
                                    $('#data .image img').one('load', function () { $(this).css({ 'marginTop': '-' + $(this).height() / 2 + 'px', 'marginLeft': '-' + $(this).width() / 2 + 'px' }); }).attr('src', d.content);
                                    $('#data .image').show();
                                    break;
                                default:
                                    $('#titleFolder').html(d.content).show();
                                    break;
                            }
                        }
                    });
                }
                else {
                    $('#titleFolder').hide();
                    $('#titleFolder').html('Select a file from the tree.').show();
                }
            });
    });
}

function hienthidanhsach_Videotheothumuc() {
    $('#liaddnew').removeAttr('style');
    var node_selected = $('#dragTree').jstree('get_selected', true);
    var idPar = node_selected[0];
    var _idthumuc = idPar.id;
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdulieutrongthumuc', _idthumuc: _idthumuc }, function (kq) {
        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon' id='ext-element-22'>\
                            <span class='x-item-thumbnail'>\
                                  <div class='html5gallery' data-html5player='true' data-fancybox data-src='" + item.duongdanfile + "' data-webm='" + item.duongdanfile + "' data-title='" + item.tenfile + "'>\
                                    <img class='b-lazy b-loaded x-select-target fancybox' src='/ThuMucGoc/AnhDaiDien/logovideo.jpg' width='90px' height='90px' id='ext-element-21'>\
                                  </div>\
                            </span>\
                        </span>\
                        <input class='x-item-textbox' value='" + item.tenfile + "' readonly type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);

            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li.click(function () {
                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                    hienthidanhsach_Videotheothumuc();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };
            idex++;
        });
    });
}
function hienthidanhsach_videoduocchiase() {
    $('#liaddnew').attr('style', 'display:none')
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachvideoduocchiase' }, function (kq) {
        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon' id='ext-element-22'>\
                            <span class='x-item-thumbnail'>\
                                  <div class='html5gallery' data-html5player='true' data-fancybox data-src='" + item.duongdanfile + "' data-webm='" + item.duongdanfile + "' data-title='" + item.tenfile + "'>\
                                    <img class='b-lazy b-loaded x-select-target fancybox' src='/ThuMucGoc/AnhDaiDien/logovideo.jpg' width='90px' height='90px' id='ext-element-21'>\
                                  </div>\
                            </span>\
                        </span>\
                        <input class='x-item-textbox' value='" + item.tenfile + "' readonly type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);

            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li.click(function () {
                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };
            idex++;
        });
    });
}
function uploadthumucVideo() {
    var _idthumuc = '';
    var check = true;
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachtaikhoanadmin' }, function (danhsach) {
        $('#danhsachadmin').empty();
        $.each(danhsach.data, function (key, val) {
            $('#danhsachadmin').append(' <div class="checkbox col-xs-3"> <label><input data-idadmin="' + JSON.stringify(val.id_taikhoan) + '" id="idadmin' + val.id_taikhoan + '" type="checkbox" />' + val.taikhoan1 + '</label></div>');
        })
    });

    $('#listAdmin').change(function () {
        if ($(this).prop("checked")) {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', true);
            });
        } else {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
        }
    });

    $('#btnUploadFile').click(function () {

        _idthumuc = "";
        var node_selected = $('#dragTree').jstree('get_selected', true);
        _idthumuc = node_selected[0].id;

        var dsadminShare = new Array();
        var anhdaidien = $('#anhdaidien').val();
        var dungluong = $('#kicthuoc').text();
        var tenfile = $('#name-vid').text();

        var dscheck = $('#danhsachadmin input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });

        var fd_data = new FormData();
        fd_data.append('thongtin', JSON.stringify(dsadminShare));
        fd_data.append('type', 'uploadFileVideo');
        fd_data.append('fileanh', $('#anhdaidien')[0].files[0]);
        fd_data.append('_idthumuc', _idthumuc);
        fd_data.append('dungluong', dungluong);
        fd_data.append("stringTookenClient", stringTookenServer);


        if (anhdaidien == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn file cần upload');
        } else if (_idthumuc == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn folder');
        } else if (!valTextboxValue(tenfile)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Tên file không chứa ký tự đặc biệt ');
        }

        if (check) {

            $('.loader-parent').removeAttr('style');
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    $('.loader-parent').css('display', 'none');
                    var data = JSON.parse(kq);
                    if (data.sucess) {
                        swal('Thông báo ', data.msg, 'success')
                        $('#preview').html('');
                        $('#anhdaidien').val('');
                        $('#name-vid').html('');
                        $('#size-vid').html('');
                        $('#type-vid').html('');
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }

                }
            });
        }
    });
    $('#lidanhsach').click(function () {
        $('#lidanhsach').addClass('active');
        $('#danhsachanhhienthi').addClass('active');

        $('#liaddnew').removeClass('active');
        $('#uploadvaothumuc').removeClass('active');

        hienthidanhsach_Videotheothumuc(_idthumuc);
    });
}




//QUẢN LÝ THƯ MỤC ẢNH --xong
function initQuanLyThuMucAnh() {
    curentPage = 0;
    loadthumuc();
    loadimage();
    uploadthumucanh();
    $(".panel-left").resizable({
        handleSelector: ".splitter",
        resizeHeight: false
    });
    $(".panel-top").resizable({
        handleSelector: ".splitter-horizontal",
        resizeWidth: false
    });
    document.body.onclick = function (e) {
        if (e.srcElement.tagName != "I" && e.srcElement.id != "deleteimg" && e.srcElement.id != "renameimg") {
            $('#popuup_div').hide();
        }
    }
}
function loadthumuc() {

    $(function () {
        $(window).resize(function () {
            var h = Math.max($(window).height() - 0, 420);
            $('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
        }).resize();
        var $menuthumuc = $('#dragTree');
        var $dragTree = $('#dragTree');
        $menuthumuc.jstree({
            'core': {
                'data': {
                    'url': function (node) {
                        return node.id === '#' ? '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucanh&id_tm=0' : '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loaddanhsachthumucanh&id_tm=' + node.id;
                    },
                    'data': function (node) {
                        return { 'id': node.id };
                    }
                },
                'check_callback': function (o, n, p, i, m) {
                    if (m && m.dnd && m.pos !== 'i') { return false; }

                    if (o === "move_node" || o === "copy_node") {
                        if (this.get_node(n).parent === this.get_node(p).id) { return false; }
                    }
                    return true;
                },
                'themes': {
                    'responsive': false
                }
            },
            'sort': function (a, b) {
                return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
            },
            'contextmenu': {
                'items': function (node) {
                    var tmp = $.jstree.defaults.contextmenu.items();
                    delete tmp.create.action;

                    var node_selected = $('#dragTree').jstree('get_selected', true);
                    var _nodeGoc = node_selected[0].parent;


                    if (_nodeGoc == "#") {
                        delete tmp.rename;
                        delete tmp.remove;
                    }

                    tmp.create.label = "Thêm mới thư mục";
                    tmp.create.submenu = {
                        "create_folder": {
                            "separator_after": true,
                            "label": "Thư mục mới",
                            "action": function (data) {
                                var inst = $.jstree.reference(data.reference),
                                    obj = inst.get_node(data.reference);
                                inst.create_node(obj, { type: "default" }, "last", function (new_node) {
                                    setTimeout(function () {
                                        inst.edit(new_node);
                                    }, 0);
                                });
                            }
                        },
                        //"create_file": {
                        //    "label": "Thêm ảnh",
                        //    "action": function (data) {
                        //        var inst = $.jstree.reference(data.reference),
                        //            obj = inst.get_node(data.reference);
                        //        inst.create_node(obj, { type: "file" }, "last", function (new_node) {
                        //            setTimeout(function () { inst.edit(new_node); }, 0);
                        //        });
                        //    }
                        //}
                    };
                    if (this.get_type(node) === "file") {
                        delete tmp.create;
                    }
                    return tmp;
                }
            },
            'types': {
                'default': {
                    'icon': 'fa fa-folder'
                },
                'file': {
                    'icon': 'fa fa-file'
                }
            },
            'unique': {
                'duplicate': function (name, counter) {

                    return name + ' ' + counter;
                }
            },
            'plugins': ['state', 'dnd', 'sort', 'types', 'contextmenu', 'unique']
        }).bind('select_node.jstree', function (e, data) {
            var _idthumuc = "";
            var node_selected = $('#dragTree').jstree('get_selected', true);
            var idPar = node_selected[0].parent;
            var idMe = node_selected[0].id;


            // Fix cứng id thư mục gốc tại đây
            if (idPar == "#" && idMe == 1) {
                hienthidanhsachanhchiase();
            }
            else {
                hienthidanhsachanhtheothumuc();
            }


            $('#liaddnew').removeClass('active');
            $('#uploadvaothumuc').removeClass('active');
            $('#lidanhsach').addClass('active');
            $('#danhsachanhhienthi').addClass('active');

        })

            .on('create_node.jstree', function (e, data) {
                var _idcha = data.parent;
                var _tencon = data.node.text;

                jsonPost({ type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }).then(function (kq) {
              //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoithumuc', _idcha: _idcha, _tencon: _tencon }, function (kq) {
                    if (kq.suscess) {
                        idtrunggian = kq.id_quanlythumuc;
                    }
                });
                $.get('?operation=create_node', { 'type': data.node.type, 'id': data.node.parent, 'text': data.node.text })
                    .done(function (d) {
                    })
                    .fail(function () {
                        data.instance.refresh();
                    });
            })
            .on('rename_node.jstree', function (e, data) {

                var _idthumuc = "";
                var _tenmoi = data.text;

                if (idtrunggian == "") {
                    _idthumuc = data.node.id;
                } else {
                    _idthumuc = idtrunggian;
                }
                if (!valTextboxValue(_tenmoi)) {
                    $menuthumuc.jstree(true).refresh();
                    $loading.remove();
                    common.showNotification('top', 'right', 'Tên thư mục không chứa ký tự đặc biệt !');
                }

                else {
                    swal({
                        title: 'Đổi tên thư mục ?',
                        text: "Bạn sẽ dùng tên mới này cho thư mục ?",
                        type: 'question',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Vâng, tôi đồng ý !',
                        cancelButtonText: 'Không. cảm ơn!'
                    }).then(function () {
                        jsonPost({ type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }).then(function (kq) {
                      //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'doitenthumuc', _idthumuc: _idthumuc, _tenmoi: _tenmoi }, function (kq) {
                            if (kq.suscess) {
                                idtrunggian = "";
                            }
                            $menuthumuc.jstree(true).refresh();
                        });
                    }, function (dismiss) {
                        if (dismiss === 'cancel') {
                            swal(
                              'Hủy bỏ ',
                              'Lệnh xóa đã bị hủy bỏ ',
                              'info'
                            )
                            $menuthumuc.jstree(true).refresh();
                        }
                    });
                }
            })
            .on('delete_node.jstree', function (e, data) {
                var _idnode = data.node.id;

                swal({
                    title: 'Xóa thư mục ?',
                    text: "Bạn có muốn xóa thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    jsonPost({ type: 'xoathumuc', _idnode: _idnode }).then(function (kq) {
                  //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoathumuc', _idnode: _idnode }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });

            })
            .on('move_node.jstree', function (e, data) {
                var _idthumuc = data.node.id;
                var _idparent = data.parent;

                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ di chuyển đến thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {
                    jsonPost({ type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {

                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'dichuyenthumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
            .on('copy_node.jstree', function (e, data) {

                var _idthumuc = data.original.id;
                var _idparent = data.parent;
                swal({
                    title: 'Di chuyển thư mục ?',
                    text: "Bạn có chắc sẽ coppy vào thư mục này không ?",
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Vâng, tôi đồng ý !',
                    cancelButtonText: 'Không. cảm ơn!'
                }).then(function () {

                    jsonPost({ type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }).then(function (kq) {
                   // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'coppythumuc', _idthumuc: _idthumuc, _idparent: _idparent }, function (kq) {
                        if (kq.suscess) {
                            swal('Thông báo', kq.msg, 'success')
                        } else {
                            swal('Thông báo', kq.msg, 'error')
                        }
                        $menuthumuc.jstree(true).refresh();
                    });
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                          'Hủy bỏ ',
                          'Lệnh xóa đã bị hủy bỏ ',
                          'info'
                        )
                        $menuthumuc.jstree(true).refresh();
                    }
                });
            })
    });
}

function hienthidanhsachanhchiase() {
    $('#liaddnew').attr('style', 'display:none')
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachanhduocchiase' }, function (kq) {

        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon'><span class='x-item-thumbnail'><a class='itemimg' href='" + item.duongdanfile + "' data-fancybox='images' data-width='2048' data-height='1365' data-caption='" + item.tenfile + "'><img class='b-lazy b-loaded x-select-target fancybox' src='" + item.duongdanfile + "' width='90px' height='90px'></a></span></span><input class='x-item-textbox' value='" + item.tenfile + "' readonly  type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);

            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };

            li.click(function () {

                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            idex++;
        });

    });

}

function hienthidanhsachanhtheothumuc() {
    $('#liaddnew').removeAttr('style');
    var node_selected = $('#dragTree').jstree('get_selected', true);
    var idPar = node_selected[0];
    var _idthumuc = idPar.id;
    var tableIMG = $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdulieutrongthumuc', _idthumuc: _idthumuc }, function (kq) {
        var $ul = $("#dataimages");
        $ul.empty();
        var idex = 0;
        var check = true;

        kq.data.forEach(function (item) {

            var li = $('<li/>', {
                class: 'x-item x-layout-largeicons',
                html: "<span class='x-item-icon' id='ext-element-22'><span class='x-item-thumbnail'><a href='" + item.duongdanfile + "' data-fancybox='images' data-width='2048' data-height='1365' data-caption='" + item.tenfile + "'><img class='b-lazy b-loaded x-select-target fancybox' src='" + item.duongdanfile + "' width='90px' height='90px' id='ext-element-21'></a></span></span><input class='x-item-textbox' value='" + item.tenfile + "' readonly  type='text' data-chilimage='" + JSON.stringify(item) + "' id='tenfile" + (item.id_quanlyfileupload) + "'></input>"
            }).appendTo($ul);

            li.hover(function () {
                li.toggleClass('x-item-over');
            });
            li.click(function () {
                _idfile = item.id_quanlyfileupload;
                $ul.find('li.x-item-selected').removeClass('x-item-selected');
                li.toggleClass('x-item-selected');
                trangthaiRename = true;
                trangthaidelete = true;
            });
            li[0].oncontextmenu = function (e) {
                _idfile = item.id_quanlyfileupload;
                var height = $('#popuup_div').height();
                var width = $('#popuup_div').width();
                leftVal = e.pageX + "px";
                topVal = e.pageY + "px";
                $('#popuup_div').css({ left: leftVal, top: topVal }).show();

                $('#deleteimg').unbind("click");
                $('#deleteimg').click(function (ev) {
                    ev.preventDefault();
                    xoafile(_idfile);
                    $('#popuup_div').hide();
                });

                $('#renameimg').unbind("click");
                $('#renameimg').click(function (abc) {

                    abc.preventDefault();
                    renamefile(li);
                    $('#popuup_div').hide();
                });

                return false;
            };

            idex++;
        });
    });
}

function uploadthumucanh() {
    var _idthumuc = '';
    var check = true;
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachtaikhoanadmin' }, function (danhsach) {
        $('#danhsachadmin').empty();
        $.each(danhsach.data, function (key, val) {
            $('#danhsachadmin').append(' <div class="checkbox col-xs-3"> <label><input data-idadmin="' + JSON.stringify(val.id_taikhoan) + '" id="idadmin' + val.id_taikhoan + '" type="checkbox" />' + val.taikhoan1 + '</label></div>');
        })
    });

    $('#listAdmin').change(function () {
        if ($(this).prop("checked")) {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', true);
            });
        } else {
            var a = $('#danhsachadmin').find('input');
            $.each(a, function (key, val) {
                $(this).prop('checked', false);
            });
        }
    });

    $('#btnUploadFile').click(function () {
        _idthumuc = "";
        var node_selected = $('#dragTree').jstree('get_selected', true);
        _idthumuc = node_selected[0].id;
        var dsadminShare = new Array();
        var anhdaidien = $('#anhdaidien').val();
        var dungluong = $('#kicthuoc').text();

        var dscheck = $('#danhsachadmin input:checked');
        $.each(dscheck, function (key, val) {
            var idArrt = val.id;
            var idadm = $('#' + idArrt).data('idadmin');
            dsadminShare.push(idadm);
        });
        var tenfile = $('#name').text();


        var fd_data = new FormData();
        fd_data.append('thongtin', JSON.stringify(dsadminShare));
        fd_data.append('type', 'uploadfileanh');
        fd_data.append('fileanh', $('#anhdaidien')[0].files[0]);
        fd_data.append('_idthumuc', _idthumuc);
        fd_data.append('dungluong', dungluong);
        fd_data.append("stringTookenClient", stringTookenServer);

        if (!valTextboxValue(tenfile)) {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn file cần upload và tên file không chứa ký tự đặc biệt !');
        } else if (_idthumuc == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn folder');
        } else if (anhdaidien == "") {
            check = false;
            $loading.remove();
            common.showNotification('top', 'right', 'Mời bạn chọn file cần upload');
        }

        if (check) {
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess) {
                        swal('Thông báo ', data.msg, 'success')
                        $('#preview').html('');
                        $('#anhdaidien').val('');
                        $('#name').html('');
                        $('#size').html('');
                        $('#type').html('');
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                }
            });
        }
    });


    $('#lidanhsach').click(function () {
        $('#lidanhsach').addClass('active');
        $('#danhsachanhhienthi').addClass('active');

        $('#liaddnew').removeClass('active');
        $('#uploadvaothumuc').removeClass('active');

        hienthidanhsachanhtheothumuc(_idthumuc);
    });
}


// SỬA , XÓA FILE ẢNH ,TÀI LIỆU ,VIDEO

function xoafile(_idfile) {
    swal({
        title: 'Xóa file ?',
        text: "Bạn có muốn xóa ảnh này không ?",
        type: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Vâng, tôi đồng ý !',
        cancelButtonText: 'Không. cảm ơn!'
    }).then(function () {
        jsonPost({ type: 'xoafile', _idfile: _idfile }).then(function (kq) {
    //    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoafile', _idfile: _idfile }, function (kq) {
            if (kq.suscess) {
                swal('Thông báo ', kq.msg, 'success')

            }
            else {
                swal('Thông báo ', kq.msg, 'error')
            }
        });
        var node_selected = $('#dragTree').jstree('get_selected', true);
        var idPar = node_selected[0].parent;
        var linkWeb = window.location.pathname;
        if (idPar == "#") {
            if (linkWeb == "/quan-ly-thu-muc-video") {
                hienthidanhsach_videoduocchiase();
            } else if (linkWeb == "/quan-ly-thu-muc-anh") {
                hienthidanhsachanhchiase();
            } else {
                hienthidanhsach_Tailieuduocchiase();
            }
        }
        else {
            if (linkWeb == "/quan-ly-thu-muc-video") {
                hienthidanhsach_Videotheothumuc();
            } else if (linkWeb == "/quan-ly-thu-muc-anh") {
                hienthidanhsachanhtheothumuc();
            } else {
                hienthidanhsach_Tailieutheothumuc();
            }
        }
    }, function (dismiss) {
        if (dismiss === 'cancel') {
            swal(
              'Hủy bỏ ',
              'Lệnh xóa đã bị hủy bỏ ',
              'info'
            )
        }
    });
}

function renamefile(li) {
    var check = true;
    var iput = li.find('input');

    var idInp = iput[0].id;
    var dataIMG = $('#' + idInp).data('chilimage');

    var _idfile = dataIMG.id_quanlyfileupload;
    var _idThumuc = dataIMG.id_quanlythumuc;

    idRename = null;
    trangthaiF2 = true;
    iput.attr('readonly', false)
    iput.select();


    giatri = iput.val();
    giatritimkiem = giatri.lastIndexOf(".");
    if (giatritimkiem >= 0) {
        name = giatri.substring(0, giatritimkiem);
        duoi = giatri.substring(giatritimkiem);
    } else {
        duoi = "";
    }



    $("#" + idInp).unbind();
    $("#" + idInp).on('keyup', function (e) {
        if (e.keyCode == 13 && !iput[0].readOnly) {
            trangthaiF2 = false;
            var _tenfile = $('#' + idInp).val();

            idRename = iput[0].id;

            if (!valTextboxValue(_tenfile)) {
                $('#' + idInp).val(dataIMG.tenfile);
                check = false;
                $loading.remove();
                common.showNotification('top', 'right', "Nội dung không chứa ký tự đặc biệt !");
            }
            if (check == true) {
                var tenmoi = _tenfile + duoi;
                jsonPost({ type: 'doitenfile', _tenfile: tenmoi, _idfile: _idfile, _idThumuc: _idThumuc }).then(function (kq) {
               // $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'doitenfile', _tenfile: tenmoi, _idfile: _idfile, _idThumuc: _idThumuc }, function (kq) {
                    if (kq.suscess) {
                        iput.attr('readonly', true)
                        $('#' + idInp).removeAttr('data-chilimage');
                        dataIMG.tenfile = tenmoi;
                        $('#' + idInp).attr('chilimage', JSON.stringify(dataIMG));
                        $('#' + idInp).val(dataIMG.tenfile);
                        giatri = '';
                        giatritimkiem = '';
                        name = '';
                        duoi = '';

                        $loading.remove();
                        common.showNotification('top', 'right', kq.msg);
                    } else {
                        iput.attr('readonly', true)
                        $('#' + idInp).val(dataIMG.tenfile);
                        $loading.remove();
                        common.showNotification('top', 'right', kq.msg);
                    }
                });
            }
        }
    });
}

//LIÊN KẾT HỢP TÁC
function initLienKetHopTac() {
    curentPage = 0;
    loaddanhsachlienket();


    var button = $('#groupChosefileLKHT .buttonLKHT');
    $.each(button, function (key, val) {
        $(this).click(function () {
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });


    $('#liaddnew').click(function () {
        $('#lblLinkLKHT').text('');
        $('#previewLKHT').html('');
        $('#lblLinkLKHT1').text('');
        $('#previewLKHT1').html('');
        themmoilienkethoptac();
    });
}
function loaddanhsachlienket() {
    var $card_content = $('#danhsachlienket');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachlienkethoptac',
            html: '<thead>\
                            <th>Tên đối tác</th>\
                            <th>Link</th>\
                            <th>Hình ảnh</th>\
                            <th>Trạng thái</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachlienkethoptac').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachlienkethoptac',
            "columns": [
                  { data: "tendoitac" },
                  { data: "linkdiachi" },
                  {
                      data: "avatar",
                      render: function (url, type, full) {
                          return '<img height="80px" width="150px" src="' + url + '"/>';
                      }
                  },
                   {
                       data: "trangthai",
                       mRender: function (data) {
                           if (data == 1) {
                               data = "Chỉ lưu";
                           } else {
                               data = "Hiển thị";
                           }
                           return data;
                       }
                   },
                   {
                       data: "button", "width": "80px",
                       mRender: function (data) {
                           if (data.sua == true && data.xoa == true) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa liên kết hợp tác"></i>\
                                          <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên kết hợp tác"></i>'
                               });
                               return $dtooltip.html();
                           }
                           else if (data.xoa == true) {
                               return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa liên kết hợp tác"></i>';
                           }
                           else if (data.sua == true) {
                               return data = '<i class="fa fa-pencil-square-o iconButton btnUpdate" aria-hidden="true" rel="tooltip" title="Sửa liên kết hợp tác"></i>';
                           }
                           return data = '';
                       }
                   },
            ],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                var a = json.data[0].button.them;
                if (a == false) {
                    $('#themmoilienkethoptac').remove();
                    $('#liaddnew').remove();
                    $('#liaddnew').click(function () {
                        swal('Thông báo', 'Bạn không có quyền thực hiện chức năng này', 'warning')
                        $('#liaddnew').removeClass('active');

                    });
                } else {
                    $('#liaddnew').css("display", "block")
                }
            },
            "order": [[0, 'asc']],
            "bSort": false,
        });
        var parent = $('#tb_danhsachlienkethoptac').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachlienkethoptac').DataTable();

        table.on('click', 'i.btnUpdate', function () {

            $('#lblLinkLKHT').text('');
            $('#previewLKHT').html('');
            $('#lblLinkLKHT1').text('');
            $('#previewLKHT1').html('');

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            $('#lidanhsach').removeClass('active');
            $('#danhsachlienket').removeClass('active');

            $('#ulmenu').append('<li class="active" id="update"><a href="#suathongtinlienket" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Cập nhật thông tin liên kết hợp tác</a></li>');
            $('#frmnoidunglienket').append('<div class="tab-pane  active" id="suathongtinlienket">\
                            <form class="form-horizontal">\
                                <div class="form-group">\
                                    <label for="inputName" class="col-sm-2 control-label">Tên đối tác<span class="required-admin">*</span></label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control hide" id="idlienket" value="' + data.id_lienkethoptac + '">\
                                        <input type="text" class="form-control" id="tendoitac1" value="' + data.tendoitac + '">\
                                        <label class="control-label" id="lbl_tendoitac1"></label>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Link website<span class="required-admin">*</span></label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="linkdiachi1" value="' + data.linkdiachi + '">\
                                        <label class="control-label" id="lbl_linkdiachi1"></label>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Thông tin đối tác<span class="required-admin">*</span></label>\
                                    <div class="col-sm-10">\
                                        <textarea class="form-control" rows="3" id="thongtindoitac1">' + data.thongtindoitac + '</textarea>\
                                        <label class="control-label" id="lbl_thongtindoitac1"></label>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Hiển thị</label>\
                                    <div class="col-sm-10">\
                                       <select class="form-control" id="dropdowHienThi1">\
                                        <option id="opt1">Hiển thị trang web ở tab mới</option>\
                                        <option id="opt2">Hiển thị trang web ở tab hiện tại</option>\
                                      </select>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện cũ</label>\
                                    <div class="col-sm-10">\
                                        <img src="' + data.avatar + '" style="max-width: 300px;max-height: 200px;"/>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện</label>\
                                    <div class="col-sm-10">\
                                        <div class="row">\
                                            <div class="col-sm-12" id="groupChosefileLKHT1">\
                                                <div class="help-block">\
                                                    <button id="chosefile1" class="buttonLKHT" type="button" value="Chọn">Chọn file</button>&nbsp &nbsp Click chọn file cần sử dụng\
                                                </div>\
                                            </div>\
                                            <div class="col-sm-12" id="groupFile1" style="display: none">\
                                                <label id="lblLinkLKHT1"></label>\
                                            </div>\
                                            <div class="col-sm-12" style="padding-top: 15px">\
                                               <div class="row"> <div id="previewLKHT1" class="col-sm-6">\
                                                </div></div>\
                                            </div>\
                                        </div>\
                                    </div>\
                                </div>\
                                 <div class="form-group" id="frmtrangthai1">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Trạng thái</label>\
                                    <div class=" col-sm-10" id="frmHienthi1">\
                                        <div class="radio">\
                                            <label>\
                                                <input type="radio" name="optionsRadios" value="hienthi" checked="" id="hienthi1">Hiển thị ngay\
                                            </label>\
                                        </div>\
                                        <div class="radio" id="rdoLuunhap1">\
                                            <label>\
                                                <input type="radio" name="optionsRadios" value="luunhap" checked="true" id="luunhap1">Lưu nháp\
                                            </label>\
                                        </div>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <div class="col-sm-offset-2 col-sm-10">\
                                        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnSualienket"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>\
                                    </div>\
                                </div>\
                            </form>\
                        </div>');

            if (data.target == "_blank") {
                $('#dropdowHienThi1 option[id="opt1"]').attr("selected", "selected");
            } else {
                $('#dropdowHienThi1 option[id="opt2"]').attr("selected", "selected");
            }
            if (data.trangthai == 2) {
                $("#hienthi1").prop("checked", true);
            } else {
                $("#luunhap1").prop("checked", true);
            }
            var button1 = $('#groupChosefileLKHT1 .buttonLKHT');
            $.each(button1, function (key, val) {
                $(this).click(function () {
                    window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
                });
            });
            $('#liaddnew').click(function () {
                $('#suathongtinlienket').remove();
                $('#update').remove();
            });
            $('#lidanhsach').click(function () {
                $('#suathongtinlienket').remove();
                $('#update').remove();
            });
            sualienkethoptac(data);
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            $('#lidanhsach').removeClass('active');
            $('#danhsachlienket').removeClass('active');

            $('#ulmenu').append('<li class="active" id="delete"><a href="#xoathongtinlienket" data-toggle="tab" aria-expanded="false"><i class="fa fa-trash-o iconTab"></i>Xóa thông tin liên kết hợp tác</a></li>');
            $('#frmnoidunglienket').append('<div class="tab-pane  active" id="xoathongtinlienket">\
                            <form class="form-horizontal">\
                                <div class="form-group">\
                                    <label for="inputName" class="col-sm-2 control-label">Tên đối tác</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control hide" id="idlienket2" value="' + data.id_lienkethoptac + '">\
                                        <input type="text" class="form-control" id="tendoitac2" value="' + data.tendoitac + '">\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Link website</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="linkdiachi2" value="' + data.linkdiachi + '">\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Thông tin đối tác</label>\
                                    <div class="col-sm-10">\
                                        <textarea class="form-control" rows="3" id="thongtindoitac2">' + data.thongtindoitac + '</textarea>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Hiển thị</label>\
                                    <div class="col-sm-10">\
                                       <select class="form-control" id="dropdowHienThi2">\
                                        <option id="opt1">Hiển thị trang web ở tab mới</option>\
                                        <option id="opt2">Hiển thị trang web ở tab hiện tại</option>\
                                      </select>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Ảnh đại diện cũ</label>\
                                    <div class="col-sm-10">\
                                        <img src="' + data.avatar + '"/>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <div class="col-sm-offset-2 col-sm-10">\
                                        <button type="button" class="btn btn-primary btn-flat IconButtonPage" id="btnXoalienket"><i class="fa fa-trash-o iconButtonPage"></i>Xóa liên kết</button>\
                                    </div>\
                                </div>\
                            </form>\
                        </div>');

            if (data.target == "_blank") {
                $('#dropdowHienThi2 option[id="opt1"]').attr("selected", "selected");
            } else {
                $('#dropdowHienThi2 option[id="opt2"]').attr("selected", "selected");
            }
            $('#liaddnew').click(function () {
                $('#xoathongtinlienket').remove();
                $('#delete').remove();
            });

            $('#lidanhsach').click(function () {
                $('#xoathongtinlienket').remove();
                $('#delete').remove();
            });
            xoalienkethoptac();
        });
    }
}
function xoalienkethoptac() {
    var table = $('#tb_danhsachlienkethoptac').DataTable();
    $('#btnXoalienket').click(function () {

        var id = $('#idlienket2').val();
        var tendoitac = $('#tendoitac2').val();
        var linkdiachi = $('#linkdiachi2').val();
        var thongtindoitac = $('#thongtindoitac2').val();

        var thongtin = {
            id: id,
            tendoitac: tendoitac,
            linkdiachi: linkdiachi,
            thongtindoitac: thongtindoitac
        };

        $('#btnXoalienket').attr('disabled', 'true');
        swal({
            title: 'Xóa thông tin liên kết',
            text: "Bạn có muốn xóa liên kết hợp tác này không ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            jsonPost({ type: 'xoathongtinlienket', thongtin: JSON.stringify(thongtin) }).then(function (kq) {
                if (kq.sucess) {
                    swal('Thông báo ', kq.msg, 'success')
                    $('#xoathongtinlienket').remove();
                    $('#delete').remove();
                    $('#lidanhsach').addClass('active');
                    $('#danhsachlienket').addClass('active');
                }
                else {
                    swal('Thông báo ', kq.msg, 'error')
                }
                $('.loader-parent').css('display', 'none');
                $('#btnXoalienket').removeAttr('disabled');
                table.ajax.reload();
            });
        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh xóa đã bị hủy bỏ ',
                  'info'
                )
            }
            $('#btnXoalienket').removeAttr('disabled');
            $('.loader-parent').css('display', 'none');
        });
    });
}
function sualienkethoptac(data) {
    var trangthai = "";
    $('#btnSualienket').click(function () {
        var check = true;

        var id = $('#idlienket').val();
        var tendoitac = $('#tendoitac1').val();
        var linkdiachi = $('#linkdiachi1').val();
        var thongtindoitac = $('#thongtindoitac1').val();

        var avatar = $('#lblLinkLKHT1').text();
        var target = $("#dropdowHienThi1")[0].selectedIndex;
        trangthai = $("#frmHienthi1 input[type='radio']:checked").val();

        if (avatar == "") {
            avatar = data.avatar;
        } else {
            avatar = avatar;
        }
        if (!valTextboxValue(tendoitac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!validateURL(linkdiachi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập link website liên kết !');
            return check == false;
        }
        else if (!valTextboxValue(thongtindoitac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập thông tin đối tác và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh !');
            return check == false;
        }
        else {

            var thongtin = {
                id: id,
                tendoitac: tendoitac,
                linkdiachi: linkdiachi,
                thongtindoitac: thongtindoitac,
                avatar: avatar,
                target: target,
                trangthai: trangthai
            };
            var table = $('#tb_danhsachlienkethoptac').DataTable();
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtinlienkethoptac');
            fd_data.append("stringTookenClient", stringTookenServer);

            $('#btnSualienket').attr('disabled', 'true');
            swal({
                title: 'Cập nhật thông tin',
                text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            swal('Thông báo ', data.msg, 'success')
                            $('#update').remove();
                            $('#suathongtinlienket').remove();
                            $('#lidanhsach').addClass('active');
                            $('#danhsachlienket').addClass('active');
                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnSualienket').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh cập nhật đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnSualienket').removeAttr('disabled');
            });
        }

    });
}
function themmoilienkethoptac() {
    var trangthai = "";
    $('#btnThemmoilienket').click(function () {

        var tendoitac = $('#tendoitac').val();
        var linkdiachi = $('#linkdiachi').val();
        var thongtindoitac = $('#thongtindoitac').val();
        var avatar = $('#lblLinkLKHT').text();
        var target = $("#dropdowHienThi")[0].selectedIndex;
        trangthai = $("#frmHienthi input[type='radio']:checked").val();

        var check = true;

        if (!valTextboxValue(tendoitac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!validateURL(linkdiachi)) {
            common.showNotification('top', 'right', 'Mời bạn nhập link website liên kết !');
            return check == false;
        }
        else if (!valTextboxValue(thongtindoitac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập thông tin đối tác và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (avatar == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh !');
            return check == false;
        }
        else {
            var thongtin = {
                tendoitac: tendoitac,
                linkdiachi: linkdiachi,
                thongtindoitac: thongtindoitac,
                avatar: avatar,
                target: target,
                trangthai: trangthai
            };
            var table = $('#tb_danhsachlienkethoptac').DataTable();
            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoilienkethoptac');
            fd_data.append("stringTookenClient", stringTookenServer);

            $('#btnThemmoilienket').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                $.ajax({
                    type: "POST",
                    url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                    data: fd_data,
                    contentType: false,
                    processData: false,
                    success: function (kq) {
                        var data = JSON.parse(kq);
                        if (data.sucess) {
                            $('#tendoitac').val('');
                            $('#linkdiachi').val('');
                            $('#thongtindoitac').val('');

                            $('#previewLKHT').html('');
                            $('#lblLinkLKHT').text('');
                            $('#frmHienthi option[id="luunhap"]').attr("selected", "selected");

                            swal('Thông báo ', data.msg, 'success')

                        } else {
                            swal('Thông báo ', data.msg, 'error')
                        }
                        $('.loader-parent').css('display', 'none');
                        $('#btnThemmoilienket').removeAttr('disabled');
                        table.ajax.reload();
                    }
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoilienket').removeAttr('disabled');
            });
        }
    });
}


// DANH SÁCH CHỨC VỤ

function initDanhSachChucVu() {
    curentPage = 0;
    $('#liaddnew').click(function () {
        $('#themmoichucvu').addClass('active');
        $('#tenchucvu').val('');
    });
    $('#lidanhsach').click(function () {
        $('#liaddnew').css('display', 'block');
        $('#lidetails').css('display', 'none');

        $('#tenchucvu').val('');
    });


    loadalldanhsachchucvu();
    themmoichucvucanbo();
    taodanhsachchucvucanbodeluachon();
}
function loadalldanhsachchucvu() {
    var $card_content = $('#danhsachchucvu');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachchucvu',
            html: '<thead>\
                            <th></th>\
                            <th>Tên chức vụ</th>\
                            <th></th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachchucvu').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=loadalldanhsachchucvucuacanbo',
            "columns": [
                 { data: "idParents" },
                 { data: "tenchucvu" },
                 {
                     data: "button",
                     mRender: function (data) {
                         if (data.sua == true) {
                             var $dtooltip = $('<div/>', {
                                 html: '<button type="button" rel="tooltip" title="Sửa thông tin" class="btn btn-block btn-success btnUpdate" data-toggle="modal" data-target="#myModal">Sửa</button>'
                             });
                             return $dtooltip.html();
                         }
                         return data = '';
                     }
                 },
            ],
            "columnDefs": [
            {
                "targets": [0],
                "visible": false,
                "searchable": false
            },
            ],
            "pagingType": "full_numbers",
            "order": [[0, 'asc']],
            initComplete: function (settings, json) {
                var a = json.data[0].button.them;
                if (a == false) {
                    $('#themmoicanbo').remove();
                    $('#liaddnew').remove();
                    $('#liaddnew').click(function () {
                        swal('Thông báo', 'Bạn không có quyền thực hiện chức năng này', 'warning')
                        $('#liaddnew').removeClass('active');

                    });
                } else {
                    $('#liaddnew').css("display", "block")
                }
            },
        });
        var parent = $('#tb_danhsachchucvu').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachchucvu').DataTable();
        table.on('click', 'button.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_chucvu = data.id_chucvu;
            $('#frmButtonCanbo').empty();
            $('#frmButtonCanbo').append('<button type="button" class="btn btn-danger" id="suathongtincanbo">Chỉnh sửa thông tin</button>');

            $('#lidetails').addClass('active');
            $('#lidetails').css('display', 'block');
            $('#themmoichucvu').addClass('active');
            $('#liaddnew').css('display', 'none');

            $('#lidanhsach').removeClass('active');
            $('#danhsachchucvu').removeClass('active');

            $('#tenchucvu').val(data.tenchucvu);

            suatenchucvucanbo(id_chucvu);
        });
    }
}

function suatenchucvucanbo(id_chucvu) {

    var table = $('#tb_danhsachchucvu').DataTable();
    $('#suathongtincanbo').click(function () {

        var check = true;
        var tenchucvu = $('#tenchucvu').val();
        if (!valTextboxValue(tenchucvu)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên chức vụ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else {
            var thongtin = {
                id_chucvu: id_chucvu,
                tenchucvu: tenchucvu
            };

            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhattenchucvucanbo');
            fd_data.append("stringTookenClient", stringTookenServer);
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess) {
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    table.ajax.reload();
                }
            });
        }
    });
}
function themmoichucvucanbo() {

    $('#frmButtonCanbo').empty();
    $('#frmButtonCanbo').append('<button type="button" class="btn btn-danger" id="btnThemmoicanbo">Thêm mới chức vụ</button>');

    $('#btnThemmoicanbo').click(function () {
        var table = $('#tb_danhsachchucvu').DataTable();
        var check = true;

        var tenchucvu = $('#tenchucvu').val();
        var id_chucvu = $('#chucvu option:selected').attr('id');

        if (!valTextboxValue(tenchucvu)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên chức vụ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (id_chucvu == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn chức vụ cấp trên gần nhất !');
            return check == false;
        }
        else {
            var thongtin = {
                tenchucvu: tenchucvu,
                id_chucvu: id_chucvu
            };

            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoichucvucanbotrongcoquan');
            fd_data.append("stringTookenClient", stringTookenServer);
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.suscess) {
                        swal('Thông báo ', data.msg, 'success')
                        $('#tenchucvu').val('');

                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    table.ajax.reload();
                }
            });
        }
    });
}
function taodanhsachchucvucanbodeluachon() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachchucvulanhdao' }, function (data) {
        $.each(data, function (key, val) {
            $('#chucvu').append('<option id="' + val.id_chucvu + '">' + val.tenchucvu + '</option>');
        })
    });
}


//DANH SÁCH CÁN BỘ
function initCanBoLanhDao() {
    curentPage = 0;
    loaddaanhsachquanham();
    loaddanhsachdonvicongtac();
    loaddanhsachchucvu();
    var button = $('#groupChosefileCanBo .buttonCanBo');
    $.each(button, function (key, val) {
        $(this).click(function () {
            window.open(window.location.origin + "/file-images", "Chọn file upload", "height=600,width=1000");
        });
    });
    $('#liaddnew').click(function () {
        $('#themmoicanbo').addClass('active');
        $('#tencanbo').val('');
        $('#donvicongtac').val('');
        $('#thongtinlienhe').val('');
        $('#quanham').val('');
        $('#quequan').val('');
        $('#lblLinkCanBo').text('');
        $('#previewCanBo').html('');
        $('#ngaysinh').val('');
        $('#frmHienthi option[id="hienthi"]').attr("selected", "selected");
    });
    $('#lidanhsach').click(function () {
        $('#liaddnew').css('display', 'block');
        $('#lidetails').css('display', 'none');

        $('#tencanbo').val('');
        $('#donvicongtac').val('');
        $('#thongtinlienhe').val('');
        $('#quanham').val('');
        $('#quequan').val('');
        $('#lblLinkCanBo').text('');
        $('#previewCanBo').html('');
        $('#ngaysinh').val('');
        $('#frmHienthi option[id="hienthi"]').attr("selected", "selected");
    });


    danhsachcanbolanhdao();
    themmoicanbolanhdao();
}

function danhsachcanbolanhdao() {
    var $card_content = $('.box-body');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachcanbo',
            html: '<thead>\
  <th></th>\
                            <th>Họ tên</th>\
                            <th>Chức vụ</th>\
                            <th>Cơ quan</th>\
                            <th>Ảnh đại diện</th>\
                            <th></th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachcanbo').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachcanbolanhdao',
            "columns": [
                 { data: "idparent" },
                  { data: "gioithieu" },
                   { data: "tenchucvu" },
                  { data: "donvicongtac" },
                  {
                      data: "anhdaidien",
                      render: function (url, type, full) {
                          return '<img height="80px" width="80px" src="' + url + '"/>';
                      }
                  },
                  {
                      data: "button",
                      mRender: function (data) {
                          if (data.sua == true && data.xoa == true) {
                              var $dtooltip = $('<div/>', {
                                  html: '<button type="button" rel="tooltip" title="Sửa thông tin" class="btn btn-block btn-success btnUpdate" data-toggle="modal" data-target="#myModal">Sửa</button>\
                                          <button type="button" rel="tooltip" title="Xóa thông tin"  class="btn btn-block btn-danger btnDelete" data-toggle="modal" data-target="#myModal">Xóa</button>'
                              });
                              return $dtooltip.html();
                          }
                          else if (data.xoa == true) {
                              return data = '<button type="button" rel="tooltip" title="Xóa thông tin"  class="btn btn-block btn-danger btnDelete" data-toggle="modal" data-target="#myModal">Xóa</button>';
                          }
                          else if (data.sua == true) {
                              return data = '<button type="button" rel="tooltip" title="Sửa thông tin" class="btn btn-block btn-success btnUpdate" data-toggle="modal" data-target="#myModal">Sửa</button>';
                          }
                          return data = '';
                      }
                  },
            ],
            "columnDefs": [
            {
                "targets": [0],
                "visible": false,
                "searchable": false
            },
            ],
            "pagingType": "full_numbers",
            "order": [[0, 'asc']],
            initComplete: function (settings, json) {
                var a = json.data[0].button.them;
                if (a == false) {
                    $('#themmoicanbo').remove();
                    $('#liaddnew').remove();
                    $('#liaddnew').click(function () {
                        swal('Thông báo', 'Bạn không có quyền thực hiện chức năng này', 'warning')
                        $('#liaddnew').removeClass('active');

                    });
                } else {
                    $('#liaddnew').css("display", "block")
                }
            },
        });
        var parent = $('#tb_danhsachcanbo').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachcanbo').DataTable();
        table.on('click', 'button.btnUpdate', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_dscanbo = data.id_dscanbo;
            var ngaythang = data.ngaysinh.substring(0, 10);
            $('#frmButtonCanbo').empty();
            $('#frmButtonCanbo').append('<button type="button" class="btn btn-danger" id="suathongtincanbo">Chỉnh sửa thông tin</button>');

            $('#lidetails').addClass('active');
            $('#lidetails').css('display', 'block');
            $('#themmoicanbo').addClass('active');
            $('#liaddnew').css('display', 'none');

            $('#lidanhsach').removeClass('active');
            $('#danhsachcanbo').removeClass('active');

            $('#tencanbo').val(data.tencanbo);
            $('#donvicongtac').val(data.donvicongtac);
            $('#thongtinlienhe').val(data.thongtinlienhe);
            $('#quanham').val(data.quanham);
            $('#ngaysinh').val(ngaythang);
            $('#quequan').val(data.quequan);
            $('#lblLinkCanBo').text(data.anhdaidien);
            $('#previewCanBo').html("<img src='" + data.anhdaidien + "' width='200px' height='100px' />");
            $('#chucvu option[id="' + data.id_chucvu + '"]').attr("selected", "selected");

            if (data.trangthaicanbo == 2) {
                $("#hienthi").prop("checked", true);
            } else {
                $("#luunhap").prop("checked", true);
            }
            suathongtincanbo(id_dscanbo);
        });
        table.on('click', 'button.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();
            var id_canbo = data.id_dscanbo;

            swal({
                title: 'Xóa thông tin cán bộ ?',
                text: "Bạn có muốn xóa thông tin về cán bộ này không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                jsonPost({ type: 'xoathongtincanbo', id_canbo: id_canbo }).then(function (kq) {
              //  $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoathongtincanbo', id_canbo: id_canbo }, function (kq) {
                    if (kq.sucess) {
                        swal('Thông báo ', kq.msg, 'success')
                    }
                    else {
                        swal('Thông báo ', kq.msg, 'error')
                    }
                });
                table.ajax.reload();
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh xóa đã bị hủy bỏ ',
                      'info'
                    )
                }
            });
        });
    }
}

function suathongtincanbo(id_dscanbo) {

    var trangthaicanbo = "";
    var table = $('#tb_danhsachcanbo').DataTable();
    $('#suathongtincanbo').click(function () {

        var check = true;

        var tencanbo = $('#tencanbo').val();
        var id_chucvu = $('#chucvu option:selected').attr('id');
        var donvicongtac = $('#donvicongtac').val();
        var thongtinlienhe = $('#thongtinlienhe').val();
        var quanham = $('#quanham').val();
        var ngaysinh = $('#ngaysinh').val();
        var quequan = $('#quequan').val();
        var anhdaidien = $('#lblLinkCanBo').text();
        trangthaicanbo = $("#frmHienthi input[type='radio']:checked").val();

        if (!validateHoTen(tencanbo)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (id_chucvu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập chức vụ của cán bộ !');
            return check == false;
        }
        else if (!valTextboxValue(donvicongtac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập đợn vị công tác của cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(thongtinlienhe)) {
            common.showNotification('top', 'right', 'Mời bạn nhập thông tin giới thiệu về cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(quanham)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quân hàm của cán bộ !');
            return check == false;
        }
        else if (ngaysinh == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày sinh của cán bộ !');
            return check == false;
        }

        else if (!valTextboxValue(quequan)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quê quán của cán bộ !');
            return check == false;
        }
        else if (anhdaidien == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện của cán bộ !');
            return check == false;
        }
        else {
            var thongtin = {
                tencanbo: tencanbo,
                id_chucvu: id_chucvu,
                donvicongtac: donvicongtac,
                thongtinlienhe: thongtinlienhe,
                quanham: quanham,
                ngaysinh: ngaysinh,
                quequan: quequan,
                anhdaidien: anhdaidien,
                trangthaicanbo: trangthaicanbo,
                id_dscanbo: id_dscanbo
            };

            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'capnhatthongtincanbo');
            fd_data.append("stringTookenClient", stringTookenServer);
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.sucess) {
                        swal('Thông báo ', data.msg, 'success')
                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    table.ajax.reload();
                }
            });
        }
    });
}


function themmoicanbolanhdao() {
    var trangthaicanbo = "";

    $('#frmButtonCanbo').empty();
    $('#frmButtonCanbo').append('<button type="button" class="btn btn-danger" id="btnThemmoicanbo">Thêm mới cán bộ</button>');

    $('#btnThemmoicanbo').click(function () {
        var table = $('#tb_danhsachcanbo').DataTable();
        var check = true;

        var tencanbo = $('#tencanbo').val();
        var id_chucvu = $('#chucvu option:selected').attr('id');
        var donvicongtac = $('#donvicongtac').val();
        var thongtinlienhe = $('#thongtinlienhe').val();
        var quanham = $('#quanham').val();
        var ngaysinh = $('#ngaysinh').val();
        var quequan = $('#quequan').val();
        var anhdaidien = $('#lblLinkCanBo').text();
        trangthaicanbo = $("#frmHienthi input[type='radio']:checked").val();

        if (!validateHoTen(tencanbo)) {
            common.showNotification('top', 'right', 'Mời bạn nhập tên cán bộ và không chứa ký tự đặc biệt!');
            return check == false;
        }
        else if (id_chucvu == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập chức vụ của cán bộ !');
            return check == false;
        }
        else if (!valTextboxValue(donvicongtac)) {
            common.showNotification('top', 'right', 'Mời bạn nhập đợn vị công tác của cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(thongtinlienhe)) {
            common.showNotification('top', 'right', 'Mời bạn nhập thông tin giới thiệu về cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (!valTextboxValue(quanham)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quân hàm của cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (ngaysinh == "") {
            common.showNotification('top', 'right', 'Mời bạn nhập ngày sinh của cán bộ !');
            return check == false;
        }

        else if (!valTextboxValue(quequan)) {
            common.showNotification('top', 'right', 'Mời bạn nhập quê quán của cán bộ và không chứa ký tự đặc biệt !');
            return check == false;
        }
        else if (anhdaidien == "") {
            common.showNotification('top', 'right', 'Mời bạn chọn ảnh đại diện của cán bộ !');
            return check == false;
        }
        else {
            var thongtin = {
                tencanbo: tencanbo,
                id_chucvu: id_chucvu,
                donvicongtac: donvicongtac,
                thongtinlienhe: thongtinlienhe,
                quanham: quanham,
                ngaysinh: ngaysinh,
                quequan: quequan,
                anhdaidien: anhdaidien,
                trangthaicanbo: trangthaicanbo
            };

            var fd_data = new FormData();
            fd_data.append('thongtin', JSON.stringify(thongtin));
            fd_data.append('type', 'themmoicanbolanhdao');
            fd_data.append("stringTookenClient", stringTookenServer);
            $.ajax({
                type: "POST",
                url: "/SourceAdmin/ashx/XuLyAdmin.ashx",
                data: fd_data,
                contentType: false,
                processData: false,
                success: function (kq) {
                    var data = JSON.parse(kq);
                    if (data.suscess) {
                        swal('Thông báo ', data.msg, 'success')
                        $('#tencanbo').val('');
                        $('#donvicongtac').val('');
                        $('#thongtinlienhe').val('');
                        $('#quanham').val('');
                        $('#quequan').val('');
                        $('#lblLinkCanBo').text('');
                        $('#previewCanBo').html('');
                        $('#ngaysinh').val('');
                        $('#frmHienthi option[id="hienthi"]').attr("selected", "selected");

                    } else {
                        swal('Thông báo ', data.msg, 'error')
                    }
                    table.ajax.reload();
                }
            });
        }
    });
}

function loaddaanhsachquanham() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'loaddaanhsachquanham' }, function (arrayOBJ) {
        var $lsquanham = $('#lsquanham');
        $('#quanham').keyup(function () {
            $lsquanham.empty();
            for (i = 0; i < arrayOBJ.length; i++) {
                var child = arrayOBJ[i];
                var option = document.createElement('option');
                option.value = child.quanham;
                option.id = child.id_capbac;
                var att = document.createAttribute("data-json");
                att.value = JSON.stringify(child);
                option.setAttributeNode(att);
                lsquanham.appendChild(option);
            }
        }).on('input', function () {
            var val = this.value;
            if ($lsquanham.find('option').filter(function () {
                return this.value.toUpperCase() === val.toUpperCase();
            }).length) {
            }
        });
    });
}
function loaddanhsachdonvicongtac() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachdonvicongtac' }, function (arrayOBJDVCT) {
        var $dsdonvicongtac = $('#dsdonvicongtac');
        $('#donvicongtac').keyup(function () {
            $dsdonvicongtac.empty();
            for (i = 0; i < arrayOBJDVCT.length; i++) {
                var child = arrayOBJDVCT[i];
                var option = document.createElement('option');
                option.value = child.donvicongtac;
                option.id = child.id_donvi;
                var att = document.createAttribute("data-json");
                att.value = JSON.stringify(child);
                option.setAttributeNode(att);
                dsdonvicongtac.appendChild(option);
            }
        }).on('input', function () {
            var val = this.value;
            if ($dsdonvicongtac.find('option').filter(function () {
                return this.value.toUpperCase() === val.toUpperCase();
            }).length) {
            }
        });
    });
}
function loaddanhsachchucvu() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachchucvulanhdao' }, function (data) {
        $.each(data, function (key, val) {
            $('#chucvu').append('<option id="' + val.id_chucvu + '">' + val.tenchucvu + '</option>');
        })
    });
}


//QUẢN LÝ TÀI KHOẢN
function initTaiKhoan() {
    curentPage = 0;
    danhsachnhomquyen();
    danhsachtaikhoanadmin();
    themmoiadmin();
}
function themmoiadmin() {
    $('#btnThemmoi').click(function () {

        var pathname = window.location.pathname;
        var tendangnhap = $('#taikhoan').val();
        var tendaydu = $('#tendaydu').val();
        var matkhau = $('#makhau').val();
        var email = $('#emailadmin').val();
        var idnhomquanly = $('#dropDownList option:selected').attr('id');

        var check = true;

        if (!validateTaikhoan(tendangnhap)) {
            $('#lbl_taikhoan').html("Tài khoản không chứa ký tự đặc biệt và lớn hơn 6 ký tự");
            return check == false;
        } else {
            $('#lbl_taikhoan').html("");
        }
        if (!validateAcountAdmin(matkhau)) {
            $('#lbl_matkhau').html("Mật khẩu phải chứa ký tự đặc biệt, chữ in hoa và lớn hơn 10 ký tự !");
            return check == false;
        } else {
            $('#lbl_matkhau').html("");
        }
        if (!validateHoTen(tendaydu)) {
            $('#lbl_tendaydu').html("Mời nhập họ tên và không chứa ký tự đặc biệt");
            return check == false;
        } else {
            $('#lbl_tendaydu').html("");
        }

        if (!isEmailAdmin(email)) {
            $('#lbl_email').html("Nhập email sai định dạng");
            return check == false;
        } else {
            $('#lbl_email').html("");
        }
        if (check == true) {
            var thongtin = {
                tendangnhap: tendangnhap,
                matkhau: matkhau,
                email: email,
                idnhomquanly: idnhomquanly,
                tendaydu: tendaydu
            };

            var table = $('#tb_danhsachtk').DataTable();
            $('#btnThemmoi').attr('disabled', 'true');
            swal({
                title: 'Thêm mới thông tin',
                text: "Bạn có chắc sẽ thêm mới thông tin như trên không ?",
                type: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Vâng, tôi đồng ý !',
                cancelButtonText: 'Không. cảm ơn!'
            }).then(function () {
                $('.loader-parent').removeAttr('style');
                jsonPost({ type: 'themmoiadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }).then(function (danhsach) {
                    //     $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'themmoiadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }, function (danhsach) {
                    if (danhsach.sucess == true) {
                        $('#taikhoan').val('');
                        $('#tendaydu').val('');
                        $('#makhau').val('');
                        $('#emailadmin').val('');
                        swal('Thông báo ', danhsach.msg, 'success')
                        table.ajax.reload();
                    }
                    else {
                        swal('Thông báo ', danhsach.msg, 'error')
                    }
                    $('.loader-parent').css('display', 'none');
                    $('#btnThemmoi').removeAttr('disabled');
                });
            }, function (dismiss) {
                if (dismiss === 'cancel') {
                    swal(
                      'Hủy bỏ ',
                      'Lệnh thêm mới đã bị hủy bỏ ',
                      'info'
                    )
                }
                $('.loader-parent').css('display', 'none');
                $('#btnThemmoi').removeAttr('disabled');
            });

        }
    });
}
function danhsachnhomquyen() {
    $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachnhomquyen' }, function (danhsach) {
        $.each(danhsach.data, function (key, val) {
            $('#dropDownList').append('<option id="' + val.id_nhomadmin + '">' + val.tennhom + '</option>');
        })
    });
}
function danhsachtaikhoanadmin() {
    var $card_content = $('.box-body');
    $card_content.addClass('table-responsive no-padding');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover ',
            id: 'tb_danhsachtk',
            html: '<thead>\
                            <th>Tài khoản</th>\
                            <th>Nhóm</th>\
                            <th>Chức năng</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachtk').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachtaikhoanadmin',
            "columns": [
                  { data: "taikhoan1" },
                  { data: "tennhom" },
                   {
                       data: "button", "width": "105px",
                       mRender: function (data) {
                           if (data.sua == true && data.xoa == true) {
                               var $dtooltip = $('<div/>', {
                                   html: '<i class="fa fa-pencil-square-o iconButton btnSelect" aria-hidden="true" rel="tooltip" title="Thay đổi nhóm quản lý"></i>\
                                          <i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa tài khoản"></i>'
                               });
                               return $dtooltip.html();
                           }
                           else if (data.sua == true) {
                               return data = '<i class="fa fa-pencil-square-o iconButton btnSelect" aria-hidden="true" rel="tooltip" title="Thay đổi nhóm quản lý"></i>';
                           }
                           else if (data.xoa == true) {
                               return data = '<i class="fa fa-trash-o iconButton btnDelete" aria-hidden="true" rel="tooltip" title="Xóa tài khoản"></i>';
                           }

                           return data = '';
                       }
                   },
            ],
            "bSort": false,
            "order": [[0, 'asc']],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
            },
        });
        var parent = $('#tb_danhsachtk').parent().addClass('box-body table-responsive no-padding');
        var table = $('#tb_danhsachtk').DataTable();
        table.on('click', 'i.btnSelect', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();

            $('#lidanhsach').removeClass('active');
            $('#danhsachtaikhoan').removeClass('active');

            $('#ulmenu').append('<li class="active" id="update"><a href="#suataikhoan" data-toggle="tab" aria-expanded="false"><i class="fa fa-edit iconTab"></i>Sửa quyền quản lý</a></li>');
            $('#frmnoidung').append('<div class="tab-pane  active" id="suataikhoan">\
                            <form class="form-horizontal">\
                                <div class="form-group">\
                                    <label for="inputName" class="col-sm-2 control-label">Tài khoản</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="account" value="' + data.taikhoan1 + '" disabled>\
                                         <label class="control-label" id="lbl_taikhoan"></label>\
                                    </div>\
                                </div>\
                                 <div class="form-group" style="display:none">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Họ và tên</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="fullname" value="' + data.tendaydu + '">\
                                         <label class="control-label" id="lbl_tendaydu"></label>\
                                    </div>\
                                </div>\
                                 <div class="form-group" style="display:none">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="mailadd" value="' + data.email + '">\
                                         <label class="control-label" id="lbl_email"></label>\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Nhóm quản lý</label>\
                                    <div class="col-sm-10">\
                                        <select class="form-control" id="dropDownList2">\
                                        </select>\
                                    </div>\
                                </div>\
                                <div class="form-group" >\
                                   <div class="col-sm-offset-2 col-sm-5">\
                                        <button type="button" class="btn btn-block btn-primary btn-flat IconButtonPage" id="btnsuathongtin"><i class="fa fa-save iconButtonPage"></i>Lưu thông tin</button>\
                                    </div>\
                                </div>\
                            </form>\
                        </div>');
            $('#liaddnew').click(function () {
                $('#suataikhoan').remove();
                $('#update').remove();
            });

            $('#lidanhsach').click(function () {
                $('#suataikhoan').remove();
                $('#update').remove();
            });
            $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'danhsachnhomquyen' }, function (danhsach) {
                $.each(danhsach.data, function (key, val) {
                    $('#dropDownList2').append('<option id="' + val.id_nhomadmin + '">' + val.tennhom + '</option>');
                    $('#dropDownList2 option[id="' + data.id_nhomadmin + '"]').attr("selected", "selected");
                })
            });
            thaydoiquyenquanlyadmin();
        });
        table.on('click', 'i.btnDelete', function () {

            var closestRow = $(this).closest('tr');
            var data = table.row(closestRow).data();

            $('#lidanhsach').removeClass('active');
            $('#danhsachtaikhoan').removeClass('active');

            $('#ulmenu').append('<li class="active" id="delete"><a href="#xoataikhoan" data-toggle="tab" aria-expanded="false"><i class="fa fa-trash-o iconTab"></i>Xóa tài khoản</a></li>');
            $('#frmnoidung').append('<div class="tab-pane  active" id="xoataikhoan">\
                            <form class="form-horizontal">\
                                <div class="form-group">\
                                    <label for="inputName" class="col-sm-2 control-label">Tài khoản</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="account" value="' + data.taikhoan1 + '">\
                                    </div>\
                                </div>\
                                 <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Họ và tên</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="fullname" value="' + data.tendaydu + '">\
                                    </div>\
                                </div>\
                                 <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="mailadd" value="' + data.email + '">\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Số điện thoại</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="sdt" value="' + data.sodienthoai + '">\
                                    </div>\
                                </div>\
                                <div class="form-group">\
                                    <label for="inputEmail" class="col-sm-2 control-label">Nhóm quản lý</label>\
                                    <div class="col-sm-10">\
                                        <input type="text" class="form-control" id="nhomql" value="' + data.tennhom + '">\
                                    </div>\
                                </div>\
                                <div class="form-group" >\
                                   <div class="col-sm-offset-2 col-sm-5">\
                                        <button type="button" class="btn btn-block btn-primary btn-flat IconButtonPage" id="btnxoataikhoan"><i class="fa fa-trash-o iconButtonPage"></i>Đồng ý xóa</button>\
                                    </div>\
                                </div>\
                            </form>\
                        </div>');
            $('#liaddnew').click(function () {
                $('#xoataikhoan').remove();
                $('#delete').remove();
            });

            $('#lidanhsach').click(function () {
                $('#xoataikhoan').remove();
                $('#delete').remove();
            });
            xoataikhoanadmin();
        });
    }

}
function thaydoiquyenquanlyadmin() {
    $('#btnsuathongtin').click(function () {
        var tendangnhap = $('#account').val();
        var email = $('#mailadd').val();
        var idnhomquanly = $('#dropDownList2 option:selected').attr('id');
        var tendaydu = $('#fullname').val();

        var pathname = window.location.pathname;

        var thongtin = {
            tendangnhap: tendangnhap,
            email: email,
            idnhomquanly: idnhomquanly,
            tendaydu: tendaydu
        };
        var table = $('#tb_danhsachtk').DataTable();
        $("#btnsuathongtin").attr("disabled", 'true');
        swal({
            title: 'Cập nhật thông tin',
            text: "Bạn có chắc sẽ cập nhật thông tin như trên không ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            jsonPost({ type: 'suathongtintaikhoanadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }).then(function (kq) {
            //$.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'suathongtintaikhoanadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }, function (kq) {
                if (kq.sucess) {
                    swal('Thông báo ', kq.msg, 'success')
                    table.ajax.reload();
                }
                else {
                    swal('Thông báo ', kq.msg, 'success')
                }
                $('.loader-parent').css('display', 'none');
                $('#btnsuathongtin').removeAttr('disabled');
            });
        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh cập nhật đã bị hủy bỏ ',
                  'info'
                )
            }
            $('.loader-parent').css('display', 'none');
            $('#btnsuathongtin').removeAttr('disabled');
        });
    });
}
function xoataikhoanadmin() {
    $('#btnxoataikhoan').click(function () {
        var tendangnhap = $('#account').val();
        var email = $('#mailadd').val();
        var pathname = window.location.pathname;

        var thongtin = {
            tendangnhap: tendangnhap,
            email: email,
        };
        var table = $('#tb_danhsachtk').DataTable();
        $('#btnxoataikhoan').attr('disabled', 'true');
        swal({
            title: 'Cấm hoạt động ?',
            text: "Tài khoản này vi phạm.Bạn có muốn cấm hoạt động ?",
            type: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Vâng, tôi đồng ý !',
            cancelButtonText: 'Không. cảm ơn!'
        }).then(function () {
            $('.loader-parent').removeAttr('style');
            jsonPost({ type: 'xoataikhoanadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }).then(function (kq) {
         //   $.getJSON('/SourceAdmin/ashx/XuLyAdmin.ashx', { type: 'xoataikhoanadmin', thongtin: JSON.stringify(thongtin), pathname: pathname }, function (kq) {
                if (kq.sucess) {
                    swal('Thông báo ', kq.msg, 'success')
                    table.ajax.reload();
                    $('#xoataikhoan').remove();
                    $('#delete').remove();
                    $('#lidanhsach').addClass('active');
                    $('#danhsachtaikhoan').addClass('active');
                }
                else {
                    swal('Thông báo ', kq.msg, 'error')
                }
                $('.loader-parent').css('display', 'none');
                $('#btnxoataikhoan').removeAttr('disabled');
            });
        }, function (dismiss) {
            if (dismiss === 'cancel') {
                swal(
                  'Hủy bỏ ',
                  'Lệnh cấm hoạt động đã bị hủy bỏ ',
                  'info'
                )
            }
            $('.loader-parent').css('display', 'none');
            $('#btnxoataikhoan').removeAttr('disabled');
        });
    });
}

// TRANG CHU ADMIN
function initQuyenHanAdmin() {
    curentPage = 0;
    danhsachquyen();
}
function danhsachquyen() {
    var $card_content = $('.box-body');
    if (curentPage == 0) {
        $card_content.empty();
        $table = $('<table />', {
            class: 'table table-bordered table-hover',
            id: 'tb_danhsachquyenadmin',
            html: '<thead>\
                            <th>Tên menu</th>\
                            <th>Xem</th>\
                            <th>Thêm</th>\
                            <th>Sửa</th>\
                            <th>Xóa</th>\
                        </thead><tbody></tbody>\
                        <tfoot></tfoot>'
        }).appendTo($card_content);
        $('#tb_danhsachquyenadmin').DataTable({
            ajax: '/SourceAdmin/ashx/XuLyAdmin.ashx?type=danhsachquyen',
            "columns": [
                  { data: "tenmenu" },
                  {
                      data: "xem",
                      mRender: function (data) {
                          if (data == true) {
                              return "Có";
                          } else {
                              return "Không";
                          }
                      }
                  },
                  {
                      data: "them",
                      mRender: function (data) {
                          if (data == true) {
                              return "Có";
                          } else {
                              return "Không";
                          }
                      }
                  },
                  {
                      data: "sua",
                      mRender: function (data) {
                          if (data == true) {
                              return "Có";
                          } else {
                              return "Không";
                          }
                      }
                  },
                  {
                      data: "xoa",
                      mRender: function (data) {
                          if (data == true) {
                              return "Có";
                          } else {
                              return "Không";
                          }
                      }
                  },
            ],
            "bSort": false,
            "order": [[0, 'asc']],
            "pagingType": "full_numbers",
            initComplete: function (settings, json) {
                if (json.data = "") {
                    window.location.reload();
                }
            },
        });
        var parent = $('#tb_danhsachquyenadmin').parent().addClass('box-body table-responsive no-padding');
    }
}

// HIỂN THỊ ẢNH VỪA CHỌN
function loadimage() {

    $("#anhdaidien").change(function () {
        renderImage(this.files[0])
    });
    $("#anhdaidien1").change(function () {
        renderImage1(this.files[0])
    });
}
function humanFileSize(bytes, si) {
    var thresh = si ? 1000 : 1024;
    if (bytes < thresh) return bytes + ' B';
    var units = si ? ['kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'] : ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
    var u = -1;
    do {
        bytes /= thresh;
        ++u;
    } while (bytes >= thresh);
    return bytes.toFixed(1) + ' ' + units[u];
}
function renderImage(file) {
    var reader = new FileReader();
    reader.onload = function (event) {
        the_url = event.target.result
        $('#preview').html("<img src='" + the_url + "' width='200px' height='100px' />")
        $('#name').html("Tên ảnh : " + file.name)
        $('#size').html("Dung lượng : " + humanFileSize(file.size, "MB"))
        $('#type').html("Kiểu ảnh : " + file.type)
        $('#kicthuoc').html(humanFileSize(file.size, "MB"))
    }
    reader.readAsDataURL(file);
}

function humanFileSize1(bytes, si) {
    var thresh = si ? 1000 : 1024;
    if (bytes < thresh) return bytes + ' B';
    var units = si ? ['kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'] : ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
    var u = -1;
    do {
        bytes /= thresh;
        ++u;
    } while (bytes >= thresh);
    return bytes.toFixed(1) + ' ' + units[u];
}
function renderImage1(file) {
    var reader = new FileReader();
    reader.onload = function (event) {
        the_url = event.target.result
        $('#preview1').html("<img src='" + the_url + "' width='100px' height='100px' />")
        $('#name1').html("Tên ảnh : " + file.name)
        $('#size1').html("Dung lượng : " + humanFileSize1(file.size, "MB"))
        $('#type1').html("Kiểu ảnh : " + file.type)
        $('#kicthuoc1').html(humanFileSize(file.size, "MB"))
    }
    reader.readAsDataURL(file);
}


//HIỂN THỊ VIDEO

if (window.File && window.FileReader && window.FileList && window.Blob) {
    function humanFileSizeVideo(bytes, si) {
        var thresh = si ? 1000 : 1024;
        if (bytes < thresh) return bytes + ' B';
        var units = si ? ['kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'] : ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
        var u = -1;
        do {
            bytes /= thresh;
            ++u;
        } while (bytes >= thresh);
        return bytes.toFixed(1) + ' ' + units[u];
    }
    function renderVideo(file) {
        var reader = new FileReader();
        reader.onload = function (event) {
            the_url = event.target.result
            $('#preview').html("<video width='400' controls><source id='vid-source' src='" + the_url + "' type='video/mp4'></video>")
            $('#name-vid').html(file.name)
            $('#size-vid').html("Dung lượng : " + humanFileSizeVideo(file.size, "MB"))
            $('#type-vid').html("Kiểu file : " + file.type)
            $('#kicthuoc').html(humanFileSizeVideo(file.size, "MB"))
            $('.loader-parent').css('display', 'none');
        }
        if (file.type.indexOf('video') == 0 || file.type.indexOf('audio') == 0) {
            reader.readAsDataURL(file);
        } else {
            $('.loader-parent').css('display', 'none');

            $('#name-vid').html(file.name)
            $('#size-vid').html("Dung lượng : " + humanFileSizeVideo(file.size, "MB"))
            $('#type-vid').html("Kiểu file : " + file.type)
            $('#kicthuoc').html(humanFileSizeVideo(file.size, "MB"))
        }

    }
    function loadvideo() {
        $("#anhdaidien").change(function () {
            $('.loader-parent').removeAttr('style');
            renderVideo(this.files[0])
        });
    }

    function loadFileOther() {
        $("#anhdaidien").change(function () {
            renderFileOther(this.files[0])

        });
    }
    function renderFileOther(file) {
        var reader = new FileReader();
        reader.onload = function (event) {
            the_url = event.target.result
            $('#name-vid').html(file.name)
            $('#size-vid').html("Dung lượng : " + humanFileSizeVideo(file.size, "MB"))
            $('#kicthuoc').html(humanFileSizeVideo(file.size, "MB"))
        }
        reader.readAsDataURL(file);
    }

} else {
    alert('Trình duyệt không hỗ trợ plugins');
}

function jsonPost(data) {
   
    return new Promise(function (resolve, reject) {
        var frm = new FormData();
        Object.keys(data).map(function (key, index) {
            frm.append(key, data[key]);
        });
        frm.append("stringTookenClient", stringTookenServer);
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
        xhr.open("POST", "/SourceAdmin/ashx/XuLyAdmin.ashx", true);
        xhr.setRequestHeader("Cache-Control", "no-cache");
        xhr.send(frm);
    });
}
