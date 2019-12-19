/*
 * Data utility class for Test classes
 *
 * @author Paul Drozd
 * @since 19-12-2019
 */
public with sharing class TestDataUtils {
    
    public static Account createAccount() {
        Account account = new Account();
        account.Name = 'TestAccount';
        return account;
    }

    public static Contact createContact(Account account, String name) {
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Test';
        contact.LastName = name;
        return contact;
    }  

    public static List<Contact> createContacts(Account account, Integer num) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < num; i++) {
            contacts.add(createContact(account, String.valueOf(i)));
        }
        return contacts;
    }
}
