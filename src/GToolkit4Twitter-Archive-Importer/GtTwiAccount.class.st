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

{ #category : #accessing }
GtTwiAccount >> gtByMonthFor: aView [
	<gtView>
	| byYear theData maxValue stencil |
	^ aView explicit
		title: 'By month';
		priority: 21;
		stencil: [ | element container |
			byYear := (self accountUser tweets
					groupedBy: [ :each | 
						{each creationDate year.
							each creationDate month} ]) associations
					sorted: [ :a :b | 
						a key first < b key first
							or: [ a key first = b key first and: [ a key second < b key second ] ] ].
			theData := GtPlotterDataGroup new values: byYear.
			theData := theData labelled: [ :each | (each key second printStringPadded: 2) , '.', each key first asString ].
			theData := theData colored: [ :each | Color blue alpha: 0.5 ].
			maxValue := theData values maxValue: [ :each | each value size ].
			stencil := GtPlotterHorizontalBarChart new
					barWidthScale: (GtPlotterLinearScale new domainFrom: 0 to: maxValue);
					barWidthData: [ :eachValue | eachValue value size ];
					barLabelFormat: [ :each | each first gtDisplayString ];
					amountOfTicks: 5;
					with: theData.
			element := stencil asElement.
			container := BrVerticalPane new matchParent.
			element
				when: GtPhlowObjectToSpawn
				do: [ :e | 
					e consumed: true.
					container phlow spawnObject: e tool object value ].
			container addChild: element ]
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
