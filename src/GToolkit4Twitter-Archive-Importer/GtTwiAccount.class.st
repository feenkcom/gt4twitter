Class {
	#name : #GtTwiAccount,
	#superclass : #Object,
	#instVars : [
		'accountUser',
		'relatedUsers',
		'devices',
		'targetingCriteria',
		'adImpressions'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #accessing }
GtTwiAccount >> accountUser [
	^ accountUser
]

{ #category : #accessing }
GtTwiAccount >> accountUser: aUser [
	accountUser := aUser
]

{ #category : #accessing }
GtTwiAccount >> adImpressions [
	^ adImpressions
]

{ #category : #adding }
GtTwiAccount >> addAdImpression: anAdImpression [
	self adImpressions add: anAdImpression
]

{ #category : #adding }
GtTwiAccount >> addRelatedUser: aUser [
	self relatedUsers add: aUser
]

{ #category : #adding }
GtTwiAccount >> addTargetingCriterion: aCriterion [
	self targetingCriteria add: aCriterion
]

{ #category : #accessing }
GtTwiAccount >> advertisers [ 
	^ self relatedUsers advertisers
]

{ #category : #'gt - extensions' }
GtTwiAccount >> gtViewOverviewFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Overview';
		priority: 10;
		items: [ self overviewData ];
		column: 'Data' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #'gt - extensions' }
GtTwiAccount >> gtViewTweetsTimelineFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Tweets';
		priority: 20;
		object: [ self accountUser ];
		view: #gtViewTweetsTimelineFor:
]

{ #category : #initialization }
GtTwiAccount >> initialize [
	super initialize.
	
	relatedUsers := GtTwiUsersGroup new.
	targetingCriteria := GtTwiTargetingCriterionGroup new.
	adImpressions := GtTwiAdImpressionsGroup new
]

{ #category : #accessing }
GtTwiAccount >> overviewData [
	^ {
		'Related Users' -> self relatedUsers.
		'Ad Impressions' -> self adImpressions .
		'Ad Targeting Criteria' -> self targetingCriteria }
]

{ #category : #accessing }
GtTwiAccount >> relatedUsers [
	^ relatedUsers
]

{ #category : #accessing }
GtTwiAccount >> targetingCriteria [
	^ targetingCriteria
]
