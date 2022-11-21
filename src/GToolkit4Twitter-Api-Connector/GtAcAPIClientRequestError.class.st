Class {
	#name : #GtAcAPIClientRequestError,
	#superclass : #Error,
	#instVars : [
		'response'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'instance creation' }
GtAcAPIClientRequestError class >> for: aResponse [
	^ self new 
		response: aResponse;
		yourself	
]

{ #category : #signalling }
GtAcAPIClientRequestError class >> signalFor: aResponse [
	^ (self for: aResponse) signal
]

{ #category : #accessing }
GtAcAPIClientRequestError >> response [
	^ response
]

{ #category : #accessing }
GtAcAPIClientRequestError >> response: anObject [
	response := anObject
]
