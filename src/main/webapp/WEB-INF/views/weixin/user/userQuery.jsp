<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员信息查询</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
</head>

<body class="" style="overflow:hidden;">


	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;overflow-y:scroll;margin:0 auto;line-height: 1.8rem;">
		<div class="one-list" >
			<div>
				<div style="font-weight:bold;float:left;">李玉兰</div>
				<div class="font-size-min font-cl-type-01" style="float:left;margin-left:0.5rem;">广州</div>
				<div class="btn btn-xs bg-type-02 "style="float:right;line-height:1rem;">查看详情</div>
				<div style="clear:both;"></div>
			</div>
			<div class="font-size-min font-gray-01" style="display:-webkit-box;-webkit-box-pack:justify;"> 
				<div style="-wekit-box-flex:1;">累计积分：500</div>
				<div style="-wekit-box-flex:1;">已兑积分：0</div>
				<div style="-wekit-box-flex:1;">结余积分：300</div>
			</div>
			<div class="hide-content dp-none">
				<div style="color:#ff0000;">累计消费金额：¥19825.00</div>
				<div class="font-size-min font-gray-01" style="display:-webkit-box;-webkit-box-pack:justify;">
					<div style="-wekit-box-flex:1;">积分计算标准：XX元消费折算1分</div>
					<div style="-wekit-box-flex:1;">积分：500分</div>
				</div>
			</div>
		</div>
		
		<div class="one-list" >
			<div>
				<div style="font-weight:bold;float:left;">李玉兰</div>
				<div class="font-size-min font-cl-type-01" style="float:left;margin-left:0.5rem;">广州</div>
				<div class="btn btn-xs bg-type-disable"style="float:right;line-height:1rem;">查看详情</div>
				<div style="clear:both;"></div>
			</div>
			<div class="font-size-min font-gray-01" style="display:-webkit-box;-webkit-box-pack:justify;"> 
				<div style="-wekit-box-flex:1;">累计积分：500</div>
				<div style="-wekit-box-flex:1;">已兑积分：0</div>
				<div style="-wekit-box-flex:1;">结余积分：300</div>
			</div>
			<div class="hide-content dp-none">
				<div style="color:#ff0000;">累计消费金额：¥19825.00</div>
				<div class="font-size-min font-gray-01" style="display:-webkit-box;-webkit-box-pack:justify;">
					<div style="-wekit-box-flex:1;">积分计算标准：XX元消费折算1分</div>
					<div style="-wekit-box-flex:1;">积分：500分</div>
				</div>
			</div>
		</div>
		
		
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';

$(function(){
	dict.init();
	/* var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/order/evaluate/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_${usertype}'
	}); */
	
	$('#div_list_parent').delegate('.one-list ','click',function(){
		var $this = $(this);
		var $target = $this.find('.hide-content');
		if($target.hasClass('dp-none')){
			$('#div_list_parent .hide-content').addClass('dp-none');
			$target.removeClass('dp-none');
		}else{
			$target.addClass('dp-none');
		}
		
	});

});

</script>


</html>
