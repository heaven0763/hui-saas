<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>订单信息</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   
    <style>
		.state-item{width:100%;border-right:1px solid #cccccc;margin: 0.5rem 0;text-align: center;font-size: 1rem;}
		.state-item-nb{border: none;}
		.one-list{border-bottom: 1px solid #f5f5f5;}
		.selected {
			width: 17px;
			height: 17px;
			background-color: rgb(255,178,38);
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
			margin-top: 13px;
		}
		.unselected {
			width: 15px;
			height: 15px;
			background-color: #ffffff;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
		    border: 1.0px solid #999999; 
			margin-top: 13px;
		}
		.flex{ display: flex;justify-content: center;align-content:center;-webkit-align-content:center;}
		.nflex{display: none;}
		.fullen{width: 100%;}
		.fullen-90{width: 90%;}
    </style>
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="top_toolbar" class="toolbar" style="">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">地区</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">场地</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">日期</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">类别</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
		</div>
	</div>
	<div id="top_toolbar_query" class="toolbar-search-parent">
			<div class="toolbar-content dp-none font-size-min" style="">
				<div style="margin:0.5rem 0;">
					<input type="text" id="input_params_cityname" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索" />	
				</div>
				
				<div class="toolbar-query-title" style="">当前定位城市</div>
				
				<div class="btn-city-list-parent city-show-default">
					<div class="btn btn-city btn-plain bg-none-city-chk " style="display:none;">广州</div>
				</div>
				
				<div class="toolbar-query-title" style="">历史定位城市</div>
				
				<div id="city_history_list" class="btn-city-list-parent city-show-default">
				    <!-- <div class="btn btn-city btn-plain bg-none-city">广州</div>
					<div class="btn btn-city btn-plain bg-none-city ">珠海</div>
					<div class="btn btn-city btn-plain bg-none-city ">中山</div> -->
				</div>
				<div class="toolbar-query-title toolbar-query-unlimited" cityid="" cityname=""  style="">不限</div>
				<div class="city-list-parent">
					<div>
						<div class="city-list-zimu" style="">A-G</div>
						<div class="toolbar-list-one" zimu="A,B,C,D,E,F,G" style="">
							<!-- <div>安庆</div>
							<div>安顺</div>
							<div>安阳</div>
							<div>鞍山</div>
							<div class="btn-city-checked">澳门</div>
							<div>阿拉善盟</div>
							<div>安康</div> -->
						</div>
					</div>
					
					<div>
						<div class="city-list-zimu" style="">H-N</div>
						<div class="toolbar-list-one " zimu="H,I,J,K,L,M,N"  style="">
						</div>
					</div>
					
					<div>
						<div class="city-list-zimu" style="">O-U</div>
						<div class="toolbar-list-one " zimu="O,P,Q,R,S,T,U"  style="">
						</div>
					</div>
					
					<div>
						<div class="city-list-zimu" style="">V-Z</div>
						<div class="toolbar-list-one " zimu="V,W,X,Y,Z"  style="">
						</div>
					</div>
				</div>
			</div>
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div style="margin:0.5rem 0;">
					<input type="text" id="input_params_hotel_name" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索" oninput="initData(1);"/>	
				</div>
				<div class="toolbar-query-title toolbar-query-unlimited"   style="margin:0.5rem 0;">不限</div>
				<div class="toolbar-query-title" style="">历史搜索结果</div>
				<div id="hotel_history_list" class="query-result" style="width:100%;font-size:0;">
					<!-- <div class="btn btn-query btn-plain bg-none-query col-justify-2" style="">广州喜来登场地</div>
					<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="">广州W场地</div>
					<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="">广州四季场地</div> -->
				</div>
				<div style="clear: both;"></div>
				<div class="toolbar-query-title" style="">搜索结果</div>
				<div id="hotel_query_list" class="query-result" >
				
				</div>
				
			</div>
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div style="margin:0.5rem 0;text-align: center;">
					<input type="date" id="fdate" class="font-gray-01" style="width:47%;height:1.0rem;padding:0.2rem 0;" />	-
					<input type="date" id="sdate" class="font-gray-01" style="width:47%;height:1.0rem;padding:0.2rem 0;" />	
				</div>
				<div style="width:100%; text-align: center;">
					<div class="btn btn-query  bg-none-query col-justify-2" style="width: 48%;" onclick="date_reset()">重置</div>
					<div id="btn_date_selt" class="btn btn-query  bg-none-query col-justify-2" style="width: 48%;" >确定</div>	
				</div>
			</div>
			
			<div id="state-list" class="toolbar-content dp-none font-gray-01 font-size-min">
				<div class="state-item-d" style="float:left;width:33%;box-sizing: border-box;">
					<div class="state-item" data="2">已结账</div>
				</div>
				<div class="state-item-d" style="float:left;width:33%;box-sizing: border-box;">
					<div class="state-item" data="1">已申请</div>
				</div>
				<div class="state-item-d" style="float:left;width:33%;box-sizing: border-box;">
					<div id="state_item_0" class="state-item state-item-nb" data="0">未结账</div>
				</div>
				<div style="clear: both;"></div>
			</div>
			
			
		</div>
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:4rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="搜索订单号/手机号/商品名称" />
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="order_list_div" class="tran-list-ct" style="width:100%;margin-top:1rem;margin-bottom:7rem;">
		 <!--  <div class="one-list" style="font-size: 0.9rem;">
			<div style="float: left;width: 10%;height: 8rem; display: flex;justify-content: center;align-content:center;-webkit-align-content:center;">
	 			<label class="check-one-label" style="display:inline-block;height: 8rem;padding: 3.3rem 0;" for="integralOrder1">
					<i class="unselected" style=""></i>
					<input  type="checkbox" name="integralOrder" id="integralOrder1" onchange="selChange();" value="1" style="display:none;">
				</label>
	 		</div>
	 		<div style="float: left;width: 90%;">
			 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
			 		<span style="font-size: 1rem;font-weight: bold;">韩式自助餐</span>
			 		<span style="color: red;">积分兑换:500分</span>
			 	</div>
			 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
			 		<span >订单号：00001234567892025</span>
			 	</div>
			 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
			 		<span >兑换客户：李玉兰&nbsp;&nbsp;13250151142&nbsp;&nbsp;广州</span>
			 	</div>
		 		<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
			 		<span >兑换时间：2016-10-27 10:50:23</span>
			 	</div>
			 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
			 		<span >会掌柜结算金额：<span style="color:#019FEA;">150元</span></span>
			 		<div class="btn btn-xs bg-type-01" style="min-width:4.2rem;margin 0 auto;padding: 0.2rem 0.8rem;">查看详情</div>
			 	</div>
		 	</div>
		 	<div style="clear: both;"></div>
		</div>   -->
	</div>
	<div style="position: fixed;bottom: 0;width:100%;background-color: #ffffff;">
		<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0;">
			<div style="float: left;margin-left: 2%;">应结：
				<fmt:formatNumber type="currency" value="${empty res.jdamount?0:res.jdamount }" />
			</div>
			<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:red;font-weight: bold;">实结：
				<fmt:formatNumber type="currency" value="${empty res.zgamount?0:res.zgamount  }" />
			</div>
			<div style="clear: both;"></div>
		</div>
		<div id="settlement_div_1" style="padding: 1% 2%;display: flex;justify-content: space-between;">
			<div id="btn_custom_settlement" class="btn btn-lg bg-type-03" style="width:47%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;">自定义确认</div>
			<div id="btn_batch_settlement" class="btn btn-lg bg-type-01" style="width:47%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;">一键确认</div>
		</div>
		<div id="settlement_div_2" style="padding: 1% 2%;display: none;justify-content: space-between;">
			<div id="btn_custom_cancel" class="btn btn-lg bg-type-03" style="width:47%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;">取消</div>
			<div id="btn_settlement" class="btn btn-lg bg-type-01" style="width:47%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;">确认结账</div>
			<input type="hidden" id="orderNos" />
		</div>
		<div id="settlement_div_0" style="padding: 1% 2%;display: none;">
			<div id="state_txt" class="btn btn-lg bg-type-03" style="width:100%;margin:0 auto;border-radius:3px;padding: 0.8rem 0;background-color:#999999;border-color:#999999;">
				已对账
			</div>
		</div>
	</div>
	<form id="form_list_params" style="display:none;">
		<input id="search_EQ_orderNo" type="text" name="search_EQ_o.order_no" />
		<input id="search_EQ_hotelSaleMobile" type="text" name="search_EQ_o.client_mobile" />
		<input id="search_LIKE_hotelName" type="text" name="search_LIKE_i.item_name" />
		
		<input id="search_city" type="text" name="search_LIKE_o.area"  />
		<input id="search_hotelId" type="text" name="search_EQ_o.hotel_id"  />
		<input id="search_fdate" type="text" name="search_GTE_o.create_date"  />
		<input id="search_sdate" type="text" name="search_LTE_o.create_date"  />
		<input id="search_state" type="text" name="search_EQ_o.settlement_status"  /> 
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>

<script>
$(function(){
	dict.init();
	var pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/hotel/integral/reconciliation/list',
		form : $('#form_list_params'),
		jqobj : $('#order_list_div'),
		tmpid : 'temp_list_order'
	}); 
	
	template.config('escape', false);
	template.helper('dayFormat', function(date){
		return common.formatDate(date);
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
			$target.show();
			initData($this.index());
			if($target.height() > $(window).height()){
				$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
			}
		}
	});
	
	$('#top_toolbar_query').delegate('.toolbar-query-unlimited','click',function(){	//不限
		var $this = $(this);
		var $toolbarcontent = $(this).parent();
		switch($toolbarcontent.index()){
		case 0:	//不限城市 
			
			$toolbarcontent.find('.btn-city-checked').removeClass('btn-city-checked');
			//$this.addClass('btn-city-checked');
			$('#search_city').val('');
			pager.search();	//查询
			
			break;
		case 1:
			$toolbarcontent.find('.btn-hotel-checked').removeClass('btn-hotel-checked');
			//$this.addClass('btn-hotel-checked');
			$('#search_hotelId').val('');
			pager.search();	//查询
			break;
		case 2:
			break;
		case 3:
			$toolbarcontent.find('.btn-state-checked').removeClass('btn-state-checked');
			$this.addClass('btn-state-checked');
			$('#search_state').val('');
			pager.search();	//查询
			break;
		}
		
		quitWithoutCheck($toolbarcontent.index());
	});
	
	var $citylistparent = $('.city-list-parent');
	$citylistparent.delegate('[cityid]','click',function(){	//城市列表点击事件
		var $this = $(this);
		$('.btn-city-checked').removeClass('btn-city-checked')
		$this.addClass('btn-city-checked');
		$('#search_city').val($this.attr('cityname'));
		pager.search();	//查询
		checkAndQuit(0);
	});
	var $hotelquerylist = $('#hotel_query_list');
	$hotelquerylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var history=[];
		var hotel = {"id":$this.attr('data'),"name":$this.text()};
		if(window.localStorage.wxIntegralOrderHotelHistory){
			var his = window.localStorage.wxIntegralOrderHotelHistory.replace(JSON.stringify(hotel),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(hotel);
	    window.localStorage.wxIntegralOrderHotelHistory=JSON.stringify(history);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$('#search_hotelId').val($this.attr('data'));
		pager.search();	//查询
		checkAndQuit(1);
	});
	var $hotelhistorylist = $('#hotel_history_list');
	$hotelhistorylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$('#search_hotelId').val($this.attr('data'));
		pager.search();	//查询
		checkAndQuit(1);
	});
	
	
	var $orderstatequerylist = $('#state-list');
	$orderstatequerylist.delegate('.state-item','click',function(){	//状态列表点击事件
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		if($this.attr('data')){
			$this.addClass('btn-state-checked');
			$('#search_state').val($this.attr('data'));
			if("2"===$this.attr('data')){
				$("#settlement_div_0").show();
				$("#settlement_div_1").hide();
				$("#settlement_div_2").hide();
				$("#state_txt").text('已对账');
			}else if("1"===$this.attr('data')){
				if('${type}'==='HUI'){
					$("#settlement_div_1").show();
					$("#settlement_div_0").hide();
					$("#settlement_div_2").hide();
				}else{
					$("#settlement_div_0").show();
					$("#settlement_div_1").hide();
					$("#settlement_div_2").hide();
					$("#state_txt").text('已申请');
				}
			}else{
				if('${type}'==='HUI'){
					$("#settlement_div_0").show();
					$("#settlement_div_1").hide();
					$("#settlement_div_2").hide();
					$("#state_txt").text('未对账');
				}else{
					$("#settlement_div_1").show();
					$("#settlement_div_0").hide();
					$("#settlement_div_2").hide();
				}
			}
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_state').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
		}
	});
	
	
	$('#state_item_0').click();
	
	/* $orderstatequerylist.delegate('.statecode-unlimited','click',function(){	//状态列表不限
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		$('#search_state').val('');
		pager.search();	//查询
		quitWithoutCheck(3);
	}); */
	$('.city-show-default').delegate('.btn-city','click',function(){	//定位城市 点击事件
		var $this = $(this);
		
		$('.city-list-parent [cityname="'+$this.attr('cityname')+'"]').click();
	});
	$('#btn_date_selt').click(function(){
		if($("#fdate").val()==''&&$("#sdate").val()==''){
			$('#search_fdate').val('');
			$('#search_sdate').val('');
			pager.search();	//查询
			quitWithoutCheck(2);
		}else{
			$('#search_fdate').val($("#fdate").val());
			$('#search_sdate').val($("#sdate").val());
			pager.search();	//查询
			checkAndQuit(2);
		}
	});
	//var date_selt = 
	
	
	initCitys();
	
	
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
		res = '<div class="btn btn-xs btn-disabled font-cl-type-'+data.commissionStatus+'"  style="float:right;"  >'+dict.trsltDict('06',data.commissionStatus)+'</div>';
		/* if(data.commissionStatus==='01'){
			//
		}else if(data.commissionStatus==='06'){
			res = '<div class="btn btn-xs btn-disabled"  style="float:right;" >已返佣</div>';
		}else{
			res = '<div class="btn btn-xs btn-disabled"  style="float:right;" >'+dict.trsltDict('06',data.commissionStatus)+'</div>';
		} */
		return res;
	});
	template.helper('state', function(data){
		var res = '<div class="list-ct-state list-ct-state-'+data.state+' " style="">'+dict.trsltDict('05',data.state);+'</div>';
		return res;
	});
	$('#btn_order_search').click(function(){
		 var tel = /^(13|15|18|17)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 $('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_hotelSaleMobile').val(searchVal);
		 }else if(numberReg.test(searchVal)){
			 $('#search_EQ_orderNo').val(searchVal);
		 }else{
			 $('#search_LIKE_hotelName').val(searchVal);
		 }
		 pager.search();
		 
	});
	
	$('#btn_custom_settlement').click(function(){
		$(".nflex").removeClass("nflex").addClass("flex");
		$(".fullen").removeClass("fullen").addClass("fullen-90");
		
		$("#settlement_div_2").show();
		$("#settlement_div_2").css("display","flex");
		$("#settlement_div_1").hide();
		
	});
	$('#btn_custom_cancel').click(function(){
		$(".flex").removeClass("flex").addClass("nflex");
		$(".fullen-90").removeClass("fullen-90").addClass("fullen");
		$(".selected").removeClass("selected").addClass("unselected");
		$('input:checkbox').removeAttr('checked');
		$("#settlement_div_1").show();
		$("#settlement_div_2").hide();
		
	});
	
	$('#btn_batch_settlement').click(function(){

		showMaskDiv();
		$.post('${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',{},function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				pager.search();
			}else{			}
			hideMaskDiv();
		})
	});
	$('#btn_settlement').click(function(){
		
		showMaskDiv();
		var orderNos = $('#orderNos').val();
		if(orderNos===''){
			toastFn("请先选择需要确认的订单！");
			hideMaskDiv();
			return;
		}
		$.post('${ctx}/weixin/hotel/integral/reconciliation/batchsettlement',{orderNos:orderNos},function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				pager.search();
				$('#btn_custom_cancel').click();
			}else{
			}
			hideMaskDiv();
		})
	});
		
});
function commission(){
	alert("确定返佣！");
}

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
		if(window.localStorage.wxIntegralOrderHotelHistory){
			var history = JSON.parse(window.localStorage.wxIntegralOrderHotelHistory);
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

function date_reset(){
	$("#fdate").val('');
	$("#sdate").val('');
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

var citys = data_citys_list;
function initCitys(){
	var $zimu = $('.city-list-parent [zimu]');
	var index = 0;
	
	var eleIndex = 0;
	var $element = $zimu.eq(eleIndex);
	var html = [];	
	for(; index < citys.length ; ){	//遍历城市 json列表
		var zimu = $element.attr('zimu');
		var zimuArray = zimu.split(',');
		if($.inArray(citys[index].zimu,zimuArray) == -1){	//如果当前城市不属于该元素
			$element.html(html.join(''));
			html = [];
			$element = $zimu.eq(++eleIndex);	//获取下一个元素
		}else{
			html.push('<div cityid="'+citys[index].id+'" cityname="'+citys[index].regionName+'"   >'+citys[index].regionName+'</div>');
			index++;
		}
		if(index == citys.length - 1){ //最后一个城市
			$element.html(html.join(''));
			break;
		}
	}
	common.getLocationCityName('getCityNameCallBack');
}

function getCityNameCallBack(res){
    var cityname = res.result.addressComponent.city;
    cityname = cityname.replace('市','');
	var selector = '.city-list-parent [cityname="'+cityname+'"]';
    var cityid = $(selector).attr('cityid');
    checkDefaultCity(cityid,cityname);
    
    
   	var storagecity = cityid + ','+cityname+';';
    var historyLocationCitys = common.getstorage('historyLocationCitys');
    
    historyLocationCitys = historyLocationCitys.replace(storagecity,'') + storagecity;
    common.setstorage('historyLocationCitys',historyLocationCitys);
    showHistoryLocationCity(historyLocationCitys);
} 

function selCity(key){
	var newcitys = [];
	var index = 0;
	for(; index < data_citys_list.length ; ){
		 if(data_citys_list[index].regionName.indexOf(key+'')>=0){
			newcitys.push(data_citys_list[index]);
		} 
		index++;
	} 
	if(newcitys.length>0){
		citys = newcitys;
		console.log(citys[0].zimu);
		initCitys();
	}
}

function showHistoryLocationCity(historyLocationCitys){
	historyLocationCitys = historyLocationCitys || common.getstorage('historyLocationCitys');
	
	var cityArray = historyLocationCitys.split(';');
	var html = [];
	for(var i in cityArray){
		var city = cityArray[i].split(',');
		if(!city[0]){
			continue;
		}
		html.push('<div class="btn btn-city btn-plain bg-none-city" cityid="' +city[0]+ '" cityname="'+city[1]+'"  >' +city[1]+ '</div>');
	}
	$('#city_history_list').html(html.join(''));
}

function checkDefaultCity(cityid,cityname){
	//var selector = 'div[cityid="'+cityid+'"]';
	//$(selector).addClass('btn-city-checked');
	$('.bg-none-city-chk').attr('cityid',cityid).attr('cityname',cityname).text(cityname).show();
	$('.city-list-parent .btn-city-checked').removeClass('btn-city-checked');	//取消城市 列表的选中
	$('.city-list-parent div[cityid="'+cityid+'"]').addClass('btn-city-checked');	//选择城市列表中的其中一个
}

function changeCity(cityid,cityname){
	$('.city-list-parent .btn-city-checked').removeClass('btn-city-checked');
	$('.city-list-parent div[cityid="'+cityid+'"]').addClass('btn-city-checked');
}

function checkAndQuit(index){
	$('#top_toolbar .toolbar-one').eq(index).addClass('icon-arrow-chked');
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-active');
	$('#top_toolbar_query .toolbar-content').eq(index).hide();
	hideMaskDiv();
}

function quitWithoutCheck(index){
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-chked');
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-active');
	$('#top_toolbar_query .toolbar-content').eq(index).hide();
	hideMaskDiv();
}
function selChange(){
	var orderNos = new Array();
	$("input[name='integralOrder']:checkbox").each(function(i){
	    if($(this).attr("checked")) {
	    	$(this).parent().find("i").removeClass("unselected");
	    	$(this).parent().find("i").addClass("selected");
	    	orderNos.push($(this).val());
	   }else{
		   $(this).parent().find("i").removeClass("selected");
		   $(this).parent().find("i").addClass("unselected");
	   }
	});
	$("#orderNos").val(orderNos.join(","));
}
</script>

<script id="temp_list_order" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="font-size: 0.9rem;" >
			<div class="nflex" style="float: left;width: 10%;height: 8rem;">
	 			<label class="check-one-label" style="display:inline-block;height: 8rem;padding: 3.3rem 0;" for="integralOrder{{item.id}}">
					<i class="unselected" style=""></i>
					<input  type="checkbox" name="integralOrder" id="integralOrder{{item.id}}" onchange="selChange();" value="{{item.orderNo}}" style="display:none;">
				</label>
	 		</div>
	 		<div class="fullen" style="float: left;" rdurl="${ctx}/weixin/hotel/integral/reconciliation/detail/{{item.id}}">

		 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
		 		<span style="font-size: 1rem;font-weight: bold;">{{item.itemName}}</span>
		 		<span style="color: red;">积分兑换:{{item.points}}分</span>
		 	</div>
		 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
		 		<span >订单号：{{item.orderNo}}</span>
		 	</div>
		 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
		 		<span >兑换客户：{{item.clientName}}&nbsp;&nbsp;{{item.clientMobile}}&nbsp;&nbsp;{{item.area}}</span>
		 	</div>
	 		<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
		 		<span >兑换时间：{{item.createDate | dayFormat}}</span>
		 	</div>
		 	<div style="display: flex;justify-content: space-between;padding: 0.3rem 0;">
		 		<span >会掌柜结算金额：<span style="color:#019FEA;">{{item.zgamount}}元</span></span>
		 		<div class="btn btn-xs bg-type-01" style="min-width:4.2rem;margin 0 auto;padding: 0.2rem 0.8rem;">查看详情</div>
		 	</div>
			</div>
			<div style="clear: both;"></div>
		</div>
	{{/each}}
</script>
</html>
