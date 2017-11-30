<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
	$(function(){
		setTimeout(ready,0);
		
		function ready(){
			var _self = new EEJ.DWZ.Dialog();
			_self.bindDWZEvent();
		}
		
	});
</script>
<div style="width: 100%; height: 100%;">
	<form id="subForm" action="${r"${ctx}"}/${moduleName}/${className}/save" method="post">
		<input type="hidden" name="id" value="${r"$"}{${className}.id}" />
		<div>
			<table class="table" style="width: 100%;">
				<#list properties as prop>  
				<tr>
					<td>${prop.annotation}</td>
					<td>
						<input type="text" name="${prop.name}" class="easyui-validatebox" data-options="required:true" value="${r"$"}{${className}.${prop.name}}" />
					</td>
				</tr>
		       </#list>
			</table>
		</div>
		<div class="dialog-button">
			<a id="submit" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			<a id="close" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭</a>
		</div>
	</form>
</div>