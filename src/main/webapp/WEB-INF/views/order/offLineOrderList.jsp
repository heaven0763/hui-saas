<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>线下活动</h3>
	<hr>
	<div class="form-group">
		<a qx="offline-event:add" href="javascript:loadContent(this,'${ctx}/weixin/order/create?OFFTAG=OFFLINE','');"  class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="order_searchForm">
	  <div class="form-group">
			
	   		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="organizer">活动主办单位</label>
	   		<input type="text" class="form-control" id="organizer" name="search_EQ_o.organizer" placeholder="请输入活动主办单位">
	   		<br>
	   		<br>
			<label for="linkman">联系人</label>
	   		<input type="text" class="form-control" id="linkman" name="search_EQ_o.linkman" placeholder="请输入联系人">
			<label for="contactNumber">联系电话</label>
	   		<input type="text" class="form-control" id="contactNumber" name="search_EQ_o.contact_number" placeholder="请输入联系电话">
	   		<c:if test="${!groupMap.iscompanysales }">
			<label for="reclaim_user_id">销售人员</label>
				<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="reclaim_user_id" name="saleId"  >
					<option value="">全部</option>
					<c:forEach items="${sales}" var="sale">
						<option value="${sale.id }">${sale.rname }</option>
					</c:forEach>
				</select>
			</c:if>
			<c:if test="${groupMap.iscompanysales }">
			 <input type="hidden" name="saleId" value="${guserId}">
			</c:if>
		  <button type="button" class="btn btn-primary" onclick="order_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="order_table" data-toggle="table" data-height="660" data-query-params="order_queryParams"
		data-pagination="true" data-url="${ctx}/weixin/order/offline/check/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="orderNo">订单编号</th> 
				<th data-field="amount">金额</th>-->
				<th data-field="area">区域</th>
				<th data-field="hotelName">场地名称</th>
				<th data-field="activityDate">活动日期</th>
				<th data-field="activityTitle">活动名称</th>
				<th data-field="organizer">活动主办单位</th>
				<th data-field="linkman">联系人</th>
				<th data-field="contactNumber">联系电话</th>
				<th data-field="offlineState" data-formatter="fm_order_state">审核状态</th>
				<th data-field="createDate">创建时间</th>
				<th data-formatter="fm_order_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_order_operate(value,row, index){
	var btnhtml = "";
	btnhtml+='<a href="javascript:loadContent(this,\'${ctx}/base/order/detail/'+row.id+'?OFFTAG=OFFLINE\',\'\');" class="btn btn-primary" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
	<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
		if(row.state=='01'){
			btnhtml+='&nbsp;&nbsp;<button qx="offline-event:update"  type="button" onclick="order_accept_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 受理</button>';
		}else if(row.state=='02'){
			btnhtml+='&nbsp;&nbsp;<a qx="offline-event:update"  href="javascript:loadContent(this,\'${ctx}/base/order/update/'+row.id+'\',\'\');" href="" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
		}
	</c:if>
	return btnhtml;
}

function fm_order_state(value,row, index){
	if(value==='0'){
		return '<span class="label label-danger">未审核</span>';	
	}else if(value==='1'){
		return '<span class="label label-success">审核通过</span>';	
	}else if(value==='2'){
		return '<span class="label label-default">审核不通过</span>';	
	}else{
		return '<span class="label label-default">其他</span>';	
	}
}

function order_del_fun(id) {
	var title = "您确定要删除该订单吗";
	var text = "删除后将无法恢复，请谨慎操作！";
	var url = '${ctx}/base/order/delete/' + id;
	var data = "";
	var msg = "您已经永久删除了这条信息。";
	cfmFun(title,text,'删除',url,data,msg);
}

function order_accept_fun(id) {
	var title = "您确定要受理该订单吗";
	var text = "";
	var url = '${ctx}/base/order/accept/' + id;
	var data = "";
	var msg = "您已经受理了该订单，请尽快与客户联系吧。";
	cfmFun(title,text,'受理',url,data,msg);
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
					order_search();
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
function order_queryParams(params){
	return $.extend({},params,util.serializeObject($('#order_searchForm')));
}

function order_search(){
	$("#order_table").bootstrapTable("refresh");
}
$(function(){
	common.pms.init();
	$("#order_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	$('.selectpicker').selectpicker();
});

</script>