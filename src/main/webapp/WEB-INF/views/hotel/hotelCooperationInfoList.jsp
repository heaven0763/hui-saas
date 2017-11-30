<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>合作信息管理</h3>
	<hr>
 	<c:if test="${aUs.getCurrentUserType() eq 'HUI' or aUs.getCurrentUserType() eq 'partner' }">
	<div class="form-group"><!--target="dialog"  -->
		<a qx="cooperationinfo:add" href="javascript:loadContent(this,'${ctx}/base/hotel/cooperationinfo/create','');"  class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	</c:if>
	<form class="form-inline" id="hotelCooperationInfo_searchForm">
	  <div class="form-group">
	 	 <c:if test="${aUs.getCurrentUserType() eq 'HUI' or aUs.getCurrentUserType() eq 'partner' }">
			<label for="city">地区</label>
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="city" name="search_EQ_h.city"  >
	     		<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select>
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_c.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_c.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<!-- <label for="hotelId">场地性质</label>
			<select class="form-control"  id="city" name="search_EQ_h.city"  >
	     		<option value="">不限</option>
	     		<option value="1">单体场地</option>
	     		<option value="2">集团</option>
			</select> -->
			<%-- <label for="citypartner">城市合伙人</label>
			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="citypartner" name="citypartner"  >
	     		<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> --%>
			<br>
			<br>
			<c:if test="${!groupMap.iscompanysales }">
			    <label for="reclaim_user_id">销售人员</label>
				<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="reclaim_user_id" name="search_EQ_h.reclaim_user_id"  >
					<option value="">全部</option>
					<c:forEach items="${sales}" var="sale">
						<option value="${sale.id }">${sale.rname }</option>
					</c:forEach>
				</select>
			</c:if>
			<c:if test="${groupMap.iscompanysales }">
			 <input type="hidden" name="search_EQ_h.reclaim_user_id" value="${guserId}">
			</c:if>
			
			<label for="sdate">日期</label>
			 <input class="form-control"  type="date" name="sdate" value="" style="width: 180px;">
			 ~
			 <input class="form-control"  type="date" name="fdate" value="" style="width: 180px;">
			 <button type="button" class="btn btn-primary" onclick="hotelCooperationInfo_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
			 </c:if>
			 <c:if test="${aUs.getCurrentUserType() eq 'HOTEL' and groupMap.isgroupadministrator}">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_c.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
				 <button type="button" class="btn btn-primary" onclick="hotelCooperationInfo_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
			 </c:if>
	  </div>
	</form>
	<br>
	<table id="hotelCooperationInfo_table" data-toggle="table" data-height="660" data-query-params="hotelCooperationInfo_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/cooperationinfo/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="hotelName" data-formatter="fm_hotelCooperationInfo_hotelName">场地名称</th>
				<th data-field="commissionRights" data-formatter="fm_hotelCooperationInfo_commissionRights">返佣权限归属</th>
				<th data-field="commissionBelong" data-formatter="fm_hotelCooperationInfo_commissionBelong">返佣归属</th>
				<c:if test="${aUs.getCurrentUserType() ne 'HOTEL' }">
				<th data-field="linkman">联系人</th>
				<th data-field="linkPhone">联系固话</th>
				<th data-field="linkMobile">联系手机</th>
				</c:if>
				<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
				<th data-field="reclaimUserName">会掌柜销售</th>
				<th data-field="reclaimUserMobile">会掌柜销售联系方式</th>
				</c:if>
				<th data-field="agreementSDate" data-formatter="fm_hotelCooperationInfo_agreementDate">协议有效期</th>
				
				<!-- <th data-field="housingCommission">住房返佣(%)</th>
				<th data-field="dinnerCommission">餐饮返佣(%)</th>
				<th data-field="mettingRoomCommission">会议室返佣(%)</th>
				<th data-field="ortherCommission">其他返佣(%)</th>
				<th data-field="isPoints" data-formatter="fm_hotelCooperationInfo_isPoints">是否参与积分</th>
				<th data-field="pointsRate">积分计算比例(%)</th> -->
				<th data-formatter="fm_hotelCooperationInfo_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	common.pms.init();
	$("#hotelCooperationInfo_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	$('.selectpicker').selectpicker();
});
function hotelCooperationInfo_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelCooperationInfo_searchForm')));
}

function hotelCooperationInfo_search(){
	$("#hotelCooperationInfo_table").bootstrapTable("refresh");
}
function fm_hotelCooperationInfo_operate(value,row, index){
	var str = "";
	//return qx="cooperationinfo:view"
	<c:if test="${aUs.getCurrentUserType() eq 'HUI' or aUs.getCurrentUserType() eq 'partner' }">
		str+='&nbsp;&nbsp;<a qx="cooperationinfo:update" href="javascript:loadContent(this,\'${ctx}/base/hotel/cooperationinfo/update/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="修改信息"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>';
		str+='&nbsp;&nbsp;<a qx="cooperationinfo:update" href="${ctx}/base/hotel/cooperationinfo/update/rate/'+row.id+'" width="700" target="dialog" class="btn btn-primary btn-sm" title="修改比例"><span class="glyphicon glyphicon-pencil"> </span> 比例</a>';
		str+='&nbsp;&nbsp;<button qx="cooperationinfo:delete" type="button" onclick="hotelCooperationInfo_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	</c:if>
	
	 return str;
}
function fm_hotelCooperationInfo_hotelName(value,row, index){
	return '<a href="${ctx}/base/hotel/cooperationinfo/detail/'+row.id+'" width="800" target="dialog" title="详情" style="white-space:nowrap;">'+value+'</a>';
}
function fm_hotelCooperationInfo_commissionRights(value,row, index){
	return value==='1'?'场地':'集团';
}

function fm_hotelCooperationInfo_commissionBelong(value,row, index){
	return value==='1'?'会掌柜':'第三方平台';
}

function fm_hotelCooperationInfo_isPoints(value,row, index){
	return value==='1'?'是':'否';
}
function fm_hotelCooperationInfo_agreementDate(value,row, index){
	return value+"~"+row.agreementEDate;
}
function hotelCooperationInfo_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/cooperationinfo/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelCooperationInfo_search();
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
</script>