Class {
	#name : #GtTwRawGroupResponse,
	#superclass : #GtTwRawResponse,
	#instVars : [
		'metadata'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'gt - extensions' }
GtTwRawGroupResponse >> gtViewMetadataFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Metadata';
		priority: 55;
		object: [ self metadata ];
		view: #gtRawDataFor:
]

{ #category : #testing }
GtTwRawGroupResponse >> hasNextPaginationToken [
	^ self metadata hasNotNilKey: 'next_token'
]

{ #category : #initialization }
GtTwRawGroupResponse >> initializaFromRawData: aDictionary [
	super initializaFromRawData: aDictionary.
	
	self  
		metadata: (GtTwRawEntity fromRawData: (aDictionary 
			at: 'meta' ifAbsent: [ Dictionary new ]))
]

{ #category : #accessing }
GtTwRawGroupResponse >> metadata [

	^ metadata
]

{ #category : #accessing }
GtTwRawGroupResponse >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
GtTwRawGroupResponse >> nextPaginationToken [
	^ self metadata rawDataAt: 'next_token'
]
