Class {
	#name : #GtTwTweetSummaryListContainerElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'tweetSummaryElement'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #initialization }
GtTwTweetSummaryListContainerElement >> initialize [
	super initialize.
	
	self 
		hMatchParent;
		vFitContent;
		alignCenter.
	
	self addChild: (tweetSummaryElement := GtTwTweetSummaryElement new).
	self addChild: (BrFrame new 
		hExact: 450;
		vExact: 1;
		background: Color veryLightGray  muchLighter )
]

{ #category : #accessing }
GtTwTweetSummaryListContainerElement >> tweet: aTweet [
	tweetSummaryElement tweet: aTweet
]
