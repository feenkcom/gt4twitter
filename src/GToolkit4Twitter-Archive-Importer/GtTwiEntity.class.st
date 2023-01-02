Class {
	#name : #GtTwiEntity,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #'gt - extensions' }
GtTwiEntity >> gtRawDataFor: aView [
	<gtView>
	
	self rawData ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Raw data';
		priority: 50;
		object: [ self rawData];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtTwiEntity >> rawData [

	^ rawData
]

{ #category : #accessing }
GtTwiEntity >> rawData: aRawData [

	rawData := aRawData
]

{ #category : #testing }
GtTwiEntity >> rawDataAt: aKey ifAbsent: anAbsentBlock [ 
	self rawData 
		ifNil: [ ^ anAbsentBlock value ].
		
	^ self rawData
		at: aKey
		ifAbsent: [ anAbsentBlock value ]
]
