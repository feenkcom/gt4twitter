Class {
	#name : #GtTwUser,
	#superclass : #GtTwEntity,
	#instVars : [
		'id',
		'username',
		'rawUser',
		'tweets',
		'followers',
		'following',
		'profilePictureForm'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwUser class >> fromRawUser: aRawUser [
	^ self new 
		initializeFromRawUser: aRawUser
]

{ #category : #'instance creation' }
GtTwUser class >> fromRawUser: aRawUser inContext: anApiContext [
	^ (self forApiContext: anApiContext)
		initializeFromRawUser: aRawUser
]

{ #category : #accessing }
GtTwUser >> description [
	^ self rawUser description
]

{ #category : #printing }
GtTwUser >> descriptionOn: aStream [ 
	aStream << (self name ifNil: ['-']) 
]

{ #category : #accessing }
GtTwUser >> downloadPofileImage [
	^ self rawUser profileImageUrl 
		ifNotNil: [ :anUrlString |
			(anUrlString endsWith: '.png')
				ifTrue: [ ^ ZnEasy getPng: anUrlString ].
			(anUrlString endsWith: '.jpg')
				ifTrue: [ ^ ZnEasy getJpeg: anUrlString ].
			^ nil ]
]

{ #category : #accessing }
GtTwUser >> followers [ 
	^ followers ifNil: [
		followers := self apiContext usersLoader 
			getFollowersForUserId: self id ]
]

{ #category : #'accessing - metrics' }
GtTwUser >> followersCount [
	^ self rawUser followersCount
]

{ #category : #accessing }
GtTwUser >> following [ 
	^  following ifNil: [
		following := self apiContext usersLoader 
			getFollowingForUserId: self id ]
]

{ #category : #'accessing - metrics' }
GtTwUser >> followingCount [
	^ self rawUser followingCount
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewDetailsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Details';
		priority: 5;
		items: [ {} ]
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewFollowersListFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Followers List';
		priority: 55;
		object: [ self followers ];
		view: #gtViewUsersListFor:;
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewFollowersSummaryUIFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Followers';
		priority: 20;
		object: [ self followers ];
		view: #gtViewUsersSummaryUIFor:;
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewFollowingSummaryUIFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Following';
		priority: 22;
		object: [ self following ];
		view: #gtViewUsersSummaryUIFor:;
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwUser >> gtViewTweetsSummaryUIFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Tweets';
		priority: 10;
		object: [ self tweets ];
		view: #gtViewTweetsSummaryUIFor:;
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
GtTwUser >> profilePictureForm [ 
	^ profilePictureForm ifNil: [
		[profilePictureForm := self downloadPofileImage]
			
			on: Error 
			do: [ profilePictureForm := nil ].
		profilePictureForm ifNil: [
			profilePictureForm := Form extent: 48@48 depth: 32.
			profilePictureForm fillColor: (Color veryLightGray).
			profilePictureForm ] ]
]

{ #category : #accessing }
GtTwUser >> rawUser [

	^ rawUser
]

{ #category : #accessing }
GtTwUser >> rawUser: anObject [

	rawUser := anObject
]

{ #category : #'accessing - metrics' }
GtTwUser >> tweetCount [
	^ self rawUser tweetCount
]

{ #category : #accessing }
GtTwUser >> tweets [ 
	^ tweets ifNil: [
		tweets := self apiContext tweetsLoader 
			getTimelineTweetsForUser: self ]
]

{ #category : #accessing }
GtTwUser >> username [
	^ username
]
