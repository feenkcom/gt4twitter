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
		object: [ fileName asFileReference ];
		view: #gtFigureFor:
]

{ #category : #importing }
GtTwiPicture >> pictureElement [
	^ GtFileUtility imageElementFromFileReference: fileName asFileReference
]

{ #category : #importing }
GtTwiPicture >> urlString: anUrlString [
	urlString := anUrlString
]
