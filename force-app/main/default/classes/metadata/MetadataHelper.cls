/*
 * Helper class for working with Salesforce Metadata API
 * Utilizes named credentials to access APIs
 *
 * @author Paul Drozd
 * @since 19-12-2019
 */
public with sharing class MetadataHelper {

    private String baseURL;
    private String sObjectName;

    public MetadataHelper(String sObjectName) {
        baseURL = URL.getSalesforceBaseUrl().toExternalForm();
        this.sObjectName = sObjectName;
    }

    public Map<String, String> getRelatedObjectNames() {
        Layouts layoutMeta = this.getLayouts();
        Map<String, String> sObjectNames = new Map<String, String>();
        if (layoutMeta.layouts != null && !layoutMeta.layouts.isEmpty()) {
            for (Layouts.RelatedLists relatedList : layoutMeta.layouts[0].relatedLists) {
                sObjectNames.put(relatedList.Name, relatedList.label);
            }
        } else {
            throw new CustomException('This SObject does not have defined layouts. Please, create at least one.');
        }
        return sObjectNames;
    }

    public Layouts getLayouts() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:ApexMDAPI/services/data/v43.0/sobjects/'+sObjectName+'/describe/layouts');
        request.setMethod('GET');
        HttpResponse response = (new Http()).send(request);
        System.debug(LoggingLevel.ERROR, '>>>\n'+response.getBody());
        return (Layouts) JSON.deserialize(response.getBody(), Layouts.class);
    }
}
