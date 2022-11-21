"
I wrap a zinc result obtained as a result of a zinc request.
"
Class {
	#name : #GtAcZincRequestResponse,
	#superclass : #GtAcRequestResponse,
	#instVars : [
		'zincResponse',
		'contents'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Response'
}

{ #category : #accessing }
GtAcZincRequestResponse >> code [
	^ self zincResponse code
]

{ #category : #accessing }
GtAcZincRequestResponse >> contents [
	^ contents
]

{ #category : #accessing }
GtAcZincRequestResponse >> contents: anObject [
	contents := anObject
]

{ #category : #'gt extensions' }
GtAcZincRequestResponse >> gtContentsFor: aView [
	<gtView>
	
	self contents ifNil: [ ^ aView empty ].
	
	^ aView forward
		  title: 'Contents';
		  priority: 1;
		  object: [ self contents ];
		  view: #gtLiveFor:
]

{ #category : #'gt extensions' }
GtAcZincRequestResponse >> gtViewJsonResponseFor: aView [ 
	<gtView>
	
	zincResponse ifNil: [ ^ aView empty ].
	
	^ zincResponse gtJsonFor: aView
]

{ #category : #testing }
GtAcZincRequestResponse >> isAuthenticationRequired [
	^ self zincResponse isAuthenticationRequired
]

{ #category : #testing }
GtAcZincRequestResponse >> isSuccess [
	<return: #Boolean>
	^ self zincResponse isSuccess
]

{ #category : #'accessing - response' }
GtAcZincRequestResponse >> statusLineMessage [
	^ (String streamContents: [ :aStream | 
			self zincResponse statusLine writeOn: aStream ])
]

{ #category : #accessing }
GtAcZincRequestResponse >> zincResponse [
	^ zincResponse
]

{ #category : #accessing }
GtAcZincRequestResponse >> zincResponse: aZnResponse [
	self assert: [ zincResponse isNil and: [ aZnResponse notNil ] ].
	zincResponse := aZnResponse
]
