Class {
	#name : #GtTwRawExpansion,
	#superclass : #GtTwRawEntity,
	#instVars : [
		'tweets'
	],
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #accessing }
GtTwRawExpansion >> tweets [

	^ tweets
]

{ #category : #accessing }
GtTwRawExpansion >> tweets: aGroupOfTweets [

	tweets := aGroupOfTweets
]
