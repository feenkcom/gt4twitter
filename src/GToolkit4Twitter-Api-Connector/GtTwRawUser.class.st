Class {
	#name : #GtTwRawUser,
	#superclass : #GtTwRawEntity,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #accessing }
GtTwRawUser >> id [ 
	^ self rawDataWithDefaultAt:'id'
]

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

{ #category : #accessing }
GtTwRawUser >> username [ 
	^ self rawDataWithDefaultAt:'username'
]
