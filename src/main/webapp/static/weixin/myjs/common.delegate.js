$(function(){
	$(document).find('[rdurl]').css("cursor","pointer");
	$(document).delegate('[rdurl]','click',function(event){
		event.preventDefault();
		var $this = $(this);
		common.rdUrl($this.attr('rdurl'));
	});
});

