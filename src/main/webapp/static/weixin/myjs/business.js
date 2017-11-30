var business = business || {};

business.projectMakePv = function(){
	//var itemId = common.getstorage('item-id');
	var project = common.getStorJson('project');
	var $imgPreview = $('#imgPreview');
	$imgPreview.attr('src',common.baseUrl +'/' +project[project_stage_name] + '?t='+Math.random());
	
	$imgPreview.click(function(){
		common.preViewImg({
			$img : $imgPreview
		});
	});
	
};

business.getProjectDetail = function(cb){
	var projectId = common.getstorage('item-id');
	$.ajax({
		url : common.baseUrl + '/app/project/detail/' + projectId,
		dataType : 'json',
		success : function(res){
			if(res.statusCode != 200){
				common.alert('获取项目详情失败');
				return;
			}
			var project = res.object;
			common.setStorJson('project',project);
			if(cb){
				cb(project);
			}
		}
	});
	
}

