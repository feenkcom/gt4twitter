Class {
	#name : #GtTwUsersGroupLookupAPIRequest,
	#superclass : #GtTwUserLookupAPIRequest,
	#category : #'GToolkit4Twitter-Api-Connector-Requests'
}

{ #category : #'query parameters' }
GtTwUsersGroupLookupAPIRequest >> paginationToken [

	^ self queryParameterAt: 'pagination_token'
]

{ #category : #accessing }
GtTwUsersGroupLookupAPIRequest >> paginationToken: aPaginationToken [

	self queryParameterAt: 'pagination_token' put: aPaginationToken
]
