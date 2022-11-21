Class {
	#name : #GtTwTwitterAPIConfig,
	#superclass : #GtAcBasicAPIConfig,
	#instVars : [
		'authentication'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwTwitterAPIConfig class >> forDefaultServer [
	^ self new
		serverUrl: 'https://api.twitter.com/' asZnUrl
]

{ #category : #accessing }
GtTwTwitterAPIConfig >> authentication [

	^ authentication
]

{ #category : #accessing }
GtTwTwitterAPIConfig >> authentication: anApiAuthentication [

	authentication := anApiAuthentication
]
