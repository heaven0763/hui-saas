<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>人员管理</h3>
	<hr>
	<div class="form-group">
		<shiro:hasRole name="administrator">
			<a qx="user:add" href="${ctx}/base/user/create?hotelId=${mhotel.id}" target="dialog" class="btn btn-primary" title="添加用户" data-permission="user:create"><span class="glyphicon glyphicon-plus"></span> 添加用户</a>
		</shiro:hasRole>
		<c:if test="${aUs.getCurrentUserType() eq 'HOTEL' }">
			<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index" target="dialog" class="btn btn-primary" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>
		</c:if>
		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
			<a qx="user:invitation" href="${ctx}/weixin/user/invitation/hotel/admin/${mhotel.id}" target="dialog" class="btn btn-primary" title="人员邀请" data-permission="user:create"><span class="glyphicon glyphicon-plus"></span> 人员邀请</a>
		</c:if>
	</div> 
	<form class="form-inline" id="user_searchForm">
		<input type="hidden" name="search_EQ_u.hotel_id" value="${mhotel.id}">
	    <div class="form-group">
			
		    <label for="nickname">用户账号</label>
		    <input type="text" class="form-control" id="nickname" name="search_LIKE_u.username" placeholder="请输入用户账号">
		    <label for="nickname">用户姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_u.rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_u.mobile" placeholder="请输入手机号码">
		   
		   <!--  <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc"> -->
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
				<th data-field="comprehensive" data-formatter="fm_user_comprehensive">综合评价</th>
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
		});
		function operate(value,row, index){
			var state =  '';//hotelId='+row.hotelId+'&
			 state+='&nbsp;&nbsp;<a href="javascript:;" onclick="loadHotelContent(this,\'${ctx}/weixin/user/moredetail?userId='+row.id+'&from=loadHotelContent\',\'\');" href="" data-permission="user:update"  class="btn btn-primary btn-sm"  title="详细信息"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
			if('HOTEL'==='${aUs.getCurrentUserType()}'){
			    state+='&nbsp;&nbsp;<a qx="user:update" href="${ctx}/base/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary" id="mdlg" title="重置密码"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>';
				state+='&nbsp;&nbsp;<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?fromuserId='+row.id+'&gid='+row.groupId+'" target="dialog" class="btn btn-primary" title="权限转移" data-permission="user:create"><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>';
			}
			return state;		
		}
		function fm_user_state(value,row, index){
			if(row.state === "1"){
				return '<span class="label label-success">在职</span>';
			}else{
				return '<span class="label label-default">已离职</span>';
			}
		}
		function fm_user_comprehensive(value,row, index){
			var cps = '<div class="icon-start icon-start-size-'+value+'" style="display:inline-block;" > <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>';
			return cps;
		}
		function user_queryParams(params){
			return $.extend({},params,util.serializeObject($('#user_searchForm')));
		}
		function user_search(){
			$("#user_table").bootstrapTable("refresh");
		}
		
		/* function fm_user_state(value,row, index){
			if(value==='01'||value==='02'||value==='04'||value==='11'){
				return '<span class="label label-danger">'+dict.trsltDict('05',value)+'</span>';
			}else if(value==='06'||value==='07'){
				return '<span class="label label-success">'+dict.trsltDict('05',value)+'</span>';
			}else{
				return '<span class="label label-default">'+dict.trsltDict('05',value)+'</span>';
			}
		} */
		
		</script>
</div>
