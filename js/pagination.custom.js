
$j("#pagination").paginate({
	count : pages,
	start : currPage,
	display : 6,
	border : true,
	border_color : '#fff',
	text_color : '#fff',
	background_color : 'black',	
	border_hover_color : '#ccc',
	text_hover_color : '#000',
	background_hover_color : '#fff', 
	images : false,
	mouse : 'press',
	onChange : function(page){	
	   currPage = page;
	   processPaginationRequest(page, $j.trim($j(".search_box").val()))
	}
});

		

	try{
		var $myDiv = $j(".project_status_table");
		if ($myDiv.length){
			$j("#overlay").css({
			opacity : 0.7,
			top     : $myDiv.offset().top,
			width   : $myDiv.outerWidth(),
			height  : $myDiv.outerHeight()
			}); 
		}	

		$j("#img-load").css({
			top  : ($myDiv.height() / 2),
			left : ($myDiv.width() / 2)
		});		
}catch(err){}




$j('table tr th').click(function() {
	var $th = $j(this);
    if($th.hasClass("sortable")) {
        if($th.hasClass("headerSortDown"))
		{
			$th.removeClass("headerSortDown");
			$th.addClass("headerSortUp current");
			$j("#ascendingOrder").val("1");
		}
		else if($th.hasClass("headerSortUp"))
		{
			$th.removeClass("headerSortUp");
			$th.addClass("headerSortDown current");
			$j("#ascendingOrder").val("0");
		}
		else
		{
			$th.addClass("headerSortDown current");
			$j("#ascendingOrder").val("0");
		}
		
		$j("#sortField").val($j('span:first', this).attr("id"));
		
		$j("th").each(function(index) {
		if(!$j(this).hasClass("current"))
			{
				if($j(this).hasClass("headerSortUp"))
				{
					$j(this).removeClass("headerSortUp");
				}
				else if($j(this).hasClass("headerSortDown"))
				{
					$j(this).removeClass("headerSortDown");
				}
			}
		});
		
		$th.removeClass("current");		
		processPaginationRequest(1, $j.trim($j(".search_box").val()))
	  }	  
	});
	
	$j(document).ready(function () {		
		var sortField = $j("#sortField").val();
		var sortOrder = $j("#ascendingOrder").val();
		if(sortField!="" && sortField.length > 0)
		{
		if(sortOrder=="" || sortOrder=="0")
			$j("#"+sortField).parent().addClass("headerSortDown");
		else
			$j("#"+sortField).parent().addClass("headerSortUp");
		}
	});