Class {
	#name : #GtTwiTargetingCriterion,
	#superclass : #Object,
	#instVars : [
		'criterionValue',
		'criterionType'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiTargetingCriterion >> criterionType [

	^ criterionType
]

{ #category : #accessing }
GtTwiTargetingCriterion >> criterionType: anObject [

	criterionType := anObject
]

{ #category : #accessing }
GtTwiTargetingCriterion >> criterionValue [

	^ criterionValue
]

{ #category : #accessing }
GtTwiTargetingCriterion >> criterionValue: anObject [

	criterionValue := anObject
]

{ #category : #printing }
GtTwiTargetingCriterion >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << self criterionType.
		self criterionValue ifNotNil: [ :aValue |
			aStream 
				<< ': ';
				<< aValue ] ]
]
