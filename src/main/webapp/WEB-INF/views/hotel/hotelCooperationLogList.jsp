<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
 
<div class="wrapper wrapper-content">
	<h3>返佣比例调整审核</h3>
	<hr>
	<form class="form-inline" id="hotelCooperationLog_searchForm">
	  <div class="form-group">
	  		<label for="hotelId">地区</label>
   			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_h.city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_c.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="hotel_type">场地类型</label>
	   		<select id="hotel_type" class="form-control" name="search_EQ_h.hotel_type" style="width: 200px;">
				<tags:dict sql="SELECT id, name  FROM hui_category where kind ='HOTELTYPE' "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<br>
	   		<br>
			<label for="reclaim_user_id">销售人员</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="reclaim_user_id" name="search_EQ_h.reclaim_user_id" style="width: 200px;">
	   			<option value="">不限</option>
	   			<c:forEach items="${sales }" var="sale">
	   				<option value="${sale.id }">${sale.rname }</option>
	   			</c:forEach>
	   		</select>
			<label for="state">状态</label>
	   		<!-- <input type="text" class="form-control" id="state" name="search_EQ_state" placeholder="请输入状态"> -->
	   		<select class="form-control" id="state" name="search_EQ_c.state"  style="width: 200px;">
	   			<option value="">不限</option>
	   			<option value="0">未审核</option>
	   			<option value="1">已审核</option>
	   		</select>
			<label for="applyUserDate1">日期</label>
	   		<input type="date" class="form-control" id="applyUserDate1" name="search_GTE_c.apply_date" placeholder="请输入创建日期">
			<label for="applyUserDate2">~</label>
	   		<input type="date" class="form-control" id="applyUserDate2" name="search_LTE_c.apply_date" placeholder="请输入创建日期">
		    <button type="button" class="btn btn-primary" onclick="hotelCooperationLog_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="hotelCooperationLog_table" data-toggle="table" data-height="660" data-query-params="hotelCooperationLog_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/cooperationinfo/site/rebate/check/list" data-data-type="json" data-row-style="hotelCooperationLogRowStyle">
	    <thead>
	        <tr>
				<th data-field="hotelName"  data-formatter="fm_hotelCooperationLog_hotelName">场地</th>
				<!-- <th data-field="star">星级</th> -->
				<!-- <th data-field="bfallCommissionRate">全单返佣原比例</th>
				<th data-field="afallCommissionRate">全单返佣比例</th>
				<th data-field="bfmettingRoomCommissionRate">原会议室返佣比例</th>
				<th data-field="afmettingRoomCommissionRate">修改后会议室返佣比例</th>
				<th data-field="bfhousingCommissionRate">原住房返佣比例</th>
				<th data-field="afhousingCommissionRate">修改后住房返佣比例</th>
				<th data-field="bfdinnerCommissionRate">原餐饮返佣比例</th>
				<th data-field="afdinnerCommissionRate">修改后餐饮返佣比例</th>
				<th data-field="bfortherCommissionRate">原其他返佣比例</th>
				<th data-field="afortherCommissionRate">修改后其他返佣比例</th> -->
				
				<!--
				<th data-field="pointsRateType">积分计算类型</th>
				<th data-field="bfpointsRate">原积分计算比例</th>
				<th data-field="afpointsRate">修改后积分计算比例</th>
					-->	
									
				<th data-field="state" data-formatter="fm_hotelCooperationLog_state">状态</th>
				<th data-field="applyReason">调整原因</th>
				<th data-field="applyUserName">提交人</th>
				<th data-field="applyDate">提交日期</th>
				<th data-formatter="fm_hotelCooperationLog_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>

$(function(){
	common.pms.init();
	$("#hotelCooperationLog_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
	$('.selectpicker').selectpicker();
});
function hotelCooperationLog_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelCooperationLog_searchForm')));
}

function fm_hotelCooperationLog_hotelName(value,row, index){
	var tips = "";
	if(row.state==='0'){
		tips = "返佣比例调整审核";
	}else{
		tips = "返佣比例调整详情";
	}
	return '<a qx="royaltyratio:check" href="${ctx}/hotel/cooperationlog/update/'+row.id+'" width="800" target="dialog"  title="'+tips+'">'+value+'</a>';
}
function hotelCooperationLog_search(){
	$("#hotelCooperationLog_table").bootstrapTable("refresh");
}
function fm_hotelCooperationLog_operate(value,row, index){
	var tips = "";
	var title = "";
	if(row.state==='0'){
		tips = "返佣比例调整审核";
		title = "审核";
	}else{
		tips = "返佣比例调整详情";
		title = "详情";
	}
	//
	return '<a qx="royaltyratio:check" href="${ctx}/hotel/cooperationlog/update/'+row.id+'" width="800" target="dialog" class="btn btn-primary btn-sm" title="'+tips+'"><span class="glyphicon glyphicon-pencil"> </span> '+title+'</a>';
}
function fm_hotelCooperationLog_state(value,row, index){
	if(value==="0"){
		return '<span class="label label-danger">未审核</span>';
	}else if(value==="1"){
		return '<span class="label label-success">审核通过</span>';
	}else if(value==="2"){
		return '<span class="label label-default">审核不通过</span>';
	}
}
function hotelCooperationLogRowStyle(row, index) {
    if (row.state === '2') {
        return {
            css: {"color":"#cccccc"}
        };
    }
    return {};
}
</script>