Class {
	#name : #GtTwiArchiveImporter,
	#superclass : #Object,
	#instVars : [
		'dataFolder',
		'tweetsById'
	],
	#category : #'GToolkit4Twitter-Archive-Importer'
}

{ #category : #'accessing - files' }
GtTwiArchiveImporter >> accountFile [
	^ dataFolder / 'data' / 'account.js'
]

{ #category : #'accessing - files' }
GtTwiArchiveImporter >> adImpressionsFile [
	^ dataFolder / 'data' / 'ad-impressions.js'
]

{ #category : #accessing }
GtTwiArchiveImporter >> atKeys: aKeysArray in: aDictionary ifPresent: aPresentBlock [
	| currentData |
	currentData := aDictionary.
	aKeysArray allButLastDo: [ :aKey |
		currentData := currentData 
			at: aKey
			ifAbsent: [ ^ self ] ].
	
	currentData at: aKeysArray last ifPresent: aPresentBlock
]

{ #category : #importing }
GtTwiArchiveImporter >> createProfilePicture: profileData [
	| urlString url matchingFiles |
	urlString := profileData at: 'avatarMediaUrl'.
	url := urlString asZnUrl.

	matchingFiles := self profileMediaFolder 
		childrenMatching: '*', url segments last .

	matchingFiles size ~= 1 ifTrue: [ ^ nil ].

	^ GtTwiPicture new
		urlString: urlString;
		fileName: matchingFiles first fullName;
		pictureForm: (GtFileUtility imageFromFromFileReference:matchingFiles first)
]

{ #category : #importing }
GtTwiArchiveImporter >> createTweetFromRawData: aTweetData [
	| tweet |
	tweet := GtTwiTweet new
			rawData: aTweetData;
			id: (aTweetData at: 'id');
			text: (aTweetData at: 'full_text').
	self tweetsById at: tweet id put: tweet.
	^ tweet
]

{ #category : #accessing }
GtTwiArchiveImporter >> dataFolder [

	^ dataFolder
]

{ #category : #accessing }
GtTwiArchiveImporter >> dataFolder: aFileReference [

	dataFolder := aFileReference
]

{ #category : #importing }
GtTwiArchiveImporter >> ensureCriterionFor: aCriterionData into: anAccount [
	^ anAccount targetingCriteria 
		detect: [ :aCriterion | 
			aCriterion criterionType = (aCriterionData at: 'targetingType') and: [ 
				aCriterion criterionValue = (aCriterionData at: 'targetingValue' ifAbsent: [ nil ]) ] ]
		ifNone: [ 
			| newCriterion |
			newCriterion := GtTwiTargetingCriterion new
				criterionType: (aCriterionData at: 'targetingType');
				criterionValue: (aCriterionData 
					at: 'targetingValue' ifAbsent: [ nil ]).
			 anAccount addTargetingCriterion: newCriterion.
			 newCriterion ]
]

{ #category : #importing }
GtTwiArchiveImporter >> ensureTweetForImpression: anImpressionRawData into: anUser [
	| tweetData |
	tweetData := anImpressionRawData 
		at: 'promotedTweetInfo' ifAbsent: [ ^ nil ].
	
	^ anUser tweets 
		detect: [ :aTweet | aTweet id = (tweetData at: 'tweetId') ]
		ifFound: [ :aTweet |
			aTweet markAsAd ]
		ifNone: [ 
			| newTweet |
			newTweet := GtTwiTweet new
				id: (tweetData at: 'tweetId');
				text: (tweetData at: 'tweetText');
				markAsAd.
			 anUser addTweet: newTweet.
			 newTweet ]
]

{ #category : #importing }
GtTwiArchiveImporter >> ensureUserForImpression: anImpressionRawData into: anAccount [
	| userData username |
	userData := anImpressionRawData at: 'advertiserInfo'.
	username := (userData at: 'screenName') copyWithoutFirst.
	
	^ anAccount relatedUsers
		detect: [ :aUser | aUser username = username ]
		ifFound: [ :aUser |
			aUser markAsAdvertiser ]
		ifNone: [ 
			| newUser |
			newUser := GtTwiUser new
				username: username;
				displayName: (userData at: 'advertiserName');
				markAsAdvertiser.
			anAccount addRelatedUser: newUser.
			newUser ]
]

{ #category : #parsing }
GtTwiArchiveImporter >> extractJsFileDataFrom: tweetsFile [
	| fileContents |
	fileContents := tweetsFile contents.
	^ fileContents copyFrom: (fileContents indexOf: $[) to: fileContents size
]

{ #category : #'gt - extensions' }
GtTwiArchiveImporter >> gtViewDataDirectoryFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Directory';
		object: [ self dataFolder];
		view: #gtTreeFor:
]

{ #category : #importing }
GtTwiArchiveImporter >> importAccount [
	| account |
	account := GtTwiAccount new.
	account accountUser: self importUser.
	
	self importAdImpressionsIntoAccount: account.
	
	^ account
]

{ #category : #importing }
GtTwiArchiveImporter >> importAccountDataTo: aUser [
	| accountFile accountData |
	accountFile := self accountFile.
	accountData := (self parseJsDataFromFile: accountFile) first at: 'account'.
	
	aUser 
		id: (accountData at: 'accountId');
		username:  (accountData at: 'username');
		displayName:  (accountData at: 'accountDisplayName').
]

{ #category : #importing }
GtTwiArchiveImporter >> importAdImpression: anImpressionRawData into: anAccount [
	| tweet advertiser impression |
	advertiser := self ensureUserForImpression: anImpressionRawData into: anAccount.
	tweet := self ensureTweetForImpression: anImpressionRawData into: advertiser.
	
	impression := GtTwiAdImpression new 
		rawData: anImpressionRawData;
		tweet: tweet;
		displayLocation: (anImpressionRawData at: 'displayLocation').
		
	(anImpressionRawData at: 'matchedTargetingCriteria' ifAbsent: [#()]) do: [ :aCriterionData |
		| matchedCriterion |
		matchedCriterion := self ensureCriterionFor: aCriterionData into: anAccount.
		impression addMatchedCriterion: matchedCriterion ].
	
	anAccount addAdImpression: impression.

]

{ #category : #importing }
GtTwiArchiveImporter >> importAdImpressionsIntoAccount: anAccount [
	| adImpressionsFile impressionsData |
	adImpressionsFile := self adImpressionsFile.
	impressionsData := self parseJsDataFromFile: adImpressionsFile.
	
	impressionsData do: [ :each |  
		self 
			atKeys: #(ad adsUserData adImpressions impressions)
			in: each
			ifPresent: [ :impressionsRawData |
				impressionsRawData do: [ :anImpressionData | 
					self 
						importAdImpression: anImpressionData 
						into: anAccount ] ] ]
]

{ #category : #importing }
GtTwiArchiveImporter >> importProfileDataTo: aUser [
	| profileFile profileData |
	profileFile := self profileFile.
	profileData := (self parseJsDataFromFile: profileFile) first at: 'profile'.

	aUser profilePicture: (self createProfilePicture: profileData)
]

{ #category : #importing }
GtTwiArchiveImporter >> importTweets [
	| tweetsFile tweetsData |
	tweetsFile := self tweetsFile.
	tweetsData := self parseJsDataFromFile: tweetsFile.
	
	^ GtTwiTweetsGroup
		withAll: (tweetsData collect: [ :aTweetData | 
			self createTweetFromRawData: (aTweetData  at: 'tweet') ])
]

{ #category : #importing }
GtTwiArchiveImporter >> importUser [
	| newUser |
	newUser := GtTwiUser new.
	self importAccountDataTo: newUser.
	self importProfileDataTo: newUser.
	newUser tweets: self importTweets.
	newUser tweets
		do: [ :aTweet | 
			aTweet isInReplyToStatus
				ifTrue: [ self tweetsById
						at: aTweet inReplyToStatusId
						ifPresent: [ :aLinkedTweet | 
							aTweet inReplyTo: aLinkedTweet.
							aLinkedTweet addReplyTweet: aTweet ] ] ].
	^ newUser
]

{ #category : #parsing }
GtTwiArchiveImporter >> parseJsDataFromFile: aDataFile [
	| fileContents |
	fileContents := self extractJsFileDataFrom: aDataFile.
	^ STONJSON fromString: fileContents
]

{ #category : #'accessing - files' }
GtTwiArchiveImporter >> profileFile [
	^ dataFolder / 'data' / 'profile.js'
]

{ #category : #'accessing - files' }
GtTwiArchiveImporter >> profileMediaFolder [
	^ dataFolder / 'data' / 'profile_media'
]

{ #category : #importing }
GtTwiArchiveImporter >> tweetsById [
	^ tweetsById ifNil: [ tweetsById := Dictionary new ] 
]

{ #category : #'accessing - files' }
GtTwiArchiveImporter >> tweetsFile [
	^ dataFolder / 'data' / 'tweets.js'
]
