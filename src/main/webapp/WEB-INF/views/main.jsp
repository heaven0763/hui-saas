<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>场地SAAS管理系统管理端 - 主页</title>
	<meta name="description" content="会掌柜（hui-china.com)是中国最全面的会议活动场所和服务供应商资源网站，允许专业人士和会议活动举办人员找到适合会议和活动的空间场所和服务供应商如：主持人，活动策划公司，摄影摄像师，活动搭建物料，舞台灯光音响设备等，协助他们顺利展开未来的会议活动。实现用户“好办会、办好会”，做办会议搞活动必备一站式资源搜索工具。">
    <meta name="Keywords" content="会掌柜,会议活动场地,公关会议活动策划执行公司,会展会议活动物料出租,演出演艺公司主持策划舞美设计,灯光音响LED摄影摄像设备,展览舞美制作工厂">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img id="myphoto" alt="image" class="img-circle" src="${aUs.getCurrentUserPhoto()}" style="width: 62px;height: 62px;" onerror="nofind()" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">${aUs.getCurrentRName()}</strong></span>
                                <span class="text-muted text-xs block">${group.name}</span> </span>
                            </a>
                            <%-- <b class="caret"></b>
                             <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" href="form_avatar.html">修改头像</a></li>
                                <li><a class="J_menuItem" href="profile.html">个人资料</a></li>
                                <!-- <li><a class="J_menuItem" href="contacts.html">联系我们</a></li>
                                <li><a class="J_menuItem" href="mailbox.html">信箱</a></li> -->
                                <li class="divider"></li>
                                <li><a href="${ctx}/logout">安全退出</a></li>
                            </ul>  --%>
                        </div>
                        <div class="logo-element">会掌柜
                        </div>
                    </li>
                    
                    <c:forEach items="${userRootMenus}" var="userRootMenu">
                    	<c:if test="${empty userRootMenu.authorizedChildrenMenuList }">
                    		<li>
                    			<a class="J_menuItem" href="${ctx }${userRootMenu.url}" data-index="0">
											<i class="fa ${userRootMenu.icon}"></i>
	                          				<span class="nav-label">${userRootMenu.name}</span></a> 
                    		</li>
                    	</c:if>
                    	<c:if test="${not empty userRootMenu.authorizedChildrenMenuList }">
	                    	<li>
								<a href="#">
		                            <i class="fa ${userRootMenu.icon}"></i>
		                            <span class="nav-label">${userRootMenu.name}</span>
		                            <span class="fa arrow"></span>
		                        </a>
								<ul class="nav nav-second-level">
									<c:forEach items="${userRootMenu.authorizedChildrenMenuList}" var="childrenMenu">
										<c:if test="${not empty childrenMenu.authorizedChildrenMenuList }">
											<li>
											<a href="#">
					                            <i class="fa ${childrenMenu.icon}"></i>
					                            <span class="nav-label">${childrenMenu.name}</span>
					                            <span class="fa arrow"></span>
					                        </a>
											<ul class="nav nav-third-level">
												<c:forEach items="${childrenMenu.authorizedChildrenMenuList}" var="cldmenu">
													<li> <a class="J_menuItem" href="${ctx }${cldmenu.url}" data-index="0">${cldmenu.name}</a> </li>
												</c:forEach>
											</ul>
										</c:if>
										<c:if test="${empty childrenMenu.authorizedChildrenMenuList }">
											<li> 
												<a class="J_menuItem" href="${ctx }${childrenMenu.url}" data-index="0">
												<i class="fa ${childrenMenu.icon}"></i>
		                          				<span class="nav-label">${childrenMenu.name}</span></a> 
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
                    	</c:if>
						
					</c:forEach>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#" style="padding: 9px 12px;"><i class="fa fa-bars"></i> </a>
                    </div>
                   <ul class="nav navbar-top-links navbar-right">
                    	<li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#" aria-expanded="true">
                                <i class="fa fa-bell"></i> <span id="todoNum" class="label label-primary" style="top: 5px;">0</span>
                                                                系统消息
                            </a>
                            <ul  class="dropdown-menu dropdown-messages" >
                           		 <li id="todolist" onclick="index_load_fun('todo');">  <div class="text-center link-block"> <a>
                             		<i class="fa fa-envelope"></i> <span class="nav-label" style="display: none;"></span><strong> 查看所有消息</strong> </a>  </div> </li>
                            </ul>
                        </li>
                        
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="${ctx}/portal/index">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight" style="right: 220px;"><i class="fa fa-forward"></i></button>
                <div class="btn-group roll-nav roll-right" style="right: 140px;">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right" >
                        <li class="J_tabShowActive"><a>定位当前选项卡</a></li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
                    </ul>
                </div>
                 <div class="btn-group roll-nav roll-right" style="right: 60px;"> 
                    <button class="dropdown" data-toggle="dropdown">个人设置<span class="caret"></span></button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                         <li><a href="${ctx}/shop/user/mypwdform" target="dialog"><i class="fa fa-sign-out"></i> 修改密码</a></li>
                         <li><a href="${ctx}/shop/user/personInfo" target="dialog"><i class="fa fa-user"></i> 个人资料</a></li>
                         <li class="divider"></li>
                         <li><a href="${ctx}/logout"><i class="fa fa-sign-out"></i> 安全退出</a></li>
                    </ul>
                </div>
                 <a href="${ctx}/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a> 
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${ctx}/portal/index" frameborder="0" data-id="${ctx}/portal/index" seamless></iframe> 
            </div>
            <div class="footer">
                <div class="pull-right">&copy; 2016 
                </div>
            </div>
        </div>
       
        <!--右侧边栏结束-->
    </div>
    <div style="display: none;">
		<a id="more_order_btn" class="J_menuItem" href="${ctx}/shop/order/index" data-index="0"> <i class="fa "></i> <span class="nav-label">订单管理</span></a>
		<a id="cnfm_order_btn" class="J_menuItem" href="" data-index="0"> <i class="fa "></i> <span class="nav-label">确认订单</span></a>
		<a id="order_detail_btn" class="J_menuItem" href="#" data-index="0"> <i class="fa "></i> <span class="nav-label"></span></a>
	</div>
	
    <script type="text/javascript">
	    
	    function index_load_fun(type){
			if(type=='order'){
				$("#more_order_btn").click();
			}
		}
	    function detail_load_fun(type,id){
			if(type=='ORDER'){
				$("#order_detail_btn").find("span").text("订单详情");
				$("#order_detail_btn").attr("href","${ctx}/portal/sysrecordetail/"+id);
				$("#order_detail_btn").click();
			}
		}
	    var todolisthtml = '<li class="m-t-xs" onclick="detail_load_fun(\'{0}\',\'{5}\')"> <div class="dropdown-messages-box">'
	   		  + '<div class="media-body">   <small class="pull-right text-navy">{4}</small> <div>{2}<div>'
	 		  + '<small class="text-muted">{3}</small>  </div>  </div>  </li>  <li class="divider"></li>';
	 		  
	 		var tofolast = '<li >  <div class="text-center link-block"> <a class="J_menuItem" href="${ctx}/admin/im/index" data-index="0">'
	 		  + ' <i class="fa fa-envelope"></i> <strong> 查看所有消息</strong> </a>  </div> </li>';  
	   $(function(){
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
		   	var $maskDiv=  $('<div id="marks" class="modal-backdrop fade in" style="z-index:9986;display:none;">'+ff+'</div>').appendTo('body');
		   	flashNum();
	   });
	   function show(){
		   $("#marks").show();
	   }
	   function hide(){
		   $("#marks").hide();
	   }
	   var $todolists;
	   function flashNum(){
		   var url = '${ctx}/portal/flashnum';
		   $.ajax({
				type: "GET",
				url: url,
				dataType: "json",
				cache: false,
				timeout: 100000,
				success: function (res) {
					 if(res.success){
						$("#todoNum").text(res.obj);
						if(res.obj*1>0){
							 var url="${ctx}/portal/getsysrecord";
							$.get(url, function (res, status) { 
								if(status=="success"&&res.total>=0){
									if($todolists){
										$todolists.remove();
									}
									var _listhtml = '';
									$.each(res.rows, function(i, item){
										var _todolisthtml = todolisthtml;
										_todolisthtml = _todolisthtml.replace('{3}',item.createdAt).replace('{5}',item.id).replace('{0}',item.itemType);
										_todolisthtml = _todolisthtml.replace('{2}',item.ptext).replace('{4}',item.title);
										_listhtml+=_todolisthtml;
									});
									$todolists = $(_listhtml);
									$("#todolist").before($todolists);
								}
							}, 'json');  
						}
					 }
					 //flashNum();
				},
				error: function (err) {
					flashNum();
				}
			}); 
	   }
	 
    </script>
</body>
</html>
