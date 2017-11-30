<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>评论查询</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    <style>
    	
    </style>
</head>

<body class="" style="overflow:hidden;">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="top_toolbar" class="toolbar" style="">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">地区</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">场地类型</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">场地</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">评论人群</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
		</div>
		
		<div id="top_toolbar_query" class="toolbar-search-parent">
			<div class="toolbar-content dp-none font-size-min" style="">
				<div style="margin:0.5rem 0;">
					<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
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
					<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
				</div>
				<div id="hotel_type_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
				</div>
			</div>
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div style="margin:0.5rem 0;">
					<input type="text" id="input_params_hotel_name" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
				</div>
				
				<div class="toolbar-query-title" style="">历史搜索结果</div>
				<div id="hotel_history_list" class="query-result" style="width:100%;font-size:0;">
				</div>
				
				<div class="toolbar-query-title" style="">搜索结果</div>
				<div id="hotel_query_list" class="query-result" >
				
				</div>
				
			</div>
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div style="margin:0.5rem 0;">
					<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
				</div>
				<div id="user_type_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
					<div style="float:left;width:33.33%;font-size:0.85rem;" usercode="">不限</div>
					<c:forEach var="dict" items="${usertypeDicts}">
						<c:if test="${dict.code ne 'HUI'}">
							<div style="float:left;width:33.33%;font-size:0.85rem;" usercode="${dict.code}">${dict.detail}</div>
						</c:if>
						
					</c:forEach>
				</div>
			</div>
			
			
		</div>
	</div>

	
	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;overflow-y:scroll;">
		
		
		
	</div>
	
	<!-- <div id="btn_share" class="export-res-parent" style="font-size:0.8rem;">
    	<div class="export-res-first-line"style="margin-top:1.5rem">分享</div>
     </div>  -->   
      
	<form action="" id="form_list_params" style="display:none;">
		<input type="text" name="search_EQ_e.evaluate_type" value="${evaluatetype}" />
		<input id="search_city" type="text" name="search_EQ_e.city"  />
		<input id="search_hotelType" type="text" name="search_EQ_h.hotel_type"  />
		<input id="search_hotelId" type="text" name="search_EQ_h.id"  />
		<input id="search_euserType" type="text" name="search_EQ_e.euser_type"  />
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
		url :  '${ctx}/weixin/order/evaluate/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_${evaluatetype}'
	});
	
	var $topToolbar = $('#top_toolbar');
	var $top_toolbar_query = $('#top_toolbar_query');
	var $topToolbars = $('#top_toolbar .toolbar-one');
	
	//为了列表能滚动而设置高度
	$('#div_list_parent').height($(window).height() - $topToolbar.height());
	
	$topToolbars.click(function(){	//顶部选择
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
		}else{
			$target.show();
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
			break;
		case 2:
			break;
		case 3:
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
	
	$('.city-show-default').delegate('.btn-city','click',function(){	//定位城市 点击事件
		var $this = $(this);
		
		$('.city-list-parent [cityname="'+$this.attr('cityname')+'"]').click();
	});
	
	
	initCitys();
	
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
	
	$('#hotel_type_list').delegate('[hoteltype]','click',function(){	//场地类型点击事件
		var $this = $(this);
		$('#hotel_type_list [hoteltype]').removeClass('font-cl-query-chked');
		if($this.attr('hoteltype')){
			$this.addClass('font-cl-query-chked');
			$('#search_hotelType').val($this.attr('hoteltype'));
			pager.search();	//查询
			checkAndQuit(1);
		}else{
			$('#search_hotelType').val('');
			pager.search();	//查询
			quitWithoutCheck(1);
		}
		
	});
	
	common.ajaxjson({	//获取场地列表
		url  : '${ctx}/weixin/hotel/category/query?search_EQ_kind=HOTELTYPE',
		success : function(res){
			
			var html = ['<div class="top-query-item-normal toolbar-query-unlimited font-cl-query-chked" style="" hoteltype="">不限</div>'];
			var list = res.object;
			for(var i in list){
				html.push('<div class="top-query-item-normal" hoteltype='+list[i].id+' >'+list[i].name+'</div>');
			}
			$('#hotel_type_list').html(html.join(''));
		}
	});
	
	var queryTimeoutId = 0;
	$('#input_params_hotel_name').bind('input',function(event){	//场地输入框改变事件
	    var $this = $(this);
		if(!$this.val()){
			$('#hotel_query_list').empty();
		}else{
			clearTimeout(queryTimeoutId);
			queryTimeoutId = setTimeout(function(){
				queryAndShowHotelDiv();
			},500);
		}
	});
	
	/* $('#div_list_parent').delegate('.one-list','click',function(){
		$(this).find('.eva-toggle-div').toggle();
	}); */
	
	$('#hotel_query_list,#hotel_history_list').delegate('[hotelid]','click',function(){	//场地点击事件
		var $this = $(this);
		$('#hotel_query_list [hotelid]').removeClass('font-cl-query-chked');
		$this.addClass('font-cl-query-chked');
		$('#search_hotelId').val($this.attr('hotelid'));
		
		var historyHotels = common.getstorage('historyHotels');
		var storageHotel = $this.attr('hotelid') + ',' + $this.attr('hotelname') + ';';
		
		historyHotels = historyHotels.replace(storageHotel,'') + storageHotel;
		
		common.setstorage('historyHotels',historyHotels);
		showHistoryHotels();
		
		pager.search();	//查询
		checkAndQuit(2);
	});
	
	$('#user_type_query_list').delegate('[usercode]','click',function(){	//评论人群点击事件
		var $this = $(this);
		$('#user_type_query_list [usercode]').removeClass('font-cl-query-chked');
		if($this.attr('usercode')){
			$this.addClass('font-cl-query-chked');
			$('#search_euserType').val($this.attr('usercode'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_euserType').val('');
			pager.search();	//查询
			quitWithoutCheck(3);
		}
		
	});
	
	showHistoryHotels();
	
	
	$('#btn_share').click(function(){	//分享
		
	});
});

function showHistoryHotels(historyHotels){
	
	historyHotels = historyHotels || common.getstorage('historyHotels');
	var hotelArray = historyHotels.split(';');
	var html = [];
	for(var i in hotelArray){
		var hotel = hotelArray[i].split(',');
		if(!hotel[0]){
			continue;
		}
		html.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" history="1" hotelid="' +hotel[0]+ '" hotelname="'+hotel[1]+'"  >' +hotel[1]+ '</div>');
	}
	html.push('<div style="clear:both;"></div>');	//清除浮动
	$('#hotel_history_list').html(html.join(''));
}



function queryAndShowHotelDiv(){
	common.ajaxjson({
		url  : '${ctx}/wexin/hotel/queryByName',
		type : 'post',
		data : {
			name : $('#input_params_hotel_name').val(),
		},
		success : function(res){
			var html = ['<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" hotelid="">不限</div>'];
			var list = res.object;
			for(var i in list){
				html.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" hotelid='+list[i].id+' hotelname='+list[i].name+' >'+list[i].name+'</div>');
			}
			$('#hotel_query_list').html(html.join(''));
		}
	});
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

function initCitys(){
	var $zimu = $('.city-list-parent [zimu]');
	var citys = data_citys_list;
	var index = 0;
	
	var eleIndex = 0;
	var $element = $zimu.eq(eleIndex);
	var html = [];	
	for(; index < citys.length + 1 ; ){	//遍历城市 json列表
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



</script>

<!-- 将模板引入 -->
<%@include file="/WEB-INF/views/weixin/tp/evaluate.jsp"%> 

</html>
