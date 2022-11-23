Class {
	#name : #GtTwUserSummaryElement,
	#superclass : #BrFrame,
	#instVars : [
		'userNameLabel',
		'userHandleLabel',
		'descriptionEditor',
		'followingCountLabel',
		'followersCountLabel',
		'user',
		'tweetsCountLabel',
		'pictureElement'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #initialization }
GtTwUserSummaryElement >> buildAsyncProfilePictureElement [
	^ pictureElement := (BrAsyncFileWidget new )
		exact: 48@48;
		geometry: (BlCircleGeometry new);
		margin: (BlInsets right: 10)
]

{ #category : #accessing }
GtTwUserSummaryElement >> buildGrayLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			foreground:  Color lightGray)
]

{ #category : #initialization }
GtTwUserSummaryElement >> buildProfilePictureElement [
	^ pictureElement := BrFrame new 
		exact: 48@48;
		geometry: (BlCircleGeometry new);
		margin: (BlInsets right: 10);
	withAsyncFutureDo: [ :anElementFuture | 
		anElementFuture
			whenPending: [ :theContainer | 
				theContainer
					removeChildren ];
			whenError: [ :theContainer :anError | 
				theContainer
					removeChildren;
					addChild:  anError asDebuggableElement matchParent;
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignCenter ] ];
			whenSuccess: [ :theContainer :theElement | 
				theContainer removeChildren.
				theContainer addChild: theElement ] ]
]

{ #category : #'building  - widgets' }
GtTwUserSummaryElement >> buildUserDescriptionElement [
	^ descriptionEditor := BrEditor new
		beReadOnlyWithoutSelection;
		aptitude: BrGlamorousRegularEditorAptitude;
		hMatchParent;
		vFitContent;
		margin: (BlInsets bottom: 5)
]

{ #category : #'building  - widgets' }
GtTwUserSummaryElement >> buildUserDetailsElement [
	| detailsElement |
	
	detailsElement := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	detailsElement 
		addChild: (tweetsCountLabel := self buildGrayLabel);
		addChild: (followingCountLabel := self buildGrayLabel);
		addChild: (followersCountLabel := self buildGrayLabel).
	
	tweetsCountLabel margin: (BlInsets right: 10).
	followingCountLabel margin: (BlInsets right: 10).
	
	^ detailsElement
]

{ #category : #'building  - widgets' }
GtTwUserSummaryElement >> buildUserHeaderElement [
	| headerElement|
	
	headerElement := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	headerElement 
		addChild: (userNameLabel := (BrLabel new 
			aptitude: BrGlamorousLabelAptitude new));
		addChild: (userHandleLabel := self buildGrayLabel).
	
	^ headerElement
]

{ #category : #initialization }
GtTwUserSummaryElement >> initialize [
	| mainContainer contentContainer |
	super initialize.
	
	self 
		hExact: 400;
		vFitContent;
		padding: (BlInsets all: 10).
	
	mainContainer  := BrHorizontalPane new
		hMatchParent;
		vFitContent.
		
	mainContainer addChild:  self buildProfilePictureElement.
	
	contentContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	
	contentContainer addChild:  self buildUserHeaderElement.
	contentContainer addChild:  self buildUserDescriptionElement.	
	contentContainer addChild:  self buildUserDetailsElement.
	
	mainContainer addChild: contentContainer.
	
	self addChild: mainContainer
]

{ #category : #accessing }
GtTwUserSummaryElement >> updateContent [

	pictureElement asyncFuture 
		future: [ self user profileImage asElement ] asAsyncFuture.


	userNameLabel text: self user name.
	userHandleLabel text: '@', self user username.
	
	(self user description 
		ifEmpty: [
			descriptionEditor visibility: BlVisibility gone ] 
		ifNotEmpty:  [
			 descriptionEditor visibility: BlVisibility visible ]).
	descriptionEditor text: self user description.
	
	tweetsCountLabel text: self user tweetCount asString, ' Tweets'.
	followingCountLabel text: self user followingCount asString, ' Following'.
	followersCountLabel text: self user followersCount asString, ' Followers'.
]

{ #category : #accessing }
GtTwUserSummaryElement >> user [

	^ user
]

{ #category : #accessing }
GtTwUserSummaryElement >> user: aUser [

	user := aUser.
	
	self updateContent.
]
