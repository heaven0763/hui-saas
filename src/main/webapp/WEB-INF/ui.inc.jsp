<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
%>

<!-- bootstrap css -->
<link href="${staticPath}/public/hplus/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/animate.min.css" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/style.min862f.css?v=4.1.0" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet"> 
<link href="${staticPath}/public/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
<!-- bootstrap -->
<!-- Morris -->
<link href="${staticPath}/public/hplus/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<!-- Gritter -->
<link href="${staticPath}/public/hplus/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">
<!-- sweetalert -->
<link href="${staticPath}/public/hplus/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
<!-- laydate -->
<link href="${staticPath}/public/hplus/js/plugins/layer/laydate/need/laydate.css" rel="stylesheet">
<link href="${staticPath}/public/hplus/js/plugins/layer/laydate/skins/default/laydate.css" id="LayDateSkin" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/plugins/clockpicker/clockpicker.css" rel="stylesheet">
<link href="${staticPath}/public/hplus/css/plugins/datapicker/datapicker3.css" rel="stylesheet">
<!-- orris -->
<link href="${staticPath}/public/hplus/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<!-- blueimp Gallery -->
<link href="${staticPath}/public/hplus/css/plugins/blueimp/css/blueimp-gallery.min.css" rel="stylesheet">
 <%-- 自定义样式 --%>
<link rel="stylesheet" href="${staticPath}/static/plugins/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="${staticPath}/static/plugins/kindeditor-4.1.10/plugins/code/prettify.css" />
    
    
<!-- bootstrap js -->
<script src="${staticPath}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.js"></script> 
<script src="${staticPath}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${staticPath}/public/js/jquery.form.js"></script>
<script src="${staticPath}/public/js/jquery.base64.js"></script>
<script src="${staticPath}/public/js/jquery.scrollTo.min.js"></script>

<script src="${staticPath}/public/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/layer/layer.min.js"></script>
<script src="${staticPath}/public/hplus/js/hplus.min.js?v=4.1.0"></script>
<script src="${staticPath}/public/hplus/js/contabs.min.js" type="text/javascript" ></script>
<script src="${staticPath}/public/hplus/js/plugins/pace/pace.min.js"></script>

<script src="${staticPath}/public/hplus/js/content.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/iCheck/icheck.min.js"></script>

<script src="${staticPath}/public/bootstrap/js/bootstrap-table.min.js"></script>
<script src="${staticPath}/public/bootstrap/js/locale/bootstrap-table-zh-CN.min.js"></script>

<script src="${staticPath}/public/hplus/js/plugins/validate/jquery.validate.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/validate/messages_zh.min.js"></script>
<script src="${staticPath}/public/hplus/js/demo/form-validate-demo.min.js"></script>
<script src="${staticPath}/public/js/bootstrap.dialog.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>

<script src="${staticPath}/public/hplus/js/plugins/layer/laydate/laydate.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/clockpicker/clockpicker.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/datapicker/bootstrap-datepicker.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>
<!-- bootstrap end-->


<!--ueditor  -->
<script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.all.min.js"> </script>
 <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
 <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
 <script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
 
 <!--kindeditor  -->
<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/kindeditor.js"></script>
<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/plugins/code/prettify.js"></script>
 


<!-- tool -->
<script src="${staticPath}/public/js/js.extend.js"></script>
<script src="${staticPath}/public/js/bsj.js"></script>
<script src="${staticPath}/public/js/common.delegate.js"></script>
<script src="${staticPath}/public/js/common/LocalResizeIMG.js"></script>
<script src="${staticPath}/public/js/common/mobileBUGFix.mini.js"></script>
<script src="${staticPath}/static/js/util.date.js"></script>
<script src="${staticPath}/static/js/common.js"></script>
<!-- tool end-->
<script type="text/javascript">
<!--
	jQuery.fn.bootstrapTable.defaults.idField = 'id';
	jQuery.fn.bootstrapTable.defaults.pagination = true;
	jQuery.fn.bootstrapTable.defaults.sidePagination = 'server';
	jQuery.fn.bootstrapTable.defaults.smartDisplay = false;
	jQuery.fn.bootstrapTable.defaults.cache = false;
	jQuery.fn.bootstrapTable.defaults.method = 'post';
	jQuery.fn.bootstrapTable.defaults.striped = true;
	jQuery.fn.bootstrapTable.defaults.contentType = 'application/x-www-form-urlencoded';
	
	var formatJson = function(json, options) {
	    var reg = null,
	        formatted = '',
	        pad = 0,
	        PADDING = '    '; // one can also use '\t' or a different number of spaces
	  
	    // optional settings
	    options = options || {};
	    // remove newline where '{' or '[' follows ':'
	    options.newlineAfterColonIfBeforeBraceOrBracket = (options.newlineAfterColonIfBeforeBraceOrBracket === true) ? true : false;
	    // use a space after a colon
	    options.spaceAfterColon = (options.spaceAfterColon === false) ? false : true;
	  
	    // begin formatting...
	    if (typeof json !== 'string') {
	        // make sure we start with the JSON as a string
	        json = JSON.stringify(json);
	    } else {
	        // is already a string, so parse and re-stringify in order to remove extra whitespace
	        json = JSON.parse(json);
	        json = JSON.stringify(json);
	    }
	  
	    // add newline before and after curly braces
	    reg = /([\{\}])/g;
	    json = json.replace(reg, '\r\n$1\r\n');
	  
	    // add newline before and after square brackets
	    reg = /([\[\]])/g;
	    json = json.replace(reg, '\r\n$1\r\n');
	  
	    // add newline after comma
	    reg = /(\,)/g;
	    json = json.replace(reg, '$1\r\n');
	  
	    // remove multiple newlines
	    reg = /(\r\n\r\n)/g;
	    json = json.replace(reg, '\r\n');
	  
	    // remove newlines before commas
	    reg = /\r\n\,/g;
	    json = json.replace(reg, ',');
	  
	    // optional formatting...
	    if (!options.newlineAfterColonIfBeforeBraceOrBracket) {        
	        reg = /\:\r\n\{/g;
	        json = json.replace(reg, ':{');
	        reg = /\:\r\n\[/g;
	        json = json.replace(reg, ':[');
	    }
	    if (options.spaceAfterColon) {         
	        reg = /\:/g;
	        json = json.replace(reg, ': ');
	    }
	  
	    $.each(json.split('\r\n'), function(index, node) {
	        var i = 0,
	            indent = 0,
	            padding = '';
	  
	        if (node.match(/\{$/) || node.match(/\[$/)) {
	            indent = 1;
	        } else if (node.match(/\}/) || node.match(/\]/)) {
	            if (pad !== 0) {
	                pad -= 1;
	            }
	        } else {
	            indent = 0;
	        }
	  
	        for (i = 0; i < pad; i++) {
	            padding += PADDING;
	        }
	  
	        formatted += padding + node + '\r\n';
	        pad += indent;
	    });
	  
	    return formatted;
	};
	function nofind(){
		var img=event.srcElement;
		img.src="${ctx}/public/default/img/avatar.png";
		img.onerror=null; //控制不要一直跳动
	}
	
	function toRad(d) {  return d * Math.PI / 180; }
	function getDisance(lat1, lng1, lat2, lng2) { //#lat为纬度, lng为经度, 一定不要弄错
	    var dis = 0;
	    var radLat1 = toRad(lat1);
	    var radLat2 = toRad(lat2);
	    var deltaLat = radLat1 - radLat2;
	    var deltaLng = toRad(lng1) - toRad(lng2);
	    var dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
	    return dis * 6378137;
	} 
	//alert(getDisance(39.91917,116.3896,39.91726,116.3940));

//-->
</script>
