<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
	<style type="text/css">
		.priceAdjusts{
			border-bottom: 1px solid #cccccc;
		}
		.priceAdjusts:last-child{
			border: 0;
		}
	</style>
<div class="wrapper wrapper-content">
	<div class="row">
		<div class="col-sm-12" style="position: relative;">
			<a href="javascript:loadContent(this,'${ctx}/base/hotel/price/trial/index','')" class="btn btn-warning" style="position: absolute;right: 20px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
			<h3>报价详情</h3>
			<hr/>
		</div>
	</div>
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div style="position: relative;">
		<input type="hidden" id="id" name="id" value="${priceTrial.id }">
		<input type="hidden" id="placeId" name="placeId" value="${priceTrial.placeId }">
		<input type="hidden" id="hotelId" name="hotelId" value="${priceTrial.hotelId }">
		<input type="hidden" id="adjustSdate" name="adjustSdate" value="${priceTrial.applyDate }">
		<input type="hidden" id="state" name="state" value="${priceTrial.state }">
		<input type="hidden" id="checktype" name="checktype" value="${checktype }">
		<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
			<div style="font-size: 14px;font-weight: bold;">申请日期：${dUs.toDay(priceTrial.applyDate) }</div>
		</div>
		<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
			<div style="font-size: 14px;font-weight: bold;">审核状态：
			<c:choose>
				<c:when test="${priceTrial.state eq '0' }">
					等待会掌柜销售初审
				</c:when>
				<c:when test="${priceTrial.state eq '1' }">
					等待会掌柜终审
				</c:when>
				<c:when test="${priceTrial.state eq '2' }">
					审核通过
				</c:when>
				<c:when test="${priceTrial.state eq '3' }">
					会掌柜销售不通过！
				</c:when>
				<c:when test="${priceTrial.state eq '4' }">
					会掌柜终审不通过！
				</c:when>
				</c:choose>
			</div>
		</div>
		<c:if test="${priceTrial.state ne '0' }">
		<div style="background-color: #f5f5f5;padding:10px;">审核情况</div>
		</c:if>
		<c:if test="${priceTrial.state ne '0' }">
			<div style="font-size: 0.8rem;">
				<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
					<div>初审日期：${priceTrial.trialDate }</div>
				</div>
				<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
					<div>初审人员：${priceTrial.trialUserName }</div>
				</div>
				<c:if test="${priceTrial.state eq '3' }">
					<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
						<div>初审不通过原因：${priceTrial.trialReason }</div>
					</div>
				</c:if>
			</div>
		</c:if>
		<c:if test="${priceTrial.state gt '1' }">
			<div style="font-size: 0.8rem;">
				<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
					<div>复审日期：${priceTrial.finalDate }</div>
				</div>
				<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
					<div>复审人员：${priceTrial.finalUserName }</div>
				</div>
				<c:if test="${priceTrial.state eq '4' }">
					<div style="border-bottom: 1px solid #f5f5f5;padding:10px;">
						<div>复审不通过原因：${priceTrial.finalReason }</div>
					</div>
				</c:if>
			</div>
		</c:if>
		
		<div style="background-color: #f5f5f5;padding:10px;">报价情况</div>
		<div>
		<c:forEach items="${priceAdjusts}" var="priceAdjust">
			<div class="priceAdjusts" style="padding:0 3%;">
				<div style="margin-top:16px;">
					<div class="btn btn-xs" style="padding: 3px 20px;font-size: 16px;font-weight: bold;color:#019FEA;border: 1px solid #019FEA; float: left;">${priceAdjust.placeName }</div>
					<div style="font-size: 16px;font-weight: bold;padding: 3px 20px; float: left;margin-left: 10px;">日期：${priceAdjust.adjustSdate }</div>
					<div style="clear: both;">
					
					</div>
				</div>
				
				<div style="font-size: 12px;">
					<div style="font-size: 14px;font-weight: bold;margin: 0.5rem 0;">线上价格</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="currency" value="${priceAdjust.onlinePriceBefore }" /></div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="currency" value="${priceAdjust.onlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: #FFB42B;"><fmt:formatNumber type="number" value="${priceAdjust.onlinePriceRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div style="font-size: 12px;">
					<div style="font-size: 14px;font-weight: bold;margin: 0.5rem 0;">线下价格</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="currency" value="${priceAdjust.offlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="currency" value="${priceAdjust.offlinePriceAfter }" /></div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: #FFB42B;"><fmt:formatNumber type="number" value="${priceAdjust.offlinePriceRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
				<div style="font-size: 12px;">
					<div style="font-size: 14px;font-weight: bold;margin: 0.5rem 0;">线上、线下调整比</div>
					<div style="width: 100%;margin: 0.5rem 0;">
						<div style="width: 33%;float: left;">调整前：<fmt:formatNumber type="number" value="${priceAdjust.priceBeforeRate }"  maxFractionDigits="2"/>%</div>
						<div style="width: 33%;float: left;">调整后：<fmt:formatNumber type="number" value="${priceAdjust.priceAfterRate }"  maxFractionDigits="2"/>%</div>
						<div style="width: 33%;float: left;">调整比例：<span style="color: red;"><fmt:formatNumber type="number" value="${priceAdjust.adjustRate }"  maxFractionDigits="2"/>%</span></div>
						<div style="clear: both;"></div>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		
		<c:if test="${checktype ne 'NONE' }">
			<div style="padding: 8px 0;text-align: center;width: 100%;background-color: #ffffff;position:fixed;bottom: 0;">
				<div qx="hotel-price-adjust:check" id="nopass_btn" class="btn btn-primary" style="padding: 10px;font-size: 14px;font-weight: bold;color:#019FEA;border: 1px solid #019FEA;background-color: #ffffff;width: 30%; ">审核不通过</div>
				<div qx="hotel-price-adjust:check" id="pass_btn" class="btn btn-primary" style="padding: 10px;font-size: 14px;font-weight: bold;width: 30%;">审核通过</div>
			</div>
			<div id="offline_check_no_div" class="div-tips-dialog" style="left:35%;padding:16px;width:500px;text-align:left;display:none;">
				<div  style="text-align:center;line-height: 1.5rem;position: relative;padding: 0.5rem 0;">
					<div style="color: #000000;">不通过原因</div>
					<div id="offline_check_no_ic_close" class="icon-close" style="position: absolute;top: -0.5rem;right: 0;">&nbsp;</div>
					<input id="tostate" name="tostate" type="hidden" value="">
		 		</div>
				<div style="padding:0 2%;" >
					<textarea id="reason" rows="15" cols="" style="width: 97%;border: none;background-color: #f5f5f5;" placeholder="请输入不通过原因"></textarea>
				</div>
				
				<div class="display-flex" style="padding: 1rem 0;text-align: right;">
					<div id="btn_offline_check_no_cansel" class="btn btn-primary" style="padding:5px 12px;width: 30%;" >再考虑</div>
					<div id="btn_offline_check_no_sure" class="btn btn-primary" style="padding:5px 12px;width: 30%;" > 确定</div>
				</div>
			</div>	
		</c:if>
	</div>
</div>


<script>
$(function(){
	//alert(window.location.hash);
	//window.addEventListener("hashchange", func, false);
	common.pms.init();
	$("#nopass_btn").click(function(){
		show()
		$("#offline_check_no_div").show();
	});
	
	$("#offline_check_no_ic_close").click(function(){
		hide();
		$("#offline_check_no_div").hide();
	});
	
	$("#btn_offline_check_no_cansel").click(function(){
		hide();
		$("#offline_check_no_div").hide();
	});
	
	$("#btn_offline_check_no_sure").click(function(){
		var checkType = $("#checktype").val();
		var reason = $("#reason").val();
		show();
		$.post('${ctx}/weixin/hotel/price/adjust/nopasscheck/${priceTrial.id }',{checkType:checkType,reason:reason},function(res){
			if(res.statusCode=="200"){
				swal(res.message, "success");
				loadContent(this,'${ctx}/base/hotel/price/trial/detail/${priceTrial.id }','RD');
			}else{
				swal(res.message, "error");
			}
			hide();
		},"json");
	});
	$("#pass_btn").click(function(){
		var checkType = $("#checktype").val();
		show();
		$.post('${ctx}/weixin/hotel/price/adjust/passcheck/${priceTrial.id }',{checkType:checkType},function(res){
			if(res.statusCode=="200"){
				swal(res.message, "success");
				loadContent(this,'${ctx}/base/hotel/price/trial/detail/${priceTrial.id }','RD');
			}else{
				swal(res.message, "error");
			}
			hide();
		},"json");
	});
});
function disabledScroll(event){
	 event.preventDefault();
};
</script>

</html>
