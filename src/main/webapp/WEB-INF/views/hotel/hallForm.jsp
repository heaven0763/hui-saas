<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
 #hallSubForm input[type="text"]{width: 300px;}
  #hallSubForm input[type="number"]{width: 100px;}
 #hallSubForm select{width: 180px;}
</style>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class="" style="position: relative;">
	                   		<a href="javascript:loadHotelContent(this,'${ctx}/base/hotel/hall/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                       <h3>${action }会场信息</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
							<form id="hallSubForm" method="post" action="${ctx}/base/hotel/hall/save"  class="form-horizontal m-t" ><!--   -->
							  	<input type="hidden" name="id" id="id" value="${hall.id}" />
							  	 <input type="hidden" name="placeType" id="placeType" value="${empty hall.id?'HALL':hall.placeType}">
							  	  <c:if test="${not empty mhotel }">
							  	  	<input type="hidden" name="hotelId" id="hotelId" value="${mhotel.id}" />
							  	  </c:if>
								 <c:if test="${empty mhotel }">
								  <div class="form-group form-inline">
								    <label for="hotelId" class="col-sm-2 control-label">所属场地</label>
								     <div class="col-sm-10">
										<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
							     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" >
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${hall.hotelId}" showPleaseSelect="true"/>
											</select> 
								     	</c:if>
								     	<c:if test="${aUs.getCurrentUserType() eq 'partner' }">
							     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" >
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}" selectedValue="${hall.hotelId}" showPleaseSelect="true"/>
											</select> 
								     	</c:if>
								    </div>
								  </div>
								  </c:if>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">会场名称</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="placeName" data-options="required:true" value="${hall.placeName}"  />
								    </div>
								  </div>
								<%--    <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">掌柜价</label> 
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="zguiPrice" data-options="required:true" value="${hall.zguiPrice}"  /> 元
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">场地价格</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="hotelPrice" data-options="required:true" value="${hall.hotelPrice}"  /> 元
								    </div>
								  </div> --%>
								  <div class="form-group form-inline">
								    <label for="recommendedIndex" class="col-sm-2 control-label">推荐指数</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="recommendedIndex" data-options="required:true" value="${hall.recommendedIndex}"  />
								    </div>
								  </div>
								<%--    <div class="form-group form-inline">
								    <label for="description" class="col-sm-2 control-label">会场说明</label>
								     <div class="col-sm-10">
								     	<textarea id="description" class="form-control" name="description" style="width: 100%;height: 50;">${hall.description}</textarea>
								    </div>
								  </div> --%>
							    <div class="form-group form-inline">
								    <label for="introduction" class="col-sm-2 control-label">会场介绍</label>
								     <div class="col-sm-10">
								     	<script id="introduction" name="introduction" type="text/plain" style="width:100%;height:500px;">${hall.introduction}</script>
								    </div>
								  </div>
							   	<div class="form-group form-inline">
								    <label for="style" class="col-sm-2 control-label">配套服务</label>
								     <div class="col-sm-10">
								     	<c:forEach items="${supportings }" var="supt" varStatus="st">
								     		<div class="row">
								     		<div class="col-sm-12">
								     		<div class="checkbox checkbox-info">
		                                        <input id="supt_chk_${supt.id}" name="supportings" type="checkbox" value="${supt.id }" ${supt.flag eq 1?'checked=\"checked\"':''} onchange="displaySPChange(this.checked,'${supt.id}');">
		                                        <label for="supt_chk_${supt.id}">
		                                            ${supt.name }
		                                        </label>
		                                        <input type="text" class="form-control" id="supportings_val_${supt.id}"  value="${supt.spval}" name="supportingsVal${supt.id}"  ${supt.flag eq 0?'style=\"display:none;\"':''} placeholder="请输入对应值" />
		                                    </div>
		                                    </div></div>
		                                     <%--  <c:if test="${(st.index+1)%6==0}"><br></c:if> --%>
								     	</c:forEach>
								    </div>
								  </div>
							  <div class="form-group form-inline">
								    <label for="style" class="col-sm-2 control-label">会场摆放</label>
								     <div class="col-sm-10">
								     	<c:forEach items="${halldisplay }" var="supt" varStatus="st">
								     	<div class="row">
								     		<div class="col-sm-12">
								     			<div class="checkbox checkbox-info">
			                                        <input id="supt_chk_${supt.id}" name="halldisplays" type="checkbox" value="${supt.id }" ${supt.flag eq 0?'':'checked=\"checked\"'} onchange="displayChange(this.checked,'${supt.id}');" >
			                                        <label for="supt_chk_${supt.id}">
			                                            ${supt.name }
			                                        </label>
			                                        <input type="number" class="form-control" id="hallPeopleNum_${supt.id}" min="1" value="${supt.flag}" name="personNum${supt.id}"  ${supt.flag eq 0?'style=\"display:none;\"':''} placeholder="请输入人数" />
			                                        	<span ${supt.flag eq 0?'style=\"display:none;\"':''}>人</span>
			                                    </div>
								     		</div>
								     	</div>
								     	</c:forEach>
								    </div>
								  </div>
								 
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">长</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" id="length" name="length" data-options="required:true" value="${hall.length}" onkeyup="sumArea();"/> m
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">宽</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" id="width" name="width" data-options="required:true" value="${hall.width}" onkeyup="sumArea();"/> m
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">高</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="height" data-options="required:true" value="${hall.height}"  /> m
								    </div>
								  </div>
								   <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">会场面积</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" id="hallArea" name="hallArea" data-options="required:true" value="${hall.hallArea}"  /> ㎡
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">所在楼层</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="floor" data-options="required:true" value="${hall.floor}"  /> 
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">会场柱子</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="pillar2" name="pillar" value="0" ${hall.pillar eq '0'?'checked=\"checked\"':'' } onclick="displayPilerNum(this.value,'pillarNum');">
	                                        <label for="pillar2"> 无 </label>
	                                    </div>
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="pillar1" name="pillar" value="1" ${hall.pillar ne '0'?'checked=\"checked\"':'' } onclick="displayPilerNum(this.value,'pillarNum');">
	                                        <label for="pillar1"> 有 </label>
	                                    </div>
	                                    <input type="number" class="form-control" id="pillarNum" min="1" value="${hall.pillar}" name="pillarNum"  ${hall.pillar eq '0'?'style=\"display:none;\"':''} placeholder="请输入柱子数" />
								    </div>
								  </div>
								 <%--  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">容纳人数</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="peopleNum" data-options="required:true" value="${hall.peopleNum}"  /> 人
								    </div>
								  </div> --%>
								  <div class="form-group form-inline">
								    <label for="decorationTime" class="col-sm-2 control-label">装修时间</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control layer-date laydate-icon" id="decorationTime" name="decorationTime" data-options="required:true" value="${dUs.toDay(mhotel.decorationTime)}"/>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">用电功率</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="electricPower" data-options="required:true" value="${hall.electricPower}"  /> W
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="isauth" class="col-sm-2 control-label">实地认证</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isauth1" name="isauth" value="1" ${hall.isauth ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isauth1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isauth2" name="isauth" value="0" ${hall.isauth eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="isauth2"> 否 </label>
	                                    </div>
							    	</div>
							  	</div>
								   <div class="form-group form-inline">
								    <label for="authDate" class="col-sm-2 control-label">认证时间</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control layer-date laydate-icon" id="authDate" name="authDate" data-options="required:true" value="${dUs.toDay(mhotel.certifiTime)}"/>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="isrecommend1" class="col-sm-2 control-label">推荐场地</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isrecommend1" name="isrecommend" value="1" ${hall.isrecommend ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isrecommend1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isrecommend2" name="isrecommend" value="0" ${hall.isrecommend eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="isrecommend2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="isbest1" class="col-sm-2 control-label">优质场地</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isbest1" name="isbest" value="1" ${hall.isbest ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isbest1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isbest2" name="isbest" value="0" ${hall.isbest eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="isbest2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  
								   <div class="form-group form-inline">
								    <label for="isbest1" class="col-sm-2 control-label">交易保障金</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="tradeKicker1" name="tradeKicker" value="1" ${hall.tradeKicker ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="tradeKicker1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="tradeKicker0" name="tradeKicker" value="0" ${hall.tradeKicker eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="tradeKicker0"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">备注</label>
								     <div class="col-sm-10">
								     	<textarea id="memo" class="form-control" name="memo" style="width: 98%;height: 80px;">${hall.memo}</textarea>
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="btn" class="col-sm-2 control-label"></label>
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
	<script type="text/javascript">
	$().ready(function() {
		$('.selectpicker').selectpicker();
		var editor = new UE.ui.Editor();
		editor.render("introduction");
		 var decorationTime={elem:"#decorationTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	  	 laydate(decorationTime);
	   var authDate={elem:"#authDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	   laydate(authDate);
		   
	    var e = "<i class='fa fa-times-circle'></i> ";
		$("#hallSubForm").validate({
	        rules: {
	        	hotelId: "required",
	        	placeName: "required",
	        	recommendedIndex: "required",
	        	zguiPrice: "required",
	        	hotelPrice: "required",
	        	hallArea: "required",
	        	length: "required",
	        	width: "required",
	        	height: "required",
	        	floor: "required",
	        	pillar: "required"
	
	        },
	        messages: {
	        	hotelId: e + "请选择所属场地",
	        	placeName: e + "请输入会场名称",
	        	recommendedIndex: e + "请输入推荐指数",
	        	zguiPrice: e + "请输入掌柜价",
	        	hotelPrice: e + "请输入场地价格",
	        	hallArea: e + "请输入会场面积",
	        	length: e + "请输入长",
	        	width: e + "请输入宽",
	        	height: e + "请输入高",
	        	floor: e + "请输入所在楼层",
	        	pillar: e + "请输入会场柱子"
	        	
	        },
	        submitHandler: function(form) {
	            var url = $(form).attr("action");
	            var data = $(form).serialize();
	            parent.show();
	       　		$.post(url, data, function (res, status) { 
	       　			if(status=="success"&&res.statusCode=="200"){
	       　				swal(res.message, "success");
	       　				loadHotelContent(this,'${ctx}/base/hotel/hall/index','');
	       　			}else{
	       　				swal(res.message, "error");
	       　			}
	       　			parent.hide();
	       　		}, 'json'); 
	         }  
	    });
		
	}); 
	function displayChange(checked,id){
		if(checked){
			$("#hallPeopleNum_"+id).css("display","inline");
			$("#hallPeopleNum_"+id).next().css("display","inline");
		}else{
			$("#hallPeopleNum_"+id).css("display","none");  
			$("#hallPeopleNum_"+id).next().css("display","none");
		}
	}
	
	function displaySPChange(checked,id){
		if(checked){
			$("#supportings_val_"+id).show();
			$("#supportings_val_"+id).val('有');
		}else{
			$("#supportings_val_"+id).hide();  
			$("#supportings_val_"+id).val('无');
		}
	}
	
	function displayPilerNum(val,id){
		if(val==='1'){
			$("#"+id).css("display","inline");
		}else{
			$("#"+id).css("display","none");  
		}
	}
	function sumArea(){
		var length = $("#length").val();
		var width = $("#width").val();
		var area = length*1*width*1;
		
		$("#hallArea").val(area.toFixed(0));
	}
	</script>
  

</div>

