Class {
	#name : #GtTwTweetsGroup,
	#superclass : #GtTwEntitiesGroup,
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'gt - extensions' }
GtTwTweetsGroup >> gtViewTweetsListFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Tweets List';
		priority: 10;
		items: [ self ];
		column: 'Created At' text: [ :aTweet | 
			aTweet createdAt printToSeconds ] width: 180;
		column: 'Text' text: [ :aTweet | aTweet text ]
]

{ #category : #'gt - extensions' }
GtTwTweetsGroup >> gtViewTweetsSummaryUIFor: aView [
	<gtView>

	^ aView list
		title: 'Tweets';
		priority: 1;
		items: [ self asyncSimilarCopy ];
		itemStencil: [ 
			GtTwTweetSummaryListContainerElement new ];
		itemDataBinder: [ :aTweetElement :aTweet | 
			aTweetElement tweet: aTweet ].
]
