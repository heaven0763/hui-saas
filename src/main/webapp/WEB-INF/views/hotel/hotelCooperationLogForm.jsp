<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body"> 
 <style>
 .form-inline{border-bottom: 1px solid #f5f5f5;}
 .form-horizontal .form-inline:last-child {border:0;}
 .line-height{height: 34px;line-height: 34px;}
 </style>
<form id="hotelCooperationLogSubForm" method="post" action="${ctx}/hotel/hotelCooperationLog/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${hotelCooperationLog.id}" />
	  
	  <div class="form-group form-inline">
	    <label for="area" class="col-sm-2 control-label">地区</label>
	     <div class="col-sm-4 line-height">
	     	${hotel.cityText}
	    </div>
	   <label for="hotelType" class="col-sm-2 control-label">场地类型</label>
	     <div class="col-sm-4 line-height">
	     	${hotel.hotelTypeText}
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="hotelName" class="col-sm-2 control-label">场地</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.hotelName}
	    </div>
	    <label for="hotelName" class="col-sm-2 control-label">星级</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.star}
	    </div>
	  </div>
	  <c:if test="${hotelCooperationLog.type eq '1'}">
	  <div class="form-group form-inline">
	    <label for="bfallCommissionRate" class="col-sm-2 control-label">全单返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationLog.bfallCommissionRate}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：${hotelCooperationLog.afallCommissionRate}%
	    </div>
	  </div>
	  </c:if>
	    <c:if test="${hotelCooperationLog.type eq '2'}">
	  <div class="form-group form-inline">
	    <label for="bfmettingRoomCommissionRate" class="col-sm-2 control-label">会议室返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationLog.bfmettingRoomCommissionRate}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：${hotelCooperationLog.afmettingRoomCommissionRate}%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="bfhousingCommissionRate" class="col-sm-2 control-label">住房返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationLog.bfhousingCommissionRate}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：${hotelCooperationLog.afhousingCommissionRate}%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="bfdinnerCommissionRate" class="col-sm-2 control-label">餐饮返佣比例</label>
	    <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationLog.bfdinnerCommissionRate}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：${hotelCooperationLog.afdinnerCommissionRate}%
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="bfortherCommissionRate" class="col-sm-2 control-label">其他返佣比例</label>
	     <div class="col-sm-6 line-height">
	     	调整前：${hotelCooperationLog.bfortherCommissionRate}%
	    </div>
	     <div class="col-sm-4 line-height">
	     	调整后：${hotelCooperationLog.afortherCommissionRate}%
	    </div>
	  </div>
	  </c:if>
	  <div class="form-group form-inline">
	    <label for="applyUserName" class="col-sm-2 control-label">提交人</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.applyUserName}
	    </div>
	     <label for="applyUserName" class="col-sm-2 control-label">提交日期</label>
	    <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.applyDate}
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="applyReason" class="col-sm-2 control-label">调整原因</label>
	     <div class="col-sm-10 line-height">
	     	${hotelCooperationLog.applyReason}
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="state" class="col-sm-2 control-label">状态</label>
	     <div class="col-sm-10 line-height">
	     	${hotelCooperationLog.state eq '0'?'未审核':hotelCooperationLog.state eq '1'?'审核通过':'审核不通过'}
	    </div>
	  </div>
	  <c:if test="${hotelCooperationLog.state ne '0' }">
	  <div class="form-group form-inline">
	    <label for="checkUserName" class="col-sm-2 control-label">审核人员</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.checkUserName}
	    </div>
	      <label for="applyUserName" class="col-sm-2 control-label">审核日期</label>
	    <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.checkDate}
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="checkMemo" class="col-sm-2 control-label">审核备注</label>
	     <div class="col-sm-4 line-height">
	     	${hotelCooperationLog.checkMemo}
	    </div>
	  </div>
	  </c:if>
	  <div class="form-group form-inline">
	    <label for="groupId" class="col-sm-2 control-label">备注</label>
	     <div class="col-sm-10 line-height">
	     	${hotelCooperationLog.memo}
	    </div>
	  </div>
  <div class="modal-footer">
	<button type="button" class="btn btn-default" id="cooperationinfo_close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	 <c:if test="${hotelCooperationLog.state eq '0' }">
		<button type="button" onclick="nopass('${hotelCooperationLog.id}');" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 审核不通过</button>
		<button type="button" onclick="pass('${hotelCooperationLog.id}');"class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 审核通过</button>
	</c:if>
</div>
</form>
<script type="text/javascript">
function nopass(id){
	show();
	$.post('${ctx}/weixin/hotel/cooperationinfo/site/rebate/check/nopass/'+id,{},function(res){
		if(res.statusCode==='200'){
			hotelCooperationLog_search();
			$("#cooperationinfo_close_btn").click();
			swal(res.message, "success");
		}else{
			swal(res.message, "error");
		}
		hide();
	},'json');
}

function pass(id){
	show();
	$.post('${ctx}/weixin/hotel/cooperationinfo/site/rebate/check/pass/'+id,{},function(res){
		if(res.statusCode==='200'){
			hotelCooperationLog_search();
			$("#cooperationinfo_close_btn").click();
			swal(res.message, "success");
		}else{
			swal(res.message, "error");
		}
		hide();
	},'json');
}
</script>
</div>

