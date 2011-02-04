<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	pluginEventHandler.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cfset variables.preserveKeyList = 'context,base,cfcbase,subsystem,subsystembase,section,item,services,action,controllerExecutionStarted' />
	
	<!--- Include FW/1 configuration that is shared between the Mura CMS and the FW/1 application. --->
	<cfinclude template="fw1config.cfm" />

	<!--- ********** Mura Specific Events ************* --->

	<cffunction name="onApplicationLoad" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfset var state=preseveInternalState(request)>
		<cfinvoke component="#variables.pluginConfig.getPackage()#.Application" method="onApplicationStart" />
		<cfset restoreInternalState(request,state)>
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>
	
	<cffunction name="onGlobalSessionStart" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfset var state=preseveInternalState(request)>
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onSessionStart" />
		<cfset restoreInternalState(request,state)>
	</cffunction>

	<cffunction name="onSiteRequestStart" output="false">
        <cfargument name="$" required="true" hint="mura scope" />
        <cfset $[variables.framework.applicationKey] = this />        
    </cffunction>

	<cffunction name="onRenderStart" output="false" returntype="any">
		<cfargument name="$" />
		<cfscript>
			// this allows you to call methods here by accessing '$.mfw1.methodName(argumentCollection=args)'
			$.mfw1 = this;
		</cfscript>
	</cffunction>

	<!--- ********** display object/s ************ --->	

	<cffunction name="renderApp" output="false">
		<cfargument name="$" required="true" hint="mura scope" />
		<cfargument name="action" required="false" default="" 
			hint="if only rendering a 'widget', then pass in the action such as 'public:main.default' ... otherwise, just leave it blank!" />
		<cfreturn doEvent(arguments.$,arguments.action) />
	</cffunction>

	<!--- ********** FW/1 ************* --->

	<cffunction name="doEvent" output="false">
		<cfargument name="$" required="true" />
		<cfargument name="action" type="string" required="false" default="" 
					hint="Optional: If not passed it looks into the event for a defined action, else it uses the default" />
		<cfreturn doAction(arguments.$,arguments.action) />
	</cffunction>
	
	<cffunction name="doAction" output="false">
		<cfargument name="$" />
		<cfargument name="action" type="string" required="false" default="" 
					hint="Optional: If not passed it looks into the event for a defined action, else it uses the default" />
		<cfscript>
			var local = StructNew();
			var state = StructNew();
			var result = '';
			var savedEvent = '';
			var savedAction = '';
			var fw1 = CreateObject('component','#pluginConfig.getPackage()#.Application');

			// Put the event url struct, to be used by FW/1
			url.$ = arguments.$;
			if ( not len( arguments.action ) ) {
				if ( len(arguments.$.event(variables.framework.action)) ) {
					arguments.action = arguments.$.event(variables.framework.action);
				} else {
					arguments.action = variables.framework.home;
				};
			};
		
			// put the action passed into the url scope, saving any pre-existing value
			if ( StructKeyExists(request, variables.framework.action) ) {
				savedEvent = request[variables.framework.action];
			};

			if ( StructKeyExists(url,variables.framework.action) ) {
				savedAction = url[variables.framework.action];
			};

			url[variables.framework.action] = arguments.action;
			state = preseveInternalState(request);

			// call the frameworks onRequestStart
			fw1.onRequestStart(CGI.SCRIPT_NAME);
		</cfscript>

		<!--- call the frameworks onRequest --->
		<!--- we save the results via cfsavecontent so we can display it in mura --->
		<cfsavecontent variable="result">
			<cfset fw1.onRequest(CGI.SCRIPT_NAME) />
		</cfsavecontent>
		
		<cfscript>
			// restore the url scope
			if ( StructKeyExists(url,variables.framework.action) ) {
				StructDelete(url,variables.framework.action);
			};

			// if there was a passed in action via the url then restore it
			if ( Len(savedAction) ) {
				url[variables.framework.action] = savedAction;
			};

			// if there was a passed in request event then restore it
			if ( Len(savedEvent) ) {
				request[variables.framework.action] = savedEvent;
			};
			
			restoreInternalState(request,state);

			return result;
		</cfscript>
	</cffunction>

	<cffunction name="checkFrameworkConfig" output="false">
		<cfargument name="$" />
		<cfset var str="">
		<cfset var configPath="#expandPath('/plugins')#/#variables.pluginConfig.getDirectory()#/frameworkConfig.cfm">
		<cfset var lineBreak=chr(13) & chr(10)>
		<cfif variables.framework.applicationKey neq variables.pluginConfig.getPackage() & lineBreak>
			<cfset str='<cfset variables.framework=structNew()>' & lineBreak>
			<cfset str=str & '<cfset variables.framework.applicationKey="#variables.pluginConfig.getPackage()#">' & lineBreak>
			<cfset str=str & '<cfset variables.framework.base="/#variables.pluginConfig.getPackage()#">' & lineBreak>
			<cfset str=str & '<cfset variables.framework.usingsubsystems=false>' & lineBreak>
			<cfset str=str & '<cfset variables.framework.action="action">' & lineBreak>
			<cfset str=str & '<cfset variables.framework.home="main.default">' & lineBreak>
			<cfset str=str & '<cfset variables.framework.baseURL="useRequestURI">' & lineBreak>
			<cfset str=str & '<cfset variables.framework.SESOmitIndex="true">' & lineBreak>
			<cfset $.getBean('fileWriter').writeFile(file=configPath, output=str)>
			<cfinclude template="frameworkConfig.cfm">
		</cfif>
	</cffunction>
	
	<cffunction name="preseveInternalState" output="false">
		<cfargument name="state" />
		<cfset var preserveKeys=structNew()>
		<cfset var k="">

		<cfif StructKeyExists(request, 'controllers')>
			<cfset StructDelete(request, 'controllers') />
		</cfif>
		
		<cfloop list="#variables.preserveKeyList#" index="k">
			<cfif isDefined("arguments.state.#k#")>
				<cfset preserveKeys[k]=arguments.state[k]>
				<cfset structDelete(arguments.state,k)>
			</cfif>
		</cfloop>
		<cfset structDelete( arguments.state, "serviceExecutionComplete" )>
		<cfreturn preserveKeys>
	</cffunction>
	
	<cffunction name="restoreInternalState" output="false">
		<cfargument name="state" />
		<cfargument name="restore" />
		<cfloop list="#variables.preserveKeyList#" index="k">
			<cfset StructDelete(arguments.state,k)>
		</cfloop>
		<cfset StructAppend( state,restore, true )>
		<cfset StructDelete( state, "serviceExecutionComplete" )>
	</cffunction>

</cfcomponent>