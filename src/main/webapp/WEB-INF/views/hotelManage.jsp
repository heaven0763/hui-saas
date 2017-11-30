<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content" style="position: relative;">
	<a href="javascript:loadContent(this,'${ctx}/base/hotel/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	<h3>${mhotel.hotelName }</h3>
	<div class="geren width1001" style="border-top: 1px solid #f5f5f5;">
		<div class="gerencl">
			<div class="gerenclxh">
				<h1>
					<img src="${ctx }/static/resource/css/images/gerenleft1.png"><a href="javascript:;" onclick="loadHotelContent(this,'${ctx}/base/hotel/update/${mhotel.id}','RD');" style="display: inline-block;">${pmenu.name }</a>
				</h1>
				<ul>
					<c:forEach items="${hotelmenus}" var="hmenu">
						<li><a href="javascript:;" onclick="loadHotelContent(this,'${ctx}/${hmenu.url}','RD');">${hmenu.name}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="grcr" style=" padding: 20px; border-left: 1px solid #eee;">
            <div id="grcrmimab" class="grcrmimab">
                    
            </div>
        </div>
	</div>

<script>
$(function(){
	loadHotelContent(this,'${ctx}/base/hotel/update/${mhotel.id}','')
});
function loadHotelContent(self,url,level){
	show();
 	$("#grcrmimab").empty();
	
	$("#grcrmimab").load(url,{},function(res){
		hide();
		$("#grcrmimab").fadeIn('slow');
	}); 
}

</script>
</div>