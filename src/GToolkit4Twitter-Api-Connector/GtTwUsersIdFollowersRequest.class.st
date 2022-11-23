Class {
	#name : #GtTwUsersIdFollowersRequest,
	#superclass : #GtTwUsersGroupLookupAPIRequest,
	#instVars : [
		'userId'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwUsersIdFollowersRequest >> pathSegments [
	^ super pathSegments, { self userId . 'followers' }
]

{ #category : #accessing }
GtTwUsersIdFollowersRequest >> responseType [
	^ GtTwRawGet2UsersIdFollowersResponse
]

{ #category : #accessing }
GtTwUsersIdFollowersRequest >> userId [

	^ userId
]

{ #category : #accessing }
GtTwUsersIdFollowersRequest >> userId: aUserId [

	userId := aUserId
]
