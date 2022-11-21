"
nil
"
Class {
	#name : #GtTwSingleUserLookupResponse,
	#superclass : #GtTwRawResponse,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #initialization }
GtTwSingleUserLookupResponse >> initializaFromRawData: aDictionary [
	super initializaFromRawData: aDictionary.
	
	self  
		data: (aDictionary 
			at: 'data' 
			ifPresent: [ :aUserData |
				GtTwRawUser fromRawData: aUserData ]  
			ifAbsent: [ nil ])
]
