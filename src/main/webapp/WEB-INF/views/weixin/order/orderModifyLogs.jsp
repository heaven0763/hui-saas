<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>修改详情</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    <style>
    	.vertical-timeline{
    		position: relative;
    	}
    	
    	.timeline-one-list{
    		position:relative;
    		width:100%;
    		margin-top:1rem;
    	}
    	
    	.timeline-one-list:last-child{
   		    height: 0;
    	}
    	
    	.vertical-timeline::before {
		    content: '';
		    position: absolute;
		    left: 0.3rem;
		    height: 100%;
		    width: 0.1rem	;
		    background: #cccccc; 
	        top: 0.2rem;
		}
		
		.timeline-leftdot{
		    position: absolute;
		    top:0.2rem;
		    width: 0.8rem;
		  	padding-bottom: 0.8rem;
		    background-color: #0B9FE5;
		    border-radius: 50%;
		}
		
		.timeline-rightcontent{
			position:relative;
			left:5%;
			width:90%;
		}
		
		.order-modify-logs{
			display:-webkit-flex;-webkit-justify-content:space-between;line-height:1.5rem;width:100%;
		}

    </style>
</head>

<body class="">
	<div style="width:96%;margin:0 auto;">
		<div class="font-size-min" style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:3rem;border-bottom:1px solid #cccccc;">
			订单号：${order.orderNo}  
		</div>
		
		<div id="div_list_order_modify_logs" class="vertical-timeline" style="margin-top:1rem;font-size:0.85rem;">
			
			
			
		</div>
	</div>

	<form id="form_list_params" style="display:none;">
		<input id="search_EQ_orderNo" type="text" name="search_EQ_l.operate_id" value="${order.id}" />
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/order.modifylogs.tran.js"></script>
<script>
$(function(){
	dict.init();

	 var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/order/modify/logs/listAll',
		form : $('#form_list_params'),
		jqobj : $('#div_list_order_modify_logs'),
		tmpid : 'temp_list_order_logs_list'
	}); 
	 
	template.config('escape', false);
	var tempHtml = '<div class="order-modify-logs" style=""><div style="">{{proName}}：<del>{{old_value}}</del> </div><div style="">调整为：<span style="color:#FFB42B;">{{new_data}}</span></div></div>';
	template.helper('modify_content', function(row){
		var modifyHtml = [];
	
		if(row.operateType==='INSERT'){
			var hml = '<div class="order-modify-logs" style="color:red;">新增订单</div>';
			modifyHtml.push(hml);
		}else{
			var newData = JSON.parse(row.newData);
			var oldData = JSON.parse(row.oldData);
			for(var pro in newData){
				var proObj = orderLogsTran[pro];
				if(proObj){
					var oldVal = proObj.dict? dict['fn'+proObj.dict](oldData[pro]) : proObj.currency?"￥"+common.formatCurrency(oldData[pro]) : oldData[pro];
					var newVal = proObj.dict? dict['fn'+proObj.dict](newData[pro]) : proObj.currency?"￥"+common.formatCurrency(newData[pro]) : newData[pro];
					modifyHtml.push(tempHtml.replace('{{proName}}',proObj.name).replace('{{old_value}}',oldVal).replace('{{new_data}}',newVal));
				}
			}
		}
		return modifyHtml.join('');
		
	});
	
	template.helper('rname', function(rname){
		if(rname===null||rname==='null'||rname===''){
			return '客户${order.linkman}';
		}else{
			return rname;
		}
	});
	//'<div class="order-modify-logs" style=""><div style="">{{proName}}：{{old_value}} </div><div style="">调整为：{{new_data}} </div></div>'
		
});
</script>

<script id="temp_list_order_logs_list" type="text/html">
{{each rows as item i}}
<div class="timeline-one-list" style="">
	<div class="timeline-leftdot" style=""></div>
	<div class="timeline-rightcontent" style="">
		<div style="font-weight:bold;">修改内容</div>
		
		{{item | modify_content}}

		<div style="">修改人：{{item.rname | rname}}&nbsp;&nbsp;{{item.position}}</div>
		<div style="display:-webkit-flex;-webkit-justify-content:space-between;line-height:1.5rem;width:100%;">
			<div style="color:#A0A0A0;">修改时间：{{item.operateTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}} </div>
		</div>
	</div>
</div>
{{/each}}
</script>
</html>
