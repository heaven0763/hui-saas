<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$(document).ready(function(e) {
	   $('#selFile').localResizeIMG({
	      quality: 1,
	      before:function(){
	    	  parent.show();
	      },
	      success: function (result) {
			  var submitData={
				  base64Str:result.clearBase64,
				  dir:'suport'
				}; 
			 $.ajax({
			   type: "POST",
			   url: "${ctx}/account/user/upload/resizeimg",
			   data: submitData,
			   dataType:"json",
			   success: function(data){
				  parent.hide();
				 if (data.success) {
					$('input[name="logo"]').val(data.obj);
					$('#WX_icon').attr('src', data.obj);
					swal("上传成功", "success");
				 }else{
				  	swal(data.msg, "error");
					return false;
				 }
			   }, 
			   complete :function(XMLHttpRequest, textStatus){
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){ //上传失败 
					parent.hide();
					swal("AJAX ERROR", "error");
				}
			});
	      },
		  error:function(){ 
		  	parent.hide();
			swal("localResizeIMG ERROR", "error");
		  }
	  });
	});
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#supportingServicesSubForm").validate({
        rules: {
        	kind: "required",
        	name: "required"
        },
        messages: {
        	kind: e + "请输入服务类型",
        	name: e + "请输入服务名称"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				supportingServices_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
</script>
<div class="modal-body"> 
  
<form id="supportingServicesSubForm" method="post" action="${ctx}/base/hotel/supporting/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${supportingServices.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">服务类型</label>
	     <div class="col-sm-9">
	     	<select class="form-control" name="kind" style="width: 180px;">
	     		<tags:dict sql="select val , name ,'' from hui_category where kind='SUPPORT' " selectedValue="${supportingServices.kind}" showPleaseSelect="true"  />
	   		</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">服务名称</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="name" data-options="required:true" value="${supportingServices.name}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	 <%--  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">服务	logo</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="logo" data-options="required:true" value="${supportingServices.logo}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div> --%>
	  
	  <div class="form-group form-inline" style="height: 50px;">
		<label for="picurl" class="col-sm-3 control-label" style="margin-top: 25px; padding-left: 58px;">服务logo</label>
		<div class="col-sm-9">
			<div class="add"
				style="position: relative; margin-left: 1rem; height: 5.0rem; width: 5.0rem;">
				<img id="WX_icon" src="${supportingServices.logo}" onerror="javascript:this.src='${ctx}/public/css/images/add-img.png'" style="height: 5.0rem; width: 5.0rem;" /> 
					<input id="selFile" type="file" name="imgfile" style="position: absolute; top: 0; left: 0; opacity: 0; width: 100%; height: 100%;" />
				<input name="dir" type="hidden" value="supporting_service_logo">
				<input name="logo" type="hidden" value="${supportingServices.logo}">
			</div>
		</div>
	</div>
	  <%-- <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">父编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="parentId" data-options="required:true" value="${supportingServices.parentId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div> --%>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

