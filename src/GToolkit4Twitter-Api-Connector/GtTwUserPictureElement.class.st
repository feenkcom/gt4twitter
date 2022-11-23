Class {
	#name : #GtTwUserPictureElement,
	#superclass : #BrFrame,
	#instVars : [
		'pictureElement'
	],
	#category : #'GToolkit4Twitter-Api-Connector-UI'
}

{ #category : #accessing }
GtTwUserPictureElement >> actOnElementDetached [
	pictureElement asyncFuture cancelSoft interrupt
]

{ #category : #'building - widgets' }
GtTwUserPictureElement >> buildAsyncPictureElement [
	^ pictureElement := (BrAsyncFileWidget new )
		matchParent;
		geometry: (BlCircleGeometry new)
]

{ #category : #'building - widgets' }
GtTwUserPictureElement >> buildProfilePictureElement [
	^ pictureElement := BrFrame new 
		matchParent;
		geometry: (BlCircleGeometry new);
		margin: (BlInsets right: 10);
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				whenPending: [ :theContainer | 
					theContainer
						removeChildren ];
				whenError: [ :theContainer :anError | 
					theContainer
						removeChildren;
						addChild:  anError asDebuggableElement matchParent;
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter ] ];
				whenSuccess: [ :theContainer :theElement | 
					theContainer removeChildren.
					theContainer addChild: theElement ] ]
]

{ #category : #initialization }
GtTwUserPictureElement >> initialize [
	super initialize.
	
	self 
		exact: 48@48;
		geometry: (BlCircleGeometry new).
	
	self addChild:  self buildAsyncPictureElement.
	"self addChild:  self buildProfilePictureElement."
]

{ #category : #updating }
GtTwUserPictureElement >> updateContentForUser: aUser [
	pictureElement formBlock: [ 
		aUser profilePictureForm  ].
		
	"pictureElement asyncFuture future: [ 
		aUser profilePictureForm asElement
			asScalableElement ] asAsyncFuture."
]

{ #category : #accessing }
GtTwUserPictureElement >> user: aUser [ 
	self updateContentForUser:  aUser
]
