<cfcomponent extends="DAO">
	
	<cffunction name="getAllInstances">
		
		<cfquery name="instanceQuery" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#" >
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				instancePasskey
			FROM
				MuraManagerInstance
		</cfquery>
		
		<cfreturn instanceQuery />
	</cffunction>
	
	<cffunction name="getInstanceByID">
		<cfargument name="instanceID" />
		
		<cfquery name="instanceQuery" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#" >
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				instancePasskey
			FROM
				MuraManagerInstance
			WHERE
				instanceID = <cfqueryparam value="#arguments.instanceID#" />
		</cfquery>
		
		<cfreturn instanceQuery />
	</cffunction>
	
	<cffunction name="save">
		<cfargument name="instance" />
		
		<cfif arguments.instance.getInstanceID() eq 0>
			<cfquery name="instanceQuery" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#" >
				INSERT INTO MuraManagerInstance (
					instanceKey,
					instanceName,
					instanceHostname,
					instancePasskey
				) VALUES (
					<cfqueryparam value="#arguments.instance.getInstanceKey()#" />,
					<cfqueryparam value="#arguments.instance.getInstanceName()#" />,
					<cfqueryparam value="#arguments.instance.getInstanceHostname()#" />,
					<cfqueryparam value="#arguments.instance.getInstancePasskey()#" />
				)
			</cfquery>
		<cfelse>
			<cfquery name="instanceQuery" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#" >
				UPDATE
					MuraManagerInstance
				SET
					instanceKey = <cfqueryparam value="#arguments.instance.getInstanceKey()#" />,
					instanceName = <cfqueryparam value="#arguments.instance.getInstanceName()#" />,
					instanceHostname = <cfqueryparam value="#arguments.instance.getInstanceHostname()#" />,
					instancePasskey = <cfqueryparam value="#arguments.instance.getInstancePasskey()#" />  
				WHERE
					instanceID = <cfqueryparam value="#arguments.instance.getInstanceID()#" />
			</cfquery>
		</cfif>
		
		<cfreturn arguments.instance />
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="instance" />
		
		<cfquery name="instanceQuery" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#" >
			DELETE FROM MuraManagerInstance	WHERE instanceID = <cfqueryparam value="#arguments.instance.getInstanceID()#" />
		</cfquery>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>