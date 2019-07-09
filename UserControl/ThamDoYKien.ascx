<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ThamDoYKien.ascx.cs" Inherits="UserControl_ThamDoYKien" %>

<div class="widget">
    <div class="title-catalog clearfix">
        <h2>THĂM DÒ Ý KIẾN</h2>
    </div>
    <%--   <div id="owl-question" class="owl-carousel owl-theme owl-question">
    </div>--%>

    <div id="owl-question" class="owl-carousel owl-theme owl-question">
        <asp:Repeater ID="RepeaterThamDoYkien" runat="server" OnItemDataBound="RepeaterThamDoYkien_ItemDataBound">
            <ItemTemplate>
                <div class="item">
                    <div class="widget-border widget-bg" id="frmCauTraLoi">
                        <h3 class="question"><b id="titleQues" runat="server"><%#Eval("cauhoi") %></b></h3>
                        <%# Eval("id_hinhthuctraloi").ToString()=="3"?"<textarea class='form-control' rows='5' placeholder='Enter ...'></textarea>": "" %>
                        <div>
                            <asp:Repeater ID="RepeaterCauTraLoi" runat="server">
                                <ItemTemplate>
                                    <%#Eval("id_hinhthuctraloi").ToString()=="1" ? "<div class='radio'><label><input type='radio' name='optionsRadios' id='optionsRadios"+Eval("id_dapanthamdo")+"' value='"+Eval("id_dapanthamdo")+"'>"+Eval("noidungtraloi")+" </label></div>" : "<div class='checkbox'><label><input id='checkbox"+Eval("id_dapanthamdo")+"' value='"+Eval("id_dapanthamdo")+"' type='checkbox'>"+Eval("noidungtraloi")+"</div>"  %>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <button id="btnabcabc<%#Eval("id_cauhoithamdo") %>" class="btn-vote" onclick="GetThongTin(<%#Eval("id_cauhoithamdo") %>,this)" type="button" name="btnBinhchon">Bình chọn</button>
                        <button id="xemkq<%#Eval("id_cauhoithamdo") %>" data-idques="<%#Eval("id_cauhoithamdo") %>" class="btn-view-result" onclick="XemThongKe(<%#Eval("id_cauhoithamdo") %>,this)" type="button" name="btnVote">Xem kết quả</button>
                        <div style="padding-top: 10px; text-align: center">
                            <label class="lblKQ"></label>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
<script type="text/javascript">
    function setdata(idControl, value) {
        $('#' + idControl).append("<h4>" + value + "</h4>");
    }
</script>
<%--<script type="text/javascript">
    $(document).ready(function () {
        $.getJSON('/SourceClient/ashx/Clientxuly.ashx', { type: 'LoadDanhSachThamDoYKien' }, function (data) {
            if (data.data != null) {
                $.each(data.data, function (i, v) {
                    if (v.id_hinhthuctraloi == 3) {
                        $('#owl-question').empty();
                        $('#owl-question').append('<div class="owl-wrapper-outer"><div class="owl-wrapper" style="width: 3320px; left: 0px; display: block;"><div class="owl-item" style="width: 332px;"><div class="item"><div class="widget-border widget-bg" id="frmCauTraLoi"><h3 class="question"><b>' + v.cauhoi + '</b></h3><textarea class="form-control" rows="5" placeholder="Enter ..."></textarea><button id="btnabcabc' + v.id_cauhoithamdo + '" class="btn-vote" onclick="GetThongTin(' + v.id_cauhoithamdo + ',this)" type="button"  name="btnBinhchon">Bình chọn</button><button id="xemkq' + v.id_cauhoithamdo + '" data-idques="' + v.id_cauhoithamdo + '" class="btn-view-result" onclick="XemThongKe(' + v.id_cauhoithamdo + ',this)" type="button" name="btnVote">Xem kết quả</button><div style="padding-top: 10px; text-align: center"><label class="lblKQ"></label></div></div></div> </div></div> </div>');
                    } else if (v.id_hinhthuctraloi == 1) {
                        $('#owl-question').append('<div class="owl-wrapper-outer"><div class="owl-wrapper" style="width: 3320px; left: 0px; display: block;"><div class="owl-item" style="width: 332px;"><div class="item"><div class="widget-border widget-bg" id="frmCauTraLoi"><h3 class="question"><b>' + v.cauhoi + '</b></h3><div id="da' + v.id_cauhoithamdo + '"></div><button id="btnabcabc' + v.id_cauhoithamdo + '" class="btn-vote" onclick="GetThongTin(' + v.id_cauhoithamdo + ',this)" type="button"  name="btnBinhchon">Bình chọn</button><button id="xemkq' + v.id_cauhoithamdo + '" data-idques="' + v.id_cauhoithamdo + '" class="btn-view-result" onclick="XemThongKe(' + v.id_cauhoithamdo + ',this)" type="button" name="btnVote">Xem kết quả</button><div style="padding-top: 10px; text-align: center"><label class="lblKQ"></label></div></div></div></div></div> </div>');
                        $.each(v.danhsachcautraloi, function (k, n) {
                            $('#da' + v.id_cauhoithamdo).append('<div class="radio"><label><input type="radio" name="optionsRadios" id="optionsRadios' + n.id_dapanthamdo + '" value="' + n.id_dapanthamdo + '"/>' + n.noidungtraloi + '</label></div>');
                        });
                    } else {
                        $('#owl-question').append('<div class="owl-wrapper-outer"><div class="owl-wrapper" style="width: 3320px; left: 0px; display: block;"><div class="owl-item" style="width: 332px;"><div class="item"><div class="widget-border widget-bg" id="frmCauTraLoi"><h3 class="question"><b>' + v.cauhoi + '</b></h3><div id="da' + v.id_cauhoithamdo + '"></div><button id="btnabcabc' + v.id_cauhoithamdo + '" class="btn-vote" onclick="GetThongTin(' + v.id_cauhoithamdo + ',this)" type="button"  name="btnBinhchon">Bình chọn</button><button id="xemkq' + v.id_cauhoithamdo + '" data-idques="' + v.id_cauhoithamdo + '" class="btn-view-result" onclick="XemThongKe(' + v.id_cauhoithamdo + ',this)" type="button" name="btnVote">Xem kết quả</button>\<div style="padding-top: 10px; text-align: center"><label class="lblKQ"></label></div></div></div></div></div> </div>');

                        $.each(v.danhsachcautraloi, function (x, y) {
                            $('#da' + v.id_cauhoithamdo).append('<div class="checkbox"><label><input type="checkbox"  id="checkbox' + y.id_dapanthamdo + '" value="' + y.id_dapanthamdo + '"/>' + y.noidungtraloi + '</label></div>');
                        });
                    }
                });
            } else {
                $('#owl-question').append('<h3>Không có câu hỏi</h3>');
            }
        });
    });
</script>--%>

