Class {
	#name : #GtTwiTweet,
	#superclass : #GtTwiEntity,
	#instVars : [
		'id',
		'text',
		'author',
		'isAd'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiTweet >> author [

	^ author
]

{ #category : #accessing }
GtTwiTweet >> author: aUser [

	author := aUser
]

{ #category : #accessing }
GtTwiTweet >> authorName [
	^ self author 
		ifNotNil: [ :aUser | aUser name ]
]

{ #category : #'accessing - metrics' }
GtTwiTweet >> creationDate [
	^ self 
		rawDataAt: 'created_at' 
		ifAbsent: [ nil ]
]

{ #category : #'gt - extensions' }
GtTwiTweet >> gtViewTextFor: aView [ 
	<gtView>
	
	^ aView textEditor
		title: 'Text';
		priority: 10;
		text: [ self text ] 
]

{ #category : #accessing }
GtTwiTweet >> id [
	^ id
]

{ #category : #accessing }
GtTwiTweet >> id: anId [
	id := anId 
]

{ #category : #testing }
GtTwiTweet >> isAdd [
	^ isAd ifNil: [ false ]
]

{ #category : #testing }
GtTwiTweet >> isRetweet [
	^ (self 
		rawDataAt: 'retweeted'
		ifAbsent: [ false ] )or: [ self text beginsWith: 'RT @' ]
]

{ #category : #'accessing - metrics' }
GtTwiTweet >> likesCount [
	^ self 
		rawDataAt: 'favorite_count' 
		ifAbsent: [ 0 ]
]

{ #category : #actions }
GtTwiTweet >> markAsAd [
	isAd := true
]

{ #category : #printing }
GtTwiTweet >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << (self text ifNil: [ '' ]) ]
]

{ #category : #'accessing - metrics' }
GtTwiTweet >> retweetsCount [
	^ self 
		rawDataAt: 'retweet_count' 
		ifAbsent: [ 0 ]
]

{ #category : #accessing }
GtTwiTweet >> text [
	^ text
]

{ #category : #accessing }
GtTwiTweet >> text: aText [
	text  := aText 
]
