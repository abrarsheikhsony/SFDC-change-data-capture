// To automate your business logic using change events Apex triggers.
// Change Event Trigger for Employee__c object
trigger EmployeeChangeEventTrigger on Employee__ChangeEvent (after insert) {

    for (Employee__ChangeEvent event : Trigger.new) {
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
        System.Debug('>>Employee Comments<<'+event.Comments__c);
    }

    /*
    Debug Log Sample
    (1) CREATE
    >>EntityName<<Employee__c
    >>ChangeOrigin<<
    >>ChangeType<<CREATE
    >>RecordIds<<(a011t00000BGGAfAAP)
    >>TransactionKey<<000e2097-7e37-1234-6111-538921235290
    >>SequenceNumber<<1
    >>CommitTimestamp<<1547332531000
    >>CommitUser<<0051t000001pGyuAAE
    >>CommitNumber<<153214623592
    >>nulledFields<<()
    >>difffields<<()
    >>Employee FirstName<<Marc
    >>Employee LastName<<Benioff
    >>Employee Tenure<<18.0

    (2) UPDATE
    >>EntityName<<Employee__c
    >>ChangeOrigin<<
    >>ChangeType<<UPDATE
    >>RecordIds<<(a011t00000BGGAfAAP)
    >>TransactionKey<<000e20b7-d0b6-e65f-783b-bfdd9988f3cc
    >>SequenceNumber<<1
    >>CommitTimestamp<<1547332669000
    >>CommitUser<<0051t000001pGyuAAE
    >>CommitNumber<<153215384788
    >>nulledFields<<()
    >>difffields<<()
    >>Employee FirstName<<Marc 2
    >>Employee LastName<<Benioff 2
    >>Employee Tenure<<20.0

    (3) DELETE
    >>EntityName<<Employee__c
    >>ChangeOrigin<<
    >>ChangeType<<DELETE
    >>RecordIds<<(a011t00000BGGAfAAP)
    >>TransactionKey<<000e20d5-2f5c-3cab-7244-82e466a77ee7
    >>SequenceNumber<<1
    >>CommitTimestamp<<1547332793000
    >>CommitUser<<0051t000001pGyuAAE
    >>CommitNumber<<153216038466
    >>nulledFields<<()
    >>difffields<<()
    >>Employee FirstName<<null
    >>Employee LastName<<null
    >>Employee Tenure<<null

    (4) UNDELETE
    >>EntityName<<Employee__c
    >>ChangeOrigin<<
    >>ChangeType<<UNDELETE
    >>RecordIds<<(a011t00000BGGAfAAP)
    >>TransactionKey<<000e20ee-b061-73d3-4530-6b9729d3e1be
    >>SequenceNumber<<1
    >>CommitTimestamp<<1547332900000
    >>CommitUser<<0051t000001pGyuAAE
    >>CommitNumber<<153216648041
    >>nulledFields<<()
    >>difffields<<()
    >>Employee FirstName<<Marc 2
    >>Employee LastName<<Benioff 2
    >>Employee Tenure<<20.0
    */

}