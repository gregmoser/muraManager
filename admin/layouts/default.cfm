<cfsavecontent variable="local.newBody">
	<cfoutput>
		<div class="mfw1adminblock">
			<h2>mura Manger | #rc.sectionTitle# #rc.itemTitle#</h2>
			#body#
		</div>
	</cfoutput>
</cfsavecontent>
<cfoutput>#application.pluginManager.renderAdminTemplate(body=local.newBody,pageTitle="mura Manager")#</cfoutput>