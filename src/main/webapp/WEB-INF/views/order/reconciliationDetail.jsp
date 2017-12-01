<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
	.pad-10{padding:10px;}
	.pad-10-k{padding:10px 30px;}
	.pad-5{padding:5px;}
	.pad-2-5{padding:2.5px;}
	.pad-ud-5{padding:5px 0;}
	.pad-ud-10{padding:10px 0;}
	.pad-ud2-5{padding:2.5px 0;}
	.pad-lr-5{padding:0 5px;}
	.pad-lr-10{padding:0 10px;}
	.pad-lr-20{padding:0 20px;}
	.pad-lr-25{padding:0 25px;}
	.pad-lr-30{padding:0 30px;}
	.pad-no{padding: 0;}
	.bottom-line{border-bottom: 1px solid #ddd;}
	.help-block{display: inline-block;margin: 0;color:#ff0000;.}
	.sweet-overlay{z-index: 99998;}
	.div-tips-dialog{z-index: 99997;}
	.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:10px;}
	.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
	.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}

	.col-sm-2{padding-right: 15px;padding-left: 0px;}
	.border-no-top{border-left : 1px solid #d2d2d2;border-right : 1px solid #d2d2d2;border-bottom : 1px solid #d2d2d2;}
	.border-full{border : 1px solid #d2d2d2;}
	.th-bg-gray{background-image: url('/hui/static/resource/css/images/arrow-gray.png');background-repeat: no-repeat;background-position: 100%;background-size: inherit;text-align: center; }
	.th-bg-red{background-image: url('/hui/static/resource/css/images/arrow-red.png');background-repeat: no-repeat;background-position: 100%;background-size: inherit;text-align: center;}
	
	.cms-amt-detl{margin-left: 10%;}
	.cms-amt-edit{margin-left: 10%;display: none;}
</style>
 <div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<h3>订单返佣信息</h3>
				<div style="position: absolute;right: 10px;margin-top: 5px;top: 7px;text-align: right;">
					<a href="javascript:loadContent(this,'${ctx}/base/order/reconciliation/index?type=1','')" class="btn btn-warning" ><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
					<c:if test="${((groupMap.ishotel and guserId eq order.hotelSaleId) or groupMap.ishoteladministrator or groupMap.ishotelsalesdirector) and order.commissionStatus <= '01' }">
						<a qx="comission:invalid" href="javascript:;" id="btn_order_close" class="btn btn-primary" ><span class="glyphicon glyphicon-off"> </span> 无效订单</a>
					</c:if>
				</div>
			</div>
		</div>
		<hr style="margin-top: 0; margin-bottom: 0; "/>
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
				</div>
				<h3 style="margin-left: 55px;">
					订单号：${order.orderNo}
				</h3>  
			</div>
		</div>
		<div class="row" style="margin-top: 10px;">
			<div class="col-sm-12 bottom-line" style="">
				<div class="row">
					<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">基本信息</span></div>
				</div>
				<div class="row">
					<div class="col-sm-12 pad-10-k" style="color: #b3b3b3" >
						<div style="position: relative;">
							<span style="color: #019FEA;font-size: 16px;">预定的场地名称：${order.hotelName }</span>
							<div style="text-align: right;position:absolute;top: 10px;right:10px;"><!--  border-radius:50%; -->
								<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px; display: inline-block;text-align: center;">${mOu.getCommissionStatus(aUs.getCurrentUserType(),order.commissionStatus)}</span>
							</div>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">地区：${order.area}</span>
							<c:if test="${hotel.hotelNature eq '2' }">
								<span class="pad-lr-10">-</span>
								<span style="font-weight: bold;color: #019FEA;">场地所属集团：${hotelGroup.name}</span>
							</c:if>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span style="">跟进销售：${hotelSale.rname}</span>
							<span style="">${hotelSale.mobile}</span>
							<span class="pad-lr-5">-</span>
							<span style="">场地本次获得积分：<span style="color:#019FEA;">${empty order.hotelPoints?0:order.hotelPoints}</span></span>
						</div>
						<div class="pad-ud-5 bottom-line" style="position: relative;margin-top: 10px">
							<span style="color: #019FEA;font-size: 16px;">活动名称：${order.activityTitle }</span>
						</div>
						<div class="pad-ud-5 bottom-line">
							<span>活动时间：${order.activityDate}</span>
						</div>
						<div class="pad-ud-5 bottom-line">
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
							<span style="">客户获得积分：<span style="color:#019FEA;">${empty order.clientPoints?0:order.clientPoints}</span></span>
						</div>
						<div class="pad-ud-5 bottom-line" style="position: relative;margin-top: 10px">
							<span style="color: #019FEA;font-size: 16px;">会掌柜联系方式</span>
							<span>：${huiSale.rname }</span>
							<span class="pad-lr-5">-</span>
							<span style="">${huiSale.mobile}</span>
							<span class="pad-lr-5">-</span>
							<span style="">${huiSale.email}</span>
						</div>
						<div class="pad-ud-5" style="position: relative;margin-top: 10px;color: #0f0f0f;">
							<div style="text-align: right;">返佣权限归属：${order.commissionRights eq '1'?'场地':'集团'}</div>
							<div style="text-align: right;margin-top: 5px;">累计获得积分：<span style="color: #019FEA;">${empty account.totalPoints?0:account.totalPoints }</span></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12" >
    			<div class="row">
					<div class="col-sm-12 pad-10-k">
						<input type="hidden" value="${order.id }" id="id" name="orderId">
						<c:if test="${not empty comissionRecord }">
							<div class="col-sm-12" style="color: #0f0f0f">
								<form id="cmsn_form">
									<input type="hidden" id="cmsn_type" name="cmsn_type" value="${comissionRecord.type }"/>
									<input type="hidden" id="cmsn_id" name="cmsn_id" value="${comissionRecord.id }" />
								<div class="row border-full">
									<div class="col-sm-1" style="padding-right: 6px;padding-left: 0;"><div class="pad-ud-5" style="color: #ffffff;width: 100%;background-color:#048dd3;text-align: center;border-right : 1px solid #d2d2d2;">返佣类型</div></div>
									<div class="col-sm-11 pad-5" style="position: relative;">
										${comissionRecord.type eq '1'?'全单返佣':'分项返佣'}
										<c:if test="${((groupMap.ishotel and guserId eq order.hotelSaleId) or groupMap.ishotelsalesdirector or groupMap.ishoteladministrator) and order.commissionStatus eq '01' }">
											<c:if test="${empty order.iscommissionupdate or  order.iscommissionupdate eq '0'}">
												<img qx="comission:updatecmsn" id="btn_update_cmsn" src="${ctx }/static/weixin/css/icon/common/icon-order-edit.png"  class="btn-icon" title="修改返佣信息" style="position: absolute;top: 0;right: 0;">
												<img qx="comission:updatecmsn" id="btn_cmsn_cancel" src="${ctx }/static/weixin/css/icon/common/icon-order-edit-cancel.png" class="btn-icon" title="取消修改" style="position: absolute;top: 0;right: 0;display: none;">
											</c:if>
										</c:if>
									</div>
								</div>
								
								<c:if test="${comissionRecord.type ne '1' }">
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >会场费用</div>
										<div class="col-sm-3 pad-5" style="">	
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.meetingAmount }" /></div>
											<div class="cms-amt-edit"><input type="number" class="amount" id="meeting_amount" name="meeting_amount" min="0"  value="${empty comissionRecordModel.meetingAmount?0:comissionRecordModel.meetingAmount }" style="text-align: right;width:100%;" onkeyup="meetingAmountChange(this);" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecordModel.mettingRoomCommissionRate }%</div>
											<div class="cms-amt-edit"><input type="number" id="meeting_cmsn_rate" name="meeting_cmsn_rate"  value="${empty comissionRecordModel.mettingRoomCommissionRate?0:comissionRecordModel.mettingRoomCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">会场返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.mettingRoomCommission }" /></div>
											<div class="cms-amt-edit"><input type="number" class="cmsnamount" id="meeting_cmsn_amount" name="meeting_cmsn_amount"  value="${empty comissionRecordModel.mettingRoomCommission?0:comissionRecordModel.mettingRoomCommission}" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >住房费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.houseAmount }" /></div>
											<div class="cms-amt-edit"><input type="number" class="amount" id="house_amount" name="house_amount" min="0"  value="${empty comissionRecordModel.houseAmount?0:comissionRecordModel.houseAmount }" style="text-align: right;width:100%;" onkeyup="houseAmountChange(this);" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecordModel.housingCommissionRate }%</div>
											<div class="cms-amt-edit"><input type="number" id="house_cmsn_rate" name="house_cmsn_rate"  value="${empty comissionRecordModel.housingCommissionRate?0:comissionRecordModel.housingCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">住房返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.housingCommission }" /></div>
											<div class="cms-amt-edit"><input type="number" class="cmsnamount" id="house_cmsn_amount" name="house_cmsn_amount" value="${empty comissionRecordModel.housingCommission?0:comissionRecordModel.housingCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >用餐费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.dinnerAmount }" /></div>
											<div class="cms-amt-edit"><input type="number" class="amount" id="dinner_amount" name="dinner_amount" min="0"  value="${empty comissionRecordModel.dinnerAmount?0:comissionRecordModel.dinnerAmount }" style="text-align: right;width:100%;"  onkeyup="dinnerAmountChange(this);"/></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecordModel.dinnerCommissionRate }%</div>
											<div class="cms-amt-edit"><input type="number" id="dinner_cmsn_rate" name="dinner_cmsn_rate"  value="${empty comissionRecordModel.dinnerCommissionRate?0:comissionRecordModel.dinnerCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">用餐返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.dinnerCommission }" /></div>
											<div class="cms-amt-edit"><input type="number" class="cmsnamount" id="dinner_cmsn_amount" name="dinner_cmsn_amount"  value="${empty comissionRecordModel.dinnerCommission?0:comissionRecordModel.dinnerCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >其他费用</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.otherAmount }" /></div>
											<div class="cms-amt-edit"><input type="number" class="amount" id="other_amount" name="other_amount" min="0"  value="${empty comissionRecordModel.otherAmount?0:comissionRecordModel.otherAmount }" style="text-align: right;width:100%;"  onkeyup="otherAmountChange(this);"/></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl">${comissionRecordModel.ortherCommissionRate }%</div>
											<div class="cms-amt-edit"><input type="number" id="other_amount_rate" name="other_amount_rate"  value="${empty comissionRecordModel.ortherCommissionRate?0:comissionRecordModel.ortherCommissionRate }" readonly="readonly" style="text-align: right;width:80%;" />%</div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">其他返佣</div>
										<div class="col-sm-3 pad-5" style="">
											<div class="cms-amt-detl"><fmt:formatNumber type="currency" value="${comissionRecordModel.ortherCommission }" /></div>
											<div class="cms-amt-edit"><input type="number" class="cmsnamount" id="other_cmsn_amount" name="other_cmsn_amount"  value="${empty comissionRecordModel.ortherCommission?0:comissionRecordModel.ortherCommission }" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
									</div>
									<div class="row border-no-top" style="" >
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">费用合计</div>
										<div class="col-sm-3 pad-5" style="border-right: 1px solid #d2d2d2;">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecordModel.amount }" /></div>
											<div class="cms-amt-edit"><input type="number"  id="cmsn_amount" name="cmsn_amount"  value="${comissionRecordModel.amount }" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
										<div class="col-sm-1 pad-5" style=""></div>
										<div class="col-sm-3 pad-5" style=""></div>
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">佣金合计</div>
										<div class="col-sm-3 pad-5">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecordModel.commissionAmount }" /></div>
											<div class="cms-amt-edit"><input type="number" id="cmsn_amount_cc" name="cmsn_amount_cc"  value="${comissionRecordModel.commissionAmount }" readonly="readonly" style="text-align: right;width:100%;" /></div>
										</div>
									</div>
								</c:if>
								<c:if test="${comissionRecord.type eq '1' }">
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-gray" >订单总额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${order.amount}" /></div>
											<div class="cms-amt-edit" style="color: #c32424;"><fmt:formatNumber type="currency" value="${order.amount}" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">应扣除金额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${order.amount-comissionRecordModel.amount }" /></div>
											<div class="cms-amt-edit"><input type="number" id="un_cmsn_amount" name="un_cmsn_amount"  value="${order.amount-comissionRecordModel.amount }" min="0"  style="text-align: right;width:100%;" onkeyup="unCmsnAmountChange(this);" onchange="unCmsnAmountChange(this);"/></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">应返佣金额</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecordModel.amount }" /></div>
											<div class="cms-amt-edit"><input type="number" id="cmsn_amount" name="cmsn_amount" value="${comissionRecordModel.amount }" min="0" style="width: 100px;text-align: right;" readonly="readonly" /></div>
										</div>
										<div class="col-sm-1 pad-5 th-bg-gray" style="">返佣比例</div>
										<div class="col-sm-2 pad-5" style="">
											<div class="cms-amt-detl" style="color: #c32424;">${comissionRecordModel.allCommissionRate }%</div>
											<div class="cms-amt-edit"><input type="number" id="cmsn_all_rate" name="allCommissionRate" value="${comissionRecordModel.allCommissionRate }" style="width: 80px;text-align: right;" readonly="readonly" />%</div>
										</div>
									</div>
									<div class="row border-no-top" >
										<div class="col-sm-1 pad-5 th-bg-red" style="color: #fff;">返佣金额</div>
										<div class="col-sm-11 pad-5" >
											<div class="cms-amt-detl" style="margin-left: 1.16%;color: #c32424;"><fmt:formatNumber type="currency" value="${comissionRecordModel.commissionAmount }" /></div>
											<div class="cms-amt-edit" style="margin-left: 1.16%;"><input type="number" name="commissionAmount" value="${comissionRecordModel.commissionAmount }" style="width: 100px;text-align: right;" readonly="readonly" /></div>
										</div>
									</div>
								</c:if>
								
								
								
								<div style="margin:0.5rem 0;text-align: right;">
					
											<!-- <div id="btn_update_cmsn" class="btn btn-primary" > 修改佣金 </div> -->
											<!-- <div id="btn_cmsn_cancel" class="btn btn-default" style="display: none;" > 取消 </div> -->
									<c:if test="${((groupMap.ishotel and guserId eq order.hotelSaleId) or groupMap.ishotelsalesdirector or groupMap.ishoteladministrator) and order.commissionStatus eq '01' }">
										<c:if test="${empty order.iscommissionupdate or  order.iscommissionupdate eq '0'}">
											<div qx="comission:cfmcmsn" id="btn_cfm_cmsn" class="btn btn-primary" > 确认佣金 </div>
											<div qx="comission:updatecmsn" id="btn_cmsn_save" class="btn btn-primary" style="display: none;" > 提交佣金 </div>
										</c:if>
										<c:if test="${ order.iscommissionupdate eq '1'}">
											佣金已修改，等待会掌柜审核!
										</c:if>
										<c:if test="${ order.iscommissionupdate eq '9'}">
											佣金已确认，等待财务确认金额!
										</c:if>
									</c:if>
									<c:if test="${((groupMap.iscompany and guserId eq order.companySaleId) or groupMap.iscompanyadministrator or groupMap.isadministrator) and order.iscommissionupdate eq '1' and order.commissionStatus eq '01'}">
										<div qx="comission:cfmcmsn" id="btn_cfm_cmsn_update" class="btn btn-primary" > 确认修改通过 </div>
										<div qx="comission:cfmcmsn" id="btn_cfm_cmsn_unupdate" class="btn btn-warning" > 确认修改不通过 </div>
										<script>
											$(function(){
												$("#btn_cfm_cmsn_update").click(function(){
													show();
													var orderId = '${order.id}';
													var cmsnId = '${comissionRecord.id}';
													var cmsnchkId = '${comissionCheckRecord.id}';
													$.post('${ctx}/base/order/commission/cmsn/update/pass',{orderId:orderId,cmsnId:cmsnId,cmsnchkId:cmsnchkId},function(res){
														if(res.statusCode==='200'){
															swal(res.message,'success');
															 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
														}else{
															swal(res.message,'error');
														}
														hide();
													},'json');
												});
												
												$("#btn_cfm_cmsn_unupdate").click(function(){
													show();
													var orderId = '${order.id}';
													var cmsnId = '${comissionRecord.id}';
													var cmsnchkId = '${comissionCheckRecord.id}';
													$.post('${ctx}/base/order/commission/cmsn/update/unpass',{orderId:orderId,cmsnId:cmsnId,cmsnchkId:cmsnchkId},function(res){
														if(res.statusCode==='200'){
															swal(res.message,'success');
															 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
														}else{
															swal(res.message,'error');
														}
														hide();
													},'json');
												});
											});
										</script>
									</c:if>
									
									<c:if test="${order.commissionStatus eq '05' and (groupMap.ishotelfinance or groupMap.isgroupfinance)}">
										<button qx="comission:payment" type="button" qx="reconciliation:update" id="btn_hotel_transfer" class="btn btn-primary">确认转账</button>
									</c:if>
								
									<c:if test="${iscomission }">
										<div qx="comission:cfmcmsn" type="button" qx="order:commissiom" id="btn_commission" class="btn btn-primary" style="">确认金额</div>
									</c:if>
								</div>
								</form>
							</div>
						</c:if>
					</div>
				</div>
   			</div>
   		</div>	
  		<c:if test="${order.commissionStatus gt '01' }">
	   		<div class="row" style="margin-top: 10px;">
				<div class="col-sm-12 " style="">
					<div class="row">
						<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">发票信息</span></div>
					</div>
					<div class="row">
						<div class="col-sm-12 bottom-line pad-10-k" style="color: #b3b3b3" >
							<c:if test="${order.isinvoice eq '1' }">
								<div class="row">
									<div class="col-sm-4 pad-ud-5">开具发票号码：${order.invoiceNo }</div>
									<div class="col-sm-3 pad-ud-5">开票人：${order.invoiceUname }</div>
									<div class="col-sm-3 pad-ud-5">开具日期：${dUs.toSecond(order.invoiceDate) }</div>
									<div class="col-sm-2" style="text-align: right;">
										<c:if test="${(order.commissionStatus eq '03' or order.commissionStatus eq '04') and order.isinvoice eq '1' and (groupMap.ishotelfinance or groupMap.isgroupfinance)}">
											<button type="button" qx="comission:recinvoice" id="btn_hotel_invoice" class="btn btn-primary">确认领票 </button>
										</c:if>
									</div>
								</div>
							</c:if>
							<c:if test="${order.isinvoice ne '1' && groupMap.iscompany}">
								<form id="invoicefrom" action="${ctx}/weixin/order/comission/invoice/save" method="post">
									<input type="hidden" value="${order.id }" id="id" name="orderId">
									<div class="row pad-ud-no">
										<div class="col-sm-4 pad-ud-5">
											<div class="col-sm-3 pad-no" style="">发票号码</div>
											<div class="col-sm-9 pad-no">
												<input class="input-form required" name="invoiceNo" type="text" style="color:#019FEA;width: 200px;font-size:14px;-webkit-box-flex: 1;border-bottom: 1px solid #999999;" placeholder="请填写发票号码"/>
											</div>
										</div>
										<div class="col-sm-3 pad-ud-5">
											<div class="col-sm-3 pad-no">开票人</div>
											<div class="col-sm-9 pad-no">
												<input class="col-sm-8 pad-no input-form required" name="invoiceUname" type="text" style="color:#019FEA;width: 120px;font-size:14px;-webkit-box-flex: 1;border-bottom: 1px solid #999999;" placeholder="请输入姓名"/>
											</div>
										</div>
										<div class="col-sm-3 pad-ud-5">
											<div class="col-sm-3 pad-no">开具日期</div>
											<div class="col-sm-9 pad-no">
												<input type="text" class="input-form required  layer-date laydate-icon" id="invoiceDate" name="invoiceDate"   style="color:#019FEA;-webkit-box-flex: 1;border-bottom: 1px solid #999999;width: 120px;font-size:14px;height: 20px;" placeholder="请选择日期"/>
											</div>
										</div>
										 <div class="col-sm-2 pad-no" style="text-align: right;">
											<div qx="comission:invoice" id="btn_submit" class="btn btn-primary" > 确认提交 </div>
										</div>
									</div>
									<script type="text/javascript">
										$(function(){
											var invoiceDate={elem:"#invoiceDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
											laydate(invoiceDate);
										});
									</script>
								</form>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	<c:if test="${order.commissionStatus gt '05' }">
	<div class="row" style="margin-top: 10px;">
		<div class="col-sm-12" style="">
			<div class="row">
				<div class="col-sm-12" style="background-color:#048dd3;color: #FFF;padding: 5px;"><span style="margin-left: 2%;">转账情况</span></div>
			</div>
			<div class="row">
				<div class="col-sm-12 pad-10-k" style="color: #b3b3b3" >
					<div class="row">
						<div class="col-sm-10 pad-no">
							${comissionRecord.transferRemark }
						</div>
						<div class="col-sm-2 pad-no" style="text-align: right;">
							<c:if test="${order.commissionStatus eq '06' and groupMap.iscompany}">
								<button type="button" qx="comission:receivables" id="btn_company_transfer" class="btn btn-primary" >确认到账</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	
	<br/>
	<br/>
	<br/>

	<div id="mask_full_screen" class="modal-backdrop fade in" style="display: none;"></div>
	<div id="reconciliation_div" class="div-tips-dialog" style="top:35%;left:35%;padding:1rem 2%;width:400px;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">是否已领取发票</div>
 			<div id="btn_reconciliation_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
		<div style="padding: 1rem 0;"> <!-- qx="reconciliation:update" -->
				<div id="btn-noget-invoice" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">否</div>
				<div qx="comission:recinvoice" id="btn-get-invoice" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">有</div>
				<div style="clear: both;"></div>
		</div>
	</div>	
	
	<div id="hotel_invoice" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">确认领取发票</div>
 			<div id="btn_hotel_invoice_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="padding: 1rem 0;">
 		<input id="hotelInvoiceNo" name="hotelInvoiceNo" type="text" style="width:100%;height: 40px;" placeholder="请输入发票号码"/>
 		</div>
		<div style="padding: 1rem 0;">
				<div id="btn_hotel_invoice_cancel" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">取消</div>
				<div qx="comission:recinvoice" id="btn_hotel_invoice_submit" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">确认领取</div>
				<div style="clear: both;"></div>
		</div>
	</div>	
	
	<div id="hotel_transfer" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;">
		<div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;height: 3rem;line-height:3rem;">确认转账</div>
 			<div id="btn_hotel_transfer_close" class="icon-close"  style="position: absolute;right: 0;top: -0.5rem;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div>
 		<div style="padding: 1rem 0;">
 		<textarea id="tranferMemo" name="tranferMemo" style="width:100%;height: 80px;" placeholder="请输入转账情况"></textarea>
 		</div>
		<div style="padding: 1rem 0;">
				<div id="btn_hotel_transfer_cancel" class="btn btn-xs bg-type-02" style="float:left;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">取消</div>
				<div qx="comission:payment" id="btn_hotel_transfer_submit" class="btn btn-xs bg-type-01" style="float:right;min-width:4.2rem;padding: 0.3rem 0.8rem;font-size: 1rem;width: 40%;vertical-align: middle;">确认转账</div>
				<div style="clear: both;"></div>
		</div>
	</div>	

<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script>
function unCmsnAmountChange(self){
	var $this = $(self);
	var cmsn_type = $('#cmsn_type').val();
	if(cmsn_type==='1'){
		var allamount = '${order.amount}'*1;
		var rate =  $("#cmsn_all_rate").val()*1;
		var cmsn_amount = allamount-$this.val();
		var amount = cmsn_amount*1*rate/100;
		$("input[name='allCommission']").val(amount);
		$("input[name='commissionAmount']").val(amount);
		$("input[name='cmsn_amount']").val(cmsn_amount);
	}else{
		
	}
}
/* function cmsnChangeAmount(self){
	var $this = $(self);
	var cmsn_type = $('#cmsn_type').val();
	if(cmsn_type==='1'){
		var rate =  $("#cmsn_all_rate").val()*1;
		var amount = $this.val()*1*rate/100;
		$("input[name='allCommission']").val(amount);
		$("input[name='commissionAmount']").val(amount);
	}else{
		
	}
} */function meetingAmountChange(self){
	var $this = $(self);
	var rate =  $("#meeting_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#meeting_cmsn_amount").val(amount);
	sumALL();
}
function houseAmountChange(self){
	var $this = $(self);
	var rate =  $("#house_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#house_cmsn_amount").val(amount);
	sumALL();
}
function dinnerAmountChange(self){
	var $this = $(self);
	var rate =  $("#dinner_cmsn_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#dinner_cmsn_amount").val(amount);
	sumALL();
}
function otherAmountChange(self){
	var $this = $(self);
	var rate =  $("#other_amount_rate").val()*1;
	var amount = $this.val()*1*rate/100;
	$("#other_cmsn_amount").val(amount);
	sumALL();
}
function sumALL(){
	var amount = 0;
	var cmsnamount = 0
	$(".amount").each(function(){
		amount+=$(this).val()*1;
	});
	$(".cmsnamount").each(function(){
		cmsnamount+=$(this).val()*1;
	});
	$("#cmsn_amount").val(amount);
	$("#cmsn_amount_cc").val(cmsnamount);
}

function reconciliationReadOrderTrajectory(){
	var reconciliationReadOrder = window.sessionStorage.getItem("reconciliationReadOrder${aUs.getCurrentUserId()}");
	var orderNo = '${order.orderNo}';
	if(reconciliationReadOrder){
		if(reconciliationReadOrder.indexOf(orderNo)<0){
			reconciliationReadOrder +=",${order.orderNo}";
		}
	}else{
		reconciliationReadOrder = "${order.orderNo}";
	}
	window.sessionStorage.setItem("reconciliationReadOrder${aUs.getCurrentUserId()}",reconciliationReadOrder);
}

$(function(){
	reconciliationReadOrderTrajectory();
	common.pms.init();
	<c:if test="${iscomission }">
		$('#btn_commission').click(function(){
			show();
			var orderId = '${order.id}';
			$.post('${ctx}/weixin/order/comission/create',{orderId:orderId},function(res){
				if(res.statusCode==='200'){
					swal(res.message,'success');
					 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
				}else{
					swal(res.message,'error');
				}
				hide();
			},'json');
		});
	</c:if>
	
	$("#btn_cmsn_cancel").click(function(){
		$(this).hide();
		$("#btn_cmsn_save").hide();
		$('#cmsn_form')[0].reset();
		
		$("#btn_update_cmsn").show();
		$("#btn_cfm_cmsn").show();
		/* 
		$("#cmsn_edit").hide();
		$("#cmsn_detail").show(); */
		
		$(".cms-amt-edit").hide();
		$(".cms-amt-detl").show();
		$(".cms-amt-detl").parent().toggleClass("pad-5").toggleClass("pad-2-5");
	});
	$("#btn_update_cmsn").click(function(){
		$(this).hide();
		$("#btn_cmsn_save").show();
		$("#btn_cmsn_cancel").show();
		$("#cmsn_edit").show();
		/* $("#cmsn_detail").hide();
		$("#btn_cfm_cmsn").hide(); */
		$(".cms-amt-edit").show();
		$(".cms-amt-detl").hide();
		
		$(".cms-amt-edit").parent().toggleClass("pad-5").toggleClass("pad-2-5");
	});
	$("#btn_cfm_cmsn").click(function(){
		show();
		var orderId = '${order.id}';
		var cmsnId = '${comissionRecord.id}';
		$.post('${ctx}/base/order/commission/cmsn/cfm',{orderId:orderId,cmsnId:cmsnId},function(res){
			if(res.statusCode==='200'){
				swal(res.message,'success');
				loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
			}else{
				swal(res.message,'error');
			}
			hide();
		},'json');
	});
	$("#btn_cmsn_save").click(function(){
		var cmsn_type = $('#cmsn_type').val();
		if(cmsn_type==='1'){
			var cmsn_amount = $('#cmsn_amount').val();
			if(cmsn_amount==null || cmsn_amount=='' ||cmsn_amount<=0){
				swal('订单金额不能为空，且不能小于零！','error');
				return;
			}
		}else{
			
		}
		var $cmsn_form = $('#cmsn_form')
		show();
		$.post('${ctx}/weixin/order/comission/update',$cmsn_form.serialize(),function(res){
			if(res.statusCode==='200'){
				swal(res.message,'success');
				setTimeout(function(){
					 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
				},1500);
			}else{
				swal(res.message,'error');
				hide();
			}
		});
	});
	$("#btn-noget-invoice").click(function(){
		loadContent(this,'${ctx}/base/order/reconciliation/index','RD');
	});
	$("#btn-get-invoice").click(function(){
		show();
		reconciliationHide()
		$.post('${ctx}/weixin/order/invoice/get/${order.id }',function(res){
			if(res.statusCode=="200"){
				swal(res.message,'success');
				 setTimeout(function(){
					 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
				 },1500);
			}else{
				swal(res.message,'error');
				hide();
				reconciliationShow()
			}
		},"json");
	});
	
	$("#btn_reconciliation_close").click(function(){
		loadContent(this,'${ctx}/base/order/reconciliation/index','RD');
	});
	
	<c:if test="${isgetinvoice }">
		reconciliationShow()
	</c:if>
	
	//show();
	
		var $form = $('#invoicefrom');
		$form.validate();
		$('#btn_submit').click(function(){
			if($form.valid && !$form.valid()){
				return;
			}
			show();
			$.post($form.attr('action'),$form.serialize(),function(res){
				if(res.statusCode==='200'){
					swal('提交成功！','success');
					setTimeout(function(){
						 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
					},1500);
				}else{
					swal(res.message,'error');
					hide();
				}
			});
		});
		<c:if test="${order.isinvoice ne '1' }">
	</c:if>
	
	$("#btn_hotel_invoice").click(function(){
		$('#mask_full_screen').show();
		$("#hotel_invoice").show();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_close").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_invoice").hide();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_cancel").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_invoice").hide();
		$("#hotelInvoiceNo").val('');
	});
	$("#btn_hotel_invoice_submit").click(function(){
		var hotelInvoiceNo = $("#hotelInvoiceNo").val();
		if(hotelInvoiceNo===null || hotelInvoiceNo===''){
			swal('请输入发票号码！','error');
			return;
		}
		
		$("#hotel_invoice").hide();
		$.post('${ctx}/weixin/order/invoice/received/${order.id }',{invoiceNo:hotelInvoiceNo},function(res){
			
			if(res.statusCode=="200"){
				swal(res.message,'success');
				 setTimeout(function(){
					 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
				 },1500);
			}else{
				$("#hotel_invoice").show();
				swal(res.message,'error');
			}
		},"json");
	});
	
	
	$("#btn_hotel_transfer").click(function(){
		$('#mask_full_screen').show();
		$("#hotel_transfer").show();
		$("#tranferMemo").val('');
	});
	$("#btn_hotel_transfer_close").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_transfer").hide();
		$("#tranferMemo").val('');
	});
	$("#btn_hotel_transfer_cancel").click(function(){
		$('#mask_full_screen').hide();
		$("#hotel_transfer").hide();
		$("#tranferMemo").val('');
	});
	
	$("#btn_hotel_transfer_submit").click(function(){
		var tranferMemo = $("#tranferMemo").val();
		if(tranferMemo===null || tranferMemo===''){
			swal('请输入转账情况！','error');
			return;
		}
		//hotelInvoiceNo
		
		$("#hotel_transfer").hide();
		$.post('${ctx}/weixin/order/reconciliation/transfer/accounts/${order.id }',{memo:tranferMemo},function(res){
			if(res.statusCode=="200"){
				swal(res.message,'success');
				 setTimeout(function(){
					 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
				 },1500);
			}else{
				swal(res.message,'error');
				$("#hotel_transfer").show();
			}
		},"json");
	});
	
	 $("#btn_company_transfer").click(function(){
		 cfm_swal("你确认已收到该笔佣金?","","warning","确认到账","","您已取消确认操作！"
				 ,'${ctx}/weixin/order/reconciliation/transfer/accounts/confirmed/${order.id }',{memo:'确认到账'},function(){
					 setTimeout(function(){
						 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
					 },1500);
				 });
		 /* confirmFn("你确认已收到该笔佣金?",function(){
			 $.post('${ctx}/weixin/order/reconciliation/transfer/accounts/confirmed/${order.id }',{memo:'确认到账'},function(res){
					if(res.statusCode=="200"){
						swal(res.message,'success');
						 setTimeout(function(){
							 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
						 },1500);
					}else{
						swal(res.message,'error');
						$("#hotel_transfer").show();
					}
				},"json");
		 }) */
	});
	 
	 $("#btn_order_close").click(function(){
		 cfm_swal("你确认该笔订单无效?","","warning","确认无效","","您已取消确认操作！"
				 ,'${ctx}/weixin/order/invalid/${order.id }',{memo:'确认到账'},function(){
					 setTimeout(function(){
						 loadContent(this,'${ctx}/base/order/reconciliation/detail/${order.id }','RD');
					 },1500);
				 });
	 });
	
});
function  reconciliationShow(){
	$("#mask_full_screen").show();
	$("#reconciliation_div").show();
}
function  reconciliationHide(){
	$("#reconciliation_div").hide();
	$('#mask_full_screen').hide();
}
</script>
</div>
