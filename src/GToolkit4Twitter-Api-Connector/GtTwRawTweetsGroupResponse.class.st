"
nil
"
Class {
	#name : #GtTwRawTweetsGroupResponse,
	#superclass : #GtTwRawResponse,
	#instVars : [
		'metadata'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'gt - extensions' }
GtTwRawTweetsGroupResponse >> gtViewMetadataFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Metadata';
		priority: 55;
		object: [ self metadata ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtTwRawTweetsGroupResponse >> gtViewTweetsListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Tweets Data';
		priority: 30;
		object: [ self tweetsGroup ];
		view: #gtItemsFor:
]

{ #category : #testing }
GtTwRawTweetsGroupResponse >> hasNextPaginationToken [
	^ self metadata hasNotNilKey: 'next_token'
]

{ #category : #initialization }
GtTwRawTweetsGroupResponse >> initializaFromRawData: aDictionary [
	super initializaFromRawData: aDictionary.
	
	self  
		data: ((aDictionary at: 'data' ifAbsent: [ {} ])
			collect: [ :aTweetData |
				GtTwRawTweet fromRawData: aTweetData ]);
		metadata: (GtTwRawEntity fromRawData: (aDictionary 
			at: 'meta' ifAbsent: [ Dictionary new ]))
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> metadata [

	^ metadata
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> nextPaginationToken [
	^ self metadata rawDataAt: 'next_token'
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		space;
		nextPut: $[;
		print: self tweetsCount;
		nextPutAll: (' tweet' asPluralBasedOn: self tweetsCount);
		nextPut: $] 
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> tweetsCount [
	^ self tweetsGroup size
]

{ #category : #accessing }
GtTwRawTweetsGroupResponse >> tweetsGroup [
	^ self data
]
