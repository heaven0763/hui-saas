<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#orderPayedRecordSubForm").validate({
        rules: {
        	hotelId: "required",
        	orderId: "required",
        	type: "required",
        	amount: "required",
        	payAmount: "required",
        	unpayAmount: "required",
        	payedAmount: "required",
        	payDate: "required",
        	payedUserId: "required",
        	createDate: "required",
        	memo: "required",
        },
        messages: {
        	hotelId: e + "请输入所属场地",
        	orderId: e + "请输入订单编号",
        	type: e + "请输入付款类型",
        	amount: e + "请输入订单金额",
        	payAmount: e + "请输入付款金额",
        	unpayAmount: e + "请输入未付款金额",
        	payedAmount: e + "请输入已付款金额",
        	payDate: e + "请输入付款时间",
        	payedUserId: e + "请输入创建人员编号",
        	createDate: e + "请输入创建日期",
        	memo: e + "请输入创建日期",
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				orderPayedRecord_search();
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
  
<form id="orderPayedRecordSubForm" method="post" action="${ctx}/order/orderPayedRecord/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${orderPayedRecord.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">所属场地</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="hotelId" data-options="required:true" value="${orderPayedRecord.hotelId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">订单编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="orderId" data-options="required:true" value="${orderPayedRecord.orderId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">付款类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="type" data-options="required:true" value="${orderPayedRecord.type}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">订单金额</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="amount" data-options="required:true" value="${orderPayedRecord.amount}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">付款金额</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="payAmount" data-options="required:true" value="${orderPayedRecord.payAmount}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">未付款金额</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="unpayAmount" data-options="required:true" value="${orderPayedRecord.unpayAmount}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">已付款金额</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="payedAmount" data-options="required:true" value="${orderPayedRecord.payedAmount}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">付款时间</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="payDate" data-options="required:true" value="${orderPayedRecord.payDate}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">创建人员编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="payedUserId" data-options="required:true" value="${orderPayedRecord.payedUserId}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">创建日期</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="createDate" data-options="required:true" value="${orderPayedRecord.createDate}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">创建日期</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="memo" data-options="required:true" value="${orderPayedRecord.memo}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

