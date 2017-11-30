<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>HR授权</h3>
	<hr>
	<div class="form-group">
		<a qx="user:hrauthor" href="${ctx}/base/user/author/transfer/index?fromuserId=&gid=${type}&type=${type}" target="dialog" class="btn btn-primary btn-sm" title="新增HR"><span class="glyphicon glyphicon-plus"></span> 新增HR</a>
		<c:forEach items="${menus}" var="menu">
			<c:if test="${menu.id!=120 }">
				<a href="javascript:;" url="${menu.url}" onclick="loadContent(this,'${ctx}/${menu.url}','');"  class="btn btn-primary btn-sm" title="${menu.name }" ><span class="fa fa-${menu.icon }"> </span> ${menu.name }</a>
			</c:if>
		</c:forEach>
	</div> 
	<form class="form-inline" id="user_searchForm">
	    <div class="form-group">
			
		    <label for="nickname">HR姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_mobile" placeholder="请输入手机号码">
		   
		    <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc">
		    <button type="button" class="btn btn-primary" onclick="user_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams" data-row-style="userRowStyle"
		data-pagination="true" data-url="${ctx}/weixin/user/hr/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="username">帐号</th>
				<th data-field="rname">姓名</th>
				<th data-field="position">职务</th>
				<th data-field="mobile">联系电话</th>
				<th data-field="email">电子邮箱</th>
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
		});
		function operate(value,row, index){
			var state =  '';
			 state+='&nbsp;&nbsp;<a  qx="user:hrauthor" href="${ctx}/base/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary btn-sm" id="mdlg" title="重置密码"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>'
			 +'&nbsp;&nbsp;<a qx="user:hrauthor" href="javascript:;" onclick="loadContent(this,\'${ctx}/${url}'+row.id+'?TYPE=HR\',\'\');" href="" data-permission="user:update"  class="btn btn-primary btn-sm"  title="详细信息"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
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
