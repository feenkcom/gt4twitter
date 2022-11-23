"
nil
"
Class {
	#name : #GtTwRawResponse,
	#superclass : #GtTwRawObject,
	#instVars : [
		'data',
		'includes'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'instance - creation' }
GtTwRawResponse class >> fromJsonString: aJsonString [
	^ self fromRawData: (STONJSON fromString: aJsonString)
]

{ #category : #accessing }
GtTwRawResponse >> data [

	^ data
]

{ #category : #accessing }
GtTwRawResponse >> data: anObject [

	data := anObject
]

{ #category : #accessing }
GtTwRawResponse >> includes [

	^ includes
]

{ #category : #accessing }
GtTwRawResponse >> includes: anObject [

	includes := anObject
]

{ #category : #accessing }
GtTwRawResponse >> initializaFromRawData: aDictionary [
	self rawData: aDictionary.
	
	self  
		includes: (aDictionary 
			at: 'includes' 
			ifPresent: [ :anExpansionData |
				GtTwRawExpansion fromRawData: anExpansionData ]  
			ifAbsent: [ nil ])
]
