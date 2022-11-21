"
nil
"
Class {
	#name : #GtAcBearerToken,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #accessing }
GtAcBearerToken class >> fromClipboard [
	^ self new 
		value: Clipboard clipboardText asString
]

{ #category : #'gt - extensions' }
GtAcBearerToken >> gtInspectorVariableNodesIn: aCollection [
	aCollection
		add: (GtInspectorDynamicNode 
			hostObject: self 
			label: 'value' 
			value: '************')
]

{ #category : #accessing }
GtAcBearerToken >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << '**********' ]
]

{ #category : #accessing }
GtAcBearerToken >> value [

	^ value
]

{ #category : #accessing }
GtAcBearerToken >> value: aString [
	self 
		assert: [ aString notNil and: [ value isNil ] ]
		description: 'Token value is immutable'.
	self assert: [ aString isNotEmpty ].
	
	value := aString
]
