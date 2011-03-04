<cfoutput>
	<cfif rc.instance.getInstanceID() eq 0>
		<h3>Add Instance</h3>	
	<cfelse>
		<h3>Edit Instance</h3>
	</cfif>
	<form action="?action=admin:main.saveinstance" method="post">
		<input type="hidden" name="instanceID" value="#rc.instance.getInstanceID()#" />
		<dl>
			<dt>Instance Name</dt>
			<dd><input type="text" name="instanceName" value="#rc.instance.getInstanceName()#" /></dd>
		</dl>
		<dl>
			<dt>Instance Key</dt>
			<dd><input type="text" name="instanceKey" value="#rc.instance.getInstanceKey()#" /></dd>
		</dl>
		<dl>
			<dt>Instance Host Address</dt>
			<dd><input type="text" name="instanceHostname" value="#rc.instance.getInstanceHostname()#" /></dd>
		</dl>
		<dl>
			<dt>Passkey</dt>
			<dd><input type="text" name="instancePasskey" value="#rc.instance.getInstancePasskey()#" /></dd>
		</dl>
		<button type="submit">Add</button>
	</form>
</cfoutput>