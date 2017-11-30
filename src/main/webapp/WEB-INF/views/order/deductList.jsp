<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>提成统计</h3>
	<hr>
	<form class="form-inline" id="reconciliation_searchForm">
	  <div class="form-group">
	  		 <label for="state">地区</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_LIKE_o.area" >
				<tags:dict sql="SELECT region_name id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<%--<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="state">返佣状态</label>
	   		<select class="form-control" name="search_EQ_o.commission_status" >
				<tags:dict sql="SELECT code as id,detail as name FROM hui_sys_dict where kind='06' order by code "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select>  --%>
			<label for="orderNo">订单编号</label>
	   		<input type="text" class="form-control" id="orderNo" name="search_EQ_o.order_no" placeholder="请输入订单流水号">
			<!-- <label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话"> -->
	   		
	   		<label for="gcreate_date">日期</label>
	   		<input type="date" class="form-control" id="gcreate_date" name="search_GTE_o.commission_date" placeholder="">
	   		~
	   		<input type="date" class="form-control" id="lcreate_date" name="search_LTE_o.commission_date" placeholder="">
		  	<button type="button" class="btn btn-primary" onclick="reconciliation_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	 	</div>
		<input type="hidden" name="saleId" value="${groupMap.iscompanysales?guserId:'' }" />
		<input type="hidden" name="search_OR_EQ;o.state" value="06,07" /> 
		<input type="hidden" name="search_EQ_o.commission_status" value = "07"  /> 
	</form>
	<br>
	<table id="reconciliation_table" data-toggle="table" data-height="600" data-query-params="reconciliation_queryParams"
		data-pagination="true" data-url="${ctx}/weixin/order/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="orderNo">订单编号</th>
				<th data-field="area">所属城市</th>
				<th data-field="hotelName">场地名称</th>
				<th data-field="activityDate">活动时间</th>
				<th data-field="activityTitle">活动名称</th>
				<th data-field="amount" data-formatter="fm_order_amount" data-align="right">提成金额</th>
				<!-- <th data-field="state" data-formatter="fm_reconciliation_state">订单状态</th> -->
				<th data-formatter="fm_reconciliation_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<c:if test="${not empty res }">
	<div style="background-color: #f5f5f5;">
		<div style="color: #5f5f5f;margin: 0 2%; padding: 0.5rem 0;">合计情况：</div>
		<div style="background-color: #019FEA;color: #ffffff; padding: 0.5rem 0;">
			<div style="margin: 0.3rem 3%;display: flex;justify-content: space-between;">
				<span style="width: 50%;">累计返佣金额：${res.settlement }</span>
				<span style="width: 50%;">累计提成金额：${res.comission }</span>
			</div>
		</div>
	</div>
	</c:if>
</div>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script>
function fm_reconciliation_state(value,row, index){
	return dict.trsltDict('05',value);
}
function fm_reconciliation_operate(value,row, index){
	var btnhtml = "";
	btnhtml+='<a href="javascript:loadContent(this,\'${ctx}/weixin/order/deduct/detail/'+row.id+'\',\'\');" class="btn btn-primary" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
	//btnhtml+='&nbsp;&nbsp;<button type="button" onclick="reconciliation_accept_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 确认返佣</button>';
	return btnhtml;
}

function fm_order_amount(value,row, index){
	return common.formatCurrency(value);
}

function reconciliation_queryParams(params){
	return $.extend({},params,util.serializeObject($('#reconciliation_searchForm')));
}

function reconciliation_search(){
	$("#reconciliation_table").bootstrapTable("refresh");
}
$(function(){
	common.ctx ='${ctx}';
	dict.init();
	common.pms.init();
	$("#reconciliation_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	$('.selectpicker').selectpicker();
	/* $("#reconciliation_table").bootstrapTable();
	$('.selectpicker').selectpicker(); */
});

</script>