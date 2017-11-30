<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
<!--
$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#huiLogSubForm").validate({
        rules: {
        	opuid: "required",
        	opuname: "required",
        	opitemtype: "required",
        	opitemid: "required",
        	optype: "required",
        	optime: "required",
        	optitle: "required",
        	opcontent: "required",
        	ophost: "required",
        	memo: "required",
        },
        messages: {
        	opuid: e + "请输入操作人员编号",
        	opuname: e + "请输入操作人员姓名",
        	opitemtype: e + "请输入操作对象类型",
        	opitemid: e + "请输入操作对象编号",
        	optype: e + "请输入操作动作类型",
        	optime: e + "请输入操作时间",
        	optitle: e + "请输入操作主题",
        	opcontent: e + "请输入操作内容",
        	ophost: e + "请输入IP地址",
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
       　				huiLog_search();
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
  
<form id="huiLogSubForm" method="post" action="${ctx}/log/huiLog/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${huiLog.id}" />
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作人员编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="opuid" data-options="required:true" value="${huiLog.opuid}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作人员姓名</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="opuname" data-options="required:true" value="${huiLog.opuname}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作对象类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="opitemtype" data-options="required:true" value="${huiLog.opitemtype}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作对象编号</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="opitemid" data-options="required:true" value="${huiLog.opitemid}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作动作类型</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="optype" data-options="required:true" value="${huiLog.optype}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作时间</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="optime" data-options="required:true" value="${huiLog.optime}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作主题</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="optitle" data-options="required:true" value="${huiLog.optitle}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">操作内容</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="opcontent" data-options="required:true" value="${huiLog.opcontent}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">IP地址</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="ophost" data-options="required:true" value="${huiLog.ophost}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-3 control-label">备注</label>
	     <div class="col-sm-9">
	     	<inputtype="text" class="form-control" name="memo" data-options="required:true" value="${huiLog.memo}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
</div>

