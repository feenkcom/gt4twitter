Class {
	#name : #GtTwiEntitiesGroup,
	#superclass : #Object,
	#traits : 'TGtGroup + TGtGroupItems',
	#classTraits : 'TGtGroup classTrait + TGtGroupItems classTrait',
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiEntitiesGroup >> groupedBy: aBlock [ 
	"We are reimplementing this method here and not reuse the one in collection
	because we want the keys to be groups, not simple collections"
	
	| result |
	result := Dictionary new.
	self do:
		[:each | | key collection |
		key := aBlock value: each.
		collection := result at: key ifAbsentPut: [ OrderedCollection new] .
		collection add: each ].
	result keysAndValuesDo: [:key :value | 
		result at: key put: (self species withAll: value)].

	^result
]

{ #category : #accessing }
GtTwiEntitiesGroup >> select: aBlock [
	^ self species withAll: (self items select: aBlock)
]
