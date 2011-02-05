<cfsavecontent variable="local.newBody">
	<cfoutput>
		<div class="mfw1adminblock">
			<div id="pageTitle"><h2>mura Manager</h2></div>
			<div class="navwrapper">
				<ul>
					<li class="first<cfif rc.action eq 'admin:main.default'> active</cfif>"><a href="#buildURL('admin:main')#">Dashboard</a></li>
					<li class="last<cfif rc.action eq 'admin:main.editinstance'> active</cfif>"><a href="#buildURL('admin:main.editinstance')#">Add Mura Instance</a></li>
				</ul>
			</div>
		</div>
		<div class="mfw1adminblock">
			#body#
		</div>
	</cfoutput>
</cfsavecontent>
<cfoutput>#application.pluginManager.renderAdminTemplate(body=local.newBody,pageTitle="mura Manager")#</cfoutput>