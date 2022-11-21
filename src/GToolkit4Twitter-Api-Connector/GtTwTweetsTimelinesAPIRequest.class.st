Class {
	#name : #GtTwTweetsTimelinesAPIRequest,
	#superclass : #GtTwTwitterAPIRequest,
	#instVars : [
		'userId'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'accessing - config values' }
GtTwTweetsTimelinesAPIRequest >> allPublicMediaFields [
	^ #(duration_ms height media_key preview_image_url type url width public_metrics)
]

{ #category : #'accessing - config values' }
GtTwTweetsTimelinesAPIRequest >> allPublicTweetFields [
	^ #(attachments author_id context_annotations conversation_id created_at entities geo id in_reply_to_user_id lang public_metrics possibly_sensitive referenced_tweets reply_settings source text withheld)
]

{ #category : #accessing }
GtTwTweetsTimelinesAPIRequest >> httpMethod [
	^ #GET
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> maxResults [

	^ self queryParameterAt: 'max_results' ifAbsentPut: [ 50 ]
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> maxResults: anInteger [

	self queryParameterAt: 'max_results' put: anInteger
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> mediaFields: aListOfMediaFields [
	self ensureExpansionField: 'attachments.media_keys'.
	queryFields at: 'media.fields' put: aListOfMediaFields.
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> paginationToken [

	^ self queryParameterAt: 'pagination_token'
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> paginationToken: aPaginationToken [

	self queryParameterAt: 'pagination_token' put: aPaginationToken
]

{ #category : #accessing }
GtTwTweetsTimelinesAPIRequest >> parserResponseContents: aContent [
	^ GtTwRawTweetsGroupResponse 
		fromJsonString: aContent
]

{ #category : #accessing }
GtTwTweetsTimelinesAPIRequest >> pathSegments [
	^ { '2' . 'users' . userId asString } 
]

{ #category : #'query parameters' }
GtTwTweetsTimelinesAPIRequest >> tweetFields: aListOfTweetFields [
	queryFields at: 'tweet.fields' put: aListOfTweetFields.
]

{ #category : #accessing }
GtTwTweetsTimelinesAPIRequest >> userId [

	^ userId
]

{ #category : #accessing }
GtTwTweetsTimelinesAPIRequest >> userId: aUserId [

	userId := aUserId
]

{ #category : #configuration }
GtTwTweetsTimelinesAPIRequest >> withAllPublicMediaFields [
	self mediaFields: self allPublicMediaFields
]

{ #category : #configuration }
GtTwTweetsTimelinesAPIRequest >> withAllPublicTweetFields [
	self tweetFields: self allPublicTweetFields
]

{ #category : #configuration }
GtTwTweetsTimelinesAPIRequest >> withDefaultConfiguration [
	self maxResults: 50.
	
	self withAllPublicTweetFields.
	self withAllPublicMediaFields.
	
	self withAuthorIdExpanded.
	self withAllUserFields.
]
