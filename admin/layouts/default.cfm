<cfsilent>
<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	/admin/layouts/default.cfm
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
</cfsilent>
<cfsavecontent variable="local.newBody">
	<cfoutput>
		<div class="mfw1adminblock">
			<div id="pageTitle"><h2>#rc.pc.getPackage()#</h2></div>
			<div class="navwrapper">
				<ul>
					<li class="first<cfif rc.action eq 'admin:main.default'> active</cfif>"><a href="#buildURL('admin:main')#">Main</a></li>
					<li<cfif rc.action eq 'admin:license.default'> class="active"</cfif>><a href="#buildURL('admin:license')#">License</a></li>
					<li class="last<cfif rc.action eq 'admin:instructions.default'> active</cfif>"><a href="#buildURL('admin:instructions')#">Instructions</a></li>
				</ul>
			</div>
		</div>

		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="mfw1adminblock">
				<h4 class="red">Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h4>
				<ul>
					<cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
						<li>#rc.errors[local.e]#</li>
					</cfloop>
				</ul>
			</div>
		</cfif>

		<div class="mfw1adminblock">
			#body#
		</div>
	</cfoutput>
</cfsavecontent>
<cfoutput>#application.pluginManager.renderAdminTemplate(body=local.newBody,pageTitle=rc.pc.getName())#</cfoutput>