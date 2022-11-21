Class {
	#name : #GtTwTweetsPaginatedLoaderStream,
	#superclass : #GtTwPaginatedLoaderStream,
	#instVars : [
		'stream',
		'done',
		'lastResult',
		'requestBuilder'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> createNewRequest [
	| newRequest| 
	newRequest := requestBuilder value.
	
	lastResult ifNotNil: [
		lastResult returnedValue hasNextPaginationToken ifTrue: [
			newRequest 
				paginationToken: lastResult returnedValue nextPaginationToken ] ].
	
	^ newRequest
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> executeNewRequest [
	| newRequest | 
	newRequest := self createNewRequest.	
	self logRequest: newRequest.
	
	^ newRequest execute
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> extractValuesFromResult: aRequestResult [ 
	^ GtTwTweetsGroup withAll: (aRequestResult returnedValue data 
		collect: [ :aRawTweet |
			GtTwTweet  fromRawTweet:  aRawTweet ])
]

{ #category : #'gt - extensions' }
GtTwTweetsPaginatedLoaderStream >> gtViewTweetGroupsFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Tweet Groups';
		priority: 15;
		items: [ requests collect: [ :aRequest |
			aRequest requestResult returnedValue ] ];
		actionUpdateButton
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> gtViewTweetsFor: aView [
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

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> hasNextPage [
	lastResult ifNil: [ ^ false ].
	
	^ lastResult returnedValue hasNextPaginationToken
]

{ #category : #testing }
GtTwTweetsPaginatedLoaderStream >> hasSuccessfulResult [
	^ lastResult notNil
]

{ #category : #initialization }
GtTwTweetsPaginatedLoaderStream >> initializeForRequestBuilder: aRequestBuilder [
	requestBuilder := aRequestBuilder.
	
	lastResult := nil.
	done := false.
	stream := nil.
	
	requests := OrderedCollection new.
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> loadInitialValues [

	^ self retrieveValues
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> loadNextValues [
	self hasSuccessfulResult ifFalse: [ 
		done := true.
		^ #() ].

	self hasNextPage ifFalse: [ 
		done := true.
		^ #() ].

	^ self retrieveValues
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."

	<return: #AsyncPoll>
	requestBuilder ifNil: [ 
		^ AsyncPoll ready: AsyncOptionalValue none ].
	
	stream ifNil: [ 
		stream := AsyncSequenceStream
			forCollection: [ self loadInitialValues ] asAsyncFuture ].

	^ (stream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll | 
			aReadyPoll value
				ifSome: [ aReadyPoll ]
				ifNone: [ done
					ifTrue: [ aReadyPoll ]
					ifFalse: [ 
						stream := AsyncSequenceStream
							forCollection: [ self loadNextValues ] asAsyncFuture.
						stream pollNext: anAsynchronousContext ] ] ]
		ifPending: [ :aPendingPoll | aPendingPoll ]
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"

	requestBuilder ifNotNil: [
		self initializeForRequestBuilder: requestBuilder ]
]

{ #category : #accessing }
GtTwTweetsPaginatedLoaderStream >> retrieveValues [
	
	lastResult := self executeNewRequest.

	self hasSuccessfulResult ifFalse: [ 
		done := true.
		^ #() ].

	^ self extractValuesFromResult: lastResult
]
