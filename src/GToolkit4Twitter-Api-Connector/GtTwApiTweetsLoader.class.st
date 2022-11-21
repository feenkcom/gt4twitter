Class {
	#name : #GtTwApiTweetsLoader,
	#superclass : #GtTwApiDataLoader,
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwApiTweetsLoader >> getTimelineTweetsForUserId: aUserId [
	| tweetsStream |
	tweetsStream := (GtTwTweetsPaginatedLoaderStream forApiContext: self apiContext)
		initializeWithRequestBuilder: [ :aContext |
			| getTweetsRequest |
			getTweetsRequest := aContext apiClient 
				createGetUserTweetsTimelineRequest: aUserId.
			getTweetsRequest withDefaultConfiguration ].
	^ tweetsStream cached
]
