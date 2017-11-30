<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content" style="">
<style>
	div.widget_container{position: relative; margin-right: 50px; float: left;  padding: 10px;  -webkit-perspective: 1000px; -moz-perspective: 1000px;    -ms-perspective: 1000px; -o-perspective: 1000px; perspective: 1000px;}
	div.widget_darkblue, div.widget_darkblue div.main, div.widget_container.darkblue div.widget, div.widget_container.darkblue div.widget div.main {
	    background-color: #3C7780;
	}
	div.widget_red, div.widget_red div.main, div.widget_container.red div.widget, div.widget_container.red div.widget div.main {
	    background-color: #C23916;
	}
	div.widget_darkred, div.widget_darkred div.main, div.widget_container.darkred div.widget, div.widget_container.darkred div.widget div.main {
	    background-color: #BE213E;
	}
	div.widget_green, div.widget_green div.main, div.widget_container.green div.widget, div.widget_container.green div.widget div.main {
	    background-color: #94C849;
	}
	div.widget_blue, div.widget_blue div.main, div.widget_container.blue div.widget, div.widget_container.blue div.widget div.main {
	    background-color: #0097AA;
	}
	div.widget_purple, div.widget_purple div.main, div.widget_container.purple div.widget, div.widget_container.purple div.widget div.main {
	    background-color: #91009B;
	}
	div.widget2x2 {
	    width: 160px;
	    height: 160px;
	}
	div.widget {
	    float: left;
	    position: relative;
	    color: #FFFFFF;
	    cursor: pointer;
	    margin: 5px;
	    opacity: 1;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -ms-box-sizing: border-box;
	    -o-box-sizing: border-box;
	    box-sizing: border-box;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	    -webkit-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.8);
	    -moz-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.8);
	    -ms-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.8);
	    -o-box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.8);
	    box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.8);
	    -webkit-transform: rotateY(0deg);
	    -moz-transform: rotateY(0deg);
	    -ms-transform: rotateY(0deg);
	    -o-transform: rotateY(0deg);
	    transform: rotateY(0deg);
	}
	div.widget div.widget_content {
	    position: absolute;
	    top: 5px;
	    right: 5px;
	    bottom: 5px;
	    left: 5px;
	    overflow: hidden;
	}
	div.widget div.main {
	    overflow: hidden;
	    position: absolute;
	    left: 0px;
	    right: 0px;
	    height: 100%;
	    top: 100%;
	    -webkit-transition: top 0.4s;
	    -moz-transition: top 0.4s;
	    -ms-transition: top 0.4s;
	    transition: top 0.4s;
	}
	div.widget div.main {
	    height: 100%;
	    top: 0px;
	    background-repeat: no-repeat;
	    background-position: 50% 50%;
	}
	div.widget_link {
	    cursor: pointer;
	}
	div.widget div.main > span {
	    display: block;
	    position: absolute;
	    bottom: 0px;
	    left: 0px;
	    right: 0px;
	    font-size: 14px;
	    text-transform: uppercase;
	    overflow: hidden;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	    -webkit-text-shadow: 0 1px 0 rgba(0, 0, 0, 0.3);
	    -moz-text-shadow: 0 1px 0 rgba(0, 0, 0, 0.3);
	    -ms-text-shadow: 0 1px 0 rgba(0, 0, 0, 0.3);
	    -o-text-shadow: 0 1px 0 rgba(0, 0, 0, 0.3);
	    text-shadow: 0 1px 0 rgba(0, 0, 0, 0.3);
	}
	div.widget:hover {
	    z-index: 10;
	    border: 3px solid rgba(255, 255, 255, 0.4);
	    -webkit-transform: scale(1.05);
	       -moz-transform: scale(1.05);
	        -ms-transform: scale(1.05);
	         -o-transform: scale(1.05);
	            transform: scale(1.05);
	}
	/* //style="background-image:url('/hui/static/resource/css/images/bg.png');background-position: center;background-size:60%;background-repeat: no-repeat; " */
	
	.menu_container{width:100%;position: relative; -webkit-perspective: 1000px; -moz-perspective: 1000px;-ms-perspective: 1000px; -o-perspective: 1000px; perspective: 1000px;}
	.menu_container .menu_box2x1 {
	    width: 24%;
	    height: 120px;
	}
	.menu_container .menu_box {
	    float: left;
	    position: relative;
	    color: #FFFFFF;
	    cursor: pointer;
	    margin: 5px;
	    opacity: 1;
	}
	.menu_container .menu_box:hover {
	    z-index: 10;
	    border: 2px solid #3b5999;
	    -webkit-transform: scale(1.05);
	       -moz-transform: scale(1.05);
	        -ms-transform: scale(1.05);
	         -o-transform: scale(1.05);
	            transform: scale(1.05);
	}
	.menu_container .menu_box_c1{background-color: #78cc50;}
	.menu_container .menu_box_c2{background-color: #fec97b;}
	.menu_container .menu_box_c3{background-color: #50ccf0;}
	.menu_container .menu_box_c4{background-color: #feb93a;}
	.menu_container .menu_box_c5{background-color: #3b5999}
	.menu_container .menu_box_c6{background-color: #00acee;}
	.menu_container .menu_box_c7{background-color: #313131;}
	.menu_container .menu_box_c8{background-color: #ea4c89;}
	.menu_container .menu_box_c9{background-color: #007bb6;}
	.menu_container .menu_box_c10{background-color: #df2f2f;}
	.menu_container .menu_box_c11{background-color: #00aaf0;}
	.menu_container .menu_box_c12{background-color: #ec1982;}
	.menu_container .fullheight{height: 100%;}
	.menu_container img{height: 50px;margin-top: 25%;}
	
	.menu_container .menu_box .menu_box_left{padding:0 30px;position: relative;height: 100%;}
	.menu_container .menu_box .menu_box_right{text-align: center;position: relative;height: 100%;padding: 0;}
	.menu_container .menu_box .menu_box_title{position: absolute;bottom: 10px;font-size: 16px;margin-left: 15px;}
	.menu_container .menu_box .menu_box_content{position: absolute;bottom: 10px;}
	.menu_container .menu_box .menu_box_tips{position: absolute;top: 50px;color: red;}
</style>
	<div class="row" style="padding:40px 0 20px;">
		<div class="col-sm-12">
			<div class="menu_container" data-num="0">
				<c:set var="sumitem" value="#"></c:set>
				<c:set var="tipitem" value="#"></c:set>
				<c:forEach items="${commonmenus }" var="menu" varStatus="st">
				<div class="menu_box menu_box2x1 menu_box_c${st.index+1}" url="${menu.url}" 
					onclick="loadContent(this,'${ctx}/${menu.url}','QUICK');" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<c:choose>
								<c:when test="${menu.id eq 21 || menu.id eq 43}">
									<c:set var="tipitem" value="${tipitem}prc#"></c:set>
									<div  class="menu_box_tips" style="display: none;">
										有<span id="prc_tips_num">5</span>个新审核需求
									</div>
								</c:when>
								<c:when test="${menu.id eq 27}">
									<c:set var="tipitem" value="${tipitem}rte#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span id="rte_tips_num">5</span>个新审核需求
									</div>
								</c:when>
								<c:when test="${menu.id eq 49 || menu.id eq 123}">
									<c:set var="tipitem" value="${tipitem}cms#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span  id="cms_tips_num">5</span>个新审核需求
									</div>
								</c:when>
								<c:when test="${menu.id eq 51}">
									<c:set var="tipitem" value="${tipitem}ord#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span  id="ord_tips_num">5</span>个新订单需求
									</div>
								</c:when>
								<c:when test="${menu.id eq 55}">
									<c:set var="tipitem" value="${tipitem}usr#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span id="usr_tips_num">5</span>个新审核需求
									</div>
								</c:when>
								<%-- <c:when test="${menu.id eq 74}">
									<c:set var="tipitem" value="${tipitem}ste#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span id="ste_tips_num" >5</span>个订单需求
									</div>
								</c:when>
								<c:when test="${menu.id eq 122}">
									<c:set var="tipitem" value="${tipitem}ivt#"></c:set>
									<div class="menu_box_tips" style="display: none;">
										有<span id="ivt_tips_num">5</span>个订单需求
									</div>
								</c:when> --%>
							</c:choose>
							<div class="menu_box_content">
							<c:choose>
								<c:when test="${menu.id eq 29}">
									<div style="font-size: 16px;"><c:set var="now" value="<%=new java.util.Date()%>" /> <fmt:formatDate pattern="E" value="${now}" /></div>
									<div style="font-size: 16px;"><fmt:formatDate pattern="yyyy/MM/dd" value="${now}" /></div>
								</c:when>
								<c:when test="${menu.id eq 51}">
									<c:set var="sumitem" value="${sumitem}order#"></c:set>
									<span id="menu_order_num" style="font-size: 20px;">0</span><span style="font-size: 10px;">个订单</span>
								</c:when>
								<c:when test="${menu.id eq 92}">
									<c:set var="sumitem" value="${sumitem}dongtai#"></c:set>
									<span id="menu_dongtai_num" style="font-size: 20px;">0</span><span style="font-size: 10px;">个动态</span>
								</c:when>
								<c:when test="${menu.id eq 74}">
									<c:set var="sumitem" value="${sumitem}site#"></c:set>
									<span id="menu_site_num" style="font-size: 20px;">0</span><span style="font-size: 10px;">个场地</span>
								</c:when>
								<c:when test="${menu.id eq 55}">
									<c:set var="sumitem" value="${sumitem}user#"></c:set>
									<span id="menu_user_num" style="font-size: 20px;">0</span><span style="font-size: 10px;">个用户</span>
								</c:when>
								<c:otherwise>
									${menu.enName}
								</c:otherwise>
							</c:choose>
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/${menu.icon}.png" style=""/>
							<div class="menu_box_title" style="">${menu.name}</div>
						</div>
					</div>
				</div>
				</c:forEach>
				<input type="hidden" name="sumitem" id="sumitem" value="${sumitem}">
				<input type="hidden" name="tipitem" id="tipitem" value="${tipitem}">
				<script type="text/javascript">
					$(function(){
						sumitem();
						tipitem();
					});
					function sumitem(){
						var sumitem = $("#sumitem").val();
						$.post('${ctx}/portal/sumitem',{sumitem:sumitem},function(res){
							if(res.statusCode=="200"){
								var sumitems = res.object;
								for (var k = 0, length = sumitems.length; k < length; k++) {
									 //alert(sumitems[k]);
									 $("#menu_"+sumitems[k].item+"_num").text(sumitems[k].num);
								}
							}
						},'json');
					}
					function tipitem(){
						var tipitem = $("#tipitem").val();
						$.post('${ctx}/portal/tipitem',{tipitem:tipitem},function(res){
							if(res.statusCode=="200"){
								var tipitems = res.object;
								for (var k = 0, length = tipitems.length; k < length; k++) {
									 //alert(sumitems[k]);
									 if(tipitems[k].num==0){
										 $("#"+tipitems[k].item+"_tips_num").parent().hide();
									 }else{
										 $("#"+tipitems[k].item+"_tips_num").text(tipitems[k].num);
										 $("#"+tipitems[k].item+"_tips_num").parent().show();
									 }
								}
							}
						},'json');
					}
				</script>
				<%-- 
				<div class="menu_box menu_box2x1 menu_box_c2" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								<span style="font-size: 20px;">1986</span><span style="font-size: 10px;">个订单</span>
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/order.png" style=""/>
							<div class="menu_box_title" style="">订单信息</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c3" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								Commission to the account
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/commission.png" style=""/>
							<div class="menu_box_title" style="">返佣对账</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c4" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								<span style="font-size: 20px;">26</span><span style="font-size: 10px;">个动态</span>
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/dongtai.png" style=""/>
							<div class="menu_box_title" style="">动态案例</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c5" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								Venue quotation review
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/quotation.png" style=""/>
							<div class="menu_box_title" style="">场地报价</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c6" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								<span style="font-size: 20px;">251246</span><span style="font-size: 10px;">个用户</span>
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/users.png" style=""/>
							<div class="menu_box_title" style="">用户管理</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c7" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								<span style="font-size: 20px;">251246</span><span style="font-size: 10px;">个场地</span>
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/sites.png" style=""/>
							<div class="menu_box_title" style="">场地管理</div>
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c8" url="${menu.url}" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
								Commission rate adjustment
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
							<img src="${ctx}/public/default/img/shouye/rate.png" style=""/>
							<div class="menu_box_title" style="">返佣比例调整</div>
						</div>
					</div>
				</div> --%>
			</div>
		</div>    
	</div>
	<hr style="border: 2px solid #e6e6e6;"/>
	<div class="row" style="padding:0;">
		<div class="col-sm-12">
			<div class="menu_container" data-num="0">
				<div class="menu_box menu_box2x1 menu_box_c9" >
					<div class="row fullheight">
						<div class="col-sm-5" style="text-align: right;padding: 0;">
							<img src="${ctx}/public/default/img/shouye/client.png" style=""/>
						</div>
						<div class="col-sm-6" style="padding: 0;margin-left: 10px;">
							<div style="font-size: 20px;margin-top: 20%;">客户端</div>
							<div style="font-size: 16px;">The client</div>
						</div>
					</div>
				</div>
				
				<div class="menu_box menu_box2x1 menu_box_c10"  >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c11" >
					<div class="row fullheight">
						<div class="col-sm-7 menu_box_left" style="">
							<div class="menu_box_content">
							</div>
						</div>
						<div class="col-sm-5 menu_box_right" style="">
						</div>
					</div>
				</div>
				<div class="menu_box menu_box2x1 menu_box_c12">
					<div class="row fullheight">
						<div class="col-sm-5" style="text-align: right;padding: 0;">
							<img src="${ctx}/public/default/img/shouye/tel.png" style=""/>
						</div>
						<div class="col-sm-6" style="padding: 0;margin-left: 10px;">
							<div style="font-size: 20px;margin-top: 20%;">会掌柜客服</div>
							<div style="font-size: 16px;">020-28319130</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- <div class="row">
		<div class="col-sm-12">
			<div class="widget_container" data-num="0" style="text-align: center;" >
			<c:forEach items="${commonmenus }" var="menu" varStatus="st">
					<div class="widget widget2x2 ${st.index%4 == 0?'widget_red':st.index%4 == 1?'widget_darkred':st.index%4 == 2?'widget_darkblue':'widget_green' }" url="${menu.url}" 
					onclick="loadContent(this,'${ctx}/${menu.url}','QUICK');" data-theme="red" data-name="Contact">
				
                    <div class="widget_content">
                        <div class="main" style="background-image:url('${ctx }/static/weixin/css/icon/main/${menu.icon}.png');">
                            <span>${menu.name}</span>
                        </div>
                    </div>
                    </div>
			</c:forEach>
            </div>
       </div>
	</div>
	<div class="row">
		<div class="col-sm-12" style="text-align: center;height: 100%;">
			<img class="gerenBnLfLo" src="${ctx}/static/resource/css/images/bg.png" style="width: 400px;">
			<br>
			<br>
			<a><span style="font-size: 48px;color: #1b5aaa;font-family: STXinwei;">欢迎使用会掌柜场地SAAS管理系统!</span></a>
		</div>
	</div>  --%>
</div>