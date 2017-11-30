function getExportExcelUrl(url,datagrid){
	var p = datagrid.datagrid('options');
	return url + "?sort="+p.sortName+'&order='+p.sortOrder;
}

/**
 *	Purpose: 从身份证号码取生日
 *	Inputs: String 
 *	Returns: String 
 */
function getBirthday(str) { 
	if(str.length==15){
		var year = "19" + str.substring(6,8);
		var month = str.substring(8,10);
		var day = str.substring(10,12);
		var retStr = year + "-" + month + "-" + day;
		return retStr;
	}else if(str.length==18)
	{
		var year = str.substring(6,10);
		var month = str.substring(10,12);
		var day = str.substring(12,14);
		var retStr = year + "-" + month + "-" + day;
		return retStr;
	}		
}
/**
 * 从身份证号码中获取性别
 * @param str
 * @returns
 */
function getSex(str){
	//根据身份证的位数（15位或者18位）为截取对应的性别判别位
	var xingbie = str.length == 15? str.substr(14,1) : str.substr(16,1);
	return xingbie % 2 == 0? '女' : '男';
}

function getDiffTime(daytime){
    var startdaytime = new Date(daytime);
    var enddaytime = new Date();
    var date3 = enddaytime.getTime() - startdaytime.getTime()  //时间差的毫秒数
    //计算出相差天数
    var days = Math.floor(date3/(24*3600*1000));
    if(days > 0){
        return daytime;
    }
    //计算出小时数
    var leave1=date3%(24*3600*1000);    //计算天数后剩余的毫秒数
    var hours=Math.floor(leave1/(3600*1000));
    if(hours > 0){
        return hours + '小时前';
    }
    //计算相差分钟数
    var leave2=leave1%(3600*1000)        //计算小时数后剩余的毫秒数
    var minutes=Math.floor(leave2/(60*1000))
    if(minutes > 0){
        return minutes + '分钟前';
    }
    //计算相差秒数
    var leave3=leave2%(60*1000)      //计算分钟数后剩余的毫秒数
    var seconds=Math.round(leave3/1000)
    if(seconds > 0){
        return seconds + '秒前';
    }
    return hours+"小时 "+minutes+" 分钟"+seconds+ ' 秒前';
}

function ajaxDownload(url){
	var ajaxDownFrame = $('#ajaxDownFrame');
	var ajaxDownForm = $('#ajaxDownForm');
	if(ajaxDownFrame.length < 1){
		ajaxDownFrame = $('<iframe id="ajaxDownFrame" name="ajaxDownFrame" style="display:none;" />');
		$('body').append(ajaxDownFrame);
	}
	if(ajaxDownForm.length < 1){
		ajaxDownForm = $('<form id="ajaxDownForm" target="ajaxDownFrame" method="post" style="display:none;"/>');
		$('body').append(ajaxDownForm);
	}
	ajaxDownFrame.bind("load", function(event){
		ajaxDownFrame.unbind("load");
		var iframeBody = document.getElementById('ajaxDownFrame').contentWindow.document.body;
		if(iframeBody){
			var text = iframeBody.innerText;
			if(text !=''){
				parent.$.messager.alert('错误', JSON.parse(text).message, 'info');
				iframeBody.innerText = '';
			}
		}
	});
	ajaxDownFrame.attr('name','ajaxDownFrame');
	ajaxDownForm.attr('action',url);
	ajaxDownForm.submit();
	
}
function bankActForm(bankAct){
	
	if(bankAct!="")
    {
        for(var i=0;i<bankAct.length;i++)
        {
            var arr=bankAct.split('');
            if((i+1)%5==0)
            {
                arr.splice(i,0,' ');
            }
            bankAct =arr.join('');
        }
        return arr.join('');
    }

}
/** 
 * formatMoney(s,type) 
 * 功能：金额按千位逗号分割 
 * 参数：s，需要格式化的金额数值. 
 * 参数：type,判断格式化后的金额是否需要小数位. 
 * 返回：返回格式化后的数值字符串. 
 */  
function formatMoney(value, type) {  
	type=1;
    if (/[^0-9\.]/.test(value))  
        return "0.00";  
    if (value == null || value == "")  
        return "0.00";  
    value = value.toString().replace(/^(\d*)$/, "$1.");  
    value = (value + "00").replace(/(\d*\.\d\d)\d*/, "$1");  
    value = value.replace(".", ",");  
    var re = /(\d)(\d{3},)/;  
    while (re.test(value))  
        value = value.replace(re, "$1,$2");  
    value = value.replace(/,(\d\d)$/, ".$1");  
    if (type == 0) {// 不带小数位(默认是有小数位)  
        var a = value.split(".");  
        if (a[1] == "00") {  
            value = a[0];  
        }  
    }  
    return value;  
}
function formatCurrency(num) {  
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
        num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10)  
    cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
}
function formcontent(value,row,len){
	if(!len){
		len=20;
	}
	if(value.length>20){
		value = value.substring(0,20)+"...";
	}
	return value;
}
function isWeiXin(){
    var ua = window.navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return true;
    }else{
        return false;
    }
}
