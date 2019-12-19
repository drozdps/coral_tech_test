/*
 * Apex controller for ChildAuditor Aura component
 *
 * @author Paul Drozd
 * @since 19-12-2019
 */
public with sharing class ChildAuditorController {

    @AuraEnabled
    public static Map<String, Integer> getChildAuditResults(String sObjectName, Id recordId){
        Map<String, String> sObjectNames = retrieveChildObjects(sObjectName);
        Map<String, Integer> counter = new Map<String, Integer>();
        String query = 'SELECT Id ';
        for (String relatedObjectName : sObjectNames.keySet()) {
            query += ', (SELECT Id FROM ' + relatedObjectName + ')';
        }
        query += ' FROM '+ sObjectName +' WHERE Id = \'' + recordId + '\'';
        Sobject obj = Database.query(query);
        for (String relatedObjectName : sObjectNames.keySet()) {
            List<SObject> childObjects =  obj.getSObjects(relatedObjectName);
            counter.put(sObjectNames.get(relatedObjectName), childObjects == null ? 0 : childObjects.size());
        }
        return counter;
    }

    private static Map<String, String> retrieveChildObjects(String sObjectName) {
        Map<String, String> sObjectNames = new Map<String, String>();
        try {
            MetadataHelper helper = new MetadataHelper(sObjectName);
            sObjectNames = helper.getRelatedObjectNames();
        } catch (CalloutException exc) {
            throw new AuraHandledException('Please, check Named Credentials configuration. Cannot access Salesforce Metadata API');
        } catch (CustomException exc) {
            throw new AuraHandledException(exc.getMessage());
        }
        return sObjectNames;
    }


}
