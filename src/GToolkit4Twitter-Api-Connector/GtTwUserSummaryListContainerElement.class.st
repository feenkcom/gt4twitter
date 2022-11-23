Class {
	#name : #GtTwUserSummaryListContainerElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'userSummaryElement'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #callbacks }
GtTwUserSummaryListContainerElement >> actOnElementDetached [
	userSummaryElement actOnElementDetached
]

{ #category : #initialization }
GtTwUserSummaryListContainerElement >> initialize [
	super initialize.
	
	self 
		hMatchParent;
		vFitContent;
		alignCenter.
	
	self addChild: (userSummaryElement := GtTwUserSummaryElement new).
	self addChild: (BrFrame new 
		hExact: 450;
		vExact: 1;
		background: Color veryLightGray  muchLighter )
]

{ #category : #accessing }
GtTwUserSummaryListContainerElement >> user: aUser [
	userSummaryElement user: aUser
]
