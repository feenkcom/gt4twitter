Class {
	#name : #GtAcBasicAPIConfig,
	#superclass : #Object,
	#instVars : [
		'serverUrl'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Client'
}

{ #category : #printing }
GtAcBasicAPIConfig >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		print: self serverUrl;
		nextPutAll: ')'
]

{ #category : #accessing }
GtAcBasicAPIConfig >> serverUrl [

	^ serverUrl
]

{ #category : #accessing }
GtAcBasicAPIConfig >> serverUrl: aZnUrl [
	serverUrl := aZnUrl
]
