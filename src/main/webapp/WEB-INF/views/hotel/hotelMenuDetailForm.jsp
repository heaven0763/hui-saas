<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelMenuDetailSubForm").validate({
        rules: {
        	menuId: "required",
        	name: "required",
        	price: "required"
        },
        messages: {
        	menuId: e + "请输入菜单编号",
        	name: e + "请输入菜名",
        	price: e + "请输入价格"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				hotelMenuDetail_search();
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
  
<form id="hotelMenuDetailSubForm" method="post" action="${ctx}/base/hotel/menu/detail/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${hotelMenuDetail.id}" />
  <input type="hidden" name="menuId" id="menuId" value="${hotelMenu.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">菜单名称</label>
	     <div class="col-sm-10">
	     	<span class="form-control">${hotelMenu.name }</span>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">菜名</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="name" data-options="required:true" value="${hotelMenuDetail.name}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">价格</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="price" data-options="required:true" value="${hotelMenuDetail.price}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	 <%-- <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">介绍</label>
	     <div class="col-sm-10">
	     	<textarea class="form-control" name="introduction" style="width: 600px;height: 100px;" >${hotelMenuDetail.introduction}</textarea>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">备注</label>
	     <div class="col-sm-10">
	     	<textarea class="form-control" name="memo" style="width: 600px;height: 80px;">${hotelMenuDetail.memo}</textarea>
	    </div>
	  </div> --%>
	
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

