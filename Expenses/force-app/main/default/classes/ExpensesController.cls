public with sharing class ExpensesController {
       @AuraEnabled
    public static List<Expense__c> getExpenses() {
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {
            'Id', 'Name', 'Amount__c', 'Client__c', 'Date__c',
            'Reimbursed__c', 'CreatedDate'
        };
        Map<String,Schema.SObjectField> fieldDescribeTokens =
            Schema.SObjectType.Expense__c.fields.getMap();
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        // OK, they're cool, let 'em through
        return [SELECT Id, Name, Amount__c, Client__c, Date__c,
                       Reimbursed__c, CreatedDate
                FROM Expense__c];
    }
  
        @AuraEnabled
   public static String generateRandomString(Integer len) {
    final String chars = '0123456789abcdef';
    String traceidStr = '';
    while (traceidStr.length() < len) {
       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
       traceidStr += chars.substring(idx, idx+1);
    }
    return traceidStr; 
}


    
   
    
    
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdateable() checking first, then
        // 
        // Code to call API and update Trace
        // Set up JSON
        // 
            JSONGenerator gen = JSON.createGenerator(true);    
            // String AZjson=        '['+   

        gen.writeStartObject();
        gen.writeNumberField('id', 1.21);
        gen.writeStringField('name', 'tsak1');
        gen.writeBooleanField('isComplete', true);
        gen.writeEndObject();
        String AZjson = gen.getAsString();
        
        
        // Generate New Relic Header
        
           //Generate our own newrelic header
           //
           //
          
        //////////
        String Zipkinjson=    '   '; 
        String ZipkinjsonE2=    '   '; 
        String ZipkinjsonE3=    '   '; 
        String ZipkinjsonE4=    '   '; 
        String ZipkinjsonE5=    '   '; 
        String ZipkinjsonE6=    '   '; 
        
        String NewRelicEvent=    '   '; 
        String NewRelicLog=    '   '; 
        String Zipkinjson2=    '   '; 
        
        String payload=' ';
        integer iTraceLength = 32;
       String sTraceID = generateRandomString(iTraceLength);  
      
       integer iSpanIDLength = 16;
       String sSpanID = generateRandomString(iSpanIDLength); 
       String sSpanIDE2 = generateRandomString(iSpanIDLength); 
       String sSpanIDE3 = generateRandomString(iSpanIDLength); 
       String sSpanIDE4 = generateRandomString(iSpanIDLength); 
       String sSpanIDE5 = generateRandomString(iSpanIDLength); 
       String sSpanIDE6 = generateRandomString(iSpanIDLength); 
      
       
       
       // Get a fake CorrelationID
       String sCorrelationID = generateRandomString(iTraceLength);  
       
       DateTime dt = DateTime.newInstance(2007, 6, 23, 3, 3, 3);
      Long currentTimeMill = dt.getTime();
  
       decimal iPr= 1.073175;
       boolean bSa = true;
       
          String headerDT = '{\n' +
        '\"d\": {\n' +
       '\"ac\": \"798156\",\n' +
       '\"pr\": 1.073175,\n' +
       '\"tx\": \"'+sTraceID+ '\",\n' +
       '\"ti\": '+ currentTimeMill + ',\n'+
       '\"ty\": \"App\",\n'      +
       '\"tk\": \"798156\",\n' +
       '\"id\": \"'+sSpanID+ '\",\n' +
       '\"tr\": \"'+sTraceID+ '\",\n' +  
       '\"sa\": true,\n' +  
       '\"ap\": \"6918692772\"\n' +
    '},\n' +      
    '\"v\": [0,1]\n' +
'}';

    
          Map<String, Object> NewRelicHeaderTraceDetails = new Map<String, Object>{
            'ac' => '798156',
            'pr' => iPr,
            'tx' => sTraceID,
            'ti' => currentTimeMill,
            'ty' => 'App',
            'tk' => '798156',
            'id' => sSpanID,
            'tr' => sTraceID,
            'sa' => bSa,
            'ap' => '6918692772'       
        };
        
        Map<String, Object> NewRelicHeaderMap = new Map<String, Object>{
            'v' => 'xxxx',
            'd:' => NewRelicHeaderTraceDetails
        };
        
        
        string headerDTfromMAP = JSON.serializePretty(NewRelicHeaderMap);
        headerDTfromMAP = headerDTfromMAP.replace ('v: "xxxx"', '\"v\": [0,1]\n');
        System.debug('NEWRELIC HEADER FROM MAP JSON: '+ headerDTfromMAP); 
        
        
        string correlationId = '232323';
        Boolean success = true;        
              
    
        System.debug('Newrelic Header: '+ headerDT); 
       
  

    // create a blob from our parameter value before we send it as part of the url
    Blob NRHeaderblob = Blob.valueOf(headerDT);
    
    // create blob from headerMAP
    Blob NRHeaderblobMAP = Blob.valueOf(headerDTfromMAP);
   
    // base64 encode the blob that contains our url param value
    string NRHeader = EncodingUtil.base64Encode(NRHeaderblob);
    string NRHeaderMAP = EncodingUtil.base64Encode(NRHeaderblobMAP);
   
    System.debug('Newrelic Header: '+ NRHeader); 
    System.debug('Newrelic Meader: '+ NRHeaderMAP); 
        
    long lDuration = 0;
    long requestTimeMill = dt.getTime();
        
    
    System.debug('Request Time - ' + requestTimeMill);        
 
        // Instantiate a new http object
        Http AZhttp = new Http();
        // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
        HttpRequest AZreq = new HttpRequest(); 
        AZreq.setEndpoint('https://testapiapptk.azurewebsites.net/api/Todo');
        // Send Header in newrelic and wc3 format for legacy compatability
        //AZreq.setHeader('newrelic', NRHeader);
        AZreq.setHeader('traceparent', '00-'+ sTraceID + '-' + sSpanID +'-01');
        AZreq.setHeader('correlationid', 'XXXXXXYYYYYYYY');
        AZreq.setHeader('mediatest', 'MEDIA TEST ATTRIBUTE');
        
        System.debug('traceparent: 00-'+ sTraceID + '-' + sSpanID +'-01'); 
        
        AZreq.setMethod('POST');
        
       
        try {  
        
        // Send the request, and return a response
         // Calculate Duration
       
        HttpResponse AZres =  AZhttp.send(AZreq); 
        String sResponseBody = AZres.getBody();
        String sResponseStatus= AZres.getStatus();
        Integer iStatusCode = AZres.getStatusCode();
    
        if(iStatusCode == 200){
        System.debug('No Error');
        
          Map<String, Object> localEndpointMap = new Map<String, Object>{
            'serviceName' => 'DaVinci',
            'ipv4' => 'newrelic-e-dev-ed.my.salesforce.com',
            'port' => 8080
        };
       
        
        
        Map<String, Object> tagsMap = new Map<String, Object>{
            'TelstraCorrelationID' => correlationId,
            'statusCode' => iStatusCode,
            'success' => success
        };

        Map<String, Object> headersMap = new Map<String, Object>{
            'traceId' => sTraceID,
            'id' => sSpanID,
            'kind' => 'SERVER',
            'name' => 'Salesforce Call RTCA API',
            'localEndpoint' => localEndpointMap,
            'tags' => tagsMap
        };    
        List<Object> headerList = new List<Object>();
        headerList.add(headersMap);
        

        payload = JSON.serializePretty(headersMap);
        payload = '[\n' + payload + '\n]';
       
        
        
        System.debug('MAP JSON: '+ payload); 
        
        Zipkinjson=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanID + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "IAG CLAIM Transaction",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "SalesForce",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "PhoneType": "iPhone X"\n'+
       '  }\n'+
       '}\n'+
       ']';
   
       System.debug('ZipKinJSON: ' + Zipkinjson );  
   
       

}
   else{
   
 
 
  String sParentSpanID = '12345';
     
        Map<String, Object> localEndpointMap = new Map<String, Object>{
            'serviceName' => 'DaVinci',
            'ipv4' => 'newrelic-e-dev-ed.my.salesforce.com',
            'port' => 8080
        };
       
        
        
        Map<String, Object> tagsMap = new Map<String, Object>{
            'TelstraCorrelationID' => correlationId,
            'statusCode' => iStatusCode,
            'success' => success,
             'error.code' => iStatusCode,
             'error.message' => sResponseStatus
        };

        Map<String, Object> headersMap = new Map<String, Object>{
            'traceId' => sTraceID,
            'id' => sSpanID,
            'kind' => 'SERVER',
            'name' => 'Salesforce Call RTCA API',
            'localEndpoint' => localEndpointMap,
            'tags' => tagsMap
        };   
        if (!String.isEmpty(sParentSpanID)) {
            headersMap.put('parentId', sParentSpanID);           
        } 
   

        payload = JSON.serializePretty(headersMap);
        payload = '[\n' + payload + '\n]';
       
        
        
        System.debug('MAP JSON: '+ payload); 
        lDuration = 10000;
   
   Zipkinjson=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanID + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "GUIDEWIRE Transaction",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "SalesForce",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534"\n'+
        '  }\n'+
       '}\n'+
       ']';
       
        lDuration = 20000;
       ZipkinjsonE2=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanIDE2 + '",\n' +
       '               "parentId": "' + sSpanID + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "APIGEE",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "APIGEE",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534"\n'+
       '  }\n'+
       '}\n'+
       ']';
   
       System.debug('ZipKinJSON: ' + ZipkinjsonE2 );  
       
        lDuration = 15000;
       ZipkinjsonE3=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanIDE3 + '",\n' +
       '               "parentId": "' + sSpanIDE2 + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "SalesForce",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "GUIDEWIRE",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534",\n'+
       '    "error.code": ' + iStatusCode + ',\n'+
       '    "otel.status_code": "ERROR",\n' +
       '    "error.message": "' + sResponseStatus + '"\n'+     
       '  }\n'+
       '}\n'+
       ']';
   
       System.debug('ZipKinJSON: ' + ZipkinjsonE3 );  
       
        lDuration = 30000;
       ZipkinjsonE4=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanIDE4 + '",\n' +
       '               "parentId": "' + sSpanIDE5 + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "CLP-CLAIM",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "CLP-CLAIM",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534"\n'+
        '  }\n'+
       '}\n'+
       ']';
    lDuration = 25000;
       System.debug('ZipKinJSON: ' + ZipkinjsonE4 );  
    
       ZipkinjsonE5=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanIDE5 + '",\n' +
       '               "parentId": "' + sSpanIDE2 + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "MULE-PAYMENTS",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "MULE-PAYMENTS",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534"\n'+
        '  }\n'+
       '}\n'+
       ']';
   
       System.debug('ZipKinJSON: ' + ZipkinjsonE5 );  
      lDuration = 10000;
       ZipkinjsonE6=        '[\n'+
       '            {\n'+
       '               "traceId": "' + sTraceID +'",\n'+
       '               "id": "' + sSpanIDE6 + '",\n' +
       '               "parentId": "' + sSpanIDE2 + '",\n' +
       '               "kind": "SERVER",\n' +
       '               "name": "CLP-AUTH",\n' +
       '               "duration": ' + lDuration + ',\n' +
       '  "localEndpoint": {\n' +
       '    "serviceName": "Notification API",\n' +
       '    "ipv4": "newrelic-e-dev-ed.my.salesforce.com",\n' +
       '    "port": 8080\n' +
       '  },\n' +
       '   "tags": {\n'+
       '    "CorrelationID": "' + sCorrelationID + '",\n'+
       '    "MEDIACUSTOMERID": "USERIDX",\n'+
       '    "SUBSCRIPTransaction": "000000044534"\n'+
            '  }\n'+
       '}\n'+
       ']';
   
       System.debug('ZipKinJSON: ' + ZipkinjsonE6 );  
     
     
       NewRelicEvent=        '[\n'+
       '            {\n'+
       '               "eventType":"SalesForce",\n' +
       '               "service.name": "SalesForce Veg Sand",'+    
          '            "eventAttribute1":"1"\n' +
       '  }\n' +   
       ']';
       
       Datetime cdt = Datetime.now();
      Long lcurrenttime = cdt.getTime();
  
       
       NewRelicLog=        '['+
        '            {'+
        '                "common": {'+
        '                    "attributes": {'+
        '                        "logtype": "SalesForce",'+
        '                        "service": "SalesForce Veg Sand",'+       
        '                        "hostname": "newrelic-e-dev-ed.my.salesforce.com"'+
        '                    }'+
        '                },'+
        '                "logs": ['+
        '                    {'+
        '                        "timestamp": ' + lcurrenttime + ',\n'+
        '                        "service.name": "SalesForce Veg Sand",'+    
        '               "trace_id": "' + sTraceID +'",\n'+
        '               "span_id": "' + sSpanID + '",\n' +
        '               "id": "' + sSpanID + '",\n' +                  
        '                        "message": "Log 1"'+
        '                        }'+
        '                ]'+
        '            }'+
        '        ]';
       
 
   
        System.debug('In Error Response Body: '+ sResponseStatus); 
    }

       
        } catch(System.CalloutException e) {  
        System.debug('Callout error: '+ e); 
  
        } 
  
             currentTimeMill = dt.getTime(); 
             long RequestTime=1524;      
    lDuration = (currentTimeMill + RequestTime) - requestTimeMill;
   System.debug('Duration: '+ lDuration); 
   System.debug('currentTimeMill: '+ currentTimeMill); 
   System.debug('requestTimeMill: '+ requestTimeMill); 
      
    //
    
    
   
 // The below JSON is NewRelic format trace payload   
        
String NewRelicjson=        '['+
        '            {'+
        '                "common": {'+
        '                    "attributes": {'+
        '                        "service.name": "SalesForce",'+
        '                        "host": "newrelic-e-dev-ed.my.salesforce.com"'+
        '                    }'+
        '                },'+
        '                "spans": ['+
        '                    {'+
        '                        "trace.id": "'+ sTraceID + '",'+
        '                        "id": "'+ sSpanID + '",'+
        '                        "attributes": {'+
        '                            "duration.ms": ' + lDuration + ','+
        '                            "name": "/home"'+
        ''+
        '                        }'+
        '                    }'+
        '                ]'+
        '            }'+
        '        ]';


   
      
   
 
      


        
        
        // Instantiate a new http object
        Http http = new Http();
        // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
        HttpRequest req = new HttpRequest(); 
       
        req.setMethod('POST');
        //Content-Type  header is set to let the service know that the sent data is in JSON format
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');
       
        // Set for Newrelic JSON Trace Payload
       // req.setHeader('Data-Format', 'newrelic');
       // req.setBody(NewRelicjson); 
      //  req.setHeader('Data-Format-Version', '1');
        
        // Set for Zipkin JSON Trace Payload
        req.setHeader('Data-Format', 'zipkin');
        req.setHeader('Data-Format-Version', '2');
        req.setBody(Zipkinjson); 
                        

        // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
        HttpRequest reqEventData = new HttpRequest(); 
       
        
        reqEventData.setMethod('POST');
        //Content-Type  header is set to let the service know that the sent data is in JSON format
        reqEventData.setHeader('Content-Type', 'application/json;charset=UTF-8');
      
        reqEventData.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');
       
        reqEventData.setBody(NewRelicEvent); 
       
  
        // Instantiate a new HTTP request, specify the method (POST) as well as the endpoint
        HttpRequest reqLogData = new HttpRequest(); 
       
        
        reqLogData.setMethod('POST');
       
        reqLogData.setHeader('Content-Type', 'application/json;charset=UTF-8');
      
        reqLogData.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');
       
        reqLogData.setBody(NewRelicLog); 
       

        try {  

        // Send the to the Trace API request, and return a response
        req.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        HttpResponse res =  http.send(req); 
        
        
        HttpRequest reqE2 = new HttpRequest(); 
        reqE2.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        reqE2.setMethod('POST');
        reqE2.setHeader('Content-Type', 'application/json;charset=UTF-8');
        reqE2.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');   
        reqE2.setHeader('Data-Format', 'zipkin');
        reqE2.setHeader('Data-Format-Version', '2');
      
        reqE2.setBody(ZipkinjsonE2); 
        HttpResponse resE2 =  http.send(reqE2); 
        
        HttpRequest reqE3 = new HttpRequest(); 
        reqE3.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        reqE3.setMethod('POST');
        reqE3.setHeader('Content-Type', 'application/json;charset=UTF-8');
        reqE3.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');   
        reqE3.setHeader('Data-Format', 'zipkin');
        reqE3.setHeader('Data-Format-Version', '2');
      
        reqE3.setBody(ZipkinjsonE3); 
        HttpResponse resE3 =  http.send(reqE3); 
         
        HttpRequest reqE4 = new HttpRequest(); 
        reqE4.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        reqE4.setMethod('POST');
        reqE4.setHeader('Content-Type', 'application/json;charset=UTF-8');
        reqE4.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRALL');   
        reqE4.setHeader('Data-Format', 'zipkin');
        reqE4.setHeader('Data-Format-Version', '2');
      
        reqE4.setBody(ZipkinjsonE4); 
        HttpResponse resE4 =  http.send(reqE4); 
        
        
        HttpRequest reqE5 = new HttpRequest(); 
        reqE5.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        reqE5.setMethod('POST');
        reqE5.setHeader('Content-Type', 'application/json;charset=UTF-8');
        reqE5.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');   
        reqE5.setHeader('Data-Format', 'zipkin');
        reqE5.setHeader('Data-Format-Version', '2');
      
        reqE5.setBody(ZipkinjsonE5); 
        HttpResponse resE5 =  http.send(reqE5); 
        
        
        HttpRequest reqE6 = new HttpRequest(); 
        reqE6.setEndpoint('https://trace-api.newrelic.com/trace/v1');
        reqE6.setMethod('POST');
        reqE6.setHeader('Content-Type', 'application/json;charset=UTF-8');
        reqE6.setHeader('Api-Key', 'f492134b7a3813cb75a9293de4bb89c7FFFFNRAL');   
        reqE6.setHeader('Data-Format', 'zipkin');
        reqE6.setHeader('Data-Format-Version', '2');
      
        reqE6.setBody(ZipkinjsonE6); 
        HttpResponse resE6 =  http.send(reqE6); 
        
        } catch(System.CalloutException e) {  
        System.debug('Callout error: '+ e); 
    //  System.debug(res.toString()); 
        } 
          try {  

        // Send the to the Event API request, and return a response
       
        reqEventData.setEndpoint('https://insights-collector.newrelic.com/v1/accounts/1100964/events');
        HttpResponse res =  http.send(reqEventData); 
        } catch(System.CalloutException e) {  
        System.debug('Callout error: '+ e); 
    //  System.debug(res.toString()); 
        } 
        
           try {  

        // Send the to the LOG API request, and return a response
      
        reqLogData.setEndpoint('https://log-api.newrelic.com/log/v1');
        HttpResponse res =  http.send(reqLogData); 
        } catch(System.CalloutException e) {  
        System.debug('Callout error: '+ e); 
    //  System.debug(res.toString()); 
        } 
        
        
        
    
        
        // 
 //       upsert expense;
       return expense;
}
}