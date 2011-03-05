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
						<td class="varWidth"><a href="#buildURL(action='admin:instance.detail', queryString='instanceID=#instance.getInstanceID()#')#">#instance.getInstanceName()#</a></td>
						<td>#arrayLen(instance.getStatus().Comments)#</td>
						<td>#arrayLen(instance.getStatus().Sites)#</td>
						<td>#instance.getStatus().version#</td>
						<td><a href="http://#instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cDashboard.main&siteid=default" target="_blank">Launch Admin</a></td>
						<td class="administration">
							<ul class="three">
								<li class="viewDetails"><a href="#buildURL(action='admin:instance.detail', queryString='instanceID=#instance.getInstanceID()#')#">View Details</a></li>
								<li class="edit"><a href="#buildURL(action='admin:instance.edit', queryString='instanceID=#instance.getInstanceID()#')#">Edit</a></li>
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