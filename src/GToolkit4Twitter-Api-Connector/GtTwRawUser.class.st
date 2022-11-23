Class {
	#name : #GtTwRawUser,
	#superclass : #GtTwRawEntity,
	#category : #'GToolkit4Twitter-Api-Connector-Model-Basic'
}

{ #category : #accessing }
GtTwRawUser >> description [ 
	^ self rawDataWithDefaultAt: 'description'
]

{ #category : #'accessing - metrics' }
GtTwRawUser >> followersCount [
	^ self publicMetrics at: 'followers_count' ifAbsent:[ nil ].
]

{ #category : #'accessing - metrics' }
GtTwRawUser >> followingCount [
	^ self publicMetrics at: 'following_count' ifAbsent:[ '-' ].
]

{ #category : #accessing }
GtTwRawUser >> id [ 
	^ self rawDataWithDefaultAt:'id'
]

{ #category : #accessing }
GtTwRawUser >> name [ 
	^ self rawDataWithDefaultAt: 'name'
]

{ #category : #printing }
GtTwRawUser >> printOn: aStream [ 
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream << (self name ifNil: ['-']) ]
]

{ #category : #accessing }
GtTwRawUser >> profileImageUrl [ 
	^ self rawDataWithDefaultAt: 'profile_image_url'
]

{ #category : #accessing }
GtTwRawUser >> publicMetrics [
	^ self rawData 
		at: 'public_metrics' 
		ifAbsent: [ Dictionary new ]
]

{ #category : #'accessing - metrics' }
GtTwRawUser >> tweetCount [
	^ self publicMetrics at: 'tweet_count' ifAbsent:[ nil ].
]

{ #category : #accessing }
GtTwRawUser >> username [ 
	^ self rawDataWithDefaultAt:'username'
]
