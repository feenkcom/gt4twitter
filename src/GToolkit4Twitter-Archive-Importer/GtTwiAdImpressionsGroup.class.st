Class {
	#name : #GtTwiAdImpressionsGroup,
	#superclass : #GtTwiEntitiesGroup,
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #'gt - extensions' }
GtTwiAdImpressionsGroup >> groupedByAdvertiser [
	^ self groupedBy: [ :each | each authorName]
]

{ #category : #accessing }
GtTwiAdImpressionsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Items';
		items: [ self ];
		column: 'Date' text: [ 'todo' ];
		column: 'Advertiser' text: [ :anAdImpression |
			anAdImpression authorName ];
		column: 'Criterias' text: [ :anAdImpression |
			anAdImpression matchedTargetingCriteria size ]
]

{ #category : #'gt - extensions' }
GtTwiAdImpressionsGroup >> gtViewGroupedByAdvertiserFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By Advertiser';
		items: [ self groupedByAdvertiser  associations 
			sorted: [ :aGroup | aGroup value size ] descending];
		column: 'Type' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: #value
]
