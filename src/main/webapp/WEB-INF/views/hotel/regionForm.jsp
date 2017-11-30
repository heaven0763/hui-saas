<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#regionSubForm").validate({
        rules: {
        	parentId: "required",
        	regionName: "required"
        },
        messages: {
        	parentId: e + "请输入父编号",
        	regionName: e + "请输入区域名称"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				region_search();
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
  
<form id="regionSubForm" method="post" action="${ctx}/base/hotel/region/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${region.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">父编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="parentId" data-options="required:true" value="${region.parentId}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">区域名称</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="regionName" data-options="required:true" value="${region.regionName}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">区域类型</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="regionType" data-options="required:true" value="${region.regionType}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">代理编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="agencyId" data-options="required:true" value="${region.agencyId}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">字目</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="zimu" data-options="required:true" value="${region.zimu}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">热门</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="isHot" data-options="required:true" value="${region.isHot}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">推荐</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="isTui" data-options="required:true" value="${region.isTui}" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">排序编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="sortOrder" data-options="required:true" value="${region.sortOrder}" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

