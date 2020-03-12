Class {
	#name : #PBSmalltalkEnumType,
	#superclass : #PBSmalltalkNodeWrapper,
	#instVars : [
		'packageName',
		'className',
		'values'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #accessing }
PBSmalltalkEnumType >> className [
	^ className
]

{ #category : #accessing }
PBSmalltalkEnumType >> className: aName [
	className := aName
]

{ #category : #actions }
PBSmalltalkEnumType >> generateIn: aRBSmalltalk [
	| refactoring newClass updateRefactoring |
	refactoring := PBAddMessageClassRefactoring
		model: aRBSmalltalk
		addClassFor: self.
	refactoring execute.
	newClass := refactoring model classNamed: self className.
	updateRefactoring := PBUpdateMessageClassRefactoring
		messageType: self
		class: newClass.
	updateRefactoring model: aRBSmalltalk.
	updateRefactoring execute
]

{ #category : #initialization }
PBSmalltalkEnumType >> initDefaults [
	className := self node name capitalized asSymbol
]

{ #category : #initialization }
PBSmalltalkEnumType >> on: anEnumNode [

	super on: anEnumNode.
	values := anEnumNode values
		collect: [ :each | PBSmalltalkEnumValueType on: each ].
	"what to do about options ? "
	self initDefaults
]

{ #category : #accessing }
PBSmalltalkEnumType >> packageName [
	^ packageName
]

{ #category : #accessing }
PBSmalltalkEnumType >> packageName: aName [
	packageName := aName
]
