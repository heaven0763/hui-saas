var common = common || {};

//可选参数 page,rows,success,startnow,tmp
//必选参数 url,jqobj,tmpid
common.customPage = function(op){
	var _self = {};
	var $window = $(window);
	_self.currPage = 0;
	_self.currPage = op.page || 1 ;
	_self.rows = op.rows|| 15  ;
	_self.isMaxPage = false;
	_self.form = op.form;
	_self.tmpid = op.tmpid;
	_self.isPageing = false;
	_self.jqobj = op.jqobj;
	_self.scrollJqObj =  $window;
	
	
	_self.refresh = function(){
		_self.jqobj.empty();
		_self.isMaxPage = false;
		_self.currPage = 0;
		_self.page();
	};
	
	_self.page = function(){
		if(_self.isPageing){
			return;
		}
		if(_self.isMaxPage){
			return;
		}
		_self.isPageing = true;
		//var data = {page : _self.currPage,rows : _self.rows};
		var data = $.extend({page : _self.currPage,rows : _self.rows},
				common.serializeObject(_self.form),op.data);
		$.ajax({
			url : op.url,
			data : data,
			type : 'post',
			dataType : 'json',
			success : function (res){
				res = res.object? res.object :res;
				if(_self.currPage * _self.rows >= res.total){
					//alert('没有更多记录');
					_self.isMaxPage =true;
					//return;
				}
				_self.currPage++;
				_self.isPageing = false;
				if(op.success){
					op.success(res);
					return;
				}
				var html = template(_self.tmpid, res);
				var $appendContent = $(html);
				_self.jqobj.append($appendContent);
				_self.jqobj.find('[item-rdurl]').unbind('click').bind('click',rdurl);
				
				if(op.callback){
					op.callback(res,$appendContent);
				}
			},
			error : function(){
				_self.isPageing = false;
			}
		});
	};
	
	function rdurl(){
		var $this = $(this);
    	common.rdUrl($this.attr('item-rdurl'));
	}
	
	
	_self.bindWdScroll = function(){
	
		_self.scrollJqObj.scroll(function(){
			var scrollTop = _self.scrollJqObj.scrollTop();
			var contentH = _self.scrollJqObj.height();
			var scrollHeight = _self.scrollJqObj[0].scrollHeight? _self.scrollJqObj[0].scrollHeight : _self.jqobj[0].scrollHeight ;
			if((scrollTop + contentH) / scrollHeight > 0.9){
				_self.page();
			}
		});
	};
	
	if(op.startnow){
		_self.page();
	}
	_self.bindWdScroll();
	
	_self.search = function (){
		op.jqobj.html('');
		_self.currPage = 1;
		_self.isMaxPage = false;
		_self.isPageing = false;
		_self.page();
	};
	
	if(_self.form){
		_self.form.submit(function(event){
			event.preventDefault();
		});
			
		_self.form.keyup(function(event){	
			if(event.keyCode == 13){ 
				_self.search();
			}
		});
	}
	return _self;
};

common.scrollAlready = function(){
	var scrollTop = $(window).scrollTop();
	var windowHeight = $(window).height();
	var documentHeight = $(document).height();
	return (scrollTop + windowHeight) / documentHeight;
};
template.helper('dateFormat', common.formatDate);
template.helper('currency', common.formatCurrency);
template.helper('currencyWy', common.formatCyWy);
template.helper('fmDouble', common.fmDouble);
