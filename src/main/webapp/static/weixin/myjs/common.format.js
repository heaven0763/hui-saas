var common = common || {}; 

common.parseCurrency = function(str){
    if (!str) return 0;
    //str = str.replace(',', '');
    str = str.replace(new RegExp(',',"gm"),'');
    return $.isNumeric(str) ? parseFloat(str) : 0;
};

//金额的格式化s为要格式化的参数（浮点型），n为小数点后保留的位数 ，最后一位会四舍五入
common.formatCurrency = function(s,n){
	var isNegative = s < 0;
    s = s || "0";
    s = s.toString().replace(/\$|\,/g,'');
    if(isNaN(s)) {s = "0";}
    s = Math.abs(s); 
    n = n>=0 && n<=20 ? n : 2; 
    s = parseFloat((s+"").replace(/[^\d\.-]/g,"")).toFixed(n)+""; 
    var l = s.split(".")[0].split("").reverse(), 
    r = s.split(".")[1]; 
    t = ""; 
    for(i = 0;i<l.length;i++){ 
        t+=l[i]+((i+1)%3==0 && (i+1) != l.length ? "," : ""); 
    } 
    var result = t.split("").reverse().join("");
    result = n == 0? result : result +"."+r;
    return isNegative? '-'+result : result; 
};

//返回(万元)，最后一位会四舍五入
common.formatCyWy = function(money){
	money = money / 10000;
	return common.formatCurrency(money);
};

//格式化银行号码
common.fmBankNo = function(value){
	if(!value) return value;
	return value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,'$1 ');
}

//
common.fmDouble = function(s){
	 s = s || "0.00";
	 s = s + ''; 
	 var l = s.split(".")[0];
	 var r = s.split(".")[1] || '0';
	 r = r.length <2? r+'0' : r.substring(0,2);
	 return l + '.' +r;
}

common.formatDate = function(date,format){
	//console.log(typeof date);
	if(!date){
		return date;
	}
	format = typeof format === 'string'?format : 'yyyy-MM-dd';
	if((typeof date) == "number"){
		 date = new Date(date);
	}else if((typeof date) == "string"){
		 date = new Date(date.replace(/-/g, "/"));
	}else{
		date = new Date(date);
	}
    var map = {
        "M": date.getMonth() + 1, //月份 
        "d": date.getDate(), //日 
        "h": date.getHours(), //小时 
        "m": date.getMinutes(), //分 
        "s": date.getSeconds(), //秒 
        "q": Math.floor((date.getMonth() + 3) / 3), //季度 
        "S": date.getMilliseconds() //毫秒 
    };
    format = format.replace(/([yMdhmsqS])+/g, function(all, t){
        var v = map[t];
        if(v !== undefined){
            if(all.length > 1){
                v = '0' + v;
                v = v.substr(v.length-2);
            }
            return v;
        }
        else if(t === 'y'){
            return (date.getFullYear() + '').substr(4 - all.length);
        }
        return all;
    });
    return format;
};

common.serializeObject = function(form) {
    var o = {};
    $.each(form.serializeArray(), function(index) {
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