<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>餐饮菜单管理</h3>
	<hr>
	<div class="form-group">
		<a qx="hotelmenu:add" href="javascript:loadHotelContent(this,'${ctx}/base/hotel/menu/create','');" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotelMenu_searchForm">
	  <div class="form-group">
	  		<%-- <c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_hotelId" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_hotelId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if> --%>
			<label for="name">菜单名称</label>
	   		<input type="text" class="form-control" id="name" name="search_EQ_name" placeholder="请输入菜单名称">
			<label for="price">价格</label>
	   		<input type="text" class="form-control" id="price" name="search_EQ_price" placeholder="请输入价格">
	  </div>
	  <button type="button" class="btn btn-primary" onclick="hotelMenu_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="hotelMenu_table" data-toggle="table" data-height="660" data-query-params="hotelMenu_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/menu/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelName">所属场地名称</th> -->
				<th data-field="name">菜单名称</th>
				<th data-field="price">价格</th>
				<th data-field="createDate">创建时间</th>
				<th data-field="memo">备注</th>
				<th data-formatter="fm_hotelMenu_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_hotelMenu_operate(value,row, index){
	
	return '<a qx="hotelmenu:update" href="javascript:loadHotelContent(this,\'${ctx}/base/hotel/menu/update/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button qx="hotelmenu:delete" type="button" onclick="hotelMenu_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_hotelMenu_state(value,row, index){
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function hotelMenu_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/menu/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelMenu_search();
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
function hotelMenu_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelMenu_searchForm')));
}

function hotelMenu_search(){
	$("#hotelMenu_table").bootstrapTable("refresh");
}

$(function(){
	common.pms.init();
	$("#hotelMenu_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
	$('.selectpicker').selectpicker();
});

</script>