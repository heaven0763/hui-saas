<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>线下活动录入</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
   <link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/bootstrap-select.min.css" />
    <style>
     .btn{color: #999999;border-color: #999999; }
   	 .display-flex{display: flex;justify-content:space-between;}
   	 .num{width: 16px;height: 16px;border: 1px solid #999999;background-color:#f5f5f5; font-style:normal;line-height: 16px;text-align: center; }
   	 .room-num{text-align: center;width: 50px;min-width: 50px;height: 16px;line-height: 18px;}
   	 .bg-none-00{font-size: 1rem;}
   	 .full{text-align: left;}
   	 .btn-sel-hotel {
	    background-color: #019FEA;
	    color: #ffffff;
	    padding: 0.2rem 0.8rem;
	    font-size: 0.85rem;
	    min-width: 4.2rem;
	    text-align: center;
	}
    </style>
</head>

<body class="">
	<form id="form" action="${ctx}/weixin/order/offline/save">
	<div style="width:96%;margin:0 auto;">
		<div style="border-top:1px solid #cccccc;" class="display-flex">
			<div style="margin:1.2rem 0;color:#019FEA;font-weight: bold;">预定场地名称：<span id="hotelname">${order.hotelName}</span></div>
			<div id="btn-sel-hotel" class="btn-sel-hotel" style="margin:1.2rem 0; height: 35px; text-align: center; line-height: 35px;">选择场地</div>
		</div>
		<div id="detail_content">
			<%-- <div>
				<div style="margin:0.5rem 0;">
					<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">活动场地选择</div>
				</div>
				<div>
					<div class="font-size-min" style="border-top:1px solid #cccccc;">
						<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
							<div>国际宴会厅</div>
							<div style="background-color: #666666;color: #ffffff;padding: 0.2rem 0.8rem;">已选定</div>
						</div>
						<div class="display-flex" style="margin:0.8rem 0;color: #999999;">
							<span>面积105m²</span>
							<span>容纳人数100人</span>
							<span>层高10m</span>
							<span>楼层3F</span>
							<span>立柱8</span>
						</div>
						
						<div style="">
							 <div style="float: left;width: 20%;padding:0.4rem 0;">预定档期：</div>
							 <div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex" >
								 <div style="width: 100%;">
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>&nbsp;&nbsp;
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">上午&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
								 </div>
								 <span><fmt:formatNumber type="currency" value="19825" /></span>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						<div style="">
							 <div style="float: left;width: 20%;padding:0.4rem 0;">预定档期：</div>
							 <div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex" >
								 <div style="width: 100%;">
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>&nbsp;&nbsp;
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">上午&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
								 </div>
								 <span><fmt:formatNumber type="currency" value="19825" /></span>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						<div style="">
							 <div style="float: left;width: 20%;">&nbsp;</div>
							 <div style="float: left;width: 80%;">
								 <div style="width: 100%;padding:0.4rem 0;">
									 <span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">添加</span>
								 </div>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						
						<div class="display-flex" style="margin:0.5rem 0;color:#FFB42B; ">
							<label><input type="checkbox" name="ismain" value="1" onchange="setMain(this);">将此场地设为主会场并选择分会场</label>
						</div>
					</div>
					
					<div class="font-size-min">
						<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
							<div>飞燕厅</div>
							<div style="background-color: #019FEA;color: #ffffff;padding: 0.2rem 1.2rem;">选定</div>
						</div>
						<div class="display-flex" style="margin:0.5rem 0;color: #999999;">
							<span>面积100m²</span>
							<span>容纳人数100人</span>
							<span>层高5m</span>
							<span>楼层6F</span>
							<span>立柱8</span>
						</div>
						
						<div style="">
							 <div style="float: left;width: 20%;padding:0.4rem 0;">预定档期：</div>
							 <div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex" >
								 <div style="width: 100%;">
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>&nbsp;&nbsp;
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">上午&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
								 </div>
								 <span><fmt:formatNumber type="currency" value="19825" /></span>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						<div style="">
							 <div style="float: left;width: 20%;padding:0.4rem 0;">预定档期：</div>
							 <div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex" >
								 <div style="width: 100%;">
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>&nbsp;&nbsp;
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">上午&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
								 </div>
								 <span><fmt:formatNumber type="currency" value="19825" /></span>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						<div style="">
							 <div style="float: left;width: 20%;">&nbsp;</div>
							 <div style="float: left;width: 80%;">
								 <div style="width: 100%;padding:0.4rem 0;">
									 <span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">添加</span>
								 </div>
							 </div>
							  <div style="clear:both;"></div>
						</div>
						<div class="display-flex" style="margin:0.5rem 0;">
							<label><input type="checkbox" name="ismain" value="0">分会场</label>
						</div>
					</div>
				</div>
				<div style="font-weight:bold;padding-top: 0.5rem;padding-bottom: 0.5rem;">
					<div style="margin:0.5rem 0;">
						<div style="float:left;">场地预定价格：<fmt:formatNumber type="currency" value="5475" /></div>
						<div style="float:right;">场地加收服务费<fmt:formatNumber type="number" value="10"  maxFractionDigits="0"/>%</div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin:0.5rem 0;">小计：<span style="color:#cb2b29;"><fmt:formatNumber type="currency" value="6022.5" /></span></div>
				</div>
			</div>
			<div>
				<div style="margin:0.5rem 0;">
					<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">住房场地（团房）</div>
				</div>
				<div>
					<div class="font-size-min" style="border-top:1px solid #cccccc;">
						<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
							<div>皇冠高级房</div>
						</div>
						
						<div>
							<div style="margin:0.5rem 0;color: #999999;">
								<div class="display-flex" >
									<div>
										${room.roomType  }大/双&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}有线免费
									</div> 
									<div>
										<div style="float: left;">数量：</div>
										<div class="num minus" style="float: left;">-</div>
										<div class="room-num" style="float: left;">${bookingRecordModel.quantity }5</div>
										<div class="num plus" style="float: left;">+</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
							<div style="margin:0.5rem 0;">
								 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：${bookingRecordModel.placeDate} ${bookingRecordModel.placeSchedule}</div>
								 <div style="float: left;width: 80%;">
									 <div class="display-flex" style="width: 100%;">
									 	 <span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>
										 <span style=""><fmt:formatNumber type="currency" value="${bookingRecordModel.price }021212" /></span>
									 </div>
								 </div>
								  <div style="clear:both;"></div>
							</div>
						</div>
						<div>
							<div style="margin:0.5rem 0;color: #999999;">
								<div class="display-flex" >
									<div>
										${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}有线免费
									</div> 
									<div>
										<div style="float: left;">数量：</div>
										<div class="num minus" style="float: left;">-</div>
										<div class="room-num" style="float: left;">${bookingRecordModel.quantity }5</div>
										<div class="num plus" style="float: left;">+</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
							<div style="margin:0.5rem 0;">
								 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：${bookingRecordModel.placeDate} ${bookingRecordModel.placeSchedule}</div>
								 <div style="float: left;width: 80%;">
									 <div class="display-flex" style="width: 100%;">
									 	 <span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>
										 <span style=""><fmt:formatNumber type="currency" value="${bookingRecordModel.price }021212" /></span>
									 </div>
								 </div>
								  <div style="clear:both;"></div>
							</div>
						</div>
						<div>
							<div style="margin:0.5rem 0;color: #999999;">
								<div class="display-flex" >
									<div>
										${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}有线免费
									</div> 
									<div>
										<div style="float: left;">数量：</div>
										<div class="num minus" style="float: left;">-</div>
										<div class="room-num" style="float: left;">${bookingRecordModel.quantity }5</div>
										<div class="num plus" style="float: left;">+</div>
										<div style="clear:both;"></div>
									</div>
								</div>
							</div>
							<div style="margin:0.5rem 0;">
								 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：${bookingRecordModel.placeDate} ${bookingRecordModel.placeSchedule}</div>
								 <div style="float: left;width: 80%;">
									 <div class="display-flex" style="width: 100%;">
									 	 <span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请选择档期</span>
										 <input type="number" id="roomschedulePrice_{{roomId}}_{{idx}}" name="roomschedulePrice_{{roomId}}_{{idx}}" value="" idx="{{idx}}" style="width: 60px;height: 26px;" class="roomschedulePrice" onkeyup="calculateRoomSchedulePrice();">
									 </div>
								 </div>
								  <div style="clear:both;"></div>
							</div>
						</div>
						<div style="margin:0.5rem 0;">
							 <div style="float: left;width: 20%;">&nbsp;</div>
							 <div style="float: left;width: 80%;">
								 <div style="width: 100%;padding:0.4rem 0;">
									 <span class="item-add room-add" style="">添加</span>
								 </div>
							 </div>
							  <div style="clear:both;"></div>
						</div>
					</div>
				</div>
				<div style="font-weight:bold;padding-bottom: 0.5rem;">
					<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">住房预定价格：<fmt:formatNumber type="currency" value="${roomPrice}"/></div>
					<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">小计：<div style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="${roomPrice}"/></div></div>
				</div>
			</div>
		
		
			<div>
				<div style="margin:0.5rem 0;">
					<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">用餐选择</div>
				</div>
				<div class="font-size-min" style="border-top:1px solid #cccccc;">
					<div style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
						<div>${meal.placeName}标准国宴</div>
					</div>
					
					<div>
						<div style="margin:0.5rem 0;" class="display-flex">
							
							<div style="width: 50%;">
								<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">围餐&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
								<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">午餐&nbsp;&nbsp;<i class="fa fa-angle-down"></i></span>
							</div>
							<div >
								<div style="float: left;">数量：</div>
								<div class="num minus" style="float: left;">-</div>
								<div class="room-num" style="float: left;">${bookingRecordModel.quantity }5</div>
								<div class="num plus" style="float: left;">+</div>
								<div style="clear:both;"></div>
							</div>
						</div>
						<div style="margin:0.5rem 0;">
							<div style="float: left;width: 20%;padding:0.2rem 0;">用餐时间：</div>
							<div style="float: left;width: 80%;padding:0.2rem 0;" class="display-flex">
								<div>
									<span style="padding:0.2rem 1rem;color: #999999;border: 1px solid #999999;">请用餐时间</span>
								</div>
								<div><span style="float: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }8525" /></span></div>
							</div>
							<div style="clear:both;"></div>
						</div>
					</div>
					<div style="margin:0.5rem 0;">
						 <div style="float: left;width: 20%;">&nbsp;</div>
						 <div style="float: left;width: 80%;">
							 <div style="width: 100%;padding:0.4rem 0;">
								 <span class="item-add room-add" style="">添加</span>
							 </div>
						 </div>
						  <div style="clear:both;"></div>
					</div>
					<div style="font-weight:bold;padding-bottom: 0.5rem;">	
						<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">用餐预定价格：<fmt:formatNumber type="currency" value="${mealPrice}" /></div>
						<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">小计：<div style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="${mealPrice}" /></div></div>
					</div>
				</div>
			 </div>	 --%>
			 
			 
		</div>
	</div>
	
	<div style="width:96%;background-color: #f5f5f5;padding: 1.0rem 2%;" class="display-flex" >
		<div>
			总合计：<span id="amount"><fmt:formatNumber type="currency" value="0" /></span>
		</div>
		<div>
			掌柜预算：<span id="zgamount"><fmt:formatNumber type="currency" value="0" /></span>
		</div>
	</div>

	<div style="padding: 0 2%;">
		<div class="btn btn-xs bg-none-00" style="margin:1rem 0;padding:0.2rem 1.0rem;">基本信息</div> 
	
		<div class="font-size-min" style="border-top:1px solid #cccccc;">
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">活动名称：<input type="text" name="activityTitle" value="${order.activityTitle}" style="width:200px;height: 26px;"> </div>
			</div>
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">活动时间：<input type="date" name="activityDate" value="${order.activityDate}" style="width:200px;height: 26px;"> </div>
			</div>
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">主办单位：<input type="text" name="organizer" value="${order.organizer}" style="width:200px;height: 26px;"> </div>
			</div>
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">联&nbsp;系&nbsp;人&nbsp;：<input type="text" name="linkman" value="${order.linkman}" style="width:200px;height: 26px;"> </div>
			</div>
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">联系方式：<input type="text" name="contactNumber" value="${order.contactNumber}" style="width:200px;height: 26px;"> </div>
			</div>
			<div style="margin:0.8rem 0;">
				<div style="font-weight:bold;font-size: 0.85rem;">电子邮箱：<input type="email" name="email" value="${order.email}" style="width:200px;height: 26px;"> </div>
			</div>
		</div>
	</div>
	<div id="commission_div" class="display-flex" style="width:94%;text-align: center;padding: 3%;">
		<div id="btn_submit" class="btn btn-lg bg-type-01" style="width:100%;margin:0 auto;border-radius:3px;color: #ffffff;">确认提交</div>
		<input type="hidden" id="hotelId" name="hotelId">
	</div>
	</form>
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	<div id="hotels_div" class="div-tips-dialog" style="top:15%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;height: 540px;overflow: hidden;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择场地</div>
 			<!-- <div id="btn_hotels_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> -->
 		</div>
		<div id="hotel_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;height: 480px;overflow: auto;">
			<c:forEach items="${hotels }" var="hotel">
				<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;" hotelid="${hotel.id }" hotelname="${hotel.hotelName }" title="${hotel.hotelName }">${hotel.hotelName }</div>
			</c:forEach>
			<div style="clear: both;"></div>
		</div>
	</div>	
</body>

<script src="${ctx}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
<script src="${ctx}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>

<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
<script src="${ctx}/static/resource/js/bootstrap-select.min.js"></script>
<script>
var o = document.getElementById('date');
$(function(){
	dict.init();
	$("#btn-sel-hotel").click(function(){
		show();
		$("#hotels_div").show();
	});
	
	$("#btn-sel-hotel").click();
	var $hotelquerylist = $('#hotel_list');
	$hotelquerylist.delegate('[hotelid]','click',function(){	//场地列表点击事件
		var $this = $(this);
		$('.btn-hotel-checked').removeClass('btn-hotel-checked')
		$this.addClass('btn-hotel-checked');
		$("#hotelname").text($this.text());
		$("#hotelId").val($this.attr('hotelid'));
		loadDetailContent($this.attr('hotelid'));
		$("#hotels_div").hide();
	});
	
	var $form = $('#form');
	$form.validate({
		rules:{
			chkhallid:"required",
			ismain:"required",
			activityTitle:"required",
			activityDate:"required",
			organizer:"required",
			linkman:"required",
			contactNumber:"required",
			email:"required"
		},
		messages:{
			chkhallid:"请选择会场",
			ismain:"请选择主会场",
			activityTitle:"请输入活动名称",
			activityDate:"请输入活动时间",
			organizer:"请输入主办单位",
			linkman:"请输入联系人姓名",
			contactNumber:"请输入联系电话",
			email:"请输入电子邮箱"
		}
	});
	$("#btn_submit").click(function(){
	    if($form.valid && !$form.valid()){
			return;
		}
		var data = $form.serialize();
		show();
		$.post($form.attr('action'),data,function(res){
			if(res.statusCode==='200'){
				common.toast('提交成功！');
				 setTimeout(function(){
				 	location.href='${ctx}/weixin/order/detail/'+res.object;
				 },1500);
			}else{
				hide();
				common.toast(res.message);
			}
		},'json');
		
	});
});

function loadDetailContent(hotelId){
	$("#detail_content").load('${ctx}/weixin/order/items/index/'+hotelId,function(){
		$("#detail_content").find('.selectpicker').selectpicker();
		$("#detail_content").find('.selectpicker').on('show.bs.select', function (e) {
			var hotelId = $("#hotelId").val();
			var $this = $(this);
			var hallId = $this.attr("hallid");
			var idx = $this.attr("idx");
			var scheduleDate = $("#scheduleDate_"+hallId+"_"+idx).val();
			if(!scheduleDate){
				return false;
			}
			 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
					if(res.statusCode==='200'){
						var k =0;
						for(var i=0;i<res.object.length;i++){
							var pschedule = res.object[i].placeSchedule;
							var price  = res.object[i].onlinePrice;
							var state =  res.object[i].state;
							$this.find('option').each(function(){
								var $self = $(this);
								if($self.val()==pschedule){
									$self.attr("price",price);
									if(state==='2'){
										$self.prop('disabled', true);
										k++;
									}
								}
							});
							$this.attr("price",price);
						}
						$this.selectpicker("refresh"); 
					}else{
						swal(res.message,'success');
					} 
				},"json");
		});
		
		$("#detail_content").find('.selectpicker').on('changed.bs.select', function (e) {
			var $this = $(this);
			var hallId = $this.attr("hallid");
			var idx = $this.attr("idx");
			var price = $this.attr("price");
			var schtimes = $this.val();
			var sumprice = 0;
			if(schtimes!=null){
				if(schtimes.length===4){
					sumprice  = price*3;
				}else{
					sumprice  = price*schtimes.length;
				}
			}
			$("#hallschedulePrice_"+hallId+"_"+idx).val(sumprice);
			calculateHallSchedulePrice()
		});
		$("#detail_content").delegate('.hall-check','click',function(){	
			$this = $(this);
			selectedHall('hall',$this);
		});
		
		$("#detail_content").delegate('.room-check','click',function(){	
			$this = $(this);
			selectedHall('room',$this);
		});
		
		$("#detail_content").delegate('.meal-check','click',function(){	
			$this = $(this);
			selectedHall('meal',$this);
		});
		
		$("#detail_content").delegate('.minus','click',function(){	
			$this = $(this);
			var num = $this.next().find('input').val()*1;
			if(num*1>0){
				var cnum = num-1;
				$this.next().find('input').val(cnum);
			}else{
				
			}
			calculateRoomSchedulePrice();
		});
		
		$("#detail_content").delegate('.plus','click',function(){	
			$this = $(this);
			var num = $this.prev().find('input').val()*1;
			var cnum = num+1;
			$this.prev().find('input').val(cnum);
			calculateRoomSchedulePrice();
			
		});
		
		
		$("#detail_content").delegate('.meal-minus','click',function(){	
			$this = $(this);
			var num = $this.next().find('input').val()*1;
			if(num*1>0){
				var cnum = num-1;
				$this.next().find('input').val(cnum);
			}else{
				
			}
			calculateMealSchedulePrice();
		});
		
		$("#detail_content").delegate('.meal-plus','click',function(){	
			$this = $(this);
			var num = $this.prev().find('input').val()*1;
			var cnum = num+1;
			$this.prev().find('input').val(cnum);
			calculateMealSchedulePrice();
			
		});
		
		
		$("#detail_content").delegate('.hall-add-schedule','click',function(){	//
			var $this = $(this);
			var placeId = $this.attr("hallId");
			var schedule_item_index = $('#scheduleidx'+placeId).val()*1;
			var crt_item_index = schedule_item_index;
			schedule_item_index++;
			var schdl_item = $('#hall_schedule_item').text().split('{{hallId}}').join(placeId);
			schdl_item = schdl_item.split('{{idx}}').join(schedule_item_index);
			var $hall_schedule=$(schdl_item);
			$hall_schedule.find('.date').on("input",function(){
			    if($(this).val().length>0){
				   $(this).addClass("full");
				}else{
				  $(this).removeClass("full");
			  	}
			 });
			
			$hall_schedule.find('.selectpicker').selectpicker();
			$hall_schedule.find('.selectpicker').on('show.bs.select', function (e) {
				var hotelId = $("#hotelId").val();
				var $this = $(this);
				var hallId = $this.attr("hallid");
				var idx = $this.attr("idx");
				var scheduleDate = $("#scheduleDate_"+hallId+"_"+idx).val();
				if(!scheduleDate){
					return false;
				}
				 $.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
						if(res.statusCode==='200'){
							var k =0;
							for(var i=0;i<res.object.length;i++){
								var pschedule = res.object[i].placeSchedule;
								var price  = res.object[i].onlinePrice;
								var state =  res.object[i].state;
								$this.find('option').each(function(){
									var $self = $(this);
									if($self.val()==pschedule){
										$self.attr("price",price);
										if(state==='2'){
											$self.prop('disabled', true);
											k++;
										}
									}
								});
								$this.attr("price",price);
							}
							$this.selectpicker("refresh"); 
						}else{
							swal(res.message,'success');
						} 
					},"json");
			});
			
			$hall_schedule.find('.selectpicker').on('changed.bs.select', function (e) {
				var $this = $(this);
				var hallId = $this.attr("hallid");
				var idx = $this.attr("idx");
				var price = $this.attr("price");
				var schtimes = $this.val();
				var sumprice = 0;
				if(schtimes!=null){
					if(schtimes.length===4){
						sumprice  = price*3;
					}else{
						sumprice  = price*schtimes.length;
					}
				}
				$("#hallschedulePrice_"+hallId+"_"+idx).val(sumprice);
				calculateHallSchedulePrice()
			});
			
			$this.parent().parent().parent().before($hall_schedule);
			$('#scheduleidx'+placeId).val(schedule_item_index);
			
		});
		
		
		$("#detail_content").delegate('.room-add-schedule','click',function(){	//
			var $this = $(this);
			var placeId = $this.attr("roomId");
			var room_schedule_item_index = $('#romscheduleidx'+placeId).val()*1;
			var crt_item_index = room_schedule_item_index;
			room_schedule_item_index++;
			console.log("room_schedule_item_index>>>"+room_schedule_item_index);
			var schdl_item = $('#room_schedule_item').text().split('{{roomId}}').join(placeId);
			schdl_item = schdl_item.split('{{idx}}').join(room_schedule_item_index);
			
			var roomdetail = $this.parent().parent().parent().prev().children(":first").children(":first").children(":first").text();
			schdl_item = schdl_item.replace('{{roomdetail}}',roomdetail);
			var $room_schedule=$(schdl_item);
			$room_schedule.find('.date').on("input",function(){
			    if($(this).val().length>0){
				   $(this).addClass("full");
				}else{
				  $(this).removeClass("full");
			  	}
			 });
			
			$this.parent().parent().parent().before($room_schedule);
			$('#romscheduleidx'+placeId).val(room_schedule_item_index);
		});
		
		$("#detail_content").delegate('.meal-add-schedule','click',function(){	//
			var $this = $(this);
			var placeId = $this.attr("mealId");
			var meal_schedule_item_index = $('#mealscheduleidx'+placeId).val()*1;
			var crt_item_index = meal_schedule_item_index;
			meal_schedule_item_index++;
			var schdl_item = $('#meal_schedule_item').text().split('{{mealId}}').join(placeId);
			schdl_item = schdl_item.split('{{idx}}').join(meal_schedule_item_index);
			var $meal_schedule=$(schdl_item);
			$meal_schedule.find('.date').on("input",function(){
			    if($(this).val().length>0){
				   $(this).addClass("full");
				}else{
				  $(this).removeClass("full");
			  	}
			 });
			
			$this.parent().parent().parent().before($meal_schedule);
			$('#mealscheduleidx'+placeId).val(meal_schedule_item_index);
		});
		
		hide();
	});
	
}
function selectedHall(type,$this){
	if("hall"===type){
		var placeId = $this.attr("hallId");
		if($this.hasClass('item-un-checked')){
			$this.parent().parent().addClass('check');
			$this.removeClass('item-un-checked').addClass('item-checked');
			$this.text('已选定');
			$("#chkhallid"+placeId).attr("checked","checked"); 
		}else{
			$this.parent().parent().removeClass('check')
			$this.removeClass('item-checked').addClass('item-un-checked');
			$this.text('选定');
			$("#chkhallid"+placeId).removeAttr("checked"); 
		}
		calculateHallSchedulePrice();
	}else if("room"===type){
		var placeId = $this.attr("roomId");
		if($this.hasClass('item-un-checked')){
			$this.parent().parent().addClass('check');
			$this.removeClass('item-un-checked').addClass('item-checked');
			$this.text('已选定');
			$("#chkroomid"+placeId).attr("checked","checked"); 
		}else{
			$this.parent().parent().removeClass('check')
			$this.removeClass('item-checked').addClass('item-un-checked');
			$this.text('选定');
			$("#chkroomid"+placeId).removeAttr("checked"); 
		}
		calculateRoomSchedulePrice();
	}else if("meal"===type){
		var mealId = $this.attr("mealId");
		
		if($this.hasClass('item-un-checked')){
			$this.parent().parent().addClass('check');
			$this.removeClass('item-un-checked').addClass('item-checked');
			$this.text('已选定');
			$("#chkmealid"+mealId).attr("checked","checked"); 
		}else{
			$this.parent().parent().removeClass('check')
			$this.removeClass('item-checked').addClass('item-un-checked');
			$this.text('选定');
			$("#chkmealid"+mealId).removeAttr("checked"); 
		}
		
		calculateMealSchedulePrice();
	}
	
}
function getHallSchedule(placeId,scheduleDate,scheduleTime,idx){
	var hotelId = $("#hotelId").val();
	$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate,scheduleTime:scheduleTime},function(res){
		console.log(JSON.stringify(res));
		if(res.statusCode==='200'){
			$("#hallscheduleId_"+placeId+"_"+idx).val(res.object.id);
			if(scheduleTime==='ALL'){
				$("#hallschedulePrice_"+placeId+"_"+idx).val(res.object.onlinePrice*3);
				$("#hallschedulecurrency_"+placeId+"_"+idx).text("￥"+res.object.onlinePrice*3);
			}else{
				$("#hallschedulePrice_"+placeId+"_"+idx).val(res.object.onlinePrice);
				$("#hallschedulecurrency_"+placeId+"_"+idx).text("￥"+res.object.onlinePrice);
			}
			
			calculateHallSchedulePrice();
		}else{
			common.alert(res.message);
		}
	},"json");
}

function getRoomSchedule(placeId,scheduleDate,idx){
	var hotelId = $("#hotelId").val();
	$.get('${ctx}/weixin/order/room/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
		if(res.statusCode==='200'){
			$("#roomscheduleId_"+placeId+"_"+idx).val(res.object.id);
			$("#roomschedulePrice_"+placeId+"_"+idx).val(res.object.onlinePrice);
			$("#roomschedulecurrency_"+placeId+"_"+idx).text("￥"+res.object.onlinePrice);
			calculateRoomSchedulePrice();
		}else{
			common.alert(res.message);
		}
	},"json");
}

function setMain(self){
	$this = $(self);
}
function hide(){
	$('#mask_full_screen').hide();
}
function show(){
	$('#mask_full_screen').show();
}
</script>
<script id="hall_schedule_item" type="text/html">
	<div style="">
		<div style="float: left;width: 20%;padding:0.7rem 0;">预定档期：</div>
		<div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex">
			 <div class="hschedule" style="width: 100%;">
			 	<input type="hidden" id="hallscheduleId_{{hallId}}_{{idx}}" name="hallscheduleId_{{hallId}}_{{idx}}" value="">
				<input type="date" class="hall-schedule date" id="scheduleDate_{{hallId}}_{{idx}}" name="scheduleDate_{{hallId}}_{{idx}}" idx="{{idx}}" hallid="{{hallId}}" placeholder="请选择档期" onchange="hallScheduleDate(this)">
				<div style="">
					<select id="scheduleTime_{{hallId}}_{{idx}}" name="scheduleTime_{{hallId}}_{{idx}}" idx="{{idx}}" hallid="{{hallId}}" class="hall-time selectpicker"  data-actions-box="true" data-width="200px" data-size="10" multiple="multiple"
								 data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选">
						<option value="84">上午</option>
						<option value="85">中午</option>
						<option value="86">下午</option>
						<option value="87">晚上</option>
					</select>
				</div>
			 </div>
			<input type="number" id="hallschedulePrice_{{hallId}}_{{idx}}" name="hallschedulePrice_{{hallId}}_{{idx}}" value="" class="hallschedulePrice" style="width: 60px;height: 26px;" onkeyup="calculateHallSchedulePrice();">
		</div>
		<div style="clear:both;"></div>
	</div>
</script>

<script id="room_schedule_item" type="text/html">
<div>
	<div style="margin:0.5rem 0;color: #999999;">
		<div class="display-flex">
			<div>
				{{roomdetail}}
			</div> 
			<div>
				<div style="float: left;">数量：</div>
				<div class="num minus" roomid="{{roomId}}" idx="{{idx}}" style="float: left;">-</div>
				<div class="room-num" style="float: left;">
					<input type="number" name="rom_num_{{roomId}}_{{idx}}" id="rom_num_{{roomId}}_{{idx}}" value="0" style="border: none;width: 50px;text-align: center;">
				</div>
				<div class="num plus" roomid="{{roomId}}" idx="{{idx}}" style="float: left;">+</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<div style="margin:0.5rem 0;">
		 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：</div>
		 <div style="float: left;width: 80%;">
			 <div class="display-flex" style="width: 100%;">
			 
			 	<input type="hidden" id="roomscheduleId_{{roomId}}_{{idx}}" name="roomscheduleId_{{roomId}}_{{idx}}" value="">
			 	
				<input type="date" class="room-schedule date" id="roomscheduleDate_{{roomId}}_{{idx}}" name="roomscheduleDate_7_{{idx}}" idx="{{idx}}" roomid="{{roomId}}" placeholder="请选择入住时间" style="float: left;" onchange="roomScheduleDate(this)">
				 
				<input type="number" id="roomschedulePrice_{{roomId}}_{{idx}}" name="roomschedulePrice_{{roomId}}_{{idx}}" value="" idx="{{idx}}" style="width: 60px;height: 26px;" class="roomschedulePrice" onkeyup="calculateRoomSchedulePrice();">
			 </div>
		 </div>
		  <div style="clear:both;"></div>
	</div>
</div>
</script>
<script id="meal_schedule_item" type="text/html">
	<div>
		<div style="margin:0.5rem 0;" class="display-flex">
			
			<div style="width: 50%;">
				<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;">
					<select id="mealType_{{mealId}}_{{idx}}" name="mealType_{{mealId}}_{{idx}}" idx="{{idx}}" mealId="{{mealId}}" class="meal-type" onchange="mealType(this)">
						<option value="01">围餐</option>
						<option value="02">自助餐</option>
					</select>
				</div>
				<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
					<select id="mealscheduleTime_{{mealId}}_{{idx}}" name="mealscheduleTime_{{mealId}}_{{idx}}" idx="{{idx}}" mealId="{{mealId}}" class="meal-cgt">
							<option value="84">早餐</option>
							<option value="85">午餐</option>
							<option value="86">晚餐</option>
					</select>
				</div>
			</div>
			<div>
				<div style="float: left;">数量：</div>
				<div class="num meal-minus" style="float: left;">-</div>
				<div class="room-num" style="float: left;">
					<input type="number" name="meal_num_{{mealId}}_{{idx}}" id="meal_num_{{mealId}}_{{idx}}" value="0" style="border: none;width: 50px;text-align: center;">
				</div>
				<div class="num meal-plus" style="float: left;">+</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div style="margin:0.5rem 0;">
			<div style="float: left;width: 20%;padding:0.2rem 0;">用餐时间：</div>
			<div style="float: left;width: 80%;padding:0.2rem 0;" class="display-flex">
				<div>
					<input type="date" class="meal-schedule date" id="mealscheduleDate_{{mealId}}_{{idx}}" name="mealscheduleDate_{{mealId}}_{{idx}}" idx="{{idx}}" mealId="{{mealId}}" placeholder="请选择用餐时间" style="float: left;" onchange="mealScheduleDate(this)">
				</div>
				<div><input type="number" id="mealschedulePrice_{{mealId}}_{{idx}}" name="mealschedulePrice_{{mealId}}_{{idx}}" value="" idx="{{idx}}" class="mealschedulePrice" style="width: 60px;height: 26px;" onkeyup="calculateMealSchedulePrice();"></div>
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>
</script>
</html>
