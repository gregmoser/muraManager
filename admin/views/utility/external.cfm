<cfparam name="rc.site" default="" />
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us" lang="en-US">
<head>
	<link href="/admin/css/admin.css" rel="stylesheet" type="text/css" />
	<link href="/plugins/muraManager/assets/css/muraManager.css" rel="stylesheet" type="text/css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#externalSite').height($('#externalSite').height()-32); 
		});
	</script>
</head>
<body style="margin:0px; border:0px; background:none;">
<cfif left(rc.site,4) neq "http">
	<cfset rc.site = "http://#rc.site#" />
</cfif>
<cfoutput>
	<iframe name="externalSite" id="externalSite" style="border:none; width:100%; height:100%;" src="#rc.site#" target="_blank" ></iframe>
	<div class="externalBar">
		<ul id="navTask">
			<li><a href="#buildURL(action='admin:main.default')#">Back to Mura Manager</a></li>	
		</ul>
	</div>
</cfoutput>
</body>
</html>