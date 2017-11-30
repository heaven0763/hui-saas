<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
<!--
.hall-schedule{color: #999999;width: 200px;}
.room-schedule{color: #999999;width: 200px;}
.meal-schedule{color: #999999;width: 200px;}
.hall-time{color: #999999;width: 120px;}
.meal-type{color: #999999;width: 120px;}
.meal-cgt{color: #999999;width:  120px;}
.font-size-min{font-size: 0.8rem;}
.add{padding:5px 15px;color: #019FEA;border: 1px solid #019FEA;}
.item-checked{background-color: #666666;color: #ffffff;padding: 0.2rem 0.8rem;font-size: 0.85rem;min-width: 4.2rem;text-align: center;}
.item-un-checked{background-color: #019FEA;color: #ffffff;padding: 0.2rem 0.8rem;font-size: 0.85rem;min-width: 4.2rem;text-align: center;}
.room-num .help-block{margin-top: 0px}
-->
</style>
<!-- 会场场地选择 -->
<div>
	<div class="row">
		<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">活动场地选择</span></div>
	</div>
	
	<div class="row hall">
		<div class="col-sm-12 pad-lr-k hall-items">
			<c:forEach items="${halls}" var="hall">
				<div class="hall-item" style="width: 100%;">
					<input type="hidden" id="hallid${hall.id }" name="hallid${hall.id }" value="${hall.id }">
					<div class="row pad-ud-5 mgn-ud-5 bottom-line">
						<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;"> ${hall.placeName} </div>
						<div class="col-sm-4 display-flex" style="color: #999999;padding: 0.1rem 0;">
							<span>面积${hall.hallArea}m²</span>
							<span>容纳人数${hall.peopleNum}人</span>
							<span>层高${hall.height}m</span>
							<span>楼层${hall.floor}F</span>
							<span>立柱${hall.pillar}</span>
						</div>
						<div class="col-sm-5">
							<input type="checkbox" id="chkhallid${hall.id }" name="chkhallid" value="${hall.id }" style="width: 0;height: 0;">
						</div>
						<div class="col-sm-1 pad-no" style="text-align: right;">
								<div class="hall-check item-un-checked btn btn-primary btn-xs" hallId="${hall.id}" style="">选定</div>
								<div id="hall-del" class="hall-del"  hallId="${hall.id }" style="display: inline-block;">
									<img id="site-up-${hall.id }" src="${ctx}/static/resource/css/images/up.png" class="btn-icon site-toggle-up" style="display: none;">
									<img id="site-down-${hall.id }" src="${ctx}/static/resource/css/images/down.png" class="btn-icon site-toggle-down">
								</div>
						</div>
					</div>
					
					<div id="" class="bottom-line" style="color:#999999;display: none;">
						<div style="position: relative;">
							<div class="row pad-lr-20 mgn-ud-5">
								<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
								<div class="col-sm-7 pad-no">
									<input type="date" class="hall-schedule date form-control" name="scheduleDate_${hall.id}" hallId="${hall.id}"
									 placeholder="请选择档期" style="float: left;width: 200px;" onchange="hallScheduleDate(this)">
									 <div style="float: left;margin-left: 15px;margin-right: 15px;">
										<input type="hidden" name="hallschedule${hall.id}" value=""/>
										<select name="scheduleTime_${hall.id}" hallId="${hall.id}" class="hall-time form-control selectpicker"  data-actions-box="true" data-width="200px" data-size="10" multiple="multiple" data-title="请选择" 
										 data-deselect-all-text="全不选" data-select-all-text="全选">
											<c:forEach items="${ctimes}" var="ctme">
												<option value="${ctme.id}">${ctme.name}</option>
											</c:forEach>
											<!-- <option value="ALL">全天</option> -->
										</select>
									</div>
									<input type="number" class="price form-control hallschedulePrice" value="${bookingRecordModel.price }" name="placePrice_${hall.id }" id="" onkeyup="calculateHallSchedulePrice()" onchange="calculateHallSchedulePrice();" style="width: 120px;">元
								</div>
								<div class="col-sm-4 pad-no">
									<img class="order-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
								</div>
							</div>
							<div style="position: absolute;bottom: 8px;right: 32%;">
								  <img class="hall-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" hallId="${hall.id }" title="添加档期">
							</div>
						</div>
						<div class="display-flex" style="margin:0.5rem 0;color:#FFB42B; ">
							<label><input type="radio" name="ismain" value="${hall.id}"  onchange="setMain(this);">设为主会场</label>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 会场价格 -->
	<div id="hallPriceDetail" class="bottom-line" style="font-weight:bold;padding: 0 5px">
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                    <div class="col-md-9"></div>
                    <div class="col-md-3" style="text-align: right;">小计：<span id="sumHallSchedulePrice"><fmt:formatNumber type="currency" value="${0 }"/></span></div>
                </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                    <div class="col-md-6"></div>
                   	<div id="commissionFeeRate_edit" class="col-md-6" style="text-align: right;">
                    	场地加收服务费:<input type="number" id="commissionFeeRate" name="commissionFeeRate" min="0" max="100" class="form-control" style="width: 80px;display: inline;"  value="${0 }" onkeyup="calculateHallSchedulePrice();" onchange="calculateHallSchedulePrice();">%
                    	 ：<span id="serviceFeedit"><fmt:formatNumber type="currency" value="${0 }" /></span>
                   	</div>
                </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                    <div class="col-md-9"> 
                     </div>
          		    <div class="col-md-3" style="text-align: right;margin: 0.3rem 0;">
          		  		  合计：<span  id="allHallSchedulePrice" style="color: red;"><fmt:formatNumber type="currency" value="${0}" /></span>
          		    </div>
           		</div>
			</div>
		</div>
	</div>
	<!-- 会场备注 -->					
	<div style="border-top:1px solid #cccccc;padding: 0 15px;">
		<div style="margin:0.8rem 0;">
			<div style="font-weight:bold;font-size: 0.85rem;">
				<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;float: left;"></div>
				<div class="remark_opt" style="display: none;float: left;margin: 10px 10px;">
					<img onclick="meetingremarkShow('order_meetingremark')" title="修改场地预定备注" id="order_meetingremark" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
		 			<img onclick="meetingremarkCancel('order_meetingremark_cancel')" title="取消修改场地预定备注" id="order_meetingremark_cancel" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		<div class="Remark" style="">
			<div id="meetingRemarkEdit" style="margin:0.8rem 0;">
				<!-- <div id="meetingRemark"  name="meetingRemark" class="edui-default" style="height: 400px;"></div> -->
				<script type="text/plain" id="meetingRemark"  name="meetingRemark" style="height: 400px;">${empty order.meetingRemark?hotel.meetingRemark:order.meetingRemark}</script>
			</div>
			<div id="meetingRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
				${empty order.meetingRemark?hotel.meetingRemark:order.meetingRemark}
			</div>
		</div>
		<script type="text/javascript">
			function meetingremarkShow(id){
				$("#"+id).hide();
				$("#order_meetingremark_cancel").show();
				$("#meetingRemarkEdit").show();
				$("#meetingRemarkDetail").hide();
			}
			function meetingremarkCancel(id){
				$("#"+id).hide();
				$("#order_meetingremark").show();
				$("#meetingRemarkDetail").show();
				$("#meetingRemarkEdit").hide();
			}
			var meeting_editor = new UE.ui.Editor({
	            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
	            toolbars:[],
	            //focus时自动清空初始化时的内容
	            autoClearinitialContent:false,
	            //关闭字数统计
	            wordCount:false,
	            //关闭elementPath
	            elementPathEnabled:false
	        });
			meeting_editor.render("meetingRemark");
			
			
			function hallScheduleDate(self){
				 var $this = $(self);
				 var placeId=$this.attr("hallId");
				 var scheduleDate = $this.val();
				 var idx = $this.attr("idx");
				 var scheduleTime = $('#scheduleTime_'+placeId+"_"+idx).val();
				 //getHallSchedule(placeId,scheduleDate,scheduleTime,idx)
			 }
			
			function getHallSchedule(placeId,scheduleDate,scheduleTime,idx){
				var hotelId = $("#hotelId").val();
				$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate,scheduleTime:scheduleTime},function(res){
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
						swal(res.message,'error');
					}
				},"json");
			}
			
			 function calculateHallSchedulePrice(){
				 var sumHallSchedulePrice =0.00;
				 var commissionFeeRate = $("#commissionFeeRate").val()*1;
				 
				 var allHallSchedulePrice =0.00;
				 $('.check .hallschedulePrice').each(function(){
					 if($(this).val()){
						 sumHallSchedulePrice+=$(this).val()*1;
					 }
				 });
				 var serviceFee = sumHallSchedulePrice*commissionFeeRate/100;
				 allHallSchedulePrice = sumHallSchedulePrice+serviceFee;
				 $("#sumHallSchedulePrice").text("￥"+common.formatCurrency(sumHallSchedulePrice));
				 $("#allHallSchedulePrice").text("￥"+common.formatCurrency(allHallSchedulePrice));
				 $("#serviceFeedit").text("￥"+common.formatCurrency(serviceFee));
				 sumALLprice();
			 }
	    </script>
	</div>
	
</div>
<!-- 住房选择 -->
<div>
	<div class="row">
		<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">住房选择</span></div>
	</div>
	<div class="row">
		<div class="col-sm-12 pad-lr-k room-items">
			<c:forEach items="${rooms}" var="room">
				<div class="room-item">
					<input type="hidden" id="roomid${room.id}" name="roomid${room.id}" value="${room.id}">
					
					<input type="hidden" id="romscheduleidx${room.id}" name="romscheduleidx${room.id}" value="1" >
					
					<div class="row pad-ud-5 mgn-ud-5 bottom-line">
						<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;"> ${room.placeName } </div>
						<div class="col-sm-3 display-flex" style="color: #999999;padding: 0.1rem 0;">
							<span style="">${room.roomType  }</span>
							<span style="">-</span>
							<span style="">${room.network}</span>
						</div>
						<div class="col-sm-6">
							<input type="checkbox" id="chkroomid${room.id}" name="chkroomid" value="${room.id}" style="display: none;">
						</div>
						<div class="col-sm-1 pad-no" style="text-align: right;">
							<div class="room-check item-un-checked btn btn-primary btn-xs" roomId="${room.id }" style="">选定</div>
							<div  roomId="${room.id }" style="display: inline-block;">
								<img id="site-up-${room.id }" src="${ctx}/static/resource/css/images/up.png" class="btn-icon site-toggle-up" style="display: none;">
								<img id="site-down-${room.id }" src="${ctx}/static/resource/css/images/down.png" class="btn-icon site-toggle-down">
							</div>
						</div>
					</div>
					
					<div style="position: relative;display: none;"><!--  -->
						<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
							
							<div class="col-sm-3 pad-no" >
								 <span style="display: inline-block;vertical-align: middle;">入住时间：</span>
								 <input type="date" class="room-schedule date form-control required" required="required" id="roomscheduleDate_${room.id}" name="roomscheduleDate_${room.id}" roomId="${room.id}"
									  onchange="roomScheduleDate(this)" value="" style="display: inline-block;vertical-align: middle;">
								 <!-- <input type="hidden" name="roomscheduleprice" value="" /> -->
							</div>
							<div class="col-sm-1 pad-no" >
								<select class="room-breakfast form-control" name="breakfast_${room.id}" roomId="${room.id}"  style="width: 80px;">
									<option value="0">无早</option>
									<option value="1">有早</option>
								</select>
							</div>
							<div class="col-sm-2 pad-no" >
								<div style="float: left;padding: 8px 0;">数量：</div>
								<div class="num minus" roomId="${room.id}"  style="float: left;margin: 6px 0;">-</div>
								<div class="room-num" style="float: left;margin: 6px 0;">
									<input type="number" name="rom_num_${room.id}" id="rom_num_${room.id}" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">
								</div>
								<div class="num plus" roomId="${room.id}" style="float: left;margin: 6px 0;">+</div>
								<div style="clear:both;"></div>
							</div>
							<div class="col-sm-3 pad-no">
								￥<input type="number" class="price form-control roomschedulePrice" style="width: 120px;" value="0" name="roomPrice_${room.id}" id="roomPrice${room.id}" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">元/间
							</div>
							<div class="col-sm-1 pad-no" >
								<img class="room-schedule-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
							</div>
						</div>
					
						<div style="position: absolute;bottom: 13px;right: 23%;">
							  <img class="room-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" title="添加档期" roomId="${room.id}">
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 住房价格 -->
	<div class="row ">
		<div class="col-md-12" style="padding: 0 30px;">
			<div class="row bottom-line">
                <div class="col-md-9">
		          </div>
                <div class="col-md-3" style="text-align: right;margin: 0.8rem 0;font-weight: bold;">
                	合计：<span id="allRoomSchedulePrice" style="color: red;"><fmt:formatNumber type="currency" value="${0}"/></span>
                </div>
            </div>
		</div>
	</div>
	
	<!-- 住房备注 -->
	<div style="border-top:1px solid #cccccc;padding: 0 15px;">
		<div style="margin:0.8rem 0;">
			<div style="font-weight:bold;font-size: 0.85rem;">
				<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;float: left;"></div>
				<div class="remark_opt" style="display: none;float: left;margin: 10px 10px;">
					<img onclick="houseRemarkShow('order_houseRemark')" title="修改场地预定备注" id="order_houseRemark" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
		 			<img onclick="houseRemarkCancel('order_houseRemark_cancel')" title="取消修改场地预定备注" id="order_houseRemark_cancel" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		
		<div class="Remark" style="">
			<div id="houseRemarkEdit" style="margin:0.8rem 0;">
				<script type="text/plain" id="houseRemark"  name="houseRemark" style="height: 400px;">${empty order.houseRemark?hotel.houseRemark:order.houseRemark}</script>
			</div>
			<div id="houseRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
				${empty order.houseRemark?hotel.houseRemark:order.houseRemark}
			</div>
		</div>
		<script type="text/javascript">
			function houseRemarkShow(id){
				$("#"+id).hide();
				$("#order_houseRemark_cancel").show();
				$("#houseRemarkEdit").show();
				$("#houseRemarkDetail").hide();
			}
			function houseRemarkCancel(id){
				$("#"+id).hide();
				$("#order_houseRemark").show();
				$("#houseRemarkDetail").show();
				$("#houseRemarkEdit").hide();
			}
			var meeting_editor = new UE.ui.Editor({
	            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
	            toolbars:[],
	            //focus时自动清空初始化时的内容
	            autoClearinitialContent:false,
	            //关闭字数统计
	            wordCount:false,
	            //关闭elementPath
	            elementPathEnabled:false
	        });
			meeting_editor.render("houseRemark");
			
			function roomScheduleDate(self){
				 var $this = $(self);
				 var roomId=$this.attr("roomId");
				 var scheduleDate = $this.val();
				 getRoomSchedule($this,roomId,scheduleDate)
			 }
			
			function getRoomSchedule($this,placeId,scheduleDate){
				var hotelId = $("#hotelId").val();
				$.get('${ctx}/weixin/order/room/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate},function(res){
					if(res.statusCode==='200'){
						$this.parent().parent().find('input.roomschedulePrice').val(res.object.onlinePrice);
						calculateRoomSchedulePrice();
					}else{
						swal(res.message,'error');
					}
				},"json");
			}
			 function calculateRoomSchedulePrice(){
				 var sumRoomSchedulePrice =0.00;
				 var allRoomSchedulePrice =0.00;
				 $('.check .roomschedulePrice').each(function(){
					 if($(this).val()){
						 var num = $(this).parent().prev().find("input[type='number']").val()*1;
						 sumRoomSchedulePrice+=$(this).val()*1*num;
					 }
				 });
				 allRoomSchedulePrice = sumRoomSchedulePrice;
				 //$("#sumRoomSchedulePrice").text("￥"+common.formatCurrency(sumRoomSchedulePrice));
				 $("#allRoomSchedulePrice").text("￥"+common.formatCurrency(allRoomSchedulePrice));
				 
				 sumALLprice();
			 }
	    </script>
	</div>

</div>
<!-- 用餐选择 -->
<div>
	<div class="row">
		<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">用餐选择</span></div>
	</div>
	<div class="row">
		<div class="col-sm-12 pad-lr-k room-items">
			<c:forEach items="${menus }" var="meal">
				<div class="room-item">
					<input type="hidden" id="mealid${meal.id}" name="mealid${meal.id}" value="${meal.id}">
					<input type="hidden" id="mealscheduleidx${meal.id}" name="mealscheduleidx${meal.id}" value="1" >
					<input type="hidden" id="mealprice${meal.id}" name="mealprice${meal.id}" value="${meal.price}" >
					
					<div class="row pad-ud-5 mgn-ud-5 bottom-line">
						<div class="col-sm-1 pad-no"><span style="color:#019FEA;margin:0.5rem 0;"> ${meal.name} </div>
						<div class="col-sm-9" style="color: #999999;padding: 0.1rem 0;overflow: hidden;">
							<c:forEach items="${meal.hotelMenuDetails }" var="mldtl">
								<span class="pad-lr-5" style="">${mldtl.name  }</span>
							</c:forEach>
						</div>
						<div class="col-sm-1">
							<input type="checkbox" id="chkmealid${meal.id}" name="chkmealids" value="${meal.id}" style="width: 0;height: 0;">
						</div>
						<div class="col-sm-1 pad-no" style="text-align: right;">
							<div class="meal-check item-un-checked btn btn-primary btn-xs" mealId="${meal.id}" style="">选定</div>
							<div  roomId="${meal.id }" style="display: inline-block;">
								<img id="site-up-${meal.id }" src="${ctx}/static/resource/css/images/up.png" class="btn-icon site-toggle-up" style="display: none;">
								<img id="site-down-${meal.id }" src="${ctx}/static/resource/css/images/down.png" class="btn-icon site-toggle-down">
							</div>
						</div>
					</div>
					
					<div style="display: none;position: relative;">
						<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
							<div class="col-sm-1 pad-no" >
								<select id="mealType_${meal.id}" name="mealType_${meal.id}" mealId="${meal.id}" class="meal-type form-control" style="width: 90px;"  onchange="mealType(this)">
									<option value="01">围餐</option>
									<option value="02">自助餐</option>
								</select>
							</div>
							<div class="col-sm-1 pad-no" >
								<select id="mealscheduleTime_${meal.id}" name="mealscheduleTime_${meal.id}"  mealId="${meal.id}" class="meal-cgt form-control"  style="width: 90px;">
									<option value="早餐">早餐</option>
									<option value="午餐">午餐</option>
									<option value="晚餐">晚餐</option>
								</select>
							</div>
							<div class="col-sm-3 pad-no" >
						 		<span style="display: inline-block;vertical-align: middle;">用餐时间：</span>
								<input type="date" class="meal-schedule date form-control" id="mealscheduleDate_${meal.id}" style="display: inline-block;vertical-align: middle;"
								name="mealscheduleDate_${meal.id}" mealId="${meal.id}" onchange="mealScheduleDate(this)" value="${bookingRecordModel.placeDate }">
								<input type="hidden" id="mealscheduleId_${meal.id}" name="mealscheduleId_${meal.id}" value="${bookingRecordModel.id }">
							</div>
							<div class="col-sm-2 pad-no" >
								<div style="float: left;padding: 8px 0;">数量：</div>
								<div class="num meal-minus" style="float: left;margin: 6px 0;">-</div>
								<div class="meal-num" style="float: left;margin: 6px 0;">
									<input type="number" name="meal_num_${meal.id}" min="0" style="border: none;width: 50px;text-align: center;margin: 0;" value="1" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">
								</div>
								<div class="num meal-plus" style="float: left;margin: 6px 0;">+</div>
								<div style="clear:both;"></div>
							</div>
							<div class="col-sm-2 pad-no" >
								￥<input type="number" class="price form-control mealschedulePrice" style="width: 120px;" value="0" min="0" name="mealPrice_${meal.id}" id="mealPrice${meal.id}" onkeyup="calculateMealSchedulePrice();" onchange="calculateMealSchedulePrice();">
								<span class="priceunittxt">元/围</span>
							</div>
							<div class="col-sm-2 pad-no" >
								<img class="meal-schedule-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;margin:0.4rem 25px;cursor: pointer;">
							</div>
						</div>
						
						<div style="position: absolute;bottom: 13px;right: 23%;">
							  <img class="meal-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" title="添加档期" mealId="${meal.id}">
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 用餐价格 -->
	<div id="mealPriceDetail" class="bottom-line" style="font-weight:bold;padding: 0 5px">
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                    <div class="col-md-9"></div>
                    <div class="col-md-3" style="text-align: right;">小计：<span id="sumMealschedulePrice"><fmt:formatNumber type="currency" value="0"/></span></div>
                </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                	<div class="col-md-6"></div>
                     	<div id="mealServiceFeeRate_edit" class="col-md-6" style="text-align: right;">
                      	用餐加收服务费:
                      	<input type="number" id="mealServiceFeeRate" name="mealServiceFeeRate" min="0" max="100" class="form-control"
                      	 style="width: 80px;display: inline;"  value="0" onkeyup="calculateMealSchedulePrice()" onchange="calculateMealSchedulePrice()">%
                      	 ：<span id="mealServiceFeedit"><fmt:formatNumber type="currency" value="0" /></span>
                     	</div>
                  	</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="row pad-5">
                    <div class="col-md-9"></div>
       		    	<div class="col-md-3" style="text-align: right;margin: 0.3rem 0;">合计：<span  id="allMealschedulePrice" style="color: red;">
       		    	<fmt:formatNumber type="currency" value="0" /></span></div>
           		</div>
			</div>
		</div>
	</div>
	<!-- 用餐备注 -->
	<div style="border-top:1px solid #cccccc;padding: 0 15px;">
		<div style="margin:0.8rem 0;">
			<div style="font-weight:bold;font-size: 0.85rem;">
				<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;float: left;"></div>
				<div class="remark_opt" style="display: none;float: left;margin: 10px 10px;">
					<img qx="order:update" onclick="dinnerRemarkShow('order_dinnerRemark')" title="修改场地预定备注" id="order_dinnerRemark" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
		 			<img qx="order:update" onclick="dinnerRemarkCancel('order_dinnerRemark_cancel')" title="取消修改场地预定备注" id="order_dinnerRemark_cancel" 
						src="${ctx}/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
		<div class="Remark" style="">
			<div id="dinnerRemarkEdit" style="margin:0.8rem 0;">
				<script type="text/plain" id="dinnerRemark"  name="dinnerRemark" style="height: 400px;">${empty order.dinnerRemark?hotel.dinnerRemark:order.dinnerRemark}</script>
			</div>
			<div id="dinnerRemarkDetail" style="margin:1rem 0;padding:0 1rem;">
				${empty order.dinnerRemark?hotel.dinnerRemark:order.dinnerRemark}
			</div>
		</div>
		<script type="text/javascript">
			function dinnerRemarkShow(id){
				$("#"+id).hide();
				$("#order_dinnerRemark_cancel").show();
				$("#dinnerRemarkEdit").show();
				$("#dinnerRemarkDetail").hide();
			}
			function dinnerRemarkCancel(id){
				$("#"+id).hide();
				$("#order_dinnerRemark").show();
				$("#dinnerRemarkDetail").show();
				$("#dinnerRemarkEdit").hide();
			}
			var meeting_editor = new UE.ui.Editor({
	            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
	            toolbars:[],
	            //focus时自动清空初始化时的内容
	            autoClearinitialContent:false,
	            //关闭字数统计
	            wordCount:false,
	            //关闭elementPath
	            elementPathEnabled:false
	        });
			meeting_editor.render("dinnerRemark");
			

			 
			 function mealType(self){
				 var $this = $(self);
				 var mealId=$this.attr("mealId");
				 var price = $("#mealprice"+mealId).val();
				 var mtype = $this.val();
				 if("01"===mtype){
					 $this.parent().next().next().next().next().find('input').val(price);
					 $this.parent().next().next().next().next().find('.priceunittxt').text('元/围');
				 }else if("02"===mtype){
					 $this.parent().next().next().next().next().find('input').val(price/10);
					 $this.parent().next().next().next().next().find('.priceunittxt').text('元/人');
				 }
				 calculateMealSchedulePrice();
			 }
			 function mealScheduleDate(self){
				 var $this = $(self);
				 var mealId=$this.attr("mealId");
				 var price = $("#mealprice"+mealId).val();
				 var mtype = $this.parent().prev().prev().find('select').val();
				 if("01"===mtype){
					 $this.parent().next().next().find('input').val(price);
					 $this.parent().next().next().find('priceunittxt').text('元/围');
				 }else if("02"===mtype){
					 $this.parent().next().next().find('input').val(price/10);
					 $this.parent().next().next().find('priceunittxt').text('元/人');
				 }
				 calculateMealSchedulePrice();
			 }
			 
			 function calculateMealSchedulePrice(){
				 var sumMealSchedulePrice =0.00;
				 var allMealSchedulePrice =0.00;
				 var mealServiceFee =0.00;
				 var mealServiceFeeRate = $("#mealServiceFeeRate").val()*1;
				 
				 $('.check .mealschedulePrice').each(function(){
					 if($(this).val()){
						 var num =  $(this).parent().prev().find('input').val()*1;
						 sumMealSchedulePrice+=$(this).val()*1*num;
					 }
				 });
				 
				 mealServiceFee = sumMealSchedulePrice*mealServiceFeeRate/100;
				 allMealSchedulePrice = sumMealSchedulePrice+mealServiceFee;
				 
				 $("#sumMealschedulePrice").text("￥"+common.formatCurrency(sumMealSchedulePrice));
				 $("#allMealschedulePrice").text("￥"+common.formatCurrency(allMealSchedulePrice));
				 $("#mealServiceFeedit").text("￥"+common.formatCurrency(mealServiceFee));
				 
				 sumALLprice();
			 }
	    </script>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		$(".site-toggle-up").click(function(){
			$(this).hide();
			$(this).next().show();
			$(this).parent().parent().parent().next().hide();
		});
		
		$(".site-toggle-down").click(function(){
			$(this).hide();
			$(this).prev().show();
			$(this).parent().parent().parent().next().show();
		});
		
		
		$(".Remark").hide();
		$("#meetingRemarkEdit").hide();
		$("#houseRemarkEdit").hide();
		$("#dinnerRemarkEdit").hide();
		
		$(".remark-btn").click(function(){
			var crtclass = $(this).hasClass("hideRemark");
			if(crtclass){
				$(this).removeClass("hideRemark");
				$(this).addClass("showRemark");
				$(this).parent().parent().next().hide();
				$(this).next().hide();
			}else{
				$(this).removeClass("showRemark");
				$(this).addClass("hideRemark");
				$(this).parent().parent().next().show();
				$(this).next().show();
			}
		});
		
		$('.selectpicker').selectpicker(); 
		
		$('.selectpicker').on('show.bs.select', function (e) {
			var hotelId = $("#hotelId").val();
			var $this = $(this);
			var hallId = $this.attr("hallid");
			
			var scheduleDate = $this.parent().parent().prev().val();
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
									}else{
										$self.prop('disabled', false);
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
		
		$('.selectpicker').on('changed.bs.select', function (e) {
			var $this = $(this);
			var hallId = $this.attr("hallid");
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
			$this.parent().prev().val((schtimes+"").split(',').join('#'));
			$this.parent().parent().next().val(sumprice);
			calculateHallSchedulePrice()
		});
	
	 	$(".date").on("input",function(){
		    if($(this).val().length>0){
			   $(this).addClass("full");
			}else{
			  $(this).removeClass("full");
		  	}
		 });
 });

</script>
<!-- 场地档期项 -->
<script id="hall_schedule_item" type="text/html">
	<div class="row pad-lr-20 mgn-ud-5">
		<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
		<div class="col-sm-7 pad-no">
			<input type="date" class="hall-schedule date form-control" name="scheduleDate_{{id}}" hallId="{{id}}"
			 placeholder="请选择档期" style="float: left;width: 200px;" onchange="hallScheduleDate(this)">
			 <div style="float: left;margin-left: 15px;margin-right: 15px;">
				<input type="hidden" name="hallschedule{{id}}" value=""/>
				<select name="scheduleTime_{{id}}" hallId="{{id}}" class="hall-time form-control selectpicker"  data-actions-box="true" data-width="200px" data-size="10" multiple="multiple" data-title="请选择" 
				 data-deselect-all-text="全不选" data-select-all-text="全选">
					<c:forEach items="${ctimes}" var="ctme">
						<option value="${ctme.id}">${ctme.name}</option>
					</c:forEach>
					<!-- <option value="ALL">全天</option> -->
				</select>
			</div>
			<input type="number" class="price form-control hallschedulePrice" value="0" name="placePrice_{{id}}" id="" onkeyup="calculateHallSchedulePrice()" onchange="calculateHallSchedulePrice();" style="width: 120px;">元
		</div>
		<div class="col-sm-4 pad-no">
			<img class="order-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
		</div>
	</div>
</script>
<!-- 住房档期项 -->
<script id="room_schedule_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
		<div class="col-sm-3 pad-no" >
			 <span style="display: inline-block;vertical-align: middle;">入住时间：</span>
			 <input type="date" class="room-schedule date form-control" id="roomscheduleDate_{{id}}" name="roomscheduleDate_{{id}}" roomId="{{id}}"
				  onchange="roomScheduleDate(this)" value="" style="display: inline-block;vertical-align: middle;">
		</div>
		<div class="col-sm-1 pad-no" >
			<select class="room-breakfast form-control" name="breakfast_{{id}}" roomId="{{id}}"  style="width: 80px;">
				<option value="0">无早</option>
				<option value="1">有早</option>
			</select>
		</div>
		<div class="col-sm-2 pad-no" >
			<div style="float: left;padding: 8px 0;">数量：</div>
			<div class="num minus" roomId="{{id}}"  style="float: left;margin: 6px 0;">-</div>
			<div class="room-num" style="float: left;margin: 6px 0;">
				<input type="number" name="rom_num_{{id}}" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">
			</div>
			<div class="num plus" roomId="{{id}}" style="float: left;margin: 6px 0;">+</div>
			<div style="clear:both;"></div>
		</div>
		<div class="col-sm-3 pad-no">
			￥<input type="number" class="price form-control roomschedulePrice" style="width: 120px;" value="0" name="roomPrice_{{id}}" id="roomPrice{{id}}" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">元/间
		</div>
		<div class="col-sm-1 pad-no" >
			<img class="room-schedule-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
		</div>
	</div>
</script>

<!-- 用餐档期项 -->
<script id="meal_schedule_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
		<div class="col-sm-1 pad-no" >
			<select id="mealType_${meal.id}" name="mealType_{{id}}" mealId="{{id}}" class="meal-type form-control" style="width: 90px;" onchange="mealType(this)">
				<option value="01">围餐</option>
				<option value="02">自助餐</option>
			</select>
		</div>
		<div class="col-sm-1 pad-no" >
			<select id="mealscheduleTime_{{id}}" name="mealscheduleTime_{{id}}"  mealId="{{id}}" class="meal-cgt form-control"  style="width: 90px;">
				<option value="早餐">早餐</option>
				<option value="午餐">午餐</option>
				<option value="晚餐">晚餐</option>
			</select>
		</div>
		<div class="col-sm-3 pad-no" >
	 		<span style="display: inline-block;vertical-align: middle;">用餐时间：</span>
			<input type="date" class="meal-schedule date form-control" id="mealscheduleDate_{{id}}" style="display: inline-block;vertical-align: middle;"
			name="mealscheduleDate_{{id}}" mealId="{{id}}" onchange="mealScheduleDate(this)" value="">
		</div>
		<div class="col-sm-2 pad-no" >
			<div style="float: left;padding: 8px 0;">数量：</div>
			<div class="num meal-minus" style="float: left;margin: 6px 0;">-</div>
			<div class="meal-num" style="float: left;margin: 6px 0;">
				<input type="number" name="meal_num_{{id}}" min="0" style="border: none;width: 50px;text-align: center;margin: 0;" value="1" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">
			</div>
			<div class="num meal-plus" style="float: left;margin: 6px 0;">+</div>
			<div style="clear:both;"></div>
		</div>
		<div class="col-sm-2 pad-no" >
			￥<input type="number" class="price form-control mealschedulePrice" style="width: 120px;" value="0" min="0" name="mealPrice_{{id}}" id="mealPrice{{id}}" onkeyup="calculateMealSchedulePrice();" onchange="calculateMealSchedulePrice();">
			<span class="priceunittxt">元/围</span>
		</div>
		<div class="col-sm-2 pad-no" >
			<img class="meal-schedule-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;margin:0.4rem 25px;cursor: pointer;">
		</div>
	</div>
</script>