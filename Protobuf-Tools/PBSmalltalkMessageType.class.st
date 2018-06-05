Class {
	#name : #PBSmalltalkMessageType,
	#superclass : #PBSmalltalkNodeWrapper,
	#instVars : [
		'packageName',
		'className',
		'fields'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #accessing }
PBSmalltalkMessageType >> className [
	^ className
]

{ #category : #accessing }
PBSmalltalkMessageType >> className: aName [
	className := aName
]

{ #category : #actions }
PBSmalltalkMessageType >> demo [
	"self new demo"

	| msgNode |
	
	msgNode := PBProtobufMessageNode name: 'TestMsg1'
		fields: (Array
			with: (PBProtobufFieldNode number: 1 name: 'fieldOne' typeName: 'string')
			with: (PBProtobufFieldNode number: 2 name: 'fieldTwo' typeName: 'int64'))
		options: #().
		
	self on: msgNode.
	self packageName: 'Protobuf-ZDemo'.
	
	self generateIn: (RBNamespace onEnvironment: RBBrowserEnvironment new)
		
	
]

{ #category : #accessing }
PBSmalltalkMessageType >> fields [
	^ fields
]

{ #category : #actions }
PBSmalltalkMessageType >> generateIn: aRBSmalltalk [

	| refactoring newClass updateRefactoring |
	
	refactoring := PBAddMessageClassRefactoring model: aRBSmalltalk addClassFor: self.
	refactoring execute.

	newClass := refactoring model classNamed: self className.
	
	updateRefactoring	:= PBUpdateMessageClassRefactoring messageType: self class: newClass.
	updateRefactoring model: aRBSmalltalk.
	updateRefactoring execute.
	
]

{ #category : #initialization }
PBSmalltalkMessageType >> initDefaults [

	className := self node name capitalized asSymbol
]

{ #category : #accessing }
PBSmalltalkMessageType >> node [
	^ node
]

{ #category : #initialization }
PBSmalltalkMessageType >> on: aMessageNode [

	super on: aMessageNode.
	
	fields := aMessageNode fields collect: [ :each |
		PBSmalltalkFieldType on: each ].
	
	self initDefaults
]

{ #category : #accessing }
PBSmalltalkMessageType >> packageName [
	^ packageName
]

{ #category : #accessing }
PBSmalltalkMessageType >> packageName: aName [
	packageName := aName
]
