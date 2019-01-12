// To automate your business logic using change events Apex triggers.
// Change Event Trigger for Account object
trigger AccountChangeEventTrigger on AccountChangeEvent (after insert) {

    // Get the Account Ids of Change Event for added and updated Accounts
    Set<Id> accountIds = new Set<Id>();
    for (AccountChangeEvent event : Trigger.new) {
        System.Debug('>>Received Change Event<<');

        System.Debug('>>EntityName<<'+event.ChangeEventHeader.getEntityName());
        System.Debug('>>ChangeOrigin<<'+event.ChangeEventHeader.getChangeOrigin());
        System.Debug('>>ChangeType<<'+event.ChangeEventHeader.getChangeType());
        System.Debug('>>RecordIds<<'+event.ChangeEventHeader.getRecordIds());
        System.Debug('>>TransactionKey<<'+event.ChangeEventHeader.getTransactionKey());
        //System.Debug('>>IsTransactionEnd<<'+event.ChangeEventHeader.getIsTransactionEnd());
        System.Debug('>>SequenceNumber<<'+event.ChangeEventHeader.getSequenceNumber());
        System.Debug('>>CommitTimestamp<<'+event.ChangeEventHeader.getCommitTimestamp());
        System.Debug('>>CommitUser<<'+event.ChangeEventHeader.getCommitUser());
        System.Debug('>>CommitNumber<<'+event.ChangeEventHeader.getCommitNumber());
        System.Debug('>>NulledFields<<'+event.ChangeEventHeader.getnulledFields());
        System.Debug('>>Difffields<<'+event.ChangeEventHeader.getdifffields());

        // Get Account record fields
        System.Debug('>>Account Name<<'+event.Name);
        System.Debug('>>Account Phone<<'+event.Phone);
        System.Debug('>>Account AccountNumber<<'+event.AccountNumber);
        
        accountIds.add( event.ChangeEventHeader.getRecordIds()[0] );
    }
    if (accountIds.size() > 0) {
        // Notify subscribers to send SMS alert to updated Customer(s)
        CustomerNotification.notifySubscribers(accountIds);
    }

    /*
    // Debug Log Sample
    >>Received Change Event<<
    >>EntityName<<Account
    >>ChangeOrigin<<
    >>ChangeType<<CREATE
    >>RecordIds<<(0011t00000FOZZ8AAP)
    >>TransactionKey<<000e2071-e1b0-f23a-8b15-ded2e35785ab
    >>SequenceNumber<<1
    >>CommitTimestamp<<1547332370000
    >>CommitUser<<0051t000001pGyuAAE
    >>CommitNumber<<153213751644
    >>NulledFields<<()
    >>Difffields<<()
    >>Account Name<<Marc Benioff
    >>Account Phone<<(415) 901-8000
    >>Account AccountNumber<<9001
    */

}