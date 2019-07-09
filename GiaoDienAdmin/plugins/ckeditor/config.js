/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
    
	// %REMOVE_START%
	// The configuration options below are needed when running CKEditor from source files.
    config.plugins = 'dialogui,html5validation,dialog,a11yhelp,about,video,button,toolbar,floatpanel,notification,basicstyles,bidi,blockquote,clipboard,codemirror,lineutils,widget,codesnippet,panelbutton,panel,colorbutton,colordialog,menu,contextmenu,dialogadvtab,div,elementspath,enterkey,entities,popup,filebrowser,find,fakeobjects,flash,floating-tools,floatingspace,listblock,richcombo,font,format,forms,googledocs,horizontalrule,htmlwriter,iframe,image,imagebrowser,imagepaste,indent,indentblock,indentlist,justify,menubutton,language,link,list,liststyle,magicline,newpage,pagebreak,pastefromexcel,pastefromword,pastetext,pbckcode,preview,print,removeformat,resize,save,scayt,selectall,showblocks,showborders,smiley,sourcearea,specialchar,stylescombo,tab,table,tabletools,tabletoolstoolbar,templates,undo,uploadcare,filetools,notificationaggregator,uploadwidget,uploadimage,wenzgmap,wysiwygarea,youtube';
	config.skin = 'office2013';
	// %REMOVE_END%
	config.language = 'vi';
	config.uiColor = '#778eb2';
	config.height = 400;
	config.fullPage = true;
	config.extraPlugins = 'video';
	config.extraPlugins = 'codemirror,preview,selectall,googledocs,eqneditor,html5validation,wordcount,htmlwriter,undo,uploadimage';
    // config.newpage_html = '<p>&nbsp;</p><p><span style="color:#d3d3d3">Content edited with the </span><a href="https://4html.net/Online-HTML-Editor-Text-to-HTML-Converter-870.html" style="text-decoration:none;"><span style="color:#add8e6"> Free Online HTML Editor</span></a><span style="color:#add8e6">.</span><span style="color:#d3d3d3"> Powered by 4html.net &copy; 2016</span></p>'; 
 //   config.filebrowserGoogledocsUploadUrl = 'https://4html.net/documentUpload.php';
   // config.filebrowserGoogledocsBrowseUrl = 'https://4html.net/documentsList.php';
	config.baseFloatZIndex = 9000;
	config.allowedContent = true;
  //  config.filebrowserUploadUrl = "ashx/uploadFile.ashx";
   // config.imageBrowser_listUrl = "ashx/imagebrowser.ashx?type=getlistUrl";
    // add new custom plugin document

    config.codemirror = {

    // Set this to the theme you wish to use (codemirror themes)
    theme: 'xq-light',

    // Whether or not you want to show line numbers
    lineNumbers: true,

    // Whether or not you want to use line wrapping
    lineWrapping: true,

    // Whether or not you want to highlight matching braces
    matchBrackets: true,

    // Whether or not you want tags to automatically close themselves
    autoCloseTags: true,

    // Whether or not you want Brackets to automatically close themselves
    autoCloseBrackets: true,

    // Whether or not to enable search tools, CTRL+F (Find), CTRL+SHIFT+F (Replace), CTRL+SHIFT+R (Replace All), CTRL+G (Find Next), CTRL+SHIFT+G (Find Previous)
    enableSearchTools: true,

    // Whether or not you wish to enable code folding (requires 'lineNumbers' to be set to 'true')
    enableCodeFolding: true,

    // Whether or not to enable code formatting
    enableCodeFormatting: true,

    // Whether or not to automatically format code should be done when the editor is loaded
    autoFormatOnStart: true,

    // Whether or not to automatically format code should be done every time the source view is opened
    autoFormatOnModeChange: true,

    // Whether or not to automatically format code which has just been uncommented
    autoFormatOnUncomment: true,

    // Define the language specific mode 'htmlmixed' for html including (css, xml, javascript), 'application/x-httpd-php' for php mode including html, or 'text/javascript' for using java script only
    mode: 'htmlmixed',

    // Whether or not to show the search Code button on the toolbar
    showSearchButton: true,

    // Whether or not to show Trailing Spaces
    showTrailingSpace: true,

    // Whether or not to highlight all matches of current word/selection
    highlightMatches: true,

    // Whether or not to show the format button on the toolbar
    showFormatButton: true,

    // Whether or not to show the comment button on the toolbar
    showCommentButton: true,

    // Whether or not to show the uncomment button on the toolbar
    showUncommentButton: true,
  

    // Whether or not to show the showAutoCompleteButton button on the toolbar
    showAutoCompleteButton: true,
    // Whether or not to highlight the currently active line
    styleActiveLine: true
};
    //config.wordcount = {

    //    // Whether or not you want to show the Word Count
    //    showWordCount: true,

    //    // Whether or not you want to show the Char Count
    //    showCharCount: true,

    //    // Maximum allowed Word Count
    //    maxWordCount: 4,

    //    // Maximum allowed Char Count
    //    maxCharCount: 10
    //};
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
};

