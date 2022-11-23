Class {
	#name : #GtTwRawUsersGroupResponse,
	#superclass : #GtTwRawGroupResponse,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #initialization }
GtTwRawUsersGroupResponse >> initializaFromRawData: aDictionary [
	super initializaFromRawData: aDictionary.
	
	self  
		data: ((aDictionary at: 'data' ifAbsent: [ {} ])
			collect: [ :aTweetData |
				GtTwRawUser fromRawData: aTweetData ])
]
