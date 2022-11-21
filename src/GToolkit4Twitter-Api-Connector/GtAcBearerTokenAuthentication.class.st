Class {
	#name : #GtAcBearerTokenAuthentication,
	#superclass : #GtAcBasicApiAuthentication,
	#instVars : [
		'bearerToken'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #'instance creation' }
GtAcBearerTokenAuthentication class >> forBearerToken: aBearerToken [
	^ self new 
		bearerToken:  aBearerToken 
]

{ #category : #'instance creation' }
GtAcBearerTokenAuthentication class >> fromClipboard [
	^ self forBearerToken: GtAcBearerToken fromClipboard
]

{ #category : #actions }
GtAcBearerTokenAuthentication >> applyAuthenticationOn: aZincClient [
	self assert: [ self bearerToken notNil ].
	self assert: [ self bearerToken value notNil ].
	
	aZincClient setBearerAuthentication: self bearerToken value
]

{ #category : #accessing }
GtAcBearerTokenAuthentication >> bearerToken [
	^ bearerToken
]

{ #category : #accessing }
GtAcBearerTokenAuthentication >> bearerToken: aBearerToken [
	bearerToken := aBearerToken
]
