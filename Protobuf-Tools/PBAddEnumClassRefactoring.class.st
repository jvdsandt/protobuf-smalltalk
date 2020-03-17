Class {
	#name : #PBAddEnumClassRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'messageType'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #'instance creation' }
PBAddEnumClassRefactoring class >> model: aRBSmalltalk addClassFor: aSmalltalkEnumDef [
	^ self new
		model: aRBSmalltalk;
		addClassFor: aSmalltalkEnumDef;
		yourself
]
