Class {
	#name : #GtTwTweetsPaginatedLoaderStream,
	#superclass : #GtTwPaginatedLoaderStream,
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> cached [
	"Returns a stream that caches items across all #asyncSimilarCopy streams.
	Correctly handles the case when each similar stream is polled from a difference worker process,
	the cache is shared and synchronised between such streams."
	<return: #TAsyncStream>

	^ GtTwTweetsCachedStream forStream: self
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> groupType [
	^ GtTwTweetsGroup 
]

{ #category : #'gt - extensions' }
GtTwTweetsPaginatedLoaderStream >> gtViewTweetsListFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Tweets';
		priority: 1;
		items: [ self asyncSimilarCopy ];
		column: 'Created At' text: [ :aTweet | 
			aTweet createdAt printToSeconds ] width: 180;
		column: 'Text' text: [ :aTweet | aTweet text ];
		actionUpdateButton
]

{ #category : #initialization }
GtTwTweetsPaginatedLoaderStream >> initialize [
	super initialize.
	
	dataInitializer := [ :anEntity | 
		GtTwTweet fromRawTweet: anEntity ]
]
