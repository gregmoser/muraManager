<cfparam name="rc.allInstances" type="array" />

<cfoutput>
	<div class="adminmaindefault">
		<table class="stripe">
			<tr>
				<th class="varWidth">Name</th>
				<th>Pending Comments</th>
				<th>Total Sites</th>
				<th>Version</th>
				<th>Management</th>
				<th class="administration"></th>
			</tr>	
			<cfloop array="#rc.AllInstances#" index="instance">
				<cfif structKeyExists(instance.getStatus(), "sites")>
					<tr>
						<td class="varWidth">#instance.getInstanceName()#</td>
						<td>#arrayLen(instance.getStatus().Comments)#</td>
						<td>#arrayLen(instance.getStatus().Sites)#</td>
						<td>#instance.getStatus().version#</td>
						<td><a href="#buildURL(action='admin:utility.external', queryString='site=http://#instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cDashboard.main&siteid=default')#"">Launch Admin</a></td>
						<td class="administration">
							<ul class="three">
								<li class="edit"><a href="#buildURL(action='admin:instance.edit', queryString='instanceID=#instance.getInstanceID()#')#">Edit</a></li>
								<li class="viewDetails"><a href="#buildURL(action='admin:instance.detail', queryString='instanceID=#instance.getInstanceID()#')#">View Details</a></li>
								<li class="delete"><a href="#buildURL(action='admin:instance.delete', queryString='instanceID=#instance.getInstanceID()#')#">Delete</a></li>
							</ul>
						</td>
					</tr>
				<cfelse>
					<tr>
						<td class="varWidth">#instance.getInstanceName()#</td>
						<td colspan="4">(no access)</td>
						<td class="administration">
							<ul class="two">
								<li class="edit"><a href="#buildURL(action='admin:instance.edit', queryString='instanceID=#instance.getInstanceID()#')#">Edit</a></li>
								<li class="delete"><a href="#buildURL(action='admin:instance.delete', queryString='instanceID=#instance.getInstanceID()#')#">Delete</a></li>
							</ul>
						</td>
					</tr>
				</cfif>
			</cfloop>
		</table>
	</div>
</cfoutput>
<!---
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
--->