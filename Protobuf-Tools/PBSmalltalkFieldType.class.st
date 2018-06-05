Class {
	#name : #PBSmalltalkFieldType,
	#superclass : #PBSmalltalkNodeWrapper,
	#instVars : [
		'variableName'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #accessing }
PBSmalltalkFieldType >> comment [

	^String streamContents: [ :s |
		self node isCardinalityRepeated
			ifTrue: [ s nextPutAll: 'repeated ' ].
		s
			nextPutAll: self node typeName;
			space;
			nextPutAll: self node name;
			nextPutAll: ' = ';
			print: self node number ]
]

{ #category : #accessing }
PBSmalltalkFieldType >> defaultValue [

	^ self node defaultValue
]

{ #category : #initialization }
PBSmalltalkFieldType >> initDefaults [

	variableName := self node name uncapitalized asSymbol
]

{ #category : #testing }
PBSmalltalkFieldType >> isCardinalityRepeated [

	^self node isCardinalityRepeated
]

{ #category : #accessing }
PBSmalltalkFieldType >> number [

	^self node number
]

{ #category : #initialization }
PBSmalltalkFieldType >> on: aMessageNode [

	super on: aMessageNode.
	
	self initDefaults
]

{ #category : #accessing }
PBSmalltalkFieldType >> parameterName [

	^ self type defaultParameterName
]

{ #category : #accessing }
PBSmalltalkFieldType >> tagNumber [

	^self node tagNumber
]

{ #category : #accessing }
PBSmalltalkFieldType >> type [

	^self node type
]

{ #category : #accessing }
PBSmalltalkFieldType >> typeClassName [

	^ self isCardinalityRepeated
			ifTrue: [ OrderedCollection name ]
			ifFalse: [ self typeName ]
]

{ #category : #accessing }
PBSmalltalkFieldType >> typeName [

	^self node typeName
]

{ #category : #accessing }
PBSmalltalkFieldType >> typeNameCapitalized [

	^self typeName capitalized
]

{ #category : #accessing }
PBSmalltalkFieldType >> variableName [

	^variableName
]
