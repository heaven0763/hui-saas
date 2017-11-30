<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>授权管理</h3>
	<hr>
	<div class="form-group">
		<a qx="user:tmpauthor" href="javascript:;" onclick="loadContent(this,'${ctx}/base/user/author/tmp','');"  class="btn btn-primary btn-sm" title="临时授权" data-permission="user:create"><span class="glyphicon glyphicon-plus"></span>临时授权</a>
		<c:forEach items="${menus}" var="menu">
			<c:if test="${menu.id!=37 }">
				<a href="javascript:;" url="${menu.url}" onclick="loadContent(this,'${ctx}/${menu.url}','');"  class="btn btn-primary btn-sm" title="${menu.name }" ><span class="fa fa-${menu.icon }"> </span>${menu.name }</a>
			</c:if>
		</c:forEach>
	</div> 
	<form class="form-inline" id="user_permission_searchForm">
	    <div class="form-group">
	    <label for="city">城市</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" name="search_EQ_u.city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
		    <label for="nickname">用户账号</label>
		    <input type="text" class="form-control" id="nickname" name="search_LIKE_u.username" placeholder="请输入用户账号">
		    <label for="nickname">用户姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_u.rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_EQ_u.mobile" placeholder="请输入手机号码">
		    <!-- <label for="nickname">权限名称</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_u.permission_name" placeholder="请输入权限名称"> -->
		    <button type="button" class="btn btn-primary" onclick="user_permission_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="user_permission_table" data-toggle="table" data-height="660" data-query-params="user_permission_queryParams"
		data-pagination="true" data-url="${ctx}/base/user/author/tmp/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="userName">姓名</th>
				<th data-field="permissionName">权限</th>
				<th data-field="startTime">开始</th>
				<th data-field="endTime">结束</th>
				<th data-field="action" data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script>
		$(function(){
			common.pms.init();
			$("#user_permission_table").bootstrapTable({onLoadSuccess: function(){common.pms.init(); }});
			$(".selectpicker").selectpicker();
		});
		function operate(value,row, index){
			var state =  '<a  qx="user:tmpauthor" href="javascript:;" onclick="takeBackFun('+row.id+');" href="" data-permission="user:update"  class="btn btn-primary btn-sm"  title="收回权限"><span class="glyphicon glyphicon-off"> </span> 收回权限</a>'
			return state;		
		}
		
		function user_permission_queryParams(params){
			return $.extend({},params,util.serializeObject($('#user_permission_searchForm')));
		}
		function user_permission_search(){
			$("#user_permission_table").bootstrapTable("refresh");
		}
		function takeBackFun(id){
			cfm_swal("您确认要收回该权限？",'','warning','收回','您已成功收回该权限！','您取消了该操作！','${ctx}/weixin/user/author/tmp/takeback/'+id,null,function(res){
				user_permission_search();
			});
		}
		</script>
</div>
