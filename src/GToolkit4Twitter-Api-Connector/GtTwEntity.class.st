Class {
	#name : #GtTwEntity,
	#superclass : #Object,
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #printing }
GtTwEntity >> descriptionOn: aStream [ 
]

{ #category : #printing }
GtTwEntity >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]
