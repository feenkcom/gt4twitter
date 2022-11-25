Class {
	#name : #GtTwTweetsUserTimelinesAPIRequest,
	#superclass : #GtTwTweetsGroupLookupAPIRequest,
	#instVars : [
		'userId'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #accessing }
GtTwTweetsUserTimelinesAPIRequest >> pathSegments [
	^ { '2' . 'users' . userId asString } 
]

{ #category : #accessing }
GtTwTweetsUserTimelinesAPIRequest >> userId [

	^ userId
]

{ #category : #accessing }
GtTwTweetsUserTimelinesAPIRequest >> userId: aUserId [

	userId := aUserId
]
