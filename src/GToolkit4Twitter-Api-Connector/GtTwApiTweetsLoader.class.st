Class {
	#name : #GtTwApiTweetsLoader,
	#superclass : #GtTwApiDataLoader,
	#category : #'GToolkit4Twitter-Api-Connector-Loader'
}

{ #category : #accessing }
GtTwApiTweetsLoader >> createTimelineTweetsStreamForUserId: aUserId [
	^ GtTwTweetsPaginatedLoaderStream new
		initializeWithRequestBuilder: [ 
			| getTweetsRequest |
			getTweetsRequest := self apiContext apiClient 
				createGetUserTweetsTimelineRequest: aUserId.
			getTweetsRequest withDefaultConfiguration ]
]

{ #category : #accessing }
GtTwApiTweetsLoader >> getTimelineTweetsForUser: aUser [
	| tweetsStream |
	tweetsStream := self createTimelineTweetsStreamForUserId: aUser id.
	tweetsStream 
		dataInitializer: [ :aRawEntity |
			(GtTwTweet 
				fromRawTweet: aRawEntity
				inContext: self apiContext)
					author: aUser ].
	^ tweetsStream cached
]

{ #category : #accessing }
GtTwApiTweetsLoader >> getTimelineTweetsForUserId: aUserId [
	| tweetsStream |
	tweetsStream := self createTimelineTweetsStreamForUserId: aUserId.
	tweetsStream 
		dataInitializer: [ :aRawEntity |
			GtTwTweet 
				fromRawTweet: aRawEntity
				inContext: self apiContext ].
	^ tweetsStream cached
]
