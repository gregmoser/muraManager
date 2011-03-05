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
			<dt>Instance Host Address</dt>
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
				<li><a href="##tabComments" onclick="return false;"><span>Pending Comments</span></a></li>	
				<li><a href="##tabPlugins" onclick="return false;"><span>Plugins</span></a></li>
			</ul>
			<div id="tabSites">
				<table class="stripe">
					<th class="varWidth">Site Name</th>
					<th>Site ID</th>
					<th>Site Theme</th>
					<th>Version</th>
					<th class="administration"></th>
				<cfloop array="#rc.instance.getStatus().sites#" index="local.site">
					<tr>
						<td class="varWidth">#site.site#</td>
						<td>#site.siteid#</td>
						<td>#site.theme#</td>
						<td>#site.siteVersion#</td>
						<td class="administration">
							<ul class="two">
								<li class="edit"><a href="http://#rc.instance.getInstanceHostname()#/admin/index.cfm?fuseaction=cSettings.editSite&siteid=#site.siteid#" target="_blank">Edit Site</a></li>
								<li class="preview"><a href="http://#rc.instance.getSiteStatus(site.siteid).domain#/" target="_blank">Preview Site</a></li>
							</ul>
						</td>
					</tr>
				</cfloop>
				</table>
			</div>
			<div id="tabComments">
				<table class="stripe">
					<th class="varWidth">Content</th>
					<th>Site</th>
					<th>Name</th>
					<th>Email</th>
					<th>IP</th>
					<th class="administration"></th>
					<cfloop array="#rc.instance.getStatus().comments#" index="local.comment">
						<tr>
							<td class="varWidth">#local.comment.title#</td>
							<td>#local.comment.site#</td>
							<td>#local.comment.name#</td>
							<td><a href="mailto:#local.comment.email#">#local.comment.email#</a></td>
							<td>#local.comment.ip#</td>
							<td class="administration">
								<ul class="one">
									<li class="preview"><a href="http://#rc.instance.getSiteStatus(local.comment.siteid).domain#/#local.comment.siteid#/index.cfm/#local.comment.Filename#" target="_blank">Preview Site</a></li>
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