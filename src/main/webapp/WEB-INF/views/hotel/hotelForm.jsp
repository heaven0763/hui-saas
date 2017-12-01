<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
 #hotelSubForm input[type="text"]{width: 400px;}
 #hotelSubForm input[type="number"]{width: 100px;}
 #hotelSubForm select{width: 180px;}
</style>
<script>
$(document).ready(function(e) {
	   /* $('#selFile').localResizeIMG({
	      quality: 1,
	      before:function(){
	    	  parent.show();
	      },
	      success: function (result) {
			  var submitData={
				  base64Str:result.clearBase64,
				  dir:'hotel_logo'
				}; 
			 $.ajax({
			   type: "POST",
			   url: "${ctx}/account/user/upload/resizeimg",
			   data: submitData,
			   dataType:"json",
			   success: function(data){
				  parent.hide();
				 if (data.success) {
					$('input[name="logo"]').val(data.obj);
					$('#WX_icon').attr('src', data.obj);
					swal("上传成功", "success");
				 }else{
				  	swal(data.msg, "error");
					return false;
				 }
			   }, 
			   complete :function(XMLHttpRequest, textStatus){
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){ //上传失败 
					parent.hide();
					swal("AJAX ERROR", "error");
				}
			});
	      },
		  error:function(){ 
		  	parent.hide();
			swal("localResizeIMG ERROR", "error");
		  }
	  }); */
	  
	$.getScript('${ctx}/static/plugins/kindeditor-4.1.10/kindeditor.js', function() {
		KindEditor.basePath = '${ctx}/static/plugins/kindeditor-4.1.10/';
		var editor = KindEditor.editor({
	        uploadJson: '${ctx}/base/hotel/img/upload',
	        allowFileManager : false
	    });
		KindEditor('#WX_icon').click(function() {
			try{
				editor.loadPlugin('image', function() {
		            editor.plugin.imageDialog({
		            	showRemote: false,
		                clickFn : function (url, message, error) {
		                	swal("上传成功", "success");
 	                        $('input[name="logo"]').val(url);
 	   						$('#WX_icon').attr('src', url);
	                        editor.hideDialog();
 	                     }
		            });
		        });
			}catch(err){
				alert(err);
			}
	    	
	    });
	});
	});
</script>
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class="" style="position: relative;">
		                   <c:if test="${empty hotel.id}">
		                   		<a href="javascript:loadContent(this,'${ctx}/base/hotel/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
		                   </c:if>
	                       <h3>${action }场地信息</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   	<div class="row">
							<div class="col-sm-12">
								<form id="hotelSubForm" method="post" action="${ctx}/base/hotel/save"  class="form-horizontal m-t" ><!--   -->
								 	 <input type="hidden" name="id" id="id" value="${hotel.id}" />
								 	 <input type="hidden" value="${hotel.logo}" name="logo" id="logo" >
								 	 <input type="hidden" value="" name="parea" id="parea_txt">
									 <input type="hidden" value="" name="carea" id="carea_txt">
									 <input type="hidden" value="" name="darea" id="darea_txt">
									 <input type="hidden" value="${hotel.pname}" name="pname" id="pname_txt" >
									 <input type="hidden" name="reclaimUserName" id="reclaimUserName_txt" value="${hotel.reclaimUserName}">
									 <div class="form-group form-inline">
									    <label for="reclaimUserId" class="col-sm-2 control-label">场地开拓人员</label>
									     <div class="col-sm-10">
									     	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
										     	<select class="form-control selectpicker" data-live-search="true" data-width="300px" data-size="10"   id="reclaimUserId" name="reclaimUserId" textTarget="reclaimUserName_txt">
													<tags:dict sql="SELECT id,CONCAT(mobile,'-',rname) as name FROM hui_user where user_type ='HUI' and state=1 and group_id=3 " selectedValue="${hotel.reclaimUserId}" showPleaseSelect="true"/>
												</select>
											</c:if>
											<c:if test="${aUs.getCurrentUserType() eq 'PARTNER'}">
												<select class="form-control selectpicker" data-live-search="true" data-width="300px" data-size="10"  id="reclaimUserId" name="reclaimUserId" textTarget="reclaimUserName_txt">
													<tags:dict sql="SELECT id,CONCAT(mobile,'-',rname) as name FROM hui_user where company_id=${aUs.getCurrentUserCompanyId()} and state=1 and group_id=3  " selectedValue="${hotel.reclaimUserId}" showPleaseSelect="true"/>
												</select>
											</c:if>
									    </div>
									  </div>
									 <div class="form-group form-inline" style="height: 50px;">
										<label for="picurl" class="col-sm-2 control-label">场地LOGO</label>
										<div class="col-sm-10">
											<div class="add" style="position: relative; margin-left: 1rem; height: 5.0rem; width: 10.0rem;display: inline-block;">
												<img id="WX_icon" src="${hotel.logo}" onerror="javascript:this.src='${ctx}/public/css/images/add-img.png'" style="height: 5.0rem; width: 10.0rem;border: 1px solid #f5f5f5;" /> 
											<!-- 	<input id="selFile" type="file" name="imgfile" style="position: absolute; top: 0; left: 0; opacity: 0; width: 100%; height: 100%;" />
												<input name="dir" type="hidden" value="user_photo"> -->
												
											</div>
											
											<span style="color: #ff0000;display: inline-block;">上传logo像素建议120*60</span>
										</div>
									</div>
									 <div class="form-group form-inline">
									    <label for="hotelNature" class="col-sm-2 control-label">场地性质</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="hotelNature1" name="hotelNature" value="1" ${hotel.hotelNature ne '2'?'checked=\"checked\"':'' }>
		                                        <label for="hotelNature1"> 单体场地 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="hotelNature2" name="hotelNature" value="2" ${hotel.hotelNature eq '2'?'checked=\"checked\"':'' }>
		                                        <label for="hotelNature2"> 集团旗下场地  </label>
		                                    </div>
									    </div>
									  </div>
									  <div id="pid_dv" class="form-group form-inline" style="display: none;">
									    <label for="pid" class="col-sm-2 control-label">所属集团</label>
									     <div class="col-sm-10">
									     	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
								     			<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"  data-size="10" id="pid" name="pid"  textTarget="pname_txt" >
													<tags:dict sql="SELECT id,name as name FROM hui_hotel_group where company_id =1 " selectedValue="${hotel.pid}" showPleaseSelect="true"/>
												</select> 
									     	</c:if>
									     	<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
								     			<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="pid" name="pid"  textTarget="pname_txt" >
													<tags:dict sql="SELECT id,name as name FROM hui_hotel_group where company_id = ${aUs.getCurrentUserCompanyId()}" selectedValue="${hotel.pid}" showPleaseSelect="true"/>
												</select> 
									     	</c:if>
									     	
									     	
											<span style="color: #ff0000;">PS：单体场地不需填！</span>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="hotelName" class="col-sm-2 control-label">场地名称</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="hotelName" data-options="required:true" value="${hotel.hotelName}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="hotelType" class="col-sm-2 control-label">场地类型</label>
									     <div class="col-sm-10">
									     	<select class="form-control"  id="hotelType" name="hotelType">
												<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='HOTELTYPE' " selectedValue="${hotel.hotelType}" showPleaseSelect="true"/>
											</select>
									    </div>
									  </div>
									  <%-- <div class="form-group form-inline">
									    <label for="hotelStar" class="col-sm-2 control-label">星级</label>
									     <div class="col-sm-10">
									     	<select class="form-control"  id="hotelStar" name="hotelStar">
												<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='STAR' " selectedValue="${hotel.hotelStar}" showPleaseSelect="true"/>
											</select>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="province" class="col-sm-2 control-label">所属城市区域</label>
									     <div class="col-sm-10">
									     	<select class="form-control" id="province" name="province" refval="value" reftext="text" textTarget="parea_txt" nxtref="#darea"
												refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
												<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' " selectedValue="${hotel.province}"  showPleaseSelect="true"/>
											</select>
											<select class="form-control"  id="city" name="city" refval="value" reftext="text"  textTarget="carea_txt"
									     		refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#district" onchange="areaclear('city');">
									     		<c:if test="${not empty hotel.city }">
													  <tags:dict sql="select  id ,region_name name  from hui_region where parent_id=${hotel.province}" selectedValue="${hotel.city}" showPleaseSelect="true"/>
												  </c:if> 
											</select>
											<select class="form-control" id="district" name="district" refval="value" reftext="text"  textTarget="darea_txt"
												refurl="${ctx}/framework/dictionary/trslCombox?sql=SELECT id,district as name FROM hui_district where region_id in (select parent_id from hui_region where id={value})" refdata="region_id=:{value}" ref="#tradeArea">
												<c:if test="${not empty hotel.district }">
													<tags:dict sql="select id,region_name name from hui_region where parent_id='${hotel.city}'" selectedValue="${hotel.district}" showPleaseSelect="true"/>
												</c:if> 
											</select> 
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="tradeArea" class="col-sm-2 control-label">所属商圈</label>
									     <div class="col-sm-10">
									     	<select class="form-control"  id="tradeArea" name="tradeArea" >
												<c:if test="${not empty hotel.district }">
													<tags:dict sql="SELECT id,district as name FROM hui_district where region_id='${hotel.city}'" selectedValue="${hotel.tradeArea}" showPleaseSelect="true"/>
												</c:if> 
											</select> 
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="address" class="col-sm-2 control-label">详细地址</label>
									     <div class="col-sm-10">
									     	<textarea class="form-control" name="address" style="width: 98%;height: 80px;">${hotel.address}</textarea>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="keyword" class="col-sm-2 control-label">SEO标题</label>
									     <div class="col-sm-10">
									     	<textarea class="form-control" name="keyword" maxlength="30" style="width: 98%;height: 80px;">${hotel.keyword}</textarea>
									     	<span style="color: #ff0000;">请用4个字编述输入搜索关键字，中间用“,”分隔；最多不超过五项。</span>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="description" class="col-sm-2 control-label">SEO描述</label>
									     <div class="col-sm-10">
									     	<textarea class="form-control" name="description" maxlength="300" style="width: 98%;height: 80px;">${hotel.description}</textarea>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="search" class="col-sm-2 control-label">SEO关键词</label>
									     <div class="col-sm-10">
									     	<textarea class="form-control" name="search" maxlength="30" style="width: 98%;height: 80px;">${hotel.search}</textarea>
									     	<span style="color: #ff0000;">请用4个字编述输入搜索关键字，中间用“,”分隔；最多不超过五项。</span>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="introduction" class="col-sm-2 control-label">场地简介</label>
									     <div class="col-sm-10">
									     	<script id="introduction" name="introduction" type="text/plain" style="width:100%;height:500px;">${hotel.introduction}</script>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="decorationTime" class="col-sm-2 control-label">装修时间</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control layer-date laydate-icon" id="decorationTime" name="decorationTime" data-options="required:true" value="${dUs.toDay(hotel.decorationTime)}"/>
									    </div>
									  </div>
									 <%--  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">会场数量</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="hallNum" data-options="required:true" value="${hotel.hallNum}"/> 间
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">客房数量</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="roomNum" data-options="required:true" value="${hotel.roomNum}"/> 间
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">最低餐标</label>
									     <div class="col-sm-10">
									     	围餐：<input type="number" class="form-control" name="tbmealAmount" data-options="required:true" value="${empty hotel.tbmealAmount?0:hotel.tbmealAmount}"/> 元/桌 &nbsp;&nbsp;
									     	自助餐：<input type="number" class="form-control" name="buffetAmount" data-options="required:true" value="${empty hotel.buffetAmount?0:hotel.buffetAmount}"/> 元/人
									    </div>
									  </div>
									  <%-- <div class="form-group form-inline">
									    <label for="averagePrice" class="col-sm-2 control-label">平均价格</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="averagePrice"  value="${hotel.averagePrice}"/> 元
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="largestVenue" class="col-sm-2 control-label">最大会场名称</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="largestVenue" value="${hotel.largestVenue}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">会场最大面积</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="hallMaxArea" data-options="required:true" value="${hotel.hallMaxArea}"/> ㎡
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">最大可容納人数</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="maxPeopleNum" data-options="required:true" value="${hotel.maxPeopleNum}"/> 人
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="specialService" class="col-sm-2 control-label">特色服务</label>
									     <div class="col-sm-10">
									     	<textarea id="specialService" class="form-control" name="specialService" style="width:98%;height: 150px;">${hotel.specialService}</textarea>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="style" class="col-sm-2 control-label">场地风格</label>
									     <div class="col-sm-10">
									     	<c:forEach items="${styles }" var="stl" varStatus="st">
									     		<div class="checkbox checkbox-info">
			                                        <input id="style_chk_${stl.id}" name="style" type="checkbox" value="${stl.id }" ${stl.flag eq 1?'checked=\"checked\"':''}>
			                                        <label for="style_chk_${stl.id}">
			                                            ${stl.name }
			                                        </label>
			                                    </div>
			                                    <c:if test="${(st.index+1)%6==0}"><br></c:if>
									     	</c:forEach>
									    </div>
									  </div>
									 <%--  <div class="form-group form-inline">
									    <label for="style" class="col-sm-2 control-label">配套服务</label>
									     <div class="col-sm-10">
									     	<c:forEach items="${supportings }" var="supt" varStatus="st">
									     		<div class="checkbox checkbox-info">
			                                        <input id="supt_chk_${supt.id}" name="supportings" type="checkbox" value="${supt.id }" ${supt.flag eq 1?'checked=\"checked\"':''} >
			                                        <label for="supt_chk_${supt.id}">
			                                            ${supt.name }
			                                        </label>
			                                    </div>
			                                      <c:if test="${(st.index+1)%6==0}"><br></c:if>
									     	</c:forEach>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="style" class="col-sm-2 control-label">客房服务</label>
									     <div class="col-sm-10">
									     	<c:forEach items="${roomservices }" var="supt" varStatus="st">
									     		<div class="checkbox checkbox-info">
			                                        <input id="rs_chk_${supt.id}" name="roomservices" type="checkbox" value="${supt.id }" ${supt.flag eq 1?'checked=\"checked\"':''} >
			                                        <label for="rs_chk_${supt.id}">
			                                            ${supt.name }
			                                        </label>
			                                    </div>
			                                      <c:if test="${(st.index+1)%6==0}"><br></c:if>
									     	</c:forEach>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="style" class="col-sm-2 control-label">目的</label>
									     <div class="col-sm-10">
									     	<c:forEach items="${purposes }" var="prs" varStatus="st">
									     		<div class="checkbox checkbox-info">
			                                        <input id="prs_chk_${prs.id}" name="purpose" type="checkbox" value="${prs.id }" ${prs.ishave eq 1?'checked=\"checked\"':''} ><!--  -->
			                                        <label for="prs_chk_${prs.id}">
			                                            ${prs.name }
			                                        </label>
			                                    </div>
			                                      <c:if test="${(st.index+1)%6==0}"><br></c:if>
									     	</c:forEach>
									    </div>
									  </div>
									  <%-- <div class="form-group form-inline">
									    <label for="trafficSigns" class="col-sm-2 control-label">交通标记</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="trafficSigns" data-options="required:true" value="${hotel.trafficSigns}"/>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="line" class="col-sm-2 control-label">地铁线路</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="line" data-options="required:true" value="${hotel.line}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="landmarks" class="col-sm-2 control-label">地标</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="landmarks" data-options="required:true" value="${hotel.landmarks}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="qq" class="col-sm-2 control-label">qq</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="qq" data-options="required:true" value="${hotel.qq}"/>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="website" class="col-sm-2 control-label">网址</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="website" data-options="required:true" value="${hotel.website}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">推荐指数</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="recommendedIndex" min="1" max="5" value="${hotel.recommendedIndex}"/>
									    </div>
									  </div>
									 <%--  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">评论指数</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="reviewIndex"  min="1" max="5" value="${hotel.reviewIndex}"/>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="contact" class="col-sm-2 control-label">联系人</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="contact" data-options="required:true" value="${hotel.contact}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="telephone" class="col-sm-2 control-label">联系固话</label>
									     <div class="col-sm-10">
									     	<c:if test="${not empty hotel.telephone}">
									     		<c:set var="telephone" value="${fn:split(hotel.telephone, ',')}" />
									     		<c:forEach items="${telephone}" var="tel">
										     		<input type="text" class="form-control" name="telephone" data-options="required:true" value="${tel}" style="width: 180px;margin-right: 10px;"/>
									     		</c:forEach>
									     		<c:if test="${fn:length(telephone)==1}">
											     	<input type="text" class="form-control" name="telephone" data-options="required:true" value="" style="width: 180px;margin-right: 10px;"/>
										     	</c:if>
									     	</c:if>
									     	<c:if test="${empty hotel.telephone}">
										     	<input type="text" class="form-control" name="telephone" data-options="required:true" value="" style="width: 180px;margin-right: 10px;"/>
										     	<input type="text" class="form-control" name="telephone" data-options="required:true" value="" style="width: 180px;margin-right: 10px;"/>
									     	</c:if>
									     	
									     	<%-- <c:set var="string1" value="www runoob com"/>
											<c:set var="string2" value="${fn:split(string1, ' ')}" />
											<c:set var="string3" value="${fn:join(string2, '-')}" />
											<p>string3 字符串 : ${string3}</p>
											<p>string3 字符串 : ${string2[0]}</p> --%>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="mobile" class="col-sm-2 control-label">联系手机</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="mobile" data-options="required:true" value="${hotel.mobile}"/>
									    </div>
									  </div>
									   <%-- <div class="form-group form-inline">
									    <label for="fax" class="col-sm-2 control-label">传真</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="fax" data-options="required:true" value="${hotel.fax}"/>
									    </div>
									  </div> --%>
									  <div class="form-group form-inline">
									    <label for="email" class="col-sm-2 control-label">邮箱</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="email" data-options="required:true" value="${hotel.email}"/>
									    </div>
									  </div>
									  <%-- <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">场地标签</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control" name="tag" data-options="required:true" value="${hotel.tag}"/>
									    </div>
									  </div> --%>
									   
									   <div class="form-group form-inline">
									    <label for="certifiTime" class="col-sm-2 control-label">认证时间</label>
									     <div class="col-sm-10">
									     	<input type="text" class="form-control layer-date laydate-icon" id="certifiTime" name="certifiTime" data-options="required:true" value="${dUs.toDay(hotel.certifiTime)}"/>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">场地状态</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="state1" name="state" value="1" ${hotel.state ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="state1"> 启用 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="state2" name="state" value="0" ${hotel.state eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="state2"> 停用 </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="verify" class="col-sm-2 control-label">实地认证</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="verify1" name="verify" value="1" ${hotel.verify ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="verify1"> 是 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="verify2" name="verify" value="0" ${hotel.verify eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="verify2"> 否 </label>
		                                    </div>
									    </div>
									  </div>
									  
									  <div class="form-group form-inline">
									    <label for="isTui1" class="col-sm-2 control-label">推荐场地</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isTui1" name="isTui" value="1" ${hotel.isTui ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="isTui1"> 是 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isTui2" name="isTui" value="0" ${hotel.isTui eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="isTui2"> 否 </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="isbest1" class="col-sm-2 control-label">优质场地</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isbest1" name="isbest" value="1" ${hotel.isbest ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="isbest1"> 是 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isbest2" name="isbest" value="0" ${hotel.isbest eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="isbest2"> 否 </label>
		                                    </div>
									    </div>
									  </div>
									  <%-- <div class="form-group form-inline">
									    <label for="isHot1" class="col-sm-2 control-label">热门场地</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isHot1" name="isHot" value="1" ${hotel.isHot ne '0'?'checked=\"checked\"':'' } >
		                                        <label for="isHot1"> 是 </label>
		                                    </div>
		                                    <div class="radio radio-info radio-inline">
		                                        <input type="radio" id="isHot2" name="isHot" value="0" ${hotel.isHot eq '0'?'checked=\"checked\"':'' }>
		                                        <label for="isHot2"> 否 </label>
		                                    </div>
									    </div>

										交易保证金
										
										tradeKicker
									  </div> --%>
									
									 <div class="form-group form-inline">
									    <label for="groupId" class="col-sm-2 control-label">交易保证金</label>
									     <div class="col-sm-10">
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="istradeKicker1" name="tradeKicker" value="1" ${hotel.tradeKicker ne '0'?'checked=\"checked\"':'' } onchange="displayPilerNum(this.value,'tradeKickerAmount');">
		                                        <label for="istradeKicker1"> 是 </label>
		                                    </div>
		                                    <input type="number" class="form-control" id="tradeKickerAmount" min="1" value="${hotel.tradeKicker}" name="tradeKickerAmount"  ${hall.pillar eq '0'?'style=\"display:none;\"':''} placeholder="请输入交易保证金" />
									     	<div class="radio radio-info radio-inline">
		                                        <input type="radio" id="istradeKicker0" name="tradeKicker" value="0" ${hotel.tradeKicker eq '0'?'checked=\"checked\"':'' } onchange="displayPilerNum(this.value,'tradeKickerAmount');">
		                                        <label for="istradeKicker0"> 否 </label>
		                                    </div>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="sortOrder" class="col-sm-2 control-label">排序编号</label>
									     <div class="col-sm-10">
									     	<input type="number" class="form-control" name="sortOrder"  min="1" max="1000" value="${hotel.sortOrder}"/>
									    </div>
									  </div>
									  
									   <div class="form-group form-inline">
									    <label for="introduction" class="col-sm-2 control-label">会场预定备注</label>
									     <div class="col-sm-10">
									     	<script id="meetingRemark" name="meetingRemark" type="text/plain" style="width:100%;height:300px;">${hotel.meetingRemark}</script>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="introduction" class="col-sm-2 control-label">住房预定备注</label>
									     <div class="col-sm-10">
									     	<script id="houseRemark" name="houseRemark" type="text/plain" style="width:100%;height:300px;">${hotel.houseRemark}</script>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="introduction" class="col-sm-2 control-label" >用餐预定备注</label>
									     <div class="col-sm-10">
									     	<script id="dinnerRemark" name="dinnerRemark" type="text/plain" style="width:100%;height:300px;">${hotel.dinnerRemark}</script>
									    </div>
									  </div>
									  <div class="form-group form-inline">
									    <label for="memo" class="col-sm-2 control-label">预定其他备注</label>
									     <div class="col-sm-10">
									     	<textarea id="memo" class="form-control" name="memo" style="width:98%;height: 50px;">${hotel.memo}</textarea>
									    </div>
									  </div>
									   <div class="form-group form-inline">
									    <label for="btn" class="col-sm-2 control-label"></label>
									     <div class="col-sm-10">
									     	<button qx="hotel:update" type="submit" class="btn btn-primary" style="width:160px;"><span class="glyphicon glyphicon-save"></span> 保存</button>
									    </div>
									  </div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div>	
<c:if test="${empty hotel.id}">
	<script>
	     $(function () {
    		common.pms.init();
	        var localMsg;
	        if(window.localStorage.hotelFormHistory){
	            localMsg=JSON.parse(window.localStorage.hotelFormHistory);
	        }
	        if(localMsg && localMsg.length>=1){
	            var realIndex=0;
	            for(var i=0;i<$('#hotelSubForm input').length;i++){
	                if($($('#hotelSubForm input')[i])[0].type=='text'){
	                    $($('#hotelSubForm input')[i]).val(localMsg[realIndex].text);
	                    realIndex++;
	                }else if($($('#hotelSubForm input')[i])[0].type=='radio'){
	                    $($('#hotelSubForm input')[i]).prop('checked',localMsg[realIndex].radio);
	                    realIndex++;
	                }else if($($('#hotelSubForm input')[i])[0].type=='checkbox'){
	                    $($('#hotelSubForm input')[i]).prop('checked',localMsg[realIndex].checkbox);
	                    realIndex++;
	                }else if($($('#hotelSubForm input')[i])[0].type=='number'){
	                	 $($('#hotelSubForm input')[i]).val(localMsg[realIndex].number);
	                    realIndex++;
	                }
	            }
	            for(var i=0;i<$('#hotelSubForm select').length;i++){
	            	$($('#hotelSubForm select')[i]).val(localMsg[realIndex].text);
	            	realIndex++;
	            }
	        }
	    	
	        var idInt = setInterval(function(){
	        	
	        	var history=[];
	            //window.localStorage.hotelFormHistory='';
	            for(var i=0;i<$('#hotelSubForm input').length;i++){
	                if($($('#hotelSubForm input')[i])[0].type=='text'){
	                    history.push({"text":$($('#hotelSubForm input')[i]).val()});
	                }else if($($('#hotelSubForm input')[i])[0].type=='radio'){
	                    history.push({"radio":$($('#hotelSubForm input')[i]).attr('checked') ? 'checked' :''});
	                }else if($($('#hotelSubForm input')[i])[0].type=='checkbox'){
	                    history.push({"checkbox":$($('#hotelSubForm input')[i]).attr('checked') ? 'checked' :''});
	                }else if($($('#hotelSubForm input')[i])[0].type=='number'){
	                	history.push({"number":$($('#hotelSubForm input')[i]).val()});
	                }
	            }
	            for(var i=0;i<$('#hotelSubForm select').length;i++){
	            	history.push({"text":$($('#hotelSubForm select')[i]).val()});
	            }
	            window.localStorage.hotelFormHistory=JSON.stringify(history);
	        },5000);
	    });
	</script>
 </c:if>
 <script type="text/javascript">
$().ready(function() {
	$('input[name="hotelNature"]').change(function(){
		if($(this).val()==='1'){
			$("#pid_dv").hide();
		}else{
			$("#pid_dv").show();
		}
	});
	var editor = new UE.ui.Editor();
	editor.render("introduction");
	var meditor = new UE.ui.Editor();
	meditor.render("meetingRemark");
	var heditor = new UE.ui.Editor();
	heditor.render("houseRemark");
	var deditor = new UE.ui.Editor();
	deditor.render("dinnerRemark");
	$('.selectpicker').selectpicker();
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelSubForm").validate({
        rules: {
        	hotelName: "required",
        	hotelType: "required",
        	hotelStar: "required",
        	province: "required",
        	city: "required",
        	district: "required",
        	address: "required",
        	introduction: "required",
        	decorationTime: "required",
        	hallNum: "required",
        	roomNum: "required",
        	hallMaxArea: "required",
        	maxPeopleNum: "required"
        },
        messages: {
        	hotelName: e + "请输入场地名称",
        	hotelType: e + "请选择场地类型",
        	hotelStar: e + "请选择场地星级",
        	province: e + "请选择场地所属省份",
        	city: e + "请选择场地所属城市",
        	district: e + "请选择场地所属区域",
        	address: e + "请输入场地详细地址",
        	introduction: e + "请输入场地简介",
        	decorationTime: e + "请输入装修时间",
        	hallNum: e + "请输入会场数量",
        	roomNum: e + "请输入客房数量",
        	hallMaxArea: e + "请输入会场最大面积",
        	maxPeopleNum: e + "请输入最大可容納人数"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            var id = $("#id").val();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				window.localStorage.hotelFormHistory='';
       　				swal(res.message, "success");
       　				if(id==""){
	       　				loadContent(this,'${ctx}/base/hotel/index','');
       　				}else{
       　					loadHotelContent(this,'/hui/base/hotel/update/'+id,'RD');
       　				}
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
   var decorationTime={elem:"#decorationTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
   laydate(decorationTime);
   var certifiTime={elem:"#certifiTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
   laydate(certifiTime);
   
   common.ctx = '${ctx}';
	dict.init();
	common.pms.init();
});

function displayPilerNum(val,id){
	if(val==='1'){
		$("#"+id).css("display","inline");
	}else{
		$("#"+id).css("display","none"); 
		$("#"+id).val(0);
	}
}
</script>

</div>

