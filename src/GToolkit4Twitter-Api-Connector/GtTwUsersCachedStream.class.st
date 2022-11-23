Class {
	#name : #GtTwUsersCachedStream,
	#superclass : #GtTwAsyncCachedPaginatedLoaderStream,
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #'gt - extensions' }
GtTwUsersCachedStream >> gtViewUsersListFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Users List';
		priority: 10;
		items: [ self asyncSimilarCopy ];
		column: 'Name' text: [ :aUser | aUser name ];
		column: 'Description' text: [ :aUser | aUser description ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
GtTwUsersCachedStream >> gtViewUsersSummaryUIFor: aView [
	<gtView>

	^ aView list
		title: 'Users';
		priority: 1;
		items: [ self asyncSimilarCopy ];
		itemStencil: [ 
			GtTwUserSummaryListContainerElement new ];
		itemDataBinder: [ :aUserElement :aUser | 
			aUserElement user: aUser ];
		itemId: [ :aUser | aUser id ]
]
