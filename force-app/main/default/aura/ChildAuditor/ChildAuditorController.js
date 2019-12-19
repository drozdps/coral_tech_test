({
    doInit: function(component, event, helper) {
        helper.fetchStatistics(component);
    },

    handleRefresh: function(component, event, helper) {
        helper.fetchStatistics(component)
    }
})
