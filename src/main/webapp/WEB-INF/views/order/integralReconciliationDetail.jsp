<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
 <div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:loadContent(this,'${ctx}/weixin/hotel/integral/reconciliation/index','')" class="btn btn-warning" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>积分商城对账信息</h3>
				<hr>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12" style="">
			    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
			    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
			   	<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
			   	<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
			    <style>
				    .bgimg{height: 7rem;width: 7rem;background-size: cover;background-position: center;}
				    i.ic{background-image:url(${ctx}/static/weixin/css/icon/main/jfcons.png);background-repeat: no-repeat;background-size:14px;    background-position: center; }
			    </style>
				
				<div style="width:96%;margin:0 auto;">
					<div  style="display:-webkit-flex;-webkit-align-items:center;-webkit-justify-content:space-between;height:48px;">
						订单号：${integralOrder.orderNo}  
					</div>
					<div>
						<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.2rem 1.5rem;font-size: 1.0rem;">基本信息</div>
					</div>
					<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 1rem;padding: 2% 0;">
						<div  style="padding-top: 0.5rem;">
							<div class="bgimg" style="float:left;background-image: url('${ctx}/${integralCommodity.img }');"></div>
							<div  style="float:left;margin-left: 10px;width: 60%;">
								<div class="one-list-ct-title" style="margin: 10px 0;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;font-size: 16px;">${integralCommodity.name }</div>
								<div style="margin: 5px 0;widht:100%;">
									<div style="float: left;">场地原价：<fmt:formatNumber type="currency" value="${integralCommodity.price }" /></div>
									<div style="float: left;margin-left: 30px;">
										<i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">${integralCommodity.integral }分</span>
									</div>
									<div style="clear:both;"></div>
								</div>
								<div style="margin: 5px 0;font-size: 0.9rem;">会掌柜价：<fmt:formatNumber type="currency" value="${integralCommodity.zgprice }" /></div>
							</div>
							<div style="clear:both;"></div>
						</div>
					</div>
					<div style="padding: 2% 0;">
						<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.2rem 1.5rem;font-size: 1.0rem;">兑换信息</div>
					</div>
					<div class="font-size-min" style="border-top:1px solid #cccccc;font-size: 0.9rem;">
						<div style="margin:0.5rem 0;">
							<div>兑换人：<span >${integralOrder.clientName}&nbsp;&nbsp;${integralOrder.clientMobile}&nbsp;&nbsp;${integralOrder.area}</span></div>
						</div>
						<div style="margin:0.5rem 0;">
							<div>兑换时间：<span >${dUs.toSecond(integralOrder.createDate)}</span></div>
						</div>
						<div style="margin:0.5rem 0;">
							<div>兑换积分：<span style="color: red;font-weight: bold;"><fmt:formatNumber type="number" value="${integralOrder.points }" minIntegerDigits="0" />分</span></div>
						</div>
						<div style="margin:0.5rem 0;">
							<div>财务对账：<span id="settlement_state" style="color: #019FEA;font-weight: bold; ">${integralOrder.settlementStatus eq '0'?'未对账':integralOrder.settlementStatus eq '1'?'已申请':'已对账'}</span></div>
						</div>
					</div>
				</div>
				<div style="width:100%;">
					<div style="width:100%;background-color: #f5f5f5;padding: 1.0rem 0;">
						<div style="float: left;margin-left: 2%;">应结：
							<fmt:formatNumber type="currency" value="${integralOrder.jdamount }" />
						</div>
						<div style="float: right;text-align: right;margin-right: 2%;display:inline;color:red;font-weight: bold;">实结：
							<fmt:formatNumber type="currency" value="${integralOrder.zgamount }" />
						</div>
						<div style="clear: both;"></div>
					</div>
					<c:if test="${issettlement }">
						<div id="settlement_div" style="padding: 1% 2%;">
							<div  qx="points-mall:reconciliation" id="btn_settlement" class="btn btn-primary" >${type eq 'HUI' ?'确认':'申请'}结账</div>
						</div>
					</c:if>
				</div>
			
			<script>
			$(function(){
				
				common.pms.init();
				
				$("#btn_settlement").click(function(){
					
					var orderNo = '${integralOrder.orderNo}';
					var itemId = '${integralOrderDetail.itemId}';
					var action = "";
					var btns = "";
					if('${type}'==='HUI'){
						action="确认";
					}else{
						action="申请";
					}
					cfm_swal("您确定要"+action+"该对账信息","","warning",action, "对账信息"+action+"完成。","您取消了该操作！"
							,'${ctx}/weixin/hotel/integral/reconciliation/settlement',{orderNo:orderNo,itemId:itemId},function(){
							loadContent(this,'${ctx}/weixin/hotel/integral/reconciliation/detail/${integralOrderDetail.itemId}','')
					});
					
					
					/* show();
					
					$.post('${ctx}/weixin/hotel/integral/reconciliation/settlement',{orderNo:orderNo,itemId:itemId},function(res){
						toastFn(res.message);
						if(res.statusCode=='200'){
							$("#settlement_div").hide();
							$("#settlement_state").text('已对账');
						}else{
							
						}
						hide();
					}) */
				});
			});
			</script>
		</div>
	</div>
</div>
