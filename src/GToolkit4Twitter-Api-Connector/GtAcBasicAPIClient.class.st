Class {
	#name : #GtAcBasicAPIClient,
	#superclass : #Object,
	#instVars : [
		'configuration'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtAcBasicAPIClient >> authorizedZnClient [
	self subclassResponsibility
]

{ #category : #accessing }
GtAcBasicAPIClient >> bearerToken [
	^ configuration bearerToken
]

{ #category : #accessing }
GtAcBasicAPIClient >> configuration: aConfiguration [
	self assert: [ aConfiguration notNil ].
	configuration := aConfiguration
]

{ #category : #logging }
GtAcBasicAPIClient >> emitErrorFor: anError [
	 GtAcZincErrorSignal  new 	
		wrappedError: anError;
		emit
]

{ #category : #logging }
GtAcBasicAPIClient >> emitRequestFor: znClient [
	 GtAcZincRequestSignal new 	
		request: znClient request;
		emit
]

{ #category : #logging }
GtAcBasicAPIClient >> emitResponseFor: znClient [
	 GtAcZincResponseSignal new 	
		response: znClient response;
		emit
]

{ #category : #accessing }
GtAcBasicAPIClient >> serverUrl [
	^ configuration serverUrl 
]

{ #category : #accessing }
GtAcBasicAPIClient >> znClient [
	^ ZnClient new
]
