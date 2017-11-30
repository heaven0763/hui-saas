<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<%@include file="/WEB-INF/ui.inc.jsp"%>
<script type="text/javascript">
 function doDel(url,rtype){
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post(url, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			if(rtype=="userOrg_search"){
   	     				userOrg_search();
   	     			}else  if(rtype=="userGathered_search"){
   	     				userGathered_search();
   	     			}else  if(rtype=="userProcess_search"){
   	     				userProcess_search();
   	     			}
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了删除操作！", "error")
		}
    });
}
</script>
<div class="wrapper wrapper-content">
	<div class="form-group"><%-- ${ctx}/account/user/index?memberType=${upUser.memberType} --%>
		<a href="javascript:window.history.go(-1)" class="btn btn-warning"><spanclass="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	</div>
	<div class="ibox ">
		<div class="ibox-content">
			<div class="tab-content">
				<div id="contact-1" class="tab-pane active">
					<div class="row m-b-lg">
	           			<div style="margin-top:3%;margin-bottom:3%;">
	           				<h2>基本信息</h2>
	           			</div>
						<div class="col-lg-4 text-center" style=" float: left; width:200px;  padding: 20px;">
							<div class="m-b-sm" >
								<img alt="image" class="img-circle" src="${upUser.avatar}"  style="width: 80px;height:80px;">
								<div>
									<h3>${upUser.username}</h3>
								</div>
							</div>
						</div>
						<div class="col-lg-4" style="display: table-cell; vertical-align: top; float: left; width: 300px; padding: 20px; margin-left: 50px; padding-right: 50px; border-right:1px solid #d1cacb;">
							<div class="m-b-sm">
								<p><i class="fa fa-user"></i> 用户账号：${upUser.username }</p>
								<p><i class="fa fa-phone"></i> 联系电话：${upUser.mobile }</p>
								<p><i class="fa fa-envelope-o"></i> 邮箱：${empty upUser.email?"无":upUser.email } </p>
							</div>
						</div>
						<div class="col-lg-4"style="display: table-cell; vertical-align: top; float: left; width: auto; padding: 20px; margin-left: 50px;">
							<div class="m-b-sm">
							<p><i class="fa fa-building-o"></i> 所属公司：${empty upUser.workingCompany?"无":upUser.workingCompany } </p>
	                            <p><i class="fa fa-black-tie"></i> 当前职务：${empty upUser.workingPosition?"无":upUser.workingPosition  } </p>
								<p><i class="fa fa-mobile"></i> 客户端：${upUser.type eq '3'?'安卓':'IPhone' }</p>
								<p> <i class="fa fa-calendar"></i> 创建时间：${upUser.createDate} </p>
							</div>
						</div>
					</div>
					<div class="row m-t-sm">
						<h3>简介</h3>
						<div class="ibox-content ">
							<div>${empty upUser.description?"无":upUser.description }</div>
						</div>
					</div>
				<c:if test="${upUser.memberType ne 99}">
					<hr>
					<div class="row m-t-sm" style="margin-top:2%;">
						<div style="margin-top:3%;margin-bottom:3%;">
	           				<h2>关联信息</h2>
	           			</div>
						<div class="col-sm-12">
							<div class="panel blank-panel">
								<div class="panel-heading">
									<div class="panel-options">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#tab-1" data-toggle="tab">所创项目</a></li>
											<li class=""><a href="#tab-2" data-toggle="tab">投递记录</a></li>
											<li class=""><a href="#tab-3" data-toggle="tab">FA申请记录</a></li>
											<li class=""><a href="#tab-4" data-toggle="tab">邀约VC记录</a></li>
											<li class=""><a href="#tab-5" data-toggle="tab">融资申请记录</a></li>
											<li class=""><a href="#tab-6" data-toggle="tab">服务申请记录</a></li>
										</ul>
									</div>
								</div>
							    <div class="panel-body">
									<div class="tab-content">
										<div class="tab-pane active" id="tab-1">
											<script type="text/javascript">
												 function fm_project_operate(value,row, index){
														return '<a href="${ctx}/cb/project/detail/'+row.id+'" class="btn btn-primary" title="查看项目"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>';	
												  }
												 function bp(value,row, index){
														if(value == null||value == ""){
															return "未上传BP";
														}else{
															var len=value.length;//获取url的长度
															var offset=value.indexOf("static");//设置参数字符串开始的位置
															var newsinfo=value.substr(offset,len);//取出参数字符串 这里会获得类似“id=1”这样的字符串
															var uriec = $.base64.encode(newsinfo);
															var url = "${ctx}/public/pdfjs/web/viewer.html?hh="+uriec;
															return '<a href="'+url+'" target="_blank" >'+'查看BP'+'</a>';
														}
													}
												 function chkstate(value,row, index){
														if(value=="0"){
															return "下架";
														}else if(value=="1"){
															return "上架";
													    }else{
															return "待审核";
													    }
													}
											</script>
											<table id="project_table" data-toggle="table" data-height="660" data-query-params="project_queryParams"
												data-pagination="true" data-url="${ctx}/cb/project/list/${upUser.id}" data-data-type="json">
												    <thead>
												        <tr>
															<th data-field="name">项目名称</th>
															<th data-field="location">项目所在地</th>
															<th data-field="domain">项目领域</th>
															<th data-field="bpurl" data-formatter="bp">BP</th>
															<th data-field="financingState">本次融资</th>
															<th data-field="createDate">创建日期</th>
															<th data-field="chkstate" data-formatter="chkstate">项目审核状态</th>
														    <th data-formatter="fm_project_operate">操作</th>  
												        </tr>
												    </thead>
											</table>
										</div>
										<div class="tab-pane" id="tab-2">
											<script type="text/javascript">
												function fm_deliverProject_operate(value,row, index){
													return  '<a href="${ctx}/cb/deliverProject/detail/'+row.id+'/'+row.projectId+'" class="btn btn-primary" title="查看投递记录"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>';	
												}
												function state(value,row, index){
													if(value=="0"){
														return "已发送";
													}else if(value=="1"){
														return "已阅读";
												    }else if(value=="3"){
														return "感兴趣";
												    }else if(value=="9"){
														return "不感兴趣";
												    }else{
														return "已约谈";
												    }
												}
												function formUserName(value,row, index){
													if(value==null){
														return "创帮推送";
													}else{
														return value;
													}
												}
								            </script>
											<table id="deliverProject_table" data-toggle="table" data-height="660" data-query-params="deliverProject_queryParams"
											data-pagination="true" data-url="${ctx}/cb/deliverProject/listUser/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="toUserName">接收者</th>
														<th data-field="projectName">项目名称</th>
														<th data-field="state" data-formatter="state">投递状态</th>
														<th data-field="createdAt">投递时间</th>
														<th data-formatter="fm_deliverProject_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
										</div>
										<div class="tab-pane" id="tab-3">
											<script type="text/javascript">
												 function fm_faRecord_operate(value,row, index){
												 	var state =  '';
													if(row.state == "1"){
														state+='<button type="button" onclick="faRecord_applying_fun(\''+row.id+'\',\''+"您确定要通过该审核吗"+'\',\''+"通过审核"+'\',\'2\')" class="btn btn-primary"><span class="glyphicon glyphicon-ok-sign"> </span> 通过</button>'
														+'&nbsp;&nbsp;<a href="${ctx}/cb/faRecord/failure/'+row.id+'" target="dialog" class="btn btn-danger" title="审核失败原因填写"><span class="glyphicon glyphicon-remove"> </span>失败</a>&nbsp;&nbsp;';
													}else if(row.state == "2"){
														state+='<button type="button" onclick="faRecord_signing_fun(\''+row.id+'\',\''+"您确定要与之签约吗"+'\',\''+"签约"+'\',\'9\')" class="btn btn-warning"><span class="glyphicon glyphicon-ok-sign"> </span> 签约</button>&nbsp;&nbsp;'
													}else{
													}
													return state
													+'<a href="${ctx}/cb/faRecord/detail/'+row.id+'/'+row.pjtid+'" class="btn btn-primary" title="查看"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>'; 
												 }
												 function fm_faRecord_state(value,row, index){
													if(row.state=="0"){
														return "审核失败";
													}if(row.state=="1"){
														return "待审核";
													}if(row.state=="2"){
														return "待签约";
													}else{
														return "已签约";
													}
												}
												 function bp(value,row, index){
														if(value == null){
															return "未上传BP";
														}else{
															var len=value.length;//获取url的长度
															var offset=value.indexOf("static");//设置参数字符串开始的位置
															var newsinfo=value.substr(offset,len);//取出参数字符串 这里会获得类似“id=1”这样的字符串
															var uriec = $.base64.encode(newsinfo);
															var url = "${ctx}/public/pdfjs/web/viewer.html?hh="+uriec;
															return '<a href="'+url+'" target="_blank" >'+'查看BP'+'</a>';
														}
													}
												 function fm_faRecord_bpfile(value,row, index){
														return '<a href="${ctx}/cb/faRecord/detail/'+row.id+'/'+row.pjtid+'"  title="查看">点击查看BP</a>';
													}
													function faRecord_applying_fun(id,title,ctype,state){
														var url='${ctx}/cb/faRecord/applying/'+id+'?state='+state;
														dopost(title,ctype,url)
													}
													function faRecord_signing_fun(id,title,ctype,state){
														var url='${ctx}/cb/faRecord/signing/'+id+'?state='+state;
														dopost(title,ctype,url)
													}
													function dopost(title,ctype,url){
														swal({
													        title: title,
													        text: "",
													        type: "warning",
													        showCancelButton: true,
													        confirmButtonColor: "#DD6B55",
													        confirmButtonText: ctype,
													        closeOnConfirm: false,
													        showLoaderOnConfirm: true
													    }, function (isConfirm)  {
													    	if (isConfirm) {
													    		parent.show();
													   	     	$.post(url, "", function (res, status) { 
													   	     		if(status=="success"&&res.statusCode=="200"){
													   	     			swal(res.message, "success");
													   	     			faRecord_search();
													   	     		}else{
													   	     			swal(res.message, "error");
													   	     		}
													   	     		parent.hide();
													   	     	}, 'json');
															} else {
																swal("已取消", "您取消了"+ctype+"操作！", "error")
															}
													    });
													}
 											</script>
											<table id="faRecord_table" data-toggle="table" data-height="660" data-query-params="faRecord_queryParams"
											data-pagination="true" data-url="${ctx}/cb/faRecord/list/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="state" data-formatter="fm_faRecord_state">申请状态</th>
														<th data-field="applyDate">申请时间</th>
														<th data-field="chkUname">审核人</th>
														<th data-field="chkDate">审核时间</th>
													    <th data-formatter="fm_faRecord_operate">操作</th>
											        </tr>
											    </thead>
											</table>
											<script>
												function faRecord_search(){
														$("#faRecord_table").bootstrapTable("refresh");
												}
											</script>
										</div>
										<div class="tab-pane" id="tab-4">
											<script type="text/javascript">
												function fm_inviteRecord_operate(value,row, index){
													return  '<a href="${ctx}/cb/inviteRecord/detail/'+row.id+'/'+row.pjtid+'/'+row.vcid+'" class="btn btn-primary" title="查看邀约记录"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>';	
												}
												function state(value,row, index){
													if(value=="0"){
														return "邀约失败";
													}else if(value=="1"){
														return "待确定";
												    }else if(value=="2"){
														return "邀约成功";
												    }else{
														return "已取消";
												    }
												}
												function iscome(value,row, index){
													if(value=="0"){
														return "未赴约";
													}else if(value=="1"){
														return "待赴约";
												    }else if(value=="2") {
														return "已赴约";
												    }else{
												    	return "待确定";
												    }
												}	
											</script>
											<table id="inviteRecord_table" data-toggle="table" data-height="660" data-query-params="inviteRecord_queryParams"
											data-pagination="true" data-url="${ctx}/cb/inviteRecord/listUser/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="sdate">VC开始日期</th>
														<th data-field="stime">开始时间</th>
														<th data-field="edate">VC结束日期</th>
														<th data-field="etime">结束时间</th>
														<th data-field="vcname">投资人</th>
														<th data-field="applyDate">申请时间</th>
														<th data-field="state" data-formatter="state">状态</th>
														<th data-field="iscome" data-formatter="iscome">是否已赴约</th>
														<th data-formatter="fm_inviteRecord_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
										</div> 
										<div class="tab-pane" id="tab-5">
											<script type="text/javascript">
												 function fm_financingRecord_operate(value,row, index){
													 return  '<a href="${ctx}/cb/financingRecord/detail/'+row.id+'" class="btn btn-primary" title="查看融资记录"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>';	
												}
											 </script>
											<table id="financingRecord_table" data-toggle="table" data-height="660" data-query-params="financingRecord_queryParams"data-pagination="true" data-url="${ctx}/cb/financingRecord/list/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="vName">投资人</th>
														<th data-field="pjtName">项目名</th>
														<th data-field="financingTime">融资时间</th>
														<th data-field="financingStage">融资阶段</th>
														<th data-field="financingAmount">融资额度</th>
														<th data-field="createDate">申请时间</th>
														<th data-field="state">状态</th>
														<th data-formatter="fm_financingRecord_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
										</div> 
										<div class="tab-pane" id="tab-6">
										<script type="text/javascript">
											 function fm_serviceApply_operate(value,row, index){
												 var state =  '';
													if(row.state == "申请已提交"){
														state+='<button type="button" onclick="serviceApply_handler_fun(\''+row.id+'\',\''+"您确定要受理该申请吗"+'\',\''+"受理"+'\',\'2\')" class="btn btn-primary"><span class="glyphicon glyphicon-ok-sign"> </span> 受理</button>'
														+'&nbsp;&nbsp;<a href="${ctx}/cb/serviceApply/failure/'+row.id+'" target="dialog" class="btn btn-warning" id="mdlg" title="失败原因填写"><span class="glyphicon glyphicon-off"> </span> 失败</a>&nbsp;&nbsp;';
													}else if(row.state == "受理中"){
														state+='<button type="button" onclick="serviceApply_applying_fun(\''+row.id+'\',\''+"您确定要通过该申请吗"+'\',\''+"成功"+'\',\'3\')" class="btn btn-primary"><span class="glyphicon glyphicon-ok-sign"> </span> 成功</button>'
														+'&nbsp;&nbsp;<a href="${ctx}/cb/serviceApply/failure/'+row.id+'" target="dialog" class="btn btn-warning" id="mdlg" title="失败原因填写"><span class="glyphicon glyphicon-off"> </span> 失败</a>&nbsp;&nbsp;';
													}else if(row.state == "已通过"){
													}else{
													}
													return state
													+'<a href="${ctx}/cb/serviceApply/detail/'+row.id+'" class="btn btn-primary" title="查看"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>'; 
											 } 
											 function serviceApply_handler_fun(id,title,ctype,state){
													var url='${ctx}/cb/serviceApply/handler/'+id+'?state='+state;
													dopost(title,ctype,url)
												}
											 function serviceApply_applying_fun(id,title,ctype,state){
												var url='${ctx}/cb/serviceApply/applying/'+id+'?state='+state;
												dopost(title,ctype,url)
											 }
											 function dopost(title,ctype,url){
												swal({
											        title: title,
											        text: "",
											        type: "warning",
											        showCancelButton: true,
											        confirmButtonColor: "#DD6B55",
											        confirmButtonText: ctype,
											        closeOnConfirm: false,
											        showLoaderOnConfirm: true
											    }, function (isConfirm)  {
											    	if (isConfirm) {
											    		parent.show();
											   	     	$.post(url, "", function (res, status) { 
											   	     		if(status=="success"&&res.statusCode=="200"){
											   	     			swal(res.message, "success");
											   	     		    serviceApply_search();
											   	     		}else{
											   	     			swal(res.message, "error");
											   	     		}
											   	     		parent.hide();
											   	     	}, 'json');
													} else {
														swal("已取消", "您取消了"+ctype+"操作！", "error")
													}
											    });
											 }
										  </script>
										  <table id="serviceApply_table" data-toggle="table" data-height="660" data-query-params="serviceApply_queryParams"
											data-pagination="true" data-url="${ctx}/cb/serviceApply/list/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="serviceType">服务类型</th>
														<th data-field="contactName">联系人姓名</th>
														<th data-field="contactPhone">联系手机</th>
														<th data-field="companyName">公司名称</th>
														<th data-field="applyDate">申请时间</th>
														<th data-field="handlers">审核员</th>
														<th data-field="checkDate">审核日期</th>
														<th data-field="state">申请状态</th>
													    <th data-formatter="fm_serviceApply_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
											<script>
											function serviceApply_search(){
												$("#serviceApply_table").bootstrapTable("refresh");
											}
											</script>
										</div>
										<%-- <div class="tab-pane" id="tab-2">
											<script type="text/javascript">
												function fm_comment_operate(value,row, index){
													return '<a href="${ctx}/cb/comment/update/'+row.id+'" target="dialog" class="btn btn-primary" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
													+'&nbsp;&nbsp;<button type="button" onclick="comment_del_fun(\''+row.id+'\')" class="btn btn-danger"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
												}
												function chktable(value,row, index){
													return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
												}
												function fm_news_ptext(value,row, index){
														if(value.length>20){
															value = value.substring(0,20);
															return value+"...";
														}else{
															return value;
														}
													}
												function fm_comment_type(value,row, index){
													if(value==null){
														return  '创客圈动态';
													}else if(value=='PROJECT'){
														return  '项目';
													}else if(value=='DEMAND'){
														return  '需求';
													}else{
														console.log(value);
														return  '评论';
													}
												}
											</script>
											<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams"
											data-pagination="true" data-url="${ctx}/cb/comment/list/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
														<th data-field="type" data-formatter="fm_comment_type">评论类型</th>
														<th data-field="createdAt">评论时间</th>
														<th data-field="ptext">评论内容</th>
											        </tr>
											    </thead>
											</table>
										</div>
										<div class="tab-pane" id="tab-3">
											<script type="text/javascript">
												function fm_user_operate(value,row, index){
													var state =  '';
													return state+='&nbsp;&nbsp;<a href="${ctx}/account/user/detail/'+row.id+'" class="btn btn-info" title="查看用户信息"><span class="glyphicon glyphicon-eye-open"> </span> 查看</a>';		
												}
												function chktable(value,row, index){
													return '<input id="selectAll'+row.id+'" name="btSelectAll" type="checkbox">';
												}
												function fm_user_sex(value,row, index){
													if(value=="1"){
														return "男";
													}else{
														return "女";
													}
												}
												function fm_user_state(value,row, index){
													if(row.locked=="0"){
														return "使用中";
													}else{
														return "已锁定";
													}
												}
											</script>
											<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams"
											data-pagination="true" data-url="${ctx}/account/user/myfriendsList/${upUser.id}" data-data-type="json">
											    <thead>
											        <tr>
											        	<!-- <th class="bs-checkbox" style="width: 36px;" data-field="id" data-formatter="chktable"> <input name="btSelectAll" type="checkbox"></th>
														 --><th data-field="username">用户帐号</th>
														<th data-field="nickname">用户名</th>
														<th data-field="sex" data-formatter="fm_user_sex">性别</th>
														<th data-field="mobile">联系电话</th>
														<th data-field="email">电子邮箱</th>
														<th data-field="createDate">注册时间</th>
														<th data-field="memo">备注</th>
														<th data-options="locked" data-formatter="fm_user_state">状态</th>
														<th data-formatter="fm_user_operate">操作</th> 
											        </tr>
											    </thead>
											</table>
										</div> --%>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
										