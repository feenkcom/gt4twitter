Class {
	#name : #GtTwTweetSummaryElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'tweetTextEditor',
		'tweet',
		'retweetsCountLabel',
		'likesCountLabel',
		'tweetDateLabel',
		'authorNameLabel',
		'authorHandleLabel',
		'pictureElement',
		'mediaContainer'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #'building widgets' }
GtTwTweetSummaryElement >> buildGrayLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			foreground:  Color lightGray)
]

{ #category : #accessing }
GtTwTweetSummaryElement >> buildProfilePictureElement [
	^ pictureElement := GtTwUserPictureElement new
		margin: (BlInsets right: 10)
]

{ #category : #initialization }
GtTwTweetSummaryElement >> buildTweetContentElement [
	^ (tweetTextEditor := BrEditor new
		beReadOnlyWithoutSelection;
		aptitude: BrGlamorousRegularEditorAptitude;
		hMatchParent;
		vFitContent;
		margin: (BlInsets bottom: 10) )
]

{ #category : #'building widgets' }
GtTwTweetSummaryElement >> buildTweetDetailsElement [
	| detailsElement|
	
	detailsElement := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	detailsElement 
		addChild: (retweetsCountLabel := self buildGrayLabel);
		addChild: (likesCountLabel := self buildGrayLabel)";
		addChild: (tweetDateLabel := self buildGrayLabel)".
		
	retweetsCountLabel margin: (BlInsets right: 10).
	
	^ detailsElement
]

{ #category : #initialization }
GtTwTweetSummaryElement >> buildTweetMediaElement [
	^ (mediaContainer := BrHorizontalPane new hMatchParent; vExact: 200)
]

{ #category : #'building widgets' }
GtTwTweetSummaryElement >> buildUserHeaderElement [
	| headerElement|
	
	headerElement := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	
	headerElement 
		addChild: (authorNameLabel := (BrLabel new 
			aptitude: BrGlamorousLabelAptitude new));
		addChild: (authorHandleLabel := self buildGrayLabel).
	
	^ headerElement
]

{ #category : #initialization }
GtTwTweetSummaryElement >> initialize [
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
	
	contentContainer addChild: self buildUserHeaderElement.
	contentContainer addChild: self buildTweetContentElement.
	contentContainer addChild: self buildTweetMediaElement.
	contentContainer addChild: self buildTweetDetailsElement.
	
	mainContainer addChild: contentContainer.
	self addChild:  mainContainer.
]

{ #category : #accessing }
GtTwTweetSummaryElement >> tweet [
	^ tweet
]

{ #category : #accessing }
GtTwTweetSummaryElement >> tweet: aTweet [
	tweet := aTweet.
	
	self updateContent
]

{ #category : #accessing }
GtTwTweetSummaryElement >> updateAuthorDetails [
	self tweet author ifNil: [
		authorNameLabel text: '<missing>'.
		authorHandleLabel text: ''.
		^ self ].
	
	authorNameLabel text: self tweet author name.
	authorHandleLabel text: '@', self tweet author  username.
]

{ #category : #accessing }
GtTwTweetSummaryElement >> updateContent [
	pictureElement user: self tweet author.
	self updateAuthorDetails.
	tweetTextEditor text: self tweet text.
	self updateMedia.
	likesCountLabel text: self tweet likesCount asString , ' Likes'.
	retweetsCountLabel text: self tweet retweetsCount asString , ' RT'
]

{ #category : #accessing }
GtTwTweetSummaryElement >> updateMedia [
	self tweet hasPhotos ifFalse: [ mediaContainer visibility: BlVisibility gone ].
	(self tweet mediaItems select: #isPhoto)
		do: [ :each | mediaContainer addChild: each asElement ]
]
