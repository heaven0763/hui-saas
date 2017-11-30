<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>用户管理</h3>
	<hr>
	<%-- <div class="form-group">
		<a href="${ctx}/account/user/create" target="dialog" class="btn btn-primary" title="添加用户" data-permission="user:create"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
		<a href="${ctx}/weixin/user/batch/upload/index" target="dialog" class="btn btn-primary" title="导入用户" data-permission="user:create"><span class="glyphicon glyphicon-plus"> </span> 导入用户</a>
	</div>  --%>
	<form class="form-inline" id="user_searchForm">
	    <div class="form-group">
		    <label for="nickname">用户账号</label>
		    <input type="text" class="form-control" id="nickname" name="search_LIKE_username" placeholder="请输入用户账号">
		    <label for="nickname">用户姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_rname" placeholder="请输入用户姓名">
		    <br>
		    <br>
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_mobile" placeholder="请输入手机号码">
		     <label for="mobile">用户角色</label>
		    <select class="form-control"  id="groupId" name="search_EQ_groupId">
				<tags:dict sql="select id , name ,'' from hui_group where id!=11 and id!=12 and id!=14 and id!=15 order by group_id"  addBefore=",全部" showPleaseSelect="false" />
			</select>
		    <!-- <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc"> -->
		    <button type="button" class="btn btn-primary" onclick="user_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams"
		data-pagination="true" data-url="${ctx}/account/user/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="username">帐号</th>
				<th data-field="rname">姓名</th>
				<!-- <th data-field="groupName">角色</th> -->
				<th data-field="groupName">职务</th>
				<th data-field="mobile">联系电话</th>
				<th data-field="email">电子邮箱</th>
				<th data-field="createDate">注册时间</th>
				<!-- <th data-options="locked" data-formatter="fm_user_state">状态</th> -->
				<th data-options="state" data-formatter="fm_user_state">状态</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script>
		$(function(){
			$("#user_table").bootstrapTable();
		});
		function operate(value,row, index){
			var state =  '';
			if(row.locked=="0"){
				state+='<a href="javascript:;" data-permission="user:lock" onclick="user_state_fun(\''+row.id+'\',\''+"您确定要锁定该用户吗"+'\',\''+"锁定"+'\',\''+"${ctx}/account/user/lockedUser/"+'\')" class="btn btn-primary btn-sm" id="mdlg" ><span class="glyphicon glyphicon-minus-sign"> </span> 锁定</a>';
			}else{
				state+='<a href="javascript:;" data-permission="user:unlock" onclick="user_state_fun(\''+row.id+'\',\''+"您确定要解锁该用户吗"+'\',\''+"解锁"+'\',\''+"${ctx}/account/user/unLockedUser/"+'\')" class="btn btn-primary btn-sm" id="mdlg" ><span class="glyphicon glyphicon-ok-sign"> </span> 解锁</a>';
			}		
			 state+='&nbsp;&nbsp;<a href="${ctx}/account/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary btn-sm" id="mdlg" title="修改密码"><span class="glyphicon glyphicon-pencil"> </span> 修改密码</a>'
			 /* +'&nbsp;&nbsp;<a href="${ctx}/account/user/update/'+row.id+'" data-permission="user:update" target="dialog" class="btn btn-primary btn-sm" id="mdlg-data-permission'+row.id+'" title="修改用户"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>' */
			 +'&nbsp;&nbsp;<button type="button" onclick="user_del_fun(\''+row.id+'\')" data-permission="user:delete" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>'; 		
			return state;		
		}
		function fm_user_state(value,row, index){
			if(row.state=="0"){
				return "已离职";
			}else{
				return "在职";
			}
		}
		function user_del_fun(id){
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
		   	     	$.post('${ctx}/account/user/delete/'+id, "", function (res, status) { 
		   	     		if(status=="success"&&res.statusCode=="200"){
		   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
		   	     			user_search();
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
		function user_state_fun(id,title,ctype,url){
			swal({
		        title: title,
		        text: "",
		        type: "warning",
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: ctype,
		        cancelButtonText: "取消",
		        closeOnConfirm: false,
		        showLoaderOnConfirm: true
		    }, function (isConfirm)  {
		    	if (isConfirm) {
		    		parent.show();
		   	     	$.post(url+id, "", function (res, status) { 
		   	     		if(status=="success"&&res.statusCode=="200"){
		   	     			swal(res.message, "success");
		   	     			user_search();
		   	     		}else{
		   	     			swal(res.message, "error");
		   	     		}
		   	     		parent.hide();
		   	     	}, 'json');
				} else {
					swal("已取消", "您取消了"+ctype+"操作！", "error")
				}
		    });
		}
		function user_queryParams(params){
			return $.extend({},params,util.serializeObject($('#user_searchForm')));
		}
		function user_search(){
			$("#user_table").bootstrapTable("refresh");
		}
	</script>
</div>
