Class {
	#name : #PBSmalltalkEnumValueType,
	#superclass : #PBSmalltalkNodeWrapper,
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #initialization }
PBSmalltalkEnumValueType >> initDefaults [
	"variableName := self node name uncapitalized asSymbol.
	self isCardinalityRepeated
		ifTrue: [ variableName := variableName , 'List' ]"
]

{ #category : #accessing }
PBSmalltalkEnumValueType >> name [
	^ self node name
]

{ #category : #accessing }
PBSmalltalkEnumValueType >> number [
	^ self node number
]

{ #category : #initialization }
PBSmalltalkEnumValueType >> on: aNode [
	super on: aNode.
	
	self initDefaults
]

{ #category : #accessing }
PBSmalltalkEnumValueType >> options [
	^ self node options
]
