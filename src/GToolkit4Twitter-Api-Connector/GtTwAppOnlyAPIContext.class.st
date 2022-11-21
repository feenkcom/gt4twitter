Class {
	#name : #GtTwAppOnlyAPIContext,
	#superclass : #GtTwTwitterAPIContext,
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #'instance creation' }
GtTwAppOnlyAPIContext class >> forBearerToken: aBearerToken [
	^ self forAuthentication:  (GtAcBearerTokenAuthentication new 
		bearerToken: aBearerToken)
]

{ #category : #'instance creation' }
GtTwAppOnlyAPIContext class >> fromClipboard [
	^ self forBearerToken: GtAcBearerToken fromClipboard
]
