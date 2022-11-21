Class {
	#name : #GtTwTwitterAPIClient,
	#superclass : #GtAcBasicAPIClient,
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwTwitterAPIClient >> authorizedZnClient [
	| znClient |
	self assert: [ self bearerToken notNil ].
	
	znClient := self znClient.
	znClient setBearerAuthentication: self bearerToken value.
	
	^ znClient
]

{ #category : #'requests creation' }
GtTwTwitterAPIClient >> createGetUserByIdRequest: aUserId [ 
	^ (GtTwFindUserByIdAPIRequest forApiClient:  self)
		userId: aUserId
]

{ #category : #'requests creation' }
GtTwTwitterAPIClient >> createGetUserByUsernameRequest: aUsername [ 
	^ (GtTwFindUserByUsernameAPIRequest forApiClient:  self)
		username: aUsername
]

{ #category : #'requests creation' }
GtTwTwitterAPIClient >> createGetUserTweetsTimelineRequest: aUserId [ 
	^ (GtTwUserTweetsTimelineAPIRequest forApiClient:  self)
		userId: aUserId
]

{ #category : #requests }
GtTwTwitterAPIClient >> getUserByIdFor: aUserId [
	^ (self createGetUserByIdRequest: aUserId)
		withDefaultConfiguration;
		execute
]

{ #category : #requests }
GtTwTwitterAPIClient >> getUserByUsernameFor: aUsername [
	^ (self createGetUserByUsernameRequest: aUsername)
		withDefaultConfiguration;
		execute
]

{ #category : #requests }
GtTwTwitterAPIClient >> getUserTweetsTimelineFor: aUserId [
	^ (self createGetUserTweetsTimelineRequest: aUserId)
		withDefaultConfiguration;
		execute
]
