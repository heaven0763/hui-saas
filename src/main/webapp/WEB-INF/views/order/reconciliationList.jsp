<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<% 
	String type = request.getParameter("type");
	type = (type == null || type.length() == 0)?"1":type;
%>
<div class="wrapper wrapper-content">
	<h3>返佣对账</h3>
	<hr style="margin-top: 5px;margin-bottom: 5px;">
	
	<div class="form-group" style="text-align: center;">
		<button id="fyd_type_1" type="button" onclick="fyd_type_sel(this,'1')" class="btn btn-primary btn-sm" style="width: 48%">对账返佣单</button>
		<button id="fyd_type_2" type="button" onclick="fyd_type_sel(this,'2')" class="btn btn-outline btn-primary btn-sm" style="width: 48%">原始返佣单</button>
		<input type="hidden" id="fyd_type" value="<%=type%>">
	</div>
	<hr style="margin-top: 5px;margin-bottom: 5px;">
	<c:if test="${groupMap.iscompanyfinance ||  groupMap.iscompanyadministrator || groupMap.iscompanysales ||  groupMap.isadministrator }">
		<div class="form-group" style="display::inline-block;">
			<button qx="comission:add" type="button" onclick="order_commission_fun()" class="btn btn-primary"><span class="glyphicon glyphicon-usd"> </span>一键返佣</button>
		</div>
	</c:if>
	
	<form class="form-inline" id="reconciliation_searchForm">
	  <div class="form-group">
	  		<%-- 
	  		<label for="state">地区</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   name="search_LIKE_o.area" >
				<tags:dict sql="SELECT region_name id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话">
	   		<label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话"> 
	   		 --%>
		
			
			<label for="orderNo">订单编号</label>
	   		<input type="text" class="form-control" id="orderNo" name="search_EQ_o.order_no" placeholder="请输入订单流水号">
	   		<label for="gcreate_date">活动日期</label>
	   		<input type="date" class="form-control" id="gcreate_date" name="search_GTE_o.activity_date" placeholder="" value="${_firstDayOfMonth }">
	   		~
	   		<input type="date" class="form-control" id="lcreate_date" name="search_LTE_o.activity_date" placeholder="" value="${_currDayOfMonth }">
	   		<label for="state">返佣状态</label>
	   		<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
		   		<select class="form-control" name="search_EQ_o.commission_status" >
		   			<option value="">请选择</option>
		   			<option value="01">待返佣</option>
		   			<option value="02,03,04">已对账</option>
		   			<option value="05">已收票</option>
		   			<option value="06,07">已付款</option>
	   				<option value="ALL">全部</option>
				</select> 
	   		</c:if>
	   		<c:if test="${aUs.getCurrentUserType() ne 'HOTEL' }">
	   			<select class="form-control" name="search_EQ_o.commission_status" >
		   			<option value="">请选择</option>
		   			<option value="01">待返佣</option>
		   			<option value="02">已对账</option>
		   			<option value="03,04,05,06">已开票</option>
		   			<option value="07">已收款</option>
		   			<option value="ALL">全部</option>
				</select>
	   		</c:if>
<%-- 				<tags:dict sql="SELECT code as id,detail as name FROM hui_sys_dict where kind='06' and code != '00' order by code "  showPleaseSelect="fasle" addBefore=",全部"/> --%>
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<br>
	   			<br>
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
	   		<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' and (groupMap.isgroupadministrator or groupMap.isgroupfinance) }">
				<br>
	   			<br>
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
	   		
	   		
	   		<c:if test="${!groupMap.iscompanysales && ! groupMap.ishotelsales }">
			<label for="reclaim_user_id">销售人员</label>
				<select class="form-control"  data-live-search="true"  id="reclaim_user_id" name="saleId"  data-width="auto" data-size="10" >
					<option value="">全部</option>
					<c:forEach items="${sales}" var="sale">
						<option value="${sale.id }">${sale.rname }</option>
					</c:forEach>
				</select>
			</c:if>
	   		
		    <button type="button" class="btn btn-primary" onclick="reconciliation_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
		<input id="search_saleId" type="hidden" name="saleId" value="${groupMap.iscompanysales or groupMap.ishotelsales?guserId:'' }" />  
		<input id="" type="hidden" name="search_OR_EQ;o.state" value="021,04,06,07" /> 
		<input id="" type="hidden" name="search_NE_o.source_app_id" value="0" /> 
		<input id="" type="hidden" name="order" value="asc,asc" />
		<input id="" type="hidden" name="sort" value="o.commission_status,o.create_date" /> 
	</form>
	<br>
	<div id="dzfyd">
		<table id="reconciliation_table" data-toggle="table" data-height="600" data-query-params="reconciliation_queryParams"
			data-pagination="true" data-url="${ctx}/weixin/order/commission/list" data-data-type="json">
		    <thead>
		        <tr>
					<th data-field="orderNo" data-formatter="fm_reconciliation_orderNo">订单编号</th>
					<c:if test="${aUs.getCurrentUserType() ne 'HOTEL' }">
						<th data-field="hotelName">场地名称</th>
					</c:if>
					<th data-field="activityDate">活动时间</th>
					<th data-field="activityTitle">活动名称</th>
					<th data-field="amount" data-align="right" data-formatter="fm_order_amount">订单金额</th>
					<th data-field="commissionStatus" data-formatter="fm_reconciliation_commissionStatus">返佣状态</th>
					<th data-formatter="fm_reconciliation_operate">操作</th> 
		        </tr>
		    </thead>
		</table>
	</div>
	<div id="ysfyd">
		<table id="ysfyd_reconciliation_table" data-toggle="table" data-height="600" data-query-params="reconciliation_queryParams"
		data-pagination="true" data-url="${ctx}/weixin/order/commission/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="orderNo" data-formatter="fm_oreconciliation_orderNo">订单编号</th>
				<c:if test="${aUs.getCurrentUserType() ne 'HOTEL' }">
					<th data-field="hotelName">场地名称</th>
				</c:if>
				<th data-field="activityDate">活动时间</th>
				<th data-field="activityTitle">活动名称</th>
				<th data-field="amount" data-align="right" data-formatter="fm_order_amount">订单金额</th>
				<th data-formatter="fm_oreconciliation_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	</div>
	<c:if test="${not empty res }">
	<%-- <div style="background-color: #f5f5f5;">
		<div style="color: #5f5f5f;margin: 0 2%; padding: 0.5rem 0;">合计情况：</div>
		<div style="background-color: #019FEA;color: #ffffff; padding: 0.5rem 0;">
			<div style="margin: 0.3rem 3%;display: flex;justify-content: space-between;">
				<span style="width: 50%;">已开具发票：${res.invoice }</span>
				<span style="width: 50%;">已返佣：${res.comission }</span>
			</div>
		</div>
	</div> --%>
	</c:if>
	
	<div class="form-group" style="text-align: center;">
		<a href="${ctx}/base/order/commissionSum" target="dialog" class="btn btn-primary" title="每月返佣汇总" width="1000">汇总统计</a>
	</div>
</div>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>
<script>
function fyd_type_sel(self,type){
	var $this = $(self);
	$("#fyd_type").val(type);
	if("1"===type){
		$this.removeClass("btn-outline");
		$this.next().addClass("btn-outline");
		$("#dzfyd").show();
		$("#ysfyd").hide();
	}else{
		$this.removeClass("btn-outline");
		$this.prev().addClass("btn-outline");
		$("#dzfyd").hide();
		$("#ysfyd").show();
	}
	
	reconciliation_search();
}
function fm_reconciliation_orderNo(value,row, index){
	var $dv = $('<div class="col-md-12" style="position: relative;"></div>');
	$dv.append('<a href="javascript:loadContent(this,\'${ctx}/base/order/reconciliation/detail/'+row.id+'\',\'\');"  title="详情">'+value+'</a>');
	/* if(isReconciliationNew(row)){
		$dv.append('<div class="new"></div>');
	} */
	return $dv.prop("outerHTML");
}
function fm_oreconciliation_orderNo(value,row, index){
	var $dv = $('<div class="col-md-12" style="position: relative;"></div>');
	$dv.append('<a href="javascript:loadContent(this,\'${ctx}/base/order/reconciliation/origindetail/'+row.id+'\',\'\');"  title="详情">'+value+'</a>');
	/* if(isReconciliationNew(row)){
		$dv.append('<div class="new"></div>');
	} */
	return $dv.prop("outerHTML");
}
function isReconciliationNew(row){
	var reconciliationReadOrder = window.sessionStorage.getItem("reconciliationReadOrder${aUs.getCurrentUserId()}");
	if("${groupMap.ishotelsales}"=="true"){
		if(row.commissionStatus==="01"&&row.isupdate==='0'){
			if(reconciliationReadOrder && reconciliationReadOrder.indexOf(row.orderNo)<0){
				return true;
			}
			return false;
		}
	}else if("${groupMap.iscompanysales}"=="true"){
		if((row.commissionStatus==="01"&&row.isupdate==='1')||row.commissionStatus==="03"){
			if(reconciliationReadOrder && reconciliationReadOrder.indexOf(row.orderNo)<0){
				return true;
			}
			return false;
		}
	}else if("${groupMap.ishotelfinance}"=="true"){
		if((row.commissionStatus==="01"&&row.isupdate==='9')||row.commissionStatus==="04"||row.commissionStatus==="05"){
			if(reconciliationReadOrder && reconciliationReadOrder.indexOf(row.orderNo)<0){
				return true;
			}
			return false;
		}
	}else if("${groupMap.iscompanyfinance}"=="true"){
		if(row.commissionStatus==="02"||row.commissionStatus==="06"){
			if(reconciliationReadOrder && reconciliationReadOrder.indexOf(row.orderNo)<0){
				return true;
			}
			return false;
		}
	}
	
	return false;
}
function fm_reconciliation_state(value,row, index){
	return dict.trsltDict('05',value);
}
function fm_order_amount(value,row, index){
	return common.formatCurrency(value);
}
function fm_reconciliation_commissionStatus(value,row, index){
	if(value==='01'){
		return '<span class="label label-danger">'+ dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'=='HOTEL'&&(value==='02'||value==='03'||value==='04')){
		return '<span class="label label-warning">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'=='HOTEL'&&value==='05'){
		return '<span class="label label-success">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'=='HOTEL'&&(value==='06'||value==='07')){
		return '<span class="label label-info">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'!='HOTEL'&&value==='02'){
		return '<span class="label label-warning">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'!='HOTEL'&&(value==='03' || value==='04' || value==='05' || value==='06') ){
		return '<span class="label label-success">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if('${aUs.getCurrentUserType()}'!='HOTEL'&&value==='07'){
		return '<span class="label label-info">'+dict.commissionStatus('${aUs.getCurrentUserType()}',value)+'</span>';
	}else if(value==='00'){
		return '<span class="label label-info">有效订单</span>';
	}
}
function reconciliation_accept_fun(id){
	cfm_swal("您确定要对该订单确认返佣","","warning","确认返佣", "确认返佣完成。","您取消了该操作！"
			,'${ctx}/weixin/order/comission/create',{orderId:id},function(){
		reconciliation_search();
	});
}

function fm_reconciliation_operate(value,row, index){
	var btnhtml = "";
	btnhtml+='<a href="javascript:loadContent(this,\'${ctx}/base/order/reconciliation/detail/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
	if(row.commissionStatus==='00'&&row.activityDate<='${_currDayOfMonth}'){
		<c:if test="${groupMap.iscompanyfinance ||  groupMap.iscompanyadministrator || groupMap.iscompanysales}">
			btnhtml+='&nbsp;&nbsp;<button qx="comission:add" type="button" onclick="order_commission_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-ok"></span> 发起返佣</button>';
		</c:if>
	}
	//
	return btnhtml;
}
function fm_oreconciliation_operate(value,row, index){
	var btnhtml = "";
	btnhtml+='<a href="javascript:loadContent(this,\'${ctx}/base/order/reconciliation/origindetail/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
	return btnhtml;
}
function order_commission_fun(id) {
	if(id){
		cfm_swal("您确认要一键发起返佣吗？","","warning","确认发起", "发起返佣完成。","您取消了该操作！"
				,'${ctx}/weixin/order/comission/batch',{},function(){
			reconciliation_search();
		});
	}else{
		cfm_swal("您确定要对该订单发起返佣？","","warning","确认发起", "发起返佣完成。","您取消了该操作！"
				,'${ctx}/weixin/order/comission/batch',{orderId:id},function(){
			reconciliation_search();
		});
	}
}


function reconciliation_queryParams(params){
	return $.extend({},params,util.serializeObject($('#reconciliation_searchForm')));
}

function reconciliation_search(){
	if($("#fyd_type").val()==='1'){
		$("#reconciliation_table").bootstrapTable("refresh");
	}else{
		$("#ysfyd_reconciliation_table").bootstrapTable("refresh");
	}
}

$(function(){
	$("#ysfyd").hide();
	common.ctx ='${ctx}';
	var y_type = $("#fyd_type").val();
	fyd_type_sel("#fyd_type_"+y_type,y_type);
	dict.init();
	common.pms.init();
	$("#reconciliation_table").bootstrapTable({onLoadSuccess: function(data){  //加载成功时执行  
    	common.pms.init();
    	for(var n=0,len=data.rows.length;n<len;n++){
    		var row = data.rows[n];
    		if(isReconciliationNew(row)){
	   			$('tr[data-index="'+n+'"] td:eq(0)').addClass("news");
    		}
    	} 
    }});
	$("#ysfyd_reconciliation_table").bootstrapTable({onLoadSuccess: function(data){  //加载成功时执行  
    	common.pms.init();
    	for(var n=0,len=data.rows.length;n<len;n++){
    		var row = data.rows[n];
    		if(isReconciliationNew(row)){
	   			$('tr[data-index="'+n+'"] td:eq(0)').addClass("news");
    		}
    	} 
    }});
	$('.selectpicker').selectpicker();
});

</script>