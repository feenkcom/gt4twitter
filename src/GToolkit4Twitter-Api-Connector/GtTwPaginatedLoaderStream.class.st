Class {
	#name : #GtTwPaginatedLoaderStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'requests',
		'apiContext'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #accessing }
GtTwPaginatedLoaderStream class >> forApiContext: anApiContext [
	^ self new 
		apiContext: anApiContext
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> apiContext [

	^ apiContext
]

{ #category : #accessing }
GtTwPaginatedLoaderStream >> apiContext: anObject [

	apiContext := anObject
]

{ #category : #'gt - extensions' }
GtTwPaginatedLoaderStream >> gtViewRequestsHistoryFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Requests History';
		items: [ requests ];
		priority: 20;
		column: 'Timestamp' text: [ :aRequest | aRequest timestamp ] width: 220;
		column: 'Request' text: [ :aRequest | aRequest ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwPaginatedLoaderStream >> gtViewResponsesFor: aView [
	"<gtView>"
	
	^ aView list 
		title: 'Results';
		items: [ requests collect: [ :aRequest |
			aRequest requestResult ] ];
		actionUpdateButton
]

{ #category : #logging }
GtTwPaginatedLoaderStream >> logRequest: aRequest [
	requests add: aRequest
]
