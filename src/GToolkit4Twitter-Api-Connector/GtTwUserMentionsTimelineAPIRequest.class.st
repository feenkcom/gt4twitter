"
nil
"
Class {
	#name : #GtTwUserMentionsTimelineAPIRequest,
	#superclass : #GtTwTweetsUserTimelinesAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUserMentionsTimelineAPIRequest >> pathSegments [
	^ super pathSegments, { 'mentions' }
]

{ #category : #accessing }
GtTwUserMentionsTimelineAPIRequest >> responseType [
	^ GtTwGet2UsersIdMentionsResponse
]
