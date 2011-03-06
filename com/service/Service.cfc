<cfcomponent>
	
	<cffunction name="init">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getNewEntity">
		<cfreturn createObject("component", "muraManager.com.entity.entity") />
	</cffunction>
	
	<cfscript>
		public any function queryToEntity(required query entityQuery, boolean uniqueRecord = false) {
			var entityArray = arrayNew(1);
			for(var i = 1; i <= arguments.entityQuery.recordcount; i++) {
				var entity = getNewEntity();
				for(var ii = 1; ii<= listLen(arguments.entityQuery.columnList); ii++) {
					var columnName = listGetAt(arguments.entityQuery.columnList, ii);
					evaluate("entity.set#columnName#('#trim(arguments.entityQuery[columnName][I])#')");	
				}
				arrayAppend(entityArray, entity);
			}
			if(uniqueRecord && arguments.entityQuery.recordcount < 1) {
				return getNewEntity();
			} else if(uniqueRecord) {
				return entityArray[1];	
			} else {
				return entityArray;
			}
		}
	</cfscript>
</cfcomponent>
	
