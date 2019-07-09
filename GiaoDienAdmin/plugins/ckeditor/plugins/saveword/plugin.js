CKEDITOR.plugins.add('saveword',
{
    init: function (editor) {
        var pluginName = 'saveword';
        editor.ui.addButton('saveword',
            {
                label: 'Lưu thành word',
                command: 'saveword',
                icon: CKEDITOR.plugins.getPath('saveword') + 'icons/word.ico'
            });
        var cmd = editor.addCommand('saveword', { exec: saveword });
    }
});

function saveword(e) {
    open = function (verb, url,data, target) {
        var form = document.createElement("form");
        form.action = url;
        form.method = verb;
        form.target = target || "_self";
        //var fd = new FormData();
        //fd.append('txt', data);
        //form.params = { FormData: fd };
        var input = document.createElement("textarea");
        input.name = 'txt';
        input.value = data;
        form.appendChild(input);
        form.style.display = 'none';
        document.body.appendChild(form);
        form.submit();
    };
    var html = $('<html/>', {
        html: '<head></head><body>' + e.getData() + '</body>'
    });
    open('POST', window.location.origin + '/ashx/pword.ashx?type=ConvertHtmlToWord', e.getData(), '_blank');
    //$.ajax({
    //    url: '/ashx/pword.ashx',
    //    data: fd,
    //    processData: false,
    //    contentType: false,
    //    type: 'POST',
    //    success: function (data) {
    //        //alert(data);
    //    }
    //});
}