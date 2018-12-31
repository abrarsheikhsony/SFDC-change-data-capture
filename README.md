# Change Data Capture (CDC)

## Introduction
<ul>

<li>Starting with <a href="https://releasenotes.docs.salesforce.com/en-us/winter19/release-notes/rn_data_change_events.htm" target="_blank" alt="Winter '19 (API version 44.0) release">Winter '19 (API version 44.0) release</a>, Change Data Capture (CDC) was Developer Preview "or" Pilot feature.</li>

<li>Starting with <a href="https://releasenotes.docs.salesforce.com/en-us/spring19/release-notes/rn_data_change_events.htm" target="_blank" alt="Spring '19 (API version 45.0) release">Spring '19 (API version 45.0) release</a>, Change Data Capture (CDC) is Generally Available (GA).</li>

<li>Change Data Capture is a Streaming Event feature on the Lightning Platform.</li>

<li>Change Data Capture uses the Publisher/Subscriber model and Push technology.</li>

<li>Change Data Capture sends notifications to subscribers whenever a data change in Salesforce occurs.</li>

<li>Change Data Capture publishes events for changes in Salesforce records corresponding to <b>Create, Update, Delete, and Undelete operations.</b></li>

<li>You can receive changes of Salesforce records in real time and synchronize corresponding records in an external data store.</li>

</ul>

## When to Use Change Data Capture
<ul>
<li>Use Change Data Capture to update data in an external system instead of doing periodic exports or API polling.</li>
<li>Capturing changes with Change Data Capture event notifications ensures that your external data can be updated in real time and stays fresh.</li>
<li>You can use Change Data Capture as part of the data replication process.</li>
<li>Capture all field changes for all records.</li>
<li>Get information about the change in the event header, such as the origin of the change, so you can ignore changes that your client generates.</li>
<li>Perform data updates using transaction boundaries when more than one operation is part of the same transaction.</li>
<li>Use a versioned event schema.</li>
<li>Subscribe to mass changes in a scalable way.</li>
<li>Get access to retained events for up to 3 days.</li>
</ul>

## Supported Objects
<ul>
<li>Custom Objects</li>
<li>Standard Objects: User, Lead, Account, Contact, Order, OrderItem, Product2, and others.</li>
</ul>

## Sample Change Event JSON
<ul>
<li>

```
{
	"schema":"TIOb-jG_qRb2ucSBIdByMA",
	"payload":{
		"ChangeEventHeader":{
			"entityName":"Employee__c",
			"recordIds":[
				"a00xx0000004GvqAAE"
			],
			"changeType":"CREATE",
			"changeOrigin":"com/salesforce/api/soap/44.0;client=GetCloudy",
			"transactionKey":"00059b44-a6c7-ffa7-af68-8a455868ed30",
			"sequenceNumber":1,
			"isTransactionEnd":true,
			"commitTimestamp":1533160499000,
			"commitUser":"005xx000001SwSiAAK",
			"commitNumber":356619267
		},
		"First_Name__c":"Jane",
		"Last_Name__c":"Smith",
		"Name":"e-100",
		"Tenure__c":2.0,     
		"LastModifiedDate":"2018-08-01T21:54:58Z",
		"OwnerId":"005xx000001SwSiAAK",
		"CreatedById":"005xx000001SwSiAAK",
		"CreatedDate":"2018-08-01T21:54:58Z",
		"LastModifiedById":"005xx000001SwSiAAK",
	},
	"event":{
		"replayId":1
	}
}
```
</li>

<li>changeType: CREATE, UPDATE, DELETE, UNDELETE</li>
<li>changeOrigin: Use this field to detect whether your app initiated the change, so you do not process the change again and potentially avoid a deep cycle of changes. This field contains the Salesforce API and the API client ID that initiated the change, if set by the client.</li>
<li>Note: In the example, it is com/salesforce/api/soap/44.0;client=GetCloudy, which means that an app with clientID GetCloudy created the Employee record via SOAP API.</li>
<li>The order of the fields in the JSON event message follows the underlying <b>Avro schema</b> that Change Events are based on.</li>

</ul>

## Subscribe to an Event Channel using a Lightning Component
<ul>
<li>Reference from the <a href="https://developer.salesforce.com/docs/atlas.en-us.218.0.api_streaming.meta/api_streaming/code_sample_lightning_cmp.htm" target="_blank" alt="Streaming API Developer Guide">Streaming API Developer Guide</a>.</li>
<li>The <a href="https://developer.salesforce.com/docs/component-library/bundle/lightning:empApi/documentation" target="_blank" alt="lightning:empApi component">lightning:empApi component</a> uses a shared CometD-based Streaming API connection, enabling you to run multiple streaming apps in the browser.</li>
<li>To call the component’s methods, add the lightning:empApi component inside your custom component and assign an aura:id
attribute to it.</li>
<li><img src="supportedimages/Lightning_empApi.png"/></li>
<li>Then in the client-side controller, add functions to call the component methods.</li>
</ul>

## Subscription Channels
Reference from the <a href="https://trailhead.salesforce.com/content/learn/modules/change-data-capture/learn-change-data-capture-characteristics" target="_blank" alt="Trailhead: Learn Change Data Capture Characteristics">Trailhead: Learn Change Data Capture Characteristics</a>.
<img src="supportedimages/SubscriptionChannels.png"/>

## Field-Level Security
Change Data Capture respects org’s field-level security settings. Delivered events contain only the fields that a subscribed user is allowed to view. 

## Required User Permissions
<ul>
<li>
Reference from the <a href="https://trailhead.salesforce.com/content/learn/modules/change-data-capture/learn-change-data-capture-characteristics" target="_blank" alt="Trailhead: Learn Change Data Capture Characteristics">Trailhead: Learn Change Data Capture Characteristics</a>.
<img src="supportedimages/RequiredUserPermissions.png"/>
</li>
<li>User permissions are enforced when the user subscribes to a channel. If the user has insufficient permissions, the user can’t subscribe to the channel and an error is returned.</li>
</ul>

## Example: Subscribe to an Event Channel
<ul>
<li>Change Data Capture in Setup <img src="supportedimages/ChangeDataCaptureInSetup.png"/></li>
<li>Subscribe to Channel: /data/Employee__ChangeEvent</li>
<li></li>
<li></li>
<li></li>
<li></li>
</ul>

## Useful Resources
<ul>

<li><a href="https://success.salesforce.com/_ui/core/chatter/groups/GroupProfilePage?g=0F93A000000HTvs" target="_blank" alt="Partner Community Group: Change Data Capture">Partner Community Group: Change Data Capture</a></li>

<li><a href="https://trailhead.salesforce.com/content/learn/modules/change-data-capture" target="_blank" alt="Trailhead: Change Data Capture Basics">Trailhead: Change Data Capture Basics</a></li>

<li><a href="https://developer.salesforce.com/docs/atlas.en-us.218.0.change_data_capture.meta/change_data_capture/cdc_intro.htm" target="_blank" alt="Change Data Capture Developer Guide">Change Data Capture Developer Guide</a></li>

<li><a href="https://developer.salesforce.com/blogs/2018/08/what-is-change-data-capture.html" target="_blank" alt="Salesforce Blog: What is Change Data Capture?">Salesforce Blog: What is Change Data Capture?</a></li>

<li><a href="https://www.youtube.com/watch?v=JEQZhZYZYPg" target="_blank" alt="YouTube: Change Data Capture -Not Your Average Data Synchronization">YouTube: Change Data Capture -Not Your Average Data Synchronization</a></li>

<li><a href="https://www.youtube.com/watch?v=v_hQyUZzLsA" target="_blank" alt="YouTube: Change Data Capture: Data Synchronization in the Cloud">YouTube: Change Data Capture: Data Synchronization in the Cloud</a></li>

<li><a href="https://www.salesforce.com/video/1111054/" target="_blank" alt="Salesforce Video: Change Data Capture: Not Your Average Data Synchronization">Salesforce Video: Change Data Capture: Not Your Average Data Synchronization</a></li>

<li><a href="https://www.salesforce.com/video/1778488/" target="_blank" alt="Salesforce Video: Why Subscribing To Change Data Capture Event Is Better Than Polling For Data">Salesforce Video: Why Subscribing To Change Data Capture Event Is Better Than Polling For Data</a></li>

<li><a href="https://mohan-chinnappan-n.github.io/sfdc/cdc.html#/home" target="_blank" alt="GitHub: Salesforce Change Data Capture">GitHub: Salesforce Change Data Capture</a></li>

</ul>

<ol type="1">
<li></li>
</ol>
