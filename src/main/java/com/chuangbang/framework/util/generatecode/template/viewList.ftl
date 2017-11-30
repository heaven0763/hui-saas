<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
<!--
 function fm_${className}_operate(value,row, index){
	
	return '<a href="${r"${ctx}"}/${moduleName}/${className}/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button type="button" onclick="${className}_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function chktable(value,row, index){
	return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
}

function fm_${className}_state(value,row, index){
	console.log(row.locked);
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
}
function ${className}_del_fun(id){
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
   	     	$.post('${r"${ctx}"}/${moduleName}/${className}/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			${className}_search();
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
//-->
</script>
<div class="wrapper wrapper-content">
	<div class="form-group">
		<a href="${r"${ctx}"}/${moduleName}/${className}/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="${className}_searchForm">
  <div class="form-group">
	<#list properties as prop>  
		<label for="${prop.name}">${prop.annotation}</label>
   		<input type="text" class="form-control" id="${prop.name}" name="search_EQ_${prop.name}" placeholder="请输入${prop.annotation}">
    </#list>
  </div>
  <button type="button" class="btn btn-info" onclick="${className}_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
</form>
	<table id="${className}_table" data-toggle="table" data-height="660" data-query-params="${className}_queryParams"
	data-pagination="true" data-url="${r"${ctx}"}/${moduleName}/${className}/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
				<#list properties as prop>  
					<th data-field="${prop.name}">${prop.annotation}</th>
		        </#list>
				<th data-formatter="fm_${className}_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function ${className}_queryParams(params){
	return $.extend({},params,util.serializeObject($('#${className}_searchForm')));
}

function ${className}_search(){
	$("#${className}_table").bootstrapTable("refresh");
}

</script>