<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12" style="position: relative;">
				<a href="javascript:loadContent(this,'${ctx}/base/order/evaluate/index/${evaluate.evaluateType}','')" class="btn btn-warning" style="position: absolute;right: 20px;margin-top: 5px;top: 7px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
				<h3>评论详情</h3>
				<hr/>
			</div>
		</div>
		<h3>
		<c:if test="${evaluate.evaluateType eq 'SITE' }">
			<c:if test="${evaluate.itemType eq 'HOTEL' }">${evaluate.itemName}</c:if>
			<c:if test="${evaluate.itemType ne 'HOTEL' }">${evaluate.hotelName}——${evaluate.itemName}</c:if>
		</c:if>
		 <c:if test="${evaluate.evaluateType eq 'PLATFORM' }">
		 	会掌柜场地SAAS平台
		 </c:if>
		  <c:if test="${evaluate.evaluateType eq 'SALE' }">
		 	所在场地：${evaluate.hotelName}
		 </c:if>
		</h3>
		<div style="">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.3rem 1rem;font-size: 14px;">基本评价</div>
		</div>
		<c:if test="${evaluate.evaluateType eq 'SITE' }">
			<div style="border-top:1px solid #f5f5f5;font-size: 12px;padding: 0.3rem 1rem;">
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						商品评价：
						<div class="icon-start icon-start-size-${evaluate.goodsEvaluation }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;" >
						响应速度：
						<div class="icon-start icon-start-size-${evaluate.responseSpeed }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						服务态度：
						<div class="icon-start icon-start-size-${evaluate.attitude }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;" >
						设施评价：
						<div class="icon-start icon-start-size-${evaluate.facilities }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						卫生评价：
						<div class="icon-start icon-start-size-${evaluate.hygiene }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;" >
						位置评价：
						<div class="icon-start icon-start-size-${evaluate.location }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						服务评价：
						<div class="icon-start icon-start-size-${evaluate.service }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${evaluate.evaluateType eq 'PLATFORM' }">
			<div  style="border-top:1px solid #f5f5f5;font-size: 0.85rem;">
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						平台体验感：
						<div class="icon-start icon-start-size-${evaluate.goodsEvaluation }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;" >
						公司跟进服务：
						<div class="icon-start icon-start-size-${evaluate.responseSpeed }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
				<div class="one-list-ct-sett" style="margin:0.5rem 0;">
					<div class="eva-star-parent" style="float: none;"  >
						获取优惠：
						<div class="icon-start icon-start-size-${evaluate.attitude }" style="display:inline-block;" >
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${evaluate.evaluateType eq 'SALE' }">
			<div  style="border-top:1px solid #f5f5f5;font-size: 12px;padding: 1rem;">
				<div style="width: 60%;display: flex;justify-content:space-between;width: 40%;">
					<div  style="font-size: 1rem;font-weight: bold;">${evaluate.saleName }</div>
					<div>${evaluate.salePosition }</div>
					<div>${evaluate.saleMobile }</div>
				</div>
			</div>
		</c:if>
		<div style="margin-top: 1rem;">
			<div class="btn btn-xs bg-none-00" style="margin:0.5rem 0;padding: 0.3rem 1rem;font-size: 14px;">综合评价</div>
		</div>
		
		<div  style="border-top:1px solid #f5f5f5;font-size: 0.85rem;padding: 1rem;">
			<div class="one-list-ct-sett" style="color: #5f5f5f;display: flex;justify-content:space-between;margin: 1rem;">
				<div class="eva-star-parent"  >
					星评：
					<div class="icon-start icon-start-size-${evaluate.comprehensive }" style="display:inline-block;" >
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
						<i class="fa fa-star"></i>
					</div>
				</div>
			</div>
			<div class="one-list-ct-sett" style="color: #5f5f5f;display: flex;justify-content:space-between;margin: 1rem;width: 40%;">
				<div>评论人员：${evaluate.userName }</div>
				<div>评论日期：${dUs.toDay(evaluate.evaluateDate)}</div>
				<c:if test="${empty evaluate.replyContent}">
				<div qx="evaluate:update" id="reply-btn"  class="btn btn-primary">回复</div>
				</c:if>
			</div>
			<div class="one-list-ct-sett" style="font-size: 12px;color: #5f5f5f;margin: 1rem;">
				${evaluate.econtent}
			</div>
			<c:if test="${not empty evaluate.replyContent}">
				<div class="one-list-ct-sett" style="font-size: 12px;color: red;margin: 1rem;">
					回复：“${evaluate.replyContent}”
				</div>
			</c:if>
		</div>
		
	</div>
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="evaluate_reply_div" class="div-tips-dialog" style="top:30%;left:3%;padding:1rem 2%;width:90%;text-align:left;display:none;">
		<!-- <div  style="text-align:center;line-height: 1.5rem;position: relative;">
 			<div style="color: 5f5f5f;font-size: 1rem;text-align: center;font-weight:bold;font-size:1.0rem;">评论回复</div>
 			<div id="btn_evaluate_reply_close" class="icon-close"  style="position: absolute;right: 0;top: 0;">&nbsp;</div>
 			<div style="clear: both;"></div>
 		</div> -->
		<form id="evaluate_reply_form" class="form-horizontal m-t" method="post" action="${ctx}/weixin/order/evaluate/reply/save">
			<div style="padding: 2%;">
				<input type="hidden" id="id" name="id" value="${evaluate.id }">
				<div style="padding: 2% 0;">
					<div>回复内容</div>
					<div style="width: 96%;padding: 2% 0;">
						<textarea type="text" id="replyContent" name="replyContent" rows="5" style="width: 100%;"></textarea>
					</div>
				</div>
			</div>
			<div style="display: flex;justify-content: space-between;">
				<button id="btn_cancel" type="button" class="btn btn-primary" style="margin:0 auto;border-radius:3px;width: 40%;" >取消</button>
				<button id="btn_sure" type="submit" class="btn btn-primary" style="margin:0 auto;border-radius:3px;width: 40%;" >确认回复</button>
			</div>
		</form>
		
	</div>
	<script>
	$(function(){
		common.pms.init();
		$("#reply-btn").click(function(){
			$("#mask-full-screen").show();
			$("#evaluate_reply_div").show();
		});
		$("#btn_evaluate_reply_close").click(function(){
			$("#mask-full-screen").hide();
			$("#evaluate_reply_div").hide();
			$("#replyContent").text('');
		});
		
		$("#btn_cancel").click(function(){
			$("#mask-full-screen").hide();
			$("#evaluate_reply_div").hide();
			$("#replyContent").text('');
		});
		
	});
	
	$().ready(function() {
	    var e = "<i class='fa fa-times-circle'></i> ";
		$("#evaluate_reply_form").validate({
			rules:{
				replyContent:"required"
			},
			messages:{
				replyContent:"请输入回复内容"
			},
	        submitHandler: function(form) {
	            var url = $(form).attr("action");
	            var data = $(form).serialize();
	            parent.show();
	       　		$.post(url, data, function (res, status) { 
	       　			if(status=="success"&&res.statusCode=="200"){
	       　				swal(res.message, "success");
	       　				loadContent(this,'${ctx}/base/order/evaluate/detail/${evaluate.id }','');
	       　			}else{
	       　				swal(res.message, "error");
	       　			}
	       　			parent.hide();
	       　		}, 'json'); 
	         }  
	    });
		
	});
	</script>