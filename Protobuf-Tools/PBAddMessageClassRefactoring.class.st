Class {
	#name : #PBAddMessageClassRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'messageType'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #'instance creation' }
PBAddMessageClassRefactoring class >> addClassFor: aSmalltalkMessageDef [

	^self new 
		addClassFor: aSmalltalkMessageDef;
		yourself
		
]

{ #category : #'instance creation' }
PBAddMessageClassRefactoring class >> model: aRBSmalltalk addClassFor: aSmalltalkMessageDef [

	^self new 
		model: aRBSmalltalk;
		addClassFor: aSmalltalkMessageDef;
		yourself
]

{ #category : #initialization }
PBAddMessageClassRefactoring >> addClassFor: aSmalltalkMessageDef [

	messageType := aSmalltalkMessageDef
]

{ #category : #accessing }
PBAddMessageClassRefactoring >> category [

	^ self messageType packageName
]

{ #category : #accessing }
PBAddMessageClassRefactoring >> className [

	^ self messageType className
]

{ #category : #accessing }
PBAddMessageClassRefactoring >> messageType [

	^ messageType
]

{ #category : #preconditions }
PBAddMessageClassRefactoring >> preconditions [

	^(RBCondition isValidClassName: self className)
]

{ #category : #accessing }
PBAddMessageClassRefactoring >> superclass [

	^ self model classNamed: #PBMessage
]

{ #category : #transforming }
PBAddMessageClassRefactoring >> transform [

	(self model)
		defineClass: ('<1p> subclass: #<2s> instanceVariableNames: '''' classVariableNames: '''' poolDictionaries: '''' category: <3p>' 
					expandMacrosWith: self superclass
					with: self className
					with: self category asString)
]
