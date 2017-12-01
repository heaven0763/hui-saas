<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
 #roomSubForm input[type="text"]{width: 400px;}
 #roomSubForm select{width: 180px;}
</style>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class=""  style="position: relative;">
	                  	   <a href="javascript:loadHotelContent(this,'${ctx}/base/hotel/room/index','')"  class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                       <h3>${action }客房信息</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content"  style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
							<form id="roomSubForm" method="post" action="${ctx}/base/hotel/room/save"  class="form-horizontal m-t" ><!--   -->
							  	<input type="hidden" name="id" id="id" value="${room.id}" />
							  	 <input type="hidden" name="placeType" id="placeType" value="ROOM">
							  	  <c:if test="${not empty mhotel }">
							  	  	<input type="hidden" name="hotelId" value="${mhotel.id}" />
							  	  </c:if>
							  	 <c:if test="${empty mhotel }">
								  <div class="form-group form-inline">
								    <label for="hotelId" class="col-sm-2 control-label">所属场地</label>
								     <div class="col-sm-10">
								     	<%-- <select class="form-control"  id="hotelId" name="hotelId" >
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${room.hotelId}" showPleaseSelect="true"/>
										</select>  --%>
										
										<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
							     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" >
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel " selectedValue="${hall.hotelId}" showPleaseSelect="true"/>
											</select> 
								     	</c:if>
								     	<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
							     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" >
												<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}" selectedValue="${hall.hotelId}" showPleaseSelect="true"/>
											</select> 
								     	</c:if>
								    </div>
								  </div>
								  </c:if>
								  <div class="form-group form-inline">
								    <label for="hotelId" class="col-sm-2 control-label">客房类型</label>
								     <div class="col-sm-10">
								     	<select class="form-control"  id="roomType" name="roomType" onchange="changeRoomType(this.value);">
												<tags:dict sql="SELECT id,name FROM hui_category  where kind ='ROOMTYPE'" selectedValue="${room.roomType}" showPleaseSelect="true"/>
										</select> 
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="placeName" class="col-sm-2 control-label">客房名称</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="placeName" data-options="required:true" value="${room.placeName}"  />
								    </div>
								  </div>
								   <div class="form-group form-inline">
								    <label for="roomNum" class="col-sm-2 control-label">客房数量</label>
								     <div class="col-sm-10">
								     	<input type="number" class="form-control" name="roomNum" data-options="required:true" value="${room.roomNum}"  />
								    </div>
								  </div>
								  <%--  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">掌柜价</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="zguiPrice" data-options="required:true" value="${room.zguiPrice}"  />
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">场地价格</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="hotelPrice" data-options="required:true" value="${room.hotelPrice}"  />
								    </div>
								  </div> --%>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">推荐指数</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="recommendedIndex" data-options="required:true" value="${room.recommendedIndex}"  />
								    </div>
								  </div>
								   <%-- <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">客房说明</label>
								     <div class="col-sm-10">
								     	<textarea id="memo" class="form-control" name="description" style="width: 100%;height: 50;">${room.description}</textarea>
								    </div>
								  </div> --%>
							    <div class="form-group form-inline">
								    <label for="introduction" class="col-sm-2 control-label">客房概述</label>
								     <div class="col-sm-10">
								     	<script id="introduction" name="introduction" type="text/plain" style="width:100%;height:500px;">${room.introduction}</script>
								    </div>
								  </div>
							   	<div class="form-group form-inline">
								    <label for="style" class="col-sm-2 control-label">便利设施</label>
								     <div class="col-sm-10">
								     	<c:forEach items="${supportings }" var="supt" varStatus="st">
								     		<div class="checkbox checkbox-info">
		                                        <input id="supt_chk_${supt.id}" name="facilities" type="checkbox" value="${supt.id }" ${supt.flag eq 1?'checked=\"checked\"':''} >
		                                        <label for="supt_chk_${supt.id}">
		                                            ${supt.name }
		                                        </label>
		                                    </div>
		                                      <c:if test="${(st.index+1)%6==0}"><br></c:if>
								     	</c:forEach>
								    </div>
								</div>
							  	<div class="form-group form-inline">
								    <label for="style" class="col-sm-2 control-label">媒体/科技</label>
								     <div class="col-sm-10">
								     	<c:forEach items="${halldisplay }" var="supt" varStatus="st">
								     		<div class="checkbox checkbox-info">
		                                        <input id="techs_chk_${supt.id}" name="techs" type="checkbox" value="${supt.id }" ${supt.flag eq 1?'checked=\"checked\"':''} >
		                                        <label for="techs_chk_${supt.id}">
		                                            ${supt.name }
		                                        </label>
		                                    </div>
		                                      <c:if test="${(st.index+1)%6==0}"><br></c:if>
								     	</c:forEach>
								    </div>
								</div>
								 
								  
								 
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">所在楼层</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="floor" data-options="required:true" value="${room.floor}"  />层
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="hallArea" class="col-sm-2 control-label">客房面积</label>
								     <div class="col-sm-10">
								     	长<input type="number" class="form-control" style="width: 60px;" id="length" name="length" data-options="required:true" value="${room.length}" onkeyup="sumArea();"/> m &nbsp;&nbsp;
								     	宽<input type="number" class="form-control" style="width: 60px;" id="width" name="width" data-options="required:true" value="${room.width}" onkeyup="sumArea();"/> m&nbsp;&nbsp;
								     	高<input type="number" class="form-control" style="width: 60px;" name="height" data-options="required:true" value="${room.height}"  /> m&nbsp;&nbsp;
								     	面积<input type="text" class="form-control" style="width: 100px;" id="hallArea" name="hallArea" data-options="required:true" value="${room.hallArea}"  />m²
								    </div>
								  </div>
								  
								   <div class="form-group form-inline">
								    <label for="bedSize" class="col-sm-2 control-label">床规格</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="bedSize" data-options="required:true" value="${room.bedSize}"  />米
								    </div>
								  </div>
								  
								   <div class="form-group form-inline">
								    <label for="bedNum" class="col-sm-2 control-label">床数量</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="bedNum" data-options="required:true" value="${room.bedNum}"  />张
								    </div>
								  </div>
								 
								  
								  <div class="form-group form-inline">
								    <label for="checkInNum" class="col-sm-2 control-label">入住人数</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="checkInNum" data-options="required:true" value="${room.checkInNum}"  />人
								    </div>
								  </div>
								  
								<%--   <div class="form-group form-inline">
								    <label for="network" class="col-sm-2 control-label">客房网络</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="network" data-options="required:true" value="${room.network}"  />
								    </div>
								  </div> --%>
								   <div class="form-group form-inline">
								    <label for="breakfast" class="col-sm-2 control-label">提供早餐</label>
								     <div class="col-sm-10">
								     	
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="breakfast1" name="breakfast" value="1" ${room.breakfast ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="hotwater1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="breakfast2" name="breakfast" value="0" ${room.breakfast eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="hotwater2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  
								   <div class="form-group form-inline">
								    <label for="freeWater" class="col-sm-2 control-label">免费水</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control" name="freeWater" data-options="required:true" value="${room.freeWater}"  />支
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="freeSupplies" class="col-sm-2 control-label">免费洗漱用品</label>
								     <div class="col-sm-10">
								     	
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="freeSupplies1" name="freeSupplies" value="1" ${room.freeSupplies ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="freeSupplies1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="freeSupplies2" name="freeSupplies" value="0" ${room.freeSupplies eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="freeSupplies2"> 否 </label>
	                                    </div>
	                                    <input type="text" class="form-control" name="freeSuppliesNum" data-options="required:true" value="${room.freeSuppliesNum}" style="width:200px;" />套
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="hotwater" class="col-sm-2 control-label">24小时热水</label>
								     <div class="col-sm-10">
								     	
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="hotwater1" name="hotwater" value="1" ${room.hotwater ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="hotwater1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="hotwater2" name="hotwater" value="0" ${room.hotwater eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="hotwater2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  
								  
								    <div class="form-group form-inline">
								    <label for="bathroom" class="col-sm-2 control-label">独立淋浴间</label>
								     <div class="col-sm-10">
								     	
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="bathroom1" name="bathroom" value="1" ${room.bathroom ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="bathroom1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="bathroom2" name="bathroom" value="0" ${room.bathroom eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="bathroom2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								
								 <div class="form-group form-inline">
								    <label for="towel" class="col-sm-2 control-label">毛巾/浴巾</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="towel1" name="towel" value="1" ${room.towel ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="towel1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="towel2" name="towel" value="0" ${room.towel eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="towel2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  
								  <div class="form-group form-inline">
								    <label for="window" class="col-sm-2 control-label">窗户</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="window1" name="window" value="1" ${room.window ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="window1"> 有 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="window2" name="window" value="0" ${room.window eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="window2"> 无 </label>
	                                    </div>
								    </div>
								  </div>
								
								  <div class="form-group form-inline">
								    <label for="decorationTime" class="col-sm-2 control-label">装修时间</label>
								     <div class="col-sm-10">
								     	<input type="text" class="form-control layer-date laydate-icon" id="decorationTime" name="decorationTime" data-options="required:true" value="${dUs.toDay(mhotel.decorationTime)}"/>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="isauth" class="col-sm-2 control-label">实地认证</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isauth1" name="isauth" value="1" ${room.isauth ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isauth1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isauth2" name="isauth" value="0" ${room.isauth eq '0'?'checked=\"checked\"':'' }>
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
								    <label for="isrecommend1" class="col-sm-2 control-label">推荐客房</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isrecommend1" name="isrecommend" value="1" ${room.isrecommend ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isrecommend1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isrecommend2" name="isrecommend" value="0" ${room.isrecommend eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="isrecommend2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="isbest1" class="col-sm-2 control-label">优质客房</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isbest1" name="isbest" value="1" ${room.isbest ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="isbest1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="isbest2" name="isbest" value="0" ${room.isbest eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="isbest2"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								   <div class="form-group form-inline">
								    <label for="isbest1" class="col-sm-2 control-label">交易保障金</label>
								     <div class="col-sm-10">
								     	<div class="radio radio-info radio-inline">
	                                        <input type="radio" id="tradeKicker1" name="tradeKicker" value="1" ${room.tradeKicker ne '0'?'checked=\"checked\"':'' } >
	                                        <label for="tradeKicker1"> 是 </label>
	                                    </div>
	                                    <div class="radio radio-info radio-inline">
	                                        <input type="radio" id="tradeKicker0" name="tradeKicker" value="0" ${room.tradeKicker eq '0'?'checked=\"checked\"':'' }>
	                                        <label for="tradeKicker0"> 否 </label>
	                                    </div>
								    </div>
								  </div>
								  <div class="form-group form-inline">
								    <label for="groupId" class="col-sm-2 control-label">备注</label>
								     <div class="col-sm-10">
								     	<textarea id="memo" class="form-control" name="memo" style="width: 98%;height: 80px;">${room.memo}</textarea>
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
	var editor = new UE.ui.Editor();
	editor.render("introduction");
	var decorationTime={elem:"#decorationTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
  	laydate(decorationTime);
    var authDate={elem:"#authDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(authDate);
    $('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#roomSubForm").validate({
        rules: {
        	hotelId: "required",
        	placeName: "required",
        	roomNum: "required",
        	recommendedIndex: "required",
        	zguiPrice: "required",
        	hotelPrice: "required",
        	floor: "required",
        	pillar: "required"

        },
        messages: {
        	hotelId: e + "请选择所属场地",
        	placeName: e + "请输入客房名称",
        	roomNum:  e + "请输入客房数量",
        	recommendedIndex: e + "请输入推荐指数",
        	zguiPrice: e + "请输入掌柜价",
        	hotelPrice: e + "请输入场地价格",
        	floor: e + "请输入所在楼层",
        	pillar: e + "请输入客房柱子"
        	
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				swal(res.message, "success");
       　				loadHotelContent(this,'${ctx}/base/hotel/room/index','');
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
		$("#roomPeopleNum_"+id).css("display","inline");  
	}else{
		$("#roomPeopleNum_"+id).css("display","none");  
	}
}
function changeRoomType(val){//67,68,69
	if(val==='67'){
		$('input[name="bedNum"]').val(1);
		$('input[name="checkInNum"]').val(2);
	}else if(val==='68'){
		$('input[name="bedNum"]').val(2);
		$('input[name="checkInNum"]').val(4);
	}else if(val==='69'){
		$('input[name="bedNum"]').val(3);
		$('input[name="checkInNum"]').val(6);
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

