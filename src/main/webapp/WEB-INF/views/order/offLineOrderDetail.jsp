<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
.pad-10{padding:10px;}
.pad-10-k{padding:20px 10px;}
.pad-5{padding:5px;}
.pad-ud2-5{padding:2.5px 0;}
.bottom-line{border-bottom: 1px solid #ddd;}
.vertical-timeline::before {
    content: '';
    position: absolute;
    left: 23.5px;
    height: 90%;
    width: 2px;
    background: #cccccc;
    top: 18px;
    margin-bottom: 20px;
}
.timeline-one-list{}
/* .timeline-one-list:last-child {
    height: 0;
} */
del {
    text-decoration: line-through;
    background-color:#ffffff;
}
.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
</style>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:loadContent(this,'${ctx}/base/order/index','')" class="btn btn-warning" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>订单信息</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12" style="">
				<div class="ibox float-e-margins" style="">
					<div class="" style="position: relative;">
						<h3>订单号${order.orderNo }</h3>
						<c:if test="${ order.state eq '02'}">
							<a href="javascript:loadContent(this,'${ctx}/base/order/update/${order.id }','')" class="btn btn-primary" style="position: absolute;right: 10px;top:7px;margin-top: 5px;"><span class="glyphicon glyphicon-pencil">修改</span></a>
						</c:if>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-sm-12">
								<div class="row">
									<div class="col-sm-12 pad-10-k" ><span style="color: #048dd3;font-size: 20px;font-weight: bold;">预定的场地名称：${order.hotelName }</span></div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage" style="">基本信息</span></div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="font-weight: bold;">活动名称：${order.activityTitle}</span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span style="color: #019FEA;font-weight: bold;">${stateTxt}</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="">地区：${order.area}</span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span>活动时间：${order.activityDate}</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="">结算状态：${dSv.trsltDict('07',order.settlementStatus)}</span>
												&nbsp;&nbsp;
												&nbsp;&nbsp;
												<span style="color: #019FEA;border: 1px solid #019FEA;padding-left: 20px;padding-right : 20px;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="">举办单位：${order.organizer}</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="">联系方式：${order.linkman }&nbsp;&nbsp;&nbsp;&nbsp;${order.contactNumber}</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="">跟进销售：${order.hotelSaleName}&nbsp;&nbsp;&nbsp;&nbsp;${order.hotelSaleMobile}</span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span style="color:#999999;">积分：${order.hotelPoints }</span>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage">预定活动场地选择</span></div>
								</div>
								<c:set var="placePrice" value="0"></c:set>
								<c:set var="commissionFeeRate" value="0"></c:set>
								<c:forEach items="${sites }" varStatus="st" var="site">
									<c:set var="commissionFeeRate" value="${site.commissionFeeRate }"></c:set>
									<div class="row">
										<div class="col-sm-6 pad-10">
											<div class="row pad-5">
					                            <div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${site.placeName }</span></div>
					                            <div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${site.ismain eq '1'?'主会场':'分会场' }</span></div>
					                        </div>
					                        <div class="row pad-5">
					                            <div class="col-md-12">面积${site.hallArea }m²&nbsp;&nbsp;容纳人数${site.peopleNum }人&nbsp;&nbsp;层高${site.height }m&nbsp;&nbsp;楼层${site.floor }F&nbsp;&nbsp;${site.pillar eq 0?'无柱':'立柱' }${site.pillar eq 0?'':site.pillar }</div>
					                        </div>
										</div>
										<div class="col-sm-6 pad-10">
											<c:forEach items="${site.bookingRecordModels }" varStatus="bst" var="br">
												<div class="row pad-5">
						                            <div class="col-xs-12 col-md-8">预定档期：${br.placeDate }&nbsp;&nbsp;${br.placeSchedule }</div>
						                            <div class="col-xs-8 col-md-4" style="text-align: right;"><fmt:formatNumber type="currency" value="${br.price }" /></div>
						                            <c:set var="placePrice" value="${placePrice+br.price*br.quantity }"></c:set>
						                        </div>
					                        </c:forEach>
										</div>
									</div>
								</c:forEach>
								<div>
									
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="font-weight: bold;">场地预定价格：<fmt:formatNumber type="currency" value="${placePrice}"/></span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span style="font-weight: bold;">场地加收服务费：<fmt:formatNumber type="number" value="${commissionFeeRate }"  maxFractionDigits="0"/>%</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<c:set var="placeSumPrice" value="${placePrice*(1+commissionFeeRate/100) }"></c:set>
												<span style="font-size:16px; font-weight: bold;">小计：<span style="color: red;"><fmt:formatNumber type="currency" value="${placeSumPrice}" /></span></span>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage"">住房选择（团房）</span></div>
								</div>
								<c:set var="roomPrice" value="0"></c:set>
								<c:forEach items="${rooms }" varStatus="st" var="room">
								<div class="row">
									<div class="col-sm-6 pad-10">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5">
											<c:if test="${rst.index eq 0 }">
												<div class="col-xs-6 col-md-4"><span style="color: #019FEA;font-weight: bold;">${room.placeName }</span></div>
											</c:if>
											<c:if test="${rst.index ne 0 }">
												<div class="col-xs-6 col-md-4"><span style="color: #019FEA;font-weight: bold;"></span></div>
											</c:if>
				                            
				                            <div class="col-xs-12 col-md-8"><span style="color: #019FEA;font-weight: bold;">${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}&nbsp;&nbsp;×${br.quantity }间</span></div>
				                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-6 pad-10">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
					                            <div class="col-xs-12 col-md-7">入住时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-5" style="text-align: right;"><fmt:formatNumber type="currency" value="${br.price }" />/间</div>
					                             <c:set var="roomPrice" value="${roomPrice+br.price*br.quantity }"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
								</c:forEach>
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-weight: bold;">住房预定价格：<fmt:formatNumber type="currency" value="${roomPrice}" /></span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:16px; font-weight: bold;">小计：<span style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice }" /></span></span>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage">用餐选择</span></div>
								</div>
								<c:set var="mealPrice" value="0"></c:set>
								<c:forEach items="${meals }" varStatus="st" var="meal">
								<div class="row">
									<div class="col-sm-6 pad-10">
										<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
												<c:if test="${rst.index eq 0 }">
					                            	<div class="col-xs-6 col-md-4"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
												</c:if>
												<c:if test="${rst.index ne 0 }">
													<div class="col-xs-6 col-md-4"><span style="color: #019FEA;font-weight: bold;"></span></div>
												</c:if>
					                            
					                            <div class="col-xs-12 col-md-8"><span style="color: #019FEA;font-weight: bold;">${meal.mealType eq '01'?'围餐':'自助餐'}&nbsp;&nbsp;${br.placeSchedule }&nbsp;&nbsp;×${br.quantity }${meal.mealType eq '01'?'围':'个'}</span></div>
					                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-6 pad-10">
										<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
					                            <div class="col-xs-12 col-md-6">用餐时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-6" style="text-align: right;"><fmt:formatNumber type="currency" value="${br.price }" />/${meal.mealType eq '01'?'围':'个'}</div>
					                            <c:set var="mealPrice" value="${mealPrice+br.price*br.quantity }"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
								</c:forEach>
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-weight: bold;">用餐预定价格：<fmt:formatNumber type="currency" value="${mealPrice }" /></span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:16px; font-weight: bold;">小计：<span style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice}" /></span></span>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage">其他费用</span></div>
								</div>
								<c:set var="mealPrice" value="0"></c:set>
								<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
								<div class="row">
									<div class="col-sm-6 pad-10">
										${odtl.placeName }<fmt:formatNumber type="currency" value="${odtl.amount }" />
									</div>
								</div>
								</c:forEach>
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-weight: bold;">其他费用：<fmt:formatNumber type="currency" value="${order.otherAmount }" /></span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:16px; font-weight: bold;">小计：<span style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}" /></span></span>
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-sm-12 pad-10" style="background: #f5f5f5;">
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="font-size:16px;font-weight: bold;">总计：<fmt:formatNumber type="currency" value="${mealPrice+roomPrice+placeSumPrice+order.otherAmount }" /></span>
											</div>
											<div class="col-md-6" style="text-align: right;">
													<span style="font-size:16px;font-weight: bold;color: red;">在线支付订金即掌柜<span id="amount_txt"><fmt:formatNumber type="number" value="${order.zgdiscount/10 }" /></span>折特惠价</span>
												</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:22px; font-weight: bold;color: red;">掌柜预算：<fmt:formatNumber type="currency" value="${(mealPrice+roomPrice+placeSumPrice+order.otherAmount)*order.zgdiscount/100}" /></span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${order.orderType eq 'OFFLINE' and order.offlineState eq '0' and groupMap.iscompanyadministrator}">
				<div id="offline_check_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
					<div qx="order:update" id="btn_offline_check_nopass" class="btn btn-lg bg-none-01" style="width:48%;margin:0 auto;border-radius:3px;border: 1px solid;">审核不通过</div>
					<div qx="order:update" id="btn_offline_check_pass" class="btn btn-lg bg-type-01" style="width:48%;margin:0 auto;border-radius:3px;">审核通过</div>
				</div>
				<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:8%;padding:1rem 2%;width:80%;text-align:left;display:none;">
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
				<script type="text/javascript">
					$(function(){
						common.pms.init();
						$("#btn_offline_check_nopass").click(function(){
							$("#reason").val('');
							$("#offline_check_no_div").show();
							show();
						});
						
						$("#btn_offline_check_pass").click(function(){
							show();
							$.post('${ctx}/weixin/order/offline/check/pass',{orderId:'${order.id}'},function(res){
								toastFn(res.message);
								if(res.statusCode==='200'){
									setTimeout(function(){
										location = location;
									},1500);
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
								toastFn(res.message);
								if(res.statusCode==='200'){
									hide();	
									setTimeout(function(){
										location = location;
									},1500);
								}else{
									$("#offline_check_no_div").show();
								}
							},'json');
						});
					});
					
				</script>	
			</c:if>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="">
						<h3>订单修改详情</h3>
					</div>
					<div class="ibox-content">
						<div class="row" style="">
							<div class="col-sm-8 vertical-timeline" >
								<c:forEach items="${logs }" var="log">
								<div class="timeline-one-list" style="position: relative;margin-bottom: 20px;">
									<div style="background-color: #0B9FE5; color: #fff; position: absolute;top: 0;left: 0;width: 20px; height: 20px; border-radius: 50%;
    									font-size: 16px; border: 3px solid #f1f1f1; text-align: center; ">
									</div>
									<div style=" position: relative;margin-left: 30px;background: #fff; border-radius: .25em;">
										<h3>${log.operateTime }</h3>
										<div>
											<c:if test="${log.operateType eq 'INSERT' }">
												<div class="row pad-ud2-5">
													<div class="col-sm-12" >
														客户提交订单
													</div>
												</div>
												<div class="row pad-ud2-5">
													<div class="col-sm-12" style="color:#A0A0A0;">
														提交时间：${log.operateTime }
													</div>
												</div>
											</c:if>
											<c:if test="${log.operateType eq 'UPDATE' }">
												<c:if test="${empty log.rname }">
													<c:forEach items="${log.changeDatas }" var="data">
														<div class="row pad-ud2-5">
															<div class="col-sm-7">
																${data.title }：${data.ovalue }
															</div>
															<div class="col-sm-5">
																调整为：<span style="color:#FFB42B;">${data.nvalue }</span>
															</div>
														</div>
													</c:forEach>
													<div class="row pad-ud2-5">
														<div class="col-sm-12" >
															客户提交订单
														</div>
													</div>
													<div class="row pad-ud2-5">
														<div class="col-sm-12" style="color:#A0A0A0;">
															提交时间：${log.operateTime }
														</div>
													</div>
												</c:if>
												<c:if test="${not empty log.rname }">
													<c:forEach items="${log.changeDatas }" var="data">
														<div class="row pad-ud2-5">
															<div class="col-sm-7">
																${data.title }：
																<c:if test="${empty data.type }">${data.ovalue }</c:if>
																<c:if test="${not empty data.type }"><del><fmt:formatNumber type="currency" value="${data.ovalue }" /></del></c:if>
															</div>
															<div class="col-sm-5">
																调整为：
																<span style="color:#FFB42B;">
																<c:if test="${empty data.type }">	${data.nvalue }</c:if>
																<c:if test="${not empty data.type }"><fmt:formatNumber type="currency" value="	${data.nvalue }" /></c:if>
																</span>
															</div>
														</div>
													</c:forEach>
													<div class="row pad-ud2-5">
														<div class="col-sm-12">
															修改人：${log.rname } ${log.position }
														</div>
													</div>
													<div class="row pad-ud2-5">
														<div class="col-sm-12" style="color:#A0A0A0;">
															修改时间：${log.operateTime }
														</div>
													</div>
												</c:if>
											</c:if>
										</div>
									</div>
								</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
	

