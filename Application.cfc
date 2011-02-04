<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	Application.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
<cfcomponent extends="fw1">

	<cfinclude template="../../config/applicationSettings.cfm" />
	<cfinclude template="../../config/mappings.cfm" />
	<cfinclude template="../mappings.cfm" />
	<cfinclude template="fw1config.cfm" />

	<!--- ********************** fw/1-specific *************************** --->
	<cffunction name="setupApplication" output="false">
		<cfscript>
			var local = StructNew();
		</cfscript>
		<cflock type="exclusive" timeout="50">
			<cfscript>
				// THIS IS CRITICIAL!! This is what gives this FW/1 app access to it's own pluginConfig within Mura CMS
				// in the setupRequest() it is also assigned to request.context to allow you to access the pluginConfig with 'rc.pc' OR 'rc.pluginConfig'
				application[variables.framework.applicationKey].pluginConfig = application.pluginManager.getConfig(ID=variables.framework.applicationKey);
				local.pc = application[variables.framework.applicationKey].pluginConfig;
				local.pc.getApplication().setValue("instanceService", new muraManager.com.service.InstanceService(new muraManager.com.dao.InstanceDAO()));
				setBeanFactory(local.pc.getApplication(purge=false));
			</cfscript>
		</cflock>
	</cffunction>

	<cffunction name="setupRequest">
		<cfscript>
			var local = StructNew();

			secureRequest();
			request.context.isAdminRequest = isAdminRequest();
			request.context.isFrontEndRequest = isFrontEndRequest();
			
			if ( StructKeyExists(url, application.configBean.getAppReloadKey()) ) { 
				setupApplication();
			};

			// rc.$
			if ( not StructKeyExists(request.context, '$') and StructKeyExists(session, 'siteid') ) {
				request.context.$ = getBeanFactory().getBean('muraScope').init(session.siteid);
			};

			// rc.pc and rc.pluginConfig
			request.context.pc = application[variables.framework.applicationKey].pluginConfig;
			request.context.pluginConfig = application[variables.framework.applicationKey].pluginConfig;
		</cfscript>
	</cffunction>

	<cffunction name="onMissingView" output="true">
		<cfargument name="rc" />
		<cfscript>
			var local = StructNew();			
			local.eMessage = "The page you're looking for ";
			// rc.action SHOULD always be there, but just in case...
			if ( StructKeyExists(arguments.rc, 'action') ) {
				local.eMessage = local.eMessage & '<em>' & rc.action & '</em> ';
			};
			local.eMessage = local.eMessage & " doesn't exist.";
			
			rc.errors = ArrayNew(1);
			ArrayAppend(rc.errors, local.eMessage);
			
			// forward to appropriate error screen
			if ( isFrontEndRequest() ) {
				redirect(action='public:main.error',preserve='errors');
			} else {
				redirect(action='admin:main.error',preserve='errors');
			};
		</cfscript>
	</cffunction>

	<!--- ********************** HELPERS / Mura-specific *************************** --->
	<cffunction name="secureRequest" output="false">
		<cfif isAdminRequest() and not IsUserInRole('S2')>
			<cfif not StructKeyExists(session,'siteID') or not application.permUtility.getModulePerm(getBeanFactory('pluginConfig').getValue('moduleID'),session.siteid)>
				<cflocation url="#application.configBean.getContext()#/admin/" addtoken="false" />
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="isAdminRequest" output="false" returntype="boolean">
		<cfscript>
			if ( StructKeyExists(request, 'action') and ListFirst(request.action, ':') eq 'admin' ) {
				return true;
			} else {
				return false;
			};
		</cfscript>
	</cffunction>

	<cffunction name="isFrontEndRequest" output="false" returntype="boolean">
		<cfreturn StructKeyExists(request, 'murascope') />
	</cffunction>

</cfcomponent>