function jsonPost(data) {
    return new Promise(function (resolve, reject) {
        var frm = new FormData();
        Object.keys(data).map(function (key, index) {
            frm.append(key, data[key]);
        });
       // frm.append("stringTooken", data[key]);
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



function thu() {
    var thongtin = {
        tenbieudo: "abc",
        id_donvitg: 1,
        trangthai: 2,
        id_loaibieudo: 2,
        tuthoigian: '11/12/2017',
        denthoigian: '12/12/2017',
    }
    var data = {
        thongtin: JSON.stringify(thongtin),
        type: ""
    };

    jsonPost(data).then(function (result) {
        console.log(result)
    });

}