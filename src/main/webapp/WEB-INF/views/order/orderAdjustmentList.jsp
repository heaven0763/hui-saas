<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>订单状态确认</h3>
	<hr>
	<form class="form-inline" id="order_searchForm">
	  <div class="form-group">
			<label for="orderNo">订单编号</label>
	   		<input type="text" class="form-control" id="orderNo" name="search_EQ_o.order_no" placeholder="请输入订单流水号">
	   		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="organizer">活动主办单位</label>
	   		<input type="text" class="form-control" id="organizer" name="search_LIKE_o.organizer" placeholder="请输入活动主办单位">
			<label for="linkman">联系人</label>
	   		<input type="text" class="form-control" id="linkman" name="search_LIKE_o.linkman" placeholder="请输入联系人">
			<label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话">
		  <button type="button" class="btn btn-primary" onclick="refund_order_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	  <input id="search_state" type="hidden" name="search_OR_EQ;o.state" value="04,06,11" /> 
	</form>
	<br>
	<div class="table-responsive">
	<table id="refund_order_table" class="text-nowrap" data-toggle="table" data-height="660" data-query-params="order_queryParams"
		data-pagination="true" data-url="${ctx}/weixin/order/list" data-data-type="json">
	    <thead>
	        <tr>
        		<th data-formatter="fm_order_operate"  style="word-break:break-all; word-wrap:break-all;">操作</th> 
				<th data-field="orderNo" data-formatter="fm_order_orderNo">订单编号</th>
				<th data-field="state" data-formatter="fm_order_state">订单状态</th>
				<th data-field="settlementStatus" data-formatter="fm_order_settlementStatus">结算状态</th>
				<th data-field="activityDate" style="word-break:break-all; word-wrap:break-all;">活动日期</th>
				<th data-field="amount" data-align="right" data-formatter="fm_order_amount">金额</th>
				<th data-field="prepaid" data-align="right" data-formatter="fm_order_amount">已交订金</th>
				<th data-field="refundAmount" data-align="right" data-formatter="fm_order_amount">退款金额</th>
				<th data-field="activityTitle" data-formatter="fm_order_activityTitle"  style="word-break:break-all; word-wrap:break-all;">活动名称</th>
				<th data-field="hotelSaleName">销售姓名</th>
				<th data-field="linkman">联系人</th>
				<th data-field="contactNumber">联系电话</th>
				<!-- <th data-field="organizer">活动主办单位</th> -->
				<!-- 	
				<th data-field="area">区域</th>
				<th data-field="createDate">创建时间</th>-->
			
	        </tr>
	    </thead>
	</table>
	</div>
</div>
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
<script>
function fm_order_orderNo(value,row, index){
	return '<a href="javascript:loadContent(this,\'${ctx}/base/order/detail/'+row.id+'\',\'\');"  title="详情">'+value+'</a>';
}
function fm_order_operate(value,row, index){
	var btnhtml = "";
	if(row.state=='11'){
		btnhtml+='&nbsp;&nbsp;<button qx="venue-station:update" type="button" onclick="agree(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-ok"></span> 同意退款</button>';
		btnhtml+='&nbsp;&nbsp;<button qx="venue-station:update" type="button" onclick="rejectOpenForm(\''+row.id+'\')" class="btn btn-warning btn-sm"><span class="glyphicon glyphicon-share-alt"></span> 拒绝退款</button>';
	}else if((row.state=='04' || row.state=='06') && row.settlementStatus < '04' ){
		btnhtml+='&nbsp;&nbsp;<button qx="venue-station:update" type="button" onclick="cfmSettlement(\''+row.id+'\')" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-ok"></span> 确认收款</button>';
	}
	return btnhtml;
}
function cfmSettlement(id){
	cfm_swal("您确认该订单已收款！","","warning","确认收款", "确认收款申请完成。","您取消了该操作！"
			,'${ctx}/weixin/order/state/'+id,{tostate:5},function(){
				refund_order_search();
	});
}
function fm_order_amount(value,row, index){
	return common.formatCurrency(value);
}
function fm_order_activityTitle(value,row, index){
	return '<div style="width: 150px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;" title="'+value+'">'+value+'</div>';
}
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
function fm_order_state(value,row, index){
	if(value==='01'||value==='02'||value==='04'||value==='09'||value==='11'){
		return '<span class="label label-danger">'+dict.trsltDict('05',value)+'</span>';
	}else if(value==='06'||value==='07'){
		return '<span class="label label-success">'+dict.trsltDict('05',value)+'</span>';
	}else{
		return '<span class="label label-default">'+dict.trsltDict('05',value)+'</span>';
	}
}
function fm_order_settlementStatus(value,row, index){
	return dict.trsltDict('07',value);
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
			refund_order_search();
			rejectCloseForm()
		}else{
			swal(res.message,'error');
			$("#offline_check_no_div").show();
		}
	},'json'); 
}
function agree(id){
	
	cfm_swal("您确定同意该笔退款申请！","","warning","同意", "同意退款申请完成。","您取消了该操作！"
			,'${ctx}/weixin/order/site/adjustment/agree',{id:id},function(){
				refund_order_search();
	});
	/* show();
	$.post('${ctx}/weixin/order/site/adjustment/agree',{id:id},function(res){
		if(res.statusCode=='200'){
			swal(res.message,'success');
			order_search();
		}else{
			swal(res.message,'error');
		}
		hide();
	},'json'); */
}
/* function fm_order_state(value,row, index){
		return dict.trsltDict('05',value);
} */

function order_queryParams(params){
	return $.extend({},params,util.serializeObject($('#order_searchForm')));
}

function refund_order_search(){
	$("#refund_order_table").bootstrapTable("refresh");
}
$(function(){
	
	common.pms.init();
	$("#refund_order_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	$('.selectpicker').selectpicker();
	$('#offline_check_no_ic_close').click(function(){
		 rejectCloseForm();
	});
	$('#btn_offline_check_no_cansel').click(function(){
		 rejectCloseForm();
	});
});

</script>