Class {
	#name : #GtTwiDateParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'weekday',
		'month',
		'day',
		'hour',
		'minute',
		'second',
		'timezone',
		'year',
		'parser'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #grammar }
GtTwiDateParser >> day [
	^ (#digit asPParser times: 2) flatten ==> #asNumber
]

{ #category : #grammar }
GtTwiDateParser >> hour [
	^ (#digit asPParser times: 2) flatten ==> #asNumber
]

{ #category : #grammar }
GtTwiDateParser >> minute [
	^ (#digit asPParser times: 2) flatten ==> #asNumber
]

{ #category : #grammar }
GtTwiDateParser >> month [
	^ (#letter asPParser times: 3) flatten
		==> [ :t | (Date monthNames collect: [ :each | each first: 3 ]) indexOf: t ]
]

{ #category : #grammar }
GtTwiDateParser >> parser [
	^ (weekday trim , month trim , day trim , hour , ':' asPParser , minute
		, ':' asPParser , second , timezone trim , year)
		==> [ :t | 
			DateAndTime
				year: (t at: 10)
				month: t second
				day: t third
				hour: t fourth
				minute: t sixth
				second: t eighth ]
]

{ #category : #grammar }
GtTwiDateParser >> second [
	^ (#digit asPParser times: 2) flatten ==> #asNumber
]

{ #category : #accessing }
GtTwiDateParser >> start [
	^ parser
]

{ #category : #grammar }
GtTwiDateParser >> timezone [
	^ '+' asPParser / '-' asPParser , (#digit asPParser times: 4) flatten
]

{ #category : #grammar }
GtTwiDateParser >> weekday [
	^ #letter asPParser times: 3
]

{ #category : #grammar }
GtTwiDateParser >> year [
	^ (#digit asPParser times: 4) flatten ==> #asNumber
]
