"
nil
"
Class {
	#name : 'GtTwFindUserByIdAPIRequest',
	#superclass : 'GtTwSingleUserLookupAPIRequest',
	#instVars : [
		'userId'
	],
	#category : 'GToolkit4Twitter-Api-Connector-Requests',
	#package : 'GToolkit4Twitter-Api-Connector',
	#tag : 'Requests'
}

{ #category : 'accessing' }
GtTwFindUserByIdAPIRequest >> pathSegments [
	^ super pathSegments, { self userId }
]

{ #category : 'accessing' }
GtTwFindUserByIdAPIRequest >> responseType [
	^ GtTwGet2UsersIdResponse
]

{ #category : 'accessing' }
GtTwFindUserByIdAPIRequest >> userId [

	^ userId
]

{ #category : 'accessing' }
GtTwFindUserByIdAPIRequest >> userId: aUserId [

	userId := aUserId
]
