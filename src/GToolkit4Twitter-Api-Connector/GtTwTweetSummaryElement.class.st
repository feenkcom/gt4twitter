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
		'pictureElement'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #accessing }
GtTwTweetSummaryElement >> buildAsyncProfilePictureElement [
	^ pictureElement := (BrAsyncFileWidget new )
		exact: 48@48;
		geometry: (BlCircleGeometry new);
		margin: (BlInsets right: 10)
]

{ #category : #'building widgets' }
GtTwTweetSummaryElement >> buildGrayLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
			foreground:  Color lightGray)
]

{ #category : #'building widgets' }
GtTwTweetSummaryElement >> buildGrayLabelWithText: aText [
	^ self buildGrayLabel
		text: aText
]

{ #category : #accessing }
GtTwTweetSummaryElement >> buildProfilePictureElement [
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
GtTwTweetSummaryElement >> updateContent [
	"pictureElement formBlock: [ 
		self tweet author profileImage ]."
	pictureElement
		removeChildren;
		addChild: (self tweet author profileImage) asElement.
		
	authorNameLabel text: self tweet author name.
	authorHandleLabel text: '@', self tweet author  username.
	
	tweetTextEditor text: self tweet text.
	
	likesCountLabel text: self tweet likesCount asString, ' Likes'.
	retweetsCountLabel text: self tweet retweetsCount asString, ' RT'.
]
