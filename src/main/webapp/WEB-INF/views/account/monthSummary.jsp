<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">
<script type="text/javascript">
$(function(){
	var beginTime={elem:"#startTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	laydate(beginTime);
	var endTime={elem:"#endTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	laydate(endTime);
	
	 $('#startTime').val(laydate.now(-getCurrentMonthFirst(), 'YYYY-MM-DD'));
	 $('#endTime').val(laydate.now(0, 'YYYY-MM-DD'));
	
	$("#sum_table").bootstrapTable();
	
});
function sum_queryParams(params){
	return $.extend({},params,util.serializeObject($('#sum_searchForm')));
}
function sum_search(){
	$("#sum_table").bootstrapTable("refresh");
}
function getCurrentMonthFirst(){
	 var date=new Date();
	 return date.getDate()-1;
}
</script>
<form class="form-inline" id="sum_searchForm">
	  <div class="form-group">
	  		<%-- <label for="state">地区</label>
	   		<select class="form-control" name="search_LIKE_o.area" >
				<tags:dict sql="SELECT region_name id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control" name="search_EQ_o.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="state">返佣状态</label>
	   		<select class="form-control" name="search_EQ_o.commission_status" >
				<tags:dict sql="SELECT code as id,detail as name FROM hui_sys_dict where kind='06' order by code "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select>  --%>
	   		<label for="decorationTime">订单时间:</label>
		  	<input type="text" class="form-control  layer-date laydate-icon" id="startTime" name="startTime">~
		  	<input type="text" class="form-control  layer-date laydate-icon" id="endTime" name="endTime">
		  	<button type="button" class="btn btn-primary" onclick="sum_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	 	</div>
</form>
<br>
<table id="sum_table" class="table-condensed" data-toggle="table" data-height="560" data-query-params="sum_queryParams"
		data-pagination="false" data-url="${ctx}/base/order/monthSummary/list" data-data-type="json" >
	    <thead>
	        <tr>
				<th data-field="hotelName">场地名称</th>
				<th data-field="totalOrder" style="word-break:break-all; word-wrap:break-all;">订单数</th>
				<th data-field="totalMoney" style="word-break:break-all; word-wrap:break-all;">订单金额</th>
	        </tr>
	    </thead>
	</table>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
