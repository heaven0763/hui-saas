<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
<!--

.hall-schedule {color: #999999;width: 200px;height: 26px;border-radius: 4px; }
.room-schedule{color: #999999;width: 135px;height: 26px;text-align: center;}
.meal-schedule{color: #999999;width: 135px;height: 26px;text-align: center;}
.hall-time{width: 60px;height: 26px;}
.meal-type{color: #999999;width: 58px;height: 26px;border: none;}
.meal-cgt{color: #999999;width: 58px;height: 26px;border: none;}
.font-size-min{font-size: 0.8rem;}
.add{padding:0.3rem 1rem;color: #019FEA;border: 1px solid #019FEA;}
.item-checked{background-color: #666666;color: #ffffff;padding: 0.2rem 0.8rem;font-size: 0.85rem;min-width: 4.2rem;text-align: center;}
.item-un-checked{background-color: #019FEA;color: #ffffff;padding: 0.2rem 0.8rem;font-size: 0.85rem;min-width: 4.2rem;text-align: center;}
.btn-default{height: 26px;padding: 0; }
.btn-group-sm>.btn, .btn-sm{padding: 0;}
-->
</style>
<div>
	<div style="margin:0.5rem 0;">
		<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">活动场地选择</div>
	</div>
	<div>
		<c:forEach items="${halls}" var="hall">
			<div class="font-size-min" style="border-top:1px solid #cccccc;">
				<input type="hidden" id="hallid${hall.id }" name="hallid${hall.id }" value="${hall.id }">
				<input type="checkbox" id="chkhallid${hall.id }" name="chkhallid" value="${hall.id }" style="width: 0;height: 0;">
				<input type="hidden" id="scheduleidx${hall.id }" name="scheduleidx${hall.id }" value="1" >
				<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 1rem;">
					<div>${hall.placeName }</div>
					<div class="hall-check item-un-checked" hallId="${hall.id}" style="">选定</div>
				</div>
				<div class="display-flex" style="margin:0.8rem 0;color: #999999;">
					<span>面积${hall.hallArea }m²</span>
					<span>容纳人数${hall.peopleNum }人</span>
					<span>层高${hall.height }m</span>
					<span>楼层${hall.floor }F</span>
					<span>立柱${hall.pillar }</span>
				</div>
				
				<div id="schedule_item_1" style="">
					 <div style="float: left;width: 20%;padding:0.7rem 0;">预定档期：</div>
					 <div style="float: left;width: 80%;padding:0.4rem 0;" class="display-flex" >
						 <div class="hschedule" style="width: 100%;">
						 	<input type="hidden" id="hallscheduleId_${hall.id}_1" name="hallscheduleId_${hall.id}_1" value="">
							<input type="date" class="hall-schedule date" id="scheduleDate_${hall.id}_1" name="scheduleDate_${hall.id}_1" idx="1" hallId="${hall.id}"
							 placeholder="请选择档期" onchange="hallScheduleDate(this)">
							<div style="margin: 5px 0;">
								
								<select id="scheduleTime_${hall.id}_1" name="scheduleTime_${hall.id}_1" idx="1" hallId="${hall.id}" class="hall-time selectpicker"  data-actions-box="true" data-width="200px" data-size="10" multiple="multiple"
								 data-title="请选择" data-deselect-all-text="全不选" data-select-all-text="全选" >
									<c:forEach items="${ctimes}" var="ctme">
										<option value="${ctme.id}">${ctme.name}</option>
									</c:forEach>
									<!-- <option value="ALL">全天</option> -->
								</select>
							</div>
						 </div>
						 <%-- <span id="hallschedulecurrency_${hall.id}_1" style="padding:0.4rem 0;"><fmt:formatNumber type="currency" value="0" /></span> --%>
						 <input type="number" id="hallschedulePrice_${hall.id}_1" name="hallschedulePrice_${hall.id}_1" value="" class="hallschedulePrice" style="width: 60px;height: 26px;" onkeyup="calculateHallSchedulePrice();">
					 </div>
					  <div style="clear:both;"></div>
				</div>
				<div style="">
					 <div style="float: left;width: 20%;">&nbsp;</div>
					 <div style="float: left;width: 80%;">
						 <div style="width: 100%;padding:0.4rem 0;">
							 <span class="add hall-add-schedule" style="" hallId="${hall.id}">添加</span>
						 </div>
					 </div>
					  <div style="clear:both;"></div>
				</div>
				
				<div class="display-flex" style="margin:0.5rem 0;color:#FFB42B; ">
					<label><input type="radio" name="ismain" value="${hall.id }"  onchange="setMain(this);">将此场地设为主会场并选择分会场</label>
				</div>
			</div>
		</c:forEach>
	</div>
	<div style="font-weight:bold;padding-top: 0.5rem;padding-bottom: 0.5rem;">
		<div style="margin:0.5rem 0;">
			<div style="float:left;">场地预定价格：<span id="sumHallSchedulePrice"><fmt:formatNumber type="currency" value="0" /></span></div>
			<div style="float:right;">场地加收服务费:<input type="number" id="serviceFee" name="serviceFee" min="0" max="100" style="width: 50px;" value="0" onkeyup="calculateHallSchedulePrice();">%</div>
			<div style="clear:both;"></div>
		</div>
		<div style="margin:0.5rem 0;">小计：<span id="allHallSchedulePrice" style="color:#cb2b29;"><fmt:formatNumber type="currency" value="0" /></span></div>
	</div>
</div>
<div>
	<div style="margin:0.5rem 0;">
		<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">住房场地（团房）</div>
	</div>
	<div>
		<c:forEach items="${rooms}" var="room">
			<div class="font-size-min" style="border-top:1px solid #cccccc;">
				<input type="hidden" id="roomid${room.id}" name="roomid${room.id}" value="${room.id}">
				<input type="checkbox" id="chkroomid${room.id}" name="chkroomid" value="${room.id}" style="display: none;">
				<input type="hidden" id="romscheduleidx${room.id}" name="romscheduleidx${room.id}" value="1" >
				<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div>${room.placeName }</div>
					<div class="room-check item-un-checked" roomId="${room.id }" style="">选定</div>
				</div>
				<div>
					<div style="margin:0.5rem 0;color: #999999;">
						<div class="display-flex" >
							<div>
								${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}
							</div> 
							<div>
								<div style="float: left;">数量：</div>
								<div class="num minus" roomId="${room.id }" idx="1" style="float: left;">-</div>
								<div class="room-num" style="float: left;">
								<input type="number" name="rom_num_${room.id }_1" id="rom_num_${room.id }_1" style="border: none;width: 50px;text-align: center;" value="0">
								</div>
								<div class="num plus" roomId="${room.id }" idx="1" style="float: left;">+</div>
								<div style="clear:both;"></div>
							</div>
						</div>
					</div>
					<div style="margin:0.5rem 0;">
						 <div style="float: left;width: 20%;padding:0.2rem 0;">入住时间：</div>
						 <div style="float: left;width: 80%;">
							 <div class="display-flex" style="width: 100%;">
							 	<input type="hidden" id="roomscheduleId_${room.id}_1" name="roomscheduleId_${room.id}_1" value="">
							 	<%-- <input type="hidden" id="roomschedulePrice_${room.id}_1" name="roomschedulePrice_${room.id}_1" value="" idx="1" class="roomschedulePrice"> --%>
								<input type="date" class="room-schedule date" id="roomscheduleDate_${room.id}_1" name="roomscheduleDate_${room.id}_1" idx="1" roomId="${room.id}"
								 placeholder="请选择入住时间" style="float: left;" onchange="roomScheduleDate(this)">
								 
								 <input type="number" id="roomschedulePrice_${room.id}_1" name="roomschedulePrice_${room.id}_1" value="" idx="1" class="roomschedulePrice" style="width: 60px;height: 26px;" onkeyup="calculateRoomSchedulePrice();">
							 </div>
						 </div>
						  <div style="clear:both;"></div>
					</div>
				</div>
				<div style="margin:0.5rem 0;">
					 <div style="float: left;width: 20%;">&nbsp;</div>
					 <div style="float: left;width: 80%;">
						 <div style="width: 100%;padding:0.4rem 0;">
							 <span class="add room-add-schedule" style="" roomId="${room.id}">添加</span>
						 </div>
					 </div>
					  <div style="clear:both;"></div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div style="font-weight:bold;padding-bottom: 0.5rem;">
		<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">住房预定价格：<span id="sumRoomSchedulePrice"><fmt:formatNumber type="currency" value="0"/></span></div>
		<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">小计：<div id="allRoomSchedulePrice" style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="0"/></div></div>
	</div>
</div>

<div>
	<div style="margin:0.5rem 0;">
		<div class="btn btn-xs bg-none-00" style="padding:0.2rem 1.0rem;">用餐选择</div>
	</div>
	<div>
		<c:forEach items="${menus }" var="meal">
			<div class="font-size-min" style="border-top:1px solid #cccccc;">
				<input type="hidden" id="mealid${meal.id}" name="mealid${meal.id}" value="${meal.id}">
				<input type="checkbox" id="chkmealid${meal.id}" name="chkmealids" value="${meal.id}" style="width: 0;height: 0;">
				<input type="hidden" id="mealscheduleidx${meal.id}" name="mealscheduleidx${meal.id}" value="1" >
				<input type="hidden" id="mealprice${meal.id}" name="mealprice${meal.id}" value="${meal.price}" >
				<div class="display-flex" style="color:#019FEA;margin:0.5rem 0;font-size: 0.85rem;">
					<div>${meal.name}</div>
					<div class="meal-check item-un-checked" mealId="${meal.id}" style="">选定</div>
				</div>
				
				<div>
					<div style="margin:0.5rem 0;" class="display-flex">
						
						<div style="width: 50%;">
							<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;">
								<select id="mealType_${meal.id}_1" name="mealType_${meal.id}_1" idx="1" mealId="${meal.id}" class="meal-type" onchange="mealType(this)">
									<option value="01">围餐</option>
									<option value="02">自助餐</option>
								</select>
							</div>
							<div style="border: 1px solid #999999;width: 60px;height: 28px;float: left;margin-left: 1rem;">
								<select id="mealscheduleTime_${meal.id}_1" name="mealscheduleTime_${meal.id}_1" idx="1" mealId="${meal.id}" class="meal-cgt">
										<option value="早餐">早餐</option>
										<option value="午餐">午餐</option>
										<option value="晚餐">晚餐</option>
								</select>
							</div>
						</div>
						<div >
							<div style="float: left;">数量：</div>
							<div class="num meal-minus" style="float: left;">-</div>
							<div class="room-num" style="float: left;">
								<input type="number" name="meal_num_${meal.id}_1" id="meal_num_${meal.id}_1" value="0" style="border: none;width: 50px;text-align: center;" value="0">
							</div>
							<div class="num meal-plus" style="float: left;">+</div>
							<div style="clear:both;"></div>
						</div>
					</div>
					<div style="margin:0.5rem 0;">
						<div style="float: left;width: 20%;padding:0.2rem 0;">用餐时间：</div>
						<div style="float: left;width: 80%;padding:0.2rem 0;" class="display-flex">
							<div>
								<input type="date" class="meal-schedule date" id="mealscheduleDate_${meal.id}_1" name="mealscheduleDate_${meal.id}_1" idx="1" mealId="${meal.id}" placeholder="请选择用餐时间" style="float: left;" onchange="mealScheduleDate(this)">
							</div>
							<div><input type="number" id="mealschedulePrice_${meal.id}_1" name="mealschedulePrice_${meal.id}_1" value="" idx="1" class="mealschedulePrice" style="width: 60px;height: 26px;" onkeyup="calculateMealSchedulePrice();"></div>
						</div>
						<div style="clear:both;"></div>
					</div>
				</div>
				<div style="margin:0.5rem 0;">
					 <div style="float: left;width: 20%;">&nbsp;</div>
					 <div style="float: left;width: 80%;">
						 <div style="width: 100%;padding:0.4rem 0;">
							  <span class="add meal-add-schedule" style="" mealId="${meal.id}">添加</span>
						 </div>
					 </div>
					  <div style="clear:both;"></div>
				</div>
			</div>
		</c:forEach>
		<div style="font-weight:bold;padding-bottom: 0.5rem;">	
			<div style="margin:0.5rem 0;padding-top: 0.5rem;font-weight:bold;">用餐预定价格：<span id="sumMealschedulePrice"><fmt:formatNumber type="currency" value="0" /></span></div>
			<div style="margin:0.5rem 0;font-weight:bold;padding-bottom: 0.5rem;">小计：<div id="allMealschedulePrice" style="display:inline;color:#cb2b29;"><fmt:formatNumber type="currency" value="0" /></div></div>
		</div>
	</div>
 </div>	
 <script>
 $(function(){
	 $(".date").on("input",function(){
	    if($(this).val().length>0){
		   $(this).addClass("full");
		}else{
		  $(this).removeClass("full");
	  	}
	 });
 });

 
 function hallScheduleDate(self){
	 var $this = $(self);
	 var placeId=$this.attr("hallId");
	 var scheduleDate = $this.val();
	 var idx = $this.attr("idx");
	 var scheduleTime = $('#scheduleTime_'+placeId+"_"+idx).val();
	 getHallSchedule(placeId,scheduleDate,scheduleTime,idx)
 }
 
 function hallScheduleTime(self){
	 var $this = $(self);
	 var placeId=$this.attr("hallId");
	 var idx = $this.attr("idx");
	 var scheduleDate = $('#scheduleDate_'+placeId+"_"+idx).val();
	 var scheduleTime = $this.val();
	 getHallSchedule(placeId,scheduleDate,scheduleTime,idx)
 }
 
 
 function roomScheduleDate(self){
	 var $this = $(self);
	 var roomId=$this.attr("roomId");
	 var scheduleDate = $this.val();
	 var idx = $this.attr("idx");
	 
	 getRoomSchedule(roomId,scheduleDate,idx)
 }
 function mealType(self){
	 var $this = $(self);
	 var idx = $this.attr("idx");
	 var mealId=$this.attr("mealId");
	 var price = $("#mealprice"+mealId).val();
	 var mtype = $this.val();
	 if("01"===mtype){
		 $("#mealschedulePrice_"+mealId+"_"+idx).val(price);
		 $("#mealschedulecurrency_"+mealId+"_"+idx).text("￥"+price+"/围");
	 }else if("02"===mtype){
		 $("#mealschedulePrice_"+mealId+"_"+idx).val(price/10);
		 $("#mealschedulecurrency_"+mealId+"_"+idx).text("￥"+price/10+"/人");
	 }
	 calculateMealSchedulePrice();
 }
 function mealScheduleDate(self){
	 var $this = $(self);
	 var idx = $this.attr("idx");
	 var mealId=$this.attr("mealId");
	 var price = $("#mealprice"+mealId).val();
	 var mtype = $("#mealType_"+mealId+"_"+idx).val();
	 if("01"===mtype){
		 $("#mealschedulePrice_"+mealId+"_"+idx).val(price);
		 $("#mealschedulecurrency_"+mealId+"_"+idx).text("￥"+price+"/围");
	 }else if("02"===mtype){
		 $("#mealschedulePrice_"+mealId+"_"+idx).val(price/10);
		 $("#mealschedulecurrency_"+mealId+"_"+idx).text("￥"+price/10+"/人");
	 }
	 calculateMealSchedulePrice();
 }
 
 function calculateHallSchedulePrice(){
	 var sumHallSchedulePrice =0.00;
	 var serviceFee = $("#serviceFee").val()*1;
	 
	 var allHallSchedulePrice =0.00;
	 $('.check .hallschedulePrice').each(function(){
		 if($(this).val()){
			 sumHallSchedulePrice+=$(this).val()*1;
		 }
	 });
	 allHallSchedulePrice = sumHallSchedulePrice*(1+serviceFee/100);
	 $("#sumHallSchedulePrice").text("￥"+sumHallSchedulePrice);
	 $("#allHallSchedulePrice").text("￥"+allHallSchedulePrice);
	 
	 sumALLprice();
 }
 function calculateRoomSchedulePrice(){
	 var sumRoomSchedulePrice =0.00;
	 var allRoomSchedulePrice =0.00;
	 $('.check .roomschedulePrice').each(function(){
		 if($(this).val()){
			 var arr = $(this).attr('id').split('_');
			 var placeId = arr[1];
			 var idx = arr[2];
			 var num = $("#rom_num_"+placeId+"_"+idx).val()*1;
			 sumRoomSchedulePrice+=$(this).val()*1*num;
		 }
	 });
	 allRoomSchedulePrice = sumRoomSchedulePrice;
	 $("#sumRoomSchedulePrice").text("￥"+sumRoomSchedulePrice);
	 $("#allRoomSchedulePrice").text("￥"+allRoomSchedulePrice);
	 
	 sumALLprice();
 }
 
 function calculateMealSchedulePrice(){
	 var sumMealSchedulePrice =0.00;
	 var allMealSchedulePrice =0.00;
	 $('.check .mealschedulePrice').each(function(){
		 if($(this).val()){
			 var arr = $(this).attr('id').split('_');
			 var placeId = arr[1];
			 var idx = arr[2];
			 var num = $("#meal_num_"+placeId+"_"+idx).val()*1;
			 sumMealSchedulePrice+=$(this).val()*1*num;
		 }
	 });
	 allMealSchedulePrice = sumMealSchedulePrice;
	 $("#sumMealschedulePrice").text("￥"+sumMealSchedulePrice);
	 $("#allMealschedulePrice").text("￥"+allMealSchedulePrice);
	 
	 sumALLprice();
 }
 
  function sumALLprice(){
	  
		var sumMealSchedulePrice = 0.00;
		var allMealSchedulePrice = 0.00;
		$('.check .mealschedulePrice').each(function() {
			if ($(this).val()) {
				var arr = $(this).attr('id').split('_');
				var placeId = arr[1];
				var idx = arr[2];
				var num = $("#meal_num_" + placeId + "_" + idx).val() * 1;
				sumMealSchedulePrice += $(this).val() * 1 * num;
			}
		});
		allMealSchedulePrice = sumMealSchedulePrice;

		var sumRoomSchedulePrice = 0.00;
		var allRoomSchedulePrice = 0.00;
		$('.check .roomschedulePrice').each(function() {
			if ($(this).val()) {
				var arr = $(this).attr('id').split('_');
				var placeId = arr[1];
				var idx = arr[2];
				var num = $("#rom_num_" + placeId + "_" + idx).val() * 1;
				sumRoomSchedulePrice += $(this).val() * 1 * num;
			}
		});
		allRoomSchedulePrice = sumRoomSchedulePrice;
		var sumHallSchedulePrice = 0.00;
		var serviceFee = $("#serviceFee").val() * 1;

		var allHallSchedulePrice = 0.00;
		$('.check .hallschedulePrice').each(function() {
			if ($(this).val()) {
				sumHallSchedulePrice += $(this).val() * 1;
			}
		});
		allHallSchedulePrice = sumHallSchedulePrice * (1 + serviceFee / 100);
		
		
		var amount = allHallSchedulePrice + allRoomSchedulePrice+allMealSchedulePrice;
		var zgamount = amount;
		
		
		$("#amount").text("￥"+amount);
		$("#zgamount").text("￥"+zgamount);
		
	}
</script>