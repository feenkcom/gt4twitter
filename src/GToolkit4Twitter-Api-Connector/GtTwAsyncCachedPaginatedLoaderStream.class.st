Class {
	#name : #GtTwAsyncCachedPaginatedLoaderStream,
	#superclass : #AsyncCachedStream,
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #'gt - extensions' }
GtTwAsyncCachedPaginatedLoaderStream >> gtViewRequestsHistoryFor: aView [
	<gtView>

	^ aView forward
		title: 'Requests History';
		priority: 25;
		object: [ collector readSlotNamed: 'stream' ];
		view: #gtViewRequestsHistoryFor:
]

{ #category : #'gt - extensions' }
GtTwAsyncCachedPaginatedLoaderStream >> gtViewReturnedValuesFor: aView [
	<gtView>

	^ aView forward
		title: 'Returned Values';
		priority: 22;
		object: [ collector readSlotNamed: 'stream' ];
		view: #gtViewReturnedValuesFor:
]
