"
I wrap an exception that happened when executing a request.
"
Class {
	#name : #GtAcExceptionRequestResponse,
	#superclass : #GtAcRequestResponse,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Response'
}

{ #category : #accessing }
GtAcExceptionRequestResponse >> exception [
	^ exception
]

{ #category : #accessing }
GtAcExceptionRequestResponse >> exception: anException [
	exception := anException
]

{ #category : #'gt extensions' }
GtAcExceptionRequestResponse >> gtExceptionMessageFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		  title: 'Message';
		  priority: 2;
		  object: [ self exception ];
		  view: #gtMessageTextFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Exception'
		  tooltip: 'Inspect exception'
		  action: [ :aButton | aButton phlow spawnObject: self exception ]
]

{ #category : #'gt extensions' }
GtAcExceptionRequestResponse >> gtResponseFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].
	(self exception isKindOf: ZnHttpUnsuccessful) ifFalse: [ 
		^ aView empty ].
	^ aView forward
		  title: 'Response';
		  priority: 3;
		  object: [ self exception ];
		  view: #gtResponseFor:
]

{ #category : #'gt extensions' }
GtAcExceptionRequestResponse >> gtResponseHeadersFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].
	(self exception isKindOf: ZnHttpUnsuccessful) ifFalse: [ 
		^ aView empty ].
	^ aView forward
		  title: 'Response Headers';
		  priority: 4;
		  object: [ self exception ];
		  view: #gtResponseHeadersFor:
]

{ #category : #'gt extensions' }
GtAcExceptionRequestResponse >> gtResponseTextContentsFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].
	(self exception isKindOf: ZnHttpUnsuccessful) ifFalse: [ 
		^ aView empty ].
	^ aView forward
		  title: 'Response Contents';
		  priority: 5;
		  object: [ self exception ];
		  view: #gtResponseTextContentsFor:
]

{ #category : #testing }
GtAcExceptionRequestResponse >> isAuthenticationRequired [
	^ self isZincHttpError and: [ 
			self exception response isAuthenticationRequired ]
]

{ #category : #testing }
GtAcExceptionRequestResponse >> isError [
	^ true
]

{ #category : #testing }
GtAcExceptionRequestResponse >> isFailedAssertion [
	^ self exception class = AssertionFailure
]

{ #category : #testing }
GtAcExceptionRequestResponse >> isServerError [
	^ self isZincHttpError and: [ 
			self exception response isError ]
]

{ #category : #testing }
GtAcExceptionRequestResponse >> isZincHttpError [
	^ self exception class = ZnHttpUnsuccessful
]

{ #category : #printing }
GtAcExceptionRequestResponse >> printOn: aStream [

	super printOn: aStream.
	self exception ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: self exception;
		nextPutAll: ', ';
		nextPutAll: self statusLineMessage;
		nextPut: $)
]

{ #category : #accessing }
GtAcExceptionRequestResponse >> statusLineMessage [
	^ self exception printString
]
