Class {
	#name : #GtTwTwitterAPIContext,
	#superclass : #Object,
	#instVars : [
		'apiClient'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #'instance creation' }
GtTwTwitterAPIContext class >> forAuthentication: anApiAuthentication [ 
	^ self new 
		initializeForAuthentication: anApiAuthentication 	
]

{ #category : #accessing }
GtTwTwitterAPIContext >> apiClient [
	^ apiClient
]

{ #category : #initialization }
GtTwTwitterAPIContext >> initializeForAuthentication: anApiAuthentication [
	 apiClient := GtTwTwitterAPIClient new 
		configuration: (GtTwTwitterAPIConfig forDefaultServer
			authentication: anApiAuthentication) 
]

{ #category : #accessing }
GtTwTwitterAPIContext >> tweetsLoader [
	^ GtTwApiTweetsLoader forApiContext: self
]

{ #category : #accessing }
GtTwTwitterAPIContext >> userLoader [
	^ GtTwApiUserLoader forApiContext: self
]
