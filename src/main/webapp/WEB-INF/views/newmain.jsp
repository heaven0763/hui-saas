<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
	<title>场地SAAS管理系统管理端 - 主页</title>
	<meta name="description" content="会掌柜（hui-china.com)是中国最全面的会议活动场所和服务供应商资源网站，允许专业人士和会议活动举办人员找到适合会议和活动的空间场所和服务供应商如：主持人，活动策划公司，摄影摄像师，活动搭建物料，舞台灯光音响设备等，协助他们顺利展开未来的会议活动。实现用户“好办会、办好会”，做办会议搞活动必备一站式资源搜索工具。">
    <meta name="Keywords" content="会掌柜,会议活动场地,公关会议活动策划执行公司,会展会议活动物料出租,演出演艺公司主持策划舞美设计,灯光音响LED摄影摄像设备,展览舞美制作工厂">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/common.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/newmain.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/sk.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap-table.min.css">   
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/sweetalert/sweetalert.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/plugins/kindeditor-4.1.10/themes/default/default.css" />
	<link type="text/css" rel="stylesheet" href="${ctx}/static/plugins/kindeditor-4.1.10/plugins/code/prettify.css" />
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/bootstrap-select.min.css" />
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/bootstrap-switch.min.css" />
	<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
	<style type="text/css">
		 .fa{width: auto;}
		.bootstrap-select .dropdown-menu {top: 100%; bottom: auto;}
		.schedule-detail{}
		.schedule-detail .tdline{border-left: none;background-color: #ddd;}
		.ibox .open>.dropdown-menu{left: 0;	right: auto;}
		.new{background-image: url('${ctx}/static/resource/css/images/new.png');background-repeat: no-repeat;background-position:right;
			color: #ff0000;position: absolute;right: -5px;top: -10px;font-size: 10px;width: 24px;height: 24px; }
			
		.news{background-image: url('${ctx}/static/resource/css/images/new.png');background-repeat: no-repeat;background-position:100% 0;}
		.btn-primary.btn-outline {
		    color: #008cd6;
		}
		.btn-outline {
		    color: inherit;
		    background-color: transparent;
		    -webkit-transition: all .5s;
		    transition: all .5s;
		}
		.table>tbody>tr>td{white-space:nowrap;text-overflow:ellipsis;word-break:break-all;overflow:hidden;}
	</style>
	
	
	<script src="${staticPath}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctx}/static/weixin/myjs/common.js"></script>
	<script src="${ctx}/static/weixin/myjs/template.js"></script>
	<script src="${ctx}/static/weixin/myjs/tools.js"></script>
	<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
	<script src="${ctx}/static/weixin/myjs/dict.js"></script>
	
	<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.format.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
	<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
	
	<script src="${ctx}/static/js/jquery.multi-select.js"></script>
	
	 <!--kindeditor  -->
	<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/kindeditor.js"></script>
	<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script type="text/javascript" src="${staticPath}/static/plugins/kindeditor-4.1.10/plugins/code/prettify.js"></script>
	 
	<script type="text/javascript">
	function nofindImg(self){
		var $this = $(self);
		$this.attr("src","${ctx}/public/default/img/avatar.png");
		$this.attr("onerror",null); //控制不要一直跳动
	}
	</script>
	
	<script type="text/javascript" src="${ctx}/static/plugins/fancybox/jquery.mousewheel.pack.js?v=3.1.3"></script>

	<!-- Add fancyBox main JS and CSS files -->
	<script type="text/javascript" src="${ctx}/static/plugins/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugins/fancybox/jquery.fancybox.css?v=2.1.5" media="screen" />

	<!-- Add Button helper (this is optional) -->
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugins/fancybox/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
	<script type="text/javascript" src="${ctx}/static/plugins/fancybox/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>

	<!-- Add Thumbnail helper (this is optional) -->
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugins/fancybox/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
	<script type="text/javascript" src="${ctx}/static/plugins/fancybox/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

	<!-- Add Media helper (this is optional) -->
	<script type="text/javascript" src="${ctx}/static/plugins/fancybox/helpers/jquery.fancybox-media.js?v=1.0.6"></script>
	
	
	<!--引入CSS-->
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugins/uploadify/css/uploadify.css">
	<!--引入JS-->
	<script type="text/javascript" src="${ctx}/static/plugins/uploadify/scripts/jquery.uploadify.js"></script>
	
</head>
<body>
	<div class="header">
		<div style="background: #052659;">
		    <div class="indexh width1000">
		        <div class="yetou">
		            <div class="yetoul">
		            </div>
		            <div class="yetour">
		            	<ul style="margin: 0;">
		            	  <a href="javascript:;" onclick="loadContent(this,'${ctx}/base/user/msg/index','')">  
		            	  <li style="position: relative;">
		            	  <i class="fa fa-bell-o"></i> 新消息
		            	  <div id="messageRemindState" style="width: 16px;height: 16px;background-color: red;position: absolute;right: -10px;top: 2px;border-radius:8px;color: #ffffff;line-height: 18px;text-align: center;font-size: 10px;display: none;">0</div>
		            	  </li></a>
		                   <a href="${ctx}/account/user/personInfo" target="dialog">  <li><i class="fa fa-user"></i> 个人资料</li></a>
		                   <a href="${ctx}/account/user/mypwdform" target="dialog"> <li><i class="fa fa-cog"></i> 重置密码 </li></a>
		                   <a href="${ctx}/logout"> <li><i class="fa fa-sign-out"></i> 退出</li></a>
		                </ul> 
		            </div>
		        </div>
		    </div>
		</div>
		<div style="background: #04184a;">
		    <div class="geren width1000">
		        <div class="gerenBnLf">
		            <c:if test="${aUs.getCurrentUserType() eq 'HOTEL'}">
		           		<a href="#" style="float: left;background-color: #ffffff;border: 1px solid #6e6e6e;">
			            <img class="gerenBnLfLo" src="${logo}">
			            </a>
		            </c:if>
		            <c:if test="${aUs.getCurrentUserType() ne 'HOTEL'}">
		            <a href="#" style="float: left;">
			            <img class="gerenBnLfLo" src="${ctx}/static/resource/css/images/logo.png">
		            </a>
		            </c:if>
		            <div class="gerenBnLfLo2">
		                <img id="myphoto" src="${user.avatar}"  class="img-circle" onerror="nofindImg(this);">
		                <div class="gerenBnLfLo2Ri">
		                    <div id="myname">
		                     	  ${user.rname} &nbsp; &nbsp;${user.mobile}
		                    </div>
		                    <a href="javascript:;">${aUs.getCurrentUserType() eq 'HOTEL'?cname:'会掌柜'} -- ${group.name}</a>
		                </div>
		            </div>
		        </div>
		        <div class="gerenBnRi">
		        </div>
		    </div>
		</div>
	</div>
	<div class="sjzx">
		<div class="sjzxnav">
			<ul >
				<li class="m-item active" ><a href="${ctx}/main" url="main">首页</a></li>
				<c:forEach items="${userRootMenus}" var="userRootMenu">
	            	<c:if test="${empty userRootMenu.authorizedChildrenMenuList }">
                  		<li class="m-item">
	                  		<c:if test="${userRootMenu.type eq 'other' }">
	                  			<a href="${userRootMenu.url}" url="${userRootMenu.url}"  target="_blank">${userRootMenu.name}</a>
	                  		</c:if>
	                  		<c:if test="${userRootMenu.type ne 'other' }">
	                  			<a href="javascript:;" url="${userRootMenu.url}" onclick="loadContent(this,'${ctx}/${userRootMenu.url}','ST');">${userRootMenu.name}</a>
	                  		</c:if>
                  		</li>
                  	</c:if>
                  	<c:if test="${not empty userRootMenu.authorizedChildrenMenuList }">
                  		<li class="m-item" style="position: relative;" onmouseover="mouseover(this)" onmouseout="mouseout(this)">
							<a href="javascript:;">${userRootMenu.name}</a>
							<div class="slnav" >
								<ul style="">
									<c:forEach items="${userRootMenu.authorizedChildrenMenuList}" var="childrenMenu">
										<c:if test="${not empty childrenMenu.authorizedChildrenMenuList }">
											<li style="position: relative;" onmouseover="mouseover(this)" onmouseout="mouseout(this)">
												<a href="javascript:;">${childrenMenu.name}</a>
												<div class="slnav" >
													<ul style="">
														<c:forEach items="${childrenMenu.authorizedChildrenMenuList}" var="cldmenu">
															<li> <%-- <a href="${ctx }/${cldmenu.url}">${cldmenu.name}</a> --%>
																<a href="javascript:;" url="${cldmenu.url}" onclick="loadContent(this,'${ctx }/${cldmenu.url}','RD');">${cldmenu.name}</a>
															</li>
														</c:forEach>
													</ul>
												</div>
											</li>
										</c:if>
										<c:if test="${empty childrenMenu.authorizedChildrenMenuList }">
											<li style="position: relative;">
												<a href="javascript:;" url="${childrenMenu.url}" onclick="loadContent(this,'${ctx }/${childrenMenu.url}','ND');">${childrenMenu.name}</a>
					                  			<%-- <a href="${ctx }${childrenMenu.url}">${childrenMenu.name}</a> --%>
					                  		</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div class="content" style="background-color:#f5f5f5;">
		<div id="pcontent" class="width1000 jiudianxq grdpxq sjzx" style="min-height:737px;position: relative;background-color:#ffffff;padding: 0 10px;">
			<!-- <iframe   style="border: 0;width: 100%;" onload="iframeLoad();"></iframe>  -->

			
			
			
		</div>
	</div> 
	
	 <div class="footer" style="">
	    <div style="background: #04184a;padding-bottom: 10px;padding-top: 10px;">
	        <div class="width1000" style="color: #ffffff;text-align: center;vertical-align: middle;">
	      	    <img class="gerenBnLfLo" src="${ctx}/public/hplus/img/loginlogo.png" style="height: 40px;">
	             &copy;2012-2017会掌柜  版权左右  ALL Right Reserved(粤ICP备15048082号-1)
	        </div>
	    </div>
	</div> 
	
	
	<!-- bootstrap js -->
<script src="http://code.jquery.com/jquery-migrate-1.1.1.js"></script> 
<script src="${staticPath}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${staticPath}/public/js/jquery.form.js"></script>
<script src="${staticPath}/public/js/jquery.base64.js"></script>
<script src="${staticPath}/public/js/jquery.scrollTo.min.js"></script>

<script src="${staticPath}/public/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/layer/layer.min.js"></script>
<script src="${staticPath}/public/hplus/js/hplus.min.js?v=4.1.0"></script>
<script src="${staticPath}/public/hplus/js/contabs.min.js" type="text/javascript" ></script>
<script src="${staticPath}/public/hplus/js/plugins/pace/pace.min.js"></script>

<script src="${staticPath}/public/hplus/js/content.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/iCheck/icheck.min.js"></script>



<script src="${staticPath}/public/hplus/js/plugins/validate/jquery.validate.min.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/validate/messages_zh.min.js"></script>
<script src="${staticPath}/public/hplus/js/demo/form-validate-demo.min.js"></script>
<script src="${staticPath}/public/js/bootstrap.dialog.js"></script>
<script src="${staticPath}/public/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>

<script src="${staticPath}/public/hplus/js/plugins/layer/laydate/laydate.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/clockpicker/clockpicker.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/datapicker/bootstrap-datepicker.js"></script> 
<script src="${staticPath}/public/hplus/js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>

<script type="text/javascript" src="${ctx}/public/bootstrap/js/bootstrap-paginator.js"></script>
<!-- bootstrap end-->

<!--ueditor  -->
<script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/ueditor.all.min.js"> </script>
 <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
 <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
 <script type="text/javascript" charset="utf-8" src="${staticPath}/static/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
 

<script src="${staticPath}/public/bootstrap/js/bootstrap-table.min.js"></script>
<script src="${staticPath}/public/bootstrap/js/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="${staticPath}/static/resource/js/bs.table.cof.js"></script>

<!-- tool -->
<script src="${staticPath}/public/js/js.extend.js"></script>
<script src="${staticPath}/public/js/bsj.js"></script>
<script src="${staticPath}/public/js/common.delegate.js"></script>
<script src="${staticPath}/public/js/common/LocalResizeIMG.js"></script>
<script src="${staticPath}/public/js/common/mobileBUGFix.mini.js"></script>
<script src="${staticPath}/static/js/util.date.js"></script>
<script src="${staticPath}/static/js/common.js"></script>


<script src="${ctx}/static/resource/js/bootstrap-switch.min.js"></script>
<script src="${ctx}/static/resource/js/bootstrap-select.min.js"></script>
<script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
<script type="text/javascript" src="${ctx}/static/resource/js/metro.js"></script>
	<script>
		var urls = [];
		if(document.addEventListener){

			document.addEventListener('click', function(event){
				$target = $(event.target);
				var url = $target.attr('url');
				if(!url){
					url = $target.attr('onclick');
					if(!url){
						url = $target.attr('href');
						if(!url){
							
						}else{
							urls.push(url);
						}
					}else{
						urls.push(url);
					}
				}else{
					urls.push(url);
				}
				
			}, false);
		}
		function log(){
		}
		function mouseover(self){
			var $this = $(self);
			$this.find('.slnav').show();
		}
		function mouseout(self){
			var $this = $(self);
			$this.find('.slnav').hide();
		}
		
		function loadContent(self,url,level){
		
			if(level==='ND'){
				$(".active").removeClass('active');
				$(".item-active").removeClass('item-active');
				$(self).parent().parent().parent().parent().addClass('active');
				$(self).parent().addClass('item-active');
			}else if(level==='ST'){
				$(".active").removeClass('active');
				$(self).parent().addClass('active');
			}else if(level==='QUICK'){
				$(".sjzxnav").find('li').removeClass('active');
				$(".sjzxnav").find('li').removeClass('item-active');
				var _url = url.replace('${ctx}/','');
				$(".sjzxnav").find('a[url="'+_url+'"]').parent().addClass('item-active');
				$(".sjzxnav").find('a[url="'+_url+'"]').parent().parent().parent().parent().addClass('active');
				urls.push(_url);
			}else{
				
			}
			
			show();
			/* 	$('#pcontent').attr('src', url);  */
		 	$("#pcontent").empty();
			
			$("#pcontent").load(url,{},function(res){
				hide();
				$("#pcontent").fadeIn('slow');
			}); 
		}
		$(function(){
			var storage=window.localStorage;
            storage.removeItem("dictJson");
            storage.removeItem("permissions");
            storage.removeItem("readOrder${aUs.getCurrentUserId()}");
            window.sessionStorage.removeItem("operateOrder${aUs.getCurrentUserId()}");
            window.sessionStorage.removeItem("reconciliationReadOrder${aUs.getCurrentUserId()}");
			loadContent(this,'${ctx}/portal/index',"rd")
			var mypermissions = "<%=request.getAttribute("permissions") %>";
			if(mypermissions!=null&&mypermissions!=''&&mypermissions!='null'){
				common.setstorage("permissions",mypermissions);		
			}
			
		   	var ff='<div class="spiner-example" style="padding-top: 400px;"><div class="sk-spinner sk-spinner-fading-circle" style="width:64px;height:64px;">'
		   	+' <div class="sk-circle1 sk-circle"></div>'
		   	+' <div class="sk-circle2 sk-circle"></div>'
		   	+' <div class="sk-circle3 sk-circle"></div>'
		   	+' <div class="sk-circle4 sk-circle"></div>'
		   	+' <div class="sk-circle5 sk-circle"></div>'
		   	+' <div class="sk-circle6 sk-circle"></div>'
		   	+' <div class="sk-circle7 sk-circle"></div>'
		   	+' <div class="sk-circle8 sk-circle"></div>'
		   	+' <div class="sk-circle9 sk-circle"></div>'
		   	+' <div class="sk-circle10 sk-circle"></div>'
		   	+' <div class="sk-circle11 sk-circle"></div>'
		   	+' <div class="sk-circle12 sk-circle"></div></div></div>';
		   	var $maskDiv=  $('<div id="marks" class="modal-backdrop fade in" style="z-index:10000;display:none;">'+ff+'</div>').appendTo('body');
		   	messageRemind();
	   });
	   function show(zidx){
		   $("#marks").show();
		   if(zidx){
			   $("#marks").css("z-index",zidx);
		   }
	   }
	   function hide(){
		   $("#marks").hide();
		   $("#marks").css("z-index",10000);
	   }
	   function iframeLoad() {  
		   hide();
	       document.getElementById("pcontent").height=0;  
	       document.getElementById("pcontent").height=document.getElementById("pcontent").contentWindow.document.body.scrollHeight;  
	   }  
	   function areaclear(tag,itemId){
			if(tag){
				if(itemId){
				}
				$("#district").html('');
				$("#tradeArea").html('');
			}else{
				$("#city").html('');
				$("#district").html('');
				$("#tradeArea").html('');
			}
		} 
	   
	   function cfm_swal(title,text,type,action,msg,cmsg,url,data,cbfn){
		   swal({
		        title: title,
		        text: text,
		        type: type,
		        showCancelButton: true,
		        confirmButtonColor: "#DD6B55",
		        confirmButtonText: action,
		        cancelButtonText: "取消",
		        closeOnConfirm: false,
		        showLoaderOnConfirm: true
		    }, function (isConfirm)  {
		    	if (isConfirm) {
		    		//show();
		   	     	$.post(url, data, function (res, status) { 
		   	     		if(status=="success"&&res.statusCode=="200"){
		   	     			swal(res.message, "success");
		   	     			if(cbfn){
		   	     				cbfn();
		   	     			}
		   	     		}else{
		   	     			swal(res.message, "error");
		   	     		}
		   	     		//hide();
		   	     	}, 'json');
				} else {
					swal("已取消", cmsg, "error")
				}
		    });
	   }
	   
	   function messageRemind(){
		   $.ajax({
			    url: '${ctx}/weixin/message/remind/count',
			    type: 'GET',
			    dataType: 'json',
			    error: function(){
			    },
			    success: function(res){
					if(res.statusCode==='200'){
						if(res.object>0){
							$("#messageRemindState").show();
							$("#messageRemindState").text(res.object);
						}else{
							$("#messageRemindState").hide();
							$("#messageRemindState").text(0);
						}
						//setTimeout("messageRemind()",5000);
					}
				}
			});
		}
	   
	   function orderRowStyle(row, index) {
		    if (row.state === '03' || row.state === '05' || row.state === '10'|| row.state === '12'|| row.state === '13') {
		        return {
		            css: {"color":"#cccccc"}
		        };
		    }
		    return {};
		}
	   function userRowStyle(row, index) {
		   
		    if (!row.state || row.state==null || row.state === '0') {
		        return {
		            css: {"color":"#cccccc"}
		        };
		    }
		    return {};
		}
	</script>

</body>
</html>