Class {
	#name : #PBUpdateMessageClassRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'class',
		'messageType'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #'as yet unclassified' }
PBUpdateMessageClassRefactoring class >> messageType: aSmalltalkMessageType class: aClass [

	^self new messageType: aSmalltalkMessageType class: aClass
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> compileField: aFieldType [

	| getter setter |

	class addInstanceVariable: aFieldType variableName.
	
	getter := String streamContents: [ :s |
		s
			nextPutAll: aFieldType variableName; cr;
			tab; nextPutAll: ' ^'; nextPutAll: aFieldType variableName ].
	
	class 
		compile: getter
		classified: #(accessing).
		
	setter := String streamContents: [ :s |
		s
			nextPutAll: aFieldType variableName; nextPut: $:; nextPutAll: aFieldType parameterName; cr;
			tab; nextPutAll: aFieldType variableName; nextPutAll: ' := '; nextPutAll: aFieldType parameterName ].
	
	class 
		compile: setter
		classified: #(accessing).
	
]

{ #category : #initialization }
PBUpdateMessageClassRefactoring >> messageType: aSmalltalkMessageType class: aClass [

	messageType := aSmalltalkMessageType.
	class := aClass
]

{ #category : #preconditions }
PBUpdateMessageClassRefactoring >> preconditions [
	^ RBCondition empty
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> transform [

	messageType fields do: [ :eachField |
		self compileField: eachField ]
	
]
