<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<#assign c=JspTaglibs["http://java.sun.com/jsp/jstl/core"]>
<#assign fn=JspTaglibs["http://java.sun.com/jsp/jstl/functions"]>
<#assign fmt=JspTaglibs["http://java.sun.com/jsp/jstl/fmt"]>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	
	<meta http-equiv="pragma" content="no-cache"></meta>
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"></meta>
	<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT"></meta>
	<title>订单详情</title>
	<meta name="description" content="会掌柜（hui-china.com)是中国最全面的会议活动场所和服务供应商资源网站，允许专业人士和会议活动举办人员找到适合会议和活动的空间场所和服务供应商如：主持人，活动策划公司，摄影摄像师，活动搭建物料，舞台灯光音响设备等，协助他们顺利展开未来的会议活动。实现用户“好办会、办好会”，做办会议搞活动必备一站式资源搜索工具。">
    <meta name="Keywords" content="会掌柜,会议活动场地,公关会议活动策划执行公司,会展会议活动物料出租,演出演艺公司主持策划舞美设计,灯光音响LED摄影摄像设备,展览舞美制作工厂">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/common.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/newmain.css"> 
	<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
	<style type="text/css">
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
		.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
		.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}
		.cmstatus{background-image: url('${ctx}/static/resource/css/images/cmstatus.png'); }
		.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
		.hide{display: none;}
		.state-item {padding: 0.5rem 0;border-bottom: 1px solid #f5f5f5;text-align: center;color: #999999;}
		.state-item-check {color: #019FEA;}
		.display-flex {display: flex;justify-content: space-between;}
		.showRemark{background-image: url('${ctx}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
		.hideRemark{background-image: url('${ctx}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
	</style>
	<script src="${staticPath}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctx}/static/weixin/myjs/common.js"></script>
	
	<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
	
	<script src="${ctx}/static/js/jquery.multi-select.js"></script>
	<script type="text/javascript">
	function nofindImg(self){
		var $this = $(self);
		$this.attr("src","${ctx}/public/default/img/avatar.png");
		$this.attr("onerror",null); //控制不要一直跳动
	}
	</script>
</head>
<body>
<div class="content" style="background-color:#f5f5f5;">
		<div id="pcontent" class="width1000 jiudianxq grdpxq sjzx" style="min-height:634px;position: relative;background-color:#ffffff;padding: 0 10px;">
<div class="wrapper wrapper-content">
	<div class="row pad-10">
		<div class="col-sm-12" style="text-align: center;" >
	            <img class="gerenBnLfLo" src="${hotel.logo}">
		</div>
	</div>
	<hr style="padding: 5px;margin-top: 0; margin-bottom: 0; "/>
	<div>
		<div class="row pad-10">
			<div class="col-sm-12" style="text-align: center;">
				<div>
					<c:if test="${order.sourceAppId == '1'}">
						<img src="${ctx}/static/resource/css/images/carton.png" style="display: inline-block;"/>
					</c:if>
					<c:if test="${order.sourceAppId == '0'}">
						<img src="${ctx}/static/resource/css/images/inner.jpg" style="display: inline-block;width: 50px;"/>
					</c:if>
					<h3 style="margin-left: 5px;display: inline-block;"> 订单号：${order.orderNo } </h3>
				</div>
			</div>
		</div>
		<!-- 基本信息 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
			</div>
			<div class="row">
				<div class="col-sm-12 pad-10-k" >
					<div style="position: relative;">
						<span style="color: #019FEA;font-size: 20px;font-weight: bold;">预定的场地名称：${order.hotelName }</span>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span style="font-weight: bold;color: #019FEA;">活动名称：${order.activityTitle}</span>
						<span class="pad-lr-10">-</span>
						<span style="">地区：${order.area}</span>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span>活动时间：${order.activityDate}</span>
						<span class="pad-lr-10">-</span>
						<span style="">举办单位：${order.organizer}</span>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span style="">联系方式：${order.linkman }</span>
						<span class="pad-lr-5">-</span>
						<span style="">${order.contactNumber}</span>
						<span class="pad-lr-5">-</span>
						<span style="">${order.email}</span>
					</div>
					<div class="pad-ud-5 bottom-line">
						<span style="">跟进销售：${order.hotelSaleName}</span>
						<span class="pad-lr-5">-</span>
						<span style="">${order.hotelSaleMobile}</span>
					</div>
				</div>
			</div>
		</div>
		<!-- 活动场地选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">活动场地选择</span></div>
			</div>
			<c:if test="${sites != null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="placePrice" value="0"></c:set>
							<c:set var="commissionFeeRate" value="0"></c:set>
							<c:forEach items="${sites }" varStatus="st" var="site">
								<c:set var="commissionFeeRate" value="${site.commissionFeeRate }"></c:set>
								<div class="row bottom-line">
									<div class="col-sm-6">
										<div class="row pad-5">
				                            <div class="col-xs-12 col-md-6">
				                            	<span style="color: #019FEA;font-weight: bold;">${site.ismain}：${site.placeName }</span>
				                            </div>
				                        </div>
				                        <div class="row pad-5">
				                            <div class="col-md-12" style="color: #cccccc;">面积${site.hallArea }m²&nbsp;&nbsp;容纳人数${site.peopleNum }人&nbsp;&nbsp;层高${site.height }m&nbsp;&nbsp;楼层${site.floor }F&nbsp;&nbsp;${site.pillars}${site.pillar == 0?'':site.pillar }</div>
				                        </div>
									</div>
									<div class="col-sm-6" style="color:#019FEA;">
										<c:forEach items="${site.bookingRecordModels }" varStatus="bst" var="br">
											<div class="row pad-5">
					                            <div class="col-md-9">预定档期：${br.placeDate }&nbsp;&nbsp;<span class="pad-lr-5" style="border-radius:20px;border: 1px solid #019FEA;">&nbsp;&nbsp;${br.placeScheduleTxt }&nbsp;&nbsp;</span></div>
					                            <div class="col-md-3" style="text-align: right;"><fmt:formatNumber type="currency" value="${br.price }" /></div>
					                            <c:set var="placePrice" value="${placePrice+br.price}"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
						
						<div>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">小计：<fmt:formatNumber type="currency" value="${placePrice}"/></div>
			                        </div>
								</div>
							</div>
							<c:if test="${commissionFeeRate > 0}">
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">场地加收服务费（<fmt:formatNumber type="number" value="${commissionFeeRate }"  maxFractionDigits="0"/>%）：<fmt:formatNumber type="currency" value="${placePrice*commissionFeeRate/100 }"/></div>
			                        </div>
								</div>
							</div>
							</c:if>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"><c:set var="placeSumPrice" value="${placePrice*(1+commissionFeeRate/100) }"></c:set></div>
			                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${placeSumPrice}" /></span></div>
			                        </div>
								</div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<!-- <div class="hideRemark" style="width: 70px;height: 32px;display: none;"></div> -->
								<div class="Remark pad-5">
									${order.meetingRemark }
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${sites == null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
					未选择场地
					</div>
				</div>
			</c:if>
		</div>
		<!-- 住房选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">住房选择</span></div>
			</div>
			<c:if test="${rooms != null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="roomPrice" value="0"></c:set>
							<c:forEach items="${rooms }" varStatus="st" var="room">
								<div class="row bottom-line">
									<div class="col-sm-2">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
												<c:if test="${rst.index == 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;">${room.placeName }</span></div>
												</c:if>
												<c:if test="${rst.index != 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
												</c:if>
					                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-10">
										<c:forEach items="${room.bookingRecordModels}" varStatus="rst" var="br">
											<div class="row pad-5 ${(rst.index+1)<fn:length(room.bookingRecordModels)?'bottom-line':'' }">
				                            	<div class="col-xs-12 col-md-4" style="color: #cccccc;"><span style="font-weight: bold;">${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast == 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}&nbsp;&nbsp;×${br.quantity }间</span></div>
					                            <div class="col-xs-12 col-md-3" style="text-align: right;color: #019FEA;">入住时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-2" style="text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/间</div>
					                            <div class="col-xs-12 col-md-3" style="text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
					                            <c:set var="roomPrice" value="${roomPrice+br.price*br.quantity }"></c:set>
					                        </div>
				                        </c:forEach>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice}"/></span></div>
		                        </div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5">
									${order.houseRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${rooms == null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未选择住房
					</div>
				</div>
			</c:if>
		</div>
		<!-- 用餐选择 -->
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">用餐选择</span></div>
			</div>
			<c:if test="${meals !=null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="mealPrice" value="0"></c:set>
							<c:forEach items="${meals }" varStatus="st" var="meal">
							<div class="row bottom-line pad-5">
								<div class="col-sm-2">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5">
											<c:if test="${rst.index == 0 }">
				                            	<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
											</c:if>
											<c:if test="${rst.index != 0 }">
												<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
											</c:if>
				                           
				                        </div>
			                        </c:forEach>
								</div>
								<div class="col-sm-10">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5 ${(rst.index+1)<fn:length(meal.bookingRecordModels)?'bottom-line':'' }">
				                            <div class="col-xs-12 col-md-4" ><span style="color: #cccccc;">${br.mealType == '01'?'围餐':'自助餐'}&nbsp;&nbsp;${br.placeSchedule }&nbsp;&nbsp;×${br.quantity }${br.mealType == '01'?'围':'个'}</span></div>
				                            <div class="col-xs-12 col-md-3 " style="text-align: right;color: #019FEA;">用餐时间：${br.placeDate }</div>
				                            <div class="col-xs-12 col-md-2" style="text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/${br.mealType == '01'?'围':'个'}</div>
				                            <div class="col-xs-12 col-md-3" style="text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
				                            <c:set var="mealPrice" value="${mealPrice+br.price*br.quantity }"></c:set>
				                        </div>
			                        </c:forEach>
								</div>
							</div>
							</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice}"/></span></div>
		                        </div>
							</div>
						</div>
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5">
									${order.dinnerRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${meals ==null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未选择用餐
					</div>
				</div>
			</c:if>
		</div>
		<!-- 其他费用 -->
		
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">其他费用</span></div>
			</div>
			<c:if test="${otherDetails != null }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:forEach items="${otherDetails }" varStatus="st" var="odtl">
									<div class="row bottom-line">
										<div class="col-md-2 pad-ud-5">
											${odtl.placeName }
										</div>
										<div class="col-md-7 pad-ud-5">
											<span>单价：<fmt:formatNumber type="currency" value="${odtl.amount/odtl.quantity }" /></span>
											<span class="pad-lr-10">-</span>
											<span>数量：<fmt:formatNumber type="number" value="${odtl.quantity }" /></span>
										</div>
										<div class="col-md-3 pad-ud-5" style="text-align: right;padding-right: 20px;">
											费用：<fmt:formatNumber type="currency" value="${odtl.amount }" />
										</div>
									</div>
								</c:forEach>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="row pad-5">
		                            <div class="col-md-9"></div>
		                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${order.otherAmount}"/></span></div>
		                        </div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${otherDetails == null}">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						未添加其他费用
					</div>
				</div>
			</c:if>
		</div>
		<div class="row" style="border-top:1px solid #000;"></div>
		<div class="row pad-10">
			<div class="col-sm-12" >
				<div class="remark-btn hideRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
				<div class="Remark pad-5" >
					${order.memo }
				</div>
			</div>
		</div>
		<div>
			<div class="row pad-10 pad-lr-25">
				<div class="col-sm-12 " style="background: #f5f5f5;">
					<div class="row pad-5">
						<div class="col-md-12" style="text-align: right;">
							<span style="font-size:16px;font-weight: bold;">场地费用：<fmt:formatNumber type="currency" value="${placeSumPrice  }" /></span>
						</div>
					</div>
					<div class="row pad-5">
						<div class="col-md-12" style="text-align: right;">
							<span style="font-size:16px;font-weight: bold;">住房费用：<fmt:formatNumber type="currency" value="${empty roomPrice?0:roomPrice }" /></span>
						</div>
					</div>
					<div class="row pad-5">
						<div class="col-md-12" style="text-align: right;">
							<span style="font-size:16px;font-weight: bold;">用餐费用：<fmt:formatNumber type="currency" value="${empty mealPrice?0:mealPrice  }" /></span>
						</div>
					</div>
					<div class="row pad-5">
						<div class="col-md-12" style="text-align: right;">
							<span style="font-size:16px;font-weight: bold;">其他费用：<fmt:formatNumber type="currency" value="${order.otherAmount  }" /></span>
						</div>
					</div>
					<div class="row pad-5">
						<div class="col-md-12" style="text-align: right;">
							<span style="font-size:16px;font-weight: bold;color: red;">总计：<fmt:formatNumber type="currency" value="${mealPrice+roomPrice+placeSumPrice+order.otherAmount }" /></span>
						</div>
					</div>
				</div>
			</div>
			<div class="row pad-lr-10">
				<div class="col-md-12" style="text-align: right;">
					<span style="margin-right: 5%;">*以上价格含税</span>
				</div>
			</div>
		</div>
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">酒店环境</span></div>
			</div>
			<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<c:forEach items="${hotelImgs }" var="himg">
							<div class="pad-10" style="float: left;">
								<img src="${himg.originalImg}" style="width: 500px;height: 360px;"/>
								<div style="text-align: center;">${hotel.hotelName}</div>
							</div>
						</c:forEach>
						<div style="clear: both;"></div>
					</div>
			</div>
		</div>
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">所选大厅</span></div>
			</div>
			<c:forEach items="${hallImgs }" var="himg">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<c:forEach items="${himg.imgs }" var="img">
							<div class="pad-10" style="float: left;">
								<img src="${img.originalImg}" style="width: 500px;height: 360px;"/>
								<div style="text-align: center;">${himg.name}</div>
							</div>
						</c:forEach>
						<div style="clear: both;"></div>
					</div>
				</div>
			</c:forEach>
		</div>
		<c:forEach items="${roomImgs }" var="rimg">
		<div>
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">${rimg.name }</span></div>
			</div>
			<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<c:forEach items="${rimg.imgs }" var="img">
							<div class="pad-10" style="float: left;">
								<img src="${img.originalImg}" style="width: 500px;height: 360px;"/>
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
