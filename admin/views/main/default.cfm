<cfoutput>
	<h3>Dashboard</h3>	
	<table>
		<tr>
			<th>Instance Name</th>
			<th>Instance Key</th>
			<th>Instance Hostname</th>
			<th>Transaction Key</th>
			<th>Instance Passkey</th>
			<th>Admin Panel</th>
		</tr>
		<cfloop array="#rc.AllInstances#" index="instance" >
			<tr>
				<td>#instance.getInstanceName()#</td>
				<td>#instance.getInstanceKey()#</td>
				<td>#instance.getInstanceHostname()#</td>
				<td>#instance.getTransactionKey()#</td>
				<td>#instance.getInstancePasskey()#</td>
				<td>
					<a href="http://#instance.getInstanceHostname()#/admin">Go To Admin</a> |
					<a href="#buildURL(action='admin:main.editinstance', queryString='instanceID=#instance.getInstanceID()#')#">Edit</a> |
					<a href="#buildURL(action='admin:main.deleteinstance', queryString='instanceID=#instance.getInstanceID()#')#">Delete</a>
				</td>
			</tr>
		</cfloop>
	</table>
</cfoutput>