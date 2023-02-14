Class {
	#name : #BaselineOfGToolkit4Twitter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Twitter
}

{ #category : #loading }
BaselineOfGToolkit4Twitter class >> loadLepiter [ 
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'gt4twitter' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGToolkit4Twitter >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec package: 'GToolkit4Twitter-Api-Connector'.
		spec package: 'GToolkit4Twitter-Archive-Importer' ]
]
