<cfparam name="rc.showTKey" type="boolean" default="false" />
<cfparam name="rc.edit" type="boolean" default="false" />

<cfoutput>
	<cfif rc.edit> 
	<form action="?action=admin:instance.save" method="post">
		<input type="hidden" name="instanceID" value="#rc.instance.getInstanceID()#" />
	</cfif>
		<dl class="twoColumn">
			<dt>Instance Name</dt>
			<dd>
				<cfif rc.edit>
					<input type="text" name="instanceName" value="#rc.instance.getInstanceName()#" />
				<cfelse>
					#rc.instance.getInstanceName()#
				</cfif>
			</dd>
			<dt>Instance Key</dt>
			<dd>
				<cfif rc.edit>
					<input type="text" name="instanceKey" value="#rc.instance.getInstanceKey()#" />
				<cfelse>
					#rc.instance.getInstanceKey()#
				</cfif>
			</dd>
			<dt>Host Address (Domain Name)</dt>
			<dd>
				<cfif rc.edit>
					<input type="text" name="instanceHostname" value="#rc.instance.getInstanceHostname()#" />
				<cfelse>
					#rc.instance.getInstanceHostname()#
				</cfif>
			</dd>
			<cfif rc.edit>
				<dt>Passkey</dt>
				<dd><input type="text" name="instancePasskey" value="#rc.instance.getInstancePasskey()#" /></dd>
			</cfif>
			<cfif rc.showTKey>
				<dt>Tansaction Key</dt>
				<dd>#rc.instance.getTransactionKey()#</dd>
			</cfif>
		</dl>
	<cfif rc.edit> 
		<button type="submit">Save</button>
	</form>
	</cfif>
	<br />
	<br />
	<cfif not rc.edit>
		<div class="tabs initActiveTab ui-tabs ui-widget ui-widget-content ui-corner-all">
			<ul>
				<li><a href="##tabSites" onclick="return false;"><span>Sites</span></a></li>
				<li><a href="##tabDrafts" onclick="return false;"><span>Drafts</span></a></li>
				<li><a href="##tabComments" onclick="return false;"><span>Pending Comments</span></a></li>	
				<li><a href="##tabPlugins" onclick="return false;"><span>Plugins</span></a></li>
			</ul>
			<div id="tabSites">
				<table class="stripe">
					<tr>
						<th class="varWidth">Site Name</th>
						<th>Site ID</th>
						<th>Domain</th>
						<th>Site Theme</th>
						<th>Version</th>
						<th class="administration"></th>
					</tr>
				<cfloop array="#rc.instance.getStatus().sites#" index="local.site">
					<tr>
						<td class="varWidth">#site.site#</td>
						<td>#local.site.siteid#</td>
						<td>#local.site.domain#</td>
						<td>#local.site.theme#</td>
						<td>#local.site.siteVersion#</td>
						<td class="administration">
							<ul class="two">
								<li class="edit"><a href="http://#rc.instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cSettings.editSite&siteid=#site.siteid#" target="_blank">Edit Site</a></li>
								<li class="preview"><a href="http://#local.site.domain#/" target="_blank">Preview Site</a></li>
							</ul>
						</td>
					</tr>
				</cfloop>
				</table>
			</div>
			<div id="tabDrafts">
				<table class="stripe">
					<tr>
						<th class="varWidth">Content</th>
						<th>Site</th>
						<th>User</th>
						<th class="administration"></th>
					</tr>
					<cfloop array="#rc.instance.getStatus().drafts#" index="local.draft">
						<tr>
							<cfset siteStruct = rc.instance.getSiteStatus(local.draft.siteid) />
							<td class="varWidth">#local.draft.title#</td>
							<td>#local.draft.siteid#</td>
							<td>#local.draft.lastupdateby#</td>
							<td class="administration">
								<ul class="three">
									<li class="edit"><a title="Version History" href="http://#rc.instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cArch.edit&contenthistid=#local.draft.contenthistid#&contentid=#local.draft.contentid#&type=#local.draft.type#&parentid=#local.draft.parentid#&topid=#ListGetAt(local.draft.path,1)#&siteid=#local.draft.siteid#&startrow=1&moduleid=#local.draft.moduleid#&return=hist&compactDisplay=false" target="_blank">Edit</a></li>
									<li class="versionHistory"><a title="Version History" href="http://#rc.instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cArch.hist&contentid=#local.draft.contentid#&type=#local.draft.type#&parentid=#local.draft.parentid#&topid=#ListGetAt(local.draft.path,1)#&siteid=#local.draft.siteid#&moduleid=#local.draft.moduleid#&startrow=1" target="_blank">Version History</a></li>
									<li class="preview"><a href="http://#siteStruct.domain#/#local.draft.siteid#/index.cfm?previewid=#local.draft.contenthistid#&contentid=#local.draft.contentid#" target="_blank">Preview Site</a></li>
								</ul>
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
			<div id="tabComments">
				<table class="stripe">
					<tr>
						<th class="varWidth">Content</th>
						<th>Site</th>
						<th>Name</th>
						<th>Email</th>
						<th>IP</th>
						<th class="administration"></th>
					</tr>
					<cfloop array="#rc.instance.getStatus().comments#" index="local.comment">
						<cfset siteStruct = rc.instance.getSiteStatus(local.draft.siteid) />
						<tr>
							<td class="varWidth">#local.comment.title#</td>
							<td>#local.comment.site#</td>
							<td>#local.comment.name#</td>
							<td><a href="mailto:#local.comment.email#">#local.comment.email#</a></td>
							<td>#local.comment.ip#</td>
							<td class="administration">
								<ul class="one">
									<li class="preview"><a href="http://#siteStruct.domain#/#local.comment.siteid#/index.cfm/#local.comment.Filename#" target="_blank">Preview Site</a></li>
								</ul>
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
			<div id="tabPlugins">
				<table class="stripe">
					<tr>
						<th class="varWidth">Plugin Name</th>
						<th>Provider</th>
						<th>Version</th>
						<th class="administration"></th>
					</tr>
					<cfloop array="#rc.instance.getStatus().plugins#" index="local.plugin">
						<tr>
							<td class="varWidth">#local.plugin.name#</td>
							<td><a href="#local.plugin.providerURL#">#local.plugin.provider#</a></td>
							<td>#local.plugin.version#</td>
							<td class="administration">
								<ul class="one">
									<li class="edit"><a href="http://#rc.instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cSettings.editPlugin&moduleID=#local.plugin.moduleID#" target="_blank">Edit Site</a></li>
								</ul>
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
		</div>
	</cfif>
</cfoutput>