CKEDITOR.plugins.add('document',
{
    init: function (editor) {
        var pluginName = 'document';
        editor.ui.addButton('document',
            {
                label: 'Chọn file từ máy tính',
                command: 'upload',
                icon: CKEDITOR.plugins.getPath('document') + 'icons/document.png'
            });
        var cmd = editor.addCommand('upload', { exec: showMyDialog });
    }
});
function showMyDialog(e) {
    e.setData();
    $.getJSON('/ashx/pword.ashx', { type: 'ReadQQ' }, function (data) {
        var $body = $(data.stream);
        //var style = e.document.createElement('style');
        //style.setHtml($($body[2]).html());
        //e.insertElement(style);
        var div = e.document.createElement('div');
        div.setHtml($($body[3]).html());
        e.insertElement(div);
        
    });
}