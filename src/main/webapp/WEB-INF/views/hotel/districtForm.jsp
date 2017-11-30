<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#districtSubForm").validate({
        rules: {
        	regionId: "required",
        	district: "required"
        },
        messages: {
        	regionId: e + "请输入地区编号	",
        	district: e + "请输入商圈名称"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				district_search();
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
  
<form id="districtSubForm" method="post" action="${ctx}/base/hotel/district/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${district.id}" />
	  <div class="form-group form-inline">
	    <label for="regionId" class="col-sm-3 control-label">地区编号	</label>
	     <div class="col-sm-9">
	     	<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="regionId" name="regionId" style="width: 200px;">
				<tags:dict sql="select id , region_name ,'' from hui_region where region_type=2 " showPleaseSelect="true" />
			</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="district" class="col-sm-3 control-label">商圈名称</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" id="district" name="district" data-options="required:true" value="${district.district}"  style="width: 200px;"/>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="sortOrder" class="col-sm-3 control-label">排序编号</label>
	     <div class="col-sm-9">
	     	<input type="text" id="sortOrder" class="form-control" name="sortOrder" data-options="required:true" value="${district.sortOrder}"  style="width: 200px;"/>
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

