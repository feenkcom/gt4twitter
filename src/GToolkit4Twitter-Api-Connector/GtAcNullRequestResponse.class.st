"
I model a null object.
"
Class {
	#name : #GtAcNullRequestResponse,
	#superclass : #GtAcRequestResponse,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Response'
}

{ #category : #cleanup }
GtAcNullRequestResponse class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
GtAcNullRequestResponse class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'accessing - response' }
GtAcNullRequestResponse >> statusLineMessage [
	<return: #String>
	^ ''
]
