Class {
	#name : #GtTwTwitterAPIClient,
	#superclass : #GtAcBasicAPIClient,
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwTwitterAPIClient >> authorizedZnClient [
	| znClient |
	self assert: [ self authentication notNil ].
	
	znClient := self znClient.
	self authentication 
		applyAuthenticationOn: znClient .
	
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

{ #category : #'requests creation' }
GtTwTwitterAPIClient >> createUsersIdFollowersRequest: aUserId [ 
	^ (GtTwUsersIdFollowersRequest forApiClient:  self)
		userId: aUserId
]

{ #category : #'requests creation' }
GtTwTwitterAPIClient >> createUsersIdFollowingRequest: aUserId [ 
	^ (GtTwUsersIdFollowingRequest forApiClient:  self)
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

{ #category : #requests }
GtTwTwitterAPIClient >> usersIdFollowersRequest: aUserId [
	^ (self createUsersIdFollowersRequest: aUserId)
		withDefaultConfiguration;
		execute
]

{ #category : #requests }
GtTwTwitterAPIClient >> usersIdFollowingRequest: aUserId [
	^ (self createUsersIdFollowingRequest: aUserId)
		withDefaultConfiguration;
		execute
]
