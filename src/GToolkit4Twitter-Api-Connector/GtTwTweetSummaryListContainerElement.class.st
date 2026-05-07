Class {
	#name : 'GtTwTweetSummaryListContainerElement',
	#superclass : 'BrVerticalPane',
	#instVars : [
		'tweetSummaryElement'
	],
	#category : 'GToolkit4Twitter-Api-Connector-UI',
	#package : 'GToolkit4Twitter-Api-Connector',
	#tag : 'UI'
}

{ #category : 'initialization' }
GtTwTweetSummaryListContainerElement >> initialize [
	super initialize.

	self
		hMatchParent;
		vFitContent;
		alignCenter.
	self
		addChild: (tweetSummaryElement := GtTwTweetSummaryElement new
					addAptitude: BrShadowAptitude;
					background: Color white;
					margin: (BlInsets all: 10))
]

{ #category : 'accessing' }
GtTwTweetSummaryListContainerElement >> tweet: aTweet [
	tweetSummaryElement tweet: aTweet
]
