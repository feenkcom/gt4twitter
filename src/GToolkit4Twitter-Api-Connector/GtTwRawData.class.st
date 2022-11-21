Class {
	#name : #GtTwRawData,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #'instance creation' }
GtTwRawData class >> fromRawData: aRawData [
	^ self new 
		initializaFromRawData: aRawData
]

{ #category : #'gt - extensions' }
GtTwRawData >> gtRawDataFor: aView [
	<gtView>
	
	self rawData ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Raw data';
		priority: 75;
		object: [ self rawData];
		view: #gtItemsFor:
]

{ #category : #testing }
GtTwRawData >> hasNotNilKey: aKey [
	^ self rawData 
		at: aKey
		ifPresent: [ :aValue | aValue ~= nil ]
		ifAbsent: [ false ]
]

{ #category : #initialization }
GtTwRawData >> initializaFromRawData: aRawData [
	self rawData: aRawData
]

{ #category : #accessing }
GtTwRawData >> rawData [

	^ rawData
]

{ #category : #accessing }
GtTwRawData >> rawData: anObject [

	rawData := anObject
]

{ #category : #accessing }
GtTwRawData >> rawDataAt: aKey [ 
	^ self rawData at: aKey
]

{ #category : #accessing }
GtTwRawData >> rawDataWithDefaultAt: aString [ 
	^ self rawData 
		at: aString ifAbsent: [ nil ]
]
