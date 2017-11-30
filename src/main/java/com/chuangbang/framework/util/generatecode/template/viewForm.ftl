<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#${className}SubForm").validate({
        rules: {
        <#list properties as prop> 
        	${prop.name}: "required",
    	</#list>
        },
        messages: {
        <#list properties as prop> 
        	${prop.name}: e + "请输入${prop.annotation}",
    	</#list>
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				${className}_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
//-->
</script>
<div class="modal-body"> 
  
<form id="${className}SubForm" method="post" action="${r"${ctx}"}/${moduleName}/${className}/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${r"$"}{${className}.id}" />
  <#list properties as prop>  
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">${prop.annotation}</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="${prop.name}" data-options="required:true" value="${r"$"}{${className}.${prop.name}}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
   </#list>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

