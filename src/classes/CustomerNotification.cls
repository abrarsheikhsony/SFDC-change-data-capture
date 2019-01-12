// Notify Customer for SMS alerts
public with sharing class CustomerNotification {

    // Notify subscribers on account updates.
    // This method is run asynchronously as it is performing a callout to the external
    // system to get the latest product details
    @future (callout=true)
    public static void notifySubscribers(Set<Id> accountIds) {
        // Get the Account records
        
        // Do callout: Notify subscribers to send SMS alert to updated Customer(s)

    }

}