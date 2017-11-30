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
   
    <style>
   		 .more-item-active{color: #274082;}
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
				<span class="toolbar-one-text" style="">更多</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
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
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<%-- <div style="margin:0.5rem 0;">
					<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
				</div>
				<div id="order_state_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
					<div class="statecode-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" statecode="">不限</div>
					<c:forEach var="dict" items="${stateDicts}">
						<div style="float:left;width:33.33%;font-size:0.85rem;" statecode="${dict.code}">${dict.detail}</div>
					</c:forEach>
				</div> --%>
				
				
				<div class="copt-more" style="margin:0.5rem 0;width: 100%;text-align: center;font-size:0.85rem;border-bottom:1px solid #cccccc;padding: 0.5rem 0; ">
					<c:if test="${groupMap.iscompanysales || groupMap.ishotelsales }">
						<div class="more-item more-item-active" style="width: 48%;float: left;">场地类型</div>
						<div class="more-item" style="width: 48%;border-left: 1px solid #cccccc;float: left;">状态</div>
						<div style="clear: both;"></div>
					</c:if>
					<c:if test="${!groupMap.iscompanysales && !groupMap.ishotelsales}">
						<div class="more-item more-item-active" style="width: 33%;float: left;">场地类型</div>
						<div class="more-item" style="width: 33%;border-left: 1px solid #cccccc;float: left;">状态</div>
						<div class="more-item" style="width: 33%;border-left: 1px solid #cccccc;float: left;">销售人员</div>
						<div style="clear: both;"></div>
					</c:if>
					
				</div>
				<div id="hotelNature">
					<!-- <div style="padding: 0.5rem 5%;background-color: #f5f5f5; ">
						<input id="hotel_type_search" type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;background-color: #f5f5f5;" placeholder="搜索"/>	
					</div> -->
					<div id="hotel_type_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
					</div>
				</div>
				
				<div id="rebatestate" style="display: none;">
					<!-- <div style="padding: 0.5rem 5%;background-color: #f5f5f5; ">
						<input id="order_state_search" type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;background-color: #f5f5f5;" placeholder="搜索"/>	
					</div> -->
					<div id="order_state_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="statecode-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" statecode="">不限</div>
						<c:forEach var="dict" items="${stateDicts}">
							<div style="float:left;width:33.33%;font-size:0.85rem;" statecode="${dict.code}">${dict.detail}</div>
						</c:forEach>
					</div> 
				</div>
				
				<c:if test="${!groupMap.iscompanysales && !groupMap.ishotelsales }">
				<div id="reclaimSale" style="display: none;">
					<!-- <div style="padding: 0.5rem 5%;background-color: #f5f5f5; ">
						<input id="sale_search" type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;background-color: #f5f5f5;" placeholder="搜索"/>	
					</div> -->
					<div id="reclaim_sale_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="reclaim-sale-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" saleId="">全部</div>
						 <c:forEach var="sale" items="${sales}">
							<div style="float:left;width:33.33%;font-size:0.85rem;" saleId="${sale.id}" saleName='${sale.rname}'>${sale.rname}</div>
						</c:forEach> 
					</div>
				</div>
				</c:if>
			</div>
			
			
		</div>
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:4rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" placeholder="搜索订单号/手机号/场地名称" />
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="order_list_div" class="tran-list-ct" style="width:100%;margin-top:1rem;">
		<!-- <div class="one-list" style="border:none;">
				<div class="one-list-ct-title" style="">
					<div style="display:inline-block;">广州喜来登场地</div>
					<div class="list-ct-state list-ct-state-01 " style="">进行中</div>
					<div style="float:right;color:#cb2b29;">1925元</div>
				</div>
				<div class="font-size-min" style="margin-top:0.5rem;">订单号：00001234567899045</div>
				<div class="font-size-min" style="margin-top:0.5rem;">
					<div style="float:left;">活动时间：2016-01-02</div>
					<div class="btn btn-xs btn-disabled" style="float:right;color:#019FEA;min-width:0;">查看详情</div>
					<div style="clear:both;"></div>
				</div>
				<div class="one-list-ct-sett" style="margin-top:0.5rem;">
					<div class="sett-left" style="">地区：广州</div>
					<div class="btn btn-xs bg-type-01" style="float:right;">确定返佣</div>
				</div>
		</div> -->
		
	</div>
	<c:if test="${not empty res }">
	<div style="background-color: #f5f5f5;">
		<div style="color: #5f5f5f;margin: 0 2%; padding: 0.5rem 0;">合计情况：</div>
		<div style="background-color: #019FEA;color: #ffffff; padding: 0.5rem 0;">
			<div style="margin: 0.3rem 3%;display: flex;justify-content: space-between;">
				<span style="width: 50%;">已结算：${res.settlement }</span>
				<span style="width: 50%;">已交订金：${res.deposit }</span>
			</div>
			<div  style="margin: 0.3rem 3%;display: flex;justify-content: space-between;">
				<span style="width: 50%;">待结算：${res.unsettlement }</span>
			</div>
		</div>
	</div>
	</c:if>
	<form id="form_list_params" style="display:none;">
		<input id="search_EQ_orderNo" type="text" name="search_EQ_o.order_no" />
		<input id="search_EQ_contactNumber" type="text" name="search_EQ_o.contact_number" />
		<input id="search_LIKE_hotelName" type="text" name="search_LIKE_h.hotel_name" />
		<input id="search_city_id" type="text"  />
		<input id="search_city" type="text" name="search_LIKE_o.area"  />
		<input id="search_hotelId" type="text" name="search_EQ_o.hotel_id"  />
		<input id="search_fdate" type="text" name="search_GTE_o.create_date"  />
		<input id="search_sdate" type="text" name="search_LTE_o.create_date"  />
		
		<input id="search_state" type="text" name="search_EQ_o.state"  /> 
		<input id="search_saleId" type="text" name="saleId" value="${groupMap.iscompanysales||groupMap.ishotelsales?guserId:'' }" /> 
		<input id="search_hotelType" type="text" name="hotelType"  /> 
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script>
var pager = null;
$(function(){
	common.ctx ='${ctx}';
	dict.init();
	common.pms.init();
	pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/order/list',
		form : $('#form_list_params'),
		jqobj : $('#order_list_div'),
		tmpid : 'temp_list_order',
		callback:common.pms.init()
	}); 
	
	
	var $topToolbar = $('#top_toolbar');
	var $top_toolbar_query = $('#top_toolbar_query');
	var $topToolbars = $('#top_toolbar .toolbar-one');
	//为了列表能滚动而设置高度
	$('#div_list_parent').height($(window).height() - $topToolbar.height());
	$topToolbars.click(function(){
		
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
			if($this.index()==1){
				initData($this.index(),$target,$topToolbar);
			}else{
				$target.show();
				if($target.height() > $(window).height()){
					$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
				}
			}
			
		}
	});
	
	$('#top_toolbar_query').delegate('.toolbar-query-unlimited','click',function(){	//不限
		var $this = $(this);
		var $toolbarcontent = $(this).parent();
		switch($toolbarcontent.index()){
		case 0:	//不限城市 
			$toolbarcontent.find('.btn-city-checked').removeClass('btn-city-checked');
			$this.addClass('btn-city-checked');
			$('#search_city').val('');
			$('#search_city_id').val('');
			
			pager.search();	//查询
			
			break;
		case 1:
			$toolbarcontent.find('.btn-hotel-checked').removeClass('btn-hotel-checked');
			$this.addClass('btn-hotel-checked');
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
	
	
	$('.copt-more').delegate('.more-item','click',function(){
		var $this = $(this);
		switch($this.index()){
		case 0:	
			moreReset();
			if($("#hotelNature").height() > $(window).height()){
				$("#hotelNature").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
			}
			break;
		case 1:
			$('.more-item').each(function(){
				var $_this = $(this);
				$_this.removeClass('more-item-active');
			}); 
			$this.addClass('more-item-active');
			$("#reclaimSale").hide();
			$("#hotelNature").hide();
			$("#rebatestate").show();
			if($("#rebatestate").height() > $(window).height()){
				$("#rebatestate").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
			}
			break;
		case 2:
			$('.more-item').each(function(){
				var $_this = $(this);
				$_this.removeClass('more-item-active');
			}); 
			$this.addClass('more-item-active');
			$("#reclaimSale").show();
			$("#hotelNature").hide();
			$("#rebatestate").hide();
			if($("#reclaimSale").height() > $(window).height()){
				$("#reclaimSale").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
			}
			break;
			
			
		}
	});
	
	
	$('#reclaim_sale_query_list').delegate('[saleId]','click',function(){	//销售人员列表点击事件
		var $this = $(this);
		$('#reclaim_sale_query_list').find('.btn-state-checked').removeClass('btn-state-checked')
		if($this.attr('saleId')){
			$this.addClass('btn-state-checked');
			$('#search_saleId').val($this.attr('saleId'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_saleId').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
			moreReset();
		}
	});
	
	$('#hotel_type_list').delegate('[hoteltype]','click',function(){	//场地类型点击事件
		var $this = $(this);
		$('#hotel_type_list [hoteltype]').removeClass('font-cl-query-chked');
		if($this.attr('hoteltype')){
			$this.addClass('font-cl-query-chked');
			$('#search_hotelType').val($this.attr('hoteltype'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_hotelType').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
		}
		
	});
	
	common.ajaxjson({	//获取场地类型列表
		url  : '${ctx}/weixin/hotel/category/query?search_EQ_kind=HOTELTYPE',
		success : function(res){
			
			var html = ['<div class="top-query-item-normal" style="" hoteltype="">不限</div>'];
			var list = res.object;
			for(var i in list){
				html.push('<div class="top-query-item-normal" hoteltype='+list[i].id+' >'+list[i].name+'</div>');
			}
			$('#hotel_type_list').html(html.join(''));
		}
	});
	
	var $citylistparent = $('.city-list-parent');
	$citylistparent.delegate('[cityid]','click',function(){	//城市列表点击事件
		var $this = $(this);
		$('.btn-city-checked').removeClass('btn-city-checked')
		$this.addClass('btn-city-checked');
		$('#search_city').val($this.attr('cityname'));
		$('#search_city_id').val($this.attr('cityid'));
		pager.search();	//查询
		checkAndQuit(0);
	});
	var $hotelquerylist = $('#hotel_query_list');
	$hotelquerylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var history=[];
		var hotel = {"id":$this.attr('data'),"name":$this.text()};
		if(window.localStorage.wxOrderHotelHistory){
			var his = window.localStorage.wxOrderHotelHistory.replace(JSON.stringify(hotel),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(hotel);
	    window.localStorage.wxOrderHotelHistory=JSON.stringify(history);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$('#search_hotelId').val($this.attr('data'));
		pager.search();	//查询
		checkAndQuit(1);
	});
	var $hotelhistorylist = $('#hotel_history_list');
	$hotelhistorylist.delegate('[data]','click',function(){	//历史场地列表点击事件
		var $this = $(this);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$('#search_hotelId').val($this.attr('data'));
		pager.search();	//查询
		checkAndQuit(1);
	});
	
	
	var $orderstatequerylist = $('#order_state_query_list');
	$orderstatequerylist.delegate('[statecode]','click',function(){	//状态列表点击事件
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		$this.addClass('btn-state-checked');
		if($this.attr('statecode')){
			$('#search_state').val($this.attr('statecode'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_state').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
		}
		
	});
	
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
		var res = '';
		if(amount*1>10000){
			res+=common.formatCurrency((amount/10000),2)+"万元";	
		}else{
			res+=common.formatCurrency(amount,2)+"元";	
		}
		return res;
		
	});
	template.helper('commission', function(data){
		var res = '';
		if(data.commissionStatus==='01'&&(data.state=='06'||data.state=='07')){//
			res = '<div class="btn btn-xs bg-type-01" style="float:right;" onclick="commission();" >确定返佣</div>';
		}else if(data.commissionStatus==='06'){
			res = '<div class="btn btn-xs bg-type-06" style="float:right;" >已返佣</div>';
		}else{
			res = '<div class="btn btn-xs bg-type-02" style="float:right;" >'+dict.trsltDict('06',data.commissionStatus)+'</div>';
		}
		return res;
	});
	template.helper('state', function(data){
		var res = '<div class="list-ct-state list-ct-state-'+data.state+' " style="">'+dict.trsltDict('05',data.state)+'</div>';
		return res;
	});
	
	
	$('#btn_order_search').click(function(){
		 var tel = /^(13|15|18|17)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 //$('#form_list_params')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_contactNumber').val(searchVal);
		 }else if(numberReg.test(searchVal)){
			 $('#search_EQ_orderNo').val(searchVal);
		 }else{
			 $('#search_LIKE_hotelName').val(searchVal);
		 }
		 pager.search();
		 
	});
		
});

function initData(index,$target,$topToolbar){
	if(index===1){
		var hotelId = $('#search_hotelId').val();
		var search_cityid = $('#search_city_id').val();
		var url = '${ctx}/wexin/hotel/listAll';
		var hotelName=$("#input_params_hotel_name").val();
		
		if(window.localStorage.wxOrderHotelHistory){
			var history = JSON.parse(window.localStorage.wxOrderHotelHistory);
			var html = [];
			var i=0;
			for(;i<history.length;){
				var str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2" data="'+history[i].id+'" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">'+history[i].name+'</div>';
				if(history===history[i].id+''){
					str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2 btn-hotel-checked" data="'+history[i].id+'" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">'+history[i].name+'</div>';
				}
				html.push(str);
				i++;
			}
			$("#hotel_history_list").html(html.join(''));
        }
		
		$.get(url,{hotelName:hotelName,search_EQ_city:search_cityid},function(data){
			var html = [];
			var i=0;
			var rows = data.rows;
			for(;i<rows.length;){
				var str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2" data="'+rows[i].id+'" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">'+rows[i].hotelName+'</div>';
				if(hotelId===rows[i].id+''){
					str = '<div class="btn btn-query btn-plain bg-none-query col-justify-2 btn-hotel-checked" data="'+rows[i].id+'" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">'+rows[i].hotelName+'</div>';
				}
				html.push(str);
				i++;
			}
			$("#hotel_query_list").html(html.join(''));
			$target.show();
			if($target.height() > $(window).height()){
				$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
			}
		});
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
}

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
	//alert(JSON.stringify(res));
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
    
    $('#search_city').val(cityname);
	$('#search_city_id').val(cityid);
	pager.search();
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
function moreReset(){
	$('.more-item').each(function(index,item){
		var $_this = $(this);
		$_this.removeClass('more-item-active');
		if(index===0){
			$_this.addClass('more-item-active');
		}
	}); 
	$("#hotelNature").show();
	$("#reclaimSale").hide();
	$("#rebatestate").hide();
}
</script>
<!--  {{item | commission}}-->
<script id="temp_list_order" type="text/html">
{{each rows as item i}}
<div class="one-list" style="" item-rdurl="${ctx}/weixin/order/detail/{{item.id}}">
	<div class="one-list-ct-title" style="">
		<div style="display:inline-block;">{{item.hotelName}}</div>
		<div class="list-ct-state list-ct-state-{{item.state}} " style="margin-left:0.5rem;">{{item.state | tp_fn05}}</div>
		<div style="float:right;color:red;">{{item.amount | order_amount}}</div>
	</div>
	<div class="font-size-min" style="margin-top:0.5rem;">订单号：{{item.orderNo}}</div>
	<div class="font-size-min" style="margin-top:0.5rem;">
		<div>活动时间：{{item.activityDate}}</div>
	</div>
	<div class="font-size-min" style="margin-top:0.5rem;">
		<div>客户名称：{{item.organizer}}</div>
	</div>
	<div class="one-list-ct-sett" style="margin-top:0.5rem;">
		<div class="sett-left" style="">地址：{{item.area}}</div>
		<div class="btn btn-xs btn-disabled" style="float:right;background-color:#019FEA;color:#ffffff;min-width:4.2rem;padding:0.3rem 0.8rem;" qx="order:view">查看详情</div>
		<div style="clear:both;"></div>
	</div>
	<div style="clear:both;"></div>
</div>
{{/each}}
</script>
</html>
