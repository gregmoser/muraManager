<cfsavecontent variable="local.newBody">
	<cfoutput>
		<div class="mfw1adminblock">
			<div id="pageTitle"><h2>mura Manager</h2></div>
			<div>
				<ul id="navTask">
					<li><a href="#buildURL('admin:main')#">Dashboard</a></li>
					<li><a href="#buildURL('admin:instance.create')#">Add Mura Instance</a></li>
				</ul>
			</div>
		</div>
		<div class="mfw1adminblock">
			#body#
		</div>
	</cfoutput>
</cfsavecontent>
<cfoutput>#application.pluginManager.renderAdminTemplate(body=local.newBody,pageTitle="mura Manager")#</cfoutput>