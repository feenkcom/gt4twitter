Class {
	#name : #GtTwRawObject,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'instance creation' }
GtTwRawObject class >> fromRawData: aRawData [
	^ self new 
		initializaFromRawData: aRawData
]

{ #category : #'gt - extensions' }
GtTwRawObject >> gtRawDataFor: aView [
	<gtView>
	
	self rawData ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Raw data';
		priority: 75;
		object: [ self rawData];
		view: #gtItemsFor:
]

{ #category : #testing }
GtTwRawObject >> hasNotNilKey: aKey [
	^ self rawData 
		at: aKey
		ifPresent: [ :aValue | aValue ~= nil ]
		ifAbsent: [ false ]
]

{ #category : #initialization }
GtTwRawObject >> initializaFromRawData: aRawData [
	self rawData: aRawData
]

{ #category : #accessing }
GtTwRawObject >> rawData [

	^ rawData
]

{ #category : #accessing }
GtTwRawObject >> rawData: anObject [

	rawData := anObject
]

{ #category : #accessing }
GtTwRawObject >> rawDataAt: aKey [ 
	^ self rawData at: aKey
]

{ #category : #accessing }
GtTwRawObject >> rawDataWithDefaultAt: aString [ 
	^ self rawData 
		at: aString ifAbsent: [ nil ]
]
