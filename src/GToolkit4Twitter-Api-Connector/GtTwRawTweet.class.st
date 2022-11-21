Class {
	#name : #GtTwRawTweet,
	#superclass : #GtTwRawEntity,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #accessing }
GtTwRawTweet >> createdAt [
	^ DateAndTime fromString:  (self rawDataAt: 'created_at') 
]

{ #category : #'gt - extensions' }
GtTwRawTweet >> gtViewTextFor: aView [
	<gtView>
	
	self text ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Text';
		priority: 30;
		object: [ self text ];
		view: #gtStringFor:
]

{ #category : #printing }
GtTwRawTweet >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream print: self text ]
]

{ #category : #accessing }
GtTwRawTweet >> text [
	^ self rawDataWithDefaultAt: 'text'
]
