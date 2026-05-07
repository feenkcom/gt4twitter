Class {
	#name : 'GtTwiMediaItem',
	#superclass : 'GtTwiEntity',
	#instVars : [
		'tweet'
	],
	#category : 'GToolkit4Twitter-Archive-Importer',
	#package : 'GToolkit4Twitter-Archive-Importer'
}

{ #category : 'accessing' }
GtTwiMediaItem >> asElement [
	^ BrAsyncFileWidget new
		matchParent;
		url: self url
]

{ #category : 'accessing' }
GtTwiMediaItem >> gtPreviewFor: aView [
	<gtView>
	self isPhoto ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 1;
		stencil: [ self asElement ]
]

{ #category : 'views' }
GtTwiMediaItem >> gtTweetFor: aView [
	<gtView>
	^ aView forward
		title: 'Tweet';
		priority: 0;
		object: [ self tweet ];
		view: #gtCardFor:
]

{ #category : 'accessing' }
GtTwiMediaItem >> isPhoto [
	^ self mediaType = 'photo'
]

{ #category : 'accessing' }
GtTwiMediaItem >> mediaType [
	^ rawData at: 'type'
]

{ #category : 'as yet unclassified' }
GtTwiMediaItem >> tweet [
	^ tweet
]

{ #category : 'accessing' }
GtTwiMediaItem >> tweet: aTweet [
	tweet := aTweet 
]

{ #category : 'accessing' }
GtTwiMediaItem >> url [
	^ rawData at: 'media_url_https'
]
