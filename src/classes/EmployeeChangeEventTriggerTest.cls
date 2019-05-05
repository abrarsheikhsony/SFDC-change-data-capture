@isTest
public class EmployeeChangeEventTriggerTest {

    @isTest static void testNewEmployee() {
        // Enable all Change Data Capture entities for notifications.
        Test.enableChangeDataCapture();

        // Insert an Employee to generate a change event.
        Employee__c employee = new Employee__c();
        employee.First_Name__c = 'Marc';
        employee.Last_Name__c = 'Benioff';
        employee.Tenure__c = 20;
        employee.Comments__c = 'Salesforce CEO';
        insert employee;
        
        // Call deliver to fire the trigger and deliver the test change event.
        Test.getEventBus().deliver();
        


        //Alternative approach
        //Test.startTest();
        // Insert an Employee to generate a change event.
        //Test.stopTest();
        // The stopTest() call fires the trigger with the test Employee change event.



        // VERIFICATIONS
        List<Employee__c> lstEmployees = [SELECT Id, First_Name__c, Last_Name__c, Tenure__c, Comments__c 
                                        FROM Employee__c];
        System.assertEquals(1, lstEmployees.size());
    }

}