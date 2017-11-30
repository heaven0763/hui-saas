<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>场地提成比例审核</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" type="text/css" />
    <style>
		
		.btn-state-left,.btn-state-right{
			width:32%;
		}
	
		.btn-state-left{
			position:absolute;left:18%;
		}
	
		.btn-state-right{
			position:absolute;right:0;
		}
		.one-item{padding: 0 2%;padding-top:1.5rem; border-bottom: 1px solid #cccccc;}
		/* .one-item:last-child {
			border:none;
		}  */
		
		.btn-hotel-type-1{ color: #019FEA;border: 1px solid #019FEA;}
		.btn-hotel-type-2{ color: #FFB635;border: 1px solid #FFB635;}
		.hide{display: none;}
		.show{}
		.more-item-active{color: #274082;}
		.partner-city-show-default{min-height: 1rem;}
		.partner-city-list-parent{margin-bottom: 50px;}
		.btn-pass{display:inline-block;background-color:#FFB635;color: #ffffff;padding: 0.3rem 0.5rem;}
		.btn-nopass{display:inline-block;background-color:#019FEA;color: #ffffff;padding: 0.3rem 0.5rem;}
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
				<div class="copt-more" style="margin:0.5rem 0;width: 100%;text-align: center;font-size:0.85rem;border-bottom:1px solid #cccccc;padding: 0.5rem 0; ">
					<div class="more-item more-item-active" style="width: 33%;float: left;">场地类型</div>
					<div class="more-item" style="width: 33%;border-left: 1px solid #cccccc;float: left;">销售人员</div>
					<div class="more-item" style="width: 33%;border-left: 1px solid #cccccc;float: left;">审核状态</div>
					<div style="clear: both;"></div>
				</div>
				<div id="hotelNature">
					<div style="padding: 0.5rem 5%;background-color: #f5f5f5; ">
						<input id="hotel_type_search" type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;background-color: #f5f5f5;" placeholder="搜索"/>	
					</div>
					<div id="hotel_type_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
					</div>
				</div>
				<div id="reclaimSale" style="display: none;">
					<!-- <div style="margin:0.5rem 0;">
						<input id="sale_search" type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
					</div> -->
					<div style="padding: 0.5rem 5%;background-color: #f5f5f5; ">
						<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;background-color: #f5f5f5;" placeholder="搜索"/>	
					</div>
					<div id="reclaim_sale_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="reclaim-sale-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" saleId="">全部</div>
						 <c:forEach var="sale" items="${sales}">
							<div style="float:left;width:33.33%;font-size:0.85rem;" saleId="${sale.id}" saleName='${sale.rname}'>${sale.rname}</div>
						</c:forEach> 
					</div>
				</div>
				
				<div id="rebatestate" style="display: none;">
					<div id="rebatestate_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="top-query-item-normal" style="" rebatestate="">不限</div>
						<div class="top-query-item-normal" style="" rebatestate="1">已审核</div>
						<div class="top-query-item-normal" style="" rebatestate="0">未审核</div>
					</div>
				</div>
			</div>
		</div>
	<div class="tran-list-ct conent-list" style="width:100%;padding-top:3rem;">
		
		<div id="cooperationinfo_list">
			<!-- <div class="one-item" style="padding-bottom: 0.5rem;">
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">碧桂园凤凰城场地</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">五星级</div>
						<div style="text-align: right;float: right;" onclick="event.cancelBubble = true">
							<div class="btn btn-xs btn-nopass" style="" onclick="nopass(1)">不通过</div>
							<div class="btn btn-xs btn-pass" style="" onclick="pass(1)">通过审核</div>
						</div>
						<div style="clear: both;"></div>
					</div>
					<div class="show" style="width:100%;font-size:0.8rem;"> 
						<div style="float: left;margin:0.3rem 0;">调整返佣比例：</div>
						<div style="float: left;width: 70%;">
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>全单</span>
								<span>原比例<span style="margin-left: 0.5rem;">5%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">8%</span></span>
							</div>
						</div>
						<div style="clear: both;"></div>
					</div>
					<div class="drate hide" style="width:100%;font-size:0.8rem;"> 
						<div style="float: left;margin:0.3rem 0;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div style="float: left;width: 70%;">
							<div style="margin-bottom:0.3rem;display: flex;justify-content: space-between;">
								<span>会议室</span>
								<span>原比例<span style="margin-left: 0.5rem;">5%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">8%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>住房</span>
								<span>原比例<span style="margin-left: 0.5rem;">5%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">8%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>用餐</span>
								<span>原比例<span style="margin-left: 0.5rem;">5%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">8%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>其他</span>
								<span>原比例<span style="margin-left: 0.5rem;">5%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">8%</span></span>
							</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div class="hide" style="margin:0.6rem 0;width:100%;">
					
					<div style="font-size:0.8rem;margin:0.3rem 0;color: #999999;">
						调整原因：
						<span></span>
					</div>
					<div style="font-size:0.8rem;margin:0.3rem 0;display: flex;justify-content: space-between;color: #999999;">
						<span>提交人：</span>
						<span>提交时间：</span>
					</div>
				</div>
			</div> -->
			
		</div>
			
		<form id="form_list_params" style="display:none;">
			<input id="search_city_id" type="text"  />
			<input id="search_city" type="text" name="search_EQ_h.city"  />
			<input id="search_hotelId" type="text" name="search_EQ_c.hotel_id"  />
			<input id="search_fdate" type="text" name="fdate"  />
			<input id="search_sdate" type="text" name="sdate"  />
			<input id="search_hotelType" type="text" name="search_EQ_h.hotel_type"  />
			<input id="search_saleId" type="text" name="search_EQ_h.reclaim_user_id"  />
			<input id="search_rebatestate" type="text" name="search_EQ_c.state" value="0" />
			<!-- p.city =77 and p.hotel_type=39  and p.hotel_id=39 -->
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
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script>
var pager = null;
$(function(){
	pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/hotel/cooperationinfo/site/rebate/check/list',
		form : $('#form_list_params'),
		jqobj : $('#cooperationinfo_list'),
		tmpid : 'temp_list_cooperationinfo'
	}); 
	
	template.config('escape', false);
	template.helper('hotelNature', function(hotelNature){
		var res = hotelNature==='1'?'场地':'集团';
		return res;
	});
	template.helper('commissionRights', function(commissionRights){
		var res = commissionRights==='1'?'场地':'集团';
		return res;
	});
	
	template.helper('commissionType', function(commissionType){
		var res = commissionType==='1'?'全单返':'分项返';
		return res;
	});
	$('#cooperationinfo_list').delegate('.itemdetail','click',function(){
		var $this = $(this);
		var flag = $this.next().hasClass('hide');
		if(flag){
			$('.itemdetail').each(function(){
				var $_this = $(this);
				var _flag = $_this.next().hasClass('hide');
				if(!_flag){
					$_this.next().addClass('hide');
				}
				
				_flag = $_this.find('.drate').hasClass('hide');
				if(!_flag){
					$_this.find('.drate').addClass('hide');
				}
			});
		}
		$this.find('.drate').toggleClass('hide');
		$this.next().toggleClass("hide");
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
			$("#reclaimSale").show();
			$("#hotelNature").hide();
			$("#rebatestate").hide();
			if($("#reclaimSale").height() > $(window).height()){
				$("#reclaimSale").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
			}
			break;
		case 2:
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
		}
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
			
			
			if($this.index()===1){
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
			//alert(0);
			$toolbarcontent.find('.btn-city-checked').removeClass('btn-city-checked');
			//$this.addClass('btn-city-checked');
			$('#search_city').val('');
			$('#search_city_id').val('');
			pager.search();	//查询
			
			break;
		case 1://不限场地
			$toolbarcontent.find('.btn-hotel-checked').removeClass('btn-hotel-checked');
			//$this.addClass('btn-hotel-checked');
			$('#search_hotelId').val('');
			pager.search();	//查询
			break;
		case 2:
			break;
		case 3:
			$toolbarcontent.find('.btn-state-checked').removeClass('btn-state-checked');
			//$this.addClass('btn-state-checked');
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
		$('#search_city').val($this.attr('cityId'));
		$('#search_city_id').val($this.attr('cityId'));
		pager.search();	//查询
		checkAndQuit(0);
	});
	
	
	var $hotelquerylist = $('#hotel_query_list');
	$hotelquerylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var history=[];
		var hotel = {"id":$this.attr('data'),"name":$this.text()};
		if(window.localStorage.siteRebateHotelHistory){
			var his = window.localStorage.siteRebateHotelHistory.replace(JSON.stringify(hotel),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(hotel);
	    window.localStorage.siteRebateHotelHistory=JSON.stringify(history);
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
	
	$('#rebatestate_query_list').delegate('[rebatestate]','click',function(){	//状态列表点击事件
		var $this = $(this);
		$('#rebatestate_query_list').find('.btn-state-checked').removeClass('btn-state-checked')
		if($this.attr('rebatestate')){
			$this.addClass('btn-state-checked');
			$('#search_rebatestate').val($this.attr('rebatestate'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_rebatestate').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
			moreReset();
		}
	});
	
	 $('.city-show-default').delegate('.btn-city','click',function(){	//定位城市 点击事件
		var $this = $(this);
		$('.city-list-parent [cityname="'+$this.attr('cityname')+'"]').click();
	}); 
	$('.partner-city-show-default').delegate('.btn-city','click',function(){	//定位城市 点击事件
		var $this = $(this);
		$('.partner-city-list-parent [cityname="'+$this.attr('cityname')+'"]').click();
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
	
	
	initCitys();
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});

	$('#hotel_type_list').delegate('[hoteltype]','click',function(){	//场地类型点击事件
		var $this = $(this);
		$('#hotel_type_list [hoteltype]').removeClass('font-cl-query-chked');
		$this.addClass('font-cl-query-chked');
		if($this.attr('hoteltype')){
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
	
	
	$("#hotel_type_search").keyup(function(){
		$this = $(this);
		//alert($this.val());
	});
	
	$("#sale_search").keyup(function(){
		$this = $(this);
		//alert($this.val());
	});
	
});

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
function initData(index,$target,$topToolbar){
	//alert(index);
	if(index===1){
		var hotelId = $('#search_hotelId').val();
		var url = '${ctx}/wexin/hotel/listAll';
		var hotelName=$("#input_params_hotel_name").val();
		var search_cityid = $('#search_city_id').val();
		if(window.localStorage.siteRebateHotelHistory){
			var history = JSON.parse(window.localStorage.siteRebateHotelHistory);
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
	pager.search();	//查询
	quitWithoutCheck(2);
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
    
    $('#search_city').val(cityid);
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


function nopass(id){
	showMaskDiv();
	$.post('${ctx}/weixin/hotel/cooperationinfo/site/rebate/check/nopass/'+id,{},function(res){
		toastFn(res.message);
		if(res.statusCode==='200'){
			pager.search();
		}
		hideMaskDiv();
	},'json');
}

function pass(id){
	showMaskDiv();
	$.post('${ctx}/weixin/hotel/cooperationinfo/site/rebate/check/pass/'+id,{},function(res){
		toastFn(res.message);
		if(res.statusCode==='200'){
			pager.search();
		}
		hideMaskDiv();
	},'json');
}

</script>

<script id="temp_list_cooperationinfo" type="text/html">
	{{each rows as item i}}
			<div class="one-item" style="padding-bottom: 0.5rem;">
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">{{item.hotelName}}</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">{{item.star}}</div>
						{{if item.state == '0'}}
						<div style="text-align: right;float: right;" onclick="event.cancelBubble = true">
							<div class="btn btn-xs btn-nopass" style="" onclick="nopass({{item.id}})">不通过</div>
							<div class="btn btn-xs btn-pass" style="" onclick="pass({{item.id}})">通过审核</div>
						</div>
						{{/if}}
						{{if item.state == '1'}}
						<div style="text-align: right;float: right;color: #019FEA;">
							<div class="btn btn-xs bg-none-01" style="" >通过审核</div>
						</div>
						{{/if}}
						{{if item.state == '2'}}
						<div style="text-align: right;float: right;color:#FFB42B;" >
							<div class="btn btn-xs bg-none-02" style="" >不通过</div>
						</div>
						{{/if}}
						<div style="clear: both;"></div>
					</div>
					<div class="show" style="width:100%;font-size:0.8rem;"><!--   -->
						<div style="float: left;margin:0.3rem 0;">调整返佣比例：</div>
						<div style="float: left;width: 70%;">
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>全单</span>
								<span>原比例<span style="margin-left: 0.5rem;">{{item.bfallCommissionRate}}%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">{{item.afallCommissionRate}}%</span></span>
							</div>
						</div>
						<div style="clear: both;"></div>
					</div>
					<div class="drate hide" style="width:100%;font-size:0.8rem;"><!--   -->
						<div style="float: left;margin:0.3rem 0;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div style="float: left;width: 70%;">
							<div style="margin-bottom:0.3rem;display: flex;justify-content: space-between;">
								<span>会议室</span>
								<span>原比例<span style="margin-left: 0.5rem;">{{item.bfmettingRoomCommissionRate}}%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">{{item.afmettingRoomCommissionRate}}%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>住房</span>
								<span>原比例<span style="margin-left: 0.5rem;">{{item.bfhousingCommissionRate}}%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">{{item.afhousingCommissionRate}}%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>用餐</span>
								<span>原比例<span style="margin-left: 0.5rem;">{{item.bfdinnerCommissionRate}}%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">{{item.afdinnerCommissionRate}}%</span></span>
							</div>
							<div style="margin:0.3rem 0;display: flex;justify-content: space-between;">
								<span>其他</span>
								<span>原比例<span style="margin-left: 0.5rem;">{{item.bfortherCommissionRate}}%</span></span>
								<span>调整后比例<span style="margin-left: 0.5rem;">{{item.afortherCommissionRate}}%</span></span>
							</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div class="hide" style="margin:0.6rem 0;width:100%;">
					<div style="font-size:0.8rem;margin:0.3rem 0;color: #999999;">
						调整原因：
						<span>{{item.applyReason}}</span>
					</div>
					<div style="font-size:0.8rem;margin:0.3rem 0;display: flex;justify-content: space-between;color: #999999;">
						<span>提交人：{{item.applyUserName}}</span>
						<span>提交时间：{{item.applyDate}}</span>
					</div>
				</div>
			</div>
	{{/each}}

</script>
</html>
