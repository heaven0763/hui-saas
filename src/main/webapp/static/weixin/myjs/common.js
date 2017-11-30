var common = common || {}; 

common.setForm = function($form,json){
	$form.find(':input').each(function(){
		var $this = $(this);
		var ppt_name =  $this.attr('name');
		$this.val(json[ppt_name]);
	});
	
}

common.rdUrl = function (url){
	if(!url || url =='#'){
		return ;
	}
	location.href = url ;
};

common.historyback = function(){
	history.back();
}

common.toast = function(inMsg){
	toastFn(inMsg);
};

common.alert = common.toast; 

common.confirm = function(msg,cb){
	confirmFn(msg,cb);
};

common.setstorage = function (objName,objValue){
    var sto = window.localStorage;
    if(sto) sto.setItem(objName,objValue);
};
common.getstorage = function(objName){
    var ret = '';
    var sto = window.localStorage;
    
    if(sto) ret=sto.getItem(objName);
    return ret? ret:'';
};

common.setstorJson = function (objName, json){
    if(json) common.setstorage(objName,JSON.stringify(json));
};
common.getstorJson = function (objName){
    var ret = {};
    var str = common.getstorage(objName);
    if(str) ret=JSON.parse(str);
    return ret;
};

common.clearstorage = function (objName){
    var sto = window.localStorage;
    if(sto){
        if(objName) sto.removeItem(objName);
        else storage.clear();
    }
};

common.isNotBlank = function (str){
    return !common.isBlank(str);  
};

common.isBlank = function(str){
  return str==null||str==''||str=='null';   
};

common.serializeObject = function($form) {
    var o = {};
    if(!$form){
    	return o;
    }
    $.each($form.serializeArray(), function(index) {
        if (this['value'] != undefined && this['value'].length > 0) {// 如果表单项的值非空，才进行序列化操作
            if (o[this['name']]) {
                o[this['name']] = o[this['name']] + "," + this['value'];
            } else {
                o[this['name']] = this['value'];
            }
        }
    });
    return o;
};

common.bindSelRefFn = function(baseUrl,$select){
	var $this = $select;
	var $target = $($this.attr('ref'));
	if($target.attr('plsel') != 0){
		$target.html('<option value="">请选择</option>');
	}
	if(!$this.val()){
		return;
	}
	var url = $this.attr('refurl').replace('{value}',$this.val());
	var refdata = $this.attr('refdata').replace('{value}',$this.val());
	var data = common.parseJson(refdata);
	
	$.ajax({
		url : baseUrl + url,
		type :'post',
		data : data,
		success : function(res){
			if(res.statusCode && res.statusCode == 300){
				return;
			}
			var html = [];
			if($target.attr('plsel') != 0){
				html.push('<option value="">请选择</option>');
			}
			var refval = $this.attr('refval');
			var reftext = $this.attr('reftext');
			var refdfval = $this.attr('refdfval');//默认值
			for(var i in res){
				var row = res[i];
				var temHtml = '<option value="'+row[refval] +'" '  ;
				if(refdfval && refdfval == row[refval] ){
					temHtml += 'selected="selected"';
				}
				temHtml += ' >' + row[reftext] +"</option>";
				html.push(temHtml);
			}
			
			$target.html(html.join(''));
		}
	});
	
}

common.getLocationCityName = function(jsonpCallback){
	if (!navigator.geolocation)  { 
        return;
    }
	navigator.geolocation.getCurrentPosition(function(position){
    	//commmon.getLocationCityName(position.coords.longitude,position.coords.latitude,callback);
    	var lng = position.coords.longitude;
    	var lat = position.coords.latitude;
    	
    	var url = 'http://api.map.baidu.com/geocoder/v2/?ak=nGbF82AsGP0Y5fZyR0qBhHzQFiRhbeIz&location='+lat+','+lng+'&output=json&pois=0';
    	//var url = 'http://api.map.baidu.com/geocoder/v2/?callback=getCityNameCallBack&location='+lat+','+lng+'&output=json&pois=1&ak=nGbF82AsGP0Y5fZyR0qBhHzQFiRhbeIz';
    	$.ajax({
    		type : 'get',
    		url  : url,
    		dataType: 'jsonp',
            jsonp: 'callback',
            jsonpCallback: jsonpCallback,	//回调函数
    		success :function(res){
    			//alert(res.status);
    		},
    		error: function (jqXHR, textStatus, errorThrown) {
    			//alert(textStatus+'  error '+errorThrown+"  "+JSON.stringify(jqXHR));
                /*弹出jqXHR对象的信息*/
            }	
    	});
    }); 
}
String.prototype.trim = function() {
	  return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
