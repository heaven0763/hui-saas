<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>消息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <style type="text/css">
    	.user_list_one{
    		width:96%;
    		padding:1rem 2% 0.5rem 2%;
    		border-top:0.1rem solid #cccccc;
    	}
    	
    	.user_list_one:first-child{
    		border:none;
    	}
    	
    	.fa {
		    -webkit-transform: scale(0.75);
		    width: 0.4rem;
		}
		.pms-hidden{    height: 36px;    overflow: hidden;}
		.read-0{color:#FFB42B}
		.read-1{color:#ff0000}
		.rd-0{width: 5px;height: 5px;border-radius: 2.5px;background-color: #ffffff;}
		.rd-1{width: 5px;height: 5px;border-radius: 2.5px;background-color: #ff0000;position: absolute;top:2.5px;}
    </style>
</head>

<body class="" style="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	
	<!-- <div style="height:1.6rem;width:95%;margin:0 auto;margin-top:1rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" 
		placeholder="搜索姓名/手机号">
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div> -->
	
	<div id="div_list_parent" class="tran-list-ct" style="width:100%;overflow-y:scroll;">
		
	</div>
	
	<form action="" id="form_list_params" style="display:none;">
		<input id="search_EQ_mobile" type="text" name="search_EQ_mobile" />
		<input id="search_LIKE_rname" type="text" name="search_LIKE_rname" />
	</form>
	<%-- <div class="flex-box flex-justify" style="padding:0.5rem 2%;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
		<div class="btn btn-xs bg-type-01" style="width:100%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}//weixin/user/author/transfer?fromuserId=&gid=${type}&type=${type}">新增HR</div>
	</div> --%>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>


<script>
common.ctx =  '${ctx}';

$(function(){
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/message/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_hotel_list',
		callback : function(res,$appendContent){
		}
	}); 
	template.config('escape', false);
	template.helper('dateFormat', function(date){
		return common.formatDate(date);
	});
	
	template.helper('state', function(state){
		return state ==='1'?'未读':'已读';
	});
	//为了列表能滚动而设置高度
	$('#btn_order_search').click(function(){
		 var tel = /^(13|15|18|17)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 $('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_mobile').val(searchVal);
		 }else{
			 $('#search_LIKE_rname').val(searchVal);
		 }
		 pager.search();
		 
	});
	
});

function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

</script>

<script id="temp_script_hotel_list" type="text/html">
	{{each rows as item i}}
		<div class="user_list_one" style="" item-rdurl="${ctx}/weixin/message/detail/{{item.id}}">
			<div>
				<div style="float:left;position: relative;" >
					<span style="font-weight:bold;">{{item.title}}</span><i class="rd-{{item.state}}">&nbsp;</i>
					<span style="font-size:0.8rem;margin-left:1rem;">{{item.createdAt | dateFormat}}</span>
				</div>
				<div  style="float:right;font-size:0.9rem;" class="read-{{item.state}}" >{{item.state | state}}</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	{{/each}}
</script>

<script id="temp_script_user_list" type="text/html">

</script>

</html>