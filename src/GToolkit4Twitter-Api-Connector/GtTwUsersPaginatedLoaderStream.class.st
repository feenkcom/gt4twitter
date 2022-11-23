Class {
	#name : #GtTwUsersPaginatedLoaderStream,
	#superclass : #GtTwPaginatedLoaderStream,
	#category : #'GToolkit4Twitter-Api-Connector-Streams'
}

{ #category : #'api - stream' }
GtTwUsersPaginatedLoaderStream >> cached [
	"Returns a stream that caches items across all #asyncSimilarCopy streams.
	Correctly handles the case when each similar stream is polled from a difference worker process,
	the cache is shared and synchronised between such streams."
	<return: #TAsyncStream>

	^ GtTwUsersCachedStream forStream: self
]

{ #category : #'gt - extensions' }
GtTwUsersPaginatedLoaderStream >> gtViewUsersListFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Users List';
		priority: 1;
		items: [ self asyncSimilarCopy ];
		column: 'Name' text: [ :aUser | aUser name ];
		column: 'Description' text: [ :aUser | aUser description ];
		actionUpdateButton
]
