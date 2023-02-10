Class {
	#name : #GtTwiMediaItem,
	#superclass : #GtTwiEntity,
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiMediaItem >> asElement [
	^ BrAsyncFileWidget new
		matchParent;
		url: self url
]

{ #category : #accessing }
GtTwiMediaItem >> gtPreviewFor: aView [
	<gtView>
	self isPhoto ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		stencil: [ self asElement ]
]

{ #category : #accessing }
GtTwiMediaItem >> isPhoto [
	^ self mediaType = 'photo'
]

{ #category : #accessing }
GtTwiMediaItem >> mediaType [
	^ rawData at: 'type'
]

{ #category : #accessing }
GtTwiMediaItem >> url [
	^ rawData at: 'media_url'
]
