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
		ifPresent: [ :aString | GtTwiDateParser parse: aString ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - metrics' }
GtTwiTweet >> creationDateString [
	^ self 
		rawDataAt: 'created_at' 
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtTwiTweet >> gtCardFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Card';
		priority: 0;
		stencil: [ GtTwTweetSummaryElement new tweet: self; addAptitude: BrShadowAptitude; background: Color white; margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
GtTwiTweet >> gtMediaItemsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Media items';
		items: [ self mediaItems ];
		column: 'Item' text: [ :each | each gtDisplayString ];
		column: 'Type' text: #mediaType
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
GtTwiTweet >> hasMediaItems [
	^ self mediaItems notEmpty
]

{ #category : #accessing }
GtTwiTweet >> hasPhotos [
	^ self mediaItems anySatisfy: #isPhoto
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

{ #category : #accessing }
GtTwiTweet >> mediaItems [
	| extendedEntitieData mediaData |
	extendedEntitieData := rawData at: 'extended_entities' ifAbsentPut: [ ^ {} ].
	mediaData := extendedEntitieData at: 'media' ifAbsentPut: [ ^ {} ].
	^ mediaData collect: [ :each | GtTwiMediaItem new rawData: each ]
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
