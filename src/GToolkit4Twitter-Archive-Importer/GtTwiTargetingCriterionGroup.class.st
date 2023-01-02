Class {
	#name : #GtTwiTargetingCriterionGroup,
	#superclass : #GtTwiEntitiesGroup,
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiTargetingCriterionGroup >> groupedByCriterionType [
	^ self groupedBy: [ :each | each criterionType ]
]

{ #category : #'gt - extensions' }
GtTwiTargetingCriterionGroup >> gtItemsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Criteria';
		items: [ self ];
		column: 'Type' text: [ :aCriterion | aCriterion criterionType ];
		column: 'Value' text: [ :aCriterion | aCriterion criterionValue ]
]

{ #category : #'gt - extensions' }
GtTwiTargetingCriterionGroup >> gtViewGroupedByCriterionTypeFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By Type';
		items: [ self groupedByCriterionType  associations 
			sorted: [ :aGroup | aGroup value size ] descending];
		column: 'Type' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: #value
]
