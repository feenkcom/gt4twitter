"
I model a generic result of making a zinc request.

My main purpose is to wrap an error or a normal Zinc response.
"
Class {
	#name : #GtAcRequestResponse,
	#superclass : #Object,
	#category : #'GToolkit4Twitter-Api-Connector-Response'
}

{ #category : #testing }
GtAcRequestResponse >> isError [
	^ false
]

{ #category : #testing }
GtAcRequestResponse >> isSuccess [
	^ false
]

{ #category : #'accessing - response' }
GtAcRequestResponse >> statusLineMessage [
	
	^ self subclassResponsibility
]
