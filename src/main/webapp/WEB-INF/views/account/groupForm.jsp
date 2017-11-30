<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/public/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/public/easyui/themes/icon.css">
<script type="text/javascript" src="${ctx}/public/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">

$().ready(function() {
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#groupSubForm").validate({
        rules: {
        	name: "required",
            groupId: "required"
        },
        messages: {
        	name: e + "请输入角色名称",
        	groupId: e + "请输入角色代码"            
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	
});
$(function(){
	
	setTimeout(ready,0);
	
	function ready(){
		initMenuTree();
		initPermissionTree();
	}
	
});

function initMenuTree(){
	$.ajax({
		type:'get',
		url : '${ctx}/account/group/menus/${empty group.id?0:group.id}',
		success : function(response){
			var $menutree = $('#tt');
			$menutree.tree( {
				idField:"id",
				checkbox:true,
				data: response,
				onClick: function(node){  
			 		 $(this).tree('toggle', node.target);  
	            },
				onCheck:function(node, checked){
					treeCheck('menuList',$menutree);
				},
				onLoadSuccess:function(){
					treeCheck('menuList',$menutree,"tt");
				}
			});
		}
	});
}

function initPermissionTree(){
	
	$.ajax({
		type:'get',
		url : '${ctx}/account/group/menupmstree?groupId=${group.id}',
		success : function(response){
			var $permissionTree = $('#permission');
			$permissionTree.tree( {
				idField:"id",
				checkbox:true,
				data: response,
				onClick: function(node){  
			 		 $(this).tree('toggle', node.target);  
	            },
				onCheck:function(node, checked){
					treeCheck('permissionEntityList',$permissionTree,"permission");
				},
				onLoadSuccess : function(){
					treeCheck('permissionEntityList',$permissionTree,"permission");
				}
			});
		}
	});
}

function treeCheck(inputId,$tree,treeId){
	
	if(treeId && treeId==='permission'){
		var nodes =  $tree.tree('getChecked',['checked']);
		var s = '';  
	    var d = '';  
	    for(var i=0; i<nodes.length; i++){  
	        if (s != '') s += ',';  
	        if(nodes[i].id==null){
	        	continue;
	        }
	        s += nodes[i].id;  
	    } 
	    $('#'+inputId).val(s);
	}else{
		var nodes =  $tree.tree('getChecked',['checked','indeterminate']);
		var s = '';  
	    var d = '';  
	    for(var i=0; i<nodes.length; i++){  
	        if (s != '') s += ',';  
	        if(nodes[i].id==null){
	        	continue;
	        }
	        var pnode =  $tree.tree('getParent');
	        s += nodes[i].id;  
	    } 
	    $('#'+inputId).val(s);
	}
    
}

</script>
<form id="groupSubForm" method="post" action="${ctx}/account/group/save"  class="form-horizontal m-t" ><!--   -->
<div class="modal-body"> 
<div class="row">
	<div class="col-sm-5">
	<input type="hidden" name="id" id="id" value="${group.id}" />
  	<div class="form-group form-inline">
      <label for="pid" class="col-md-3 control-label">上级角色</label>
      <div class="col-md-9">
		<select class="form-control" aria-required="true" aria-invalid="false" class="valid" id="pid" name="pid" style="width:180px;">
			<tags:dict sql="select id , name  from hui_group where 1=1 " selectedValue="${group.pid}" addBefore="0,父角色" showPleaseSelect="false" />
		</select>
  	  </div>
  </div>
   <div class="form-group form-inline">
    <label for="groupId" class="col-sm-3 control-label">角色代码</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="groupId" name="groupId" placeholder="角色代码" value="${group.groupId}" aria-required="true" aria-invalid="false" class="valid"></div>
  </div>
   <div class="form-group form-inline">
    <label for="name" class="col-sm-3 control-label">角色名称</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="name" name="name" placeholder="角色名称" value="${group.name}" aria-required="true" aria-invalid="false" class="valid"></div>
  </div>
  
   <div class="form-group form-inline">
    <label for="memo" class="col-sm-3 control-label">备注</label>
    <div class="col-sm-9">
    <input type="text" class="form-control" id="memo" name="memo" placeholder="备注" value="${group.memo}"></div>
  </div>
	</div>
	<div class="col-sm-7">
	<div class="panel blank-panel">
        <div class="panel-heading">
            <div class="panel-options">
                <ul class="nav nav-tabs">
                    <li class="active"><a aria-expanded="true" href="#tab-1" data-toggle="tab">菜单权限</a> </li>
                    <li class=""><a aria-expanded="false" href="#tab-2" data-toggle="tab">操作权限</a> </li>
                </ul>
            </div>
        </div>

     	<div class="panel-body">

         <div class="tab-content">
             <div class="tab-pane active" id="tab-1" style="height: 360px;border: 0">
					<div class="easyui-panel"  style="padding:5px;width:420px;height: 360px;border: 0">
						<input id="menuList" type="hidden" name="menuList" value="${group.menuIds}">
						<ul id="tt"></ul>
					</div>
             </div>
             <div class="tab-pane" id="tab-2" style="height: 360px;border: 0">
					<input id="permissionEntityList" type="hidden" name="permissionEntityList" value="${group.permissionIds}">
					<div class="easyui-panel"  style="padding:5px;width:420px;height:360px;border: 0">
						<ul id="permission"></ul>
					</div>
             </div>
         </div>
     </div>
 </div>
	</div>
</div>
  
  
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
</div>
</form>
