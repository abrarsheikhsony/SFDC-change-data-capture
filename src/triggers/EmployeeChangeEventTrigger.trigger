// To automate your business logic using change events Apex triggers.
// Change Event Trigger for Employee__c object
trigger EmployeeChangeEventTrigger on Employee__ChangeEvent (after insert) {

    for (Employee__ChangeEvent event : Trigger.new) {
        System.Debug('>>Received Change Event<<');

        // Get Change Event Header fields
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        System.Debug('>>Received Change Event<<');

        System.Debug('>>EntityName<<'+header.entityName);
        System.Debug('>>ChangeOrigin<<'+header.changeOrigin);
        System.Debug('>>ChangeType<<'+header.changeType);
        System.Debug('>>RecordIds<<'+header.recordIds);
        System.Debug('>>TransactionKey<<'+header.transactionKey);
        //System.Debug('>>IsTransactionEnd<<'+header.isTransactionEnd);
        System.Debug('>>SequenceNumber<<'+header.sequenceNumber);
        System.Debug('>>CommitTimestamp<<'+header.commitTimestamp);
        System.Debug('>>CommitUser<<'+header.commitUser);
        System.Debug('>>CommitNumber<<'+header.commitNumber);
        System.Debug('>>nulledFields<<'+header.nulledFields);
        System.Debug('>>difffields<<'+header.difffields);

        // Get Employee record fields
        System.Debug('>>Employee FirstName<<'+event.First_Name__c);
        System.Debug('>>Employee LastName<<'+event.Last_Name__c);
        System.Debug('>>Employee Tenure<<'+event.Tenure__c);
    }
    
}