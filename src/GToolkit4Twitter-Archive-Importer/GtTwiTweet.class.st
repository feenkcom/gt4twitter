Class {
	#name : #GtTwiTweet,
	#superclass : #GtTwiEntity,
	#instVars : [
		'id',
		'text',
		'author',
		'isAd',
		'inReplyToTweet',
		'replyTweets'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiTweet >> addReplyTweet: aTweet [
	self replyTweets add: aTweet
]

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
		stencil: [ GtTwTweetSummaryElement new
				tweet: self;
				addAptitude: BrShadowAptitude;
				background: Color white;
				margin: (BlInsets all: 10) ]
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

{ #category : #accessing }
GtTwiTweet >> gtThreadFor: aView [ 
	<gtView>
	^ aView mondrian
		title: 'Thread';
		painting: [:m | 
			self paintContainingThreadWith: m]
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

{ #category : #'as yet unclassified' }
GtTwiTweet >> inReplyTo [
	^ inReplyToTweet
]

{ #category : #'as yet unclassified' }
GtTwiTweet >> inReplyTo: aGtTwiTweet [ 
	inReplyToTweet := aGtTwiTweet
]

{ #category : #accessing }
GtTwiTweet >> inReplyToStatusId [
	^ self rawDataAt: 'in_reply_to_status_id' ifAbsent: [ nil ]
]

{ #category : #testing }
GtTwiTweet >> isAdd [
	^ isAd ifNil: [ false ]
]

{ #category : #accessing }
GtTwiTweet >> isInReplyToStatus [
	^ self inReplyToStatusId notNil
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

{ #category : #accessing }
GtTwiTweet >> paintContainingThreadWith: m [
	m nodes
		stencil: [ :each | 
			| shadow |
			shadow := BrShadowAptitude new.
			each = self ifTrue: [ shadow color: Color blue ].
			GtTwTweetSummaryElement new
				tweet: each;
				addAptitude: shadow;
				background: Color white;
				margin: (BlInsets all: 10);
				when: BlClickEvent do: [ :e | e target phlow spawnObject: each ] ];
		with: self threadTweets.
	m edges connectFrom: #inReplyTo.
	m layout tree levelDistance: 30
]

{ #category : #printing }
GtTwiTweet >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << (self text ifNil: [ '' ]) ]
]

{ #category : #accessing }
GtTwiTweet >> replyTweets [
	^ replyTweets ifNil: [ replyTweets := OrderedCollection new ]
]

{ #category : #'accessing - metrics' }
GtTwiTweet >> retweetsCount [
	^ self 
		rawDataAt: 'retweet_count' 
		ifPresent: [ :x | x asNumber ]
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

{ #category : #accessing }
GtTwiTweet >> threadTweets [
	| allReplyTweets allInReplyTweets |
	allInReplyTweets := self withDeepCollect: [ :each | each inReplyTo ].
	allReplyTweets := self deepCollect: [ :each | each replyTweets ].
	^ allInReplyTweets , allReplyTweets
]
