<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ThoiTietGiaVang.ascx.cs" Inherits="UserControl_ThoiTietGiaVang" %>

<div class="widget">
    <div class="title-catalog clearfix">
        <h2>TIỆN ÍCH</h2>
    </div>
    <div class="weather">
        <div class="ttp clearfix">
            <ul>
                <li><b>Tỉnh/ Thành phố</b></li>
                <li>
                    <select class="form-control-ttp" onchange="loadthoitiet(this.value);" id="thoitiet">
                        <option value="2347703">Bến Tre</option>
                        <option value="2347704">Cao Bằng</option>
                        <option value="2347707">Hải Phòng</option>
                        <option value="2347708">Lai Châu</option>
                        <option value="2347709">Lâm Đồng</option>
                        <option value="2347710">Long An</option>
                        <option value="2347711">Quảng Nam</option>
                        <option value="2347712">Quảng Ninh</option>
                        <option value="2347713">Sơn La</option>
                        <option value="2347714">Tây Ninh</option>
                        <option value="2347715">Thanh Hóa</option>
                        <option value="2347716">Thái Bình</option>
                        <option value="2347717">Tiền Giang</option>
                        <option value="2347718">Lạng Sơn</option>
                        <option value="2347719">An Giang</option>
                        <option value="2347720">Đắc Nông</option>
                        <option value="2347721">Đồng Nai</option>
                        <option value="2347722">Đồng Tháp</option>
                        <option value="2347723">Kiên Giang</option>
                        <option value="2347727" selected="selected">Hà Nội</option>
                        <option value="2347728">TP.Hồ Chí Minh</option>
                        <option value="2347729">Bà Rịa - Vũng Tầu</option>
                        <option value="2347730">Bình Định</option>
                        <option value="2347731">Bình Thuận</option>
                        <option value="2347732">Cần Thơ</option>
                        <option value="2347733">Gia Lại</option>
                        <option value="audi">Audi</option>
                        <option value="2347734">Hà Giang</option>
                        <option value="2347735">Hà Tây</option>
                        <option value="2347736">Hà Tĩnh</option>
                        <option value="2347737">Hòa Bình</option>
                        <option value="2347738">Khánh Hòa</option>
                        <option value="2347740">Lào Cai</option>
                        <option value="2347741">Hà Nam</option>
                        <option value="2347742">Nghệ An</option>
                        <option value="2347743">Ninh Bình</option>
                        <option value="2347744">Ninh Thuận</option>
                        <option value="2347745">Phú Yên</option>
                        <option value="2347746">Quảng Bình</option>
                        <option value="2347747">Quảng Trị</option>
                        <option value="2347748">Sóc Trăng</option>
                        <option value="2347749">Thừa - Thiên - Hếu</option>
                        <option value="2347750">Trà Vinh</option>
                        <option value="2347751">Tuyên Quang</option>
                        <option value="2347752">Vĩnh Long</option>
                        <option value="2347753">Yên Bái</option>
                        <option value="20070076">Kon Tum</option>
                        <option value="20070077">Quảng Ngãi</option>
                        <option value="20070078">Bình Dương</option>
                        <option value="20070079">Hưng Yên</option>
                        <option value="20070080">Hải Dương</option>
                        <option value="20070081">Bạc Liêu</option>
                        <option value="20070082">Cà mau</option>
                        <option value="20070083">Thái Nguyên</option>
                        <option value="20070084">Bắc Cạn</option>
                        <option value="20070085">Đà Nẵng</option>
                        <option value="20070086">Bình Phước</option>
                        <option value="20070087">Bắc Giang</option>
                        <option value="20070088">Bắc Ninh</option>
                        <option value="20070089">Nam Định</option>
                        <option value="20070090">Vĩnh Phúc</option>
                        <option value="20070091">Phú Thọ</option>
                        <option value="28301718">Điện Biên</option>
                        <option value="28301719">Đắc Nông</option>
                        <option value="28301720">Hậu Giang</option>
                    </select>
                </li>
            </ul>
        </div>
        <div id="featured-info" class="featured-info clearfix">
            <h3 id="city" class="city"></h3>
            <div id="status" class="status">
                <div id="temp" class="temp clearfix">
                    <span id="iconw" class="ic-weather classimg"></span>
                    <p id="temphuidity" class="abc">
                        <span id="dc" class="dc"></span>
                        <span id="humidity" class="humidity"><i class="widget fa-thermometer-full "></i></span>
                    </p>
                </div>
                <p id="note" class="note"></p>
                <p id="dnote" class="note"></p>
            </div>
            
        </div>

        <ul id="listing" class="listing clearfix">
        </ul>
    </div>
    <div class="gia-vang">
    </div>

    <div class="ti-gia">
        <h2><b>Giá Vàng / Tỉ Giá</b></h2>
        <iframe id="fr33" style="border: none;" src="//www.tygia.com/api2.php?auto=1&amp;change=0&amp;flag=1&amp;column=2&amp;titlecolor=333333&amp;upcolor=008800&amp;downcolor=aa0000&amp;textcolor=333333&amp;gbcolor=ffffff&amp;title=0&amp;chart=0&amp;gold=1&amp;rate=1&amp;ngoaite=USD,JPY,EUR,GBP,AUD&amp;expand=0&amp;color=B4D0D0&amp;nganhang=VIETCOM&amp;fontsize=80&amp;css=%23SJC_N_ng{display:%20table-row%20!important;}%23wgold{display:none}" width="100%" height="250"></iframe>
    </div>
</div>
