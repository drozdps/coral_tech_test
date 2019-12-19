({
    fetchStatistics : function(cmp) {
        cmp.set("v.isLoading", true);
        var action = cmp.get("c.getChildAuditResults");
        action.setParams({ 
            sObjectName : cmp.get("v.sObjectName"), 
            recordId : cmp.get("v.recordId"),  
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var mapping = new Array();
                var values = response.getReturnValue();
                for (var key in values) {
                    mapping.push({label: key, count: values[key]});
                }
                cmp.set('v.mapping', mapping);
            }
            else {
                   
            }
            cmp.set("v.isLoading", false);
        });

        $A.enqueueAction(action);
    }
})
