<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
 #hotelCooperationInfoSubForm input[type="text"]{width: 400px;}
 #hotelCooperationInfoSubForm select{width: 180px;}
</style>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
	                   <div class="" style="position:relative;border: none;">
	                   		<div style="position: absolute;right: 10px;">
	                   			<a href="javascript:loadContent(this,'${ctx}/base/hotel/cooperationinfo/index','');" class="btn btn-warning"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                   		</div>
	                       <h3>${action }场地合作信息</h3>
	                       <hr>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
								<form id="hotelCooperationInfoSubForm" method="post" action="${ctx}/base/hotel/cooperationinfo/save"  class="form-horizontal m-t" ><!--   -->
								  	  <input type="hidden" name="id" id="id" value="${hotelCooperationInfo.id}" />
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">所属场地</label>
									    <div class="col-sm-10">
									    	<c:if test="${empty hotelCooperationInfo.id}">
										     <select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" style="width:200px;" onchange="selHotel(this.value);">
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
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" id="linkman" name="linkman" data-options="required:true" value="${hotelCooperationInfo.linkman}"  />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">联系固话</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" id="linkPhone" name="linkPhone" data-options="required:true" value="${hotelCooperationInfo.linkPhone}"  />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">联系手机</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" id="linkMobile" name="linkMobile" data-options="required:true" value="${hotelCooperationInfo.linkMobile}"  />
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="commissionRights" class="col-sm-2 control-label">返佣权限归属</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionRights1" name="commissionRights" value="1" ${hotelCooperationInfo.commissionRights ne '2'?'checked=\"checked\"':'' } >
		                                        <label for="commissionRights1"> 场地 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionRights2" name="commissionRights" value="2" ${hotelCooperationInfo.commissionRights eq '2'?'checked=\"checked\"':'' }>
		                                        <label for="commissionRights2"> 集团  </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="commissionBelong" class="col-sm-2 control-label">返佣归属</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionBelong1" name="commissionBelong" value="1" ${hotelCooperationInfo.commissionBelong ne '2'?'checked=\"checked\"':'' } >
		                                        <label for="commissionBelong1"> 会掌柜 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionBelong2" name="commissionBelong" value="2" ${hotelCooperationInfo.commissionBelong eq '2'?'checked=\"checked\"':'' }>
		                                        <label for="commissionBelong2"> 第三方平台  </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="agreementDate" class="col-sm-2 control-label">协议有效日期</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control layer-date laydate-icon" id="agreementSDate" name="agreementSDate" data-options="required:true" value="${hotelCooperationInfo.agreementSDate}"  />
									     	~ <input type="text" class="form-control layer-date laydate-icon" id="agreementEDate" name="agreementEDate" data-options="required:true" value="${hotelCooperationInfo.agreementEDate}"  />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="commissionType" class="col-sm-2 control-label">返佣类型</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionType1" name="commissionType" value="1" ${hotelCooperationInfo.commissionType ne '2'?'checked=\"checked\"':'' } onchange="commissionTypeChange(this);" >
		                                        <label for="commissionType1">全单返佣 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="commissionType2" name="commissionType" value="2" ${hotelCooperationInfo.commissionType eq '2'?'checked=\"checked\"':'' } onchange="commissionTypeChange(this);">
		                                        <label for="commissionType2"> 分项返佣 </label>
		                                    </div>
									    </div>
									  </div>
									  <c:if test="${empty hotelCooperationInfo.id }">
									  		 <div class="form-group form-inline commissionType1">
											    <label for="allCommission" class="col-sm-2 control-label">全单返佣</label>
											     <div class="col-sm-10">
											     	<input type="number" class="form-control" name="allCommission" data-options="required:true" value="${hotelCooperationInfo.allCommission}" min="0" max="100"  /> %
											    </div>
											  </div>
											  <div class="form-group form-inline commissionType2">
											    <label for="groupId" class="col-sm-2 control-label">住房返佣</label>
											     <div class="col-sm-10">
											     	<input type="number" class="form-control" name="housingCommission" data-options="required:true" value="${hotelCooperationInfo.housingCommission}" min="0" max="100"  /> %
											    </div>
											  </div>
											  <div class="form-group form-inline commissionType2">
											    <label for="groupId" class="col-sm-2 control-label">餐饮返佣</label>
											     <div class="col-sm-10">
											     	<input type="number" class="form-control" name="dinnerCommission" data-options="required:true" value="${hotelCooperationInfo.dinnerCommission}" min="0" max="100"  /> %
											    </div>
											  </div>
											  <div class="form-group form-inline commissionType2">
											    <label for="groupId" class="col-sm-2 control-label">会场返佣</label>
											     <div class="col-sm-10">
											     	<input type="number" class="form-control" name="mettingRoomCommission" data-options="required:true" value="${hotelCooperationInfo.mettingRoomCommission}" min="0" max="100" /> %
											    </div>
											  </div>
											  <div class="form-group form-inline commissionType2">
											    <label for="groupId" class="col-sm-2 control-label">其他返佣</label>
											     <div class="col-sm-10">
											     	<input type="number" class="form-control" name="ortherCommission" data-options="required:true" value="${hotelCooperationInfo.ortherCommission}" min="0" max="100" /> %
											    </div>
											  </div>
									  </c:if>
									  <c:if test="${not empty hotelCooperationInfo.id && hotelCooperationInfo.commissionType ne '2'}">
										   <div class="form-group form-inline">
										    <label for="allCommission" class="col-sm-2 control-label">全单返佣</label>
										     <div class="col-sm-4">
										     	<span class="form-control">${hotelCooperationInfo.allCommission}% </span>
										    </div>
										  </div>
										  </c:if>
										  <c:if test="${not empty hotelCooperationInfo.id && hotelCooperationInfo.commissionType eq '2'}">
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
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isPoints1" name="isPoints" value="1" ${hotelCooperationInfo.isPoints ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="isPoints1">是 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isPoints2" name="isPoints" value="0" ${hotelCooperationInfo.isPoints eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="isPoints2"> 否 </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="pointsRate" class="col-sm-2 control-label">积分计算比例</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="pointsRate" data-options="required:true" value="${hotelCooperationInfo.pointsRate}" min="0" max="100" /> %
									    </div>
									  </div>
									   <%-- <div class="form-group form-inline">
									    <label for="reclaimUserId" class="col-sm-2 control-label">场地开拓销售</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="reclaimUserId" data-options="required:true" value="${hotelCooperationInfo.reclaimUserId}"  />
									     	 <select class="form-control"  id="reclaimUserId" name="reclaimUserId" style="width:200px;">
												<tags:dict sql="SELECT id,rname as name FROM hui_user where user_type = 'HUI' "  showPleaseSelect="true" selectedValue="${hotelCooperationInfo.reclaimUserId}"/>
											 </select>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">备注</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="memo" data-options="required:true" value="${hotelCooperationInfo.memo}"  />
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label"></label>
									     <div class="col-sm-10">
									     	<button type="submit" class="btn btn-primary" style="width: 160px;"><span class="glyphicon glyphicon-save"></span> 保存</button>
									    </div>
									  </div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 表单临时保存 -->
	<script>
		<c:if test="${empty hotelCooperationInfo.id}">
	     $(function () {
	        var localMsg;
	        if(window.localStorage.hotelCooperationInfoFormHistory){
	            localMsg=JSON.parse(window.localStorage.hotelCooperationInfoFormHistory);
	        }
	        if(localMsg && localMsg.length>=1){
	            var realIndex=0;
	            for(var i=0;i<$('#hotelCooperationInfoSubForm input').length;i++){
	                if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='text'){
	                    $($('#hotelCooperationInfoSubForm input')[i]).val(localMsg[realIndex].text);
	                    realIndex++;
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='radio'){
	                    $($('#hotelCooperationInfoSubForm input')[i]).prop('checked',localMsg[realIndex].radio);
	                    realIndex++;
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='checkbox'){
	                    $($('#hotelCooperationInfoSubForm input')[i]).prop('checked',localMsg[realIndex].checkbox);
	                    realIndex++;
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='number'){
	                	 $($('#hotelCooperationInfoSubForm input')[i]).val(localMsg[realIndex].number);
	                    realIndex++;
	                }
	            }
	            for(var i=0;i<$('#hotelCooperationInfoSubForm select').length;i++){
	            	$($('#hotelCooperationInfoSubForm select')[i]).val(localMsg[realIndex].text);
	            	realIndex++;
	            }
	        }
	       
	        var idInt = setInterval(function(){
	        	var history=[];
	            window.localStorage.hotelCooperationInfoFormHistory='';
	            for(var i=0;i<$('#hotelCooperationInfoSubForm input').length;i++){
	                if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='text'){
	                    history.push({"text":$($('#hotelCooperationInfoSubForm input')[i]).val()});
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='radio'){
	                    history.push({"radio":$($('#hotelCooperationInfoSubForm input')[i]).attr('checked') ? 'checked' :''});
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='checkbox'){
	                    history.push({"checkbox":$($('#hotelCooperationInfoSubForm input')[i]).attr('checked') ? 'checked' :''});
	                }else if($($('#hotelCooperationInfoSubForm input')[i])[0].type=='number'){
	                	history.push({"number":$($('#hotelCooperationInfoSubForm input')[i]).val()});
	                }
	            }
	            for(var i=0;i<$('#hotelCooperationInfoSubForm select').length;i++){
	            	history.push({"text":$($('#hotelCooperationInfoSubForm select')[i]).val()});
	            }
	            window.localStorage.hotelCooperationInfoFormHistory=JSON.stringify(history);
	        },5000);
	    });
	     </c:if>
	     
	     $().ready(function() {
	    	 var commissionType ='${hotelCooperationInfo.commissionType}'; 
	    	 if(commissionType!=2){
	    		$(".commissionType1").show();
	    		$(".commissionType2").hide();
	    	 }else{
	    		$(".commissionType2").show();
	    		$(".commissionType1").hide();
	    	 }
	    	 var agreementSDate={elem:"#agreementSDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	    	 var agreementEDate={elem:"#agreementEDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	    	 laydate(agreementSDate);
	    	 laydate(agreementEDate);
	    	 $('.selectpicker').selectpicker();
	    	   
	        var e = "<i class='fa fa-times-circle'></i> ";
	    	$("#hotelCooperationInfoSubForm").validate({
	            rules: {
	            	hotelId: "required",
	            	commissionRights: "required",
	            	reclaimUserId: "required",
	            	linkman: "required",
	            	linkPhone: "required",
	            	linkMobile: "required",
	            	agreementDate: "required",
	            	commissionBelong: "required",
	            	commissionType: "required",
	            	allCommission: "required",
	            	housingCommission: "required",
	            	dinnerCommission: "required",
	            	mettingRoomCommission: "required",
	            	ortherCommission: "required"
	            },
	            messages: {
	            	hotelId: e + "请选择所属场地",
	            	commissionRights: e + "请输入返佣权限归属",
	            	reclaimUserId: e + "请选择场地开拓销售",
	            	linkman: e + "请输入联系人",
	            	linkPhone: e + "请输入联系固话",
	            	linkMobile: e + "请输入联系手机",
	            	agreementDate: e + "请输入协议有效日期",
	            	commissionBelong: e + "请输入返佣归属",
	            	commissionType: e + "请选择返佣类型",
	            	allCommission: e + "请输入全单返佣",
	            	housingCommission: e + "请输入住房返佣",
	            	dinnerCommission: e + "请输入餐饮返佣",
	            	mettingRoomCommission: e + "请输入会议室返佣",
	            	ortherCommission: e + "请输入其他返佣"
	            },
	            submitHandler: function(form) {
	                var url = $(form).attr("action");
	                var data = $(form).serialize();
	                parent.show();
	           　		$.post(url, data, function (res, status) { 
	           　			if(status=="success"&&res.statusCode=="200"){
	           　				window.localStorage.hotelCooperationInfoFormHistory='';
	           　				$('#close_btn').click();
	           　				swal(res.message, "success");
	           　				loadContent(this,'${ctx}/base/hotel/cooperationinfo/index','');
	           　			}else{
	           　				swal(res.message, "error");
	           　			}
	           　			parent.hide();
	           　		}, 'json'); 
	             }  
	        });
	    	
	    });
	     
	    function selHotel(hotelId){
	    	var url = "${ctx}/base/hotel/gethotel/"+hotelId;
	    	$.post(url,"",function(res){
	    		$("#linkman").val(res.obj.contact);
	    		$("#linkPhone").val(res.obj.telephone.split(',')[0]);
	    		$("#linkMobile").val(res.obj.mobile);
	    	},"json");
	    }
	    
	    function commissionTypeChange(self){
	    	var $this = $(self);
	    	if($this.val()==1){
	    		$(".commissionType1").show();
	    		$(".commissionType2").hide();
	    	}else{
	    		$(".commissionType2").show();
	    		$(".commissionType1").hide();
	    	}
	    }
	</script>

