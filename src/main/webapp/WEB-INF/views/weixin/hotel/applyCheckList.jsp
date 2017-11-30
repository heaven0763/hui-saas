<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>加入申请审核</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link rel="stylesheet" href="${ctx}/static/weixin/css/tools.css"/>
   
    <style>
    	.more-item-active{color: #274082;}
    </style>
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="top_toolbar" class="toolbar" style="">
		
	</div>
	
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:4rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="场地名称" />
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="order_list_div" class="tran-list-ct" style="width:100%;margin-top:1rem;">
		<!-- 场地列表 -->
	</div>
	
	<form id="form_list_params" style="display:none;">
		<input id="search_LIKE_hotelName" type="text" name="search_LIKE_h.hotel_name" />
	</form>
	
</div>
	
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/js/tools.js"></script>
<script>
$(function(){
	dict.init();
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/base/hotel/record/checkList',
		form : $('#form_list_params'),
		jqobj : $('#order_list_div'),
		tmpid : 'temp_list_order'
	}); 
	
	
	var $topToolbar = $('#top_toolbar');
	var $top_toolbar_query = $('#top_toolbar_query');
	var $topToolbars = $('#top_toolbar .toolbar-one');
	//为了列表能滚动而设置高度
	$('#div_list_parent').height($(window).height() - $topToolbar.height());
	$topToolbars.click(function(){
	/* 	$topToolbars.removeClass('icon-arrow-active');
		var $this = $(this);
		$this.addClass('icon-arrow-active');
		var index = $(this).index(); */
		
		var $this = $(this);
		$('#top_toolbar .toolbar-one:not(:eq('+$this.index()+'))').removeClass('icon-arrow-active');
		
		if(!$this.hasClass('icon-arrow-active')){
			$this.addClass('icon-arrow-active');
			$topToolbar.addClass('toolbar-active')
			showMaskDiv();
		}else{
			$this.removeClass('icon-arrow-active');
			$topToolbar.removeClass('toolbar-active')
			hideMaskDiv();
		}
		
		$top_toolbar_query.find('.toolbar-content').hide();
		
		var $target = $top_toolbar_query.find('.toolbar-content:eq('+($this.index() )+')');
		if(!$this.hasClass('icon-arrow-active')){
			$target.hide();
			if($this.index()==1){
				$("#input_params_hotel_name").val('');
			}
		}else{
			/* $target.show();
			initData($this.index());
			if($target.height() > $(window).height()){
				$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
			} */
		}
	});
	

	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});


	template.config('escape', false);
	template.helper('order_amount', function(amount){
		var res = '￥';
		if(amount*1>10000){
			res+=common.formatCurrency((amount/10000),2)+"万元";	
		}else{
			res+=common.formatCurrency(amount,2)+"元";	
		}
		return res;
		
	});
	template.helper('commission', function(data){
		var res = '';
		res = '<div class="btn btn-xs font-cl-type-'+data.commissionStatus+'"  style="float:right;text-align:right;"  >'+dict.trsltDict('06',data.commissionStatus)+'</div>';
		
		return res;
	});
	template.helper('state', function(data){
		var res = '<div class="list-ct-state list-ct-state-'+data.state+' " style="">'+dict.trsltDict('05',data.state);+'</div>';
		return res;
	});
	$('#btn_order_search').click(function(){
		 var searchVal = $('#input_search_val').val();
		 $('#form_list_params')[0].reset();
		 $('#search_LIKE_hotelName').val(searchVal);
		 pager.search();
		 
	});
		
});

function initData(index){
	//alert(index);
	if(index===1){
		var hotelId = $('#search_hotelId').val();
		var url = '${ctx}/wexin/hotel/listAll';
		var hotelName=$("#input_params_hotel_name").val();
		$.get(url,{hotelName:hotelName},function(data){
			var html = [];
			var i=0;
			var rows = data.rows;
			for(;i<rows.length;){
				var str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2" data="'+rows[i].id+'" style="">'+rows[i].hotelName+'</div>';
				if(hotelId===rows[i].id+''){
					str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2 btn-hotel-checked" data="'+rows[i].id+'" style="">'+rows[i].hotelName+'</div>';
				}
				html.push(str);
				i++;
			}
			$("#hotel_query_list").html(html.join(''));
		});
		if(window.localStorage.wxOrderHotelHistory){
			var history = JSON.parse(window.localStorage.wxOrderHotelHistory);
			var html = [];
			var i=0;
			for(;i<history.length;){
				var str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2" data="'+history[i].id+'" style="">'+history[i].name+'</div>';
				if(history===history[i].id+''){
					str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2 btn-hotel-checked" data="'+history[i].id+'" style="">'+history[i].name+'</div>';
				}
				html.push(str);
				i++;
			}
			$("#hotel_history_list").html(html.join(''));
        }
	}else if(index===3){
		
	}
}
function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

function disabledScroll(event){
	 event.preventDefault();
};


function check(state,recordId){
	$.post('${ctx}/base/hotel/record/checkApply',{state:state,recordId:recordId},function(res){
		if(res.statusCode==='200'){
		}else{
		}
	},'json');
}

function showPassDialog(id){
	confirmFn("确定审核通过吗？",function(){
		check("1",id);
		location.reload();
	});
}

function showFailDialog(id){
	confirmFn("确定审核不通过吗？",function(){
		check("2",id);
		location.reload();
	});
}


</script>

<script id="temp_list_order" type="text/html">
{{each rows as item i}}
<div class="one-list" style="">
	<div class="one-list-ct-title" style="">
		<div style="display:inline-block;">{{item.rname}}</div>
	</div>
	<div class="font-size-min" style="margin-top:0.5rem;">
		<div style="float:left;">手机号：{{item.mobile}}</div>
		<input class="btn btn-xs bg-type-01" type="button" style="float:right;min-width:4.2rem;margin 0 auto;" id="id{{item.id}}" onclick="showPassDialog({{item.recordId}})" value="审核通过"/>
	</div>
	<div class="font-size-min" style="margin-top:0.5rem;">
		<div style="float:left;">申请时间：{{item.applyDate}}</div>
		<div style="clear:both;"></div>
	</div>
	<div class="font-size-min" style="margin-top:0.5rem;">
		<div style="float:left;">邮箱：{{item.email}}</div>
		<input class="btn btn-xs bg-type-01" type="button" style="float:right;min-width:4.2rem;margin 0 auto;" id="id{{item.id}}" onclick="showFailDialog({{item.recordId}})" value="审核不过"/>
	</div>

</div>
{{/each}}
	
</script>
</html>
