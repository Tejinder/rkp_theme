function readCookie(name) {	
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
	var c = ca[i];
	while (c.charAt(0) == ' ') c = c.substring(1, c.length);
	if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
	}
	return null;													
}

function eraseCookie(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}


function cookieTimer(cookie_name, token)
{
$j.loader({
		className:"blue-with-image",
		content:'Fetching Report'
	});
var timerId = 0;
		timerId = window.setInterval(function(){
			if(readCookie(cookie_name)!=null && readCookie(cookie_name)==token)
			{					
				clearInterval(timerId);
				$j("#dialog-box").remove();
				$j("#jquery-loader").remove();
				$j("#jquery-loader-background").remove();
				eraseCookie(cookie_name);
			}
		}, 100);
}

function showLoader(title)
{
	$j.loader({
			className:"blue-with-image",
			content: title
		});
}

function hideLoader()
{
	$j("#jquery-loader").remove();
	$j("#jquery-loader-background").remove();
}