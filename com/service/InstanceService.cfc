<cfcomponent extends="Service">
	
	<cfset variables.DAO = "" />
	
	<cffunction name="init">
		<cfargument name="DAO" />
		<cfset setDAO(arguments.DAO) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getDAO">
		<cfreturn variables.DAO />
	</cffunction>
	<cffunction name="setDAO">
		<cfargument name="DAO" />
		<cfset variables.DAO = arguments.DAO />
	</cffunction>
	
	<cffunction name="save">
		<cfargument name="instance" />
		<cfreturn getDAO().save(arguments.instance) />
	</cffunction>
	
	<cffunction name="read">
		<cfargument name="instanceID" />
		<cfreturn queryToEntity(getDAO().getInstanceByID(arguments.instanceID), true) />
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="instance" />
		<cfreturn getDAO().delete(arguments.instance) />
	</cffunction>
	
	<cffunction name="getAllInstances">
		<cfreturn queryToEntity(getDAO().getAllInstances()) />
	</cffunction>
	
	<cffunction name="getNewEntity">
		<cfreturn CreateObject("component", "muraManager.com.entity.Instance") />
	</cffunction>
</cfcomponent>
}