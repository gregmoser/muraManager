<cfparam name="rc.site" defualt="" />
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us" lang="en-US">
<head>
	<script type="text/javascript" src="/default/includes/themes/nytro/js/jquery-1.3.1.min.js"></script>
	<script type="text/javascript" src="js/slatwall.js"></script>
	<link rel="stylesheet" type="text/css" href="css/slatwall_admin.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/slatwall_toolbar.css" media="all" />
	<script type="text/javascript">
		$(document).ready(function(){
			$('#externalSite').height($('body').height()-27); 
		});
	</script>
	<style type="text/css">
		body, html {height:100%;}
	</style>
</head>
<body>
<cfif left(rc.site,4) neq "http">
	<cfset rc.site = "http://#rc.site#" />
</cfif>
<cfoutput>
	<iframe name="externalSite" id="externalSite" style="border:none; width:100%;" src="#rc.site#" ></iframe>
	<div class="externalBar"></div>
</cfoutput>
</body>
</html>