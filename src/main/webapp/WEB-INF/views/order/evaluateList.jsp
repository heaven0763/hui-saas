<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>${title}</h3>
	<hr>
	<div class="form-group">
	<button id="btn_evaluate_batchdel" type="button" class="btn btn-primary" ><span class="glyphicon glyphicon-search"> </span>批量删除</button>
	</div>
	<form class="form-inline" id="evaluate_searchForm">
	  <input type="hidden" name="search_EQ_e.evaluate_type" value="${evaluateType }">
	  <div class="form-group">
	  		<c:if test="${evaluateType eq 'SITE' or evaluateType eq 'PLATFORM' }">
		  		<label for="city">城市</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_h.city" style="width: 200px;">
					<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
				 <label for="nickname">${evaluateType eq 'SITE'?'场地名称':'所属场地' }</label>
			    <input type="text" class="form-control" id="nickname" name="${evaluateType eq 'SITE'?'search_LIKE_e.item_name':'search_LIKE_e.hotel_name'}" placeholder="请输入场地名称">
			     <label for="nickname">评价人员</label>
			    <input type="text" class="form-control" id="nickname" name="search_LIKE_e.user_name" placeholder="请输入用户账号">
	  		</c:if>
	  		<c:if test="${evaluateType eq 'SALE' }">
				<label for="city">城市</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_h.city" style="width: 200px;">
					<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			 	<label for="nickname">销售人员</label>
			    <input type="text" class="form-control" id="nickname" name="search_LIKE_e.sale_name" placeholder="请输入销售人员">
   			 	<label for="nickname">手机号码</label>
			    <input type="text" class="form-control" id="nickname" name="search_LIKE_e.sale_mobile" placeholder="请输入手机号码">
			    <br>
			    <br>
				<label for="nickname">所属场地</label>
			    <input type="text" class="form-control" id="nickname" name="search_LIKE_e.hotel_name" placeholder="请输入场地名称">
			     <label for="nickname">评价者</label>
			    <input type="text" class="form-control" id="nickname" name="search_LIKE_e.user_name" placeholder="请输入评价者">
			
			<%-- <label for="area">场地类型</label>
	   		<select id="hotel_type" class="form-control" name="search_EQ_h.hotel_type" style="width: 200px;">
				<tags:dict sql="SELECT id, name  FROM hui_category where kind ='HOTELTYPE' "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<label for="hotelName">场地</label>
	   		<select class="form-control" name="search_EQ_e.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_e.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_e.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="euserType">评论人群</label>
			<select class="form-control" name="search_EQ_e.euser_type" >
				<option value="">不限</option>
				<option value="SITE">场地</option>
				<option value="CLIENT">普通客户</option>
			</select> --%>
			
			</c:if>
			
	  		<button type="button" class="btn btn-primary" onclick="evaluate_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="evaluate_table" data-toggle="table" data-height="660" data-query-params="evaluate_queryParams"
	data-pagination="true" data-url="${ctx}/base/order/evaluate/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th data-checkbox="true"></th>
				<!-- <th data-field="evaluateType">评价类型</th> 
				<th data-field="hotelId">场地编号</th>-->
				<c:if test="${evaluateType eq 'SALE' }">
				<th data-field="city">城市</th>
				<th data-field="saleName">销售人员</th>
				<th data-field="saleMobile">销售人员联系电话</th>
				<th data-field="itemName">所属场地</th>
				<th data-field="userName">评论者</th>
				<th data-field="evaluateDate">评论日期</th> 
				</c:if>
				<c:if test="${evaluateType eq 'SITE' or evaluateType eq 'PLATFORM' }">
				<th data-field="evaluateDate">评论日期</th> 
				<th data-field="userName">评论者</th>
				<th data-field="city">城市</th>
				<th data-field="${evaluateType eq 'SITE'?'itemName':'hotelName' }">${evaluateType eq 'SITE'?'场地名称':'所属场地' }</th>
				</c:if>
				<th data-field="comprehensive" data-formatter="fm_evaluate_comprehensive">综合评价</th>
				<!-- 
				<th data-field="area">区域</th>
				<th data-field="star">星级</th>
				<th data-field="facilities">设施评价</th>
				<th data-field="hygiene">卫生评价</th>
				<th data-field="service">服务评价</th>
				<th data-field="location">位置评价</th>
				<th data-field="experience">平台体验感</th>
				<th data-field="follow">公司跟进服务</th>
				<th data-field="benefit">获取优惠</th>
				<th data-field="econtent">评价内容</th>
				<th data-field="saleId">销售人员编号</th>
				<th data-field="saleName">销售人员姓名</th>
				<th data-field="salePosition">销售人员职位</th>
				<th data-field="saleMobile">销售人员联系电话</th>
				<th data-field="euserType">评论人群</th>
				<th data-field="isanonymous">是否匿名</th>-->
			
				 <th data-formatter="fm_evaluate_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	common.pms.init();
	$("#evaluate_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
	$('.selectpicker').selectpicker();
});
function evaluate_queryParams(params){
	return $.extend({},params,util.serializeObject($('#evaluate_searchForm')));
}

function evaluate_search(){
	$("#evaluate_table").bootstrapTable("refresh");
}
function fm_evaluate_comprehensive(value,row, index){
	var cps = '<div class="icon-start icon-start-size-'+value+'" style="display:inline-block;" > <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>';
	return cps;
}
 function fm_evaluate_operate(value,row, index){
	
	return '<a href="javascript:loadContent(this,\'${ctx}/base/order/evaluate/detail/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="详情"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>'
	+'&nbsp;&nbsp;<button qx="evaluate:delete" type="button" onclick="evaluate_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function evaluate_del_fun(id){
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/order/evaluate/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			evaluate_search();
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

$('#btn_evaluate_batchdel').click(function(){
	var rows = $("#evaluate_table").bootstrapTable("getAllSelections");
	if(rows.length===0){
		swal("请先选择需要删除的评价信息！",'error');
		return;
	}
	var ids = [];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}
	var action = "删除";
	var btns = "删除所选";
	cfm_swal("您确定要"+action+"所选中的评价信息","","warning",btns, "评价信息"+action+"完成。","您取消了该操作！"
			,'${ctx}/base/order/evaluate/batch/delete',{ids:ids.join(',')},function(){
			evaluate_search();
	});
});
</script>