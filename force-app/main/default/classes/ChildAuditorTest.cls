@isTest
private class ChildAuditorTest {

    private static final Integer CHILD_NUMBER = 10;

    @TestSetup
    static void makeData(){
        Account account = TestDataUtils.createAccount();
        insert account;
        List<Contact> contacts = TestDataUtils.createContacts(account, CHILD_NUMBER);
        insert contacts;
    }

    @isTest
    static void test_GetAuditResults_Positive() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        Map<String, Integer> results;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MetadataAPIMock());
        results = ChildAuditorController.getChildAuditResults('Account', account.Id);
        Test.stopTest();

        System.assert(results.keySet().contains('Contacts'), 'Contacts statistics must be calculated for this account.');
    }

    @isTest
    static void test_GetAuditResults_Negative() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        Map<String, Integer> results;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MetadataAPIMock());
        try {
            results = ChildAuditorController.getChildAuditResults('Account', 'blabla');
            System.assert(false);
        } catch(Exception exc) {
            System.assert(exc.getMessage().contains('Invalid id'));
        }
        Test.stopTest();
    }


    public class MetadataAPIMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"layouts":[{"relatedLists":[{"name":"Contacts","label":"Contacts"}]}]}');
            res.setStatusCode(200);
            return res;
        }
    }
}
