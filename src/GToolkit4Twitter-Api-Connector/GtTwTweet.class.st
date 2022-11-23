Class {
	#name : #GtTwTweet,
	#superclass : #GtTwEntity,
	#instVars : [
		'rawTweet',
		'author'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwTweet class >> fromRawTweet: aRawTweet [
	^ self new 
		rawTweet: aRawTweet
]

{ #category : #'instance creation' }
GtTwTweet class >> fromRawTweet: aRawTweet inContext: anApiContext [
	^ (self forApiContext: anApiContext)
		rawTweet: aRawTweet
]

{ #category : #accessing }
GtTwTweet >> author [
	^ author
]

{ #category : #accessing }
GtTwTweet >> author: aUser [
	author := aUser
]

{ #category : #accessing }
GtTwTweet >> createdAt [
	^ self rawTweet createdAt
]

{ #category : #accessing }
GtTwTweet >> descriptionOn: aStream [ 
	aStream << self text
]

{ #category : #'gt - extensions' }
GtTwTweet >> gtRawDataFor: aView [
	<gtView>
	
	self rawTweet ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Raw data';
		priority: 75;
		object: [ self rawTweet];
		view: #gtRawDataFor:
]

{ #category : #'gt - extensions' }
GtTwTweet >> gtViewTextFor: aView [
	<gtView>
	
	self text ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Text';
		priority: 30;
		object: [ self text ];
		view: #gtStringFor:
]

{ #category : #'accessing - metrics' }
GtTwTweet >> likesCount [
	^ self rawTweet likesCount
]

{ #category : #accessing }
GtTwTweet >> rawTweet [

	^ rawTweet
]

{ #category : #accessing }
GtTwTweet >> rawTweet: aRawTweet [

	rawTweet := aRawTweet
]

{ #category : #'accessing - metrics' }
GtTwTweet >> retweetsCount [
	^ self rawTweet retweetsCount
]

{ #category : #accessing }
GtTwTweet >> text [
	^ self rawTweet text
]
