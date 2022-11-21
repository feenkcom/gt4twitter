Class {
	#name : #GtTwApiUserLoader,
	#superclass : #GtTwApiDataLoader,
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtTwApiUserLoader >> loadUsername: aUsername [
	^ (GtTwUser forApiContext: self apiContext)
		 initializeFromRawUser: ((self apiContext apiClient 
		 	createGetUserByUsernameRequest: 'chis_andrei')
				withDefaultConfiguration;
				execute) returnedValue data
]
