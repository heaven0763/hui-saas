<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>场地合作信息</title>
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
		.more-item-active{color: #274082;}
		.partner-city-show-default{min-height: 1rem;}
		.partner-city-list-parent{margin-bottom: 50px;}
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
					<c:if test="${groupMap.iscompanysales }">
						<div class="more-item more-item-active" style="float: left;width: 48%;">场地性质</div>
						<div class="more-item" style="border-left: 1px solid #cccccc;float: left;width: 48%;">城市合伙人</div>
						<div style="clear: both;"></div>
					</c:if>
					<c:if test="${!groupMap.iscompanysales }">
						<div class="more-item more-item-active" style="float: left;width: 33%;">场地性质</div>
						<div class="more-item" style="border-left: 1px solid #cccccc;float: left;width: 33%;">城市合伙人</div>
						<div class="more-item" style="border-left: 1px solid #cccccc;float: left;width: 33%;">销售人员</div>
						<div style="clear: both;"></div>
					</c:if>
				</div>
				<div id="hotelNature">
					<!-- <div style="margin:0.5rem 0;">
						<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
					</div> -->
					<div id="hotel_nature_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="hotel-nature-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" hotelNature="">不限</div>
						<div style="float:left;width:33.33%;font-size:0.85rem;" hotelNature="2">集团</div>
						<div style="float:left;width:33.33%;font-size:0.85rem;" hotelNature="1">单体场地</div>
					</div>
				</div>
				<div id="cityPartner" style="display: none;">
					<div style="margin:0.5rem 0;">
						<input type="text" id="input_params_partner_cityname" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索" />	
					</div>
					
					<div class="toolbar-query-title" style="">当前定位城市</div>
					
					<div class="btn-city-list-parent partner-city-show-default">
						<div class="btn btn-city btn-plain bg-none-city-chk " style="display:none;">广州</div>
					</div>
					
					<div class="toolbar-query-title" style="">历史定位城市</div>
					
					<div id="partner_city_history_list" class="btn-city-list-parent partner-city-show-default">
					</div>
					
					<div class="toolbar-query-title toolbar-query-unlimited partner-city-unlimited" cityid="" cityname=""  style="">不限</div>
					
					<div class="partner-city-list-parent">	</div>
					
				</div>
				<div id="reclaimSale" style="display: none;">
					<!-- <div style="margin:0.5rem 0;">
						<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
					</div> -->
					<div id="reclaim_sale_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
						<div class="reclaim-sale-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" saleId="">不限</div>
						 <c:forEach var="sale" items="${sales}">
							<div style="float:left;width:33.33%;font-size:0.85rem;" saleId="${sale.id}" saleName='${sale.rname}'>${sale.rname}</div>
						</c:forEach> 
					</div>
				</div>
			</div>
		</div>
	<div class="tran-list-ct conent-list" style="width:100%;padding-top:3rem;">
		
		<div id="cooperationinfo_list">
			<!-- <div class="one-item" >
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">碧桂园凤凰城场地</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">类型：场地   性质：集团</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						<div style="font-size:0.8rem;float: left;">地区：广州</div>
						<div style="font-size:0.8rem;float: right;width:auto;">
							返佣权限归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div class="hide" style="color: #999999;font-size:0.8rem;">
					<div style="margin:0.6rem 0;width:100%;">
						开拓场地销售：李玉兰
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						场地联系人：李晓明        13625254104
					</div>
					<div style="margin:0.6rem 0;width:100%;color: red;">
						协议有效期：2016年1月20日——2019年1月19日s
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣计算方式：住房 10%  用餐 10% 会议室 10% 其他 0%
					</div>
				</div>
			</div>
			<div class="one-item" >
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">碧桂园凤凰城场地2</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">类型：场地   性质：集团</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						<div style="font-size:0.8rem;float: left;">地区：广州</div>
						<div style="font-size:0.8rem;float: right;width:auto;">
							返佣权限归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div class="hide" style="color: #999999;font-size:0.8rem;">
					<div style="margin:0.6rem 0;width:100%;">
						开拓场地销售：李玉兰
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						场地联系人：李晓明s        13625254104
					</div>
					<div style="margin:0.6rem 0;width:100%;color: red;">
						协议有效期：2016年1月20日——2019年1月19日
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣计算方式：住房 10%  用餐 10% 会议室 10% 其他 0%
					</div>
				</div>
			</div>
			<div class="one-item" >
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">碧桂园凤凰城场地3</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">类型：场地   性质：集团</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						<div style="font-size:0.8rem;float: left;">地区：广州</div>
						<div style="font-size:0.8rem;float: right;width:auto;">
							返佣权限归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div  class="hide" style="color: #999999;font-size:0.8rem;">
					<div style="margin:0.6rem 0;width:100%;">
						开拓场地销售：李玉兰s
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						场地联系人：李晓明        13625254104
					</div>
					<div style="margin:0.6rem 0;width:100%;color: red;">
						协议有效期：2016年1月20日——2019年1月19日
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣归属：<div class="btn btn-xs btn-hotel-type-1">场地</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣计算方式：住房 10%  用餐 10% 会议室 10% 其他 0%
					</div>
				</div>
			</div> -->
			
		</div>
			
		<form id="form_list_params" style="display:none;">
			<input id="search_city_id" type="text" />
			<input id="search_city" type="text" name="search_EQ_h.city"  />
			<input id="search_hotelId" type="text" name="search_EQ_c.hotel_id"  />
			<input id="search_fdate" type="text" name="fdate"  />
			<input id="search_sdate" type="text" name="sdate"  />
			<input id="search_nature" type="text" name="search_EQ_h.hotel_nature"  /> 
			<input id="search_citypartner" type="text" name="citypartner"  /> 
			<input id="search_saleId" type="text" name="search_EQ_h.reclaim_user_id" value="${groupMap.iscompanysales?guserId:''}"  />
			<!-- p.city =77 and p.hotel_type=39  and p.hotel_id=39 -->
		</form>
	</div>
	<div id="site_rate_adjust_div" class="div-tips-dialog" style="top:30%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;">场地返佣比例调整</div>
 			<div id="btn_adjust_rate_close" class="icon-close"  style="position: absolute;right: 0;top: 0;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
		<div style="padding: 2%;">
			<form id="site_rate_form"  action="${ctx}/weixin/hotel/cooperationinfo/save">
			<input type="hidden" id="cpId" name="cpId" value="">
			<input type="hidden" id="hotelId" name="hotelId" value="">
			<div id="hotelName" style="display:inline-block;font-weight:bold;font-size:1.0rem;">广州长隆场地</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>全单</div><div>原比例  <span id="bfallCommissionRated"></span> %</div><div>调整为：<input type="number" id="bfallCommissionRate" name="afallCommissionRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>会议室</div><div>原比例  <span id="bfmettingRoomCommissionRated"></span>%</div><div>调整为：<input type="number" id="bfmettingRoomCommissionRate" name="afmettingRoomCommissionRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>住房</div><div>原比例  <span id="bfhousingCommissionRated"></span>%</div><div>调整为：<input type="number" id="bfhousingCommissionRate" name="afhousingCommissionRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>用餐</div><div>原比例  <span id="bfdinnerCommissionRated"></span>%</div><div>调整为：<input type="number" id="bfdinnerCommissionRate" name="afdinnerCommissionRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>其他</div><div>原比例  <span id="bfortherCommissionRated"></span>%</div><div>调整为：<input type="number" id="bfortherCommissionRate" name="afortherCommissionRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>积分计算</div><div>原比例  <span id="bfpointsRated"></span>%</div><div>调整为：<input type="number" id="bfpointsRate" name="afpointsRate" style="width: 60px;" max="100" min="0">%</div>
			</div>
			<div style="display: flex;justify-content: space-between;padding: 2% 0;">
				<div>调整原因</div>
				<div style="width: 70%;"><input type="text" id="applyReason" name="applyReason" style="width: 100%;"></div>
			</div>
			</form>
		</div>
		<div style="display: flex;justify-content: space-between;">
			<div id="btn_cancel" class="btn btn-lg bg-type-02" style="margin:0 auto;border-radius:3px;width: 40%;" >取消</div>
			<div id="btn_sure" class="btn btn-lg bg-type-01" style="margin:0 auto;border-radius:3px;width: 40%;" >确认修改</div>
		</div>
		
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>

<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>

<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>

<script>
var pager = null
$(function(){
	pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/hotel/cooperationinfo/list',
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
	$('#cooperationinfo_list').delegate('.itemdetail','click',function(){	//不限
		var $this = $(this);
		var flag = $this.next().hasClass('hide');
		if(flag){
			$('.itemdetail').each(function(){
				var $_this = $(this);
				var _flag = $_this.next().hasClass('hide');
				if(!_flag){
					$_this.next().addClass('hide');
				}
			});
		}
		
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
			$("#cityPartner").show();
			$("#hotelNature").hide();
			$("#reclaimSale").hide();
			if($("#cityPartner").height() > $(window).height()){
				$("#cityPartner").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
			}
			break;
		case 2:
			$('.more-item').each(function(){
				var $_this = $(this);
				$_this.removeClass('more-item-active');
			}); 
			$this.addClass('more-item-active');
			$("#reclaimSale").show();
			$("#cityPartner").hide();
			$("#hotelNature").hide();
			if($("#reclaimSale").height() > $(window).height()){
				$("#reclaimSale").height($(window).height() - $topToolbar.find('.toolbar-title').height() - 60);	//为了弹出的选择框能滚动而设置高度
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
		$('#hotel_query_list').empty();
		pager.search();	//查询
		checkAndQuit(0);
	});
	
	var $partnercitylistparent = $('.partner-city-list-parent');
	$partnercitylistparent.delegate('[cityid]','click',function(){	//城市合伙人列表点击事件
		var $this = $(this);
		var history=[];
		var city = {"id":$this.attr('cityid'),"name":$this.attr('cityName')};
		if(window.localStorage.wxCooperationinfoPartnerCityHistory){
			var his = window.localStorage.wxCooperationinfoPartnerCityHistory.replace(JSON.stringify(city),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(city);
	    window.localStorage.wxCooperationinfoPartnerCityHistory=JSON.stringify(history);
		$partnercitylistparent.find('.btn-city-checked').removeClass('btn-city-checked');
		$this.addClass('btn-city-checked');
		$('#search_citypartner').val($this.attr('cityid'));
		pager.search();	//查询
		checkAndQuit(3);
	});
	
	var $hotelquerylist = $('#hotel_query_list');
	$hotelquerylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var history=[];
		var hotel = {"id":$this.attr('data'),"name":$this.text()};
		if(window.localStorage.wxCooperationinfoHotelHistory){
			var his = window.localStorage.wxCooperationinfoHotelHistory.replace(JSON.stringify(hotel),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(hotel);
	    window.localStorage.wxCooperationinfoHotelHistory=JSON.stringify(history);
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
	
	
	var $hotelnaturequerylist = $('#hotel_nature_query_list');
	$hotelnaturequerylist.delegate('[hotelNature]','click',function(){	//场地性质列表点击事件
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		if($this.attr('hotelNature')){
			$this.addClass('btn-state-checked');
			$('#search_nature').val($this.attr('hotelNature'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_nature').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
			moreReset();
		}
		
	});
	
	$("#cityPartner").delegate('.partner-city-unlimited','click',function(){
		$('.partner-city-list-parent').find('.btn-city-checked').removeClass('btn-city-checked');
		$('#search_citypartner').val('');
		pager.search();	//查询
		quitWithoutCheck(3);
		moreReset();
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
	initPartner();
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});

	$("#btn_adjust_rate_close").click(function(){
		$("#mask-full-screen").css("z-index","66666");
		$("#mask-full-screen").hide();
		$("#site_rate_adjust_div").hide();
		setData(null);
	});
	
	$("#btn_cancel").click(function(){
		$("#mask-full-screen").css("z-index","66666");
		$("#mask-full-screen").hide();
		$("#site_rate_adjust_div").hide();
		setData(null);
	});
	
	var $form = $('#site_rate_form');
	//$form.validate();
	$form.validate({
		rules:{
			afallCommissionRate:"required",
			afmettingRoomCommissionRate:"required",
			afhousingCommissionRate:"required",
			afdinnerCommissionRate:"required",
			afortherCommissionRate:"required",
			afpointsRate:"required",
			applyReason:"required"
		},
		messages:{
			afallCommissionRate:"请输入全单返佣比例",
			afmettingRoomCommissionRate:"请输入会议室返佣比例",
			afhousingCommissionRate:"请输入住房返佣比例",
			afdinnerCommissionRate:"请输入用餐返佣比例",
			afortherCommissionRate:"请输入其他返佣比例",
			afpointsRate:"请输入积分计算比例",
			applyReason:"请输入调整原因"
		}
	});
	$('#btn_sure').click(function(){
		 common.submitForm($form,function(res){
			 common.toast('提交申请成功！');
			 $("#btn_cancel").click();
			 
         },function(res){
			 common.toast(res.message);
 		});
	});
});
function initPartner(){
	$('.partner-city-list-parent').html($(".city-list-parent").prop("innerHTML"));
	if(window.localStorage.wxCooperationinfoPartnerCityHistory){
		var history = JSON.parse(window.localStorage.wxCooperationinfoPartnerCityHistory);
		var html = [];
		var i=0;
		for(;i<history.length;){
			var str = '<div class="btn btn-city btn-plain bg-none-city" cityId="'+history[i].id+'" cityName="'+history[i].name+'">'+history[i].name+'</div>';
			/* if(history===history[i].id+''){
				str = '<div class="btn btn-city btn-plain bg-none-city-chk" cityId="'+history[i].id+'" cityName="'+history[i].name+'">'+history[i].name+'</div>';
			} */
			html.push(str);
			i++;
		}
		$("#partner_city_history_list").html(html.join(''));
	}
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
	$("#cityPartner").hide();
	$("#reclaimSale").hide();
}
function initData(index,$target,$topToolbar){
	//alert(index);
	if(index===1){
		var search_cityid = $('#search_city_id').val();
		var hotelId = $('#search_hotelId').val();
		var url = '${ctx}/wexin/hotel/listAll';
		var hotelName=$("#input_params_hotel_name").val();
		
		
		
		if(window.localStorage.wxCooperationinfoPartnerCityHistory){
			var history = JSON.parse(window.localStorage.wxCooperationinfoHotelHistory);
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
		var ishaving = $("#hotel_query_list").html();
		if(ishaving.trim().length===0){
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
				if($target){
					$target.show();
					if($target.height() > $(window).height()){
						$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
					}
				}
			});
		}else{
			if($target){
				$target.show();
				if($target.height() > $(window).height()){
					$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
				}
			}
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
    $('#search_city').val(cityid);
	$('#search_city_id').val(cityid);
	pager.search();	//查询
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

function updateRate(id){
	
	$.get('${ctx}/weixin/hotel/cooperationinfo/detail/'+id,function(res){
		if(res.statusCode==='200'){
			$("#mask-full-screen").css("z-index","90000");
			$("#mask-full-screen").show();
			$("#site_rate_adjust_div").show();
			setData(res.object);
		}else{
			
		}
	},'json');
}
function setData(obj){
	$("#hotelId").val(obj==null?'':obj.hotelId);  
	$("#cpId").val(obj==null?'':obj.id);
	$("#bfhousingCommissionRate").val(obj==null?'':obj.housingCommission);
	$("#bfdinnerCommissionRate").val(obj==null?'':obj.dinnerCommission); 
	$("#bfmettingRoomCommissionRate").val(obj==null?'':obj.mettingRoomCommission); 
	$("#bfortherCommissionRate").val(obj==null?'':obj.ortherCommission); 
	$("#bfallCommissionRate").val(obj==null?'':obj.allCommission);  
	$("#bfpointsRate").val(obj==null?'':obj.pointsRate);
	$("#hotelName").text(obj==null?'':obj.hotelName);
	
	$("#bfhousingCommissionRated").text(obj==null?'0':obj.housingCommission);
	$("#bfdinnerCommissionRated").text(obj==null?'0':obj.dinnerCommission); 
	$("#bfmettingRoomCommissionRated").text(obj==null?'0':obj.mettingRoomCommission); 
	$("#bfortherCommissionRated").text(obj==null?'0':obj.ortherCommission); 
	$("#bfallCommissionRated").text(obj==null?'0':obj.allCommission);  
	$("#bfpointsRated").text(obj==null?'0':obj.pointsRate);
	
	$("#applyReason").val('');
}

</script>

<script id="temp_list_cooperationinfo" type="text/html">
{{each rows as item i}}
			<div class="one-item" >
				<div class="itemdetail">
					<div style="position:relative;width:100%;vertical-align:bottom;">
						<div style="display:inline-block;font-weight:bold;font-size:1.0rem;">{{item.hotelName}}</div>
						<div style="display:inline-block;margin-left:0.8rem;font-size:0.9rem;color: #019FEA;">类型：{{item.hoteType}}&nbsp;&nbsp;&nbsp;&nbsp;性质：{{item.hotelNature | hotelNature}}</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						<div style="font-size:0.8rem;float: left;">地区：{{item.area}}</div>
						<div style="font-size:0.8rem;float: right;width:auto;">
							返佣权限归属：<div class="btn btn-xs btn-hotel-type-{{item.commissionRights}}">{{item.commissionRights | commissionRights}}</div>
						</div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div  class="hide" style="color: #999999;font-size:0.8rem;">
					<div style="margin:0.6rem 0;width:100%;">
						开拓场地销售：{{item.reclaimUserName}}
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						场地联系人：{{item.linkman}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{item.linkMobile}}
					</div>
					<div style="margin:0.6rem 0;width:100%;color: red;">
						协议有效期：{{item.agreementSDate}}——{{item.agreementEDate}}
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						返佣归属：<div class="btn btn-xs btn-hotel-type-{{item.commissionRights}}">{{item.commissionRights | commissionRights}}</div>
					</div>
					<div style="margin:0.6rem 0;width:100%;">
						<div style="margin:0.3rem 0;width:100%;">返佣计算方式：{{item.commissionType | commissionType}}</div>
						<div style="margin:0.3rem 0;width:100%;">
							
							<div style="display: table-cell;width:80px;vertical-align: top;">返佣比例：</div>
							<div style="display: table-cell;">
							<div style="float:left;">全单&nbsp;&nbsp;{{item.allCommission}}%&nbsp;&nbsp;&nbsp;</div>
							<div style="float:left;">会议室&nbsp;&nbsp;{{item.mettingRoomCommission}}%&nbsp;&nbsp;&nbsp;</div>
							<div style="float:left;">住房&nbsp;&nbsp;{{item.housingCommission}}%&nbsp;&nbsp;&nbsp;</div>
							<div style="float:left;">用餐&nbsp;&nbsp;{{item.dinnerCommission}}%&nbsp;&nbsp;&nbsp;</div>
							<div style="float:left;">其他&nbsp;&nbsp;{{item.ortherCommission}}%</div>
							</div>
						</div>
						<div style="clear: both;"></div>
					</div>
					<div style="margin:0.6rem 0;width:100%;display: flex;justify-content: space-between;" onclick="event.cancelBubble = true">
						<span>积分换算率：{{item.pointsRate}}%</span>
						{{if item.reclaimUserId == '${aUs.getCurrentUserId()}'}}
							<div onclick="updateRate({{item.id}})" class="btn btn-xs" style="background-color: #019FEA;color: #ffffff;padding: 0.3rem 0.5rem;">修改比例</div>
						{{/if}}
					</div>
				</div>
			</div>
{{/each}}

</script>
</html>
