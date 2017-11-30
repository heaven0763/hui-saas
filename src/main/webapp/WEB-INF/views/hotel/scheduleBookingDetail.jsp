<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
    <style type="text/css">
		
		.book-state-01 .book-list-detail{
			line-height:2rem;
		}
		
		.book-state-01 .book-list-detail{
			display:block;
		}
		.common-ct-inner{
		    width: 100%;
			border-bottom:1px solid #cccccc;
		}
		
		.date-icon-left{
			display:table-cell;;width:5%;
		}
		
		.input-date-parent{
			display:table;width:100%;margin:4px 0;;
		}
		.icon-search{background-size: 35%;}
		.input-date{
			display:table-cell;width:100%;border:none; font-size: 14px;
		}	
		
		.book-list-parent{
			padding:5px 2%;border-bottom:1px solid #cccccc;font-size:0;width: 99.87%;
		}
		
		.book-list-snapshot .btn{
			width:20%;
			margin:5px 0%;
		}
		
		.place_schedule .book-list-snapshot{
			/* display : block; */
		}
		
		.place_schedule .book-list-detail{
			display : none;
		}
		
		.book-state-03{
			background-color:#ff0000;color:#ffffff;
		}
		
		.book-state-03 .btn-xs,.book-state-2 .btn-xs{
			background-color:#ff0000;border-color:#ffffff;
		}
		
		.book-state-2{
			background-color:#ff0000;color:#ffffff;
		}
		
		/* .book-state-2 .book-list-snapshot{
			display : none;
		} */
		
		.book-state-2 .hotel .book-list-snapshot{
			display : none;
		}
		.book-state-2 .hui .book-list-snapshot{
			display : block;
		}
		
		.book-state-2 .hotel .book-list-detail{
			display : block;color:#ffffff;
		}
		.book-state-2 .hui .book-list-detail{
			display : none;color:#ffffff;
		}
		.book-state-2 .bottom-line{
			color:#ffffff;
		}
		/* .book-state-2 .book-list-detail{
			display : block;color:#ffffff;
		} */
		.bottom-line{border-bottom: 1px solid #f5f5f5;}
		.bottom-line:last-child{border: none;}
		.btn-md{font-size: 14px;padding: 6px 12px;}
		.sw-item{display:inline-block;width:15%;font-size:20px;;vertical-align: top;height:36px;line-height:36px;}
		.font-size-min{font-size: 14px;}
		.date-day-num{cursor: pointer;text-align: center;vertical-align: middle;}
		.day-num-text{ border: 1px solid;width: 30px;height: 30px;text-align: center;display: inline-block;border-radius: 15px;}
		
		.date-day-num .full{border-color:#019ce5;color:#019ce5;}
		.date-day-num .some{border-color:#f8ac59;color:#f8ac59;}
		.date-day-num .none{border-color:#c8c8c8;color:#c8c8c8;}
		
		.date-day-num .full-checked{background-color:#019ce5;color:#ffffff;}
		.date-day-num .some-checked{background-color:#f8ac59;color:#ffffff;}
		.date-day-num .none-checked{background-color:#c8c8c8;color:#ffffff;}
		
		.date-day-num .full:HOVER{background-color:#019ce5;color:#ffffff;}
		.date-day-num .some:HOVER{background-color:#f8ac59;color:#ffffff;}
		.date-day-num .none:HOVER{background-color:#c8c8c8;color:#ffffff;}
		
		.point{width: 16px;height: 16px;display: inline-block;border-radius: 50%;vertical-align: middle;margin-right: 5px;}
	</style>

    		
   		<div style="">
   			
   			<div class="common-ct-inner" style="">
   				<div style="width:100%;text-align:center;font-size:20px;margin:20px 0 20px 0;font-weight:bold;">
   					<div style="display:inline-block;font-size:20px;">${hotelPlace.hotelName }</div>
   					<div style="display:inline-block;margin-left:10px;font-size:20px;">${hotelPlace.placeName }</div>
    			</div>
   				<div style="font-size:0;width:96%;height: 40px;">
   					<span class="label label-success" style="padding: 6px 12px;margin: 5px;font-size: 14px;width: 100px;display: inline-block;">会掌柜订单</span>
  					<span class="label label-warning" style="padding: 6px 12px;margin: 5px;font-size: 14px;width: 100px;display: inline-block;">内部订单</span>
    				<!-- <div class="btn btn-md bg-type-01 btn-plain" style="width:32%;">会掌柜</div>
    				<div class="btn btn-md bg-type-02 btn-plain" style="width:32%;margin:0 2%;">场地</div> -->
    				<!-- <div class="btn btn-md bg-type-03 btn-plain" style="width:32%;">拓源公关</div> -->
    			</div>
   				<div class="input-date-parent" style="">
    				<!-- <div class="date-icon-left" style="">&nbsp;</div> -->
	    			<input type="date" id="date_year_month"  style="width:200px;" class="form-control"  /> 
	    			<!-- <div class="icon-search" style="">&nbsp;</div> -->
	    		</div>
	    			
	    		<div style="width:100%;text-align:center;font-size:0.75rem;padding: 5px 0;">
	    			<div style="display:table;width:100%;color:#000000;height:20px;line-height:20px;font-weight: bold;padding: 5px 0;">
		    			<div style="display:table-cell;width:5%;">&nbsp;</div>
		    			<div style="display:table-cell;width:12.85%;">日</div>
		    			<div style="display:table-cell;width:12.85%;">一</div>
		    			<div style="display:table-cell;width:12.85%;">二</div>
		    			<div style="display:table-cell;width:12.85%;">三</div>
		    			<div style="display:table-cell;width:12.85%;">四</div>
		    			<div style="display:table-cell;width:12.85%;">五</div>
		    			<div style="display:table-cell;width:12.85%;">六</div>
		    			<div style="display:table-cell;width:5%;">&nbsp;</div>
		    		</div>
		    		<div id="date_switch_tab" style="display:table;width:100%;color:#666666;height:28px;line-height:28px;font-weight: bold;">
		    			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
		    			<div class="date-day-num" day="6" style="display:table-cell;width:12.85%;"><div class="day-num-text">6</div></div>
		    			<div class="date-day-num" day="7" style="display:table-cell;width:12.85%;"><div class="day-num-text">7</div></div>
		    			<div class="date-day-num" day="8" style="display:table-cell;width:12.85%;"><div class="day-num-text">8</div></div>
		    			<div class="date-day-num" day="9" style="display:table-cell;width:12.85%;"><div class="day-num-text">9</div></div>
		    			<div class="date-day-num" day="10" style="display:table-cell;width:12.85%;"><div class="day-num-text">10</div></div>
		    			<div class="date-day-num" day="11" style="display:table-cell;width:12.85%;"><div class="day-num-text">11</div></div>
		    			<div class="date-day-num" day="12" style="display:table-cell;width:12.85%;"><div class="day-num-text">12</div></div>
		    			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
		    		</div>
		    		
		    		
		    		
		    		<!-- <div id="date_switch_tab" style="display:table;width:100%;color:#666666;height:28px;line-height:28px;font-weight: bold;">
		    			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
		    			<div class="date-day-num" day="6" style="display:table-cell;width:12.85%;">6</div>
		    			<div class="date-day-num" day="7" style="display:table-cell;width:12.85%;">7</div>
		    			<div class="date-day-num date-icon-checked" day="8" style="display:table-cell;width:12.85%;">8</div>
		    			<div class="date-day-num" day="9" style="display:table-cell;width:12.85%;">9</div>
		    			<div class="date-day-num" day="10" style="display:table-cell;width:12.85%;">10</div>
		    			<div class="date-day-num" day="11" style="display:table-cell;width:12.85%;">11</div>
		    			<div class="date-day-num" day="12" style="display:table-cell;width:12.85%;">12</div>
		    			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
		    		</div> -->
    			</div>
    			
    			
    			
    			
   			</div>
    		
   			
   			<div class="common-ct-inner book-list-parent   place_schedule" style="">
   				<div class="sw-item" style="">上午</div>
   				<div class="font-gray-01 book-list-div font-size-min" style="display:inline-block;width:85%;position: relative;">
   					<div class="book-list-detail" style="" >暂无状态</div>
   				</div>
   			</div>
   			
   			<div class="common-ct-inner book-list-parent   place_schedule" style="">
   				<div class="sw-item" style="">中午</div>
   				<div class="font-gray-01 book-list-div font-size-min" style="display:inline-block;width:85%;position: relative;">
   					<div class="book-list-detail" style="" >暂无状态</div>
   				</div>
   			</div>
   			
   			
   			<div class="common-ct-inner book-list-parent   place_schedule" style="">
   				<div  class="sw-item" style="">下午</div>
   				<div class="font-gray-01 book-list-div font-size-min" style="display:inline-block;width:85%;position: relative;">
   					<div class="book-list-detail" style="" >暂无状态</div>
   				</div>
   			</div>
   			
   			
   			<div class="common-ct-inner book-list-parent   place_schedule" style="">
   				<div  class="sw-item" style="">晚上</div>
   				<div class="font-gray-01 book-list-div font-size-min" style="display:inline-block;width:85%;position: relative;">
   					<div class="book-list-detail" style="" >暂无状态</div>
   				</div>
   			</div>
   			
   		</div>
   
  	<input type="hidden" id="crt_sel_day"  value=""/>		
   	<div style="background-color:#000000;width:100%;height:36px;display:table;text-align:center;color:#ffffff;font-size:14px;">
   		<div id="today" style="display:table-cell;width:50%;vertical-align: middle;cursor: pointer;">
   			<div  class="icon-sun" style="display:inline-block;">&nbsp;</div>
   			今日
 		</div>
   		<div id="kalendar"  style="display:table-cell;width:50%;vertical-align: middle;">
   			<!-- <div class="icon-calendar" style="display:inline-block;">&nbsp;</div>日历 -->
   		</div>
   	</div>
	<div class="modal-footer" style="text-align: left;padding: 15px 0;">
		<div style="text-align: left;display: inline-block;vertical-align: middle;width: 58%;">
			<div style="float: left;margin: 0 10px 0 20px;">
				<span class="point" style="background-color: #cccccc;"></span>
				<span style="vertical-align: middle;">无档期<span>
			</div>
			<div style="float: left;margin: 0 10px 0 20px;"><span class="point" style="background-color: #1c84c6;"></span><span style="vertical-align: middle;">有档期</span></div>
			<div style="float: left;margin: 0 10px 0 20px;"><span class="point" style="background-color: #f8ac59;"></span><span style="vertical-align: middle;">有部分档期</span></div>
			<div style="clear: both;"></div>
		</div>
		<div style="text-align: right;display: inline-block;vertical-align: middle;width: 40%;">
		<c:if test="${aUs.getHotelUserType() eq 'HOTEL'}">
			<button id="booking_btn" type="button" qx="schedule:booking"  class="btn btn-primary" onclick="goBooking();">Booking</button>
			<a id="btn-go-booking" qx="schedule:booking" href="/hui/weixin/schedulebooking/place/booking?placeId=${hotelPlace.id }&amp;placeDate=2017-07-26" class="btn btn-primary" target="dialog" style="display: none;">Booking</a>
		</c:if>
		<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭 </button>
		</div>
	</div>
	<input type="hidden" id="hotelId" value="${hotelPlace.hotelId}">
   	<input type="hidden" id="placeId" value="${hotelPlace.id}">
<script src="${ctx}/static/weixin/myjs/schedule.date.switch.js"></script>
<script>
var place_schedule_index = 0;
var place_schedules = '84,85,86,87';
var place_scheduleArray = place_schedules.split(',');
var state_num = 0;
$(function(){
	common.ctx = '${ctx}'
	dict.init();
	common.pms.init();
	
	template.helper('formatName', function(item){
		var str =item.state=='1'?'有预订':item.state=='2'?'已锁定':item.state=='4'?'已取消':'未预定';
		return "${aUs.getCurrentUserType()}"==='HUI'?str:item.hotelSaleName;
	});
	$('.book-list-parent').click(function(){
		var $this = $(this);
		/* if(!$this.hasClass('book-state-2')){	//不处于预定状态下
			return;
		} */
		if("${aUs.getCurrentUserType()}"==='HUI'){
			
		}else{
			var $snapshot = $(this).find('.book-list-snapshot');
			var $detail = $(this).find('.book-list-detail');
			$snapshot.toggle();
			$detail.toggle();
		}
		
		//book-list-snapshot
		//book-list-detail
	});
	
	var $date_year_month = $('#date_year_month');
	var $date_switch_tab = $('#date_switch_tab');
	
	initDateSwitchTab($date_year_month,$date_switch_tab,datechageCallBack);
	$("#today").click(function(){
		var inpuYearMonthArray = '${_currDayOfMonth}'.split('-');
		var date = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1,inpuYearMonthArray[2]);
		setCommonWeek(date);
	});
	$("#kalendar").click(function(){
		$("#sc_kalendar").click();
	});
	$("#sc_kalendar").change(function(){
		var inpuYearMonthArray =$("#sc_kalendar").val().split('-');
		var date = new Date(inpuYearMonthArray[0],inpuYearMonthArray[1] -1,inpuYearMonthArray[2]);
		setCommonWeek(date);
	});
	//var st = getWeekStartDate(new Date(2017,0,28));
	//alert(common.formatDate(st));
	
	
	
});

function goBooking(){
	var crt_sel_day = $("#crt_sel_day").val();
	var url = "${ctx}/weixin/schedulebooking/place/booking?placeId=${placeId}&placeDate="+crt_sel_day;
	$("#btn-go-booking").attr('href',url);
	$("#btn-go-booking").click();
}

function datechageCallBack(dateStr){
	place_schedule_index = 0;
	state_num = 0;
	getScheduleList(dateStr);
}

function getScheduleList(dateStr){
	var placeId = '${placeId}';
	var placeDate = dateStr;
	var placeSchedule = place_scheduleArray[place_schedule_index];
	common.ajaxjson({
		url : '${ctx}/weixin/schedulebooking/place/detail/list',
		data : {
			placeId : '${placeId}',
			place_date : dateStr,
			place_schedule : place_scheduleArray[place_schedule_index]
		},
		success : function(res){
			var $list_target = $('.place_schedule').eq(place_schedule_index).find('.book-list-div');
			$list_target.parent().removeClass('book-state-2' );
			$list_target.parent().removeClass('book-state-1' );
			place_schedule_index++;
			var list = res.object;
			if(list.length < 1){
				$list_target.parent().removeClass('book-state-2' );
				var snapshotHtml = '<div class="display-flex"  ><div style="line-height:36px;">暂无状态</div>';
				snapshotHtml +='</div>';
				var $snapshotHtml = $(snapshotHtml);
				$list_target.html($snapshotHtml); 
			
			}else{
				var firstRow = list[0];
				
				$list_target.parent().addClass('book-state-' + firstRow.state);
				var snapshotHtml = template('temp_list_schedulebooing_snapshot', res);
				snapshotHtml = '<div class="book-list-snapshot">' + snapshotHtml +　'</div>';
				var $snapshotHtml = $(snapshotHtml);
				$list_target.html($snapshotHtml);
				
				if("${aUs.getCurrentUserType()}"==='HUI'){
					$list_target.parent().addClass('hui');
				}else{
					$list_target.parent().addClass('hotel');
					
					var detailHtml = template('temp_list_schedulebooing_detail', res);
					detailHtml = '<div class="book-list-detail">' + detailHtml +　'</div>';
					$list_target.append(detailHtml);
				}
				
				/* if(firstRow.state=='2'){
					state_num++;
				} */
				
			}	
			if(place_schedule_index < 4){
				getScheduleList(dateStr);
			}else{
				clk_flag = 0;
			}
			common.pms.init();
			var crtDate = common.formatDate(new Date());
			if(dateStr<crtDate){
				$("#booking_btn").attr("onclick",'common.alert("过期日期不能预订！");');
			}else{
				if(state_num<4){
					$("#booking_btn").attr("onclick",'goBooking();');
				}else{
					$("#booking_btn").attr("onclick",'common.alert("档期已订满，不能预订！");');
				}
			}
		}
	});
}
function toDetail(orderNo){
	$("#close_btn").click();
	loadContent(this,'${ctx}/weixin/order/mdetail/'+orderNo,'');
}
</script>
   
   
   
<script id="temp_list_schedulebooing_snapshot" type="text/html">
{{each object as item i}}
	<div class="btn-md bg-type-{{item.sourceAppId}} btn-plain" style="color:#ffffff;float:left;margin: 0 5px;text-align: center;">{{item | formatName}}</div>
{{/each}}
</script>

 <script id="temp_list_schedulebooing_detail"  type="text/html">
{{each object as item i}}
	<div class="bottom-line" style="">
		<div style="font-size:0;position:relative;">
			<div class="font-size-min" style="display:inline-block;margin:0 0.5rem;">客户：{{item.linkman}}</div>
			<div class="font-size-min" style="display:inline-block;margin:0 0.5rem;">销售：{{item.hotelSaleName}}</div>
			<div class="btn-md bg-type-{{item.sourceAppId}}" style="display:inline-block;color:#ffffff;padding:5px 3px;margin:0 3px;text-align: center;">{{item.state | tp_fn02}}</div>
			<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
			<div style="display:inline-block;" onclick="event.cancelBubble = true">
				<div class="btn-md bg-type-01" style="color:#ffffff;padding:5px 3px;margin:0 3px;text-align: center;" onclick="toDetail('{{item.orderNo}}')">详情</div>
			</div>
			</c:if>
		</div>
	</div>
	
{{/each}}
</script>
</div>
