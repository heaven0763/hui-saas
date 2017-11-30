<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
	.display-flex {
		display: flex;
		justify-content: space-between;
	}
	.state-item {
		padding: 0.5rem 0;
		border-bottom: 1px solid #f5f5f5;
		text-align: center;
		color: #999999;
	}
	.state-item-check {color: #019FEA;}
	.hall-schedule {color: #999999;width: 180px;text-align: center;}
	.hall-time {color: #999999;width: 150px;}
	.price {width: 100px;display: inline;}
	
	.room-schedule {color: #999999;width: 180px;text-align: center;}
	.meal-schedule {color: #999999;width: 180px;text-align: center;}
	.room-breakfast {color: #999999;width: 120px;}
	.meal-type {color: #999999;	width: 120px;}
	.meal-cgt {color: #999999;width: 120px;}
	
	.font-size-min {font-size: 0.8rem;}
	.item-checked {
		background-color: #666666;
		color: #ffffff;
		padding: 0.2rem 0.8rem;
		font-size: 0.85rem;
		min-width: 4.2rem;
		text-align: center;
	}
	.item-un-checked {
		background-color: #019FEA;
		color: #ffffff;
		padding: 0.2rem 0.8rem;
		font-size: 0.85rem;
		min-width: 4.2rem;
		text-align: center;
	}
	.num {
		width: 26px;
		height: 26px;
		border: 1px solid #999999;
		background-color: #f5f5f5;
		font-style: normal;
		line-height: 26px;
		text-align: center;
		cursor: pointer;
	}
	.room-num {
		text-align: center;
		width: 50px;
		min-width: 50px;
		line-height: 26px;
	}
	
	.hall-item{border-bottom: 1px solid #f5f5f5;}
	.arr-down{background-image: url('${ctx}/static/weixin/css/icon/common/arrow-down.png');background-position: 90% 50%;background-repeat: no-repeat;background-size:20px; }
	.amount-item{text-align: right;margin: 8px 2%;}
	
	.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:-5px;left: 0;}
	.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
	.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}
	
	.cmstatus{background-image: url('${ctx}/static/resource/css/images/cmstatus.png'); }
	.base input{width: 160px;height: 25px;}
	.pad-10{padding:10px;}
	.pad-10-k{padding:10px 30px;}
	.pad-5{padding:5px;}
	.pad-ud-5{padding:5px 0;}
	.pad-ud2-5{padding:2.5px 0;}
	.pad-lr-5{padding:0 5px;}
	.pad-lr-10{padding:0 10px;}
	.pad-lr-20{padding:0 20px;}
	.pad-lr-25{padding:0 25px;}
	.pad-lr-30{padding:0 30px;}
	
	.pad-no{padding:0;}
	.bottom-line{border-bottom: 1px solid #ddd;}
	
	.mgn-5{margin:5px;}
	.mgn-ud-5{margin:5px 0;}
	
	.showRemark{background-image: url('${ctx}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
	.hideRemark{background-image: url('${ctx}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
	.btn-icon{width:24px; height:24px;cursor: pointer;}
</style>
 <div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:;" class="btn btn-warning backto" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>订单信息</h3>
			</div>
		</div>
		<hr style="margin-top: 5px; margin-bottom: 5px; ">
		<div class="row">
			<div class="col-sm-12" style="">
				<div class="detail_content">
					<div class="row">
						<div class="col-sm-7" style="">
							<div class="" style="position: relative;height: 55px;">
								<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;"></div>
								<h3 style="margin-left: 55px;position: relative;">
								订单号：${order.orderNo }
								<c:if test="${order.commissionStatus eq '00' and  order.sourceAppId ne '0'}">
									<div class="cmstatus" style="position: absolute;left: 58%;top: -5px;width: 80px;height: 30px;">	</div>
								</c:if>
								</h3>
							</div>
						</div>
						<div class="col-sm-5" style="">
							<div class="display-flex" style="position: relative;margin: 15px 0;" >
							<c:if test="${groupMap.ishotelsales and order.state gt '02' and order.state < '10'  and order.state !='03' and !(order.state eq '06' and order.settlementStatus eq '04')}">
								<div id="order_state_div" class="display-flex" >
									<button type="button"  qx="order:update" id="btn_order_state" class="btn btn-primary" >订单状态更改</button>
								</div>
							</c:if>
							<c:if test="${groupMap.iscompanysales and guserId eq order.companySaleId and order.orderType eq 'OFFLINE' and (order.state=='021' or order.state=='04')}">
								<div id="order_state_div" class="display-flex" >
									<button type="button"  qx="order:update" id="btn_order_state" class="btn btn-primary" >订单状态更改</button>
								</div>
							</c:if>
							<c:if test="${iscomission }">
								<div id="commission_div" class="display-flex" >
									<button type="button" qx="order:commissiom" id="btn_commission"  class="btn btn-primary" >确认返佣</button>
								</div>
							</c:if>
							<c:if test="${((groupMap.ishotelsales  and order.hotelSaleId eq guserId) or groupMap.ishotelsalesdirector) and order.state eq '-1'}"> <!--( || order.state eq '04')  -->
							<a qx="order:update" href="javascript:confirmQuotation(${order.id})" class="btn btn-primary" 
								style=""><span class="glyphicon glyphicon-pencil"> 确认报价</span></a>
								<script type="text/javascript">
								 function confirmQuotation(id){
									 cfm_swal("您确定确认该笔订单报价？","","warning","确认", "确认报价完成。","您取消了该操作！"
												,'${ctx}/weixin/order/confirm/quotation',{id:id},function(){
													loadContent(this,'${ctx}/base/order/detail/'+id,'');
										});
								 }
								</script>
							</c:if>
							</div>
						</div>
					</div>
					<form id="orderForm" action="${ctx}/weixin/order/modify">
					<input type="hidden"  name="orderNo" value="${order.orderNo}">
					<input type="hidden"  name="id" value="${order.id}">
					<!-- 基本信息 -->
					<div class="base">
						<div class="row">
							<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
						</div>
						<div class="row">
							<div class="col-sm-12 pad-10-k" >
								<div style="position: relative;">
									<span style="color: #019FEA;font-size: 20px;font-weight: bold;">预定的场地名称：${order.hotelName }</span>
									<div style="text-align: right;position:absolute;top: 10px;right:10px;"><!--  border-radius:50%; -->
										<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px;display: inline-block;text-align: center;">${dSv.trsltDict('05',order.state)}</span>
										&nbsp;&nbsp;
										<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px; display: inline-block;text-align: center;">${dSv.trsltDict('07',order.settlementStatus)}</span>
									</div>
								</div>
								<div class="pad-ud-5 bottom-line">
									<div class="row">
										<div class="col-sm-1" style="padding-right: 0;">活动名称：</div>
										<div class="col-sm-2" style="padding-left: 0;"><input type="text" name="activityTitle" value="${order.activityTitle}" ></div>
										<div class="col-sm-1" style="padding-right: 0;">活动地点：</div>
										<div class="col-sm-2" style="padding-left: 0;"><input type="text" name="area" value="${order.area}" ></div>
									</div>
								</div>
								<div class="pad-ud-5 bottom-line">
									<div class="row">
										<div class="col-sm-1" style="padding-right: 0;">活动时间：</div>
										<div class="col-sm-2" style="padding-left: 0;"><input type="date" name="activityDate" value="${order.activityDate}" ></div>
										<div class="col-sm-1" style="padding-right: 0;">举办单位：</div>
										<div class="col-sm-2" style="padding-left: 0;"><input type="text" name="organizer" value="${order.organizer}" ></div>
									</div>
									<%-- <span>活动时间：${order.activityDate}</span>
									<span class="pad-lr-10">-</span>
									<span style="">举办单位：${order.organizer}</span> --%>
								</div>
								<div class="pad-ud-5 bottom-line">
									<div class="row">
										<div class="col-sm-1" style="padding-right: 0;">联系方式：</div>
										<div class="col-sm-6 display-flex " style="padding-left: 0;">
											<input type="text" name="linkman" value="${order.linkman}" >
											<input type="text" name="contactNumber" value="${order.contactNumber}" >
											<input type="email" name="email" value="${order.email}" >
										</div>
									</div>
									<%-- <span style="">联系方式：${order.linkman }</span>
									<span class="pad-lr-5">-</span>
									<span style="">${order.contactNumber}</span>
									<span class="pad-lr-5">-</span>
									<span style="">${order.email}</span> --%>
								</div>
								<div class="pad-ud-5">
									<span style="">跟进销售：${hotelSale.rname}</span>
									<span class="pad-lr-5">-</span>
									<span style="">${hotelSale.mobile}</span>
								</div>
							</div>
						</div>
					</div>
					<!-- 活动场地选择 -->
					<div>
						<div class="row">
							<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">活动场地选择</span></div>
						</div>
						<div class="row hall">
							<div class="col-sm-12 pad-10-k hall-items">
								<!-- 主会厅 -->
								<c:if test="${not empty main_hotelplace}">
								<c:set var="hallIds" value="#${main_hotelplace.placeId}"></c:set>
								<div class="hall-item" style="width: 100%;">
									<input type="hidden"  name="orderDetailId" value="${main_hotelplace.id}" >
									<div class="row pad-ud-5 mgn-ud-5 bottom-line">
										<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">主会厅: ${main_hotelplace.placeName} </div>
										<div class="col-sm-4 display-flex" style="color: #999999;">
											<span>面积${main_hotelplace.hallArea}m²</span>
											<span>容纳人数${main_hotelplace.peopleNum}人</span>
											<span>层高${main_hotelplace.height}m</span>
											<span>楼层${main_hotelplace.floor}F</span>
											<span>立柱${main_hotelplace.pillar}</span>
										</div>
										<div class="col-sm-5">
										</div>
										<div class="col-sm-1 pad-no" style="text-align: right;">
											
											<c:if test="${(aUs.getCurrentUserId() eq order.hotelSaleId and (order.state eq '02' or order.state eq '04'))
												or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
											</c:if>
													<input type="hidden" name="ismain" value="${main_hotelplace.placeId }"  >
													<div  class="hall_detail_edit"  hallId="${main_hotelplace.placeId }" style="display: inline-block;">
														<img qx="order:update" id="hall_detail_edit_to_${main_hotelplace.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
														<img qx="order:update" id="hall_detail_edit_cancel_${main_hotelplace.placeId}" src="${ctx}/static/resource/css/images/cfm.png" style="display: none;"  class="btn-icon">
													</div>
													<div id="hall-del" class="hall-del"  hallId="${main_hotelplace.placeId }" style="display: inline-block;">
														<img qx="order:update" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon">
													</div>
											
										</div>
									</div>
									
									<div id="hallscheduleDetail${main_hotelplace.placeId }">
										<c:forEach items="${main_hotelplace.bookingRecordModels}"  var="bookingRecordModel" >
											<div class="display-flex" style="margin:0.5rem 0;color: #999999;width: 60%;">
												<div>
												<span>预定档期：${bookingRecordModel.placeDate}</span>
												<span class="pad-lr-5" style="border-radius:20px;border: 1px solid #999999;">${bookingRecordModel.placeScheduleTxt}</span>
												</div>
												<div>
													<span style="color: #019FEA;text-align: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
												</div>
											</div>
										</c:forEach>
									</div>
									
									<div id="hallscheduleUpForm${main_hotelplace.placeId }" style="display: none;color:#999999;position: relative;">
										<c:forEach items="${main_hotelplace.bookingRecordModels}"  var="bookingRecordModel" varStatus="st" >
											<div class="row pad-ud-5 mgn-ud-5">
												<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
												<div class="col-sm-4 pad-no">
													<div style="display: inline-block;vertical-align: middle;">
														<input type="date" class="hall-schedule date form-control"  name="scheduleDate_${main_hotelplace.placeId }" hallId="${main_hotelplace.placeId }"
															value="${bookingRecordModel.placeDate}"  style="float: left;" onchange="hallScheduleDate(this);">
													</div>
													<div style="display: inline-block;margin-left: 10px;vertical-align: middle;">
														<div class="timesolt" style="width: 180px;position: relative;" tabindex="1" hallid="${main_hotelplace.placeId }">
															<input type="hidden" id="" name="scheduleTime_${main_hotelplace.placeId }" value="${ fn:replace(bookingRecordModel.placeScheduleIds, ',', '#')}">   
															<input type="hidden" id="" name="scheduleTimeTxt_${main_hotelplace.placeId }" value="${bookingRecordModel.placeScheduleTxt }">   
															<div style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
																<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;">  ${bookingRecordModel.placeScheduleTxt}</span>
																<!-- <i class="" style="    font-size: 3em;"></i> -->
															</div>
															<div  class="timesolt-item" style="position: absolute;left: 0;top: 35px;background-color: #ffffff;width:100%;display: none;z-index: 20000;">
																<c:forEach items="${ctimes}" var="ctme">
																	<div style="width: 100%;height:30px; border: 1px solid #999999;">
																		<label for="timesolt_${ctme.id}_${bookingRecordModel.id}" style="width:100%;line-height:30px;vertical-align:middle;">
																			<input class="timesolt-select-item" id="timesolt_${ctme.id}_${bookingRecordModel.id}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" ${fn:contains(bookingRecordModel.placeScheduleIds, ctme.id)?'checked="checked"':''}>
																			${ctme.name}
																		</label>
																	</div>
																</c:forEach>
																<div style="width:100%;height:30px;border:1px solid #999999;">
																	<label for="timesolt_all_${bookingRecordModel.id}" style="width:100%;line-height:30px;vertical-align:middle;">
																		<input class="timesolt-select-item timesolt_all" id="timesolt_all_${bookingRecordModel.id}" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
																		全天
																	</label>
																</div>
																<div style="width:100%;height:40px;border:1px solid #999999;text-align: center;padding: 5px;">
																	<button type="button"  class="btn btn-primary btn-sm timesolt-select"  style="width: 40%;" hallId="${main_hotelplace.placeId }" >确定</button>
																	<button type="button"  class="btn btn-default btn-sm timesolt-cancel"  style="width: 40%;" hallId="${main_hotelplace.placeId }" >取消</button>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="col-sm-3 pad-no">
													 ￥<input type="number" class="price form-control" data="${bookingRecordModel.price }" value="${bookingRecordModel.price }" name="placePrice_${main_hotelplace.placeId }" id="" onkeyup="calculateHallSchedulePrice()" onchange="calculateHallSchedulePrice();">元
												</div>
												<div class="col-sm-1 pad-no">
													<img class="order-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
												</div>
											</div>
										</c:forEach>
										<div style="position: absolute;bottom: 10px;right: 32%;">
											  <img qx="order:update" class="hall-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" hallId="${main_hotelplace.placeId }" title="添加档期">
										</div>
									</div>
								
								</div>
								</c:if>
								<!-- 分会厅 -->
								<c:forEach items="${otherHalls}" var="otherHall">
									
								<div class="hall-item" style="width: 100%;">
									<input type="hidden"  name="orderDetailId" value="${otherHall.id}" >
									<c:set var="hallIds" value="${hallIds}#${otherHall.placeId}"></c:set>
									<div class="row pad-ud-5 mgn-ud-5 bottom-line">
										<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">分会厅: ${otherHall.placeName} </div>
										<div class="col-sm-4 display-flex" style="color: #999999;">
											<span>面积${otherHall.hallArea}m²</span>
											<span>容纳人数${otherHall.peopleNum}人</span>
											<span>层高${otherHall.height}m</span>
											<span>楼层${otherHall.floor}F</span>
											<span>立柱${otherHall.pillar}</span>
										</div>
										<div class="col-sm-5">
										</div>
										<div class="col-sm-1 pad-no" style="text-align: right;">
											<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
												or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
												or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
											</c:if>		<input type="hidden" name="ismain" value="${otherHall.placeId }"  >
													<div  class="hall_detail_edit"  hallId="${otherHall.placeId }" style="display: inline-block;">
														<img qx="order:update" id="hall_detail_edit_to_${otherHall.placeId}" src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png"  class="btn-icon">
														<img qx="order:update" id="hall_detail_edit_cancel_${otherHall.placeId}" src="${ctx}/static/resource/css/images/cfm.png"  class="btn-icon" style="display: none;">
													</div>
													<div id="hall-del" class="hall-del"  hallId="${otherHall.placeId }" style="display: inline-block;">
														<img qx="order:update" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon">
													</div>
											
										</div>
									</div>
									
									<div id="hallscheduleDetail${otherHall.placeId }">
									<c:forEach items="${otherHall.bookingRecordModels}"  var="bookingRecordModel" >
										<div class="display-flex" style="margin:0.5rem 0;color: #999999;width: 60%;">
											<div>
											<span>预定档期：${bookingRecordModel.placeDate}</span>
											<span class="pad-lr-5" style="border-radius:20px;border: 1px solid #999999;">${bookingRecordModel.placeScheduleTxt}</span>
											</div>
											<div>
												<span style="color: #019FEA;text-align: right;"><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
											</div>
										</div>
									</c:forEach>
									</div>
									
									<div id="hallscheduleUpForm${otherHall.placeId }" style="display: none;color:#999999;position: relative;">
										<c:forEach items="${otherHall.bookingRecordModels}"  var="bookingRecordModel" varStatus="st" >
											<div class="row pad-ud-5 mgn-ud-5">
												<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
												<div class="col-sm-4 pad-no">
													<div style="display: inline-block;vertical-align: middle;">
														<input type="date" class="hall-schedule date form-control"  name="scheduleDate_${otherHall.placeId }" hallId="${otherHall.placeId }"
															value="${bookingRecordModel.placeDate}"  style="float: left;" onchange="hallScheduleDate(this);">
													</div>
													<div style="display: inline-block;margin-left: 10px;vertical-align: middle;">
														<div class="timesolt" style="width: 180px;position: relative;" tabindex="1" hallid="${otherHall.placeId }">
															<input type="hidden" id="" name="scheduleTime_${otherHall.placeId }" value="${ fn:replace(bookingRecordModel.placeScheduleIds, ',', '#')}">   
															<input type="hidden" id="" name="scheduleTimeTxt_${otherHall.placeId }" value="${bookingRecordModel.placeScheduleTxt }">   
															<div style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
																<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;">  ${bookingRecordModel.placeScheduleTxt}</span>
																<!-- <i class="" style="    font-size: 3em;"></i> -->
															</div>
															<div  class="timesolt-item" style="position: absolute;left: 0;top: 35px;background-color: #ffffff;width:100%;display: none;z-index: 20000;">
																<c:forEach items="${ctimes}" var="ctme">
																	<div style="width: 100%;height:30px; border: 1px solid #999999;">
																		<label for="timesolt_${ctme.id}_${bookingRecordModel.id}" style="width:100%;line-height:30px;vertical-align:middle;">
																			<input class="timesolt-select-item" id="timesolt_${ctme.id}_${bookingRecordModel.id}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" ${fn:contains(bookingRecordModel.placeScheduleIds, ctme.id)?'checked="checked"':''}>
																			${ctme.name}
																		</label>
																	</div>
																</c:forEach>
																<div style="width:100%;height:30px;border:1px solid #999999;">
																	<label for="timesolt_all_${bookingRecordModel.id}" style="width:100%;line-height:30px;vertical-align:middle;">
																		<input class="timesolt-select-item timesolt_all" id="timesolt_all_${bookingRecordModel.id}" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
																		全天
																	</label>
																</div>
																<div style="width:100%;height:40px;border:1px solid #999999;text-align: center;padding: 5px;">
																	<button type="button"  class="btn btn-primary btn-sm timesolt-select"  style="width: 40%;" hallId="${otherHall.placeId }" >确定</button>
																	<button type="button"  class="btn btn-default btn-sm timesolt-cancel"  style="width: 40%;" hallId="${otherHall.placeId }" >取消</button>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="col-sm-3 pad-no">
													 ￥<input type="number" class="price form-control" value="${bookingRecordModel.price }" name="placePrice_${otherHall.placeId }" id="" onkeyup="calculateHallSchedulePrice()" onchange="calculateHallSchedulePrice();">元
												</div>
												<div class="col-sm-1 pad-no">
													<img class="order-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
												</div>
											</div>
										</c:forEach>
										<div style="position: absolute;bottom: 10px;right: 32%;">
											  <img qx="order:update" class="hall-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" hallId="${otherHall.placeId }" title="添加档期">
										</div>
									</div>
								</div>							
								</c:forEach>
								
							
							</div>
						</div>
						<!-- 会场价格 -->
						<div id="hallPriceDetail" class="bottom-line" style="font-weight:bold;padding: 0 5px">
							<input type="hidden" id="hallAmount" name="hallAmount" value="${bookPriceCount }">
							<input type="hidden" id="hallAllAmount" name="hallAllAmount" value="${bookPriceCount * (1 + bookServicePercent/100)}">
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">小计：<span id="hallAmnout_dv"><fmt:formatNumber type="currency" value="${bookPriceCount }"/></span></div>
			                        </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-6"></div>
			                            <div id="commissionFeeRate_dtl" class="col-md-6" style="text-align: right;">
			                            	场地加收服务费（<span id="serviceFeeRatedtl"><fmt:formatNumber type="number" value="${bookServicePercent }"  maxFractionDigits="0"/></span>%）
			                            	 ：<span id="serviceFeedtl"><fmt:formatNumber type="currency" value="${bookPriceCount*bookServicePercent/100 }" /></span>
			                            	 <%-- <fmt:formatNumber type="currency" value="${placePrice*commissionFeeRate/100 }"/> --%>
		                            	</div>
		                            	<div id="commissionFeeRate_edit" class="col-md-6" style="text-align: right;display: none;">
			                            	场地加收服务费:<input type="number" id="commissionFeeRate" name="commissionFeeRate" min="0" max="100" class="form-control" style="width: 80px;display: inline;"  value="${bookServicePercent }" onkeyup="calculateHallSchedulePrice();" onchange="calculateHallSchedulePrice();">%
			                            	 ：<span id="serviceFeedit"><fmt:formatNumber type="currency" value="${bookPriceCount*bookServicePercent/100 }" /></span>
		                            	</div>
			                        </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"> 
			                            	<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
											or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
											or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
											</c:if>
												 <span qx="order:update" class="btn add hall-add" style="">添加场地</span>
			                             </div>
			                  		    <div class="col-md-3" style="text-align: right;margin: 0.3rem 0;">
			                  		  		  合计：<span  id="hallAllAmnout_dv" style="color: red;"><fmt:formatNumber type="currency" value="${bookPriceCount * (1 + bookServicePercent/100)}" /></span>
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
										<img qx="order:update" onclick="meetingremarkShow('order_meetingremark')" title="修改场地预定备注" id="order_meetingremark" 
											src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
							 			<img qx="order:update" onclick="meetingremarkCancel('order_meetingremark_cancel')" title="取消修改场地预定备注" id="order_meetingremark_cancel" 
											src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
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
								/* meeting_editor.ready(function() {//编辑器初始化完成再赋值  
									meeting_editor.setContent('${empty order.meetingRemark?hotel.meetingRemark:order.meetingRemark}');  //赋值给UEditor  
						        }); */
						    </script>
						</div>
						<input type="hidden" id="hallIds" name="hallIds" value="${hallIds}">
						
						
						<script type="text/javascript">
							$(function(){
								$(".detail_content").delegate('.hall-add-schedule','click',function(){	//
									var $this = $(this);
									var placeId = $this.attr("hallId");
									var ramId = new Date().getTime();
									var schdl_item = $('#hall_schedule_item').text().split('{{id}}').join(placeId);
									schdl_item = schdl_item.split('{{ramId}}').join(ramId);
									var $hall_schedule=$(schdl_item);
									$hall_schedule.find('.order-del').click(function(){
										$hall_schedule.remove();
										calculateHallSchedulePrice();
									});
									$hall_schedule.find(".timesolt").focus(function(){
										var $this = $(this);
										var tabindex = $this.attr('tabindex');
										$this.attr('tabindex',-1);
										var hallId = $this.attr("hallid");
										var scheduleDate =$this.parent().prev().find('input[name="scheduleDate_'+hallId+'"]').val();
										var hotelId = '${order.hotelId}';
										$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
											if(res.statusCode==='200'){
												var k =0;
												for(var i=0;i<res.object.length;i++){
													var id='#'+res.object[i].id;
													var pschedule = res.object[i].placeSchedule;
													$this.find('input[type="checkbox"]').each(function(){
														var $self = $(this);
														if($self.val()==pschedule){
															$self.attr("price",res.object[i].onlinePrice);
															if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
																$self.attr("disabled","disabled");
																k++;
															}
														}
													});
													/* $this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("price",res.object[i].onlinePrice);
													if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
														$this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("disabled","disabled");
														k++;
													} */
													
												}
												
												if(k!=0){
													$this.find('input[id="timesolt_all"]').attr("disabled","disabled");
												}
												
												$this.find('.timesolt-item').show();
											}else{
												swal(res.message,'success');
											} 
										},"json");
									});

									$hall_schedule.find(".timesolt-select").click(function(){
										var $this = $(this);
										$this.attr('tabindex',1);
										$this.parent().parent().hide();
										var sles = [];
										var slestxt = [];
										var hallId = $this.attr('hallId');
										var n = 0;
										var sumPrice = 0;
										$this.parent().parent().find('input[type="checkbox"]:checked').each(function(){
											var $self = $(this);
											if($self.val()!='ALL'){
												sles.push($self.val());
												slestxt.push($self.attr('data'));
												sumPrice=$self.attr('price')*1;
												n++;
											}
										});
										if(n>=3){
											$this.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*3);
										}else{
											$this.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*n);
										}
										$this.parent().parent().prev().text(slestxt.join(','));
										$this.parent().parent().parent().find('input[name="scheduleTimeTxt_'+hallId+'"]').val(slestxt.join(','));
										$this.parent().parent().parent().find('input[name="scheduleTime_'+hallId+'"]').val(sles.join('#'));
										calculateHallSchedulePrice();
									});
									
									$hall_schedule.find(".timesolt-select-item").change(function(){
										var $this = $(this);
										if($this.val()=='ALL'&&$(this).attr("checked")){
											$this.parent().parent().parent().find('input[type="checkbox"]').each(function(){
												if($(this).attr("disabled")){
												
												}else{
													$(this).attr("checked","checked");
												}
											}); 
											//$this.parent().parent().parent().find('input[type="checkbox"]').attr("checked","checked");
										}else if($this.val()=='ALL'&&!$(this).attr("checked")){
											$this.parent().parent().parent().find('input[type="checkbox"]').removeAttr("checked"); 
										}else if(!$(this).attr("checked")){
											$this.parent().parent().parent().find('.timesolt_all').removeAttr("checked"); 
										}
										/* else if($this.val()=='ALL'&&){
											
										} */
									});
									$hall_schedule.find(".timesolt-cancel").click(function(){
										var $this = $(this);
										$hall_schedule.find(".timesolt-item").hide();
									});
									
									
									$this.parent().before($hall_schedule);
									
								});
								
								$(".detail_content").delegate('.hall-add','click',function(){
									var hallIds = $("#hallIds").val();
									$.get('${ctx}/weixin/hotelplace/list',{hotelId:'${order.hotelId}'},function(res){
										if(res.statusCode==200){
											var arr = [];
											for(var i=0;i<res.object.length;i++){
												var id='#'+res.object[i].id;
												if(hallIds.indexOf(id)<0){
													arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" hallId="'+res.object[i].id+'" hallName="'+res.object[i].placeName+'">'+res.object[i].placeName+'</div>');
												}
											}
											$("#halls_list").html(arr.join(''));
											show();
											$("#halls_div").show();
										}else{
											
										}
									},'json')
								});
								
								
								$("#halls_div").delegate('[hallid]','click',function(){	//场地列表点击事件
									var $this = $(this);
									var hallId = $this.attr('hallid');
									$.get('${ctx}/weixin/hotelplace/getone',{id:hallId,type:'HALL'},function(res){
										if(res.statusCode==200){
											res.object.ramId = new Date().getTime();
											var shtml =	template('hall_item', res.object);
											var $shl = 	$(shtml);
											$shl.find('.hall-del').click(function(){
												var hallIds = $("#hallIds").val();
												var hallId = $this.attr('hallid');
												$("#hallIds").val(hallIds.replace("#"+hallId,''));
												$shl.remove();
												calculateHallSchedulePrice()
											});
											$shl.find(".timesolt").focus(function(){
												var $this = $(this);
												var tabindex = $this.attr('tabindex');
												$this.attr('tabindex',-1);
												var hallId = $this.attr("hallid");
												var scheduleDate =$this.parent().prev().find('input[name="scheduleDate_'+hallId+'"]').val();
												var hotelId = '${order.hotelId}';
												$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
													if(res.statusCode==='200'){
														var k =0;
														for(var i=0;i<res.object.length;i++){
															var pschedule = res.object[i].placeSchedule;
															$this.find('input[type="checkbox"]').each(function(){
																var $self = $(this);
																if($self.val()==pschedule){
																	$self.attr("price",res.object[i].onlinePrice);
																	if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
																		$self.attr("disabled","disabled");
																		k++;
																	}
																}
															});
															/* $this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("price",res.object[i].onlinePrice);
															if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
																$this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("disabled","disabled");
																k++;
															} */
														}
														
														if(k!=0){
															$this.find('input[id="timesolt_all"]').attr("disabled","disabled");
														}
														
														$this.find('.timesolt-item').show();
													}else{
														swal(res.message,'success');
													} 
												},"json");
											});

											$shl.find(".timesolt-select").click(function(){
												var $thisselect = $(this);
												$thisselect.attr('tabindex',1);
												$thisselect.parent().parent().hide();
												var sles = [];
												var slestxt = [];
												var hallId = $thisselect.attr('hallId');
												var n = 0;
												var sumPrice = 0;
												$thisselect.parent().parent().find('input[type="checkbox"]:checked').each(function(){
													var $self = $(this);
													if($self.val()!='ALL'){
														sles.push($self.val());
														slestxt.push($self.attr('data'));
														sumPrice=$self.attr('price')*1;
														n++;
													}
												});
												if(n>=3){
													$thisselect.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*3);
												}else{
													$thisselect.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*n);
												}
												$thisselect.parent().parent().prev().text(slestxt.join(','));
												$thisselect.parent().parent().parent().find('input[name="scheduleTimeTxt_'+hallId+'"]').val(slestxt.join(','));
												$thisselect.parent().parent().parent().find('input[name="scheduleTime_'+hallId+'"]').val(sles.join('#'));
												calculateHallSchedulePrice();
											});
											
											$shl.find(".timesolt-select-item").change(function(){
												var $this = $(this);
												if($this.val()=='ALL'&&$(this).attr("checked")){
													$this.parent().parent().parent().find('input[type="checkbox"]').each(function(){
														if($(this).attr("disabled")){
															
														}else{
															$(this).attr("checked","checked");
														}
													}); 
													//$this.parent().parent().parent().find('input[type="checkbox"]').attr("checked","checked"); 
												}else if($this.val()=='ALL'&&!$(this).attr("checked")){
													$this.parent().parent().parent().find('input[type="checkbox"]').removeAttr("checked"); 
												}else if(!$(this).attr("checked")){
													$this.parent().parent().parent().find('.timesolt_all').removeAttr("checked"); 
												}
												/* else if($this.val()=='ALL'&&){
													
												} */
											});
											$shl.find(".timesolt-cancel").click(function(){
												var $this = $(this);
												$this.parent().parent().hide();
											});
											

											$shl.find(".hall_detail_edit").click(function(){
												$this = $(this);
												var placeId = $this.attr("hallId");
												if($this.hasClass('edit')){
													
													sumALLprice(); 
													
													var ditem ='<div class="display-flex" style="margin:0.5rem 0;color: #999999;width: 60%;"> <div> <span>预定档期：{date}</span> <span class="pad-lr-5" style="border-radius:20px;border: 1px solid #999999;">{sch}</span> </div> <div> <span style="color: #019FEA;text-align: right;">￥{price}</span> </div> </div>';
													var items = [];
													$("#hallscheduleUpForm"+placeId).find(".row").each(function(){
														var $this = $(this);
														
														var date = $this.find('input[type="date"]').val();
														var sch = $this.find('input[name="scheduleTimeTxt_'+placeId+'"]').val();
														var price = $this.find('input[type="number"]').val();
														
														var dtm = ditem;
														dtm = dtm.replace('{date}',date).replace('{sch}',sch).replace('{price}',common.formatCurrency(price*1));
														items.push(dtm);
													});
													
													$("#hallscheduleDetail"+placeId).empty();
													$("#hallscheduleDetail"+placeId).html(items.join(''));
													
													$this.removeClass('edit');
													$("#hall_detail_edit_to_"+placeId).show();
													$("#hall_detail_edit_cancel_"+placeId).hide();
													$("#hallscheduleDetail"+placeId).show();
													$("#hallscheduleUpForm"+placeId).hide();
													
													//$("#hallscheduleUpForm"+placeId).html($edit);
													
													$("#commissionFeeRate_edit").hide();
													$("#commissionFeeRate_dtl").show();
													
													$("#halltitle_show_"+placeId).show();
													$("#halltitle_edit_"+placeId).hide();
													
												}else{
													$this.addClass('edit');
													$("#hall_detail_edit_to_"+placeId).hide();
													$("#hall_detail_edit_cancel_"+placeId).show();
													$("#hallscheduleDetail"+placeId).hide();
													$("#hallscheduleUpForm"+placeId).show();
													
													$("#commissionFeeRate_edit").show();
													$("#commissionFeeRate_dtl").hide();
													
													$("#halltitle_show_"+placeId).hide();
													$("#halltitle_edit_"+placeId).show();
												}
											});
											
											
											$(".hall-items").append($shl);
											var hallIds = $("#hallIds").val();
											$("#hallIds").val(hallIds+"#"+hallId);
											$("#halls_div").hide();
											hide();
											$("#commissionFeeRate_edit").show();
											$("#commissionFeeRate_dtl").hide();
										}
									},'json')
									
								});
								
								
								$(".hall_detail_edit").click(function(){
									$this = $(this);
									var placeId = $this.attr("hallId");
									if($this.hasClass('edit')){
										
										/* $("#hallAmount").val("${bookPriceCount}");
										$("#hallAllAmount").val("${bookPriceCount * (1 + bookServicePercent/100)}");
										
										$("#serviceFeeRatedtl").text("${bookServicePercent}"*1);
										$("#serviceFeedtl").text("￥"+common.formatCurrency("${bookPriceCount * bookServicePercent/100}"*1));
										
										$("#commissionFeeRate").val("${bookServicePercent}"*1);
										$("#serviceFeedit").text("￥"+common.formatCurrency("${bookPriceCount * bookServicePercent/100}"*1));
										
										$("#hallAmnout_dv").text("￥"+common.formatCurrency("${bookPriceCount}"*1));
										$("#hallAllAmnout_dv").text("￥"+common.formatCurrency("${bookPriceCount * (1 + bookServicePercent/100)}"*1)); */
										
										sumALLprice(); 
										
										var ditem ='<div class="display-flex" style="margin:0.5rem 0;color: #999999;width: 60%;"> <div> <span>预定档期：{date}</span> <span class="pad-lr-5" style="border-radius:20px;border: 1px solid #999999;">{sch}</span> </div> <div> <span style="color: #019FEA;text-align: right;">￥{price}</span> </div> </div>';
										var items = [];
										$("#hallscheduleUpForm"+placeId).find(".row").each(function(){
											var $this = $(this);
											
											var date = $this.find('input[type="date"]').val();
											var sch = $this.find('input[name="scheduleTimeTxt_'+placeId+'"]').val();
											var price = $this.find('input[type="number"]').val();
											
											var dtm = ditem;
											dtm = dtm.replace('{date}',date).replace('{sch}',sch).replace('{price}',common.formatCurrency(price*1));
											items.push(dtm);
										});
										
										$("#hallscheduleDetail"+placeId).empty();
										$("#hallscheduleDetail"+placeId).html(items.join(''));
										
										$this.removeClass('edit');
										$("#hall_detail_edit_to_"+placeId).show();
										$("#hall_detail_edit_cancel_"+placeId).hide();
										$("#hallscheduleDetail"+placeId).show();
										$("#hallscheduleUpForm"+placeId).hide();
										
										//$("#hallscheduleUpForm"+placeId).html($edit);
										
										$("#commissionFeeRate_edit").hide();
										$("#commissionFeeRate_dtl").show();
										
										$("#halltitle_show_"+placeId).show();
										$("#halltitle_edit_"+placeId).hide();
										
									}else{
										$this.addClass('edit');
										$("#hall_detail_edit_to_"+placeId).hide();
										$("#hall_detail_edit_cancel_"+placeId).show();
										$("#hallscheduleDetail"+placeId).hide();
										$("#hallscheduleUpForm"+placeId).show();
										
										$("#commissionFeeRate_edit").show();
										$("#commissionFeeRate_dtl").hide();
										
										$("#halltitle_show_"+placeId).hide();
										$("#halltitle_edit_"+placeId).show();
									}
								});
								
								$('.hall-del').click(function(){
									var hallIds = $("#hallIds").val();
									var hallId = $(this).attr('hallid');
									$("#hallIds").val(hallIds.replace("#"+hallId));
									$(this).parent().parent().parent().remove();
									calculateHallSchedulePrice();
								});
								
								$('.order-del').click(function(){
									$(this).parent().parent().remove();
									calculateHallSchedulePrice();
								});
								
								/* 	$(".timesolt").click(function(){
										var $this = $(this);
										$this.next().show();
									}); */
									/* 	$(".timesolt").blur(function(){
									var $this = $(this);
									var tabindex = $this.attr('tabindex');
									$this.attr('tabindex',1);
									$this.find('.timesolt-item').hide();
								});  */

								$(".timesolt").focus(function(){
									var $this = $(this);
									var tabindex = $this.attr('tabindex');
									$this.attr('tabindex',-1);
									var hallId = $this.attr("hallid");
									var scheduleDate =$this.parent().prev().find('input[name="scheduleDate_'+hallId+'"]').val();
									var hotelId = '${order.hotelId}';
									$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
										if(res.statusCode==='200'){
											var k =0;
											for(var i=0;i<res.object.length;i++){
												var pschedule = res.object[i].placeSchedule;
												$this.find('input[type="checkbox"]').each(function(){
													var $self = $(this);
													if($self.val()==pschedule){
														$self.attr("price",res.object[i].onlinePrice);
														if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
															$self.attr("disabled","disabled");
															k++;
														}
													}
												});
												/* $this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("price",res.object[i].onlinePrice);
												if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
													$this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("disabled","disabled");
													k++;
												} */	
											}
											if(k!=0){
												$this.find('input[id="timesolt_all"]').attr("disabled","disabled");
											}
											
											$this.find('.timesolt-item').show();
										}else{
											swal(res.message,'success');
										} 
									},"json");
									
								});

								$(".timesolt-select").click(function(){
									var $this = $(this);
									$this.attr('tabindex',1);
									$this.parent().parent().hide();
									var sles = [];
									var slestxt = [];
									var hallId = $this.attr('hallId');
									var n = 0;
									var sumPrice = 0;
									$this.parent().parent().find('input[type="checkbox"]:checked').each(function(){
										var $self = $(this);
										if($self.val()!='ALL'){
											sles.push($self.val());
											slestxt.push($self.attr('data'));
											sumPrice=$self.attr('price')*1;
											n++;
										}
									});
									if(n>=3){
										$this.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*3);
									}else{
										$this.parent().parent().parent().parent().parent().next().find("input[name='placePrice_"+hallId+"']").val(sumPrice*n);
									}
									$this.parent().parent().prev().text(slestxt.join(','));
									$this.parent().parent().parent().find('input[name="scheduleTimeTxt_'+hallId+'"]').val(slestxt.join(','));
									$this.parent().parent().parent().find('input[name="scheduleTime_'+hallId+'"]').val(sles.join('#'));
									calculateHallSchedulePrice();
								});
								
								$(".timesolt-select-item").change(function(){
									var $this = $(this);
									if($this.val()=='ALL'&&$(this).attr("checked")){
										$this.parent().parent().parent().find('input[type="checkbox"]').each(function(){
											if($(this).attr("disabled")){
												
											}else{
												$(this).attr("checked","checked");
											}
										}); 
										//$this.parent().parent().parent().find('input[type="checkbox"]').attr("checked","checked"); 
									}else if($this.val()=='ALL'&&!$(this).attr("checked")){
										$this.parent().parent().parent().find('input[type="checkbox"]').removeAttr("checked"); 
									}else if(!$(this).attr("checked")){
										$this.parent().parent().parent().find('.timesolt_all').removeAttr("checked"); 
									}
									/* else if($this.val()=='ALL'&&){
										
									} */
								});
								
								$(".timesolt-cancel").click(function(){
									var $this = $(this);
									$this.parent().parent().hide();
								});
								
							});
							
							

							function hallScheduleDate(self){
								 var $this = $(self);
								 var placeId=$this.attr("hallId");
								 var scheduleDate = $this.val();
								 var scheduleTime = $this.parent().next().find('select').val();
								 getHallSchedule(placeId,scheduleDate,scheduleTime,$this);
							}
							function hallScheduleTime(self){
								 var $this = $(self);
								 var placeId=$this.attr("hallId");
								 var scheduleDate =$this.parent().prev().find('input').val();
								 var scheduleTime = $this.val();
								 getHallSchedule(placeId,scheduleDate,scheduleTime,$this)
							}
							function getHallSchedule(placeId,scheduleDate,scheduleTime,$this){
								var hotelId = "${order.hotelId}";
								$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:placeId,scheduleDate:scheduleDate,scheduleTime:scheduleTime},function(res){
									if(res.statusCode==='200'){
										$this.find("input[name='hallScheduleId_"+placeId+"']").val(res.object.id);
										if(scheduleTime===4){
											$this.parent().parent().next().find("input[name='placePrice_"+placeId+"']").val(res.object.onlinePrice*3);
										}else{
											$this.parent().parent().next().find("input[name='placePrice_"+placeId+"']").val(res.object.onlinePrice*scheduleTime);
										}
										
										calculateHallSchedulePrice();
									}else{
										alert(res.message);
									} 
								},"json");
							}

							function calculateHallSchedulePrice(){
								 var sumHallSchedulePrice =0.00;
								 var serviceFeeRate = $("#commissionFeeRate").val()*1;
								 
								 var allHallSchedulePrice =0.00;
								 $('.hall .price').each(function(){
									 if($(this).val()){
										 sumHallSchedulePrice+=$(this).val()*1;
									 }
								 });
								 var allHallSchedulePrice = sumHallSchedulePrice*(1+serviceFeeRate/100);
								 var serviceFee = sumHallSchedulePrice*serviceFeeRate/100
								 $("#hallAmount").val(sumHallSchedulePrice);
								 $("#hallAllAmount").val(allHallSchedulePrice);
								 
								 //$("#serviceFee").text("￥"+common.formatCurrency(serviceFee));
								 $("#hallAmnout_dv").text("￥"+common.formatCurrency(sumHallSchedulePrice));
								 $("#hallAllAmnout_dv").text("￥"+common.formatCurrency(allHallSchedulePrice));
								 
								 $("#serviceFeeRatedtl").text(serviceFeeRate);
								 $("#serviceFeedtl").text("￥"+common.formatCurrency(serviceFee));
								 $("#serviceFeedit").text("￥"+common.formatCurrency(serviceFee));
								 
								sumALLprice();
							}
							
						</script>
					</div>
					
					<!--住房选择  -->
					<div>
						<div class="row">
							<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">住房选择</span></div>
						</div>
						<!-- 住房详情 -->
						<div class="row room">
							<div class="col-sm-12 room-items" style="padding: 10px 30px 5px;">
								<c:set var="roomIds" value=""></c:set>
								<c:forEach items="${rooms}" var="room">
									<div>
										<input type="hidden"  name="orderDetailId" value="${room.id}" >
										<input type="hidden" id="hotelPrice${room.placeId}" name="hotelPrice${room.placeId}" value="${room.bookingRecordModels[0].price}">
										<c:set var="roomIds" value="${roomIds}#${room.placeId}"></c:set>
										
										<div class="row pad-ud-5 mgn-ud-5 bottom-line">
											<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">${room.placeName}</span></div>
											<div class="col-sm-9"></div>
											<div class="col-sm-1 pad-no" style="text-align: right;">
												<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
													or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
													or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
												</c:if>
													<div class="room_detail_edit" roomId="${room.placeId}" style="display: inline-block;">
														<img qx="order:update" id="room_detail_edit_to_${room.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png"  class="btn-icon" title="编辑住房档期详情">
														<img qx="order:update" id="room_detail_edit_cancel_${room.placeId}" src="${ctx }/static/resource/css/images/cfm.png" class="btn-icon" style="display: none;" title="确认住房档期详情">
													</div>
													<div class="room-del" roomId="${room.placeId}" style="display: inline-block;">
														<img qx="order:update" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon" title="删除住房档期详情">
													</div>
											</div>
										</div>
										
										<div id="roomViewDetail${room.placeId}">
											<c:forEach items="${room.bookingRecordModels}"  var="bookingRecordModel" >
												<div class="row pad-ud-5 mgn-ud-5 bottom-line">
													<div class="col-sm-3 display-flex" style="color: #999999;">
														<span style="">${room.roomType  }</span>
														<span style="">-</span>
														<span style="">${room.network}</span>
														<span style="">-</span>
														<span style="">${(empty bookingRecordModel.breakfast or bookingRecordModel.breakfast eq 0)?'无早':'有早' }</span>
														<span style="">-</span>
														<span style="">×${bookingRecordModel.quantity }</span>
													</div>
													<div class="col-sm-3" style="text-align: right;color: #019FEA;">
														<span>入住时间：${bookingRecordModel.placeDate} </span>
													</div>
													<div class="col-sm-3" style="text-align: right;color: #019FEA;">
														<span><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
													</div>
													<div class="col-sm-3" style="text-align: right;">
														<span>预定费用：<fmt:formatNumber type="currency" value="${bookingRecordModel.price*bookingRecordModel.quantity }" /> </span>
													</div>
												</div>
											</c:forEach>
										</div>
										
										<div id="roomEditForm${room.placeId}" style="display: none;position: relative;">
											<c:forEach items="${room.bookingRecordModels}"  var="bookingRecordModel" >
												<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
													<input type="hidden" id="roomscheduleId_${room.placeId}" name="roomscheduleId_${room.placeId}" value="${bookingRecordModel.placeScheduleId}">
													<div class="col-sm-2 pad-ud-5 rtype" >
														<span style="vertical-align: middle;">${room.roomType}</span>
														<span style="vertical-align: middle;">-</span>
														<span style="vertical-align: middle;">${room.network}</span>
													</div>
													<div class="col-sm-1 pad-no" >
														<select class="room-breakfast form-control" name="breakfast_${room.placeId}" roomId="${room.placeId}"  style="width: 80px;">
															<option value="0" ${(empty bookingRecordModel.breakfast or bookingRecordModel.breakfast eq 0)?'selected="selected"':'' }>无早</option>
															<option value="1" ${ bookingRecordModel.breakfast eq 1 ?'selected="selected"':'' }>有早</option>
														</select>
													</div>
													<div class="col-sm-2 pad-no" >
														<div style="float: left;padding: 8px 0;">数量：</div>
														<div class="num minus" roomId="${room.placeId}"  style="float: left;margin: 6px 0;">-</div>
														<div class="room-num" style="float: left;margin: 6px 0;">
															<input type="number" name="rom_num_${room.placeId}" id="rom_num_${room.placeId}" style="border: none;width: 50px;text-align: center;" value="${bookingRecordModel.quantity }" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">
														</div>
														<div class="num plus" roomId="${room.placeId}" style="float: left;margin: 6px 0;">+</div>
														<div style="clear:both;"></div>
													</div>
													<div class="col-sm-3 pad-no" >
														 <span style="display: inline-block;vertical-align: middle;">入住时间：</span>
														 <input type="date" class="room-schedule date form-control" id="roomscheduleDate_${room.placeId}" name="roomscheduleDate_${room.placeId}" roomId="${room.placeId}"
															  onchange="roomScheduleDate(this)" value="${bookingRecordModel.placeDate}" style="display: inline-block;vertical-align: middle;">
													</div>
													<div class="col-sm-2 pad-no">
														￥<input type="number" class="price form-control"   value="${bookingRecordModel.price}" name="roomPrice_${room.placeId}" id="roomPrice${room.placeId}" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">元/间
													</div>
													<div class="col-sm-1 pad-no" >
														<img class="room-schedule-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
													</div>
												</div>
											</c:forEach>
										
											<div style="position: absolute;bottom: 14px;right: 15%;">
												  <img qx="order:update" class="room-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" title="添加档期" roomId="${room.placeId}">
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
			                            <c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
											or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
											or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
										</c:if>
											<div style="padding: 0.2rem 0;">
												 <div style="width: 100%;padding:0.2rem 0;">
													 <span qx="order:update" class="btn add room-add" style="">添加住房</span>
												 </div>
											</div>
		            		          </div>
		                            <div class="col-md-3" style="text-align: right;margin: 0.8rem 0;font-weight: bold;">
		                            	合计：<span id="allRoomSchedulePrice" style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice}"/></span>
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
										<img qx="order:update" onclick="houseRemarkShow('order_houseRemark')" title="修改场地预定备注" id="order_houseRemark" 
											src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
							 			<img qx="order:update" onclick="houseRemarkCancel('order_houseRemark_cancel')" title="取消修改场地预定备注" id="order_houseRemark_cancel" 
											src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
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
						    </script>
						</div>
				
						<input type="hidden" id="roomIds" name="roomIds" value="${roomIds}">
						<input type="hidden" id="roomAmount" name="roomAmount" value="${roomPrice}">
						<input type="hidden" id="roomAllAmount" name="roomAllAmount" value="${roomPrice}">
						
						
						<script type="text/javascript">
							$(function(){
								$(".detail_content").delegate('.room-add-schedule','click',function(){	//
									var $this = $(this);
									var placeId = $this.attr("roomId");
									var hotelPrice = $("#hotelPrice"+placeId).val();
									var roomDetail = $this.parent().prev().find("div.rtype").html();
									console.log("roomDetail>>>>"+roomDetail);
									var schdl_item = $('#room_schedule_item').text().split('{{id}}').join(placeId);
									schdl_item = schdl_item.replace('{{roomDetail}}',roomDetail);
									schdl_item = schdl_item.replace('{{hotelPrice}}',hotelPrice);
									var $room_schedule=$(schdl_item);
									$room_schedule.find(".room-schedule-del").click(function(){
										$room_schedule.remove();
										calculateRoomSchedulePrice();
									})
									$this.parent().before($room_schedule);
									
								});
								
								$(".room-schedule-del").click(function(){
									$(this).parent().parent().remove();
									calculateRoomSchedulePrice();
								});
								
								$(".detail_content").delegate('.room-add','click',function(){
									var roomIds = $("#roomIds").val();
									$.get('${ctx}/weixin/hotelplace/room/list',{hotelId:'${order.hotelId}'},function(res){
										if(res.statusCode==200){
											var arr = [];
											for(var i=0;i<res.object.length;i++){
												var id='#'+res.object[i].id;
												if(roomIds.indexOf(id)<0){
													arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" roomId="'+res.object[i].id+'" roomName="'+res.object[i].placeName+'">'+res.object[i].placeName+'</div>');
												}
											}
											$("#rooms_list").html(arr.join(''));
											show();
											$("#rooms_div").show();
										}else{
											
										}
									},'json')
								});
								
								
								
								$("#rooms_div").delegate('[roomId]','click',function(){	//住房列表点击事件
									var $this = $(this);
									var roomId = $this.attr('roomId');
									var date = '${order.activityDate}'
									$.get('${ctx}/weixin/hotelplace/getone',{id:roomId,type:'ROOM',date:date},function(res){
										if(res.statusCode==200){
											var shtml =	template('room_item', res.object);
											var $shl = 	$(shtml);
											$shl.find('.room-del').click(function(){
												var roomIds = $("#roomIds").val();
												var roomId = $this.attr('roomId');
												$("#roomIds").val(roomIds.replace("#"+roomId,''));
												$shl.remove();
												calculateRoomSchedulePrice();
											});
											
											$shl.find(".room-schedule-del").click(function(){
												$(this).parent().parent().remove();
												calculateRoomSchedulePrice();
											});
											
											$shl.find(".room_detail_edit").click(function(){
												$this = $(this);
												var placeId = $this.attr("roomId");
												if($this.hasClass('edit')){
												
													var ditem ='<div class="row pad-ud-5 mgn-ud-5 bottom-line"><div class="col-sm-3 display-flex" style="color: #999999;"> {roomDetail}<span style="">-</span><span style="">{breakfast}</span><span style="">-</span><span style="">×{rom_num}</span></div><div class="col-sm-3" style="text-align: right;color: #019FEA;"><span>入住时间：{roomscheduleDate} </span></div><div class="col-sm-3" style="text-align: right;color: #019FEA;"><span>￥{roomPrice}</span></div><div class="col-sm-3" style="text-align: right;"><span>预定费用：￥{allPrice} </span></div></div>';
													var items = [];
													$("#roomEditForm"+placeId).find(".row").each(function(){
														var $this = $(this);
														var roomDetail = $this.find("div.rtype").html();
														var breakfast = $this.find('select[name="breakfast_'+placeId+'"]').val();
														var rom_num = $this.find('input[name="rom_num_'+placeId+'"]').val();
														var roomscheduleDate = $this.find('input[name="roomscheduleDate_'+placeId+'"]').val();
														var roomPrice = $this.find('input[name="roomPrice_'+placeId+'"]').val();
														breakfast = breakfast==='1'?'有早':'无早';
														var dtm = ditem;
														dtm = dtm.replace('{roomDetail}',roomDetail).replace('{breakfast}',breakfast).replace('{roomPrice}',common.formatCurrency(roomPrice*1))
														.replace('{allPrice}',common.formatCurrency(roomPrice*1*rom_num)).replace('{rom_num}',rom_num).replace('{roomscheduleDate}',roomscheduleDate);
														items.push(dtm);
													});
													
													$("#roomViewDetail"+placeId).empty();
													$("#roomViewDetail"+placeId).html(items.join(''));
													
													
													$this.removeClass('edit');
													$("#room_detail_edit_to_"+placeId).show();
													$("#room_detail_edit_cancel_"+placeId).hide();
													$("#roomViewDetail"+placeId).show();
													$("#roomEditForm"+placeId).hide();
													
												}else{
													$this.addClass('edit');
													$("#room_detail_edit_to_"+placeId).hide();
													$("#room_detail_edit_cancel_"+placeId).show();
													$("#roomViewDetail"+placeId).hide();
													$("#roomEditForm"+placeId).show();
												}
											});
											
											$(".room-items").append($shl);
											var roomIds = $("#roomIds").val();
											$("#roomIds").val(roomIds+"#"+roomId);
											$("#rooms_div").hide();
											hide();
										}
									},'json')
									
								});
								
								$(".room_detail_edit").click(function(){
									$this = $(this);
									var placeId = $this.attr("roomId");
									if($this.hasClass('edit')){
									
										var ditem ='<div class="row pad-ud-5 mgn-ud-5 bottom-line"><div class="col-sm-3 display-flex" style="color: #999999;"> {roomDetail}<span style="">-</span><span style="">{breakfast}</span><span style="">-</span><span style="">×{rom_num}</span></div><div class="col-sm-3" style="text-align: right;color: #019FEA;"><span>入住时间：{roomscheduleDate} </span></div><div class="col-sm-3" style="text-align: right;color: #019FEA;"><span>￥{roomPrice}</span></div><div class="col-sm-3" style="text-align: right;"><span>预定费用：￥{allPrice} </span></div></div>';
										var items = [];
										$("#roomEditForm"+placeId).find(".row").each(function(){
											var $this = $(this);
											var roomDetail = $this.find("div.rtype").html();
											var breakfast = $this.find('select[name="breakfast_'+placeId+'"]').val();
											var rom_num = $this.find('input[name="rom_num_'+placeId+'"]').val();
											var roomscheduleDate = $this.find('input[name="roomscheduleDate_'+placeId+'"]').val();
											var roomPrice = $this.find('input[name="roomPrice_'+placeId+'"]').val();
											breakfast = breakfast==='1'?'有早':'无早';
											var dtm = ditem;
											dtm = dtm.replace('{roomDetail}',roomDetail).replace('{breakfast}',breakfast).replace('{roomPrice}',common.formatCurrency(roomPrice*1))
											.replace('{allPrice}',common.formatCurrency(roomPrice*1*rom_num)).replace('{rom_num}',rom_num).replace('{roomscheduleDate}',roomscheduleDate);
											items.push(dtm);
										});
										
										$("#roomViewDetail"+placeId).empty();
										$("#roomViewDetail"+placeId).html(items.join(''));
										
										
										$this.removeClass('edit');
										$("#room_detail_edit_to_"+placeId).show();
										$("#room_detail_edit_cancel_"+placeId).hide();
										$("#roomViewDetail"+placeId).show();
										$("#roomEditForm"+placeId).hide();
										
									}else{
										$this.addClass('edit');
										$("#room_detail_edit_to_"+placeId).hide();
										$("#room_detail_edit_cancel_"+placeId).show();
										$("#roomViewDetail"+placeId).hide();
										$("#roomEditForm"+placeId).show();
									}
								});
								
								$('.room-del').click(function(){
									var roomIds = $("#roomIds").val();
									var roomId = $(this).attr('roomId');
									$("#roomIds").val(roomIds.replace("#"+roomId).replace(',,',','));
									$(this).parent().parent().parent().remove();
									calculateRoomSchedulePrice();
								});
								
								$(".detail_content").delegate('.minus','click',function(){	
									$this = $(this);
									var num = $this.next().find('input').val()*1;
									if(num*1>0){
										var cnum = num-1;
										$this.next().find('input').val(cnum);
									}else{
										
									}
									calculateRoomSchedulePrice();
								});
								
								$(".detail_content").delegate('.plus','click',function(){	
									$this = $(this);
									var num = $this.prev().find('input').val()*1;
									var cnum = num+1;
									$this.prev().find('input').val(cnum);
									calculateRoomSchedulePrice();
									
								});
							});
							
							
							function calculateRoomSchedulePrice(){
								 var sumRoomSchedulePrice =0.00;
								 var allRoomSchedulePrice =0.00;
								 $('.room .price').each(function(){
									 if($(this).val()){
										 var arr = $(this).attr('id').split('_');
										 var placeId = arr[1];
										 var idx = arr[2];
										 var num = $(this).parent().parent().find("div.room-num").find('input[type="number"]').val()*1;
										 sumRoomSchedulePrice+=$(this).val()*1*num;
									 }
								 });
								 allRoomSchedulePrice = sumRoomSchedulePrice;
								 $("#roomAmount").val(sumRoomSchedulePrice);
								 $("#roomAllAmount").val(allRoomSchedulePrice);
								 //$("#sumRoomSchedulePrice").text("￥"+common.formatCurrency(sumRoomSchedulePrice));
								 $("#allRoomSchedulePrice").text("￥"+common.formatCurrency(allRoomSchedulePrice));
								 
								 sumALLprice();
							}
						</script>
					</div>
					
					<!--用餐选择  -->
					<div>
						<div class="row">
							<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">用餐选择</span></div>
						</div>
						<!-- 用餐详情 -->
						<div class="row meal">
							<div class="col-sm-12 meal-items" style="padding: 10px 30px 5px;">
								<c:set var="mealIds" value=""></c:set>
								<c:forEach items="${meals}" var="meal">
									<div>
										<input type="hidden"  name="orderDetailId" value="${meal.id}" >
										<c:set var="mealIds" value="${mealIds}#${meal.placeId}"></c:set>
										<c:set var="originalPrice" value="0"></c:set>
										
										<div class="row pad-ud-5 mgn-ud-5 bottom-line">
											<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">${meal.placeName}</span></div>
											<div class="col-sm-9"></div>
											<div class="col-sm-1 pad-no" style="text-align: right;">
												<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
											or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
											or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
												</c:if>
													<div class="meal_detail_edit" mealId="${meal.placeId}" style="display: inline-block;">
														<img qx="order:update" id="meal_detail_edit_to_${meal.placeId}" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon" title="编辑用餐详情">
														<img qx="order:update" id="meal_detail_edit_cancel_${meal.placeId}" src="${ctx }/static/resource/css/images/cfm.png" class="btn-icon" style="display: none;" title="确认用餐详情">
													</div>
													<div class="meal-del" mealId="${meal.placeId}" style="display: inline-block;">
														<img qx="order:update" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon" title="删除用餐详情">
													</div>
											</div>
										</div>
										
										<div id="mealViewForm${meal.placeId}">
											<c:forEach items="${meal.bookingRecordModels}"  var="bookingRecordModel" >
												<div class="row pad-ud-5 mgn-ud-5 bottom-line">
													<div class="col-sm-3 pad-no" style="color: #999999;">
														<span>${bookingRecordModel.mealType eq '01'?'围餐':'自助餐'}</span>
														<span>-</span>
														<span>×${bookingRecordModel.quantity }${meal.mealType eq '01'?'围':'个'}</span>
													</div>
													<div class="col-sm-3 pad-no" style="color: #019FEA;">
														<span>用餐时间：${bookingRecordModel.placeDate}</span>
														<span style="">${bookingRecordModel.placeSchedule }</span>
													</div>
													<div class="col-sm-3 pad-no" style="color: #019FEA;text-align: right;">
														<span style=""><fmt:formatNumber type="currency" value="${bookingRecordModel.price }" /></span>
													</div>
													<div class="col-sm-3 pad-no" style="text-align : right;">
														<span>预定费用<fmt:formatNumber type="currency" value="${bookingRecordModel.price*bookingRecordModel.quantity }" /></span>
													</div>
												</div>
											</c:forEach>
										</div>
										<div id="mealEditForm${meal.placeId}" style="display: none;position: relative;">
											<c:forEach items="${meal.bookingRecordModels}"  var="bookingRecordModel" >
												<c:set var="originalPrice" value="${bookingRecordModel.price }"></c:set>
												<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
													<input type="hidden"  name="bookingRecordId" value="${bookingRecordModel.id}" >
													<div class="col-sm-1 pad-no" >
														<select id="mealType_${meal.placeId}" name="mealType_${meal.placeId}" mealId="${meal.placeId}" class="meal-type form-control" style="width: 90px;">
															<option value="01" ${bookingRecordModel.mealType eq '01'?'selected="selected"':''}>围餐</option>
															<option value="02" ${bookingRecordModel.mealType eq '02'?'selected="selected"':''}>自助餐</option>
														</select>
													</div>
													<div class="col-sm-1 pad-no" >
														<select id="mealscheduleTime_${meal.placeId}" name="mealscheduleTime_${meal.placeId}"  mealId="${meal.placeId}" class="meal-cgt form-control"  style="width: 90px;">
															<option value="早餐" ${bookingRecordModel.placeSchedule eq '早餐'?'selected="selected"':'' }>早餐</option>
															<option value="午餐" ${bookingRecordModel.placeSchedule eq '午餐'?'selected="selected"':'' }>午餐</option>
															<option value="晚餐" ${bookingRecordModel.placeSchedule eq '晚餐'?'selected="selected"':'' }>晚餐</option>
														</select>
													</div>
													<div class="col-sm-3 pad-no" >
												 		<span style="display: inline-block;vertical-align: middle;">用餐时间：</span>
														<input type="date" class="meal-schedule date form-control" id="mealscheduleDate_${meal.placeId}" style="display: inline-block;vertical-align: middle;"
														name="mealscheduleDate_${meal.placeId}" mealId="${meal.placeId}" onchange="mealScheduleDate(this)" value="${bookingRecordModel.placeDate }">
														<input type="hidden" id="mealscheduleId_${meal.placeId}" name="mealscheduleId_${meal.placeId}" value="${bookingRecordModel.id }">
													</div>
													<div class="col-sm-2 pad-no" >
														<div style="float: left;padding: 8px 0;">数量：</div>
														<div class="num meal-minus" style="float: left;margin: 6px 0;">-</div>
														<div class="meal-num" style="float: left;margin: 6px 0;">
															<input type="number" name="meal_num_${meal.placeId}" id="meal_num_${meal.placeId}" min="0" style="border: none;width: 50px;height:25.56px;text-align: center;" value="${bookingRecordModel.quantity }" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">
														</div>
														<div class="num meal-plus" style="float: left;margin: 6px 0;">+</div>
														<div style="clear:both;"></div>
													</div>
													<div class="col-sm-2 pad-no" >
														￥<input type="number" class="price  form-control" value="${bookingRecordModel.price }" min="0" name="mealPrice_${meal.placeId}" id="mealPrice${meal.placeId}" onkeyup="calculateMealSchedulePrice();" onchange="calculateMealSchedulePrice();">/围
													</div>
													<div class="col-sm-1 pad-no" >
														<img class="meal-schedule-del btn-icon" src="${ctx}/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;margin:0.4rem 0;cursor: pointer;">
													</div>
												</div>
											</c:forEach>
											<div style="position: absolute;bottom: 14px;right: 25%;">
												  <img qx="order:update" class="meal-add-schedule btn-icon" src="${ctx}/static/resource/css/images/add.png" title="添加档期" mealId="${meal.placeId}">
											</div>
										</div>
										<input type="hidden" id="mealOriginalPrice_${meal.placeId}" name="mealOriginalPrice_${meal.placeId}" value="${originalPrice}">
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
			                            <div class="col-md-3" style="text-align: right;">小计：<span id="sumMealschedulePrice"><fmt:formatNumber type="currency" value="${mealPrice }"/></span></div>
			                        </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-6"></div>
			                            <div id="mealServiceFeeRate_dtl" class="col-md-6" style="text-align: right;">
			                            	用餐加收服务费（<span id="mealServiceFeeRatetxt"><fmt:formatNumber type="number" value="${empty order.mealServiceFeeRate?0:order.mealServiceFeeRate }"  maxFractionDigits="0"/></span>%）
			                            	 ：<span id="mealServiceFeedtl"><fmt:formatNumber type="currency" value="${mealPrice*order.mealServiceFeeRate/100 }" /></span>
		                            	</div>
		                            	<div id="mealServiceFeeRate_edit" class="col-md-6" style="text-align: right;display: none;">
			                            	用餐加收服务费:<input type="number" id="mealServiceFeeRate" name="mealServiceFeeRate" min="0" max="100" class="form-control"
			                            	 style="width: 80px;display: inline;"  value="${empty order.mealServiceFeeRate?0:order.mealServiceFeeRate }" onkeyup="calculateMealSchedulePrice()" onchange="calculateMealSchedulePrice()">%
			                            	 ：<span id="mealServiceFeedit"><fmt:formatNumber type="currency" value="${mealPrice*order.mealServiceFeeRate/100 }" /></span>
		                            	</div>
			                        </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"> 
			                            	<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
											or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
											or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
											</c:if>
												 <span qx="order:update" class="btn add meal-add" style="">添加用餐</span>
			                             </div>
			                  		    <div class="col-md-3" style="text-align: right;margin: 0.3rem 0;">合计：<span  id="allMealschedulePrice" style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice * (1 + order.mealServiceFeeRate/100)}" /></span></div>
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
											src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
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
						    </script>
						</div>
						
						<input type="hidden" id="mealIds" name="mealIds" value="${mealIds}">
						<input type="hidden" id="mealAmount" name="mealAmount" value="${mealPrice}">
						<input type="hidden" id="mealAllAmount" name="mealAllAmount" value="${mealPrice}">
						
						<script type="text/javascript">
							$(function(){

								$(".detail_content").delegate('.meal-minus','click',function(){	
									$this = $(this);
									var num = $this.next().find('input').val()*1;
									if(num*1>0){
										var cnum = num-1;
										$this.next().find('input').val(cnum);
									}else{
										
									}
									calculateMealSchedulePrice();
								});
								
								$(".detail_content").delegate('.meal-plus','click',function(){	
									$this = $(this);
									var num = $this.prev().find('input').val()*1;
									var cnum = num+1;
									$this.prev().find('input').val(cnum);
									calculateMealSchedulePrice();
									
								});
								
								$(".detail_content").delegate('.meal-add','click',function(){
									var mealIds = $("#mealIds").val();
									$.get('${ctx}/weixin/hotelplace/meal/list',{hotelId:'${order.hotelId}'},function(res){
										if(res.statusCode==200){
											var arr = [];
											for(var i=0;i<res.object.length;i++){
												var id='#'+res.object[i].id;
												if(mealIds.indexOf(id)<0){
													arr.push('<div class="btn btn-query btn-plain bg-none-query col-justify-2" style="" mealId="'+res.object[i].id+'" mealName="'+res.object[i].name+'">'+res.object[i].name+'</div>');
												}
											}
											$("#meals_list").html(arr.join(''));
											show();
											$("#meals_div").show();
										}else{
											
										}
									},'json')
								});
								
								$(".detail_content").delegate('.meal-add-schedule','click',function(){	//
									var $this = $(this);
									var placeId = $this.attr("mealId");
									var price = $("#mealOriginalPrice_"+placeId).val();
									var schdl_item = $('#meal_schedule_item').text().split('{{id}}').join(placeId);
									schdl_item = schdl_item.replace("{{price}}",price);
									var $meal_schedule=$(schdl_item);
									$meal_schedule.find(".meal-schedule-del").click(function(){
										$meal_schedule.remove();
										calculateRoomSchedulePrice();
									});
									
									$this.parent().before($meal_schedule);
								});
								
								$("#meals_div").delegate('[mealId]','click',function(){	//住房列表点击事件
									var $this = $(this);
									var mealId = $this.attr('mealId');
									$.get('${ctx}/weixin/hotelplace/getone',{id:mealId,type:'MEAL'},function(res){
										if(res.statusCode==200){
											var shtml =	template('meal_item', res.object);
											var $shl = 	$(shtml);
											$shl.find('.meal-del').click(function(){
												var mealIds = $("#mealIds").val();
												var mlId = $this.attr('mealId');
												$("#mealIds").val(mealIds.replace("#"+mlId,''));
												$shl.remove();
												calculateMealSchedulePrice();
												var num = $(".meal").find(".edit").length;{}
												if(num>0){
													$("#mealServiceFeeRate_dtl").hide();
													$("#mealServiceFeeRate_edit").show();
												}else{
													$("#mealServiceFeeRate_dtl").show();
													$("#mealServiceFeeRate_edit").hide();
												}
											});
											
											$shl.find(".meal-schedule-del").click(function(){
												$(this).parent().parent().remove();
												calculateMealSchedulePrice();
											});
											
											$shl.find(".meal_detail_edit").click(function(){
												$this = $(this);
												var placeId = $this.attr("mealId");
												
												if($this.hasClass('edit')){
													
													var ditem ='<div class="row pad-ud-5 mgn-ud-5 bottom-line"><div class="col-sm-3 pad-no" style="color: #999999;"><span>{mealType}</span><span>-</span><span>×{mealNum}个</span></div> <div class="col-sm-3 pad-no" style="color: #019FEA;"> <span>用餐时间：{mealDate}</span> <span style="">{mealTime}</span> </div> <div class="col-sm-3 pad-no" style="color: #019FEA;text-align: right;"> <span style="">￥{mealPrice}</span> </div> <div class="col-sm-3 pad-no" style="text-align : right;"> <span>预定费用￥{allPrice}</span> </div> </div>';
													var items = [];
													$("#mealEditForm"+placeId).find(".row").each(function(){
														var $this = $(this);
														var mealType = $this.find('select[name="mealType_'+placeId+'"]').val();
														mealType = mealType==='01'?'围餐':'自助餐';
														var mealTime = $this.find('select[name="mealscheduleTime_'+placeId+'"]').val();
														
														var mealNum = $this.find('input[name="meal_num_'+placeId+'"]').val();
														var mealDate = $this.find('input[name="mealscheduleDate_'+placeId+'"]').val();
														var mealPrice = $this.find('input[name="mealPrice_'+placeId+'"]').val();
														
														var dtm = ditem;
														dtm = dtm.replace('{mealType}',mealType).replace('{mealTime}',mealTime).replace('{mealPrice}',common.formatCurrency(mealPrice*1))
														.replace('{allPrice}',common.formatCurrency(mealPrice*1*mealNum)).replace('{mealNum}',mealNum).replace('{mealDate}',mealDate);
														items.push(dtm);
													});
													
													$("#mealViewForm"+placeId).empty();
													$("#mealViewForm"+placeId).html(items.join(''));
													
													
													$this.removeClass('edit');
													$("#meal_detail_edit_to_"+placeId).show();
													$("#meal_detail_edit_cancel_"+placeId).hide();
													$("#mealViewForm"+placeId).show();
													$("#mealEditForm"+placeId).hide();
												}else{
													$this.addClass('edit');
													$("#meal_detail_edit_to_"+placeId).hide();
													$("#meal_detail_edit_cancel_"+placeId).show();
													$("#mealViewForm"+placeId).hide();
													$("#mealEditForm"+placeId).show();
												}
												
												var num = $(".meal").find(".edit").length;{}
												if(num>0){
													$("#mealServiceFeeRate_dtl").hide();
													$("#mealServiceFeeRate_edit").show();
												}else{
													$("#mealServiceFeeRate_dtl").show();
													$("#mealServiceFeeRate_edit").hide();
												}
											});
											
											$(".meal-items").append($shl);
											var mealIds = $("#mealIds").val();
											$("#mealIds").val(mealIds+"#"+mealId);
											$("#meals_div").hide();
											
											$("#mealServiceFeeRate_dtl").hide();
											$("#mealServiceFeeRate_edit").show();
											
											hide();
										}
									},'json')
									
								});
								
								$(".meal_detail_edit").click(function(){
									$this = $(this);
									var placeId = $this.attr("mealId");
									
									
									if($this.hasClass('edit')){
										
										var ditem ='<div class="row pad-ud-5 mgn-ud-5 bottom-line"><div class="col-sm-3 pad-no" style="color: #999999;"><span>{mealType}</span><span>-</span><span>×{mealNum}个</span></div> <div class="col-sm-3 pad-no" style="color: #019FEA;"> <span>用餐时间：{mealDate}</span> <span style="">{mealTime}</span> </div> <div class="col-sm-3 pad-no" style="color: #019FEA;text-align: right;"> <span style="">￥{mealPrice}</span> </div> <div class="col-sm-3 pad-no" style="text-align : right;"> <span>预定费用￥{allPrice}</span> </div> </div>';
										var items = [];
										$("#mealEditForm"+placeId).find(".row").each(function(){
											var $this = $(this);
											var mealType = $this.find('select[name="mealType_'+placeId+'"]').val();
											mealType = mealType==='01'?'围餐':'自助餐';
											var mealTime = $this.find('select[name="mealscheduleTime_'+placeId+'"]').val();
											//mealTime = mealTime===''?'':'';
											
											var mealNum = $this.find('input[name="meal_num_'+placeId+'"]').val();
											var mealDate = $this.find('input[name="mealscheduleDate_'+placeId+'"]').val();
											var mealPrice = $this.find('input[name="mealPrice_'+placeId+'"]').val();
											
											var dtm = ditem;
											dtm = dtm.replace('{mealType}',mealType).replace('{mealTime}',mealTime).replace('{mealPrice}',common.formatCurrency(mealPrice*1))
											.replace('{allPrice}',common.formatCurrency(mealPrice*1*mealNum)).replace('{mealNum}',mealNum).replace('{mealDate}',mealDate);
											items.push(dtm);
										});
										
										$("#mealViewForm"+placeId).empty();
										$("#mealViewForm"+placeId).html(items.join(''));
										
										
										$this.removeClass('edit');
										$("#meal_detail_edit_to_"+placeId).show();
										$("#meal_detail_edit_cancel_"+placeId).hide();
										$("#mealViewForm"+placeId).show();
										$("#mealEditForm"+placeId).hide();
									}else{
										$this.addClass('edit');
										$("#meal_detail_edit_to_"+placeId).hide();
										$("#meal_detail_edit_cancel_"+placeId).show();
										$("#mealViewForm"+placeId).hide();
										$("#mealEditForm"+placeId).show();
									}
									
									var num = $(".meal").find(".edit").length;{}
									if(num>0){
										$("#mealServiceFeeRate_dtl").hide();
										$("#mealServiceFeeRate_edit").show();
									}else{
										$("#mealServiceFeeRate_dtl").show();
										$("#mealServiceFeeRate_edit").hide();
									}
								});
								
								$('.meal-del').click(function(){
									var mealIds = $("#mealIds").val();
									var mealId = $(this).attr('mealId');
									$("#mealIds").val(mealIds.replace("#"+mealId).replace(',,',','));
									$(this).parent().parent().parent().remove();
									calculateMealSchedulePrice();
									
									var num = $(".meal").find(".edit").length;{}
									if(num>0){
										$("#mealServiceFeeRate_dtl").hide();
										$("#mealServiceFeeRate_edit").show();
									}else{
										$("#mealServiceFeeRate_dtl").show();
										$("#mealServiceFeeRate_edit").hide();
									}
								});
								
								$(".meal-schedule-del").click(function(){
									$(this).parent().parent().remove();
									calculateMealSchedulePrice();
								});
								
								
							})
						</script>
					</div>
					<!--其他费用  -->
					<div>
						<div class="row">
							<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">其他费用</span></div>
						</div>
						<!-- 其他费用 详情 -->
						<div class="row other">
							<div class="col-sm-12 other-item" style="padding: 10px 30px 5px;">
								<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
									<div class="row pad-ud-5 mgn-ud-5 bottom-line">
										<div class="col-sm-2 pad-no" style="color: #019FEA;">
											<span>${odtl.placeName }</span>
										</div>
										<div class="col-sm-3 pad-no" style="color: #999999;">
											<span>单价：<fmt:formatNumber type="currency" value="${odtl.amount/odtl.quantity }" /></span>
											<span>-</span>
											<span>数量：<fmt:formatNumber type="number" value="${odtl.quantity }" /></span>
										</div>
										<div class="col-sm-3 pad-no" style="text-align: right;">
											<span>费用：<fmt:formatNumber type="currency" value="${odtl.amount }" /></span>
										</div>
										<div class="col-sm-4 pad-no" style="text-align: right;">
											<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))}">
												<img qx="order:update" class="other-edit btn-icon" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png" title="编辑该项">
												<img  class="other-del btn-icon" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="display: inline-block;" title="删除该项">
											</c:if>
										</div>
									</div>
									<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;display: none;">
										<div class="col-sm-3 pad-no">
											其他小项 :<input type="text" class="form-control" id="" name="otherdetail"  placeholder="消费明细" style="width: 200px;display: inline-block;" value="${odtl.placeName }">
										</div>
										<div class="col-sm-2 pad-no">
											单价： <input type="number" id="" name="oprice" class="form-control oprice" placeholder="单价" style="width: 100px;display: inline-block;" value="${odtl.amount/odtl.quantity }">元
										</div>
										<div class="col-sm-2 pad-no">
											数量： <input type="number" id="" name="oquantity" class="form-control oquantity" placeholder="数量" style="width: 100px;display: inline-block;" value="${odtl.quantity }">
										</div>
										<div class="col-sm-3 pad-no">
											总计： <input type="number" id="" name="otherprice" class="form-control otherprice" placeholder="总计" style="width: 100px;display: inline-block;" value="${odtl.amount }" readonly="readonly">
										</div>
										<div class="col-sm-2 pad-no" style="text-align: right;">
											<c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))}">
												<img  class="other-cancel" src="${ctx }/static/resource/css/images/cfm.png" style="width:20px;height:20px;display: inline-block;cursor: pointer;" title="取消编辑">
												<img  class="other-del" src="${ctx }/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;display: inline-block;cursor: pointer;" title="删除该项">
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" style="padding: 0 30px;">
								<div class="row bottom-line">
		                            <div class="col-md-9">
			                            <c:if test="${(aUs.getCurrentUserId() eq order.companySaleId && order.orderType eq 'OFFLINE') 
											or (aUs.getCurrentUserId() eq order.hotelSaleId && (order.state eq 02 or order.state eq 04))
											or (groupMap.ishotelsalesdirector or groupMap.iscompanysalesdirector)}">
										</c:if>
											<div style="padding: 0.2rem 0;">
												 <div style="width: 100%;padding:0.2rem 0;">
													 <span class="btn add other-add" style="">添加</span>
												 </div>
											</div>
		            		          </div>
		                            <div class="col-md-3" style="text-align: right;margin: 0.8rem 0;">合计：<span  id="allOtherPrice" style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}"/></span></div>
		                        </div>
							</div>
							<script type="text/javascript">
								$(function(){
									$(".other-edit").click(function(){
										$this = $(this);
										$this.parent().parent().hide();
										$this.parent().parent().next().show();
										$this.parent().addClass('edit');
									});
									
									$(".other-cancel").click(function(){
										$this = $(this);
										$this.parent().parent().hide();
										$this.parent().parent().prev().show();
										$this.parent().removeClass('edit');
									});
									
									$(".other-del").click(function(){
										$this = $(this);
										$this.parent().parent().parent().remove();
										//$this.parent().removeClass('edit');
										calculateOtherPrice();
									});
									
									$('.oprice').keyup(function(){	
										var $otherItem = $(this).parent();
										var oprice = $(this).val()*1;
										var oquantity = $otherItem.find('.oquantity').val()*1;
										$otherItem.find('.otherprice').val(oprice*oquantity);
										calculateOtherPrice();
									});
									$('.oquantity').keyup(function(){	
										var $otherItem = $(this).parent();
										var oquantity =$(this).val()*1;
										var oprice = $otherItem.find('.oprice').val()*1;
										$otherItem.find('.otherprice').val(oprice*oquantity);
										calculateOtherPrice();
									});
									
									$('.other-add').click(function(){
										var oitem = $("#other_fee_item").text();
										var $otherItem = $(oitem);
										$otherItem.delegate('.other-del','click',function(){	
											calculateOtherPrice();
											$otherItem.remove();
										});
										$otherItem.delegate('.oprice','keyup',function(){	
											var oprice = $(this).val()*1;
											var oquantity = $otherItem.find('.oquantity').val()*1;
											$otherItem.find('.otherprice').val(oprice*oquantity);
											calculateOtherPrice();
										});
										$otherItem.delegate('.oquantity','keyup',function(){	
											var oquantity =$(this).val()*1;
											var oprice = $otherItem.find('.oprice').val()*1;
											$otherItem.find('.otherprice').val(oprice*oquantity);
											calculateOtherPrice();
										});
										$(".other-item").append($otherItem);
									});
								});
								
								function calculateOtherPrice(){
									 var allOtherPrice =0.00;
									 var sumOtherPrice =0.00;
									 $('.otherprice').each(function(){
										 if($(this).val()){
											 sumOtherPrice+=$(this).val()*1;
										 }
									 });
									 allOtherPrice = sumOtherPrice;
									 //$("#sumOtherPrice").text("￥"+common.formatCurrency(sumOtherPrice));
									 $("#allOtherPrice").text("￥"+common.formatCurrency(allOtherPrice));
									 $("#other_amount_dv").text("￥"+common.formatCurrency(allOtherPrice));
									 sumALLprice();
								}
								
							</script>
						</div>
					</div>
					
					<!-- 订单备注 -->
					<div style="border-top:1px solid #cccccc;padding: 0 15px;">
						<div style="margin:0.8rem 0;">
							<div style="font-weight:bold;font-size: 0.85rem;">
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;float: left;"></div>
								<div class="remark_opt" style="display: none;float: left;margin: 10px 10px;">
									<img qx="order:update" onclick="memoShow('order_memo')" title="修改备注" id="order_memo" 
										src="${ctx}/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon">
						 			<img qx="order:update" onclick="memoCancel('order_memo_cancel')" title="取消修改备注" id="order_memo_cancel" 
										src="/hui/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" style="display: none;">
								</div>
								<div style="clear: both;"></div>
							</div>
						</div>
						<div class="Remark" style="">
							<div id="memoEdit" style="margin:0.8rem 0;">
								<script type="text/plain" id="memo"  name="memo" style="height: 400px;">${order.memo}</script>
							</div>
							<div id="memoDetail" style="margin:1rem 0;padding:0 1rem;">
								${order.memo}
							</div>
						<script type="text/javascript">
							function memoShow(id){
								$("#"+id).hide();
								$("#order_memo_cancel").show();
								$("#memoEdit").show();
								$("#memoDetail").hide();
							}
							function memoCancel(id){
								$("#"+id).hide();
								$("#order_memo").show();
								$("#memoDetail").show();
								$("#memoEdit").hide();
							}
							var memo_editor = new UE.ui.Editor({
					            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
					            toolbars:[],
					            //focus时自动清空初始化时的内容
					            autoClearinitialContent:true,
					            //关闭字数统计
					            wordCount:false,
					            //关闭elementPath
					            elementPathEnabled:false,
					            //默认的编辑区域高度
					            initialFrameHeight:150
					        });
							memo_editor.render("memo");
					    </script>
					</div>
				</div>
				</form>
				
				<!-- 价格统计 -->
				<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0; ">
					<c:set var="placeSumPrice" value="${bookPriceCount * (1 + bookServicePercent/100)}"></c:set>
					<c:set var="mealSumPrice" value="${mealPrice * (1 + order.mealServiceFeeRate/100)}"></c:set>
					<div  class="amount-item">场地费用：
						<span id="hall_amount_dv">
							<c:if test="${placeSumPrice>=10000 }">
								<fmt:formatNumber type="currency" value="${empty placeSumPrice?0:placeSumPrice/10000  }" />万元
							</c:if>
							<c:if test="${placeSumPrice<10000 }">
								<fmt:formatNumber type="currency" value="${empty placeSumPrice?0:placeSumPrice  }" />
							</c:if>
						</span>
					</div>
					
					<div  class="amount-item">住房费用：
						<span id="room_amount_dv">
							<c:if test="${roomPrice>=10000 }">
								<fmt:formatNumber type="currency" value="${empty roomPrice?0:roomPrice/10000  }" />万元
							</c:if>
							<c:if test="${roomPrice<10000 }">
								<fmt:formatNumber type="currency" value="${empty roomPrice?0:roomPrice  }" />
							</c:if>
						</span>
					</div>
					
					<div  class="amount-item">用餐费用：
						<span id="meal_amount_dv">
							<c:if test="${mealSumPrice>=10000 }">
								<fmt:formatNumber type="currency" value="${empty mealSumPrice?0:mealSumPrice/10000  }" />万元
							</c:if>
							<c:if test="${mealSumPrice<10000 }">
								<fmt:formatNumber type="currency" value="${empty mealSumPrice?0:mealSumPrice  }" />
							</c:if>
						</span>
					</div>
					
					<div  class="amount-item">其他费用：
						<span id="other_amount_dv">
							<c:if test="${order.otherAmount>=10000 }">
								<fmt:formatNumber type="currency" value="${order.otherAmount/10000 }" />万元
							</c:if>
							<c:if test="${order.otherAmount<10000 }">
								<fmt:formatNumber type="currency" value="${order.otherAmount }" />
							</c:if>
						</span>
					</div>
					
					<div class="amount-item" style="color:#cb2b29;font-weight: bold;">总计：
						<span id="amount_dv">
							<c:if test="${order.amount>=10000 }">
								<fmt:formatNumber type="currency" value="${order.amount/10000 }" />万元
							</c:if>
							<c:if test="${order.amount<10000 }">
								<fmt:formatNumber type="currency" value="${order.amount }" />
							</c:if>
						</span>
					</div>
					<div class="amount-item">已付定金：
						<input type="hidden" id="prepaid" value="${order.prepaid}">
						<span>
							<fmt:formatNumber type="currency" value="${order.prepaid}" />
						</span>
					</div>
					<div  class="amount-item">剩余尾款：
						<span id="finalPayment">
							<fmt:formatNumber type="currency" value="${order.finalPayment}" />
						</span>
					</div>
					<c:if test="${order.settlementStatus >='04'}">
						<div  class="amount-item">结算金额：
							<span id="finalPayment">
								<fmt:formatNumber type="currency" value="${order.settlementAmount}" />
							</span>
						</div>
					</c:if>
				</div>
			</div>
			
			
			<c:if test="${(groupMap.ishotelsales or groupMap.ishotelsalesdirector ) and order.state < '10'  and (order.state=='01' or order.state=='02' or order.state=='04')}">
				<div id="order_save_div" class="display-flex" style="color: #ffffff;width:100%;text-align: center;padding: 3%;">
					<div qx="order:update" id="btn_submit" class="btn btn-lg bg-type-01" style="width:40%;margin:0 auto;border-radius:3px;">确认提交</div>
					<input type="hidden" id="hotelId" name="hotelId" value="${order.hotelId}">
				</div>
			</c:if>
			<c:if test="${((groupMap.iscompanysales and guserId eq order.companySaleId) or groupMap.iscompanysalesdirector) and order.orderType == 'OFFLINE' and (order.state=='01' or order.state=='02' or order.state=='04')}">
				<div id="order_save_div" class="display-flex" style="color: #ffffff;width:100%;text-align: center;padding: 3%;">
					<div qx="order:update" id="btn_submit" class="btn btn-lg bg-type-01" style="width:40%;margin:0 auto;border-radius:3px;">确认提交</div>
					<input type="hidden" id="hotelId" name="hotelId" value="${order.hotelId}">
				</div>
			</c:if>
	
	
	<!-- 遮罩层 -->
	<div id="mask_full_screen" class="mask-full-screen" style=""></div>
	
	<!-- 状态更改 -->
	<div id="order_state_chg_div" class="div-tips-dialog" style="top:40%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
			<input id="tostate" name="tostate" type="hidden" value="">
 		</div>
		<div id="state_list" >
			<!-- <div class="state-item" style="cursor: pointer;" data="1">处理中</div> -->
			<div class="state-item" style="cursor: pointer;" data="2">已交订金</div>
			<div class="state-item" style="cursor: pointer;" data="3">已签约</div>
			<div class="state-item" style="cursor: pointer;" data="4">已完成</div>
			<div class="state-item" style="cursor: pointer;" data="5">已结算</div>
			<div class="state-item" style="cursor: pointer;" data="0">客户取消</div>
		</div>
		
		<div id="canceldv" style="padding:0 2%;display: none;" >
			<c:if test="${order.settlementStatus>='02' }">
				<div style="width: 100%;">
					<div   style="padding: 5px 0;display: inline-block;width:48%;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
					<div   style="padding: 5px 0;display: inline-block;width:48%;">已付定金：<fmt:formatNumber type="currency" value="${order.prepaid}" /></div>
				</div>
				<div style="width: 100%;">
					<div style="padding:5px 0" >退款金额：<input type="number" id="refundAmount" value="" max="${order.prepaid}" min="0" class="form-control" style="width: 50%;display: inline-block;" placeholder="请输入退款金额" ></div>
				</div>
			</c:if>
			<div>
				<textarea id="cancelReason" rows="5" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入取消原因"></textarea>
			</div>
		</div>
		<div id="payedv" style="padding:0 2%;display: none;" >
			<div style="width: 100%;">
				<div   style="padding: 5px 0;display: inline-block;width:48%;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
				<div   style="padding: 5px 0;display: inline-block;width:48%;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></div>
			</div>
			<div style="width: 100%;">
				<div style="padding:5px 0" >结算金额：<input type="number" id="payAmount" value="" min="0" class="form-control" style="width: 50%;display: inline-block;" placeholder="请输入退款金额" ></div>
			</div>
		</div>
		<div id="prepaydv" style="padding:5px 2%;display: none;" >
			<input type="number" class="form-control" id="prepay" value="" min="0" style="width: 98%;" placeholder="请输入订金" >
		</div>
		<div class="display-flex" style="padding: 1rem 0;">
			<div id="btn-order-state-cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" > 取消</div>
			<div  qx="order:update" id="btn-order-state-sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;" > 确定</div>
		</div>
	</div>	
	
	<!-- 线下订单，会掌柜人员录入 -->
	<c:if test="${order.orderType eq 'OFFLINE' and order.offlineState eq '0'}">
		<div id="offline_check_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
			<div qx="order:update" id="btn_offline_check_nopass" class="btn btn-lg bg-none-01" style="width:48%;margin:0 auto;border-radius:3px;border: 1px solid;">审核不通过</div>
			<div qx="order:update" id="btn_offline_check_pass" class="btn btn-lg bg-type-01" style="width:48%;margin:0 auto;border-radius:3px;">审核通过</div>
		</div>
		<div id="offline_check_no_div" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
				<div style="color: #000000;">不通过原因</div>
				<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
	 		</div>
			<div style="padding:0 2%;">
				<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
			</div>
			<div class="display-flex" style="padding: 1rem 0;">
				<div id="btn_offline_check_no_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" >再考虑</div>
				<div qx="order:update" id="btn_offline_check_no_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;" > 确定</div>
			</div>
		</div>	
	</c:if>
	<!-- 其他操作 -->
	<div>
		<div id="halls_div" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;height:450px;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;">
	 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择场地</div>
	 			 <div id="btn_halls_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
	 		</div>
			<div id="halls_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
				<div style="clear: both;"></div>
			</div>
		</div>	
		
		
		<div id="rooms_div" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;height:450px;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;">
	 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择住房</div>
	 			<div id="btn_rooms_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
	 		</div>
			<div id="rooms_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
				<div style="clear: both;"></div>
			</div>
		</div>
		
		
		<div id="meals_div" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;height:450px;text-align:left;display:none;">
			<div  style="text-align:center;line-height: 1.5rem;position: relative;">
	 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">选择用餐</div>
	 			<div id="btn_meals_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div> 
	 		</div>
			<div id="meals_list" style="padding: 0.2rem 0;border-top: 1px solid #999999;">
				<div style="clear: both;"></div>
			</div>
		</div>	
	</div>
<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>

<script>
function operateOrderTrajectory(){
	var operateOrder = window.sessionStorage.getItem("operateOrder${aUs.getCurrentUserId()}");
	var orderNo = '${order.orderNo}';
	
	if(operateOrder){
		if(operateOrder.indexOf(orderNo)<0){
			operateOrder +=",${order.orderNo}";
		}
	}else{
		operateOrder = "${order.orderNo}";
	}
	window.sessionStorage.setItem("operateOrder${aUs.getCurrentUserId()}",operateOrder);
}
function remarkDisplay(){
	$(".Remark").hide();
	$("#meetingRemarkEdit").hide();
	$("#houseRemarkEdit").hide();
	$("#dinnerRemarkEdit").hide();
	$("#memoEdit").hide();
	
}
$(function(){
	remarkDisplay();
	
	operateOrderTrajectory();
	dict.init();
	common.pms.init();
	<c:if test="${iscomission }">
		$('#btn_commission').click(function(){
			show();
			var orderId = '${order.id}';
			$.post('${ctx}/weixin/order/comission/create',{orderId:orderId},function(res){
				if(res.statusCode==='200'){
					swal(res.message,'success');
					$('#commission_div').hide();
				}else{
					swal(res.message,'error');
				}
				hide();
			},'json');
		});
	</c:if>
	
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
	
	 
	$("#order_state_div").click(function(){
		$("#order_state_chg_div").show();
		show();
		$("#prepay").val('');
		$("#refundAmount").val(0);
		$("#payAmount").val(0);
		$("#cancelReason").val('');
		$('.state-item').removeClass("state-item-check");
	});
	
	$("#btn-order-state-cansel").click(function(){
		$("#order_state_chg_div").hide();
		hide();
		$("#prepay").val('');
		$("#refundAmount").val(0);
		$("#payAmount").val(0);
		$("#cancelReason").val('');
		
		$("#payedv").hide();
		$("#canceldv").hide();
		$("#prepaydv").hide();
		$('.state-item').removeClass("state-item-check");
	});
	
	$("#btn-order-state-sure").click(function(){
		var tostate = $("#tostate").val();
		var cancelReason = $("#cancelReason").val();
		var stlstate = '${order.settlementStatus}';
		if(tostate==='0'&&cancelReason===''){
			swal('请输入取消原因！','error');
			return;
		}
		var ramount =$("#refundAmount").val();
		if(tostate==='0'&&stlstate>='02'&&(ramount===''||ramount*1<0)){
			swal('请输入退款金额，退款金额不能小于0！','error');
			return;
		}
		var pamount =$("#payAmount").val();
		if(tostate==='5'&&(pamount===''||pamount*1<0)){
			swal('请输入结算金额，结算金额不能小于0！','error');
			return;
		}
		var prepay = $("#prepay").val();
		if(tostate==='2'&&(prepay===''||prepay*1<=0)){
			swal('请输入订金，且订金不能小于0！','error');
			return;
		}
		if(tostate){
			$.post('${ctx}/weixin/order/state/${order.id}',{tostate:tostate,cancelReason:cancelReason,prepay:prepay,ramount:ramount,pamount:pamount},function(res){
				if(res.statusCode==='200'){
					$("#order_state_chg_div").hide();
					swal(res.message,'success');
					setTimeout(function(){
						loadContent(this,'${ctx}/weixin/order/detail/${order.id}','RD');
					},1500);
				}else{
					swal(res.message,'error');
				}
			},'json');
		}else{
			swal('请先选择要变更的状态！','error');
		}
	});
	
	
	$("#state_list").delegate('.state-item','click',function(){	
		$this = $(this);
		$("#tostate").val($this.attr('data'));
		$('.state-item').removeClass("state-item-check");
		$this.addClass('state-item-check');
		if($this.attr('data')==='0'){
			$("#canceldv").show();
			$("#prepaydv").hide();
			$("#payedv").hide();
			
			$("#prepay").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
			$("#cancelReason").val('');
		}else if($this.attr('data')==='2'){
			$("#canceldv").hide();
			$("#payedv").hide();
			$("#prepaydv").show();
			
			$("#prepay").val('');
			$("#cancelReason").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
		}else if($this.attr('data')==='5'){
			$("#canceldv").hide();
			$("#prepaydv").hide();
			$("#payedv").show();
			
			$("#prepay").val('');
			$("#cancelReason").val('');
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
		}else{
			$("#canceldv").hide();
			$("#prepaydv").hide();
			$("#payedv").hide();
			
			$("#refundAmount").val(0);
			$("#payAmount").val(0);
			$("#prepay").val('');
			$("#cancelReason").val('');
		}
	});
	
	$("#btn_offline_check_nopass").click(function(){
		$("#reason").val('');
		$("#offline_check_no_div").show();
		show();
	});
	
	$("#btn_offline_check_pass").click(function(){
		show();
		$.post('${ctx}/weixin/order/offline/check/pass',{orderId:'${order.id}'},function(res){
			if(res.statusCode==='200'){
				swal(res.message,'success');
				setTimeout(function(){
					loadContent(this,'${ctx}/weixin/order/detail/${order.id}','RD');
				},1500);
			}else{
				swal(res.message,'error');
			}
			hide();
		},'json');
	});
	
	$("#btn_offline_check_no_cansel").click(function(){
		$("#offline_check_no_div").hide();
		hide();
		$("#reason").val('');
		
	});
	
	$("#offline_check_no_ic_close").click(function(){
		$("#offline_check_no_div").hide();
		hide();	
		$("#reason").val('');
		
	}); 
	
	$("#btn_offline_check_no_sure").click(function(){
		$("#offline_check_no_div").hide();
		var reason = $("#reason").val();
		
		$.post('${ctx}/weixin/order/offline/check/nopass',{orderId:'${order.id}',reason:reason},function(res){
			if(res.statusCode==='200'){
				swal(res.message,'success');
				setTimeout(function(){
					loadContent(this,'${ctx}/weixin/order/detail/${order.id}','RD');
				},1500);
				hide();	
			}else{
				$("#offline_check_no_div").show();
				swal(res.message,'error');
			}
		},'json');
	});
	
	$("#btn_halls_close").click(function(){
		$("#halls_div").hide();
		hide();
	});
	
	$("#btn_rooms_close").click(function(){
		$("#rooms_div").hide();
		hide();
	});
	
	$("#btn_meals_close").click(function(){
		$("#meals_div").hide();
		hide();
	});
	
	
	
	
	
	
	
	var $form = $("#orderForm");
	$("#btn_submit").click(function(){
	  /*   if($form.valid && !$form.valid()){
			return;
		} */
		var data = $form.serialize();
		show();
		$.post($form.attr('action'),data,function(res){
		 	if(res.statusCode==='200'){
				swal(res.message,'success');
				setTimeout(function(){
					loadContent(this,'${ctx}/weixin/order/detail/${order.id}','RD');
				},2000);
			}else{
				swal(res.message,'error');
			}
			hide();
		},'json');
		
	});
	
	
	$("#btn_company_follow_pass").click(function(){
		show();
		$("#company_follow_feedback_div").show();
		$("#companyFollowMemo").val('');
	});
	
	$("#btn_company_follow_cansel").click(function(){
		$("#company_follow_feedback_div").hide();
		hide();
		$("#companyFollowMemo").val('');
		
	});
	
	$("#company_follow_ic_close").click(function(){
		$("#company_follow_feedback_div").hide();
		hide();	
		$("#companyFollowMemo").val('');
		
	}); 
	
	$("#btn_company_follow_sure").click(function(){
		
		var companyFollowMemo = $("#companyFollowMemo").val();
		if(companyFollowMemo===''){
			swal('请输入反馈信息！','success');
			return;
		}
		$("#company_follow_feedback_div").hide();
		$.post('${ctx}/weixin/order/company/follow',{orderId:'${order.id}',companyFollowMemo:companyFollowMemo},function(res){
			toastFn(res.message);
			if(res.statusCode==='200'){
				hide();	
				swal(res.message,'success');
				setTimeout(function(){
					loadContent(this,'${ctx}/weixin/order/detail/${order.id}','RD');
				},1500);
			}else{
				swal(res.message,'error');
				$("#company_follow_feedback_div").show();
			}
			
		},'json');
	});
	
	$(".backto").click(function(){
		//loadContent(this,'${ctx}/weixin/order/detail/${order.id}','QUICK');
		loadContent(this,'${ctx}/'+$(".item-active").find('a').attr('url'),'QUICK');
	});
	
});

function mealScheduleDate(self){
	 var $this = $(self);
	 calculateMealSchedulePrice();
}

function calculateMealSchedulePrice(){
	 var sumMealSchedulePrice =0.00;
	 var allMealSchedulePrice =0.00;
	 $('.meal .price').each(function(){
		 if($(this).val()){
			 var arr = $(this).attr('id').split('_');
			 var placeId = arr[1];
			 var idx = arr[2];
			 var num = $(this).parent().prev().find('input[type="number"]').val()*1;
			 sumMealSchedulePrice+=$(this).val()*1*num;
		 }
	 });
	
	 $("#mealAmount").val(sumMealSchedulePrice);
	
	 $("#sumMealschedulePrice").text("￥"+common.formatCurrency(sumMealSchedulePrice));
	 
	 var mealServiceFeeRate = $("#mealServiceFeeRate").val()*1;
	 var mealServiceFee = sumMealSchedulePrice*mealServiceFeeRate/100;
	 $("#mealServiceFeeRatetxt").text(mealServiceFeeRate);
	 $("#mealServiceFeedit").text("￥"+common.formatCurrency(mealServiceFee));
	 $("#mealServiceFeedtl").text("￥"+common.formatCurrency(mealServiceFee));
	 allMealSchedulePrice = sumMealSchedulePrice+mealServiceFee;
	 
	 $("#mealAllAmount").val(allMealSchedulePrice);
	 $("#allMealschedulePrice").text("￥"+common.formatCurrency(allMealSchedulePrice));
	 
	 sumALLprice();
}
function sumALLprice(){
	  
	var sumRoomSchedulePrice = $("#roomAmount").val()*1;
	var allRoomSchedulePrice = $("#roomAllAmount").val()*1;
	
	var sumHallSchedulePrice = $("#hallAmount").val()*1;
	var allHallSchedulePrice = $("#hallAllAmount").val()*1;
	 
	var allMealSchedulePrice = $("#mealAllAmount").val()*1;
	
	 var sumOtherPrice =0.00;
	 $('.otherprice').each(function(){
		 if($(this).val()){
			 sumOtherPrice+=$(this).val()*1;
		 }
	 });
	
	var amount = allHallSchedulePrice + allRoomSchedulePrice +allMealSchedulePrice+sumOtherPrice;
	var zgamount = amount;
	var prepaid = $("#prepaid").val()*1;
	var finalPayment = zgamount-prepaid;
	$("#amount_dv").text("￥"+common.formatCurrency(amount));
	$("#zgamount_dv").text("￥"+common.formatCurrency(zgamount));
	$("#finalPayment").text("￥"+common.formatCurrency(zgamount));
	
	 $("#hall_amount_dv").text("￥"+common.formatCurrency(allHallSchedulePrice));
	 $("#room_amount_dv").text("￥"+common.formatCurrency(allRoomSchedulePrice));
	 $("#meal_amount_dv").text("￥"+common.formatCurrency(allMealSchedulePrice));
	 $("#other_amount_dv").text("￥"+common.formatCurrency(sumOtherPrice));
	
}





</script>
		</div>
	</div>
<!--其他费用小项  -->
<script id="other_fee_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: rgb(153, 153, 153);">
		<div class="col-sm-3 pad-no">
			其他小项 :<input type="text" class="form-control" id="" name="otherdetail" placeholder="消费明细" style="width: 200px;display: inline-block;" value="">
		</div>
		<div class="col-sm-2 pad-no">
			单价： <input type="number" id="" name="oprice" class="form-control oprice" placeholder="单价" min="0" style="width: 100px;display: inline-block;" value="0">元
		</div>
		<div class="col-sm-2 pad-no">
			数量： <input type="number" id="" name="oquantity" class="form-control oquantity" placeholder="数量" min="0" style="width: 100px;display: inline-block;" value="1">
		</div>
		<div class="col-sm-3 pad-no">
			总计： <input type="number" id="" name="otherprice" class="form-control otherprice" placeholder="总计" min="0" style="width: 100px;display: inline-block;" value="00" readonly="readonly">
		</div>
		<div class="col-sm-2 pad-no" style="text-align: right;">
			<img class="other-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;display: inline-block;cursor: pointer;" title="删除该项">
		</div>
	</div>
</script>
<!-- 用餐项 -->
<script id="meal_item" type="text/html">
	<div>
		<input type="hidden" id="mealOriginalPrice_{{id}}" name="mealOriginalPrice_{{id}}" value="{{price}}">
		<div class="row pad-ud-5 mgn-ud-5 bottom-line">
			<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">{{name}}</span></div>
			<div class="col-sm-9"></div>
			<div class="col-sm-1 pad-no" style="text-align: right;">
				<div class="meal_detail_edit edit" mealid="{{id}}" style="display: inline-block;">
				</div>
				<div class="meal-del" mealid="{{id}}" style="display: inline-block;">
					<img qx="order:update" src="/hui/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon" title="删除用餐详情">
				</div>
			</div>
		</div>
		<div id="mealViewForm{{id}}" style="display:none;"></div>
		<div id="mealEditForm{{id}}" style="position: relative; display: block;">
				<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
					<input type="hidden" name="bookingRecordId" value="">
					<div class="col-sm-1 pad-no">
						<select id="mealType_{{id}}" name="mealType_{{id}}" mealid="{{id}}" class="meal-type form-control" style="width: 90px;">
							<option value="01" selected="selected">围餐</option>
							<option value="02">自助餐</option>
						</select>
					</div>
					<div class="col-sm-1 pad-no">
						<select id="mealscheduleTime_{{id}}" name="mealscheduleTime_{{id}}" mealid="{{id}}" class="meal-cgt form-control" style="width: 90px;">
							<option value="早餐" selected="selected">早餐</option>
							<option value="午餐">午餐</option>
							<option value="晚餐">晚餐</option>
						</select>
					</div>
					<div class="col-sm-3 pad-no">
				 		<span style="display: inline-block;vertical-align: middle;">用餐时间：</span>
						<input type="date" class="meal-schedule date form-control" id="mealscheduleDate_{{id}}" style="display: inline-block;vertical-align: middle;" name="mealscheduleDate_{{id}}" mealid="{{id}}" onchange="mealScheduleDate(this)" value="${order.activityDate}">
						<input type="hidden" id="mealscheduleId_{{id}}" name="mealscheduleId_{{id}}" value="">
					</div>
					<div class="col-sm-2 pad-no">
						<div style="float: left;padding: 8px 0;">数量：</div>
						<div class="num meal-minus" style="float: left;margin: 6px 0;">-</div>
						<div class="meal-num" style="float: left;margin: 6px 0;">
							<input type="number" name="meal_num_{{id}}" id="meal_num_{{id}}" min="0" style="border: none;width: 50px;height:25.56px;text-align: center;" value="1" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">
						</div>
						<div class="num meal-plus" style="float: left;margin: 6px 0;">+</div>
						<div style="clear:both;"></div>
					</div>
					<div class="col-sm-2 pad-no">
						￥<input type="number" class="price  form-control" value="{{price}}" min="0" name="mealPrice_{{id}}" id="mealPrice{{id}}" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">/围
					</div>
					<div class="col-sm-1 pad-no">
						<img class="meal-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;margin:0.4rem 0;cursor: pointer;">
					</div>
				</div>

			<div style="position: absolute;bottom: 14px;right: 25%;">
				  <img qx="order:update" class="meal-add-schedule btn-icon" src="/hui/static/resource/css/images/add.png" title="添加档期" mealid="{{id}}">
			</div>
		</div>
	</div>
</script>
<!-- 用餐小项 -->
<script id="meal_schedule_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
		<input type="hidden" name="bookingRecordId" value="">
		<div class="col-sm-1 pad-no">
			<select id="mealType_{{id}}" name="mealType_{{id}}" mealid="{{id}}" class="meal-type form-control" style="width: 90px;">
				<option value="01" selected="selected">围餐</option>
				<option value="02">自助餐</option>
			</select>
		</div>
		<div class="col-sm-1 pad-no">
			<select id="mealscheduleTime_{{id}}" name="mealscheduleTime_{{id}}" mealid="{{id}}" class="meal-cgt form-control" style="width: 90px;">
				<option value="早餐" selected="selected">早餐</option>
				<option value="午餐">午餐</option>
				<option value="晚餐">晚餐</option>
			</select>
		</div>
		<div class="col-sm-3 pad-no">
	 		<span style="display: inline-block;vertical-align: middle;">用餐时间：</span>
			<input type="date" class="meal-schedule date form-control" id="mealscheduleDate_{{id}}" style="display: inline-block;vertical-align: middle;" name="mealscheduleDate_{{id}}" mealid="{{id}}" onchange="mealScheduleDate(this)" value="${order.activityDate}">
			<input type="hidden" id="mealscheduleId_{{id}}" name="mealscheduleId_{{id}}" value="">
		</div>
		<div class="col-sm-2 pad-no">
			<div style="float: left;padding: 8px 0;">数量：</div>
			<div class="num meal-minus" style="float: left;margin: 6px 0;">-</div>
			<div class="meal-num" style="float: left;margin: 6px 0;">
				<input type="number" name="meal_num_{{id}}" id="meal_num_{{id}}" min="0" style="border: none;width: 50px;height:25.56px;text-align: center;" value="1" onkeyup="calculateMealSchedulePrice();" onchange="calculateMealSchedulePrice();">
			</div>
			<div class="num meal-plus" style="float: left;margin: 6px 0;">+</div>
			<div style="clear:both;"></div>
		</div>
		<div class="col-sm-2 pad-no">
			￥<input type="number" class="price  form-control" value="{{price}}" min="0" name="mealPrice_{{id}}" id="mealPrice{{id}}" onkeyup="calculateMealSchedulePrice();"  onchange="calculateMealSchedulePrice();">/围
		</div>
		<div class="col-sm-1 pad-no ">
			<img class="meal-schedule-del" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="width:20px;height:20px;margin:0.4rem 0;cursor: pointer;">
		</div>
	</div>
</script>
<!-- 住房详细项 -->
<script id="room_item" type="text/html">
	<div>
		<input type="hidden" name="orderDetailId" value="">
		<input type="hidden" id="hotelPrice{{id}}" name="hotelPrice{{id}}" value="{{hotelPrice}}">
		<div class="row pad-ud-5 mgn-ud-5 bottom-line">
			<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">{{placeName}}</span></div>
			<div class="col-sm-9"></div>
			<div class="col-sm-1 pad-no" style="text-align: right;">
					<div class="room_detail_edit edit" roomid="{{id}}" style="display: inline-block;">
						<img qx="order:update" id="room_detail_edit_to_{{id}}" src="/hui/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon" title="编辑住房档期详情" style="display: none;">
						<img qx="order:update" id="room_detail_edit_cancel_{{id}}" src="/hui/static/resource/css/images/cfm.png" class="btn-icon" style="" title="确认住房档期详情">
					</div>
					<div class="room-del" roomid="{{id}}" style="display: inline-block;">
						<img qx="order:update" src="/hui/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon" title="删除住房档期详情">
					</div>
				
			</div>
		</div>
		<div id="roomViewDetail{{id}}" style="display:none;"></div>
		<div id="roomEditForm{{id}}" style="position: relative;">
			<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
				<input type="hidden" id="roomscheduleId_{{id}}" name="roomscheduleId_{{id}}" value="">
				<div class="col-sm-2 pad-ud-5 rtype">
					<span style="vertical-align: middle;">{{roomType}}</span>
					<span style="vertical-align: middle;">-</span>
					<span style="vertical-align: middle;">{{network}}</span>
				</div>
				<div class="col-sm-1 pad-no">
					<select class="room-breakfast form-control" name="breakfast_{{id}}" roomid="{{id}}" style="width: 80px;">
						<option value="0">无早</option>
						<option value="1" selected="selected">有早</option>
					</select>
				</div>
				<div class="col-sm-2 pad-no">
					<div style="float: left;padding: 8px 0;">数量：</div>
					<div class="num minus" roomid="{{id}}" style="float: left;margin: 6px 0;">-</div>
					<div class="room-num" style="float: left;margin: 6px 0;">
						<input type="number" name="rom_num_{{id}}" id="rom_num_{{id}}" min="0" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">
					</div>
					<div class="num plus" roomid="{{id}}" style="float: left;margin: 6px 0;">+</div>
					<div style="clear:both;"></div>
				</div>
				<div class="col-sm-3 pad-no">
					 <span style="display: inline-block;vertical-align: middle;">入住时间：</span>
					 <input type="date" class="room-schedule date form-control" id="roomscheduleDate_{{id}}" name="roomscheduleDate_{{id}}" roomid="{{id}}" onchange="roomScheduleDate(this)" value="${order.activityDate}" style="display: inline-block;vertical-align: middle;">
				</div>
				<div class="col-sm-2 pad-no">
					￥<input type="number" class="price form-control" value="{{hotelPrice}}" min="0" name="roomPrice_{{id}}" id="roomPrice{{id}}" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">元/间
				</div>
				<div class="col-sm-1 pad-no">
					<img class="room-schedule-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
				</div>
			</div>
			<div style="position: absolute;bottom: 14px;right: 15%;">
				  <img qx="order:update" class="room-add-schedule btn-icon" src="/hui/static/resource/css/images/add.png" title="添加档期" roomid="{{id}}">
			</div>
		</div>
	</div>
</script>
<!-- 住房档期详细项 -->
<script id="room_schedule_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5 bottom-line" style="color: #999999;">
		<input type="hidden" id="roomscheduleId_{{id}}" name="roomscheduleId_{{id}}" value="">
		<div class="col-sm-2 pad-ud-5 rtype">
			{{roomDetail}}
		</div>
		<div class="col-sm-1 pad-no">
			<select class="room-breakfast form-control" name="breakfast_{{id}}" roomid="{{id}}" style="width: 80px;">
				<option value="0">无早</option>
				<option value="1" selected="selected">有早</option>
			</select>
		</div>
		<div class="col-sm-2 pad-no">
			<div style="float: left;padding: 8px 0;">数量：</div>
			<div class="num minus" roomid="{{id}}" style="float: left;margin: 6px 0;">-</div>
			<div class="room-num" style="float: left;margin: 6px 0;">
				<input type="number" name="rom_num_{{id}}" id="rom_num_{{id}}" min="0" style="border: none;width: 50px;text-align: center;" value="1" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">
			</div>
			<div class="num plus" roomid="{{id}}" style="float: left;margin: 6px 0;">+</div>
			<div style="clear:both;"></div>
		</div>
		<div class="col-sm-3 pad-no">
			 <span style="display: inline-block;vertical-align: middle;">入住时间：</span>
			 <input type="date" class="room-schedule date form-control" id="roomscheduleDate_{{id}}" name="roomscheduleDate_{{id}}" roomid="{{id}}" onchange="roomScheduleDate(this)" value="${order.activityDate}" style="display: inline-block;vertical-align: middle;">
		</div>
		<div class="col-sm-2 pad-no">
			￥<input type="number" class="price form-control" value="{{hotelPrice}}" min="0" name="roomPrice_{{id}}" id="roomPrice{{id}}" onkeyup="calculateRoomSchedulePrice();" onchange="calculateRoomSchedulePrice();">元/间
		</div>
		<div class="col-sm-1 pad-no">
			<img class="room-schedule-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
		</div>
	</div>
</script>
<!-- 场地详细项 -->
<script id="hall_item" type="text/html">
	<div class="hall-item" style="width: 100%;">
		<input type="hidden" name="orderDetailId" value="1623">
		<div class="row pad-ud-5 mgn-ud-5 bottom-line">
			<div class="col-sm-2 pad-no"><span style="color:#019FEA;margin:0.5rem 0;">分会厅:{{placeName}} </span></div>
			<div class="col-sm-4 display-flex" style="color: #999999;">
				<span>面积{{hallArea}}m²</span>
				<span>容纳人数{{peopleNum}}人</span>
				<span>层高{{height}}m</span>
				<span>楼层{{floor}}F</span>
				<span>立柱{{pillar}}</span>
			</div>
			<div class="col-sm-5">
			</div>
			<div class="col-sm-1 pad-no" style="text-align: right;">
				<div class="hall_detail_edit edit" hallid="{{id}}" style="display: inline-block;">
					<img qx="order:update" id="hall_detail_edit_to_{{id}}" src="/hui/static/weixin/css/icon/common/icon-order-edit.png" class="btn-icon" style="display: none;">
					<img qx="order:update" id="hall_detail_edit_cancel_{{id}}" src="/hui/static/resource/css/images/cfm.png" class="btn-icon" style="">
				</div>
				<div id="hall-del" class="hall-del" hallid="{{id}}" style="display: inline-block;">
					<img qx="order:update" src="/hui/static/weixin/css/icon/common/icon-order-del.png" class="btn-icon">
				</div>
			</div>
		</div>
		<div id="hallscheduleDetail{{id}}" style="display:none;"></div>
		<div id="hallscheduleUpForm{{id}}" style="color: rgb(153, 153, 153); position: relative;">
			
			<div class="row pad-ud-5 mgn-ud-5">
				<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
				<div class="col-sm-4 pad-no">
					<div style="display: inline-block;vertical-align: middle;">
						<input type="date" class="hall-schedule date form-control" name="scheduleDate_{{id}}" hallid="{{id}}" value="${order.activityDate}" style="float: left;" onchange="hallScheduleDate(this);">
					</div>
			<div style="display: inline-block;margin-left: 10px;vertical-align: middle;">
				<div class="timesolt" style="width: 180px;position: relative;" tabindex="1" hallid="{{id}}">
					<input type="hidden" id="" name="scheduleTime_{{id}}" value="">   
					<input type="hidden" id="" name="scheduleTimeTxt_{{id}}" value="">   
					<div style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
						<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;"></span>
					</div>
					<div  class="timesolt-item" style="position: absolute;left: 0;top: 35px;background-color: #ffffff;width:100%;display: none;z-index: 20000;">
						<c:forEach items="${ctimes}" var="ctme">
							<div style="width: 100%;height:30px; border: 1px solid #999999;">
								<label for="timesolt_${ctme.id}_{{ramId}}" style="width:100%;line-height:30px;vertical-align:middle;">
									<input class="timesolt-select-item" id="timesolt_${ctme.id}_{{ramId}}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" >
									${ctme.name}
								</label>
							</div>
						</c:forEach>
						<div style="width:100%;height:30px;border:1px solid #999999;">
							<label for="timesolt_all_{{ramId}}" style="width:100%;line-height:30px;vertical-align:middle;">
								<input class="timesolt-select-item timesolt_all" id="timesolt_all_{{ramId}}" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
								全天
							</label>
						</div>
						<div style="width:100%;height:40px;border:1px solid #999999;text-align: center;padding: 5px;">
							<button type="button"  class="btn btn-primary btn-sm timesolt-select"  style="width: 40%;" hallId="{{id}}" >确定</button>
							<button type="button"  class="btn btn-default btn-sm timesolt-cancel"  style="width: 40%;" hallId="{{id}}" >取消</button>
						</div>
					</div>
				</div>
			</div>
				</div>
				<div class="col-sm-3 pad-no">
					 ￥<input type="number" class="price form-control" value="{{hotelPrice}}" name="placePrice_{{id}}" id="" onkeyup="calculateHallSchedulePrice();" onchange="calculateHallSchedulePrice();">元
				</div>
				<div class="col-sm-1 pad-no">
					<img class="order-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
				</div>
			</div>
			<div style="position: absolute;bottom: 10px;right: 32%;">
				  <img qx="order:update" class="hall-add-schedule btn-icon" src="/hui/static/resource/css/images/add.png" hallid="{{id}}" title="添加档期">
			</div>
		</div>
	</div>
</script>
<!-- 场地档期项 -->
<script id="hall_schedule_item" type="text/html">
	<div class="row pad-ud-5 mgn-ud-5">
		<div class="col-sm-1 pad-no" style="margin:0.5rem 0;"><span>预定档期：</span> </div>
		<div class="col-sm-4 pad-no">
			<div style="display: inline-block;vertical-align: middle;">
				<input type="date" class="hall-schedule date form-control" name="scheduleDate_{{id}}" hallid="{{id}}" value="${order.activityDate}" style="float: left;" onchange="hallScheduleDate(this);">
			</div>
			<div style="display: inline-block;margin-left: 10px;vertical-align: middle;">
				<div class="timesolt" style="width: 180px;position: relative;" tabindex="1" hallid="{{id}}">
					<input type="hidden" id="" name="scheduleTime_{{id}}" value="">   
					<input type="hidden" id="" name="scheduleTimeTxt_{{id}}" value="">   
					<div style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
						<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;"></span>
					</div>
					<div  class="timesolt-item" style="position: absolute;left: 0;top: 35px;background-color: #ffffff;width:100%;display: none;z-index: 20000;">
						<c:forEach items="${ctimes}" var="ctme">
							<div style="width: 100%;height:30px; border: 1px solid #999999;">
								<label for="timesolt_${ctme.id}_{{ramId}}" style="width:100%;line-height:30px;vertical-align:middle;">
									<input class="timesolt-select-item" id="timesolt_${ctme.id}_{{ramId}}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" >
									${ctme.name}
								</label>
							</div>
						</c:forEach>
						<div style="width:100%;height:30px;border:1px solid #999999;">
							<label for="timesolt_all_{{ramId}}" style="width:100%;line-height:30px;vertical-align:middle;">
								<input class="timesolt-select-item timesolt_all" id="timesolt_all_{{ramId}}" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
								全天
							</label>
						</div>
						<div style="width:100%;height:40px;border:1px solid #999999;text-align: center;padding: 5px;">
							<button type="button"  class="btn btn-primary btn-sm timesolt-select"  style="width: 40%;" hallId="{{id}}" >确定</button>
							<button type="button"  class="btn btn-default btn-sm timesolt-cancel"  style="width: 40%;" hallId="{{id}}" >取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3 pad-no">
			 ￥<input type="number" class="price form-control" value="{{hotelPrice}}" name="placePrice_{{id}}" id="" onkeyup="calculateHallSchedulePrice();" onchange="calculateHallSchedulePrice();">元
		</div>
		<div class="col-sm-1 pad-no">
			<img class="order-del btn-icon" src="/hui/static/weixin/css/icon/common/icon-order-del.png" style="margin:0.4rem 25px;">
		</div>
	</div>
</script>


</div>
