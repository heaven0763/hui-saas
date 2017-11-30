<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="domain" value="http://saas.hui-china.com/hui"></c:set>
<c:set var="domain1" value="http://saas.hui-china.com"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	<meta http-equiv="pragma" content="no-cache"></meta>
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"></meta>
	<meta http-equiv="Cache-Control" content="no-transform"></meta>
	<meta http-equiv="Cache-Control" content="no-siteapp"></meta>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=yes"></meta>
	<title>订单详情</title>
	<meta name="description" content="会掌柜（hui-china.com)是中国最全面的会议活动场所和服务供应商资源网站，允许专业人士和会议活动举办人员找到适合会议和活动的空间场所和服务供应商如：主持人，活动策划公司，摄影摄像师，活动搭建物料，舞台灯光音响设备等，协助他们顺利展开未来的会议活动。实现用户“好办会、办好会”，做办会议搞活动必备一站式资源搜索工具。"></meta>
    <meta name="Keywords" content="会掌柜,会议活动场地,公关会议活动策划执行公司,会展会议活动物料出租,演出演艺公司主持策划舞美设计,灯光音响LED摄影摄像设备,展览舞美制作工厂"></meta>
	<style type="text/css"   media="screen">

		.fa{width: auto;}
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
		.bottom-line{border-bottom: 1px solid #ddd;}
		.vertical-timeline::before {content: '';position: absolute;left: 23.5px;height: 90%; width: 2px; background: #cccccc;top: 18px; margin-bottom: 20px;}
		.timeline-one-list{}
		del {text-decoration: line-through;background-color:#ffffff;}
		.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:-15px;left: 0;}
		.hui{background-image: url('${domain}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
		.hotel{background-image: url('${domain}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}
		.cmstatus{background-image: url('${domain}/static/resource/css/images/cmstatus.png'); }
		.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
		.hide{display: none;}
		.state-item {padding: 0.5rem 0;border-bottom: 1px solid #f5f5f5;text-align: center;color: #999999;}
		.state-item-check {color: #019FEA;}
		.display-flex {display: flex;justify-content: space-between;}
		.showRemark{background-image: url('${domain}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
		.hideRemark{background-image: url('${domain}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
	</style>
</head>
<body style="font-family: Microsoft YaHei,Helvetica,Arial,sans-serif;font-size: 14px;">
	
	<div style="background-color:#f5f5f5;">
		<div id="pcontent" style="width: 1180px; margin: 0 auto;overflow: hidden;min-height:634px;position: relative;background-color:#ffffff;padding: 0 10px;">
			<div>
				<div style="margin-right: -15px;margin-left: -15px;padding:10px;">
					<div style="text-align: center;" >
				            <img style="height: 65px;" src="${domain1}${hotel.logo}"></img>
					</div>
				</div>
				
				<hr style="margin-top: 0; margin-bottom: 0;"/>
				
				<div>
					<!--  -->
					<div style="margin-right: -15px;margin-left: -15px;padding:10px;">
						<div style="text-align: center;width: 100%;">
							<div>
								<c:if test="${order.sourceAppId eq '1'}">
									<img src="${domain}/static/resource/css/images/carton.png" style="display: inline-block;width: 50px;vertical-align: middle;"></img>
								</c:if>
								<c:if test="${order.sourceAppId eq '0'}">
									<img src="${domain}/static/resource/css/images/inner.jpg" style="display: inline-block;width: 50px;vertical-align: middle;"></img>
								</c:if>
								<h3 style="margin-left: 5px;display: inline-block;"> 订单号：${order.orderNo } </h3>
							</div>
						</div>
					</div>
					<!--  -->
					<div>
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
						</div>
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="padding:10px 30px;margin-right: -10px;margin-left: -10px;" >
								<div style="position: relative;">
									<span style="color: #019FEA;font-size: 20px;">预定的场地名称：${order.hotelName }</span>
								</div>
								<div style="padding:5px 0;border-bottom: 1px solid #ddd;">
									<span style="color: #019FEA;">活动名称：${order.activityTitle}</span>
									<span style="padding:0 10px">-</span>
									<span style="">地区：${order.area}</span>
								</div>
								<div style="padding:5px 0;border-bottom: 1px solid #ddd;">
									<span>活动时间：${order.activityDate}</span>
									<span style="padding:0 10px">-</span>
									<span style="">举办单位：${order.organizer}</span>
								</div>
								<div style="padding:5px 0;border-bottom: 1px solid #ddd;">
									<span style="">联系方式：${order.linkman }</span>
									<span style="padding:0 5px">-</span>
									<span style="">${order.contactNumber}</span>
									<span style="padding:0 5px">-</span>
									<span style="">${order.email}</span>
								</div>
								<div style="padding:5px 0;border-bottom: 1px solid #ddd;">
									<span style="">跟进销售：${hotelSale.rname}</span>
									<span style="padding:0 5px">-</span>
									<span style="">${hotelSale.mobile}</span>
								</div>
							</div>
						</div>
					</div>
					<!--  -->
					<div>
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">活动场地选择</span></div>
						</div>
						<c:if test="${not empty sites}">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="padding:10px 30px;" >
									<div style="width:100%;">
										<c:set var="placePrice" value="0"></c:set>
										<c:set var="commissionFeeRate" value="0"></c:set>
										<c:forEach items="${sites }" varStatus="st" var="site">
											<c:set var="commissionFeeRate" value="${site.commissionFeeRate }"></c:set>
											<div style="width:100%; margin-right: -15px;margin-left: -15px;border-bottom: 1px solid #ddd;">
												<div style="width: 45%;float: left;position: relative;min-height: 1px;">
													<div style="margin-right: -15px;margin-left: -15px;padding:5px;">
							                            <div style="width: 100%;position: relative;min-height: 1px; padding-right: 15px; padding-left: 15px;">
							                            	<span style="color: #019FEA;">${site.ismain eq '1'?'主会场':'分会场' }：${site.placeName }</span>
							                            </div>
							                        </div>
							                        <div style="margin-right: -15px;margin-left: -15px;padding:5px;color: #cccccc;">
							                            <div style="float: left;position: relative;min-height: 1px; padding-right: 5px; padding-left: 15px;" >面积${site.hallArea }m²</div>
							                            <div style="float: left;position: relative;min-height: 1px; padding-right: 5px; padding-left: 5px;" >容纳人数${site.peopleNum }人</div>
							                            <div style="float: left;position: relative;min-height: 1px; padding-right: 5px; padding-left: 5px;" >层高${site.height }</div>
							                            <div style="float: left;position: relative;min-height: 1px; padding-right: 5px; padding-left: 5px;" >楼层${site.floor }</div>
							                            <div style="float: left;position: relative;min-height: 1px; padding-right: 5px; padding-left: 5px;" >${site.pillar eq 0?'无柱':'立柱' }${site.pillar eq 0?'':site.pillar }</div>
							                            <div style="clear: both;"></div>
							                        </div>
												</div>
												<div style="width: 54%;float: right;position: relative;min-height: 1px;color:#019FEA;">
													<c:forEach items="${site.bookingRecordModels }" varStatus="bst" var="br">
														<div style="margin-right: -15px;margin-left: -15px;padding:5px;">
								                            <div style="width: 72%;float: left;position: relative;min-height: 1px;">
								                            <span style="padding:0 5px">预定档期：${br.placeDate }</span>
								                            <span style="padding:0 10px;border-radius:20px;border: 1px solid #019FEA;">${br.placeScheduleTxt }</span></div>
								                            <div style="width: 25%;float: right;position: relative;min-height: 1px; text-align: right;color:#000;"><fmt:formatNumber type="currency" value="${br.price }" /></div>
								                            <c:set var="placePrice" value="${placePrice+br.price}"></c:set>
								                            <div style="clear: both;"></div>
								                        </div>
							                        </c:forEach>
												</div>
												<div style="clear: both;"></div>
											</div>
										</c:forEach>
									</div>
									
									<div style="width:100%;">
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">小计：<fmt:formatNumber type="currency" value="${placePrice}"/></div>
										</div>
										<c:if test="${commissionFeeRate > 0}">
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">场地加收服务费（<fmt:formatNumber type="number" value="${commissionFeeRate }"  maxFractionDigits="0"/>%）：<fmt:formatNumber type="currency" value="${placePrice*commissionFeeRate/100 }"/></div>
										</div>
										</c:if>
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
											<c:set var="placeSumPrice" value="${placePrice*(1+commissionFeeRate/100) }"></c:set>
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${placeSumPrice}" /></span></div>
										</div>
									</div>
									<div style="margin-right: -15px;margin-left: -15px;border-top:1px solid #000;"></div>
									<div style="width:100%;margin-right: -15px;margin-left: -15px;">
										<div style="width:100%;font-size: 13px;" >
											<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;background-image: url('${domain}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat;"></div>
											<div class="Remark" style="width:100%;padding: 5px;font-size: 12px;">
												${order.meetingRemark }
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${empty sites}">
							<div style="margin-right: -15px;margin-left: -15px;">		
								<div style="width:100%;padding:10px 30px;" >
								未选择场地
								</div>
							</div>
						</c:if>
					</div>
					<!--  -->
					<div>
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">住房选择</span></div>
						</div>
						<c:if test="${not empty rooms }">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="padding:10px 30px;" >
									<div style="width:100%;">
										<c:set var="roomPrice" value="0"></c:set>
										<c:forEach items="${rooms }" varStatus="st" var="room">
											<div style="margin-right: -15px;margin-left: -15px;border-bottom: 1px solid #ddd;">
												<div style="width: 15%;float: left;position: relative;min-height: 1px;">
													<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
														<div style="padding:5px;">
															<c:if test="${rst.index eq 0 }">
																<div style="width:100%;"><span style="color: #019FEA;">${room.placeName }</span></div>
															</c:if>
															<c:if test="${rst.index ne 0 }">
																<div style="width:100%;"><span style="color: #019FEA;"></span></div>
															</c:if>
								                        </div>
							                        </c:forEach>
												</div>
												<div style="width: 84%;float: left;position: relative;min-height: 1px;">
													<c:forEach items="${room.bookingRecordModels}" varStatus="rst" var="br">
														<div style="width: 100%;margin-right: -15px;margin-left: -15px;padding:5px;${(rst.index+1)<fn:length(room.bookingRecordModels)?'border-bottom: 1px solid #f5f5f5;':'' }">
							                            	<div style="width: 33.3333333%;float: left;position: relative;min-height: 1px; color: #cccccc;">
								                            	<span style="font-weight: bold;">
									                            	<span style="padding:0 5px">${room.roomType}</span>  
									                            	<span style="padding:0 5px">${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }</span>
									                            	<span style="padding:0 5px">${room.network}</span>
									                            	<span style="padding:0 5px"> ×${br.quantity }间</span>
								                            	</span>
							                            	</div>
								                            <div style="width: 25%;float: left;position: relative;min-height: 1px; text-align: right;color: #019FEA;">入住时间：${br.placeDate }</div>
								                            <div style="width: 16.66666667%;float: left;position: relative;min-height: 1px; text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/间</div>
								                            <div style="width: 25%;float: left;position: relative;min-height: 1px; text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
								                            <c:set var="roomPrice" value="${roomPrice+br.price*br.quantity }"></c:set>
								                            <div style="clear: both;"></div>
								                        </div>
							                        </c:forEach>
												</div>
												<div style="clear: both;"></div>
											</div>
										</c:forEach>
									</div>
									<div style="width:100%;">
										<div style="width: 100%;margin-right: -15px;margin-left: -15px;">
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice}"/></span></div>
										</div>
									</div>
									<div style="margin-right: -15px;margin-left: -15px;border-top:1px solid #000;"></div>
									<div style="margin-right: -15px;margin-left: -15px;">
										<div style="width:100%;" >
											<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;background-image: url('${domain}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat;"></div>
											<div class="Remark" style="padding: 5px;font-size: 12px;">
												${order.houseRemark }
											</div>
										</div>
									</div>
								</div>
							</div>		
						</c:if>
						<c:if test="${empty rooms}">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="width:100%;padding:10px 30px;" >
									未选择住房
								</div>
							</div>
						</c:if>
					</div>
					
					<!-- 用餐选择 -->
					
					<div style="width:100%;">
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">用餐选择</span></div>
						</div>
						<c:if test="${not empty meals }">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="padding:10px 30px;" >
									<div style="width:100%;">
										<c:set var="mealPrice" value="0"></c:set>
										<c:forEach items="${meals }" varStatus="st" var="meal">
										<div style="margin-right: -15px;margin-left: -15px;border-bottom: 1px solid #ddd;padding: 5px;">
											<div style="width: 15%;float: left;position: relative;min-height: 1px;">
												<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
													<div style="padding:5px;">
														<c:if test="${rst.index eq 0 }">
							                            	<div style="width:100%;"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
														</c:if>
														<c:if test="${rst.index ne 0 }">
															<div style="width:100%;"><span style="color: #019FEA;font-weight: bold;"></span></div>
														</c:if>
							                        </div>
						                        </c:forEach>
											</div>
											<div style="width: 84%;float: left;position: relative;min-height: 1px;">
												<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
													<div style="width: 100%;margin-right: -15px;margin-left: -15px;padding:5px 8px;${(rst.index+1)<fn:length(meal.bookingRecordModels)?'border-bottom: 1px solid #f5f5f5;':'' }">
							                            <div style="width: 34%;float: left;position: relative;min-height: 1px;color: #cccccc;"><span style="color: #cccccc;"><span style="padding:0 5px">${br.mealType eq '01'?'围餐':'自助餐'}</span><span style="padding:0 5px">${br.placeSchedule }</span><span style="padding:0 5px">×${br.quantity }${br.mealType eq '01'?'围':'个'}</span></span></div>
							                            <div style="width: 25%;float: left;position: relative;min-height: 1px;text-align: right;color: #019FEA;">用餐时间：${br.placeDate }</div>
							                            <div style="width: 21%;float: left;position: relative;min-height: 1px;text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/${br.mealType eq '01'?'围':'个'}</div>
							                            <div style="width: 20%;float: left;position: relative;min-height: 1px; text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
							                            <c:set var="mealPrice" value="${mealPrice+br.price*br.quantity }"></c:set>
							                            <div style="clear: both;"></div>
							                        </div>
						                        </c:forEach>
											</div>
											<div style="clear: both;"></div>
										</div>
										</c:forEach>
									</div>
									
									<div style="width:100%;">
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">小计：<fmt:formatNumber type="currency" value="${mealPrice}"/></div>
										</div>
										<c:if test="${order.mealServiceFeeRate > 0}">
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">用餐加收服务费（<fmt:formatNumber type="number" value="${order.mealServiceFeeRate }"  maxFractionDigits="0"/>%）：<fmt:formatNumber type="currency" value="${mealPrice*order.mealServiceFeeRate/100 }"/></div>
										</div>
										</c:if>
										<div style="width:100%;margin-right: -15px;margin-left: -15px;">
											<c:set var="mealSumPrice" value="${mealPrice*(1+order.mealServiceFeeRate/100) }"></c:set>
				                            <div style="width: 100%;position: relative;min-height: 1px;text-align: right;margin:10px;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${mealSumPrice}" /></span></div>
										</div>
									</div>
									
									<div style="margin-right: -15px;margin-left: -15px;border-top:1px solid #000;"></div>
									<div style="margin-right: -15px;margin-left: -15px;">
										<div style="width:100%;" >
											<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;background-image: url('${domain}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat;"></div>
											<div class="Remark" style="padding: 5px;font-size: 12px;">
												${order.dinnerRemark}
											</div>
										</div>
									</div>
								</div>
							</div>		
						</c:if>
						<c:if test="${empty meals}">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="width:100%;padding:10px 30px;" >
									未选择用餐
								</div>
							</div>
						</c:if>
					</div>
					
					<!-- 其他费用 -->
					
					<div>
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">其他费用</span></div>
						</div>
						<c:if test="${not empty otherDetails }">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="padding:10px 30px;" >
									<div style="width:100%;">
										<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
											<div style="margin-right: -15px;margin-left: -15px;padding:5px 10px;border-bottom: 1px solid #ddd;">
												<div style="width: 16.66666667%;float: left;position: relative;min-height: 1px;color: #019FEA;">
													${odtl.placeName }
												</div>
												<div style="width: 58.33333333%;float: left;position: relative;min-height: 1px;color: #cccccc;">
													<span>单价：<fmt:formatNumber type="currency" value="${odtl.amount/odtl.quantity }" /></span>
													<span style="padding:0 10px">-</span>
													<span>数量：<fmt:formatNumber type="number" value="${odtl.quantity }" /></span>
												</div>
												<div style="width: 24%;float: left;position: relative;min-height: 1px;text-align: right;">
													费用：<fmt:formatNumber type="currency" value="${odtl.amount }" />
												</div>
												 <div style="clear: both;"></div>
											</div>
										</c:forEach>
									</div>
									<div style="width:100%;margin-right: -15px;margin-left: -15px;">
			                        	<div style="width: 100%;position: relative;min-height: 1px; margin:10px; text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}"/></span></div>
									</div>
								</div>
							</div>		
						</c:if>
						<c:if test="${empty otherDetails}">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="width:100%;padding:10px 30px;" >
									未添加其他费用
								</div>
							</div>
						</c:if>
					</div>
					
					<div style="margin-right: -15px;margin-left: -15px;border-top:1px solid #000;"></div>
					
					<div style="margin-right: -15px;margin-left: -15px;padding:10px;">
						<div style="width:100%;" >
							<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;background-image: url('${domain}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat;"></div>
							<div class="Remark" style="padding: 5px;font-size: 12px;">
								${order.memo }
							</div>
						</div>
					</div>
					
					<div>
						<div style="margin-right: -15px;margin-left: -15px;padding:10px 30px;">
							<div style="background: #f5f5f5;width:100%;">
								<div style="margin-right: 0px;margin-left: -15px;padding:5px;">
									<div style="width:100%;text-align: right;">
										<span style="font-size:16px;">场地费用：<fmt:formatNumber type="currency" value="${placeSumPrice  }" /></span>
									</div>
								</div>
								<div style="margin-right: 0px;margin-left: -15px;padding:5px;">
									<div style="width:100%;text-align: right;">
										<span style="font-size:16px;">住房费用：<fmt:formatNumber type="currency" value="${empty roomPrice?0:roomPrice }" /></span>
									</div>
								</div>
								<div style="margin-right: 0px;margin-left: -15px;padding:5px;">
									<div style="width:100%;text-align: right;">
										<span style="font-size:16px;">用餐费用：<fmt:formatNumber type="currency" value="${empty mealSumPrice?0:mealSumPrice  }" /></span>
									</div>
								</div>
								<div style="margin-right: 0px;margin-left: -15px;padding:5px;">
									<div style="width:100%;text-align: right;">
										<span style="font-size:16px;">其他费用：<fmt:formatNumber type="currency" value="${order.otherAmount  }" /></span>
									</div>
								</div>
								<div style="margin-right: 0px;margin-left: -15px;padding:5px;">
									<div style="width:100%;text-align: right;">
										<span style="font-size:16px;color: red;">总计：<fmt:formatNumber type="currency" value="${mealSumPrice+roomPrice+placeSumPrice+order.otherAmount }" /></span>
									</div>
								</div>
							</div>
						</div>
						<div style="margin-right: -15px;margin-left: -15px;padding:0 10px;">
							<div style="width:100%;text-align: right;">
								<span style="margin-right:4%;">*以上价格含税</span>
							</div>
						</div>
					</div>
					
					<div style="width: 100%;margin-bottom: 30px;">
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">场地环境</span></div>
						</div>
						<div style="margin-right: -15px;margin-left: -15px;text-align: center;">
								<div style="width:100%;padding:20px 30px;" >
									<c:forEach items="${hotelImgs }" var="himg">
										<div style="padding:20px;float: left;width: 44%;height: 350px;">
											<img src="${himg.originalImg}" style="width: 100%;height: 350px;"></img>
											<div style="text-align: center;">${hotel.hotelName}</div>
										</div>
									</c:forEach>
									<div style="clear: both;"></div>
								</div>
						</div>
					</div>
					
					<div style="width: 100%;margin-bottom: 30px;">
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">所选会场</span></div>
						</div>
						<c:forEach items="${hallImgs }" var="himg">
							<div style="margin-right: -15px;margin-left: -15px;">
								<div style="width:100%;padding:10px 30px;" >
									<c:forEach items="${himg.imgs }" var="img">
										<div style="padding:10px;float: left;width: 44%;height: 350px;">
											<img src="${img.originalImg}" style="width: 100%;height: 350px;"></img>
											<div style="text-align: center;">${himg.name}</div>
										</div>
									</c:forEach>
									<div style="clear: both;"></div>
								</div>
							</div>
						</c:forEach>
					</div>
					
					<c:forEach items="${roomImgs }" var="rimg">
					<div style="width: 100%;height: 450px;">
						<div style="margin-right: -15px;margin-left: -15px;">
							<div style="width:100%;background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">${rimg.name }</span></div>
						</div>
						<div style="margin-right: -15px;margin-left: -15px;">
								<div style="width:100%;padding:10px 30px;" >
									<c:forEach items="${rimg.imgs }" var="img">
										<div style="padding:10px;float: left;width: 44%;height: 350px;">
											<img src="${img.originalImg}" style="width: 100%;height: 350px;"></img>
										</div>
									</c:forEach>
									<div style="clear: both;"></div>
								</div>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
