({
    doInit : function(component, event, helper) {
        
        // Get the empApi component.
        var empApi = component.find("empApi");

        // Get the channel from the input box.
        var channel = '/data/';

        var sObjectName = component.get('v.sObjectName');
        if (sObjectName.endsWith('__c')) {
            // Custom object
            channel = channel + sObjectName.substring('0', sObjectName.length-3) + '__ChangeEvent';
        }
        else {
            // Standard object
            channel = channel + sObjectName + 'ChangeEvent';
        }
        
        channel = '/data/Employee__ChangeEvent';
        
        var replayId = '-1';
        
        // Callback function to be passed in the subscribe call.
        // After an event is received, this callback prints the event
        // payload to the console.
        var callback = function (message) {
            console.log("Received [" + message.channel +
                " : " + message.data.event.replayId + "] payload=" +
                JSON.stringify(message.data.payload));
            
            // ChangeEventHeader fields
            var entityName = message.data.payload.ChangeEventHeader.entityName;
            var modifiedRecords = message.data.payload.ChangeEventHeader.recordIds;
            var changeType = message.data.payload.ChangeEventHeader.changeType;
            var changeOrigin = message.data.payload.ChangeEventHeader.changeOrigin;
            var transactionKey = message.data.payload.ChangeEventHeader.transactionKey;
            var sequenceNumber = message.data.payload.ChangeEventHeader.sequenceNumber;
            var isTransactionEnd = message.data.payload.ChangeEventHeader.isTransactionEnd;
            var commitTimestamp = message.data.payload.ChangeEventHeader.commitTimestamp;
            var commitUser = message.data.payload.ChangeEventHeader.commitUser;
            var commitNumber = message.data.payload.ChangeEventHeader.commitNumber;
			
            // SObject Modified fields
            var employeeRecordID = message.data.payload.ChangeEventHeader.recordIds[0];
            var employeeName = message.data.payload.Name;
            var First_Name__c = message.data.payload.First_Name__c;
            var Last_Name__c = message.data.payload.Last_Name__c;
            var Tenure__c = message.data.payload.Tenure__c;
            var CreatedDate = message.data.payload.CreatedDate;
            var CreatedById = message.data.payload.CreatedById;
            var LastModifiedDate = message.data.payload.LastModifiedDate;
            var OwnerId = message.data.payload.OwnerId;
            
            var currentRecordId = component.get('v.recordId');
            var userId = $A.get("$SObjectType.CurrentUser.Id")
			
            // Show Pop-Up Message
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                //"message": "Change Event Received: "+employeeName+" "+entityName+" "+changeType+" "+changeOrigin+" "+transactionKey+" "+sequenceNumber+" "+isTransactionEnd+" "+commitTimestamp+" "+commitUser+" "+commitNumber,
                "title": entityName+" Change Event",
                "message": entityName+" record received: "+"Change Type: "+changeType+" ,ID: "+employeeRecordID+" ,First Name: "+First_Name__c+" ,Last Name: "+Last_Name__c+" ,Tenure: "+Tenure__c+" ,at: "+LastModifiedDate,
                "type": "success",
                "mode": "sticky"
            });
            toastEvent.fire();
            
            if (modifiedRecords.includes(currentRecordId)) {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    //"message": "Someone else modified the record you're viewing!",
                    "message": "Message! "+entityName+" "+changeType+" "+changeOrigin+" "+transactionKey+" "+sequenceNumber+" "+isTransactionEnd+" "+commitTimestamp+" "+commitUser+" "+commitNumber,
                    "type": "warning",
                    "mode": "sticky"
                });
                toastEvent.fire();
            }
        }.bind(this);

        // Error handler function that prints the error to the console.
        var errorHandler = function (message) {
            console.log("Received error ", message);
        }.bind(this);

        // Register error listener and pass in the error handler function.
        empApi.onError(errorHandler);

        // Subscribe to the channel and save the returned subscription object.
        empApi.subscribe(channel, replayId, callback).then(function(value) {
            console.log("Subscribed to channel " + channel);
        });
    }
})