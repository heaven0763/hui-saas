$(function(){
	
	$(document).delegate('.modal-close','hidden.bs.modal',function(){
		$(this).removeData("bs.modal");
	});
	
	$(document).delegate('[target="tab"]','click',function(event){
		event.preventDefault();
		var $this = $(this);
		BSJ.openTab({
			url : $this.attr('href'),
			title : $this.attr('title') || $this.text()
		});
	});
	
	$(document).delegate('[target="dialog"]','click',function(event){
		event.preventDefault();
		var $this = $(this);
		BSJ.openDialog({
			url : $this.attr('href'),
			title : $this.attr('title') || $this.text() ,
			dialogid : $this.attr('id') ,
			size : $this.attr('size')||'',
			width : $this.attr('width')
		});
	});

	$(document).delegate('#project_manage_accordion .pro-tab','click',function(event){
		event.preventDefault();
		var $this = $(this);
		BSJ.openProjectTab({
			url : $this.attr('href'),
			title : $this.attr('title') || $this.text(),
			_this : $this
		});
	});


	$(document).delegate('select[textTarget]','change',function(){
		var $this =$(this);
		var txt = $this.val()? $this.find('option:selected').text():'';
		$('#'+$this.attr('textTarget')).val(txt);
	});

	$(document).delegate('select[refurl]','change',function(){
		var $this =$(this);
		var $target = $($this.attr('ref'));
		var $nxttarget = $($this.attr('nxtref'));
		if($target.attr('plsel') != 0){
			$target.html('<option value="">请选择...</option>');
		}
		
		if(!$this.val()){
			return;
		}
		var url = $this.attr('refurl').replace('{value}',$this.val());
		var refdata = $this.attr('refdata').replace('{value}',$this.val());
		var data = '{'+refdata+'}';
		
		$.ajax({
			url : url,
			type :'post',
			data : data,
			success : function(res){
				if(res.statusCode && res.statusCode == 300){
					return;
				}
				var html = [];
				if($target.attr('plsel') != 0){
					html.push('<option value="">请选择...</option>');
				}
				for(var i in res){
					var row = res[i];
					html.push('<option value="'+row[$this.attr('refval')] +'" >' + row[$this.attr('reftext')] +"</option>"  );
				}
				$target.html(html.join(''));
				if($nxttarget){
					$nxttarget.html('');
				}
			}
		});
		
	});
});


