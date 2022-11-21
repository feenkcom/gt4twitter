Class {
	#name : #GtAcBasicAPIRequest,
	#superclass : #Object,
	#instVars : [
		'apiClient',
		'zincRequest',
		'zincResponse',
		'requestResponse',
		'requestResult',
		'queryFields'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'instance creation' }
GtAcBasicAPIRequest class >> forApiClient: anApiClient [
	^ self new
		apiClient: anApiClient
]

{ #category : #accessing }
GtAcBasicAPIRequest >> apiClient [

	^ apiClient
]

{ #category : #accessing }
GtAcBasicAPIRequest >> apiClient: anApiClient [
	apiClient := anApiClient
]

{ #category : #accessing }
GtAcBasicAPIRequest >> applyCustomHeadersFor: aZincClient [
]

{ #category : #accessing }
GtAcBasicAPIRequest >> authorizedZnClient [
	| zincClient |
	zincClient := self apiClient authorizedZnClient.
	zincClient 
		enforceHttpSuccess: true;
		enforceAcceptContentType: true.
	self applyCustomHeadersFor: zincClient.
	^ zincClient
]

{ #category : #execution }
GtAcBasicAPIRequest >> basicExecute [ 
	| zincClient |
	
	zincClient := self performZincCall.
	zincResponse := zincClient  response.
	
	zincResponse isSuccess 
		ifFalse: [ GtAcAPIClientRequestError signalFor: zincResponse ].
	
	^ requestResponse := GtAcZincRequestResponse new 
		zincResponse: zincResponse;
		contents: zincClient contents.
]

{ #category : #execution }
GtAcBasicAPIRequest >> basicExecuteWithErrorHandling [ 
	^ [ self basicExecute ] 
		on: Error 
		do: [ :anError | 
			self emitErrorFor: anError.
			requestResponse := GtAcExceptionRequestResponse new
				exception: anError ] 
]

{ #category : #accessing }
GtAcBasicAPIRequest >> configuredZincClient [
	^ self subclassResponsibility
]

{ #category : #logging }
GtAcBasicAPIRequest >> emitErrorFor: anError [
	self apiClient emitErrorFor: anError
]

{ #category : #logging }
GtAcBasicAPIRequest >> emitRequestFor: znClient [
	self apiClient emitRequestFor: znClient
]

{ #category : #logging }
GtAcBasicAPIRequest >> emitResponseFor: znClient [
	self apiClient emitResponseFor: znClient
]

{ #category : #execution }
GtAcBasicAPIRequest >> execute [ 
	| currentResponse returnValue| 
	currentResponse := self basicExecute.
	
	returnValue := self parserResponseContents: currentResponse contents.
	
	^ requestResult := (GtAcRequestResult forRequest: self)
		requestResponse: currentResponse;
		returnedValue: returnValue
]

{ #category : #execution }
GtAcBasicAPIRequest >> executeWithErrorHandling [ 
	| currentResponse resultValue | 
	
	currentResponse := self basicExecuteWithErrorHandling. 
	currentResponse isSuccess ifFalse: [
		^ requestResult := GtAcRequestResult new 
			requestResponse: currentResponse ].
				
	[ resultValue := self parserResponseContents: currentResponse contents ]
		on: Error
		do: [ 
			^ GtAcRequestResult new 
				requestResponse: currentResponse ].

	^ requestResult := (GtAcRequestResult forRequest: self) 
		requestResponse: currentResponse;
		returnedValue: resultValue
]

{ #category : #accessing }
GtAcBasicAPIRequest >> formattedQueryValueFor: aValue [ 

	aValue isString ifTrue: [
		^ aValue ].

	aValue isCollection ifTrue: [
		^ String streamContents: [ :aStream |
			aValue asStringOn: aStream delimiter: ',' ] ].
	
	^ aValue asString
]

{ #category : #'gt - extensions' }
GtAcBasicAPIRequest >> gtViewQueryParametersFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Query Parameters';
		object: [ queryFields ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtAcBasicAPIRequest >> httpMethod [
	self subclassResponsibility
]

{ #category : #initialization }
GtAcBasicAPIRequest >> initialize [
	super initialize.
	
	queryFields := OrderedDictionary new
]

{ #category : #accessing }
GtAcBasicAPIRequest >> parserResponseContents: aContent [
	^ aContent
]

{ #category : #execution }
GtAcBasicAPIRequest >> performZincCall [ 
	| zincClient |
	
	zincClient := self configuredZincClient.
	
	zincRequest := zincClient request.
	self emitRequestFor: zincClient.
	
	zincClient 
		method: self httpMethod; 
		execute.
	
	self emitResponseFor: zincClient.
	^ zincClient 
]

{ #category : #accessing }
GtAcBasicAPIRequest >> queryParameterAt: aKey [
	^ queryFields at: aKey
]

{ #category : #accessing }
GtAcBasicAPIRequest >> queryParameterAt: aKey ifAbsentPut: aBlock [
	queryFields at: aKey ifAbsentPut: aBlock
]

{ #category : #accessing }
GtAcBasicAPIRequest >> queryParameterAt: aKey put: aValue [
	queryFields at: aKey put: aValue
]

{ #category : #accessing }
GtAcBasicAPIRequest >> serverUrl [
	^ self apiClient serverUrl
]

{ #category : #accessing }
GtAcBasicAPIRequest >> zincResponse [
	^ requestResponse zincResponse
]
