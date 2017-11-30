<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
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
.position-a{position:absolute;width: 50px;height: 50px;line-height:50px; border-radius:50%;text-align: center;top:-15px;left: 0;}
.hui{background-image: url('${ctx}/static/resource/css/images/carton.png');background-repeat: no-repeat;}
.hotel{background-image: url('${ctx}/static/resource/css/images/inner.jpg');background-size: 50px;background-repeat:no-repeat;}

.cmstatus{background-image: url('${ctx}/static/resource/css/images/cmstatus.png'); }

.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
.hide{display: none;}
.state-item {
	padding: 0.5rem 0;
	border-bottom: 1px solid #f5f5f5;
	text-align: center;
	color: #999999;
}
.state-item-check {color: #019FEA;}
.display-flex {display: flex;justify-content: space-between;}
.showRemark{background-image: url('${ctx}/static/resource/css/images/showRemark.png');background-repeat: no-repeat; }
.hideRemark{background-image: url('${ctx}/static/resource/css/images/hideRemark.png');background-repeat: no-repeat; }
</style>
<c:set var="url" value="${ctx}${OFFTAG eq 'OFFLINE'?'/base/order/offline/check/index':'/base/order/index' }"></c:set>
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-5" >
			<h3>订单信息</h3>
		</div>
		<div class="col-sm-7" >
			<div style="margin-top: 20px;margin-bottom: 10px;text-align: right;">
			<a href="javascript:;" class="btn btn-warning backto"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a><!--loadContent(this,'${url}','')  -->
			<c:if test="${( groupMap.ishoteladministrator or groupMap.ishotelsalesdirector) and (order.state=='01' or order.state=='02' or order.state=='021' or order.state=='04')}"> <!--( || order.state eq '04')  -->
				<a qx="order:update"  href="${ctx}/base/order/salerChangeForm/${order.id}" target="dialog" class="btn btn-primary" 
				style=""><span class="glyphicon glyphicon-pencil"> 调整跟进销售</span></a>
			</c:if>
			<c:if test="${((groupMap.ishotel and order.hotelSaleId eq guserId) or groupMap.ishotelsalesdirector or groupMap.ishoteladministrator) and order.state < '021'}"> <!--( || order.state eq '04')  -->
				<a qx="order:update" href="javascript:loadContent(this,'${ctx}/weixin/order/detail/${order.id }','')" class="btn btn-primary" 
				style=""><span class="glyphicon glyphicon-pencil"> 修改</span></a>
			</c:if>
			<c:if test="${groupMap.ishotelsales and order.state gt '02' and order.state < '10'  and order.state !='03' and !(order.state eq '06' and order.settlementStatus eq '04')}">
				<button type="button"  qx="order:update" id="btn_order_state" class="btn btn-primary" >订单状态更改</button>
			</c:if>
			<c:if test="${groupMap.iscompanysales and guserId eq order.companySaleId and order.orderType eq 'OFFLINE' and (order.state=='021' or order.state=='04')}">
				<button type="button"  qx="order:update" id="btn_order_state" class="btn btn-primary" >订单状态更改</button>
			</c:if>
			<c:if test="${((groupMap.iscompanysales  and order.companySaleId eq guserId) or groupMap.iscompanysalesdirector or groupMap.iscompanyadministrator or groupMap.isadministrator) and order.state < '021'}">
				<a qx="order:update" href="javascript:confirmQuotation(${order.id})" class="btn btn-primary" style=""><span class="glyphicon glyphicon-pencil"> 确认报价</span></a>
				<script type="text/javascript">
				 function confirmQuotation(id){
					 cfm_swal("您确定确认该笔订单报价？","","warning","确认", "确认报价完成。","您取消了该操作！"
								,'${ctx}/weixin/order/confirm/quotation',{id:id},function(){
									loadContent(this,'${ctx}/base/order/detail/'+id,'');
						});
				 }
				</script>
			</c:if>
			<div id="order_state_chg_div" class="div-tips-dialog" style="top:40%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;z-index: 9999;">
				<div  style="text-align:center;line-height: 1.5rem;position: relative;">
					<input id="tostate" name="tostate" type="hidden" value="">
		 		</div>
				<div id="state_list" >
					<!-- <div class="state-item" style="cursor: pointer;" data="1">处理中</div> -->
					<div class="state-item" style="cursor: pointer;" data="2">已交订金</div>
					<div class="state-item" style="cursor: pointer;" data="3">已签约</div>
					<div class="state-item" style="cursor: pointer;" data="7">已付款</div>
					<div class="state-item" style="cursor: pointer;" data="4">已完成</div>
					<div class="state-item" style="cursor: pointer;" data="5">已结算</div>
					<div class="state-item" style="cursor: pointer;" data="0">客户取消</div>
				</div>
				
				<div id="canceldv" style="padding:0 2%;display: none;" >
					<c:if test="${order.settlementStatus>='02' }">
						<div style="width: 100%;">
							<div style="padding: 5px 0;display: inline-block;width:48%;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
							<div style="padding: 5px 0;display: inline-block;width:48%;">已付定金：<fmt:formatNumber type="currency" value="${order.prepaid}" /></div>
						</div>
						<div style="width: 100%;">
							<div style="padding:5px 0" >退款金额：<input type="number" id="refundAmount" value="" max="${order.prepaid}" min="0" class="form-control" style="width: 50%;display: inline-block;" placeholder="请输入退款金额" ></div>
						</div>
					</c:if>
					<div>
						<textarea id="cancelReason" rows="5" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入取消原因"></textarea>
					</div>
				</div>
				<div id="settlementdv" style="padding:0 2%;display: none;" >
					<div style="width: 100%;">
						<div   style="padding: 5px 0;display: inline-block;width:48%;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
						<div   style="padding: 5px 0;display: inline-block;width:48%;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></div>
					</div>
					<div style="width: 100%;">
						<div style="padding:5px 0" >结算金额：<input type="number" id="settlementAmount" value="" min="0" class="form-control" style="width: 50%;display: inline-block;" placeholder="请输入退款金额" ></div>
					</div>
				</div>
				<div id="payedv" style="padding:0 2%;display: none;" >
					<div style="width: 100%;">
						<div style="padding: 5px 0;display: inline-block;width:48%;">结算状态：<span>${dSv.trsltDict('07',order.settlementStatus)}</span></div>
						<div style="padding: 5px 0;display: inline-block;width:48%;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></div>
					</div>
					<div style="width: 100%;">
						<div style="padding:5px 0" >付款金额：<input type="number" id="payAmount" value="" min="0" class="form-control" style="width: 50%;display: inline-block;" placeholder="请输入退款金额" ></div>
					</div>
				</div>
				<div id="prepaydv" style="padding:5px 2%;display: none;" >
					<input type="number" class="form-control" id="prepay" value="" min="0" style="width: 98%;" placeholder="请输入订金" >
				</div>
				<div class="display-flex" style="padding: 1rem 0;">
					<div id="btn-order-state-cansel" class="btn btn-warning" style="padding:0.3rem 0.8rem;width: 40%;" > 取消</div>
					<div qx="order:update" id="btn-order-state-sure" class="btn btn-primary" style="padding:0.3rem 0.8rem;width: 40%;" > 确定</div>
				</div>
			</div>	
			
			<script type="text/javascript">
			$("#btn_order_state").click(function(){
				$("#order_state_chg_div").show();
				show();
				$("#marks").css("z-index",9997);
				$(".sk-spinner").hide();
				$("#prepay").val('');
				$("#refundAmount").val(0);
				$("#payAmount").val(0);
				$("#cancelReason").val('');
				$('.state-item').removeClass("state-item-check");
			});
			
			$("#btn-order-state-cansel").click(function(){
				$("#order_state_chg_div").hide();
				hide();
				$("#marks").css("z-index",10000);
				$(".sk-spinner").show();
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
				var cancelReason = "";
				var ramount = 0;
				var prepay = 0;
				var pamount =$("#payAmount").val();
				
				if(tostate==='0'){
					cancelReason = $("#cancelReason").val();
					if(cancelReason===''){
						swal('请输入取消原因！','error');
						return;
					}
					ramount =$("#refundAmount").val();
					var stlstate = '${order.settlementStatus}';
					if(stlstate>='02'&&(ramount===''||ramount*1<0)){
						swal('请输入退款金额，退款金额不能小于0！','error');
						return;
					}
				}else if(tostate==='5'){
					pamount =$("#settlementAmount").val();
					if(pamount===''||pamount*1<0){
						swal('请输入结算金额，结算金额不能小于0！','error');
						return;
					}
				}else if(tostate==='2'){
					prepay = $("#prepay").val();
					if(prepay===''||prepay*1<=0){
						swal('请输入订金，且订金不能小于0！','error');
						return;
					}
				}else if(tostate==='7'){
					pamount = $("#payAmount").val();
					if(pamount===''||pamount*1<=0){
						swal('请输入金额，且金额不能小于0！','error');
						return;
					}
				}
				if(tostate){
					$.post('${ctx}/weixin/order/state/${order.id}',{tostate:tostate,cancelReason:cancelReason,prepay:prepay,ramount:ramount,pamount:pamount},function(res){
						if(res.statusCode==='200'){
							$("#order_state_chg_div").hide();
							swal(res.message,'success');
							setTimeout(function(){
								loadContent(this,'${ctx}/base/order/detail/${order.id}','RD');
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
					$("#settlementdv").hide();
					
					$("#prepay").val('');
					$("#refundAmount").val(0);
					$("#payAmount").val(0);
					$("#cancelReason").val('');
				}else if($this.attr('data')==='2'){
					$("#canceldv").hide();
					$("#payedv").hide();
					$("#settlementdv").hide();
					$("#prepaydv").show();
					
					$("#prepay").val('');
					$("#cancelReason").val('');
					$("#refundAmount").val(0);
					$("#payAmount").val(0);
				}else if($this.attr('data')==='5'){
					$("#canceldv").hide();
					$("#prepaydv").hide();
					$("#settlementdv").show();
					$("#payedv").hide();
					
					$("#settlementAmount").val(0);
				}else if($this.attr('data')==='7'){
					$("#canceldv").hide();
					$("#prepaydv").hide();
					$("#settlementdv").hide();
					$("#payedv").show();
					
					$("#payAmount").val(0);
				}else{
					$("#canceldv").hide();
					$("#prepaydv").hide();
					$("#payedv").hide();
					$("#settlementdv").hide();
					
					$("#settlementAmount").val(0);
					$("#refundAmount").val(0);
					$("#payAmount").val(0);
					$("#prepay").val('');
					$("#cancelReason").val('');
				}
			});
			</script>
			<c:if test="${order.state=='11' && groupMap.ishotelfinance }">
				<button qx="order:update" type="button" onclick="agree('${order.id }')" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 同意</button>
				<button qx="order:update" type="button" onclick="rejectOpenForm('${order.id }')" class="btn btn-warning"><span class="glyphicon glyphicon-share-alt"></span> 拒绝</button>
				<script type="text/javascript">
					$(function(){
						$('#offline_check_no_ic_close').click(function(){
							 rejectCloseForm();
						});
						$('#btn_offline_check_no_cansel').click(function(){
							 rejectCloseForm();
						});
					});
					function rejectOpenForm(id){
						show();
						$("#orderNo").val(id);
						$("#offline_check_no_div").show();
						$(".spiner-example").hide();
					}
					function rejectCloseForm(){
						hide();
						$("#orderNo").val('');
						$("#reason").val('');
						$("#offline_check_no_div").hide();
						$(".spiner-example").show();
					}
					function reject(){
						var orderNo = $("#orderNo").val();
						var reason = $("#reason").val();
						if(reason===''){
							swal("请输入原因",'error');
							return;
						}
						 $.post('${ctx}/weixin/order/site/adjustment/reject',{id:orderNo,reason:reason},function(res){
							if(res.statusCode=='200'){
								swal(res.message,'success');
								//refund_order_search();
								rejectCloseForm();
								loadContent(this,'${ctx}/base/order/detail/'+id,'');
							}else{
								swal(res.message,'error');
								$("#offline_check_no_div").show();
							}
						},'json'); 
					}
					function agree(id){
						cfm_swal("您确定同意该笔退款申请！","","warning","同意", "同意退款申请完成。","您取消了该操作！"
								,'${ctx}/weixin/order/site/adjustment/agree',{id:id},function(){
									//refund_order_search();
									loadContent(this,'${ctx}/base/order/detail/'+id,'');
						});
					}
				</script>
				<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:35%;padding:10px 2%;width:500px;text-align:left;display:none;z-index: 99997; ">
					<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
						<div style="color: #000000;">不通过原因</div>
						<input id="orderNo" name="orderNo" type="hidden" value="">
						<!-- <div  class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div> -->
						<button id="offline_check_no_ic_close" type="button" class="close" style="position: absolute;top: 0;right: 0;">	<span>×</span></button>
			 		</div>
					<div style="padding:0 2%;" >
						<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
					</div>
					
					<div class="" style="padding: 1rem 0;text-align: right;">
						<div id="btn_offline_check_no_cansel" class="btn btn-warning" ><span class="glyphicon glyphicon-off"></span> 再考虑</div>
						<div id="btn_offline_check_no_sure" class="btn btn-primary" onclick="reject()" ><span class="glyphicon glyphicon-save"></span> 确定</div>
					</div>
				</div>
			</c:if>
			<%-- <c:if test="${(order.state=='04' || order.state=='06') && order.settlementStatus < '04' && groupMap.ishotelfinance && empty order.clientId}">
				<button qx="order:update" type="button" onclick="cfmSettlement('${order.id}')" class="btn btn-info"><span class="glyphicon glyphicon-ok"></span> 确认收款</button>
				<script type="text/javascript">
					function cfmSettlement(id){
						cfm_swal("您确认该订单已收款！","","warning","确认收款", "确认收款申请完成。","您取消了该操作！"
								,'${ctx}/weixin/order/state/'+id,{tostate:5},function(){
									loadContent(this,'${ctx}/base/order/detail/'+id,'');
						});
					}
				</script>
			</c:if> --%>
			</div>
		</div>
	</div>
	<hr style="margin-top: 0; margin-bottom: 0; "/>
	<div id="haha">
		<div class="row">
			<div class="col-sm-12" style="">
				<div class="" style="position: relative;">
					<div class="position-a ${order.sourceAppId eq '1'?'hui':'hotel'}" style="font-size: 20px;">
						<%-- ${order.sourceAppId eq '1'?'会':'內'} --%>
					</div>
					<h3 style="margin-left: 55px;position: relative;">
					订单号：${order.orderNo }
					<c:if test="${order.commissionStatus eq '00' and  order.sourceAppId ne '0'}">
						<div class="cmstatus" style="position: absolute;left: 34%;top: -5px;width: 80px;height: 30px;">	</div>
					</c:if>
					</h3>
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
						<div style="text-align: right;position:absolute;top: 10px;right:10px;"><!--  border-radius:50%; -->
							<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px;display: inline-block;text-align: center;">${dSv.trsltDict('05',order.state)}</span>
							&nbsp;&nbsp;
							<span style="color: #019FEA;border: 1px solid #019FEA;width: 80px;height: 30px;line-height:30px; display: inline-block;text-align: center;">${dSv.trsltDict('07',order.settlementStatus)}</span>
						</div>
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
			<c:if test="${not empty sites}">
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
				                            	<span style="color: #019FEA;font-weight: bold;">${site.ismain eq '1'?'主会场':'分会场' }：${site.placeName }</span>
				                            </div>
				                            <%-- <span style="color: #019FEA;font-weight: bold;">（${site.ismain eq '1'?'主会场':'分会场' }）</span> --%>
				                            <%-- <div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${site.ismain eq '1'?'主会场':'分会场' }</span></div> --%>
				                        </div>
				                        <div class="row pad-5">
				                            <div class="col-md-12" style="color: #cccccc;">面积${site.hallArea }m²&nbsp;&nbsp;容纳人数${site.peopleNum }人&nbsp;&nbsp;层高${site.height }m&nbsp;&nbsp;楼层${site.floor }F&nbsp;&nbsp;${site.pillar eq 0?'无柱':'立柱' }${site.pillar eq 0?'':site.pillar }</div>
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
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<!-- <div class="hideRemark" style="width: 70px;height: 32px;display: none;"></div> -->
								<div class="Remark pad-5" style="display: none;">
									${order.meetingRemark }
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty sites}">
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
			<c:if test="${not empty rooms }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="roomPrice" value="0"></c:set>
							<c:forEach items="${rooms }" varStatus="st" var="room">
								<div class="row bottom-line">
									<div class="col-sm-2">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
												<c:if test="${rst.index eq 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;">${room.placeName }</span></div>
												</c:if>
												<c:if test="${rst.index ne 0 }">
													<div class="col-xs-12 col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
												</c:if>
					                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-10">
										<c:forEach items="${room.bookingRecordModels}" varStatus="rst" var="br">
											<div class="row pad-5 ${(rst.index+1)<fn:length(room.bookingRecordModels)?'bottom-line':'' }">
				                            	<div class="col-xs-12 col-md-4" style="color: #cccccc;"><span style="font-weight: bold;">${room.roomType  }&nbsp;&nbsp;${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;${room.network}&nbsp;&nbsp;×${br.quantity }间</span></div>
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
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5" style="display: none;">
									${order.houseRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${empty rooms}">
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
			<c:if test="${not empty meals }">
				<div class="row">
					<div class="col-sm-12 pad-10-k" >
						<div>
							<c:set var="mealPrice" value="0"></c:set>
							<c:forEach items="${meals }" varStatus="st" var="meal">
							<div class="row bottom-line pad-5">
								<div class="col-sm-2">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5">
											<c:if test="${rst.index eq 0 }">
				                            	<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
											</c:if>
											<c:if test="${rst.index ne 0 }">
												<div class="col-md-12"><span style="color: #019FEA;font-weight: bold;"></span></div>
											</c:if>
				                           
				                        </div>
			                        </c:forEach>
								</div>
								<div class="col-sm-10">
									<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5 ${(rst.index+1)<fn:length(meal.bookingRecordModels)?'bottom-line':'' }">
				                            <div class="col-xs-12 col-md-4" ><span style="color: #cccccc;">${br.mealType eq '01'?'围餐':'自助餐'}&nbsp;&nbsp;${br.placeSchedule }&nbsp;&nbsp;×${br.quantity }${br.mealType eq '01'?'围':'个'}</span></div>
				                            <div class="col-xs-12 col-md-3 " style="text-align: right;color: #019FEA;">用餐时间：${br.placeDate }</div>
				                            <div class="col-xs-12 col-md-2" style="text-align: right;color: #019FEA;"><fmt:formatNumber type="currency" value="${br.price }" />元/${br.mealType eq '01'?'围':'个'}</div>
				                            <div class="col-xs-12 col-md-3" style="text-align: right;">预定费用：<fmt:formatNumber type="currency" value="${br.price*br.quantity }" /></div>
				                            <c:set var="mealPrice" value="${mealPrice+br.price*br.quantity }"></c:set>
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
			                            <div class="col-md-3" style="text-align: right;">小计：<fmt:formatNumber type="currency" value="${mealPrice}"/></div>
			                        </div>
								</div>
							</div>
							<c:if test="${order.mealServiceFeeRate > 0}">
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"></div>
			                            <div class="col-md-3" style="text-align: right;">用餐加收服务费（<fmt:formatNumber type="number" value="${order.mealServiceFeeRate }"  maxFractionDigits="0"/>%）：<fmt:formatNumber type="currency" value="${mealPrice*commissionFeeRate/100 }"/></div>
			                        </div>
								</div>
							</div>
							</c:if>
							<div class="row">
								<div class="col-md-12">
									<div class="row pad-5">
			                            <div class="col-md-9"><c:set var="mealSumPrice" value="${mealPrice*(1+order.mealServiceFeeRate/100) }"></c:set></div>
			                            <div class="col-md-3" style="text-align: right;">合计：<span style="color: red;"><fmt:formatNumber type="currency" value="${mealSumPrice}" /></span></div>
			                        </div>
								</div>
							</div>
						</div>
						
						<div class="row" style="border-top:1px solid #000;"></div>
						<div class="row">
							<div class="col-sm-12" >
								<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
								<div class="Remark pad-5" style="display: none;">
									${order.dinnerRemark }
								</div>
							</div>
						</div>
					</div>
				</div>		
			</c:if>
			<c:if test="${empty meals}">
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
			<c:if test="${not empty otherDetails }">
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
			<c:if test="${empty otherDetails}">
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
				<div class="remark-btn showRemark" style="width: 70px;height: 32px;margin: 5px 0;cursor: pointer;"></div>
				<div class="Remark pad-5" style="display: none;">
					${order.memo }
				</div>
			</div>
		</div>
		
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
						<span style="font-size:16px;font-weight: bold;">用餐费用：<fmt:formatNumber type="currency" value="${empty mealSumPrice?0:mealSumPrice  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">其他费用：<fmt:formatNumber type="currency" value="${order.otherAmount  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;color: red;">总计：<fmt:formatNumber type="currency" value="${order.amount }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">已付定金：<fmt:formatNumber type="currency" value="${order.prepaid  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">已付金额：<fmt:formatNumber type="currency" value="${order.settlementAmount  }" /></span>
					</div>
				</div>
				<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span style="font-size:16px;font-weight: bold;">剩余尾款：<fmt:formatNumber type="currency" value="${order.finalPayment}" /></span>
					</div>
				</div>
				<c:if test="${order.settlementStatus >='04'}">
					<div class="row pad-5">
					<div class="col-md-12" style="text-align: right;">
						<span id="finalPayment" style="font-size:16px;font-weight: bold;">
							结算金额：<fmt:formatNumber type="currency" value="${order.settlementAmount+order.prepaid}" />
						</span>
					</div>
					</div>
				</c:if>
				<%-- <c:if test="${order.state eq '09'  }">
				</c:if> --%>
			</div>
		</div>
		
		
		
		
		<div>
			<c:if test="${groupMap.iscompanysales and order.state eq '03' and not empty order.companyFollowTime && empty order.companyFollowMemo}">
				<div id="company_follow_div" class="display-flex" style="color: #ffffff;width:94%;text-align: center;padding: 3%;">
					<div qx="order:update" id="btn_company_follow_pass" class="btn btn-lg bg-type-01" style="width:48%;margin:0 auto;border-radius:3px;">客服介入</div>
				</div>
				<div id="company_follow_feedback_div" class="div-tips-dialog" style="top:35%;left:35%;padding:10px 2%;width:500px;height:450px;text-align:left;display:none;">
					<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
						<div style="color: #000000;">客服介入反馈</div>
						<div id="company_follow_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
			 		</div>
					<div style="padding:0 2%;">
						<textarea id="companyFollowMemo" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入客服介入反馈"></textarea>
					</div>
					<div class="display-flex" style="padding: 1rem 0;">
						<div id="btn_company_follow_cansel" class="btn btn-xs bg-type-02" style="padding:0.3rem 0.8rem;width: 40%;" >再考虑</div>
						<div qx="order:update" id="btn_company_follow_sure" class="btn btn-xs bg-type-01" style="padding:0.3rem 0.8rem;width: 40%;" > 确定</div>
					</div>
				</div>	
			</c:if>
			<c:if test="${order.orderType eq 'OFFLINE' and order.offlineState eq '0' and groupMap.iscompanyadministrator}">
				<div id="offline_check_div" class="display-flex" style="color: #ffffff;width:94%;text-align: left;padding: 3%;">
					<div qx="order:update" id="btn_offline_check_nopass" class="btn btn-primary" style="width:20%;margin:0 auto;border-radius:3px;border: 1px solid;">审核不通过</div>
					<div qx="order:update" id="btn_offline_check_pass" class="btn btn-primary" style="width:20%;margin:0 auto;border-radius:3px;">审核通过</div>
				</div>
				<div id="offline_check_no_div" class="div-tips-dialog" style="top:25%;left:35%;padding:16px 2%;width:500px;text-align:left;display:none;">
					<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
						<div style="color: #000000;font-size: 16px;">不通过原因</div>
						<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
			 		</div>
					<div style="padding:0 2%;">
						<textarea id="reason" rows="18" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
					</div>
					<div class="display-flex" style="padding: 16px 0;text-align: right;">
						<div id="btn_offline_check_no_cansel" class="btn btn-primary" style="padding:0.3rem 0.8rem;width: 30%;" >再考虑</div>
						<div qx="order:update" id="btn_offline_check_no_sure" class="btn btn-primary" style="padding:0.3rem 0.8rem;width: 30%;" > 确定</div>
					</div>
				</div>
				
				<script type="text/javascript">
					
					$(function(){
						
						$("#btn_offline_check_nopass").click(function(){
							$("#reason").val('');
							$("#offline_check_no_div").show();
							show();
						});
						
						
						$("#btn_offline_check_pass").click(function(){
							show();
							$.post('${ctx}/weixin/order/offline/check/pass',{orderId:'${order.id}'},function(res){
								
								if(res.statusCode==='200'){
									swal(res.message, "success");
									setTimeout(function(){
										loadContent(this,'${ctx}/base/order/detail/${order.id}?OFFTAG=OFFLINE','');
									},1500);
								}else{
									swal(res.message, "error");
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
									hide();	
									setTimeout(function(){
										loadContent(this,'${ctx}/base/order/detail/${order.id}?OFFTAG=OFFLINE','');
									},1500);
									swal(res.message, "success");
								}else{
									$("#offline_check_no_div").show();
									swal(res.message, "error");
								}
							},'json');
						});
					});
					
					
				</script>	
			</c:if>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="pad-10">
					<input type="hidden" id="logidx" value="0">
					<table style="width: 100%;">
						<c:forEach items="${logs }" var="log" varStatus="st">
						<tr>
							<td class="pad-10" style="width: 30%;border-top: 1px solid #f5f5f5;border-bottom:1px solid #f5f5f5;color: #0B9FE5; ">
								<span>${st.index ==0?'最新修改':''}  ${dUs.toDay(log.operateTime) }</span>
							</td>
							<td class="pad-10" style="width: 70%;border-top: 1px solid #f5f5f5;border-bottom:1px solid #f5f5f5;border-left: 1px solid #f5f5f5;position: relative;color: #A0A0A0;">
								<div style="background-color: #f1f1f1; color: #fff; position: absolute;top: 46%;left: -5px;width: 10px; height: 10px; border-radius: 50%;"></div>
								<c:if test="${st.index ==0}">
								<div class="pad-lr-10" onclick="showLog(this);" style="position:absolute;top:10px;right: 10px;border-radius: 5px;border: 1px solid #0B9FE5;width: 160px;text-align: center;color: #0B9FE5;cursor: pointer;">
								查看更多记录 <span class="fa fa-chevron-down"></span></div>
								</c:if>
								<div style="width: 100%;">
									<c:if test="${log.operateType eq 'INSERT' }">
										<div class="row pad-ud2-5">
											<div class="col-sm-12" >
												客户提交订单
											</div>
										</div>
										<div class="row pad-ud2-5">
											<div class="col-sm-12" style="color:#cccccc;">
												提交时间：${dUs.toSecond(log.operateTime) }
											</div>
										</div>
									</c:if>
									<c:if test="${log.operateType eq 'UPDATE' }">
										<c:if test="${empty log.rname }">
											<c:forEach items="${log.changeDatas }" var="data">
												<div>
													${data.title }调整为：<span style="color:#FFB42B;">${data.nvalue }</span>
												</div>
											</c:forEach>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" >
													客户提交订单
												</div>
											</div>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" style="color:#cccccc;">
													提交时间：${dUs.toSecond(log.operateTime) }
												</div>
											</div>
										</c:if>
										<c:if test="${not empty log.rname }">
											<c:forEach items="${log.changeDatas }" var="data">
												<div>
													<%-- <div class="col-sm-7">
														
														<c:if test="${empty data.type }">${data.ovalue }</c:if>
														<c:if test="${not empty data.type }"><del><fmt:formatNumber type="currency" value="${data.ovalue }" /></del></c:if>
													</div>
													<div class="col-sm-5"> --%>
														${data.title} 
														<c:if test="${data.title eq '现销售人员' or data.title eq '原销售人员'  }">
														：
														</c:if>
														<c:if test="${data.title ne '现销售人员' and data.title ne '原销售人员'  }">
														调整为：
														</c:if>
														<span style="color:#FFB42B;">
														<c:if test="${empty data.type }">	${data.nvalue }</c:if>
														<c:if test="${not empty data.type }"><fmt:formatNumber type="currency" value="	${data.nvalue }" /></c:if>
														</span>
													<!-- </div> -->
												</div>
											</c:forEach>
											<div class="row pad-ud2-5">
												<div class="col-sm-12">
													修改人：${log.rname } ${log.position }
												</div>
											</div>
											<div class="row pad-ud2-5">
												<div class="col-sm-12" style="color:#cccccc;">
													修改时间：${dUs.toSecond(log.operateTime) }
												</div>
											</div>
										</c:if>
									</c:if>
								</div>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function () {
	common.pms.init();
	$(".remark-btn").click(function(){
		var crtclass = $(this).hasClass("hideRemark");
		if(crtclass){
			$(this).removeClass("hideRemark");
			$(this).addClass("showRemark");
			$(this).next().hide();
		}else{
			$(this).removeClass("showRemark");
			$(this).addClass("hideRemark");
			$(this).next().show();
		}
	});
	
	
	orderTrajectory();
	$("#btn_modify").click(function(){
		$("#modify_content").toggleClass("hide");
	});
	$(".backto").click(function(){
		loadContent(this,'${ctx}/'+$(".item-active").find('a').attr('url'),'QUICK');
	});
	if("${issend}"==1){
		html2canvas(document.getElementById("haha"), {  
	        allowTaint: true,  
	        taintTest: false,  
	        onrendered: function(canvas) {  
	            canvas.id = "mycanvas";  
	            //document.body.appendChild(canvas);  
	            //生成base64图片数据  
	            var dataUrl = canvas.toDataURL();  
	            var newImg = document.createElement("img");  
	            $.ajax({
	                type: "POST",
	                url: "${ctx}/weixin/order/sendEmail",
	                data: {base64:dataUrl,id:"${order.id}"},
	                success: function(data){
	                }
	            });
	        }  
	    });  
	}
	
	showLog();
});
function showLog(self){
	var logidx = $("#logidx").val();
	if(logidx==0){
		$("table tr").hide();
		$("table tr:eq(0)").show();
		$("#logidx").val("1");
		if(self){
			$(self).find("span").toggleClass("fa-chevron-down").toggleClass("fa-chevron-up");
		}
	}else{
		$("table tr").show();
		$("#logidx").val("0");
		if(self){
			$(self).find("span").toggleClass("fa-chevron-down").toggleClass("fa-chevron-up");
		}
	}
}
function orderTrajectory(){
	var readOrder = common.getstorage("readOrder${aUs.getCurrentUserId()}",readOrder);
	var orderNo = '${order.orderNo}';
	
	if(readOrder){
		if(readOrder.indexOf(orderNo)<0){
			readOrder +=",${order.orderNo}";
		}
	}else{
		readOrder = "${order.orderNo}";
	}
	common.setstorage("readOrder${aUs.getCurrentUserId()}",readOrder);	
}

</script>

