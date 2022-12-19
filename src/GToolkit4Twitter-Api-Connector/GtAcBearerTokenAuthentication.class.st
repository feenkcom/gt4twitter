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
	^ self forBearerToken: GtAcApiToken fromClipboard
]

{ #category : #'instance creation' }
GtAcBearerTokenAuthentication class >> fromEnvVar: aVariableName [
	^ self forBearerToken: (GtAcEnvVariableToken fromEnvVar: aVariableName)
]

{ #category : #actions }
GtAcBearerTokenAuthentication >> applyAuthenticationOn: aZincClient [
	self assert: [ self bearerToken notNil ].
	
	self bearerToken applyBearerAuthenticationOn: aZincClient.
]

{ #category : #accessing }
GtAcBearerTokenAuthentication >> bearerToken [
	^ bearerToken
]

{ #category : #accessing }
GtAcBearerTokenAuthentication >> bearerToken: aBearerToken [
	bearerToken := aBearerToken
]
