<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>会场管理</h3>
	<hr>
	<div class="form-group">
		<a qx="hall:add" href="javascript:loadHotelContent(this,'${ctx}/base/hotel/hall/create','');"  class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotelPlace_searchForm">
	  <input type="hidden" class="form-control"   name="search_EQ_h.place_type" value="HALL">
	  <div class="form-group">
			<%-- <label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_h.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> --%>
			
			<%-- <c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_h.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if> 
			<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_h.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			--%>
			<!-- <label for="placeType">会场类型</label>
	   		<input type="text" class="form-control" id="placeType" name="search_EQ_placeType" placeholder="请输入会场类型"> -->
			<label for="placeName">会场名称</label>
	   		<input type="text" class="form-control" id="placeName" name="search_LIKE_h.place_name" placeholder="请输入会场名称">
			<label for="person">会场人数</label>
	   		<select class="form-control"  id="person" name="person">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='PERSON' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<label for="area">会场面积</label>
	   		<select class="form-control"  id="area" name="area">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='AREA' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<br>
			<br>
			<%-- <label for="zgprice">掌柜价格</label>
	   		<select class="form-control"  id="zgprice" name="zgprice">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='PRICE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select> --%>
			
			<label for="price">会场价格</label>
	   		<select class="form-control"  id="price" name="price">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='PRICE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<label for="floor">所在楼层</label>
	   		<input type="text" class="form-control" id="floor" name="search_EQ_h.floor" placeholder="请输入所在楼层">
	 		<button type="button" class="btn btn-primary" onclick="hotelPlace_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="hotelPlace_table" data-toggle="table" data-height="660" data-query-params="hotelPlace_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/hall/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelName">所属场地</th> -->
				<th data-field="placeName">会场名称</th>
				<th data-field="recommendedIndex" data-align="right">推荐指数</th>
				<!-- <th data-field="zguiPrice" data-align="right">掌柜价</th> -->
				<th data-field="hotelPrice" data-align="right">会场价格</th>
				<th data-field="isauth">实地认证</th>
				<th data-field="isrecommend">推荐</th>
				<th data-field="isbest">优质</th>
				<th data-field="hallArea" data-align="right">面积</th>
				<th data-field="floor" data-align="right">所在楼层</th>
				<th data-field="pillar" data-align="right">场地柱子</th>
				<!-- <th data-field="decorationTime">装修时间</th> -->
				<th data-formatter="fm_hotelPlace_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_hotelPlace_operate(value,row, index){
	
	return '<a qx="hall:update" href="javascript:loadHotelContent(this,\'${ctx}/base/hotel/hall/update/'+row.id+'\',\'\');"   class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button qx="hall:delete" type="button" onclick="hotelPlace_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_hotelPlace_state(value,row, index){
}
function hotelPlace_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/hall/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelPlace_search();
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
$(function(){
	common.pms.init();
	$('.selectpicker').selectpicker();
	$("#hotelPlace_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
});
function hotelPlace_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelPlace_searchForm')));
}

function hotelPlace_search(){
	$("#hotelPlace_table").bootstrapTable("refresh");
}

</script>