Class {
	#name : #GtTwUserTweetsTimelineAPIRequest,
	#superclass : #GtTwTweetsUserTimelinesAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUserTweetsTimelineAPIRequest >> pathSegments [
	^ super pathSegments, { 'tweets' }
]

{ #category : #accessing }
GtTwUserTweetsTimelineAPIRequest >> responseType [
	^ GtTwGet2UsersIdTweetsResponse
]
