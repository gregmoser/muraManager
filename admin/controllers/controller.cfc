<cfcomponent extends="mura.cfobject">
	
	<cfset variables.fw = "" />
	
	<cffunction name="getFW">
		<cfreturn variables.fw />
	</cffunction>
	<cffunction name="setFW">
		<cfargument name="fw" />
		<cfset variables.fw = arguments.fw />
	</cffunction>
	
	<cffunction name="init">
		<cfargument name="fw" />
		
		<cfset setFW(arguments.fw) />
	</cffunction>
	
	<cffunction name="subSystemBefore">
		<cfargument name="rc" type="struct" />
		
		<cfset rc.sectionTitle = "" />
		<cfset rc.itemTitle = "" />
	</cffunction>
	
</cfcomponent>