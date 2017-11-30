var BSJ = BSJ || {};

BSJ.panelIndex = 0;

BSJ.currPanel = '';

BSJ.tabTitles = '';

BSJ.getPanelIndex = function(){  return BSJ.panelIndex++ };

BSJ.openTab = function(op){
	var _self = {};
	if(BSJ.tabTitles.indexOf('*#*'+op.title) != -1){
		$('.page-tabs-content a[title="'+op.title+'"]').click();
		return;
	}
	BSJ.tabTitles += '*#*'+op.title;
	_self.index  = BSJ.getPanelIndex();
	_self.header = $('<a href="javascript:;" class="active J_menuTab" data-id="bsj-'+_self.index+'" title="'+op.title+'">'+op.title+' <i class="fa fa-times-circle"></i></a>');
	_self.panel = $('<div class="J_iframe" width="100%" height="100%" data-id="bsj-'+_self.index+'" seamless></div>');
	$(".J_menuTab").removeClass("active");
	$.ajax({
		url : op.url,
		success : function(res){
			$(".J_mainContent").find("div.J_iframe").hide();
			
			_self.panel.html(res).appendTo($('#content-main'));
			_self.header.appendTo($(".J_menuTabs .page-tabs-content"));
		}
	});
	
	_self.header.find('.fa-times-circle').click(function(){
		BSJ.tabTitles = BSJ.tabTitles.replace('*#*'+op.title,'');
	});
	_self.close = function(){
		_self.header.find('.fa-times-circle').click();
	};
	BSJ.currPanel = _self;
	return _self;
};


BSJ.openDialog = function(op){
	var _self = {};
	_self.id = 'bsj-'+op.dialogid;
	_self.panel = $('<div class="modal fade modal-close" id="'+_self.id+'" tabindex="-1" role="dialog" aria-labelledby="modal" style="" >'
			+'<div class="modal-dialog '+op.size+'"'+(op.width?' style="width:'+op.width+'px;"':'')+'>'
			+'<div class="modal-content" >'
			+'<div class="modal-header">'
			+'<button type="button" class="close" data-dismiss="modal" aria-label="Close">'
			+'	<span>&times;</span>'
			+'</button>'
			+'<h4 class="modal-title" id="user_modal_title">'+op.title+'</h4>'
			+'</div>'
			+'</div>'
			+'</div>'
			+'</div>').appendTo('body');
	
	_self.panel.on('hidden.bs.modal', function (e) {
		  // do something...
		_self.panel.remove();
	});
	if(op.url){
		$.ajax({
			url : op.url,
			success : function(res){
				$('.modal-content',_self.panel).append(res);
				_self.panel.modal('show');
			}
		});
	}else{
		$('.modal-content',_self.panel).append(op.content);
		_self.panel.modal('show');
	}
	
	return _self;
};

BSJ.openProjectTab = function(op){
	var _self = {};
	_self.index  = BSJ.getPanelIndex();
	_self.panel = $('<div width="100%" height="100%" data-id="bsj-'+_self.index+'"></div>');
	var $project_manage_nav = $('#project_manage_nav');
	var $project_manage_content = $('#project_manage_content');
	$project_manage_nav.find('.active').removeClass('active');
	op._this.parent().addClass('active');
	$project_manage_content.empty();
	$.ajax({
		url : op.url,
		success : function(res){
			_self.panel.html(res).appendTo($project_manage_content);
		}
	});
	
	BSJ.currPanel = _self;
	return _self;
};


BSJ.namespace = function(){//类似extjs的namespace
	var a=arguments, o=null, i, j, d, rt;
	for (i=0; i<a.length; ++i) {
		d=a[i].split(".");
		rt = d[0];
		eval('if (typeof ' + rt + ' == "undefined"){' + rt + ' = {};} o = ' + rt + ';');
		for (j=1; j<d.length; ++j) {
		o[d[j]]=o[d[j]] || {};
		o=o[d[j]];
		}
	}
};


