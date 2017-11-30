<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>场地价格调整</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/place.price.css" rel="stylesheet" />
   
    <style type="text/css">
		
	</style>
</head>

 <body style="">
    		
 	<div style="">
 			
 	    <div class="common-ct-inner" style="">
			<div class="input-date-parent" style="">
	  			<div id="month-icon-left" class="date-icon-left" style="">&nbsp;</div>
	   			<input type="month" id="date_year_month"  style=""  /> 
	   			<div id="btn_search" class="icon-search" style="">&nbsp;</div>
	   		</div>
	   		
	   		<div style="font-size:0;margin:0.5rem auto;padding:0 2%;width:96%;">
				<div class="btn btn-md bg-type-01 btn-plain" onOrOff="on" style="width:45%;margin-right:5%;">系统销售价格调整</div>
				<div class="btn btn-md bg-none-00 btn-plain" onOrOff="off" style="width:45%;margin-left:5%;">线下合作销售价格调整</div>
			</div>
  		</div>	
  		
  		
  		<div style="width:100%;text-align:center;font-size:0.75rem;color:#666666;height:1.8rem;line-height:1.8rem;">
	   			<div style="border-bottom:0.15rem solid #cccccc;width:96%;padding:0 2%;">
	   				<div style="width:20%;float:left;"></div>
		    		<div id="date_switch_tab" style="display:table;width:80%;float:right;">
		    			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
		    			<div class="date-day-num" day="6" style="display:table-cell;width:18%;">6</div>
		    			<div class="date-day-num" day="7" style="display:table-cell;width:18%;">7</div>
		    			<div class="date-day-num date-icon-checked" day="8" style="display:table-cell;width:18%;">8</div>
		    			<div class="date-day-num" day="9" style="display:table-cell;width:18%;">9</div>
		    			<div class="date-day-num" day="10" style="display:table-cell;width:18%;">10</div>
		    			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
		    		</div>
	   				<div style="clear:both;"></div>	
	   			</div>
	    		
	    		<div id="list_div_parent" style="">
	    			
	    			
	    			
	    			
	    		</div>
	    		
	    		
	 		</div>
 	</div>
 	<form id="form_list_params" style="display:none;">
	 	  <input type="hidden" id="search_EQ_placeSchedule" name="searchDates" />
	 	  <input type="hidden" id="onOrOff" name="onOrOff" value="on"/>
	 </form>
	 
	 
 	<div id="mask_div" class="mask-div" style="display:none;"></div>
 	<div id="place_date_price_div" class="div-tips-dialog" style="top:20%;left:3%;padding:1rem 2%;width:90%;display:none;">
 		<form id="form_place_date_price_list" class="form_place_date_price_list" style="display:none;">
 			<input type="hidden" id="search_EQ_placeId" name="search_EQ_placeId"  />
 			<input type="hidden" id="search_GTE_onlinePrice"  name="search_GTE_placeSchedule"  />
 			<input type="hidden" id="search_LTE_onlinePrice" name="search_LTE_placeSchedule"  />
 			
 		</form>
 		<div style="position: relative;">
			<div class="place_date_title" style="text-align:left;"> 会议厅 </div>
			<div id="place_date_close" class="icon-close" style="position: absolute;top: 0;right: 0rem;">&nbsp;</div>
		</div>
 		
 		<div style="height:2rem;line-height:2rem;margin-top:1rem;display:flex;justify-content:space-between;">
 			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
 			<div style="font-size:1rem;"><span class="place_year_month">2017年1月</span><span class="place_date_month" >January</span></div>
 			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 	
 		<div style="display:flex;justify-content:space-between;font-size:0.75rem;width:95%;margin:0.5rem; auto;">
 			<div class="date-picker-week-one" style="">Sun</div>
 			<div class="date-picker-week-one" style="">Mon</div>
 			<div class="date-picker-week-one" style="">Tue</div>
 			<div class="date-picker-week-one" style="">Wed</div>
 			<div class="date-picker-week-one" style="">Thu</div>
 			<div class="date-picker-week-one" style="">Fri</div>
 			<div class="date-picker-week-one" style="">Sat</div>
 		</div>
 	
 		<div  class="date-picker-ct">
 		
 		</div>
 	
 		<div id="btn_batch_update_price" class="btn btn-lg bg-type-01" style="margin:1.3rem 0 1rem 0;">一键修改价格</div>
 	</div>
 	<div id="place_price_adjust_div" class="div-tips-dialog" style="top:30%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
 		<form id="form_place_price_adjust" action="${ctx}/weixin/hotel/price/adjust/save"  method="post" >
 		<input type="hidden" id="adjust_price_id" name="search_EQ_placeId" />
 		<input type="hidden" id="adjust_price_type" name="price_type" />
 		<!-- <input type="hidden" id="adjust_price_start_day" name="search_GTE_placeSchedule" />
 		<input type="hidden" id="adjust_price_end_day" name="search_LTE_placeSchedule" /> -->
 		<div class="place_date_title" style="text-align:left;line-height: 1.5rem;">
 			<div id="btn_adjust_price_back" class="date-icon-left"  style="float:left;width:5%;">&nbsp;</div>
 			<div style="float:left;color: 5f5f5f;font-size: 1rem;vertical-align: top;">修改金额</div>
 			<div id="btn_adjust_price_close" class="icon-close"  style="float:right;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="color:#019FEA;margin:0.5rem 0;margin-left:5%;margin-top:1rem;">原来价格：￥<span id="adjust_price_old">12564</span></div>
 		<div style="margin:0.5rem 0;margin-left:5%;">
 		修改日期： 			<input type="date" id="adjust_price_start_day" name="search_GTE_placeSchedule" style="width:31%;height:1.5rem;line-height:1.5rem;"/>
 		&nbsp;-&nbsp;
 		<input type="date" id="adjust_price_end_day" name="search_LTE_placeSchedule" style="width:31%;height:1.5rem;line-height:1.5rem;"/>
 		
 		<!-- <span id="adjust_zh_year_month">2017年01月</span> -->
 		</div>
 		<div style="margin:0.5rem 0;margin-left:5%;">
 			修改价格： 			<input id="adjust_price" type="number" name="adjust_price"  value="" style="width:61%;padding:0 5%;height:1.5rem;line-height:1.5rem;"/>
		</div>
 		<!-- <div style="margin-left:5%;">
 			<input id="adjust_price" type="number" name="adjust_price"  value="" style="-webkit-box-shadow:inset 0 0 1px #ffd1d1;width:85%;padding:0 5%;height:2rem;line-height:2rem;font-size:1.2rem;background-color:#F5F3F3;border:none;outline: none;"/>
 			
 		</div> -->
 		<div id="btn_adjust_price_sumit" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;margin-top:1rem;margin-bottom:1rem;;">确认修改</div>
 		</form>
 	</div>
 	<input type="hidden" id="adjust_curt_date" name="adjust_curt_date" value="${_currDayOfMonth}" />
 	
 	<div id="suc_tips_div" class="div-tips-dialog" style="top:30%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
 		<div class="place_date_title" style="text-align:center;line-height: 1.5rem;padding: 0.5rem;">
 			<div style="color: #000000;font-size: 1rem;vertical-align: top;">修改金额</div>
 		</div>
 		<div style="padding: 0.8rem;">
 			您的价格变动信息已提交，我们将在一个工作日内完成审批，如有特殊情况，将及时与您联系，感谢您的使用。
 		</div>
 		<div style="text-align: right;padding: 0.8rem;">
 			<div id="priceCalendar" style="color:#019FEA; " >返回价格日历界面</div>
 		</div>
 	</div>
</body>


<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
<script src="${ctx}/static/weixin/myjs/place.date.switch.js"></script>
<script src="${ctx}/static/weixin/myjs/place.price.date.js"></script>
<script>

var pager ;
common.ctx = '${ctx}';
$(function(){
	dict.init();

	template.config('escape', false);
	
	template.helper('update_class', function(update_date){
		return update_date? 'last-modify' : '';
	});
	
	var $date_switch_tab = $('#date_switch_tab');
	template.helper('fm_price', function(item){
		var resHtml = [];
		//<div class="{{item.update_date_0 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_0}}</div>
		var price_index = 0;
		$date_switch_tab.find('.date-day-num').each(function(){
			var $this = $(this);
			if(!$this.text()){
				resHtml.push('<div class="" style="display:table-cell;width:18%;">&nbsp;</div>');
			}else{
				resHtml.push('<div class="'+ (item['update_date_'+price_index]? 'last-modify' : '') +'" style="display:table-cell;width:18%;">'+item['price_'+price_index]+'</div>');
				price_index++;
			}
			
		});
		
		return resHtml.join('');
	});
	
	var currPlacePriceDate = new placePriceDate({
		initCallBack : function(){
			currPlacePriceDate.options.$dom_ct.find('.date-picker-ct-one').click(function(){//单个价格修改
				var $this = $(this);
				if($this.attr('date')<=$('#adjust_curt_date').val()){
					toastFn('今天之前的价格不可修改！');
					return ;
				}
				$('#adjust_price_id').val($('#search_EQ_placeId').val());
				$('#adjust_price_start_day').val($this.attr('date'));
				$('#adjust_price_end_day').val($this.attr('date'));
				
				$('#adjust_zh_year_month').html($this.attr('date').replace('-','年').replace('-','月')  + '日');
				$('#adjust_price_old').html($this.find('.date-picker-ct-money').html());
				
				currPlacePriceDate.hide();
				$('#mask_div').show();
				$('#place_price_adjust_div').show();
				
				$('#adjust_price').val('');
			});
		}
	});
	pager = new common.customPage({
		startnow : false,
		url :  '${ctx}/weixin/hotel/price/list',
		form : $('#form_list_params'),
		jqobj : $('#list_div_parent'),
		tmpid : 'temp_list_script',
		callback : function(res,$appendContent){
			$appendContent.each(function(){
				var $this = $(this);
				$this.click(function(){	
					//alert();
					currPlacePriceDate.options.place_id = $this.attr('place_id');
					currPlacePriceDate.options.place_name = $this.attr('place_name');
					currPlacePriceDate.init({
						
					});
				});
			});
		}
	}); 
	
	var $date_year_month = $('#date_year_month');
	var $date_switch_tab = $('#date_switch_tab');
	schedule_data_num = 5;
	initDateSwitchTab($date_year_month,$date_switch_tab,datechageCallBack);
	
	

	$('#btn_search').click(function(){
		var searchDate = $date_year_month.val() +'-'+ $date_switch_tab.find('.date-day-num:first').attr('day');
		searchCallBack(searchDate);
	});
	
	$('[onOrOff]').click(function(){
		$('[onOrOff]').removeClass('bg-type-01').addClass('bg-none-00');
		var $this = $(this);
		$this.removeClass('bg-none-00').addClass('bg-type-01');
		$('#onOrOff').val($this.attr('onOrOff'));
		pager.search();
	});
	
	$('#btn_search').click();
	
	$('#btn_batch_update_price').click(function(){	//一键修改价格
		//$('#adjust_curt_date').val()
		$('#adjust_price_id').val($('#search_EQ_placeId').val());
		var dfd=$('#search_GTE_onlinePrice').val();
		var date = new Date(dfd);
		var curtDate = new Date();
		var firstDateOfMonth = new Date(date.getFullYear(),date.getMonth() ,1);
		
		if(date.getFullYear()===curtDate.getFullYear()&&curtDate.getMonth()===date.getMonth()){
			firstDateOfMonth = new Date(curtDate.getFullYear(),curtDate.getMonth(),curtDate.getDate()+1);
		}
		$('#adjust_price_start_day').val(common.formatDate(firstDateOfMonth));
		$('#adjust_price_end_day').val($('#search_LTE_onlinePrice').val());
		
		$('#adjust_zh_year_month').html(currPlacePriceDate.options.$place_year_month.html());
		$('#adjust_price_old').html(currPlacePriceDate.options.$dom_ct.find('[date]:first').find('.date-picker-ct-money').html());
		
		
		currPlacePriceDate.hide();
		$('#mask_div').show();
		$('#place_price_adjust_div').show();
		$('#adjust_price').val('');
	});
	
	$('#btn_adjust_price_sumit').click(function(){	//确定修改
		if(!$('#adjust_price').val()){
			toastFn('请输入价格！');
			return;
		}
		common.submitForm($('#form_place_price_adjust'),function(res){
			//toastFn('修改价格申请提交成功！');
			pager.search();
		 	$('#place_price_adjust_div').hide();
		 	//$('#mask_div').hide();
	 		$("#suc_tips_div").show();
		 	/* currPlacePriceDate.show();
			var onOrOff = $("#adjust_price_type").val();
			currPlacePriceDate.setData(res.object,onOrOff); */
			
			var ajprice = $('#adjust_price').val();
			var onOrOff = $("#adjust_price_type").val();
			var pstdays = $("#adjust_price_start_day").val().split('-');
			var stday = pstdays[2]*1;
			var edday = ($("#adjust_price_end_day").val().split('-'))[2]*1;
	 		var placeId = $("#search_EQ_placeId").val();
			var placeSchedule = pstdays[0]+"-"+pstdays[1];
			var list = [];
			for(var n=stday;n<=edday;n++){
				var ctday = n<10?'0'+n:n;
				var pprice = { "placeSchedule":placeSchedule+"-"+ctday , "onlinePrice":0, "offlinePrice":0 };
				if("off"===onOrOff){
					pprice.offlinePrice=ajprice;
				}else{
					pprice.onlinePrice=ajprice;
				}
				list.push(JSON.stringify(pprice));
			}
		    common.setstorage('tmp_price_'+placeId+"_"+placeSchedule,"["+list.join(',')+"]");
		    currPlacePriceDate.setData(list,onOrOff); 
		    
		},function(){
			toastFn(res.message);
		});
	});
	$('#mask_div').click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
		$("#suc_tips_div").hide();
	});
	
	$('#btn_adjust_price_back').click(function(){	//修改金额界面返回
		$('#place_price_adjust_div').hide();
		currPlacePriceDate.show();
	});
	$("#month-icon-left").click(function(){
		var date = $("#date_year_month").val();
		var vdate=date.split('-');
		var newdate = new Date(vdate[0],vdate[1] -2,1);
		var mon = (newdate.getMonth()*1+1);
		var nmonth = newdate.getFullYear()+"-"+(mon>9?mon:"0"+mon);
		$("#date_year_month").val(nmonth);
		setCommonWeek(newdate);
	});
	
	$("#btn_adjust_price_close").click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
	});
	
	$("#place_date_close").click(function(){
		currPlacePriceDate.hide();
		$('#place_price_adjust_div').hide();
	});
	$("#priceCalendar").click(function(){
		$("#suc_tips_div").hide();
		currPlacePriceDate.show();
	});
	
});
function priceCalendar(){
	
}
function datechageCallBack(dateStr){
}

function searchCallBack(dateStr){
	var $date_year_month = $('#date_year_month');
	var $date_switch_tab = $('#date_switch_tab');
	var dateStrArray = [];
	$date_switch_tab.find('.date-day-num').each(function(){
		var $this = $(this);
		if(!$this.text()){
			return true;
		}
		var day = $this.text().length < 2? '0'+$this.text() : $this.text();
		dateStrArray.push($date_year_month.val() + '-' + day);
	});
	
	$('#search_EQ_placeSchedule').val(dateStrArray.join(','));
	pager.search();
}


</script>
   
<script id="temp_list_script" type="text/html">
{{each rows as item i}}
	<div class="place_price_list_one" style="border-bottom:0.05rem solid #cccccc;margin:0.5rem 0;width:96%;padding:0 2%;" place_id="{{item.id}}" place_name="{{item.placeName}}" >
		<div style="width:20%;float:left;">{{item.placeName}}</div>
 		<div style="display:table;width:80%;color:#666666;height:1.8rem;line-height:1.8rem;float:right;">
 			<div style="display:table-cell;width:5%;">&nbsp;</div>
			{{item | fm_price}}
 			<div class="" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 		<div style="clear:both;"></div>
	</div>
{{/each}}	    			
</script>
<script id="temp_list_script2" type="text/html">
{{each rows as item i}}
	<div class="place_price_list_one" style="border-bottom:0.05rem solid #cccccc;margin:0.5rem 0;width:96%;padding:0 2%;" place_id="{{item.id}}" place_name="{{item.placeName}}" >
		<div style="width:20%;float:left;">{{item.placeName}}</div>
 		<div style="display:table;width:80%;color:#666666;height:1.8rem;line-height:1.8rem;float:right;">
 			<div style="display:table-cell;width:5%;">&nbsp;</div>
 			<div class="{{item.update_date_0 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_0}}</div>
 			<div class="{{item.update_date_1 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_1}}</div>
 			<div class="{{item.update_date_2 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_2}}</div>
 			<div class="{{item.update_date_3 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_3}}</div>
 			<div class="{{item.update_date_4 | update_class}}" style="display:table-cell;width:18%;">{{item.online_price_4}}</div>
 			<div class="" style="display:table-cell;width:5%">&nbsp;</div>
 		</div>
 		<div style="clear:both;"></div>
	</div>
{{/each}}	    			
</script>

</html>
