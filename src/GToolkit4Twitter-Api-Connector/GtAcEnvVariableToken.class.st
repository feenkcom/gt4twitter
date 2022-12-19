Class {
	#name : #GtAcEnvVariableToken,
	#superclass : #GtAcApiToken,
	#instVars : [
		'variableName'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #'instance creation' }
GtAcEnvVariableToken class >> fromEnvVar: aVariableName [
	^ self new 
		variableName: aVariableName
]

{ #category : #accessing }
GtAcEnvVariableToken >> applyBearerAuthenticationOn: aZincClient [
	self assert: [ self variableName notNil ].
	
	aZincClient setBearerAuthentication: self currentValue
]

{ #category : #accessing }
GtAcEnvVariableToken >> currentValue [
	^ OSPlatform current environment 
		at: self variableName
]

{ #category : #accessing }
GtAcEnvVariableToken >> variableName [

	^ variableName
]

{ #category : #accessing }
GtAcEnvVariableToken >> variableName: aVariableName [

	variableName := aVariableName
]
