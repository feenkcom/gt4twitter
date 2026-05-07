Class {
	#name : 'GtTwiMediaItemGroup',
	#superclass : 'GtTwiEntitiesGroup',
	#category : 'GToolkit4Twitter-Archive-Importer',
	#package : 'GToolkit4Twitter-Archive-Importer'
}

{ #category : 'views' }
GtTwiMediaItemGroup >> gtItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Items';
		items: [ items ];
		column: 'Text' text: [ :each | each tweet text ];
		column: 'Date' text: [ :each | each tweet creationDate asLocalStringYMDHM ] width: 100;
		column: 'Media type' text: [ :each | each mediaType ] width: 100
]

{ #category : 'views' }
GtTwiMediaItemGroup >> gtViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Photos';
		priority: 1;
		stencil: [ BrFlowList new
				items: (items);
				margin: (BlInsets all: 10);
				matchParent;
				stencil: [ :each | 
					each asElement
						size: 250 @ 180;
						when: BlClickEvent do: [ :e | e target phlow spawnObject: each ];
						margin: (BlInsets all: 10) ] ]
]
