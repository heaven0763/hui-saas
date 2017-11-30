<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div  class="modal-body">
    <link href="${ctx}/static/weixin/css/place.price.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
    <style type="text/css">
		.date-icon-left, .date-icon-right {
		    background-repeat: no-repeat;
		    background-size: 13px;
		}
		.icon-search{ background-repeat: no-repeat;background-size: 20px;width: auto;}
		.date-icon-left {
		    display: table-cell;
		    width: 20px;
		    height: 34px;
		    line-height: 34px;
		}
		.date-icon-right {
		    display: table-cell;
		    width: 20px;
		    height: 34px;
		    line-height: 34px;
		}
		.date-icon-checked{background-size:28px; }
		.date-picker-week-one{text-align: center;}
	</style>
   <div class="row">
		<div class="col-sm-12" style="position: relative;">
		 	<div id="place_date_price_div">
		 		<form id="form_place_date_price_list" class="form_place_date_price_list" style="display:none;">
		 			<input type="hidden" id="search_EQ_placeId" name="search_EQ_placeId"  />
		 			<input type="hidden" id="search_GTE_onlinePrice"  name="search_GTE_placeSchedule"  />
		 			<input type="hidden" id="search_LTE_onlinePrice" name="search_LTE_placeSchedule"  />
		 			<input type="hidden" id="ptrialId" name="${priceTrial.placeId}"  />
		 		</form>
		 		<input type="hidden" id="date_year_month" value="${date_year_month }"  />
		 		<input type="hidden" id="year_months" value="${year_months }"  /> 
		 		<div style="position: relative;">
					<div class="place_date_title" style="text-align: center;font-size:1rem;">${priceTrial.placeName}——${priceTrial.priceType eq 'on'?'系统销售价格调整审核':'线下合作销售价格调整审核' }</div>
				</div>
				<div>
			 		<div style="height:2rem;line-height:2rem;margin-top:1rem;text-align: center;display:flex;justify-content:space-between;">
			 			<div class="date-icon-left" style="display:table-cell;width:5%;">&nbsp;</div>
			 			<div style="font-size:1rem;"><span class="place_year_month">2017年1月</span><span class="place_date_month" >January</span></div>
			 			<div class="date-icon-right" style="display:table-cell;width:5%">&nbsp;</div>
			 		</div>
			 		<div style="display:flex;justify-content:space-between;font-size:0.75rem;width:95%;margin:0.5rem; auto;">
			 			<div class="date-picker-week-one" style="">Sun</div>
			 			<div class="date-picker-week-one" style="">Mon</div>
			 			<div class="date-picker-week-one" style="">Tue</div>
			 			<div class="date-picker-week-one" style="">Wed</div>
			 			<div class="date-picker-week-one" style="">Thu</div>
			 			<div class="date-picker-week-one" style="">Fri</div>
			 			<div class="date-picker-week-one" style="">Sat</div>
			 		</div>
	
					<div class="date-picker-ct">
					</div>
				</div>
		 	</div>
   
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12" style="border-top: 1px solid #f5f5f5;">
		<input type="hidden" id="checktype" name="checktype" value="${checktype }">
		<input type="hidden" id="nypriceType" name="priceType" value="${priceTrial.priceType}">
		<c:if test="${checktype ne 'NONE' }">
			<div style="padding: 8px 0;text-align: center;width: 100%;background-color: #ffffff;">
				<div qx="hotel-price-adjust:check" id="nopass_btn" class="btn btn-primary" style="padding: 10px;font-size: 14px;font-weight: bold;color:#019FEA;border: 1px solid #019FEA;background-color: #ffffff;width: 30%; ">审核不通过</div>
				<div qx="hotel-price-adjust:check" id="pass_btn" class="btn btn-primary" style="padding: 10px;font-size: 14px;font-weight: bold;width: 30%;">审核通过</div>
			</div>
			<div id="offline_check_no_div" class="div-tips-dialog" style="left:20%;padding:16px;width:500px;text-align:left;display: none;border: 1px solid #f5f5f5;">
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
	<div class="modal-footer">
		<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	</div>
	<script src="${ctx}/static/weixin/myjs/place.price.check.js"></script>
	<script>
		$(function(){
			common.ctx =  '${ctx}';
			var currPlacePriceDate = new placePriceDate({
					initCallBack : function(){
				}
			});
			
			currPlacePriceDate.options.place_id = '${priceTrial.placeId}';
			currPlacePriceDate.options.place_name ='${priceTrial.placeName}';
			currPlacePriceDate.options.priceTrial ='${priceAdjusts}';
			currPlacePriceDate.options.priceType='${priceTrial.priceType}';
			currPlacePriceDate.init({		
			});
			
			
			common.pms.init();
			$("#nopass_btn").click(function(){
				$("#offline_check_no_div").show();
			});
			
			$("#offline_check_no_ic_close").click(function(){
				$("#offline_check_no_div").hide();
			});
			
			$("#btn_offline_check_no_cansel").click(function(){
				$("#offline_check_no_div").hide();
			});
			
			$("#btn_offline_check_no_sure").click(function(){
				var checkType = $("#checktype").val();
				var reason = $("#reason").val();
				show();
				$.post('${ctx}/weixin/hotel/price/adjust/nopasscheck/${priceTrial.id }',{checkType:checkType,reason:reason},function(res){
					if(res.statusCode=="200"){
						swal(res.message, "success");
						priceTrial_search();
						hide();
						$("#close_btn").click();
					}else{
						swal(res.message, "error");
						hide();
					}
					
				},"json");
			});
			$("#pass_btn").click(function(){
				var checkType = $("#checktype").val();
				show();
				 $.post('${ctx}/weixin/hotel/price/adjust/passcheck/${priceTrial.id }',{checkType:checkType},function(res){
					if(res.statusCode=="200"){
						swal(res.message, "success");
						priceTrial_search();
						hide();
						$("#close_btn").click();
						$("#offline_check_no_div").hide();
					}else{
						swal(res.message, "error");
					}
					hide();
				},"json"); 
			});
		})
	</script>
</div>