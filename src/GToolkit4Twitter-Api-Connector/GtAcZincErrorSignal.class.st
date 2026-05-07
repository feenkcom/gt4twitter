Class {
	#name : 'GtAcZincErrorSignal',
	#superclass : 'GtAcZincSignal',
	#instVars : [
		'erro',
		'error'
	],
	#category : 'GToolkit4Twitter-Api-Connector-Logging',
	#package : 'GToolkit4Twitter-Api-Connector',
	#tag : 'Logging'
}

{ #category : 'printing' }
GtAcZincErrorSignal >> printOneLineContentsOn: stream [
	error printOn: stream.
]

{ #category : 'accessing' }
GtAcZincErrorSignal >> wrappedError: anError [
	error := anError
]
