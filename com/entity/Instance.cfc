<cfcomponent extends="Entity">
	
	<cfset variables.instanceID = 0 />
	<cfset variables.instanceKey = "" />
	<cfset variables.instanceName = "" />
	<cfset variables.instanceHostname = "" />
	<cfset variables.instancePasskey = "" />
	<cfset variables.status = structNew() />
	
	<cffunction name="getInstanceID">
		<cfreturn variables.instanceID />
	</cffunction>
	<cffunction name="setInstanceID">
		<cfargument name="instanceID" />
		<cfset variables.instanceID = arguments.instanceID />
	</cffunction>
	
	<cffunction name="getInstanceKey">
		<cfreturn variables.instanceKey />
	</cffunction>
	<cffunction name="setInstanceKey">
		<cfargument name="instanceKey" />
		<cfset variables.instanceKey = arguments.instanceKey />
	</cffunction>
	
	<cffunction name="getInstanceName">
		<cfreturn variables.instanceName />
	</cffunction>
	<cffunction name="setInstanceName">
		<cfargument name="instanceName" />
		<cfset variables.instanceName = arguments.instanceName />
	</cffunction>

	<cffunction name="getInstanceHostname">
		<cfreturn variables.instanceHostname />
	</cffunction>
	<cffunction name="setInstanceHostname">
		<cfargument name="instanceHostname" />
		<cfset variables.instanceHostname = arguments.instanceHostname /> 
	</cffunction>
	
	<cffunction name="getInstancePasskey">
		<cfreturn variables.instancePasskey />
	</cffunction>
	<cffunction name="setInstancePasskey">
		<cfargument name="instancePasskey" />
		<cfset variables.instancePasskey = arguments.instancePasskey />
	</cffunction>
	
	<cffunction name="getTransactionKey">
		<cfset var date = DateFormat(now(), "MM-DD-YYYY") />
		<cfset var passdate = lcase(hash(lcase("#getInstancePasskey()##date#"))) />
		<cfreturn lcase(hash(lcase("#passdate##getInstanceKey()#"))) />
	</cffunction>
	
	<cffunction name="getStatus">
		<cfset tempStatus = structNew() />
		<cfif not structKeyExists(variables.status, "error") and not structKeyExists(variables.status, "coreVersion")>
			<cftry>
				<cfset statusService = createObject("webservice", "http://#getInstanceHostname()#/plugins/muraManagerRemote/remote.cfc?wsdl") />
				<cfset variables.status = statusService.getStatus(getTransactionKey()) />
				<cfcatch type="any">
					<cfset tempStatus.error = "Could Not Access Web Service" />
					<cfset variables.status = serializeJSON(tempStatus) />
				</cfcatch>
			</cftry>
		</cfif>
		<cfreturn deserializeJSON(variables.status) />
	</cffunction>
	
	<cffunction name="getSiteStatus">
		<cfargument name="siteID" />
		
		<cfset var status = getStatus() />
		<cfset var site = structNew() />
		
		<cfloop array="status.sites" index="thisSite">
			<cfif thisSite.siteID eq arguments.siteID>
				<cfset site = thisSite />
			</cfif>
		</cfloop>
		
		<cfreturn site />
	</cffunction>
	
</cfcomponent>