<cfoutput>
	<h3>Dashboard</h3>	
	<table>
		<tr>
			<th>Instance Name</th>
			<th>Host Address</th>
			<th>Core Version</th>
			<th>Admin Panel</th>
		</tr>
	</table>
	<cfset instanceTest = createObject("component", "muraManager.com.entity.Instance") />
	<cfset instanceTest.setInstanceKey("208cfa23c2948ff2284056ef1dd186f5") />
	<cfset instanceTest.setPasskey("passkeyone") />
	<strong>Transaction Key:</strong> #instanceTest.getTransactionKey()#
</cfoutput>