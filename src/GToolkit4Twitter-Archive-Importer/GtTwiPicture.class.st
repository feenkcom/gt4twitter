Class {
	#name : #GtTwiPicture,
	#superclass : #Object,
	#instVars : [
		'urlString',
		'fileName',
		'pictureForm'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #importing }
GtTwiPicture >> fileName: aFileName [
	fileName := aFileName 
]

{ #category : #'gt - extensions' }
GtTwiPicture >> gtViewPictureFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Picture';
		object: [ pictureForm ];
		view: #gtFormFor:
]

{ #category : #importing }
GtTwiPicture >> pictureForm [
	^ pictureForm
]

{ #category : #importing }
GtTwiPicture >> pictureForm: aForm [
	pictureForm := aForm 
]

{ #category : #importing }
GtTwiPicture >> urlString: anUrlString [
	urlString := anUrlString
]
