/**
 * 扩展String方法
 */
$.extend(String.prototype, {
	/**
	 * 是否是正整数，不包括0
	 * @returns true if is positiveInteger else false
	 */
	isPositiveInteger:function(){
		return (new RegExp(/^[1-9]\d*$/).test(this));
	},
	/**
	 * 是否是整数，包括0
	 * @returns
	 */
	isInteger:function(){
		return (new RegExp(/^\d+$/).test(this));
	},
	/**
	 * 是否是数字，但负数不是，因为有-号
	 * @param value
	 * @param element
	 * @returns
	 */
	isNumber: function(value, element) {
		return (new RegExp(/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/).test(this));
	},
	/**
	 * 去除两边的空格，中间的空格不会去掉
	 * @returns
	 */
	trim:function(){
		return this.replace(/(^\s*)|(\s*$)|\r|\n/g, "");
	},
	//你懂的
	startsWith:function (pattern){
		return this.indexOf(pattern) === 0;
	},
	//你懂的
	endsWith:function(pattern) {
		var d = this.length - pattern.length;
		return d >= 0 && this.lastIndexOf(pattern) === d;
	},
	/**
	 * 不明
	 * @param index
	 * @returns
	 */
	replaceSuffix:function(index){
		return this.replace(/\[[0-9]+\]/,'['+index+']').replace('#index#',index);
	},
	/**
	 * 将html特殊字符转为html命名实体
	 * @returns
	 */
	trans:function(){
		return this.replace(/&lt;/g, '<').replace(/&gt;/g,'>').replace(/&quot;/g, '"');
	},
	/**
	 * 将html命名实体转为html特殊字符
	 * @returns
	 */
	encodeTXT: function(){
		return (this).replaceAll('&', '&amp;').replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;");
	},
	//你懂的
	replaceAll:function(os, ns){
		return this.replace(new RegExp(os,"gm"),ns);
	},
	//不明
	replaceTm:function($data){
		if (!$data) return this;
		return this.replace(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})","g"), function($1){
			return $data[$1.replace(/[{}]+/g, "")];
		});
	},
	replaceTmById:function(_box){
		var $parent = _box || $(document);
		return this.replace(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})","g"), function($1){
			var $input = $parent.find("#"+$1.replace(/[{}]+/g, ""));
			return $input.val() ? $input.val() : $1;
		});
	},
	isFinishedTm:function(){
		return !(new RegExp("{[A-Za-z_]+[A-Za-z0-9_]*}").test(this)); 
	},
	skipChar:function(ch) {
		if (!this || this.length===0) {return '';}
		if (this.charAt(0)===ch) {return this.substring(1).skipChar(ch);}
		return this;
	},
	isValidPwd:function() {
		return (new RegExp(/^([_]|[a-zA-Z0-9]){6,32}$/).test(this)); 
	},
	isValidMail:function(){
		return(new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(this.trim()));
	},
	isSpaces:function() {
		for(var i=0; i<this.length; i+=1) {
			var ch = this.charAt(i);
			if (ch!=' '&& ch!="\n" && ch!="\t" && ch!="\r") {return false;}
		}
		return true;
	},
	isPhone:function() {
		return (new RegExp(/(^([0-9]{3,4}[-])?\d{3,8}(-\d{1,6})?$)|(^\([0-9]{3,4}\)\d{3,8}(\(\d{1,6}\))?$)|(^\d{3,8}$)/).test(this));
	},
	isUrl:function(){
		return (new RegExp(/^[a-zA-z]+:\/\/([a-zA-Z0-9\-\.]+)([-\w .\/?%&=:]*)$/).test(this));
	},
	isExternalUrl:function(){
		return this.isUrl() && this.indexOf("://"+document.domain) == -1;
	}
});