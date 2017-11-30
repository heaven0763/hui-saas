<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#scheduleBookingSubForm").validate({
        rules: {
        	clientFrom: "required",
        	clientId: "required",
        	organizer: "required",
        	linkman: "required",
        	contactNumber: "required",
        	companySaleId: "required",
        	companySaleName: "required",
        	isdeposit: "required",
        	depositDate: "required",
        	createDate: "required",
        	memo: "required",
        },
        messages: {
        	clientFrom: e + "请输入客户来源",
        	clientId: e + "请输入客户编号",
        	organizer: e + "请输入活动主办单位",
        	linkman: e + "请输入联系人",
        	contactNumber: e + "请输入联系电话",
        	companySaleId: e + "请输入销售人员编号",
        	companySaleName: e + "请输入销售人员姓名",
        	isdeposit: e + "请输入是否已付定金",
        	depositDate: e + "请输入预定日期",
        	createDate: e + "请输入创建时间",
        	memo: e + "请输入备注",
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				scheduleBooking_search();
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
  
<form id="scheduleBookingSubForm" method="post" action="${ctx}/hotel/scheduleBooking/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${scheduleBooking.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">客户来源</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="clientFrom" data-options="required:true" value="${scheduleBooking.clientFrom}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">客户编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="clientId" data-options="required:true" value="${scheduleBooking.clientId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">活动主办单位</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="organizer" data-options="required:true" value="${scheduleBooking.organizer}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">联系人</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="linkman" data-options="required:true" value="${scheduleBooking.linkman}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">联系电话</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="contactNumber" data-options="required:true" value="${scheduleBooking.contactNumber}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">销售人员编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="companySaleId" data-options="required:true" value="${scheduleBooking.companySaleId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">销售人员姓名</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="companySaleName" data-options="required:true" value="${scheduleBooking.companySaleName}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">是否已付定金</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="isdeposit" data-options="required:true" value="${scheduleBooking.isdeposit}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">预定日期</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="depositDate" data-options="required:true" value="${scheduleBooking.depositDate}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">创建时间</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="createDate" data-options="required:true" value="${scheduleBooking.createDate}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="memo" data-options="required:true" value="${scheduleBooking.memo}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="modal-footer">
		<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
		<button type="submit" class="btn btn-primary" qx="schedule:booking"><span class="glyphicon glyphicon-save"></span> 保存</button>
	</div>
</form>
</div>

