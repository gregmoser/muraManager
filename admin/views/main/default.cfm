<cfoutput>
	<h3>Dashboard</h3>	
	<cfloop array="#rc.AllInstances#" index="instance">
		<div style="border:5px solid ##333333">
			<table>
				<tr>
					<th>Instance Name</th>
					<th>Instance Key</th>
					<th>Instance Hostname</th>
					<th>Admin</th>
				</tr>
				<tr>
					<td>#instance.getInstanceName()#</td>
					<td>#instance.getInstanceKey()#</td>
					<td>#instance.getInstanceHostname()#</td>
					<td>
						<a href="http://#instance.getInstanceHostname()#/admin">Go To Admin</a> |
						<a href="#buildURL(action='admin:main.editinstance', queryString='instanceID=#instance.getInstanceID()#')#">Edit</a> |
						<a href="#buildURL(action='admin:main.deleteinstance', queryString='instanceID=#instance.getInstanceID()#')#">Delete</a>
					</td>
				</tr>
			</table>
			<cfset instanceStatus = instance.getStatus() />
			<cfif not isDefined("instanceStatus.error")>
				<strong>Sites</strong>
				<table>
					<tr>
						<th>Site Name</th>
						<th>Site ID</th>
						<th>Theme</th>
						<th>Admin</th>
					</tr>
					<cfloop array="#instanceStatus.Sites#" index="Site">
						<tr>
							<td>#Site.site#</td>
							<td>#Site.siteID#</td>
							<td>#Site.theme#</td>
							<td><a href="http://#instance.getInstanceHostname()#/#Site.siteID#/">Preview</a></td>
						</tr>
					</cfloop>
				</table>
				<strong>Plugins</strong>
				<table>
					<tr>
						<th>Plugin Name</th>
						<th>Version</th>
						<th>Provider</th>
						<th>Provider Website</th>
					</tr>
					<cfloop array="#instanceStatus.Plugins#" index="Plugin">
						<tr>
							<td>#Plugin.name#</td>
							<td>#Plugin.version#</td>
							<td>#Plugin.provider#</td>
							<td><a href="#Plugin.providerURL#">Provider Website</a></td>
						</tr>
					</cfloop>
				</table>
			<cfelse>
				Instance Key or Passkey is Incorrect for this Instance.
			</cfif>
		</div>
	</cfloop>
</cfoutput>