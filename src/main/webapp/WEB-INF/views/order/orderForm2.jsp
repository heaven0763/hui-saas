<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
.pad-10{padding:10px;}
.pad-10-k{padding:20px 10px;}
.pad-5{padding:5px;}
.bottom-line{border-bottom: 1px solid #ddd;}
.bage{font-size: 16px;font-weight: bold;border: 1px solid #ddd;padding: 5px 20px;}
</style>
<c:set var="url" value="${ctx}${OFFTAG eq 'OFFLINE'?'/base/order/offline/check/index':'/base/order/index' }"></c:set>
<div class="wrapper wrapper-content">
	<!-- <div class="row">
		<div class="col-sm-12">
			<a href="javascript:window.history.go(-1)" class="btn btn-warning"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
		</div>
	</div> -->
	<div class="row">
		<div class="col-sm-12" style="position: relative;">
			<a href="javascript:loadContent(this,'${ctx}/base/order/detail/${order.id }','')" class="btn btn-warning" style="position: absolute;right: 10px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
			<h3>订单信息</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="ibox float-e-margins">
				<div class="" style="position: relative;">
					<h3>订单号${order.orderNo }</h3>
				</div>
				<div class="ibox-content">
					<div class="row">
						<div class="col-sm-12" >
							<form id="orderSubForm" action="${ctx}/base/order/saveprice">
							
								<div class="row">
									<div class="col-sm-12 pad-10-k" ><span style="color: #048dd3;font-size: 20px;font-weight: bold;">预定的场地名称：${order.hotelName }</span></div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage">基本信息</span></div>
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
										<div class="col-sm-6 pad-10 placePrice">
											<c:forEach items="${site.bookingRecordModels }" varStatus="bst" var="br">
												<div class="row pad-5">
						                            <div class="col-xs-12 col-md-8">预定档期：${br.placeDate }&nbsp;&nbsp;${br.placeSchedule }</div>
						                            <div class="col-xs-8 col-md-4" style="text-align: right;">
						                            	<%-- <fmt:formatNumber type="currency" value="${br.price }" /> --%>
						                            	￥<input type="number"  style="width: 80px;" value="${br.price }" name="placePrice${br.id}" id="placePrice${br.id}" onkeyup="priceChange('placePrice',this.value)">
						                            </div>
						                            <c:set var="placePrice" value="${placePrice+br.price*br.quantity }"></c:set>
						                        </div>
					                        </c:forEach>
										</div>
									</div>
								</c:forEach>
								
								<div class="row">
									<div class="col-sm-12 pad-10">
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="font-weight: bold;">场地预定价格：<span id="placePrice_txt"><fmt:formatNumber type="currency" value="${placePrice}"/></span></span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span style="font-weight: bold;">场地加收服务费：<fmt:formatNumber type="number" value="${commissionFeeRate }"  maxFractionDigits="0"/>%</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<c:set var="placeSumPrice" value="${placePrice*(1+commissionFeeRate/100) }"></c:set>
												<span style="font-size:16px; font-weight: bold;">小计：<span id="placeSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${placeSumPrice}" /></span></span>
												<input type="hidden" id="commissionFeeRate" name="commissionFeeRate" value="${commissionFeeRate }">
												<input type="hidden" id="placeSumPrice" name="placeSumPrice" value="${placeSumPrice }">
												<input type="hidden" id="placePrice" name="placePrice" value="${placeSumPrice }">
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 pad-10 bottom-line"><span class="bage">住房选择（团房）</span></div>
								</div>
								<c:set var="roomPrice" value="0"></c:set>
								<c:forEach items="${rooms }" varStatus="st" var="room">
								<div class="row">
									<div class="col-sm-6 pad-10">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
										<div class="row pad-5">
											<c:if test="${rst.index eq 0 }">
												<div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${room.placeName }</span></div>
											</c:if>
											<c:if test="${rst.index ne 0 }">
												<div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;"></span></div>
											</c:if>
				                            
				                            <div class="col-xs-12 col-md-9">
					                            <span style="color: #019FEA;font-weight: bold;">
						                            ${room.roomType  }&nbsp;&nbsp;
						                            ${(empty room.breakfast or room.breakfast eq 0)?'无早':'有早' }&nbsp;&nbsp;
						                            ${room.network}&nbsp;&nbsp;
						                            ×&nbsp;<input type="number" class="num"  style="width: 80px;border: 1px solid #019FEA;" value="${br.quantity }" name="roomQuantity${br.id}" id="roomQuantity${br.id}" onkeyup="priceChange('roomPrice',this.value)">&nbsp;间
					                            </span>
				                            </div>
				                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-6 pad-10 roomPrice">
										<c:forEach items="${room.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
					                            <div class="col-xs-12 col-md-6">入住时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-6" style="text-align: right;">
					                            	￥<input type="number" class="price"  style="width: 80px;" value="${br.price }" name="roomPrice${br.id}" id="roomPrice${br.id}" onkeyup="priceChange('roomPrice',this.value)">
					                            	/间
					                            </div>
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
												<span style="font-weight: bold;">住房预定价格：<span id="roomPrice_txt"><fmt:formatNumber type="currency" value="${roomPrice}" /></span></span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:16px; font-weight: bold;">小计：<span id="roomSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${roomPrice }" /></span></span>
												<input type="hidden" id="roomSumPrice" name="roomSumPrice" value="${roomPrice }">
												<input type="hidden" id="roomPrice" name="roomPrice" value="${roomPrice }">
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
					                            	<div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;">${meal.placeName}</span></div>
												</c:if>
												<c:if test="${rst.index ne 0 }">
													<div class="col-xs-6 col-md-3"><span style="color: #019FEA;font-weight: bold;"></span></div>
												</c:if>
					                            
					                            <div class="col-xs-12 col-md-9">
						                            <span style="color: #019FEA;font-weight: bold;">
							                            ${meal.mealType eq '01'?'围餐':'自助餐'}&nbsp;&nbsp;
							                            ${br.placeSchedule }&nbsp;&nbsp;
							                            ×&nbsp;<input type="number" class="num"  style="width: 80px;border: 1px solid #019FEA;" value="${br.quantity }" name="mealQuantity${br.id}" id="mealQuantity${br.id}" onkeyup="priceChange('mealPrice',this.value)">&nbsp;
							                            ${meal.mealType eq '01'?'围':'个'}
						                            </span>
					                            </div>
					                        </div>
				                        </c:forEach>
									</div>
									<div class="col-sm-6 pad-10 mealPrice">
										<c:forEach items="${meal.bookingRecordModels }" varStatus="rst" var="br">
											<div class="row pad-5">
					                            <div class="col-xs-12 col-md-6">用餐时间：${br.placeDate }</div>
					                            <div class="col-xs-12 col-md-6" style="text-align: right;">
					                               	￥<input type="number" class="price"  style="width: 80px;" value="${br.price }" name="mealPrice${br.id}" id="mealPrice${br.id}" onkeyup="priceChange('mealPrice',this.value)">
					                          		 /${meal.mealType eq '01'?'围':'个'}
					                            </div>
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
												<span style="font-weight: bold;">用餐预定价格：<span id="mealPrice_txt"><fmt:formatNumber type="currency" value="${mealPrice }" /></span></span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:16px; font-weight: bold;">小计：<span id="mealSumPrice_txt" style="color: red;"><fmt:formatNumber type="currency" value="${mealPrice}" /></span></span>
												<input type="hidden" id="mealSumPrice" name="placeSumPrice" value="${mealPrice }">
												<input type="hidden" id="mealPrice" name="placePrice" value="${mealPrice }">
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-sm-12 pad-10" style="background: #f5f5f5;">
										<div class="row pad-5">
											<div class="col-md-6">
												<span style="font-size:16px;font-weight: bold;">总计：<span id="amount_txt"><fmt:formatNumber type="currency" value="${mealPrice+roomPrice+placeSumPrice }" /></span></span>
											</div>
											<div class="col-md-6" style="text-align: right;">
												<span style="font-size:16px;font-weight: bold;color: red;">在线支付订金即掌柜<span id="amount_txt"><fmt:formatNumber type="number" value="${order.zgdiscount/10 }" /></span>折特惠价</span>
											</div>
										</div>
										<div class="row pad-5">
											<div class="col-md-12">
												<span style="font-size:22px; font-weight: bold;color: red;">掌柜预算：<span id="zgamount_txt"><fmt:formatNumber type="currency" value="${(mealPrice+roomPrice+placeSumPrice)*order.zgdiscount/100 }" /></span></span>
											</div>
										</div>
										<input type="hidden" id="amount" name="amount" value="${mealPrice+roomPrice+placeSumPrice }">
										<input type="hidden" id="zgamount" name="zgamount" value="${(mealPrice+roomPrice+placeSumPrice)*order.zgdiscount/100}">
										<input type="hidden" id="zgdiscount" name="zgdiscount" value="${order.zgdiscount}">
										<input type="hidden" id="id" name="id" value="${order.id}">
										<input type="hidden" id="orderNo" name="orderNo" value="${order.orderNo}">
									</div>
								</div>
								<c:if test="${ order.state eq '02'}">
								<div class="row">
									<div class="col-sm-12 pad-10" style="text-align: center;">
									
										<button type="button" class="btn btn-primary" style="width: 200px;" onclick="submitOrder()"><span class="glyphicon glyphicon-save"></span>提交保存</button>
									</div>
								</div>
								</c:if>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	function priceChange(type,val){
		if(type==='placePrice'){
			var sumprice = 0;
			$('.placePrice').find("input").each(function(){
				sumprice += $(this).val()*1;
		  	});
			
			var commissionFeeRate = $("#commissionFeeRate").val()*1/100;
			var allprice = sumprice*(1+commissionFeeRate);
			
			$("#placePrice_txt").text("￥"+formatCurrency(sumprice));
			$("#placeSumPrice_txt").text("￥"+formatCurrency(allprice));
			
			$("#placePrice").val(sumprice);
			$("#placeSumPrice").val(allprice);
			
		}else if(type==='roomPrice'){
			var sumprice = 0;
			$('.roomPrice').find(".price").each(function(){
				var id=$(this).attr("id").replace("roomPrice","");
				var num = $("#roomQuantity"+id).val();
				sumprice += $(this).val()*1*num;
		  	});
			$("#roomPrice_txt").text("￥"+formatCurrency(sumprice));
			$("#roomSumPrice_txt").text("￥"+formatCurrency(sumprice));
			$("#roomSumPrice").val(sumprice);
			$("#roomPrice").val(sumprice);
		}else if(type==='mealPrice'){
			var sumprice = 0;
			$('.mealPrice').find(".price").each(function(){
				var id=$(this).attr("id").replace("mealPrice","");
				var num = $("#mealQuantity"+id).val();
				sumprice += $(this).val()*1*num;
		  	});
			$("#mealPrice_txt").text("￥"+formatCurrency(sumprice));
			$("#mealSumPrice_txt").text("￥"+formatCurrency(sumprice));
			$("#mealSumPrice").val(sumprice);
			$("#mealPrice").val(sumprice);
		}
		
		var mealSumPrice = $("#mealSumPrice").val()*1;
		var roomSumPrice = $("#roomSumPrice").val()*1;
		var placeSumPrice = $("#placeSumPrice").val()*1;
		var zgdiscount =  $("#zgdiscount").val()*1;
		$("#amount").val(mealSumPrice+roomSumPrice+placeSumPrice);
		$("#zgamount").val((mealSumPrice+roomSumPrice+placeSumPrice)*zgdiscount/100);
		$("#amount_txt").text("￥"+formatCurrency(mealSumPrice+roomSumPrice+placeSumPrice));
		$("#zgamount_txt").text("￥"+formatCurrency((mealSumPrice+roomSumPrice+placeSumPrice)*zgdiscount/100));
	}
	
	function cfmFun(title, text, type, url, data,msg) {
		swal({
			title : title,
			text : text,
			type : "warning",
			showCancelButton : true,
			cancelButtonText : "取消",
			confirmButtonColor : "#DD6B55",
			confirmButtonText : type,
			closeOnConfirm : false,
			showLoaderOnConfirm : true
		}, function(isConfirm) {
			if (isConfirm) {
				parent.show();
				$.post(url, data, function(res, status) {
					if (status == "success" && res.statusCode == "200") {
						swal(res.message, msg, "success");
						location.href='${ctx}/base/order/detail/${order.id}';
					} else {
						swal(res.message, "error");
					}
					parent.hide();
				}, 'json');
			} else {
				swal("已取消", "您取消了"+type+"操作！", "error")
			}
		});
	}
	
	function submitOrder(){
		var title = "您确定要提交该订单吗";
		var text = "";
		var url = $("#orderSubForm").attr("action");
		var data = $("#orderSubForm").serialize();
		var msg = "您已经提交修改了该订单报价，请尽快与客户联系吧。";
		cfmFun(title,text,'提交',url,data,msg);
	}
</script>
</div>
	

