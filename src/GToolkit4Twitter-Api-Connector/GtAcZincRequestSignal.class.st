Class {
	#name : #GtAcZincRequestSignal,
	#superclass : #GtAcZincSignal,
	#instVars : [
		'request'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Logging'
}

{ #category : #printing }
GtAcZincRequestSignal >> printOneLineContentsOn: stream [
	self request headers at:'X-Request-Id' ifPresent: [:xRequestId |
		 stream nextPutAll: xRequestId].
	stream nextPutAll: '|'.
	self request method printOn: stream.
	stream nextPutAll: '|'.
	stream nextPutAll: (self request url asString).
]

{ #category : #accessing }
GtAcZincRequestSignal >> request [
	^ request
]

{ #category : #accessing }
GtAcZincRequestSignal >> request: anObject [
	request := anObject
]
