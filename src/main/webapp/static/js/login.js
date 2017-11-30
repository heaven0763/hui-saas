$(function() {
    var $dialog = $('#logindialog');
    var $formBody = $('#dcontent');
    
    $dialog.dialog({
        height: 300,
        width: 500,
        resizable:false,
        content: $formBody.show(),
        noheader: true,
        buttons: [{
                id: 'loginBtn',
                text: '&nbsp;&nbsp;&nbsp;&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;&nbsp;&nbsp;&nbsp;',
                width:100,
                iconCls:'',
                handler:function(){
                	if($("#form-body").form('validate')){
                		$("#form-body").submit();
                	}
                }
            }]
    });
    $formBody.after($('#logo').show());
    $(window).resize(function() {
        $dialog.panel("move",{top:$(document).scrollTop() + ($(window).height()-150) * 0.5,
        						left:$(document).scrollLeft()+($(window).width()-500) * 0.5});
        $(".window-shadow").remove();
    });
});