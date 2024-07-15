Class {
	#name : #GtTwiUser,
	#superclass : #GtTwiEntity,
	#instVars : [
		'id',
		'username',
		'displayName',
		'profilePicture',
		'tweets',
		'isAdvertiser'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #adding }
GtTwiUser >> addTweet: aTweet [
	self assert: [ aTweet author isNil ].
	 
	self tweets add: aTweet.
	aTweet author: self
]

{ #category : #accessing }
GtTwiUser >> displayName: aString [ 
	displayName := aString
]

{ #category : #'gt - extensions' }
GtTwiUser >> gtViewTweetsListFor: aView [
	<gtView>
	
	tweets ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Tweets List';
		priority: 20;
		object: [ tweets ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtTwiUser >> gtViewTweetsTimelineFor: aView [
	<gtView>
	
	tweets ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Tweets';
		priority: 10;
		object: [ tweets ];
		view: #gtViewTweetsTimelineFor:
]

{ #category : #accessing }
GtTwiUser >> id: anId [
	id := anId 
]

{ #category : #accessing }
GtTwiUser >> initialize [
	super initialize.
	
	tweets := GtTwiTweetsGroup new
]

{ #category : #testing }
GtTwiUser >> isAdvertiser [
	^ isAdvertiser ifNil: [ false ]
]

{ #category : #actions }
GtTwiUser >> markAsAdvertiser [
	isAdvertiser := true
]

{ #category : #accessing }
GtTwiUser >> name [ 
	^ displayName
]

{ #category : #printing }
GtTwiUser >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< displayName;
			<< ', @';
			<< username ]
]

{ #category : #accessing }
GtTwiUser >> profilePicture: aPicture [ 
	profilePicture := aPicture 
]

{ #category : #accessing }
GtTwiUser >> profilePictureElement [
	^ profilePicture ifNotNil: [:aPicture |
		aPicture pictureElement ]
]

{ #category : #accessing }
GtTwiUser >> tweets [
	^ tweets
]

{ #category : #accessing }
GtTwiUser >> tweets: aTweetsGroup [ 
	tweets := aTweetsGroup.
	
	tweets do: [ :aTweet |
		aTweet author: self ] 
]

{ #category : #accessing }
GtTwiUser >> username [
	^ username
]

{ #category : #accessing }
GtTwiUser >> username: aString [ 
	username := aString
]
