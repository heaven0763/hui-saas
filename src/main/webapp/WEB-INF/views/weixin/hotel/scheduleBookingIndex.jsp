<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>档期查阅</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
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
		
		.one-list:nth-child(0) {
			border:none;
		}
	
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
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div style="margin:0.5rem 0;">
					<input type="text" class="icon-input-search font-gray-01"style="width:100%;height:0.8rem;padding:0.2rem 0;" placeholder="搜索"/>	
				</div>
				<div id="hotel_type_query_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">
					<div class="hoteltype-unlimited" style="float:left;width:33.33%;font-size:0.85rem;" hoteltype="">不限</div>
					<c:forEach var="dict" items="${categories}">
						<div style="float:left;width:33.33%;font-size:0.85rem;" hoteltype="${dict.id}">${dict.name}</div>
					</c:forEach>
				</div>
			</div>
		</div>
	<div class="tran-list-ct conent-list" style="width:100%;padding-top:3rem;">
		
		<div style="font-size:0;margin:0.5rem auto;padding:0 2%;width:96%;">
			<div class="btn btn-md bg-type-01 btn-plain" style="width:32%;">会掌柜客户</div>
			<div class="btn btn-md bg-type-02 btn-plain" style="width:32%;margin:0 2%;">场地自有客户</div>
			<!-- <div class="btn btn-md bg-type-03 btn-plain" style="width:32%;border:0;">拓源公关</div> -->
		</div>
		
		
		<div class="font-gray-02" style="font-size:0.7rem;padding:0 2%;width:96%;">
			注：蓝色代表会掌柜客户，橙色代表场地自有客户。
		</div>
		
		
		<div id="schedule_booking_list">
			
		
		</div>
			
		<form id="form_list_params" style="display:none;">
			<input id="search_city_id" type="text"/>
			<input id="search_city" type="text" name="search_EQ_p.city"  />
			<input id="search_hotelId" type="text" name="search_EQ_p.hotel_id"  />
			<input id="search_fdate" type="text" name="fdate"  />
			<input id="search_sdate" type="text" name="sdate"  />
			<input id="search_type" type="text" name="search_EQ_p.hotel_type"  /> 
			<!-- p.city =77 and p.hotel_type=39  and p.hotel_id=39 -->
		</form>
	</div>
	
	<form id="form_list_params" style="display:none;"></form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>

<script>
var pager = null;
$(function(){
	dict.init();
	pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/schedulebooking/list',
		form : $('#form_list_params'),
		jqobj : $('#schedule_booking_list'),
		tmpid : 'temp_list_schedulebooing'
	}); 
	template.helper('state', function(state){
		if(state==='1'){
			return '预定';
		}else if(state==='2'){
			return '已交订金';
		}else{
			return '未预定';
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
	
	var $citylistparent = $('.city-list-parent');
	$citylistparent.delegate('[cityid]','click',function(){	//城市列表点击事件
		var $this = $(this);
		$('.btn-city-checked').removeClass('btn-city-checked')
		$this.addClass('btn-city-checked');
		$('#search_city').val($this.attr('cityid'));
		$('#search_city_id').val($this.attr('cityid'));
		pager.search();	//查询
		checkAndQuit(0);
	});
	var $hotelquerylist = $('#hotel_query_list');
	$hotelquerylist.delegate('[data]','click',function(){	//场地列表点击事件
		var $this = $(this);
		var history=[];
		var hotel = {"id":$this.attr('data'),"name":$this.text()};
		if(window.localStorage.wxSchedulebookingHotelHistory){
			var his = window.localStorage.wxSchedulebookingHotelHistory.replace(JSON.stringify(hotel),'').replace(',]',']').replace('[,','[').replace(',,',',');
			history=JSON.parse(his);
        }
		history.push(hotel);
	    window.localStorage.wxSchedulebookingHotelHistory=JSON.stringify(history);
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
	
	
	var $hoteltypequerylist = $('#hotel_type_query_list');
	$hoteltypequerylist.delegate('[hoteltype]','click',function(){	//状态列表点击事件
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		$this.addClass('btn-state-checked');
		if($this.attr('hoteltype')){
			$('#search_type').val($this.attr('hoteltype'));
			pager.search();	//查询
			checkAndQuit(3);
		}else{
			$('#search_type').val('');
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


	
});
function initData(index,$target,$topToolbar){
	//alert(index);
	if(index===1){
		var search_city_id =  $('#search_city_id').val();
		var hotelId = $('#search_hotelId').val();
		var url = '${ctx}/wexin/hotel/listAll';
		var hotelName=$("#input_params_hotel_name").val();
		
		if(window.localStorage.wxOrderHotelHistory){
			var history = JSON.parse(window.localStorage.wxSchedulebookingHotelHistory);
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
		
		$.get(url,{hotelName:hotelName,search_EQ_city:search_city_id},function(data){
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

</script>

<script id="temp_list_schedulebooing" type="text/html">
{{each rows as item i}}
<div class="one-list" style="font-size:0.9rem;">
	<div style="position:relative;width:100%;vertical-align:bottom;">
		<div style="display:inline-block;font-weight:bold;">{{item.hotelName}}</div>
		<div style="display:inline-block;margin-left:0.8rem;">{{item.placeName}}</div>
		<div class="font-gray-01" style="display:inline-block;position:absolute;right:0;bottom:0;font-size:0.75rem;">{{item.clientFrom}}</div>
	</div>
	
	<div class="one-list-ct-sett" style="margin-top:0.6rem;">
		<div class="sett-left" style="">跟进销售：{{item.hotelSaleName}}</div>
		<div class="sett-right" style="">活动时间：{{item.placeDate}}</div>
	</div>
				
	<div style="margin:0.6rem 0;font-size:0;width:100%;position:relative;">
		<div style="display:inline-block;font-size:0.75rem;width:18%;">档期状态</div>
		<div class="btn btn-xs btn-state-left  bg-type-{{item.sourceAppId? item.sourceAppId:'1'}}">{{item.state | state}}</div>
		<div class="btn btn-xs btn-disable btn-state-right" item-rdurl="${ctx}/weixin/schedulebooking/place/detail?placeId={{item.placeId}}">其他档期</div>
	</div>
</div>
{{/each}}

</script>
</html>
