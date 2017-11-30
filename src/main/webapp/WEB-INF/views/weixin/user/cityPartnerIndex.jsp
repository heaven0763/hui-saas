<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>城市合伙人</title>
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
		.user-item{
			border-bottom: 1px solid #f5f5f5;
			padding-top: 1rem;
			padding-bottom: 0.5rem
		}
		
		 .state-item-d:nth-child(1){
			border-bottom: 1px solid #cccccc;
		}
		 .state-item-d:nth-child(2){
			border-bottom: 1px solid #cccccc;
		}
		 .state-item-d:nth-child(3){
			border-bottom: 1px solid #cccccc;
		}
		.state-item{width:100%;border-right:1px solid #cccccc;margin: 0.5rem 0;}
		.state-item-nb{ border: none;}
		.pms-hidden{height: 36px; overflow: hidden;}
		.hide{display: none;}
    </style>
</head>

<body class="" style="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	
	<div id="top_toolbar" class="toolbar" style="box-sizing: border-box;">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">地区</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">日期</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">部门</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
		</div>
	</div>
	<div id="top_toolbar_query" class="toolbar-search-parent" style="">
		<div class="toolbar-content dp-none font-gray-01 font-size-min">
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
			<div style="margin:0.5rem 0;text-align: center;">
				<input type="date" id="fdate" class="font-gray-01" style="width:47%;height:1.0rem;padding:0.2rem 0;" />	-
				<input type="date" id="sdate" class="font-gray-01" style="width:47%;height:1.0rem;padding:0.2rem 0;" />	
			</div>
			<div style="width:100%; text-align: center;">
				<div class="btn btn-query  bg-none-query col-justify-2" style="width: 48%;" onclick="date_reset()">重置</div>
				<div id="btn_date_selt" class="btn btn-query  bg-none-query col-justify-2" style="width: 48%;" >确定</div>	
			</div>
		</div>
		<div id="state-list" class="toolbar-content dp-none font-gray-01 font-size-min" style="text-align:center;">
			<c:forEach items="${departments }" var="dept" varStatus="st">
				<div class="state-item-d" style="padding: 0.5rem 0;float:left;width:33%;box-sizing: border-box;">
					<div class="state-item ${st.index%3==2?'state-item-nb':'' }" style="" data="${dept.id }">${dept.unitname }</div>
				</div>
			</c:forEach>
			<!-- <div class="state-item" style="float:left;width:33%;border-right:1px solid #cccccc;box-sizing: border-box;" data="1">在职人员</div>
			<div class="state-item" style="float:left;width:33%;border-right:1px solid #cccccc;box-sizing: border-box;" data="0">离职人员</div>
			<div class="toolbar-query-unlimited" style="float:left;width:33%;">不限</div> -->
			<div style="clear: both;"></div>
		</div>
	</div>
	<div style="height:1.6rem;width:95%;margin:0 auto;margin-top:4rem;">
		<input id="input_search_val" type="text" name="" value="" style="width:72%;background-color:#f5f3f4;border:none;height:100%;outline:none;padding:0 4%;" 
		placeholder="搜索姓名/手机号">
		<div id="btn_order_search" class="icon-search-02" style="width:20%;height:100%;background-color:#FFB42B;float:right;background-size: 30%;background-position:center center;"></div>
	</div>
	<div id="div_list_parent" class="tran-list-ct" style="">
		<!-- <div class="user_list_one" style="" item-rdurl="/hui/weixin/user/staff/detail/fc2aecc8-35af-4dc1-b108-8d91f70a65a4">
			<div class="display-flex">
				<div>
					<span style="font-weight:bold;">韩诗蕊</span>
					<span style="font-size:0.95rem;margin-left:1rem;">地区：广州</span>
				</div>
				<div class="btn btn-xs bg-type-01" style="padding:0.3rem 1rem;">查看详情</div>
			</div>
			<div class="display-flex font-size-min" style="margin:0.5rem 0;">
				<div>合伙人协议到期时间：2019-01-01</div>
				<div>审核状态：<span style="color: #999999;">已通过</span></div>
			</div>
			<div class="display-flex" style="color: #ff0000;margin:0.5rem 0;">
				<div>本年度达成业务：1366456</div>
			</div>
			<div class="font-size-min">
				<div class="display-flex" style="margin:0.5rem 0;">
					<div>联系电话：13664562365</div>
					<div>邮箱：afd@fdg.com</div>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;">
					<div>开拓场地数量：352间</div>
					<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;">导出</div>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;">
					<div>年度接待业务金额：1366456</div>
					<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;">导出</div>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;">
					<div>累计接待业务金额：3625142</div>
					<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;">导出</div>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;">
					<div>管辖人员树状图</div>
					<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;">导出</div>
				</div>
			</div>
		</div> -->

	</div>
	
	<form action="" id="form_list_params" style="display:none;">
		<input id="search_EQ_mobile" type="text" name="search_EQ_u.mobile" />
		<input id="search_LIKE_rname" type="text" name="search_LIKE_u.rname" />
		
		<input id="search_groupid" type="text" name="search_EQ_u.dept_id"  />
		<input id="search_area" type="text" name="search_EQ_c.city"  />
		
		<input id="search_fdate" type="text" name="search_GTE_c.create_date"  />
		<input id="search_sdate" type="text" name="search_LTE_c.create_date"  />
	</form>
	<div class="flex-box flex-justify" style="padding:0.5rem 2%;background-color: #ffffff;position: fixed;width: 96%;bottom:0;font-size: 1rem;">
		<div class="btn btn-xs bg-type-01" style="width:100%;padding:0.5rem 0;font-size: 1rem;" rdurl="${ctx}/weixin/city/partner/create">新增</div>
	</div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>


<script>
common.ctx =  '${ctx}';

$(function(){
	dict.init();
	initCitys();
	var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/city/partner/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_hui_list'
	}); 
	
	template.config('escape', false);
	template.helper('createDate', function(createDate){
		return common.formatDate(createDate,'yyyy-MM-dd');
	});
	template.helper('state', function(state){
		if(state==="0"){
			return '<span style="color: #019FEA;">待审核</span>';
		}else{
			return '<span style="color: #999999;">已通过</span>';
		}
		
		
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
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
	
	$('#top_toolbar_query').delegate('.toolbar-query-unlimited','click',function(){	//不限
		var $this = $(this);
		var $toolbarcontent = $(this).parent();
		switch($toolbarcontent.index()){
		case 0:	//不限城市 
			$toolbarcontent.find('.btn-city-checked').removeClass('btn-city-checked');
			$('#search_area').val('');
			pager.search();	//查询
			break;
		case 1:
			$toolbarcontent.find('.btn-state-checked').removeClass('btn-state-checked');
			$('#search_groupid').val('');
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
		$('#search_area').val($this.attr('cityid'));
		pager.search();	//查询
		checkAndQuit(0);
	});

	
	$('#state-list').delegate('.state-item','click',function(){	//状态点击事件
		var $this = $(this);
		$('.btn-state-checked').removeClass('btn-state-checked')
		$this.addClass('btn-state-checked');
		$('#search_groupid').val($this.attr('data'));
		pager.search();	//查询
		checkAndQuit(2);
	});
	
	
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
	
	$('#btn_date_selt').click(function(){
		if($("#fdate").val()==''&&$("#sdate").val()==''){
			$('#search_fdate').val('');
			$('#search_sdate').val('');
			pager.search();	//查询
			quitWithoutCheck(1);
		}else{
			$('#search_fdate').val($("#fdate").val());
			$('#search_sdate').val($("#sdate").val());
			pager.search();	//查询
			checkAndQuit(1);
		}
	});
	
	$('.item-detail').click(function(){
		$(this).toggleClass('hide');
	});
	
	
	$('#div_list_parent').delegate('.user_list_one','click',function(){	//不限
		var $this = $(this);
		var flag = $this.find('.item-detail').hasClass('hide');
		if(flag){
			$('.item-detail').each(function(){
				var $_this = $(this);
				var _flag = $_this.hasClass('hide');
				if(!_flag){
					$_this.addClass('hide');
				}
			});
		}
		
		$this.find('.item-detail').toggleClass("hide");
	});
});
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

function date_reset(){
	$("#fdate").val('');
	$("#sdate").val('');
}

function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').addClass("mbody");
	$('html').addClass("mhtml");
}

function hideMaskDiv(){
	$('body').removeClass("mbody");
	$('html').removeClass("mhtml");
	$('#mask-full-screen').hide();
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
function exportExcel(type,cmpyId,idx){
	var url = '${ctx}/weixin/city/partner/export/'+type+"?cmpyId="+cmpyId+"&idx="+idx;
	common.ajaxDownload(url);
}
</script>
<!-- item-rdurl="/hui/weixin/user/staff/detail/fc2aecc8-35af-4dc1-b108-8d91f70a65a4" -->
<script id="temp_script_hui_list" type="text/html">
{{each rows as item i}}
<div class="user_list_one" style="" >
	<div class="display-flex">
		<div>
			<span style="font-weight:bold;">{{item.rname}}</span>
			<span style="font-size:0.95rem;margin-left:1rem;">地区：{{item.cityTxt}}</span>
		</div>
		<div class="btn btn-xs bg-type-01" style="padding:0.3rem 1rem;">查看详情</div>
	</div>
	<div class="display-flex font-size-min" style="margin:0.5rem 0;">
		<div>合伙人协议到期时间：{{item.eeffectiveDate | createDate}}</div>
		<div>审核状态：{{item.state | state}}</div>
	</div>
	<div class="display-flex" style="color: #ff0000;margin:0.5rem 0;">
		<div>本年度达成业务：{{item.annualAmount}}</div>
	</div>
	<div class="item-detail font-size-min hide">
		<div class="display-flex" style="margin:0.5rem 0;">
			<div>联系电话：{{item.mobile}}</div>
			<div>邮箱：{{item.email}}</div>
		</div>
		<div class="display-flex" style="margin:0.5rem 0;" onclick="event.cancelBubble = true">
			<div>开拓场地数量：{{item.hotelQuantity}}间</div>
			<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel('hotel',{{item.id}},0)">导出</div>
		</div>
		<div class="display-flex" style="margin:0.5rem 0;" onclick="event.cancelBubble = true">
			<div>年度接待业务金额：{{item.annualAmount}}</div>
			<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel('order',{{item.id}},1)">导出</div>
		</div>
		<div class="display-flex" style="margin:0.5rem 0;" onclick="event.cancelBubble = true">
			<div>累计接待业务金额：{{item.allAmount}}</div>
			<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel('order',{{item.id}},0)">导出</div>
		</div>
		<div class="display-flex" style="margin:0.5rem 0;" onclick="event.cancelBubble = true">
			<div>管辖人员树状图</div>
			<div class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel('staff',{{item.id}},0)">导出</div>
		</div>
	</div>
</div>
{{/each}}
</script>
</html>