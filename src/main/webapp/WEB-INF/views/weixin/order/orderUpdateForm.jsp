<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>订单详情</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
     <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   
    <style>
   	 .display-flex{display: flex;justify-content:space-between;}
   	 .state-item{padding: 0.5rem 0;border-bottom:1px solid #f5f5f5;text-align:center;color: #999999;}
   	 .state-item-check{color:#019FEA }
   	 .num{border: none;width:50px;}
   	 .rnum{width: 16px;height: 16px;border: 1px solid #999999;background-color:#f5f5f5; font-style:normal;line-height: 16px;text-align: center; }
   	 .room-num{text-align: center;width: 50px;min-width: 50px;height: 16px;line-height: 18px;}
   	 .meal-type{color: #999999;width: 60px;height: 26px;}
   	 .meal-cgt{color: #999999;width: 60px;height: 26px;}
    </style>
</head>

<body class="">
	<form id="form" action="${ctx}/weixin/order/update/save">
	<input id="id" name="id" type="hidden" value="${order.id}">
	<input id="orderNo" name="orderNo" type="hidden" value="${order.orderNo}">
	<div style="width:96%;margin:0 auto;">
		<div class="font-size-min" style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:3rem;">
			<span  style="font-size: 1rem;">订单号：${order.orderNo}</span> 
		 	<div class="btn btn-xs bg-type-01" style="float:right;padding:0.3rem 0.8rem;" rdurl="${ctx}/weixin/order/modify/logs/${order.id}">查看修改详情</div>
		</div>
		<div style="border-top:1px solid #cccccc;">
			<div style="margin:1.2rem 0;color:#019FEA;font-weight: bold;">活动场地名称：${order.hotelName}</div>
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;">基本信息</div>
		</div>
		
		<div class="font-size-min" style="border-top:1px solid #cccccc;">
			<div style="margin:0.5rem 0;">
				<div style="font-weight:bold;float:left;font-size: 0.85rem;">活动名称：${order.activityTitle}</div>
				<div style="font-weight:bold;color:#019FEA;float:right;">${dSv.trsltDict('05',order.state)}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">地区：${order.area}</div>
				<div style="float:right;">活动时间：${order.activityDate}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div style="float:left;">
					结帐状态：${dSv.trsltDict('07',order.settlementStatus)}
					&nbsp;&nbsp;
					&nbsp;&nbsp;
					<span style="color: #019FEA;border: 1px solid #019FEA;padding-left: 20px;padding-right : 20px;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
				</div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;">活动主办单位：${order.organizer}</div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 60%;">联系方式：<span style="width: 20%;">${order.linkman}</span><span style="float:right;">${order.contactNumber}</span></div>
				<div style="clear:both;"></div>
			</div>
			
			<div style="margin:0.5rem 0;">
				<div style="float:left;width: 60%;">跟进销售：<span style="width: 20%;">${order.hotelSaleName}</span><span style="float:right;">${order.hotelSaleMobile}</span></div>
				<div style="float:right;width: 40%;text-align: right;">积分：${order.hotelPoints}</div>
				<div style="clear:both;"></div>
			</div>
			<div style="margin:0.5rem 0;">
				<div class="btn btn-xs bg-none-00" style="padding-left: 10px;padding-right : 10px;">活动场地选择</div>
			</div>
		</div>
		
		<div class="font-size-min hall" style="border-top:1px solid #cccccc;">
			<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
				<div>${main_hotelplace.placeName}  主会厅</div>
			</div>
			<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
				<span>面积${main_hotelplace.hallArea}m²</span>
				<span>容纳人数${main_hotelplace.peopleNum}人</span>
				<span>层高${main_hotelplace.height}m</span>
				<span>楼层${main_hotelplace.floor}F</span>
				<span>立柱${main_hotelplace.pillar}</span>
			</div>
			<c:forEach items="${main_hotelplace.bookingRecordModels}"  var="bookingRecordModel" >
				<div style="margin:0.5rem 0;">预定档期：${bookingRecordModel.placeDate}&nbsp;&nbsp;${bookingRecordModel.placeSchedule eq 'ALL'?'全天':bookingRecordModel.placeSchedule}
				<span style="float: right;">
					￥<input type="number" class="price" style="width: 80px;" value="${bookingRecordModel.price }" name="placePrice${bookingRecordModel.id}" id="placePrice${bookingRecordModel.id}" onkeyup="priceChange('placePrice',this.value)">
				</span>
				</div>
			</c:forEach>
			
			<c:forEach items="${otherHalls}" var="otherHall">
				<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div>${otherHall.placeName} 分会厅</div>
				</div>
				<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
					<span>面积${otherHall.hallArea}m²</span>
					<span>容纳人数${otherHall.peopleNum}人</span>
					<span>层高${otherHall.height}m</span>
					<span>楼层${otherHall.floor}F</span>
					<span>立柱${otherHall.pillar}</span>
				</div>
				<c:forEach items="${otherHall.bookingRecordModels}"  var="bookingRecordModel" >
					<div style="margin:0.5rem 0;">
						预定档期：${bookingRecordModel.placeDate}&nbsp;&nbsp;${bookingRecordModel.placeSchedule}
						<span style="float: right;">
							￥<input type="number" class="price" style="width: 80px;" value="${bookingRecordModel.price }" name="placePrice${bookingRecordModel.id}" id="placePrice${bookingRecordModel.id}" onkeyup="priceChange('placePrice',this.value)">
						</span>
					</div>
				</c:forEach>
			</c:forEach>
			
			<div style="font-weight:bold;padding-top: 0.5rem;padding-bottom: 0.5rem;">
				<div style="margin:0.5rem 0;">
					<div style="float:left;">场地预定价格：<span id="placePrice_txt"><fmt:formatNumber type="currency" value="${bookPriceCount }" /></span></div>
					<div style="float:right;">场地加收服务费
						<input type="number" id="commissionFeeRate" name="commissionFeeRate" min="0" max="100" style="width: 50px;"  value="${bookServicePercent }" onkeyup="priceChange('placePrice',this.value);">%
					</div>
					<div style="clear:both;"></div>
				</div>
				<div style="margin:0.5rem 0;">小计：<span id="placeSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${bookPriceCount * (1 + bookServicePercent/100)}" /></span></div>
				<input type="hidden" id="placeSumPrice" name="placeSumPrice" value="${bookPriceCount * (1 + bookServicePercent/100)}">
				<input type="hidden" id="placePrice" name="placePrice" value="${bookPriceCount }">
			</div>
			<div style="margin:0.5rem 0;">
				<div class="btn btn-xs bg-none-00">住房场地</div>
			</div>
		</div>
		
		
		<div class="font-size-min roomPrice" style="border-top:1px solid #cccccc;">
			<c:forEach items="${rooms}" var="room">
				<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div>${room.placeName}</div>
				</div>
				
				<c:forEach items="${room.bookingRecordModels}"  var="bookingRecordModel" >
					<div style="margin:0.5rem 0;color: #999999;">
						<span style="">${room.roomType  }&nbsp;&nbsp;${room.network} </span> 
					</div>
					<div class="roomPrice" style="margin:0.5rem 0;">
						<div style="float:left; ">
							早餐：
							<label for="breakfast${bookingRecordModel.id}_1"><input type="radio" name="roomBreakfast${bookingRecordModel.id}" id="breakfast${bookingRecordModel.id}_1" value="" ${bookingRecordModel.breakfast eq '1'?'checked="checked"':'' } >有</label> 
						  	<label for="breakfast${bookingRecordModel.id}_2"><input type="radio" name="roomBreakfast${bookingRecordModel.id}" id="breakfast${bookingRecordModel.id}_2" value="" ${bookingRecordModel.breakfast eq '1'?'checked="checked"':'' } >无</label> 
						</div>
						<div style="float:right;margin-left: 1rem; ">
							<div style="float: left;">数量：</div>
							<div class="rnum room-minus" style="float: left;">-</div>
							<div class="room-num" style="float: left;">
								<input type="number" class="num" style="text-align: center;"  value="${bookingRecordModel.quantity }" name="roomQuantity${bookingRecordModel.id}" id="roomQuantity${bookingRecordModel.id}" 
								onkeyup="priceChange('roomPrice',this.value)">
							</div>
							<div class="rnum room-plus" style="float: left;">+</div>
							<div style="clear: both;"></div>
						</div>
						<div style="clear: both;"></div>
					</div>
					<div style="margin:0.5rem 0;">
						入住时间：${bookingRecordModel.placeDate} ${bookingRecordModel.placeSchedule}
						 <span style="float: right;">
							<%--  <fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /> --%>
						 	￥<input type="number" class="price"  style="width: 80px;" value="${bookingRecordModel.price }" name="roomPrice${bookingRecordModel.id}" id="roomPrice${bookingRecordModel.id}" onkeyup="priceChange('roomPrice',this.value)">/间
						 </span>
					</div>
				</c:forEach>
				
			</c:forEach>
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">
				住房预定价格：<span id="roomPrice_txt"><fmt:formatNumber type="currency" value="${roomPrice}"/></span>
			</div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">小计：
				<span id="roomSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice}"/></span>
				<input type="hidden" id="roomSumPrice" name="roomSumPrice" value="${roomPrice }">
				<input type="hidden" id="roomPrice" name="roomPrice" value="${roomPrice }">
			</div>
			
			<div style="margin:0.5rem 0;">
				<div class="btn btn-xs bg-none-00">用餐选择</div>
			</div>
		</div>
		
		<div class="font-size-min meal" style="border-top:1px solid #cccccc;">
			<c:forEach items="${meals}" var="meal">
				<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div>${meal.placeName}</div>
				</div>
				
				<c:forEach items="${meal.bookingRecordModels}"  var="bookingRecordModel" >
					<div style="margin:0.5rem 0;color: #999999;">
						<select id="mealType${bookingRecordModel.id}" name="mealType${bookingRecordModel.id}" class="meal-type">
							<option value="01" ${bookingRecordModel.mealType eq '01' ?'selected="selected"':'' } >围餐</option>
							<option value="02" ${bookingRecordModel.mealType eq '02' ?'selected="selected"':'' } >自助餐</option>
						</select>
						<select id="mealscheduleTime${bookingRecordModel.id}" name="mealscheduleTime${bookingRecordModel.id}" class="meal-cgt">
							<option value="早餐"  ${bookingRecordModel.placeSchedule eq '早餐' ?'selected="selected"':'' } >早餐</option>
							<option value="午餐"  ${bookingRecordModel.placeSchedule eq '午餐' ?'selected="selected"':'' } >午餐</option>
							<option value="晚餐"  ${bookingRecordModel.placeSchedule eq '晚餐' ?'selected="selected"':'' } >晚餐</option>
						</select>
					</div>
					<div style="margin:0.5rem 0;color: #999999;">
					
						<div style="float:left;">
							<div style="float: left;">数量：</div>
							<div class="rnum meal-minus" style="float: left;">-</div>
							<div class="room-num" style="float: left;">
								<input type="number" class="num" style="text-align: center;"  value="${bookingRecordModel.quantity }" name="mealQuantity${bookingRecordModel.id}" id="mealQuantity${bookingRecordModel.id}" 
								onkeyup="priceChange('roomPrice',this.value)">
							</div>
							<div class="rnum meal-plus" style="float: left;">+</div>
							<div style="clear: both;"></div>
						</div>
						<div style="float:right;margin-left: 1rem; ">
							<div style="float: left;">用餐人数（一围）：</div>
							<div class="rnum mealnum-minus" style="float: left;">-</div>
							<div class="room-num" style="float: left;">
								<input type="number" class="num" style="text-align: center;"  value="${bookingRecordModel.mealnum }" name="mealnum${bookingRecordModel.id}" id="mealnum${bookingRecordModel.id}" 
								onkeyup="priceChange('roomPrice',this.value)">
							</div>
							<div class="rnum mealnum-plus" style="float: left;">+</div>
							<div style="clear: both;"></div>
						</div>
						<div style="clear: both;"></div>
						
						
						<%-- <span style="">${meal.mealType eq '01'?'围餐':'自助餐'}
						&nbsp;&nbsp;${bookingRecordModel.placeSchedule }
						&nbsp;&nbsp;×&nbsp;<input type="number" class="num"  style="width: 80px;border: 1px solid #019FEA;" value="${bookingRecordModel.quantity }" name="mealQuantity${bookingRecordModel.id}" id="mealQuantity${bookingRecordModel.id}" onkeyup="priceChange('mealPrice',this.value)">&nbsp;
                         ${meal.mealType eq '01'?'围':'个'}</span> --%>
                         
					</div>
					<div style="margin:0.5rem 0;">
						用餐时间：${bookingRecordModel.placeDate}
						<span style="float: right;">
						￥<input type="number" class="price"  style="width: 80px;" value="${bookingRecordModel.price }" 
							name="mealPrice${bookingRecordModel.id}" id="mealPrice${bookingRecordModel.id}" onkeyup="priceChange('mealPrice',this.value)">
			            /${bookingRecordModel.mealType eq '01'?'围':'个'}
			             </span>
					</div>
				</c:forEach>
				
			</c:forEach>
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">用餐预定价格：<span id="mealPrice_txt"><fmt:formatNumber type="currency" value="${mealPrice}" /></span></div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">
				小计：<span id="mealSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice}" /></span>
				<input type="hidden" id="mealSumPrice" name="mealSumPrice" value="${mealPrice }">
				<input type="hidden" id="mealPrice" name="mealPrice" value="${mealPrice }">
			</div>
			
		</div>
	</div>
	<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0; ">
		<div style="float: left;margin-left: 2%;">总合计：
			<c:if test="${order.amount>=10000 }">
				<fmt:formatNumber type="currency" value="${order.amount/10000 }" />万元
			</c:if>
			<c:if test="${order.amount<10000 }">
				<fmt:formatNumber type="currency" value="${order.amount }" />
			</c:if>
		</div>
		<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:#cb2b29;font-weight: bold;">掌柜预算：
			<c:if test="${order.zgamount>=10000 }">
				<fmt:formatNumber type="currency" value="${order.zgamount/10000 }" />万元
			</c:if>
			<c:if test="${order.zgamount<10000 }">
				<fmt:formatNumber type="currency" value="${order.zgamount }" />
			</c:if>
		</div>
		<div style="clear: both;"></div>
	</div>
	<div  class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
		<input type="hidden" id="amount" name="amount" value="${order.amount}">
		<input type="hidden" id="zgamount" name="zgamount" value="${order.zgamount}">
		<input type="hidden" id="zgdiscount" name="zgdiscount" value="${order.zgdiscount}">
		<div id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;">确认修改</div>
	</div>
	</form>
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.format.js" type="text/javascript"></script>
<script>
$(function(){
	dict.init();
	

	var $form = $('#form');
	/* $form.validate({
		rules:{
			chkhallid:"required",
			ismain:"required",
			activityTitle:"required",
			activityDate:"required",
			organizer:"required",
			linkman:"required",
			contactNumber:"required"
		},
		messages:{
			chkhallid:"请选择会场",
			ismain:"请选择主会场",
			activityTitle:"请输入活动名称",
			activityDate:"请输入活动时间",
			organizer:"请输入主办单位",
			linkman:"请输入联系人姓名",
			contactNumber:"请输入联系电话"
		}
	}); */
	$("#btn_submit").click(function(){
	    if($form.valid && !$form.valid()){
			return;
		}
	    show();
		var data = $form.serialize();
		$.post($form.attr('action'),data,function(res){
			if(res.statusCode==='200'){
				common.toast('提交成功！');
				 setTimeout(function(){
					location=location;
				 },1500);
			}else{
				hide();
				common.toast(res.message);
			}
		},'json');
		
	});
	
	
	$('.mealnum-minus').click(function(){	
		$this = $(this);
		var num = $this.next().find('input').val()*1;
		if(num*1>0){
			var cnum = num-1;
			$this.next().find('input').val(cnum);
		}else{
		}
		//calculateRoomSchedulePrice();
	});
	
	$('.mealnum-plus').click(function(){	
		$this = $(this);
		var num = $this.prev().find('input').val()*1;
		var cnum = num+1;
		$this.prev().find('input').val(cnum);
		//calculateRoomSchedulePrice();
	});
	
	
	$('.meal-minus').click(function(){	
		$this = $(this);
		var num = $this.next().find('input').val()*1;
		if(num*1>0){
			var cnum = num-1;
			$this.next().find('input').val(cnum);
		}else{
		}
		
		priceChange("mealPrice",0);
	});
	
	$('.meal-plus').click(function(){	
		$this = $(this);
		var num = $this.prev().find('input').val()*1;
		var cnum = num+1;
		$this.prev().find('input').val(cnum);
		priceChange("mealPrice",0);
	});
	
	$('.room-minus').click(function(){	
		$this = $(this);
		var num = $this.next().find('input').val()*1;
		if(num*1>0){
			var cnum = num-1;
			$this.next().find('input').val(cnum);
		}else{
		}
		priceChange("roomPrice",0);
	});
	
	$('.room-plus').click(function(){	
		$this = $(this);
		var num = $this.prev().find('input').val()*1;
		var cnum = num+1;
		$this.prev().find('input').val(cnum);
		priceChange("roomPrice",0);
	});
});

function hide(){
	$('#mask_full_screen').hide();
	//$('body').removeClass("mbody");
	//$('html').removeClass("mhtml");
}
function show(){
	$('#mask_full_screen').show();
	//$('body').addClass("mbody");
	//$('html').addClass("mhtml");
}

function priceChange(type,val){
	if(type==='placePrice'){
		var sumprice = 0;
		$('.hall').find(".price").each(function(){
			sumprice += $(this).val()*1;
	  	});
		
		var commissionFeeRate = $("#commissionFeeRate").val()*1/100;
		var allprice = sumprice*(1+commissionFeeRate);
		
		$("#placePrice_txt").text("￥"+common.formatCurrency(sumprice));
		$("#placeSumPrice_txt").text("￥"+common.formatCurrency(allprice));
		
		$("#placePrice").val(sumprice);
		$("#placeSumPrice").val(allprice);
		
	}else if(type==='roomPrice'){
		var sumprice = 0;
		$('.roomPrice').find(".price").each(function(){
			var id=$(this).attr("id").replace("roomPrice","");
			var num = $("#roomQuantity"+id).val();
			sumprice += $(this).val()*1*num;
	  	});
		$("#roomPrice_txt").text("￥"+common.formatCurrency(sumprice));
		$("#roomSumPrice_txt").text("￥"+common.formatCurrency(sumprice));
		$("#roomSumPrice").val(sumprice);
		$("#roomPrice").val(sumprice);
	}else if(type==='mealPrice'){
		var sumprice = 0;
		$('.meal').find(".price").each(function(){
			var id=$(this).attr("id").replace("mealPrice","");
			var num = $("#mealQuantity"+id).val();
			sumprice += $(this).val()*1*num;
	  	});
		$("#mealPrice_txt").text("￥"+common.formatCurrency(sumprice));
		$("#mealSumPrice_txt").text("￥"+common.formatCurrency(sumprice));
		$("#mealSumPrice").val(sumprice);
		$("#mealPrice").val(sumprice);
	}
	
	var mealSumPrice = $("#mealSumPrice").val()*1;
	var roomSumPrice = $("#roomSumPrice").val()*1;
	var placeSumPrice = $("#placeSumPrice").val()*1;
	var zgdiscount =  $("#zgdiscount").val()*1;
	
	
	var amount = mealSumPrice+roomSumPrice+placeSumPrice;
	var zgamount = (mealSumPrice+roomSumPrice+placeSumPrice)*zgdiscount/100;
	
	$("#amount").val(amount);
	$("#zgamount").val(zgamount);
	
	if(zgamount>100000){
		$("#amount_txt").text("￥"+common.formatCurrency(amount/10000)+"万元");
		$("#zgamount_txt").text("￥"+common.formatCurrency(zgamount/10000)+"万元");
	}else{
		$("#amount_txt").text("￥"+common.formatCurrency(amount));
		$("#zgamount_txt").text("￥"+common.formatCurrency(zgamount));
	}
	
	
}

</script>

</html>
