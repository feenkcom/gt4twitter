Class {
	#name : #GtTwUserLookupAPIRequest,
	#superclass : #GtTwTwitterAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUserLookupAPIRequest >> httpMethod [
	^ #GET
]

{ #category : #accessing }
GtTwUserLookupAPIRequest >> pathSegments [
	^ { '2' . 'users' }
]

{ #category : #configuration }
GtTwUserLookupAPIRequest >> withDefaultConfiguration [
	self 
		withPinnedTweetId;
		withAllUserFields
]

{ #category : #configuration }
GtTwUserLookupAPIRequest >> withPinnedTweetId [
	self ensureExpansionField: 'pinned_tweet_id'
]
