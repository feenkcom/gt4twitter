Class {
	#name : #GtTwRawUser,
	#superclass : #GtTwRawEntity,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #accessing }
GtTwRawUser >> name [ 
	^ self rawDataWithDefaultAt:'name'
]

{ #category : #printing }
GtTwRawUser >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << (self name ifNil: ['-']) ]
]
