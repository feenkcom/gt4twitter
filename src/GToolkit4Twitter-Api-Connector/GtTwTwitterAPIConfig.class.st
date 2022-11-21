Class {
	#name : #GtTwTwitterAPIConfig,
	#superclass : #GtAcBasicAPIConfig,
	#instVars : [
		'bearerToken'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwTwitterAPIConfig class >> forDefaultServer [
	^ self new
		serverUrl: 'https://api.twitter.com/' asZnUrl
]

{ #category : #accessing }
GtTwTwitterAPIConfig >> bearerToken [
	^ bearerToken
]

{ #category : #accessing }
GtTwTwitterAPIConfig >> bearerToken: aBearerToken [
	bearerToken := aBearerToken
]
