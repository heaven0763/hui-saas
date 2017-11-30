var common = common || {}; 

common.pms = {};
common.pms.permissions = '';

common.pms.hasPermission = function(permission){
	if(common.pms.permissions == ''){
		/*var currUser = common.getStorJson('user');
		common.pms.permissions = currUser.permissions;*/
		common.pms.permissions = common.getstorage("permissions");
	}
	return common.pms.permissions.indexOf(permission) != -1;
};

common.pms.disableBtn = function($dom){
	$dom.addClass('disabled');
	$dom.attr('disabled','disabled');
	$dom.attr('href','javascript:;');
	$dom.removeAttr('target');
	$dom.removeAttr('id');
	$dom.removeAttr('onclick');
	$dom.removeAttr('rdurl');
	$dom.removeAttr('item-rdurl');
	$dom.click(function(event){
		common.alert($dom.attr('distitle') || '您没有权限');
		event.stopPropagation();
	});
};

//target or html;distitle
common.pms.disableDom = function(op){
	var $target = op.target || $('<div>'+op.html +'</div>');
	$target.find('*').each(function(){
		var $this = $(this);
		$this.attr('distitle',op.distitle);
		common.pms.disableBtn($this);
	});
	$target.unwrap();
	return op.target? $target : $target.html()
};
common.pms.isDisabled = function($dom){
	return $dom.attr('disabled') =='disabled' || $dom.hasClass('disabled');
};

common.pms.parse = function(op){
	var $target = op.target || $('<div>'+op.html +'</div>');
	$target.find('[qx]').each(function(){
		var $this = $(this);
		var permiss = $this.attr('qx');
		$this.removeAttr('qx');
		if(!common.pms.hasPermission(permiss)){
			common.pms.disableBtn($this);
		}
		
	});
	if(!op.target){
		$target.unwrap();
	}
	return op.target? $target : $target.html()
};

common.pms.parseHtml = function(html){
	return common.pms.parse({html : html});
};

common.pms.parseTarget = function($target){
	return common.pms.parse({target : $target});
};

common.pms.init = function($target){
	if($target){
		$target.find('[qx]').each(function(){
			var $this = $(this);
			var permission = $this.attr('qx');
			var qxvt = $this.attr('qxvt');
			if(!common.pms.hasPermission(permission)){
				if(qxvt){
					$this.hide();
				}else{
					common.pms.disableBtn($this);
				}
			}
		});
	}else{
		$('[qx]').each(function(){
			var $this = $(this);
			var permission = $this.attr('qx');
			var qxvt = $this.attr('qxvt');
			if(!common.pms.hasPermission(permission)){
				if(qxvt){
					$this.hide();
				}else{
					common.pms.disableBtn($this);
				}
			}
		});
	}
	
}