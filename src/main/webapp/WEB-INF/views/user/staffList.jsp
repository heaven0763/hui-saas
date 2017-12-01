<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<% 
	String type = request.getParameter("type");
	type = (type == null || type.length() == 0)?AccountUtils.getCurrentUserType().equals("HOTEL")?"2":"1":type;
%>
<div class="wrapper wrapper-content">
	<h3>职员管理${aUs.getCurrentUserType()}</h3>
	<hr>
	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	<div class="form-group" style="text-align: center;">
		<button id="user_type_1" type="button" onclick="user_type_sel(this,'1')" class="btn btn-primary" style="width: 49.5%">会掌柜人员</button>
		<button id="user_type_2" type="button" onclick="user_type_sel(this,'2')" class="btn btn-outline btn-primary" style="width: 49.5%">场地方人员</button>
		<input type="hidden" id="user_type" value="<%=type%>">
	</div>
	</c:if>
	<div id="huimenutools" class="form-group">
		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
		<a qx="user:add" href="${ctx}/base/user/create" target="dialog" class="btn btn-primary btn-sm" title="添加职员" width="800"><span class="glyphicon glyphicon-plus"></span> 添加职员</a>
		<a qx="user:add" href="${ctx}/weixin/city/partner/create" target="dialog" class="btn btn-primary btn-sm" title="添加合伙人"><span class="glyphicon glyphicon-plus"></span> 添加合伙人</a>
		</c:if>
		<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index" target="dialog" class="btn btn-primary btn-sm" title="角色调整" ><span class="glyphicon glyphicon-transfer"> </span> 角色调整</a>
		<%-- <a qx="user:import" href="${ctx}/weixin/user/batch/upload/index" target="dialog" class="btn btn-primary btn-sm" title="导入用户" ><span class="glyphicon glyphicon-plus"> </span> 导入用户</a> --%>
		<c:forEach items="${menus}" var="menu">
			<c:if test="${menu.id!=55 }">
				<a href="javascript:;" url="${menu.url}" onclick="loadContent(this,'${ctx}/${menu.url}','');"  class="btn btn-primary btn-sm" title="${menu.name }" ><span class="fa fa-${menu.icon }"> </span> ${menu.name }</a>
			</c:if>
		</c:forEach>
	</div> 
	<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
		<div id="hotelmenutools" class="form-group" style="display: none;">
			<a qx="user:add" href="${ctx}/base/user/create?crtusrty=SITE" target="dialog" class="btn btn-primary btn-sm" title="添加职员" width="800"><span class="glyphicon glyphicon-plus"></span> 添加职员</a>
			<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?crtusrty=SITE" target="dialog" class="btn btn-primary btn-sm" title="角色调整" ><span class="glyphicon glyphicon-transfer"> </span> 角色调整</a>
			<%-- <a qx="user:import" href="${ctx}/weixin/user/batch/upload/index?crtusrty=SITE" target="dialog" class="btn btn-primary btn-sm" title="导入用户" ><span class="glyphicon glyphicon-plus"> </span> 导入用户</a> --%>
			<a href="javascript:;" url="/weixin/user/invitation/index" onclick="loadContent(this,'${ctx}/weixin/user/invitation/index?crtusrty=SITE','');" class="btn btn-primary btn-sm" title="人员邀请"><span class="fa fa-users"> </span> 人员邀请</a>
		</div> 
	</c:if>
	<form class="form-inline" id="user_searchForm">
	    <div id="huifilterdv" class="form-group"  style="padding: 5px 0;">
	    	<label for="city">所属城市</label>
	   		<select id="harea" class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" name="search_EQ_u.city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			
			<label for="userType">所属职务</label>
			<select class="form-control"  id="groupId" name="search_EQ_u.group_id">
				<tags:dict sql="select id , name ,'' from hui_group where pid=11 or pid=14 order by group_id"  addBefore=",全部" showPleaseSelect="false" />
			</select>
			<!-- <select class="form-control"  id="huiposition" name="position">
		    	<option value="">全部</option>
		    	<option value="CLIENT">普通用户</option>
		    	<option value="PARTNER">城市合伙人</option>
		    	<option value="PARTNERSALE">合伙人销售</option>
		    	<option value="HUISALE">会掌柜销售</option>
		    	<option value="HUIQUIT">会掌柜离职人员</option>
		    	<option value="HUIOPERATE">会掌柜运营</option>
		    	<option value="HUIDIRECTOR">会掌柜场地总监</option>
		    	<option value="HUIFINANACE">会掌柜财务</option>
		    	<option value="HUIADMIN">会掌柜管理员</option>
		    	<option value="ADMINISTRATOR">平台超级管理员</option>
			</select> -->
		</div>
		<div  id="sitefilterdv" class="form-group"  style="padding: 5px 0;display: none;">
	    	<label for="city">所属城市</label>
	   		<select id="sarea" class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" name="search_EQ_u.city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_u.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
				<%-- <label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_u.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel WHERE company_id = ${aUs.getCurrentUserCompanyId() }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select>  --%>
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_u.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId() }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'HOTEL' }">
				<label for="userType">所属职务</label>
				<select class="form-control"  id="groupId" name="search_EQ_u.group_id">
					<tags:dict sql="select id , name ,'' from hui_group where pid=12 and group_id like 'hotel%' order by group_id"  addBefore=",全部" showPleaseSelect="false" />
				</select>
				<!-- <select class="form-control"  id="siteposition" name="position">
			    	<option value="">全部</option>
			    	<option value="CLIENT">普通用户</option>
			    	<option value="SITESALE">场地销售</option>
			    	<option value="SITEFINANACE">场地财务</option>
			    	<option value="SITEQUIT">场地离职人员</option>
			    	<option value="SITESALEMANAGER">场地销售主管</option>
			    	<option value="SITEHR">场地HR</option>
			    	<option value="SITEADMIN">场地系统管理员</option>
				</select> -->
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
				<label for="userType">所属职务</label>
				<select class="form-control"  id="groupId" name="search_EQ_u.group_id">
					<tags:dict sql="select id , name ,'' from hui_group where pid=12 and group_id like 'group%' order by group_id"  addBefore=",全部" showPleaseSelect="false" />
				</select>
				<!-- <select class="form-control"  id="siteposition" name="position">
			    	<option value="">全部</option>
			    	<option value="CLIENT">普通用户</option>
			    	<option value="SITEGROUPFINANACE">集团财务</option>
			    	 <option value="SITEGROUPSALE">集团销售</option> 
			    	<option value="SITEGROUPHR">集团HR</option>
			    	<option value="SITEGROUPADMIN">集团系统管理员</option>
			    	<option value="SITESALE">场地销售</option>
			    	<option value="SITEFINANACE">场地财务</option>
			    	<option value="SITEQUIT">场地离职人员</option>
			    	<option value="SITESALEMANAGER">场地销售主管</option>
			    	<option value="SITEHR">场地HR</option>
			    	<option value="SITEADMIN">场地系统管理员</option>
				</select> -->
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="userType">所属职务</label>
				 <select class="form-control"  id="groupId" name="search_EQ_u.group_id">
					<tags:dict sql="select id , name ,'' from hui_group where pid=12 order by group_id"  addBefore=",全部" showPleaseSelect="false" />
				</select>
				<!-- <select class="form-control"  id="siteposition" name="position">
			    	<option value="">全部</option>
			    	<option value="CLIENT">普通用户</option>
			    	<option value="SITESALE">场地销售</option>
			    	<option value="SITEFINANACE">场地财务</option>
			    	<option value="SITEQUIT">场地离职人员</option>
			    	<option value="SITESALEMANAGER">场地销售主管</option>
			    	<option value="SITEHR">场地HR</option>
			    	<option value="SITEADMIN">场地系统管理员</option>
			    	<option value="SITEGROUPFINANACE">集团财务</option>
			    	<option value="SITEGROUPSALE">集团销售</option>
			    	<option value="SITEGROUPHR">集团HR</option>
			    	<option value="SITEGROUPADMIN">集团系统管理员</option>
				</select> -->
			</c:if>
			
			<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
				<label for="userType">所属职务</label>
				 <select class="form-control"  id="groupId" name="search_EQ_u.group_id">
					<tags:dict sql="select id , name ,'' from hui_group where pid=14 order by group_id"  addBefore=",全部" showPleaseSelect="false" />
				</select>
			</c:if>
			</div>
	    	<div class="form-group" style="padding: 5px 0;">
		    <label for="nickname">职员账号</label>
		    <input type="text" class="form-control" id="nickname" name="search_LIKE_u.username" placeholder="请输入用户账号">
		    <label for="nickname">职员姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_u.rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_u.mobile" placeholder="请输入手机号码">
		   
		    <!-- <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc"> -->
	    	<input type="hidden" id="usertype" name="search_EQ_u.user_type" value="HUI">
		    <button type="button" class="btn btn-primary" onclick="user_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="user_table" data-toggle="table" data-height="660" data-query-params="user_queryParams" data-row-style="userRowStyle"
		data-pagination="true" data-url="${ctx}/base/user/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="username">帐号</th>
				<th data-field="rname">姓名</th>
				<!-- <th data-field="groupName">角色</th> -->
				<th data-field="groupName">职务</th>
				<th data-field="mobile">联系电话</th>
				<th data-field="email">电子邮箱</th>
				<th data-field="comprehensive" data-formatter="fm_user_comprehensive">综合评价</th>
				<th data-options="state" data-formatter="fm_user_state">状态</th>
				<th data-formatter="operate">操作</th> 
	        </tr>
	    </thead>
	</table>
	<script>
		var user_table = null;
		$(function(){
			common.pms.init();
			$(".selectpicker").selectpicker();
			
			set_user_type();
		});
		function operate(value,row, index){
			var state =  '';
			var user_type = $("#user_type").val();
			var _type = '${aUs.getCurrentUserType()}';
			if(user_type=='1'){
				state+='&nbsp;&nbsp;<a qx="user:update" href="${ctx}/base/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary btn-sm" id="mdlg" title="重置密码"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>';
				state+='&nbsp;&nbsp;<a qx="user:update" href="javascript:;" onclick="loadContent(this,\'${ctx}/base/user/detail/'+row.id+'\',\'\');" href="" data-permission="user:update"  class="btn btn-primary btn-sm"  title="详细信息"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
				if(row.userType==='HUI'){
					state+='&nbsp;&nbsp;<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?fromuserId='+row.id+'&gid='+row.groupId+'" target="dialog" class="btn btn-primary btn-sm" title="权限转移" ><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>';
				}
				if(row.groupId===3){
					state+='&nbsp;&nbsp;<a qx="user:allothotel" href="${ctx}/base/user/author/hotel/'+row.id+'" target="dialog" class="btn btn-primary btn-sm" title="分配场地"  width="1000" ><span class="glyphicon glyphicon-transfer"> </span> 分配场地</a>';
				}
			}else{
				if(_type==='HOTEL'){
					state+='&nbsp;&nbsp;<a qx="user:update" href="${ctx}/base/user/pwdForm/'+row.id+'" data-permission="user:updatepwd" target="dialog" class="btn btn-primary btn-sm" id="mdlg" title="重置密码"><span class="glyphicon glyphicon-cog"></span> 重置密码</a>';
				}
				state+='&nbsp;&nbsp;<a qx="user:update" href="javascript:;" onclick="loadContent(this,\'${ctx}/base/user/detail/'+row.id+'\',\'\');" href="" data-permission="user:update"  class="btn btn-primary btn-sm"  title="详细信息"><span class="glyphicon glyphicon-eye-open"> </span> 详情</a>';
				if(_type==='HOTEL'&&row.userType==='HOTEL'){
					state+='&nbsp;&nbsp;<a qx="user:transfer" href="${ctx}/base/user/author/transfer/index?fromuserId='+row.id+'&gid='+row.groupId+'" target="dialog" class="btn btn-primary btn-sm" title="权限转移" ><span class="glyphicon glyphicon-transfer"> </span> 权限转移</a>';
				}
			}
			return state;		
		}
		function fm_user_comprehensive(value,row, index){
			var cps = '<div class="icon-start icon-start-size-'+value+'" style="display:inline-block;" > <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div>';
			return cps;
		}
		function fm_user_state(value,row, index){
			if(row.state === "1"){
				return "<span class='label label-success'>在职</span>";
			}else{
				return "<span class='label label-default'>已离职</span>";
			}
		}
		
		function user_queryParams(params){
			return $.extend({},params,util.serializeObject($('#user_searchForm')));
		}
		function user_search(){
			$("#user_table").bootstrapTable("refresh");
		}
		function user_type_sel(self,type){
			var $this = $(self);
			$("#user_type").val(type);
			
			if(type=='1'){
				$("#usertype").val("HUI");
				$this.removeClass("btn-outline");
				$this.next().addClass("btn-outline");
				$("#huifilterdv").show();
				<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				$("#huimenutools").show();
				$("#hotelmenutools").hide();
				</c:if>
				//$("#hotelId").selectpicker("re")
				$("#sitefilterdv").hide();
			}else{
				$("#usertype").val("HOTEL");
				$this.removeClass("btn-outline");
				$this.prev().addClass("btn-outline");
				$("#sitefilterdv").show();
				$("#huifilterdv").hide();
				<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				$("#huimenutools").hide();
				$("#hotelmenutools").show();
				</c:if>
			}
			$('#user_searchForm')[0].reset();	
			$("#hotelid").selectpicker('refresh');
			$("#harea").selectpicker('refresh');
			$("#sarea").selectpicker('refresh');
			
			user_search();
		}
		
		function set_user_type(){
			var type = $("#user_type").val();
			
			if(type=='1'){
				$("#usertype").val("HUI");
				$("#user_type_1").removeClass("btn-outline");
				$("#user_type_2").addClass("btn-outline");
				$("#huifilterdv").show();
				
				//$("#hotelId").selectpicker("re")
				$("#sitefilterdv").hide();
				
				<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				$("#huimenutools").show();
				$("#hotelmenutools").hide();
				</c:if>
			}else{
				$("#usertype").val("HOTEL");
				$("#user_type_2").removeClass("btn-outline");
				$("#user_type_1").addClass("btn-outline");
				$("#sitefilterdv").show();
				$("#huifilterdv").hide();
				
				<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				$("#huimenutools").hide();
				$("#hotelmenutools").show();
				</c:if>
			}
			$('#user_searchForm')[0].reset();	
			$("#hotelid").selectpicker('refresh');
			$("#harea").selectpicker('refresh');
			$("#sarea").selectpicker('refresh');
			if(!user_table){
				user_table = $("#user_table").bootstrapTable({onLoadSuccess: function(){common.pms.init(); }});
			}else{
				user_search();
			}
		}
		</script>
</div>
