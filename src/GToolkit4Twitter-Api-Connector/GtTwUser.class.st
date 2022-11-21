Class {
	#name : #GtTwUser,
	#superclass : #GtTwEntity,
	#instVars : [
		'tweets',
		'rawUser',
		'id',
		'username'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwUser class >> fromRawUser: aRawUser [
	^ self new 
		initializeFromRawUser: aRawUser
]

{ #category : #printing }
GtTwUser >> descriptionOn: aStream [ 
	aStream << (self name ifNil: ['-']) 
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewDetailsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Details';
		priority: 10;
		items: [ {} ]
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewTweetsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Tweets';
		priority: 20;
		items: [ self tweets ];
		column: 'Created At' text: [ :aTweet | 
			aTweet createdAt printToSeconds ] width: 180;
		column: 'Text' text: [ :aTweet | aTweet text ];
		actionUpdateButton
]

{ #category : #accessing }
GtTwUser >> id [
	^ self rawUser id
]

{ #category : #initialization }
GtTwUser >> initializeFromRawUser: aRawUser [
	self rawUser: aRawUser.
	
	id := aRawUser id.
	username := aRawUser username.
]

{ #category : #accessing }
GtTwUser >> name [
	^ self rawUser name
]

{ #category : #accessing }
GtTwUser >> rawUser [

	^ rawUser
]

{ #category : #accessing }
GtTwUser >> rawUser: anObject [

	rawUser := anObject
]

{ #category : #accessing }
GtTwUser >> tweets [ 
	^ tweets ifNil: [
		tweets := self apiContext tweetsLoader 
			getTimelineTweetsForUserId: self id ]
]
