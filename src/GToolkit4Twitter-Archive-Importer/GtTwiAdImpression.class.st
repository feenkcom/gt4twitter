Class {
	#name : #GtTwiAdImpression,
	#superclass : #GtTwiEntity,
	#instVars : [
		'timestamp',
		'tweet',
		'device',
		'displayLocation',
		'matchedTargetingCriteria'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #adding }
GtTwiAdImpression >> addMatchedCriterion: aCriterion [

	self matchedTargetingCriteria add: aCriterion 
]

{ #category : #accessing }
GtTwiAdImpression >> authorName [
	^ self tweet 
		ifNotNil: [ :aTweet | aTweet authorName ]
]

{ #category : #accessing }
GtTwiAdImpression >> device [

	^ device
]

{ #category : #accessing }
GtTwiAdImpression >> device: anObject [

	device := anObject
]

{ #category : #accessing }
GtTwiAdImpression >> displayLocation [

	^ displayLocation
]

{ #category : #accessing }
GtTwiAdImpression >> displayLocation: anObject [

	displayLocation := anObject
]

{ #category : #'gt - extensions' }
GtTwiAdImpression >> gtViewMatchedCriteriasFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Matched Criteria';
		object: [ self matchedTargetingCriteria];
		view: #gtItemsFor: 
]

{ #category : #initialization }
GtTwiAdImpression >> initialize [
	super initialize.
	
	matchedTargetingCriteria := GtTwiTargetingCriterionGroup new.
]

{ #category : #accessing }
GtTwiAdImpression >> matchedTargetingCriteria [

	^ matchedTargetingCriteria
]

{ #category : #printing }
GtTwiAdImpression >> printOn: aStream [ 
	super printOn: aStream .
	
	aStream parenthesize: [
		self authorName
			ifNotNil: [ :aString | 
				aStream  
					<< aString;
					<< ', ' ].
		aStream << displayLocation ]
]

{ #category : #accessing }
GtTwiAdImpression >> tweet [

	^ tweet
]

{ #category : #accessing }
GtTwiAdImpression >> tweet: anObject [

	tweet := anObject
]
