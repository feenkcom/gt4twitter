Class {
	#name : #GtTwPaginatedLoaderStream,
	#superclass : #GtTwDataStream,
	#instVars : [
		'stream',
		'done',
		'lastResult',
		'requestBuilder',
		'dataInitializer',
		'requests'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #'instance creation' }
GtTwPaginatedLoaderStream class >> forRequestBuilder: aRequestBuilder [ 
	^ self new 
		initializeWithRequestBuilder: aRequestBuilder
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> createNewRequest [
	| newRequest | 
	newRequest := requestBuilder value.
	
	lastResult ifNotNil: [
		lastResult returnedValue hasNextPaginationToken ifTrue: [
			newRequest 
				paginationToken: lastResult returnedValue nextPaginationToken ] ].
	
	^ newRequest
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> dataInitializer: aBlock [
	dataInitializer := aBlock
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> executeNewRequest [
	| newRequest | 
	newRequest := self createNewRequest.	
	self logRequest: newRequest.
	
	^ newRequest execute
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> extractValuesFromResult: aRequestResult [ 
	^ self groupType withAll: (self 
		extractValuesFromReturnedValue: aRequestResult returnedValue)
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> extractValuesFromReturnedValue: aReturnedValue [
	^ aReturnedValue data collect: [ :aRawTweetData |
			dataInitializer 
				cull: aRawTweetData 
				cull: aReturnedValue ]
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> groupType [
	^ OrderedCollection 
]

{ #category : #'gt - extensions' }
GtTwPaginatedLoaderStream >> gtViewRequestsHistoryFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Requests History';
		items: [ requests ];
		priority: 20;
		column: 'Timestamp' text: [ :aRequest | aRequest timestamp ] width: 220;
		column: 'Request' text: [ :aRequest | aRequest ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwPaginatedLoaderStream >> gtViewResponsesFor: aView [
	"<gtView>"
	
	^ aView list 
		title: 'Results';
		items: [ requests collect: [ :aRequest |
			aRequest requestResult ] ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwPaginatedLoaderStream >> gtViewReturnedValuesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Returned Values';
		priority: 15;
		items: [ requests collect: [ :aRequest |
			aRequest requestResult returnedValue ] ];
		actionUpdateButton
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> hasNextPage [
	lastResult ifNil: [ ^ false ].
	
	^ lastResult returnedValue hasNextPaginationToken
]

{ #category : #testing }
GtTwPaginatedLoaderStream >> hasSuccessfulResult [
	^ lastResult notNil
]

{ #category : #initialization }
GtTwPaginatedLoaderStream >> initialize [
	super initialize.
	
	dataInitializer := [ :anEntity | anEntity ]
]

{ #category : #initialization }
GtTwPaginatedLoaderStream >> initializeWithRequestBuilder: aRequestBuilder [
	requestBuilder := aRequestBuilder.
	
	lastResult := nil.
	done := false.
	stream := nil.
	
	requests := OrderedCollection new.
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> loadInitialValues [

	^ self retrieveValues
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> loadNextValues [
	self hasSuccessfulResult ifFalse: [ 
		done := true.
		^ #() ].

	self hasNextPage ifFalse: [ 
		done := true.
		^ #() ].

	^ self retrieveValues
]

{ #category : #logging }
GtTwPaginatedLoaderStream >> logRequest: aRequest [
	requests add: aRequest
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> pollNext: anAsynchronousContext [
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
GtTwPaginatedLoaderStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"

	requestBuilder ifNotNil: [
		self initializeWithRequestBuilder: requestBuilder ]
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> retrieveValues [
	
	lastResult := self executeNewRequest.

	self hasSuccessfulResult ifFalse: [ 
		done := true.
		^ #() ].

	^ self extractValuesFromResult: lastResult
]
