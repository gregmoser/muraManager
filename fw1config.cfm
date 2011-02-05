<!---

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

CAREFULLY READ THE ENCLOSED LICENSE AGREEMENT (plugin/license.htm). BY USING THIS SOFTWARE, YOU ARE CONSENTING TO BE BOUND BY AND ARE BECOMING A PARTY TO THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS AGREEMENT, THEN DO NOT USE THIS SOFTWARE, AND, IF APPLICABLE, RETURN THIS PRODUCT TO THE PLACE OF PURCHASE FOR A FULL REFUND.

		Document:	fw1config.cfm
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.01.28

--->
<cfscript>
	// !important: enter the plugin packageName here. must be the same as found in '/plugin/config.xml.cfm'
	variables.instance.package = 'muraManager';

	// less commonly modified
	variables.instance.defaultSection = 'main';
	variables.instance.defaultItem = 'default';
	variables.instance.usingSubSystems = true;
	variables.instance.defaultSubsystem = 'admin';

	// ***** rarely modified *****
	variables.framework = StructNew();
	variables.framework.applicationKey = instance.package;
	variables.framework.base = '/' & instance.package;
	variables.framework.action = 'action';
	variables.framework.defaultSection = instance.defaultSection;
	variables.framework.defaultItem = instance.defaultItem;
	variables.framework.defaultSubsystem = instance.defaultSubsystem;
	//variables.framework.reload = 'reload';
	//variables.framework.password = 'appreload';
	variables.framework.reloadApplicationOnEveryRequest = true;
	variables.framework.generateSES = false;
	variables.framework.SESOmitIndex = true;
	variables.framework.suppressImplicitService = false;
	variables.framework.unhandledExtensions = 'cfc';
	variables.framework.unhandledPaths = '/flex2gateway';
	variables.framework.preserveKeyURLKey = 'fw1pk';
	variables.framework.maxNumContextsPreserved = 10;
	variables.framework.cacheFileExists = false;
	variables.framework.usingSubSystems = instance.usingSubSystems;
	if ( instance.usingSubSystems ) {
		variables.framework.subsystemDelimiter = ':';
		variables.framework.siteWideLayoutSubsystem = 'common';
		variables.framework.home = instance.defaultSubsystem & framework.subsystemDelimiter & instance.defaultSection & '.' & instance.defaultItem;
		variables.framework.error = instance.defaultSubsystem & framework.subsystemDelimiter & instance.defaultSection & '.error';
	} else {
		variables.framework.home = instance.defaultSection & '.' & instance.defaultItem;
		variables.framework.error = instance.defaultSection & '.error';
	};
</cfscript>