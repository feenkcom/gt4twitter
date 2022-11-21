Class {
	#name : #GtTwUserTweetsTimelineAPIRequest,
	#superclass : #GtTwTweetsTimelinesAPIRequest,
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
