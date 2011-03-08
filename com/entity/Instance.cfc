<cfcomponent extends="Entity" output="false">
	
	<cfset variables.instanceID = 0 />
	<cfset variables.instanceKey = "" />
	<cfset variables.instanceName = "" />
	<cfset variables.instanceHostname = "" />
	<cfset variables.instancePasskey = "" />
	
	<cffunction name="getInstanceID" output="false">
		<cfreturn trim(variables.instanceID) />
	</cffunction>
	<cffunction name="setInstanceID">
		<cfargument name="instanceID" />
		<cfset variables.instanceID = trim(arguments.instanceID) />
	</cffunction>
	
	<cffunction name="getInstanceKey" output="false">
		<cfreturn trim(variables.instanceKey) />
	</cffunction>
	<cffunction name="setInstanceKey">
		<cfargument name="instanceKey" />
		<cfset variables.instanceKey = trim(arguments.instanceKey) />
	</cffunction>
	
	<cffunction name="getInstanceName" output="false">
		<cfreturn trim(variables.instanceName) />
	</cffunction>
	<cffunction name="setInstanceName">
		<cfargument name="instanceName" />
		<cfset variables.instanceName = trim(arguments.instanceName) />
	</cffunction>

	<cffunction name="getInstanceHostname" output="false">
		<cfreturn trim(variables.instanceHostname) />
	</cffunction>
	<cffunction name="setInstanceHostname">
		<cfargument name="instanceHostname" />
		<cfset variables.instanceHostname = trim(arguments.instanceHostname) /> 
	</cffunction>
	
	<cffunction name="getInstancePasskey" output="false">
		<cfreturn trim(variables.instancePasskey) />
	</cffunction>
	<cffunction name="setInstancePasskey">
		<cfargument name="instancePasskey" />
		<cfset variables.instancePasskey = trim(arguments.instancePasskey) />
	</cffunction>
	
	<cffunction name="getTransactionKey" output="false">
		<cfset var date = DateFormat(now(), "MM-DD-YYYY") />
		<cfset var passdate = lcase(hash(lcase("#getInstancePasskey()##date#"))) />
		<cfreturn lcase(hash(lcase("#passdate##getInstanceKey()#"))) />
	</cffunction>
	
	<cffunction name="getStatus" output="false">
		<cfset tempStatus = structNew() />
		<cfif not isDefined("variables.status")>
			<cftry>
				<cfset statusService = createObject("webservice", "http://#getInstanceHostname()#/plugins/muraManagerRemote/remote.cfc?wsdl") />
				<cfset variables.status = statusService.getStatus(getTransactionKey()) />
				<cfcatch type="any">
					<cfset tempStatus.error = "Could Not Access Web Service" />
					<cfset variables.status = tempStatus />
				</cfcatch>
			</cftry>
		</cfif>
		<cfreturn variables.status />
	</cffunction>
	
	<cffunction name="getSiteStatus" output="false">
		<cfargument name="siteID" />
		
		<cfset var status = getStatus() />
		<cfset var site = structNew() />
		<cfset var thisSite = structNew() />
		
		<cfloop array="#status.sites#" index="thisSite">
			<cfif thisSite.siteID eq arguments.siteID>
				<cfset site = Duplicate(thisSite) />
			</cfif>
		</cfloop>
		
		<cfreturn site />
	</cffunction>
	
</cfcomponent>