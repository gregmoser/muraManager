<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	/admin/controllers/main.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
<cfcomponent extends="mura.cfobject" output="false">

	<cfscript>
		variables.fw = '';

		function init ( fw ) {
			variables.fw = arguments.fw;
		};

		function before ( rc ) {
			var $ = StructNew();
			if ( StructKeyExists(rc, '$') ) {
				$ = rc.$;
			};

			if ( rc.isFrontEndRequest ) {
				fw.redirect(action='public:main.default');
			};
			
		};
	</cfscript>

	<!--- ************ pages *************** --->
	<cffunction name="default" output="false" returntype="any">
		<cfargument name="rc" />
		<!---<cfparam name="rc.save" default="false" />
		<cfparam name="rc.delete" default="false" />--->
		<cfscript>
			// rc.varName = '';
		</cfscript>
	</cffunction>

</cfcomponent>