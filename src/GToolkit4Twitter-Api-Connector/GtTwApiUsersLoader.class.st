Class {
	#name : #GtTwApiUsersLoader,
	#superclass : #GtTwApiDataLoader,
	#category : #'GToolkit4Twitter-Api-Connector-Loader'
}

{ #category : #accessing }
GtTwApiUsersLoader >> getFollowersForUserId: aUserId [
	| usersStream |
	
	usersStream := GtTwUsersPaginatedLoaderStream new 
		initializeWithRequestBuilder: [ 
			| getFollowersRequest |
			getFollowersRequest := self apiContext apiClient 
				createUsersIdFollowersRequest: aUserId.
			getFollowersRequest withDefaultConfiguration ];
		dataInitializer: [ :aRawEntity |
			GtTwUser 
				fromRawUser: aRawEntity
				inContext: self apiContext ].
	
	^ usersStream cached
]

{ #category : #accessing }
GtTwApiUsersLoader >> getFollowingForUserId: aUserId [
	| usersStream |
	
	usersStream := GtTwUsersPaginatedLoaderStream new 
		initializeWithRequestBuilder: [ 
			| getFollowingRequest |
			getFollowingRequest := self apiContext apiClient 
				createUsersIdFollowingRequest: aUserId.
			getFollowingRequest withDefaultConfiguration ];
		dataInitializer: [ :aRawEntity |
			GtTwUser 
				fromRawUser: aRawEntity
				inContext: self apiContext ].
	
	^ usersStream cached
]

{ #category : #accessing }
GtTwApiUsersLoader >> loadUsername: aUsername [
	^ (GtTwUser forApiContext: self apiContext)
		 initializeFromRawUser: ((self apiContext apiClient 
		 	createGetUserByUsernameRequest: aUsername)
				withDefaultConfiguration;
				execute) returnedValue data
]
