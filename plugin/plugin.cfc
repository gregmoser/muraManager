<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	plugin/plugin.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.18

--->
<cfcomponent output="false" extends="mura.plugin.plugincfc">

	<cfset variables.config = '' />

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="config"  type="any" default="" />
		<cfscript>
			variables.config = arguments.config;
		</cfscript>
	</cffunction>
	
	<cffunction name="install" access="public" returntype="void" output="false">
		<cfscript>
			var local = StructNew();

			// need to check and see if this is already installed ... if so, then abort!
			local.moduleid = variables.config.getModuleID();

			// comment this out if you want to allow more than 1 installation of this plugin per Mura CMS install.
			if ( val(getInstallationCount()) neq 1 ) {
				variables.config.getPluginManager().deletePlugin(local.moduleid);
			} else {
				installDatabase();
				// doSomethingElseIfNeeded();
			};

			application.appInitialized = false;
		</cfscript>
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfscript>
			// this will be executed by the pluginManager when the plugin is updated.
			application.appInitialized = false;
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" access="public" returntype="void" output="false">
		<cfscript>
			// this will be executed by the pluginManager when the plugin is deleted.
			var local = StructNew();
			// don't delete the subTypes if this is being invoked by the deletePlugin() from install()
			if ( val(getInstallationCount()) eq 1 ) {
				//deleteSomethingAppSpecificIfNeeded();
				deleteDatabase();
			};
			application.appInitialized = false;
		</cfscript>
	</cffunction>

	<!--- *******************************    private    ******************************** --->
	<cffunction name="getInstallationCount" access="private" returntype="any" output="false">
		<cfscript>
			var qoq = '';
			var rs = variables.config.getConfigBean().getPluginManager().getAllPlugins();
		</cfscript>
		<cfquery name="qoq" dbtype="query">
			SELECT *
			FROM rs
			WHERE package = <cfqueryparam value="#variables.config.getPackage()#" cfsqltype="cf_sql_varchar" maxlength="100" />
		</cfquery>
		<cfreturn val(qoq.recordcount) />
	</cffunction>
	
	<cffunction name="installDatabase" access="private" returntype="any" output="false">
		<cfquery name="rs" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#">
			CREATE TABLE [dbo].[MuraManagerInstance] (
				[instanceID] [int] IDENTITY(1,1) NOT NULL,
				[instanceName] [char](50) NULL,
				[instanceHostname] [char](50) NULL,
				[instanceKey] [char](50) NULL,
				[instancePasskey] [char](50) NULL,
				CONSTRAINT [PK_MuraMonitorInstance] PRIMARY KEY CLUSTERED (
					[instanceID] ASC
				) WITH (
					PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON
				) ON [PRIMARY]
			) ON [PRIMARY]
		</cfquery>
		<cfreturn true />
	</cffunction>
	
	<cffunction name="deleteDatabase" access="private" returntype="any" output="false">
		<cfquery name="rs" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getUsername()#" password="#application.configBean.getPassword()#">
			DROP TABLE [MuraManagerInstance]
		</cfquery>
		<cfreturn true />
	</cffunction>

</cfcomponent>