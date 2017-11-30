<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>场地报价调整审核</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    
</head>

<body class="">
	<div class="tran-list-ct conent-list" style="width:100%;">
		
		<div id="pricradjust_list">
			
		</div>
		<form id="form_list_params" style="display:none;">
			<c:if test="${groupMap.iscompanysales }">
			 <input type="hidden" name="search_EQ_h.reclaim_user_id" value="${guserId}">
			</c:if>
			<!-- <input type="hidden" id="search_EQ_pa.state" name="search_EQ_pa.state" value="0"/> -->
		</form>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>

<script>
$(function(){
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/hotel/price/adjust/list',
		form : $('#form_list_params'),
		jqobj : $('#pricradjust_list'),
		tmpid : 'temp_list_priceadjust'
	}); 
	
	template.config('escape', false);
	
	template.helper('state', function(item){
		if (item.state =='0' && 'HUI'=='${aUs.getCurrentUserType()}' && '${groupMap.iscompanysales}'=='true'){
			return '<div class="btn btn-xs bg-type-01" style="float:right;">点击审核</div>';
		}else if (item.state =='1' && 'HUI'=='${aUs.getCurrentUserType()}' && '${groupMap.iscompanyadministrator}'=='true'){
			return '<div class="btn btn-xs bg-type-01" style="float:right;">点击审核</div>';
		}else{
			return '<div class="btn btn-xs bg-type-02" style="float:right;">查看详情</div>';
		}
	});
});

</script>
<script id="temp_list_priceadjust" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="" item-rdurl="/hui/weixin/hotel/price/adjust/detail/{{item.id}}?idx={{i+1}}">
			<div class="one-list-ct-title" style="padding-top: 0.5rem;">
				<div style="display:inline-block;">{{item.hotelName}}</div>
				<div class="list-ct-state list-ct-state-02 " style="margin-left: 1rem;">{{item.area}}</div>
				{{item | state}}
				<div style="clear:both;"></div>
			</div>
			<div class="font-size-min display-flex" style="margin-top:0.5rem;width: 100%;">
				<div style="">提交人：{{item.applyUserName}}</div>
				<div style="">提交时间：{{item.applyDate}}</div>
				<div style="">初审人：{{item.trialUserName}}</div>
			</div>
		</div>
	{{/each}}

</script>
</html>
