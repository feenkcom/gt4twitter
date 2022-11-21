Class {
	#name : #GtTwUser,
	#superclass : #GtTwEntity,
	#instVars : [
		'tweets',
		'rawUser'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model'
}

{ #category : #'instance creation' }
GtTwUser class >> fromRawUser: aRawUser [
	^ self new 
		rawUser: aRawUser
]

{ #category : #initialization }
GtTwUser >> initialize [
	super initialize.
	
	tweets := GtTwTweetsGroup new.
]

{ #category : #accessing }
GtTwUser >> name [
	^ self rawUser name
]

{ #category : #printing }
GtTwUser >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << (self name ifNil: ['-']) ]
]

{ #category : #accessing }
GtTwUser >> rawUser [

	^ rawUser
]

{ #category : #accessing }
GtTwUser >> rawUser: anObject [

	rawUser := anObject
]
