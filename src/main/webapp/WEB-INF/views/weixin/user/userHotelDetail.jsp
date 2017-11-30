<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员信息列表详细</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <style type="text/css">
    	.user_list_one{
    		width:96%;
    		
    		
    	}
    	
    	.user-eval-list:first-child{
    		border:none;
    	}
    	
    	.fa {
		    -webkit-transform: scale(0.75);
		    width: 0.4rem;
		}
		.user-eval-list{
			padding:1rem 0 0.5rem 0;
			border-top:0.1rem solid #cccccc;
		}
    </style>
</head>

<body class="" >
	<div id="mask-full-screen" class="mask-full-screen"></div>
	
	<div class="user_list_one" style="margin-top:1rem;padding: 0 2%;">
		<div style="">
			<div style="font-size:0.95rem;font-weight:bold;">${hotel.hotelName}</div>
		</div>
		<div id="div_list_parent" class=" tran-list-ct" style="margin:0;">
			
		</div>
	</div>
	
	
	<form action="" id="form_list_params" style="display:none">
		<input type="date" id="search_GTE_createDate" name="search_GTE_createDate"  />
		<input type="date" id="search_LTE_createDate" name="search_LTE_createDate"/>
		<input id="search_groupid" type="text" name="search_EQ_groupId"  />
	</form>
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
	
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/user/hoteldetail/list?hotelId=${hotel.id}',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_hotel_list'
	}); 
	 

	
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
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
{{each rows as item j}}
	<div class="font-size-min flex-box user-eval-list" style="margin:0.5rem 0;" item-rdurl="${ctx}/weixin/user/moredetail?hotelId=${hotel.id}&userId={{item.id}}">
		<div style="display: table-cell;width: 27%;">姓名：{{item.rname}}</div>
				<div style="display: table-cell;width: 28%;">职位：{{item.position}}</div>
				<div style="display: table-cell;width: 45%;text-align: right;">客户综合评价：
					<div class="icon-start-02 icon-start-size-{{item.comprehensive? item.comprehensive:item.star}}" style="display:inline-block;">
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
	</div>
{{/each}}
</script>

<script id="temp_script_user_list" type="text/html">

</script>

</html>