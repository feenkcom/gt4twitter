Class {
	#name : 'GtTwApiDataLoader',
	#superclass : 'Object',
	#instVars : [
		'apiContext'
	],
	#category : 'GToolkit4Twitter-Api-Connector-Loader',
	#package : 'GToolkit4Twitter-Api-Connector',
	#tag : 'Loader'
}

{ #category : 'instance creation' }
GtTwApiDataLoader class >> forApiContext: anApiContext [
	^ self new 
		apiContext: anApiContext
]

{ #category : 'accessing' }
GtTwApiDataLoader >> apiContext [

	^ apiContext
]

{ #category : 'accessing' }
GtTwApiDataLoader >> apiContext: anObject [

	apiContext := anObject
]
