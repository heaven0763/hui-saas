<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>人员邀请</h3>
	<hr><!--model.addAttribute("crtusrty",crtusrty);  -->
	<div class="form-group">
		<a qx="user:invitation" href="${ctx}/weixin/user/invitation/create?crtusrty=${crtusrty}" target="dialog" class="btn btn-primary btn-sm" title="人员邀请" data-permission="user:create"><span class="glyphicon glyphicon-plus"></span> 人员邀请</a>
		<c:forEach items="${menus}" var="menu">
			<c:if test="${menu.id == 55 }">
				<a href="javascript:;" url="${menu.url}" onclick="loadContent(this,'${ctx}/${menu.url}?type=${empty crtusrty?'':1}','');"  class="btn btn-primary btn-sm" title="${menu.name }" ><span class="fa fa-${menu.icon }"> </span> ${menu.name }</a>
			</c:if>
		</c:forEach>
	</div> 
	<form class="form-inline" id="invitation_searchForm">
	  <input type="hidden" name="search_EQ_msgType" value="USERINVITATION">
	  <input type="hidden" name="crtusrty" value="${crtusrty}">
	  <c:if test="${empty crtusrty }">
		  <input type="hidden" name="search_EQ_hotelId" value="0">
	  </c:if>
	  <c:if test="${not empty crtusrty }">
	  	 <input type="hidden" name="search_NE_hotelId" value="0">
	  </c:if>
	  <div class="form-group">
			<label for="area">被邀请人姓名</label>
	   		<input class="form-control" name="search_LIKE_toUserName" >
	  		<button type="button" class="btn btn-primary" onclick="invitation_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="invitation_table" data-toggle="table" data-height="660" data-query-params="invitation_queryParams"
	data-pagination="true" data-url="${ctx}/weixin/user/invitation/rd/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="toUserName">被邀请人姓名</th>
				<th data-field="title">标题</th>
				<th data-field="itemDesc">职位</th>
				<th data-field="createdAt">邀请时间</th>
				<th data-field="state" data-formatter="fm_invitation_state">状态</th>
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	common.pms.init(); 
	$("#invitation_table").bootstrapTable({onLoadSuccess: function(){common.pms.init(); }});
});
function invitation_queryParams(params){
	return $.extend({},params,util.serializeObject($('#invitation_searchForm')));
}

function invitation_search(){
	$("#invitation_table").bootstrapTable("refresh");
}
function fm_invitation_state(value,row, index){
	if(value=="1"){
		return '已确认';
	}else{
		return '未确认';
	}
}
</script>