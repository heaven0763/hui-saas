<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>价格管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/hotel/price/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="placePrice_searchForm">
	  <div class="form-group">
			<label for="shotelId">所属场地</label>
	   			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="shotelId" name="search_EQ_hotelId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " showPleaseSelect="false"  addBefore=",全部"/>
				</select>
			<label for="placeType">场地类型</label>
	   		<select class="form-control" name="search_EQ_placeType"  style="width: 180px;">
				<tags:dict sql="SELECT val, name FROM hui_category where kind='PLACETYPE' and val!='HOTEL'" showPleaseSelect="false" addBefore=",全部"  />
			</select>
			<label for="placeId">场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="splaceId" name="search_EQ_placeId" refval="value" reftext="text"  style="width: 180px;">
	   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place " showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<br>
			<br>
			<label for="placeSchedule">价格日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="splaceSchedule" name="search_EQ_placeSchedule" placeholder="请输入场地档期">
		  	<button type="button" class="btn btn-primary" onclick="placePrice_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="placePrice_table" data-toggle="table" data-height="600" data-query-params="placePrice_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/price/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="hotelName">所属场地</th>
				<th data-field="placeType" data-formatter="fm_price_placeType">场地类型</th>
				<th data-field="placeName">所属场地</th>
				<th data-field="placeSchedule">价格日期</th>
				<th data-field="onlinePrice" data-align="right">线上价格</th>
				<th data-field="offlinePrice" data-align="right">线下价格</th>
				<!-- <th data-field="updateDate">调整日期</th>
				<th data-field="beforeOnlinePrice">调整前线上价格</th>
				<th data-field="beforeOfflinePrice">调整前线下价格</th> -->
				<th data-formatter="fm_placePrice_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_placePrice_operate(value,row, index){
	
	return '<a href="${ctx}/base/hotel/price/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="placePrice_del_fun(\''+row.id+'\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_placePrice_state(value,row, index){
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function placePrice_del_fun(id){
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/base/hotel/price/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			placePrice_search();
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了删除操作！", "error")
		}
    });
	
}
function fm_price_placeType(value,row, index){
	if(value=="HOTEL"){
		return "场地";
	}else if(value=="HALL"){
		return "会场";
	}else if(value=="ROOM"){
		return "客房";
	}else{
		return "其他";
	}
}
$(function(){
	 var splaceSchedule={elem:"#splaceSchedule",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 laydate(splaceSchedule);
	 $("#placePrice_table").bootstrapTable();
	 $('.selectpicker').selectpicker();
});
function placePrice_queryParams(params){
	return $.extend({},params,util.serializeObject($('#placePrice_searchForm')));
}

function placePrice_search(){
	$("#placePrice_table").bootstrapTable("refresh");
}

</script>