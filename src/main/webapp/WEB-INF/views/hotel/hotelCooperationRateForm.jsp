<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body"> 
 <style>
 .line-height{height: 34px;line-height: 34px;}
 .help-block{display: inline;}    
 </style>
<form id="hotelCooperationRateSubForm" method="post" action="${ctx}/weixin/hotel/cooperationinfo/save"  class="form-horizontal m-t" >
  	  <input type="hidden" name="cpId" id="cpId" value="${hotelCooperationInfo.id}" />
	  <input type="hidden" name="hotelId" id="hotelId" value="${hotel.id}" />
	  <input type="hidden" name="hotelId" id="hotelId" value="${hotel.id}" />
	  <div class="form-group form-inline">
	    <label for="area" class="col-sm-2 control-label">地区</label>
	     <div class="col-sm-4 line-height" >
	     	${hotel.cityText}
	    </div>
	   <label for="hotelType" class="col-sm-2 control-label">场地类型</label>
	     <div class="col-sm-4 line-height">
	     	${hotel.hotelTypeText}
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="hotelName" class="col-sm-2 control-label">场地</label>
	     <div class="col-sm-10 line-height">
	     	${hotel.hotelName}
	    </div>
	   
	  </div>
	   <div class="form-group form-inline">
	    <label for="hotelName" class="col-sm-2 control-label">返佣类型</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationInfo.commissionType ne '2'?'全单返佣':'分项返佣'}
	    </div>
	     <label for="hotelName" class="col-sm-2 control-label">星级</label>
	     <div class="col-sm-4 line-height">
	     	${hotel.hotelStarText}
	    </div>
	  </div>
	  <c:if test="${hotelCooperationInfo.commissionType eq '1'}">
	   <div class="form-group form-inline">
	    <label for="afallCommissionRate" class="col-sm-2 control-label">全单返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationInfo.allCommission}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：<input type="number" class="form-control" name="afallCommissionRate" data-options="required:true" value="" style="width: 80px;" min="0" max="100"/>%
	    </div>
	  </div>
	  </c:if>
	  <c:if test="${hotelCooperationInfo.commissionType eq '2'}">
	  <div class="form-group form-inline">
	    <label for="afmettingRoomCommissionRate" class="col-sm-2 control-label">会场返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationInfo.mettingRoomCommission}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：<input type="number" class="form-control" name="afmettingRoomCommissionRate" data-options="required:true" value="" style="width: 80px;" min="0" max="100"/>%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="afhousingCommissionRate" class="col-sm-2 control-label">住房返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationInfo.housingCommission}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：<input type="number" class="form-control" name="afhousingCommissionRate" data-options="required:true" value="" style="width: 80px;" min="0" max="100"/>%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="afdinnerCommissionRate" class="col-sm-2 control-label">餐饮返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationInfo.dinnerCommission}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：<input type="number" class="form-control" name="afdinnerCommissionRate" data-options="required:true" value="" style="width: 80px;" min="0" max="100"/>%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="afortherCommissionRate" class="col-sm-2 control-label">其他返佣比例</label>
	     <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationInfo.ortherCommission}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：<input type="number" class="form-control" name="afortherCommissionRate" data-options="required:true" value="" style="width: 80px;" min="0" max="100"/>%
	    </div>
	  </div>
	  </c:if>
	 
	  
	  <div class="form-group form-inline">
	    <label for="applyReason" class="col-sm-2 control-label">调整原因</label>
	     <div class="col-sm-10">
	     	<textarea  class="form-control" name="applyReason" rows="5" style="width: 100%;"></textarea>
	    </div>
	  </div>
	  <div class="modal-footer">
		<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
		<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 提交保存</button>
	</div>
</form>
<script type="text/javascript">
$().ready(function() {
   var e = "<i class='fa fa-times-circle'></i> ";
   
	$("#hotelCooperationRateSubForm").validate({
       rules: {
    	afallCommission: "required",
    	afhousingCommissionRate: "required",
       	afdinnerCommissionRate: "required",
       	afmettingRoomCommissionRate: "required",
       	afortherCommissionRate: "required"
       },
       messages: {
    	afallCommission: e + "请输入全单返佣",
    	afhousingCommissionRate: e + "请输入住房返佣",
       	afdinnerCommissionRate: e + "请输入餐饮返佣",
       	afmettingRoomCommissionRate: e + "请输入会议室返佣",
       	afortherCommissionRate: e + "请输入其他返佣"
       },
       submitHandler: function(form) {
           var url = $(form).attr("action");
           var data = $(form).serialize();
           parent.show();
      　	   $.post(url, data, function (res, status) { 
      　			if(status=="success"&&res.statusCode=="200"){
      　				$('#close_btn').click();
      　				swal(res.message, "success");
      　			}else{
      　				swal(res.message, "error");
      　			}
      　			parent.hide();
      　		}, 'json'); 
        }  
   });
	
});
</script>
</div>

