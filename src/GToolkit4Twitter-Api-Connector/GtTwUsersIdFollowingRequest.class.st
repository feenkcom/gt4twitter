Class {
	#name : #GtTwUsersIdFollowingRequest,
	#superclass : #GtTwUsersGroupLookupAPIRequest,
	#instVars : [
		'userId'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUsersIdFollowingRequest >> pathSegments [
	^ super pathSegments, { self userId . 'following' }
]

{ #category : #accessing }
GtTwUsersIdFollowingRequest >> responseType [
	^ GtTwRawGet2UsersIdFollowingResponse
]

{ #category : #accessing }
GtTwUsersIdFollowingRequest >> userId [

	^ userId
]

{ #category : #accessing }
GtTwUsersIdFollowingRequest >> userId: aUserId [

	userId := aUserId
]
