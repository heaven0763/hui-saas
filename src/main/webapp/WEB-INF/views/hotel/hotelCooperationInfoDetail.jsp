<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
 #hotelCooperationInfoSubForm input[type="text"]{width: 400px;}
 #hotelCooperationInfoSubForm select{width: 180px;}
</style>
<div class="modal-body">
    <div class="row">
		<div class="col-sm-12">
			<form  method="post"   class="form-horizontal m-t" >
		  	  <input type="hidden" name="id" id="id" value="${hotelCooperationInfo.id}" />
			  <div class="form-group form-inline">
			    <label for="groupId" class="col-sm-2 control-label">所属场地</label>
			    <div class="col-sm-10">
			    	<c:if test="${empty hotelCooperationInfo.id}">
				     <select class="form-control"  id="hotelId" name="hotelId" style="width:200px;" onchange="selHotel(this.value);">
						<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="true" selectedValue="${hotelCooperationInfo.hotelId}"/>
					 </select>
					 </c:if>
					 <c:if test="${not empty hotelCooperationInfo.id}">
						 <input type="hidden" name="hotelId" id="hotelId" value="${hotelCooperationInfo.hotelId}" />
						 <span class="form-control">${hotelCooperationInfo.hotelName}</span>
					 </c:if>
			    </div>
			  </div>
			   <div class="form-group form-inline">
			  	<label for="groupId" class="col-sm-2 control-label">联系人</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.linkman}</span>
			    </div>
			    <label for="commissionType" class="col-sm-2 control-label">返佣类型</label>
			     <div class="col-sm-4">
			     		<span class="form-control">${hotelCooperationInfo.commissionType ne '2'?'全单返佣':'分项返佣' }</span>
			    </div>
			  </div>
			  <div class="form-group form-inline">
			    <label for="groupId" class="col-sm-2 control-label">联系固话</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.linkPhone}</span>
			    </div>
			    <label for="groupId" class="col-sm-2 control-label">联系手机</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.linkMobile}</span>
			    </div>
			  </div>
			   <div class="form-group form-inline">
			    <label for="commissionRights" class="col-sm-2 control-label">返佣权限归属</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.commissionRights ne '2'?'场地':'集团' }</span>
			    </div>
			    <label for="commissionBelong" class="col-sm-2 control-label">返佣归属</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.commissionBelong ne '2'?'场地':'集团' }</span>
			    </div>
			  </div>
			  
			  <div class="form-group form-inline">
			    <label for="agreementDate" class="col-sm-2 control-label">协议有效日期</label>
			     <div class="col-sm-10">
			     	<span class="form-control" style="width: auto;">${hotelCooperationInfo.agreementSDate} ~ ${hotelCooperationInfo.agreementEDate}</span>
			    </div>
			  </div>
			  <c:if test="${hotelCooperationInfo.commissionType ne '2'}">
			   <div class="form-group form-inline">
			    <label for="allCommission" class="col-sm-2 control-label">全单返佣</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.allCommission}% </span>
			    </div>
			  </div>
			  </c:if>
			  <c:if test="${hotelCooperationInfo.commissionType eq '2'}">
			  <div class="form-group form-inline">
			     <label for="groupId" class="col-sm-2 control-label">会场返佣</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.mettingRoomCommission}% </span>
			    </div>
			    <label for="groupId" class="col-sm-2 control-label">住房返佣</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.housingCommission}% </span>
			    </div>
			  </div>
			  <div class="form-group form-inline">
			    <label for="groupId" class="col-sm-2 control-label">餐饮返佣</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.dinnerCommission}% </span>
			    </div>
			    <label for="groupId" class="col-sm-2 control-label">其他返佣</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.ortherCommission}% </span>
			    </div>
		     </div>
		     </c:if>
			  <div class="form-group form-inline">
			    <label for="isPoints" class="col-sm-2 control-label">是否参与积分</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.isPoints ne '0'?'是':'否' }  </span>
			    </div>
			 
			    <label for="pointsRate" class="col-sm-2 control-label">积分计算比例</label>
			     <div class="col-sm-4">
			     	<span class="form-control">${hotelCooperationInfo.pointsRate}% </span>
			    </div>
			    </div>
			    <div class="form-group form-inline">
			    <label for="groupId" class="col-sm-2 control-label">备注</label>
			     <div class="col-sm-10">
			     	<span class="form-control">${hotelCooperationInfo.memo} </span>
			    </div>
			  </div>
			   <div class="modal-footer">
					<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
				</div>
			  </form>
		</div>
	</div>
</div>
