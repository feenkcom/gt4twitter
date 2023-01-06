Class {
	#name : #GtTwiTweetsGroup,
	#superclass : #GtTwiEntitiesGroup,
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiTweetsGroup >> gtItemsFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Tweets';
		priority: 10;
		items: [ self ];
		column: 'Text' text: [ :aTweet | aTweet text ];
		column: 'Date' text: [ :aTweet | aTweet creationDate ]
]

{ #category : #accessing }
GtTwiTweetsGroup >> gtViewTweetsTimelineFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Timeline';
		priority: 10;
		items: [ self ];
		itemStencil: [ GtTwTweetSummaryListContainerElement new ];
		itemDataBinder: [ :aTweetElement :aTweet |
			aTweetElement tweet: aTweet ]
]

{ #category : #accessing }
GtTwiTweetsGroup >> retweets [
	^ self select: #isRetweet
]
