Class {
	#name : #GtTwTweetsCachedStream,
	#superclass : #GtTwAsyncCachedPaginatedLoaderStream,
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #'gt - extensions' }
GtTwTweetsCachedStream >> gtViewTweetsListFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Tweets List';
		priority: 10;
		items: [ self asyncSimilarCopy ];
		column: 'Created At' text: [ :aTweet | 
			aTweet createdAt printToSeconds ] width: 180;
		column: 'Text' text: [ :aTweet | aTweet text ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwTweetsCachedStream >> gtViewTweetsSummaryUIFor: aView [
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
