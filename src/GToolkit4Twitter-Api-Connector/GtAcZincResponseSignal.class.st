Class {
	#name : #GtAcZincResponseSignal,
	#superclass : #GtAcZincSignal,
	#instVars : [
		'response'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Logging'
}

{ #category : #printing }
GtAcZincResponseSignal >> printOneLineContentsOn: stream [
	stream nextPutAll: (self response headers 
		at:'X-Request-Id'  ifAbsent:'X-Request-Id' ).
	stream nextPutAll: '|'.
	self response asString printOn: stream.
]

{ #category : #accessing }
GtAcZincResponseSignal >> response [
	^ response
]

{ #category : #accessing }
GtAcZincResponseSignal >> response: anObject [
	response := anObject
]
