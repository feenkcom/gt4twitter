Class {
	#name : #GtTwUserTimelineAPIRequest,
	#superclass : #GtTwTweetsUserTimelinesAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUserTimelineAPIRequest >> pathSegments [
	^ super pathSegments, { 'timelines' . 'reverse_chronological' }
]

{ #category : #accessing }
GtTwUserTimelineAPIRequest >> responseType [
	^ GtTwGet2UsersIdTimelinesReverseChronologicalResponse
]
