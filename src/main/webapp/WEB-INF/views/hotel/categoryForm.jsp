<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#categorySubForm").validate({
        rules: {
        	kind: "required",
        	name: "required"
        },
        messages: {
        	kind: e + "请输入类型",
        	name: e + "请输入名称"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				category_search();
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
  
<form id="categorySubForm" method="post" action="${ctx}/base/hotel/category/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${category.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">父类型</label>
	     <div class="col-sm-9">
	     	<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="parentId" name="parentId" style="width: 180px;">
				<tags:dict sql="select id , name ,'' from hui_category where parent_id=0  " selectedValue="${category.parentId}" showPleaseSelect="true" addBefore="0,根类型"/>
			</select>
	    </div>
	  </div>
	  <div class="form-group form-inline" id="dvkind">
	    <label for="groupId" class="col-sm-3 control-label">种类</label>
	     <div class="col-sm-9">
	     	<select class="form-control" name="kind" style="width: 180px;">
	     		<tags:dict sql="select val , name ,'' from hui_category where kind='0' " selectedValue="${category.kind}" showPleaseSelect="true" addBefore="0,根种类"/>
	   		</select>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">名称</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="name" data-options="required:true" value="${category.name}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">详细值</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="val" data-options="required:true" value="${category.val}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="sortOrder" class="col-sm-3 control-label">排序编号</label>
	     <div class="col-sm-9">
	     	<input type="text" class="form-control" name="sortOrder" data-options="required:true" value="${category.sortOrder}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

