<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
function fm_${className}_Update(value, row) {
	return '<a href="${r"${ctx}"}/${moduleName}/${className}/update/#id#" class="btnEdit" target="dialog" width="${formWidth}" height="${formHeight}" title="修改">修改</a>';
}
function fm_${className}_Del(value, row) {
	return '<a href="${r"${ctx}"}/${moduleName}/${className}/delete/#id#" class="btnDel" target="ajaxTodo"  title="确定删除吗?">删除</a>';
}

$(function(){
	setTimeout(ready,0);
	
	function ready(){
	  var _self = new EEJ.DWZ.ListPanel();
      _self.bindDWZEvent();
	}
	
});
</script>
<div id="toolbar" style="padding:5px;height:auto" class="datagrid-toolbar">
	<a href="${r"${ctx}"}/${moduleName}/${className}/create" title="添加" target="dialog" width="${formWidth}" height="${formHeight}" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:false">添加</a>
   	<form id="searchForm">
		<table class="searchTable" style="width:100%">
			<tr>
				<#list properties as prop>  
				<#if prop.isSearchColunm == 1>
				<td style="width:80px;">${prop.annotation}</td>
				<td style="width:200px;">
					<input type="text" name="search_${prop.condition}_${prop.name}" style="width:180px;"/>
				</td>
				<#if (prop_index > 0) && (prop_index%2 == 1)>
			</tr>
			<tr>
				</#if>
				</#if>
			  	</#list>
				<td>
					<a href="javascript:void(0);" id="searchBtn" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
				</td>
			</tr>
		</table>
	</form>
 </div>
<div id="dgDiv" style="height:705px;width:100%;display:none;">
	<table id="dg" data-options="url:'${r"${ctx}"}/${moduleName}/${className}/list',fit:true,fitColumns:false">
		<thead>
	       <tr>
		   <#list properties as prop>  
	           <th data-options="field:'${prop.name}',width:'${prop.uiWidth}'">${prop.annotation}</th>
	       </#list>
	       	   <th data-options="field:'update',formatter:fm_${className}_Update,width:'60'">修改</th>
               <th data-options="field:'del',formatter:fm_${className}_Del,width:'60'">删除</th>
	       </tr>
	   </thead>
	</table>
</div>