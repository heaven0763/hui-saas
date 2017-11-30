<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>职员管理</h3>
	<hr>
	<div class="form-group">
		<%-- <a  qx="user:add" href="${ctx}/base/user/create" target="dialog" class="btn btn-primary" title="添加用户" ><span class="glyphicon glyphicon-plus"></span> 添加用户</a> --%>
		<a qx="author:update" href="${ctx}/base/user/author/transfer/index" target="dialog" class="btn btn-primary" title="权限转移" ><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
		<a qx="user:import"href="${ctx}/weixin/user/batch/upload/index" target="dialog" class="btn btn-primary" title="导入用户" ><span class="glyphicon glyphicon-plus"> </span> 导入用户</a>
	</div> 
	<form class="form-inline" id="user_searchForm">
	    <div class="form-group">
	    	<c:if test="${!aUs.getCurrentUserType() eq 'partner'}">
	    	<label for="userType">用户类型</label>
		    <select class="form-control"  id="userType" name="search_EQ_userType">
		    	<option value="HUI">会掌柜及第三方平台</option>
		    	<option value="HOTEL">场地</option>
		    	<!-- <option value="PARTNER">城市合伙人</option> -->
			</select>
			</c:if>
			<label for="city">城市</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" name="search_EQ_city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<c:if test="${!aUs.getCurrentUserType() eq 'partner' }">
			<label for="dept">部门</label>
	   		<select class="form-control" name="search_EQ_deptId" style="width: 200px;">
				<tags:dict sql=" SELECT id,unitname name FROM hzg_saas.hui_department where id != 1"  showPleaseSelect="fasle" addBefore=",全部"/>
			</select>
			<br>
			<br>
			</c:if>
		    <label for="nickname">用户账号</label>
		    <input type="text" class="form-control" id="nickname" name="search_LIKE_username" placeholder="请输入用户账号">
		    <label for="nickname">用户姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_mobile" placeholder="请输入手机号码">
		   
		    <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc">
		    <input type="hidden"  name="search_EQ_userType" value="HUI">
		    <button type="button" class="btn btn-primary" onclick="user_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams" data-row-style="userRowStyle"
		data-pagination="true" data-url="${ctx}/base/user/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="username">帐号</th>
				<th data-field="rname">姓名</th>
				<!-- <th data-field="groupName">角色</th> -->
				<th data-field="position">职务</th>
				<th data-field="mobile">联系电话</th>
				<th data-field="email">电子邮箱</th>
				<th data-options="state" data-formatter="fm_user_state">状态</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script>
		var user_table;
		$(function(){
			user_table = 1;
			common.pms.init();
			$("#user_table").bootstrapTable({onLoadSuccess: function(){common.pms.init(); }});
			$(".selectpicker").selectpicker();
		});
		function operate(value,row, index){
			var state =  '';
			 state+='&nbsp;&nbsp;<a qx="user:update" href="${ctx}/base/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary" id="mdlg" title="重置密码"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>'
			 +'&nbsp;&nbsp;<a qx="user:update" href="javascript:;" onclick="loadContent(this,\'${ctx}/base/user/detail/'+row.id+'\',\'\');" href="" data-permission="user:update"  class="btn btn-primary"  title="详细信息"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>'
			/*  +'&nbsp;&nbsp;<a href="javascript:;" onclick="loadContent(this,\'${ctx}/weixin/user/pms/update/'+row.id+'\',\'\');" class="btn btn-primary" title="调整权限" ><span class="glyphicon glyphicon-move"> </span> 调整权限</a>' */
			 +'&nbsp;&nbsp;<a  qx="author:update" href="${ctx}/base/user/author/transfer/index?fromuserId='+row.id+'&gid='+row.groupId+'" target="dialog" class="btn btn-primary" title="权限转移" ><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>';
			 if(row.groupId===3){
				 state+='&nbsp;&nbsp;<a  qx="author:update" href="${ctx}/base/user/author/hotel/'+row.id+'" target="dialog" class="btn btn-primary" title="分配场地"  width="1000" ><span class="glyphicon glyphicon-transfer"> </span> 分配场地</a>';
			 }
			return state;		
		}
		function fm_user_state(value,row, index){
			if(row.state === "1"){
				return "在职";
			}else{
				return "已离职";
			}
		}
		
		function user_queryParams(params){
			return $.extend({},params,util.serializeObject($('#user_searchForm')));
		}
		function user_search(){
			$("#user_table").bootstrapTable("refresh");
		}
		</script>
</div>
