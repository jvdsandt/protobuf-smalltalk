Class {
	#name : #PBSmalltalkFieldType,
	#superclass : #PBSmalltalkNodeWrapper,
	#instVars : [
		'variableName'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #initialization }
PBSmalltalkFieldType >> initDefaults [

	variableName := self node name uncapitalized asSymbol
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
PBSmalltalkFieldType >> type [

	^self node type
]

{ #category : #accessing }
PBSmalltalkFieldType >> variableName [

	^variableName
]
