<cfsilent>
<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	/public/layouts/default.cfm
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
	<cfscript>
		//request.layout = false;
	</cfscript>
</cfsilent>
<cfoutput>
	<div class="clearfix">
		<p><a href="#buildURL( 'public:main' )#">Public Main</a> | <a href="#buildURL( 'public:main.another' )#">Another Page</a></p>
	</div>
	<div class="clearfix">
		#body#
	</div>
</cfoutput>