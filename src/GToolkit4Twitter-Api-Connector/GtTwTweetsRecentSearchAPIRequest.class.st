Class {
	#name : #GtTwTweetsRecentSearchAPIRequest,
	#superclass : #GtTwTweetsGroupLookupAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwTweetsRecentSearchAPIRequest >> pathSegments [
	^ { '2' . 'tweets' . 'search' . 'recent' } 
]

{ #category : #accessing }
GtTwTweetsRecentSearchAPIRequest >> query: aString [

	self queryParameterAt: 'query' put: aString
]

{ #category : #accessing }
GtTwTweetsRecentSearchAPIRequest >> responseType [
	^ GtTwGet2TweetsSearchRecentResponse
]
