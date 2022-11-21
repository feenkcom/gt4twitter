Class {
	#name : #GtAcRequestResult,
	#superclass : #Object,
	#instVars : [
		'request',
		'requestResponse',
		'returnedValue'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Result'
}

{ #category : #'instance creation' }
GtAcRequestResult class >> forRequest: aRequest [
	^ self new 
		request: aRequest 
]

{ #category : #accessing }
GtAcRequestResult >> contents [
	^ self resultValue
]

{ #category : #accessing }
GtAcRequestResult >> request [

	^ request
]

{ #category : #accessing }
GtAcRequestResult >> request: anObject [

	request := anObject
]

{ #category : #accessing }
GtAcRequestResult >> requestResponse [

	^ requestResponse
]

{ #category : #accessing }
GtAcRequestResult >> requestResponse: anObject [

	requestResponse := anObject
]

{ #category : #accessing }
GtAcRequestResult >> returnedValue [

	^ returnedValue
]

{ #category : #accessing }
GtAcRequestResult >> returnedValue: anObject [

	returnedValue := anObject
]
