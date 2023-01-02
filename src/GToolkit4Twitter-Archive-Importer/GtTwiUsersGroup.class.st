Class {
	#name : #GtTwiUsersGroup,
	#superclass : #GtTwiEntitiesGroup,
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiUsersGroup >> advertisers [
	^ self select: [ :aUser |
		aUser isAdvertiser ]
]

{ #category : #'gt - extensions' }
GtTwiUsersGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Items';
		items: [ self ];
		column: 'Handle' text: [ :aUser | '@',aUser username ];
		column: 'Name' text: [ :aUser | aUser name ]
]
