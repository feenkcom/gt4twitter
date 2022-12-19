Class {
	#name : #GtAcInMemoryToken,
	#superclass : #GtAcApiToken,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #'instance creation' }
GtAcInMemoryToken class >> fromClipboard [
	^ self new 
		value: Clipboard clipboardText asString
]

{ #category : #accessing }
GtAcInMemoryToken >> applyBearerAuthenticationOn: aZincClient [
	self assert: [ value notNil ].
	
	aZincClient setBearerAuthentication: value
]

{ #category : #'gt - extensions' }
GtAcInMemoryToken >> gtInspectorVariableNodesIn: aCollection [
	aCollection
		add: (GtInspectorDynamicNode 
			hostObject: self 
			label: 'value' 
			value: '************')
]

{ #category : #accessing }
GtAcInMemoryToken >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << '**********' ]
]

{ #category : #accessing }
GtAcInMemoryToken >> value: aString [
	self 
		assert: [ aString notNil and: [ value isNil ] ]
		description: 'Token value is immutable'.
	self assert: [ aString isNotEmpty ].
	
	value := aString
]
