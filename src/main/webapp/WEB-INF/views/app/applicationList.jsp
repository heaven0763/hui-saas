<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>应用管理</h3>
	<hr>
	<div class="form-group">
		<a href="${ctx}/base/app/application/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="application_searchForm">
	  <div class="form-group">
			<label for="appId">应用编号</label>
	   		<input type="text" class="form-control" id="appId" name="search_EQ_appId" placeholder="请输入应用编号">
			<label for="appName">应用名称</label>
	   		<input type="text" class="form-control" id="appName" name="search_LIKE_appName" placeholder="请输入应用名称">
			<label for="state">应用状态</label>
	   		<select class="form-control" name="search_EQ_state">
	   			<option value="1" selected="selected">使用中</option>
	   			<option value="0" >已停用</option>
	   		</select>
	  </div>
	  <button type="button" class="btn btn-primary" onclick="application_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="application_table" data-toggle="table" data-height="660" data-query-params="application_queryParams"
	data-pagination="true" data-url="${ctx}/base/app/application/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="appLogo" data-formatter="fm_application_logo">应用图标</th>
				<th data-field="appId">应用编号</th>
				<th data-field="appName">应用名称</th>
				<th data-field="appKey">应用标识</th>
				<th data-field="state" data-formatter="fm_application_state">应用状态</th>
				<!-- <th data-field="effectiveDate">应用有效日期</th> -->
				<th data-field="createDate">创建时间</th>
				<!-- <th data-field="memo">备注</th> -->
				<th data-formatter="fm_application_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>

	$(function() {
		$("#application_table").bootstrapTable();
	});
	function fm_application_operate(value, row, index) {

		return '<a href="${ctx}/base/app/application/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
				+ '&nbsp;&nbsp;<button type="button" onclick="application_del_fun(\''
				+ row.id + '\')" class="btn btn-primary"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
	}

	function fm_application_state(value, row, index) {
		if (value == "1") {
			return "使用中";
		} else {
			return "已停用";
		}
	}

	function fm_application_logo(value, row, index) {
		return '<img src="'+value+'" onerror="javascript:this.src=\'${ctx}/public/css/images/add-img.png\'" style="height: 32px; width: 32px;border-radius: 50%;" /> ';
	}
	function application_del_fun(id) {
		swal({
			title : "您确定要删除这条信息吗",
			text : "删除后将无法恢复，请谨慎操作！",
			type : "warning",
			showCancelButton : true,
			confirmButtonColor : "#DD6B55",
			confirmButtonText : "删除",
			cancelButtonText : "取消",
			closeOnConfirm : false,
			showLoaderOnConfirm : true
		}, function(isConfirm) {
			if (isConfirm) {
				parent.show();
				$
						.post('${ctx}/base/app/application/delete/' + id, "",
								function(res, status) {
									if (status == "success"
											&& res.statusCode == "200") {
										swal(res.message, "您已经永久删除了这条信息。",
												"success");
										application_search();
									} else {
										swal(res.message, "error");
									}
									parent.hide();
								}, 'json');
			} else {
				swal("已取消", "您取消了删除操作！", "error")
			}
		});

	}
	function application_queryParams(params) {
		return $.extend({}, params, util.serializeObject($('#application_searchForm')));
	}

	function application_search() {
		$("#application_table").bootstrapTable("refresh");
	}
</script>