Class {
	#name : #GtTwEntity,
	#superclass : #Object,
	#instVars : [
		'apiContext'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwEntity class >> forApiContext: aContext [
	^ self new 
		apiContext: aContext
]

{ #category : #accessing }
GtTwEntity >> apiContext [

	^ apiContext
]

{ #category : #accessing }
GtTwEntity >> apiContext: anObject [

	apiContext := anObject
]

{ #category : #printing }
GtTwEntity >> descriptionOn: aStream [ 
]

{ #category : #printing }
GtTwEntity >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]
