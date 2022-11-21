"
nil
"
Class {
	#name : #GtTwFindUserByUsernameAPIRequest,
	#superclass : #GtTwUserLookupAPIRequest,
	#instVars : [
		'username'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwFindUserByUsernameAPIRequest >> pathSegments [
	^ super pathSegments, { 'by' . 'username' . self username }
]

{ #category : #accessing }
GtTwFindUserByUsernameAPIRequest >> responseType [
	^ GtTwGet2UsersByUsernameUsernameResponse
]

{ #category : #accessing }
GtTwFindUserByUsernameAPIRequest >> username [

	^ username
]

{ #category : #accessing }
GtTwFindUserByUsernameAPIRequest >> username: aUserName [

	username := aUserName
]
