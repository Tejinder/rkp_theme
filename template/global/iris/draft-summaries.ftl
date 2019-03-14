This is Draft Summary

<#if irisSummaryList?? && irisSummaryList?size gt 0>  
	<#list irisSummaryList as irisSummary>
		Project Name ${irisSummary.projectName}
		Modified Date ${irisSummary.modifiedDate}
		<br>
	</#list>

</#if>