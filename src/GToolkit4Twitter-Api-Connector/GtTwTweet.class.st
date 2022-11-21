Class {
	#name : #GtTwTweet,
	#superclass : #GtTwEntity,
	#instVars : [
		'rawTweet'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwTweet class >> fromRawTweet: aRawTweet [
	^ self new 
		rawTweet: aRawTweet
]

{ #category : #accessing }
GtTwTweet >> createdAt [
	^ self rawTweet createdAt
]

{ #category : #accessing }
GtTwTweet >> descriptionOn: aStream [ 
	aStream << self text
]

{ #category : #accessing }
GtTwTweet >> gtViewTextFor: aView [
	<gtView>
	
	self text ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Text';
		priority: 30;
		object: [ self text ];
		view: #gtStringFor:
]

{ #category : #accessing }
GtTwTweet >> rawTweet [

	^ rawTweet
]

{ #category : #accessing }
GtTwTweet >> rawTweet: aRawTweet [

	rawTweet := aRawTweet
]

{ #category : #accessing }
GtTwTweet >> text [
	^ self rawTweet text
]
