"
nil
"
Class {
	#name : #GtTwTwitterAPIRequest,
	#superclass : #GtAcBasicAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'accessing - config values' }
GtTwTwitterAPIRequest >> allUserFields [
	^ #(created_at description entities id location name pinned_tweet_id profile_image_url protected public_metrics url username verified withheld)
]

{ #category : #accessing }
GtTwTwitterAPIRequest >> configureQueryFielsFor: aZincClient [

	queryFields keysAndValuesDo: [:k :v |
		aZincClient 
			queryAt: k 
			put: (self formattedQueryValueFor:v) ]
]

{ #category : #accessing }
GtTwTwitterAPIRequest >> configuredZincClient [
	| zincClient |
	
	zincClient := self authorizedZnClient. 
	zincClient url: self serverUrl.
	zincClient accept: ZnMimeType applicationJson. 
	
	self pathSegments do: [ :aPathSegment |
		zincClient addPath: aPathSegment ].
	
	self configureQueryFielsFor: zincClient.
		
	^ zincClient
]

{ #category : #configuration }
GtTwTwitterAPIRequest >> ensureExpansionField: aField [ 
	| expansionFields |
	expansionFields := queryFields 
		at: 'expansions' 
		ifAbsentPut: [ OrderedCollection new].	
	(expansionFields includes: aField )ifFalse: [
		expansionFields add: aField ].
]

{ #category : #'gt - extensions' }
GtTwTwitterAPIRequest >> gtViewPathSegmentsFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Path Segments';
		object: [ self pathSegments ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtTwTwitterAPIRequest >> parserResponseContents: aContent [
	^ self responseType  
		fromJsonString: aContent
]

{ #category : #accessing }
GtTwTwitterAPIRequest >> pathSegments [
	^ {}
]

{ #category : #accessing }
GtTwTwitterAPIRequest >> responseType [
	self subclassResponsibility 
]

{ #category : #'query parameters' }
GtTwTwitterAPIRequest >> userFields: aListOfUserFields [
	queryFields at: 'user.fields' put: aListOfUserFields.
]

{ #category : #configuration }
GtTwTwitterAPIRequest >> withAllUserFields [
	self userFields: self allUserFields
]

{ #category : #configuration }
GtTwTwitterAPIRequest >> withAuthorIdExpanded [
	self ensureExpansionField: 'author_id'.
]
