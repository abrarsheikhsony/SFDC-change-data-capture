require(['dojo/ready', 'dojox/cometd', 'dojo/dom', 'dojo', 'dojo/query'], function(ready){
  ready(function(){

    dojo.removeClass('join', 'hidden');
    dojo.addClass('joined', 'hidden');

    var channel = null;
    var connected = false;
    var topicsubscription = false;    
    var cometd = dojox.cometd;

    function metaConnectListener(message) {
        var wasConnected = connected;
        connected = message.successful;
        if (!wasConnected && connected) {                
		display('DEBUG: Connection Successful : '+JSON.stringify(message)+'<br>');                                    
        } else if (wasConnected && !connected) {
                display('DEBUG: Disconnected from the server'+JSON.stringify(message)+'<br>');
        }
    }

    function metaHandshakeListener(message) {
        if (message.successful) {
            display('<br> DEBUG: Handshake Successful: '+JSON.stringify(message)+' <br>');
        } else {
            display('DEBUG: Handshake Unsuccessful: '+JSON.stringify(message)+' <br>');
        }
    }

    function metaDisconnectListener(message) {
        display('DEBUG: /meta/disconnect message: '+JSON.stringify(message)+' <br>');
    }

    function metaSubscribeListener(message) {  
        if (message.successful) {
            display('DEBUG: Subscribe Successful '+channel+': '+JSON.stringify(message)+' <br>');
	    dojo.addClass('join', 'hidden');
	    dojo.removeClass('joined', 'hidden');
        } else {
            display('DEBUG: Subscribe Unsuccessful '+channel+': '+JSON.stringify(message)+' <br>');                
        }    
    };

    function metaUnSubscribeListener(message) {  
        if (message.successful) {
            display('DEBUG: Unsubscribe Successful '+JSON.stringify(message)+' <br>');
	    dojo.removeClass('join', 'hidden');
	    dojo.addClass('joined', 'hidden');
        } else {
            display('DEBUG: Unsubscribe Unsuccessful '+JSON.stringify(message)+' <br>');                
        }
    };

    function metaUnSucessfulListener(message) {  
        display('DEBUG:  /meta/unsuccessful Error: '+JSON.stringify(message)+' <br>');
    };

    function subscribe(topic) {  
        if(connected) {
	    if (topic == null || name.topic == 0) {
	        display('<br>Please enter a topic<br>');
	        return;
	    }	
	    channel = topic;
	    topicsubscription = cometd.subscribe(channel, receive);	
        } else {
            display('<br>DEBUG: Cannot subscribe due to unsuccessful connection<br>');
        }                
    }

    function unsubscribe() {
        if(topicsubscription) {
            cometd.unsubscribe(topicsubscription);
        }
        topicsubscription = null;
    }

    function leave() {
        unsubscribe();
     
        // switch the input form
        dojo.removeClass('join', 'hidden');
        dojo.addClass('joined', 'hidden');
    
        dojo.byId('topic').focus();
    
        channel = null;
    }

    dojo.query('#subscribeButton').onclick(function(e) {
        subscribe(dojo.byId('topic').value);
    }); 
    
    dojo.query('#leaveButton').onclick(function(e) {
        leave();
    });

    function receive(message) {
        var datastream = dojo.byId('datastream');
        data = message.data; 
        datastream.innerHTML += '<span class=\'text\'>' + JSON.stringify(data, null, '\t') + '</span><br/>';
        datastream.innerHTML += '<span class=\'text\'>' + '_____________ ' + '</span><br/><br/>';
        datastream.scrollTop = datastream.scrollHeight - datastream.clientHeight;
    }

    function display(text) {
        var datastream = dojo.byId('datastream');
        datastream.innerHTML += '<span class=\'data\'><span class=\'text\'>' + text + '</span></span><br/>';
        datastream.scrollTop = datastream.scrollHeight - datastream.clientHeight;
    }
    
    cometd.websocketEnabled = false;
    var auth = 'OAuth ' + token;
    var cometdURL = window.location.protocol+'//'+window.location.hostname+ (null != window.location.port ? (':'+window.location.port) : '') +'/cometd/40.0/';

    cometd.configure({
        url: cometdURL,
        requestHeaders: { Authorization: auth}
    });

    cometd.addListener('/meta/connect', metaConnectListener);

    cometd.addListener('/meta/handshake', metaHandshakeListener);

    cometd.addListener('/meta/disconnect', metaDisconnectListener);

    cometd.addListener('/meta/subscribe', metaSubscribeListener);

    cometd.addListener('/meta/unsubscribe', metaUnSubscribeListener);

    cometd.addListener('/meta/unsuccessful', metaUnSucessfulListener);

    cometd.handshake();	
  });
});
