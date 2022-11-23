"
nil
"
Class {
	#name : #GtTwRawTweetsGroupResponse,
	#superclass : #GtTwRawGroupResponse,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'gt - extensions' }
GtTwRawTweetsGroupResponse >> gtViewTweetsListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Tweets Data';
		priority: 30;
		object: [ self tweetsGroup ];
		view: #gtItemsFor:
]

{ #category : #initialization }
GtTwRawTweetsGroupResponse >> initializaFromRawData: aDictionary [
	super initializaFromRawData: aDictionary.
	
	self  
		data: ((aDictionary at: 'data' ifAbsent: [ {} ])
			collect: [ :aTweetData |
				GtTwRawTweet fromRawData: aTweetData ])
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
