Class {
	#name : #GtTwTweetsGroupLookupAPIRequest,
	#superclass : #GtTwTwitterAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'accessing - config values' }
GtTwTweetsGroupLookupAPIRequest >> allPublicMediaFields [
	^ #(duration_ms height media_key preview_image_url type url width public_metrics)
]

{ #category : #'accessing - config values' }
GtTwTweetsGroupLookupAPIRequest >> allPublicTweetFields [
	^ #(attachments author_id context_annotations conversation_id created_at entities geo id in_reply_to_user_id lang public_metrics possibly_sensitive referenced_tweets reply_settings source text withheld)
]

{ #category : #accessing }
GtTwTweetsGroupLookupAPIRequest >> httpMethod [
	^ #GET
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> maxResults [

	^ self queryParameterAt: 'max_results' ifAbsentPut: [ 50 ]
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> maxResults: anInteger [

	self queryParameterAt: 'max_results' put: anInteger
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> mediaFields: aListOfMediaFields [
	self ensureExpansionField: 'attachments.media_keys'.
	queryFields at: 'media.fields' put: aListOfMediaFields.
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> paginationToken [

	^ self queryParameterAt: 'pagination_token'
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> paginationToken: aPaginationToken [

	self queryParameterAt: 'pagination_token' put: aPaginationToken
]

{ #category : #accessing }
GtTwTweetsGroupLookupAPIRequest >> parserResponseContents: aContent [
	^ GtTwRawTweetsGroupResponse 
		fromJsonString: aContent
]

{ #category : #'query parameters' }
GtTwTweetsGroupLookupAPIRequest >> tweetFields: aListOfTweetFields [
	queryFields at: 'tweet.fields' put: aListOfTweetFields.
]

{ #category : #configuration }
GtTwTweetsGroupLookupAPIRequest >> withAllPublicMediaFields [
	self mediaFields: self allPublicMediaFields
]

{ #category : #configuration }
GtTwTweetsGroupLookupAPIRequest >> withAllPublicTweetFields [
	self tweetFields: self allPublicTweetFields
]

{ #category : #configuration }
GtTwTweetsGroupLookupAPIRequest >> withDefaultConfiguration [
	self maxResults: 50.
	
	self withAllPublicTweetFields.
	self withAllPublicMediaFields.
	
	self withAuthorIdExpanded.
	self withAllUserFields.
]
