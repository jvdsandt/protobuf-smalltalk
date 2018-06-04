Class {
	#name : #PBProtobufCodeGeneratorTest,
	#superclass : #RBRefactoringTest,
	#category : #'Protobuf-Tools-Tests'
}

{ #category : #'as yet unclassified' }
PBProtobufCodeGeneratorTest >> createMessageType1 [

	^PBProtobufMessageNode name: 'TestMsg1'
		fields: (Array
			with: (PBProtobufFieldNode number: 1 name: 'fieldOne' typeName: 'string')
			with: (PBProtobufFieldNode number: 2 name: 'fieldTwo' typeName: 'int64'))
		options: #()
]

{ #category : #'as yet unclassified' }
PBProtobufCodeGeneratorTest >> createSmalltalkMessageDef1 [

	^(PBSmalltalkMessageType on: self createMessageType1)
			packageName: self class category;
			yourself
]

{ #category : #tests }
PBProtobufCodeGeneratorTest >> testSmalltalkMessageDef1 [

	| refactoring msgDef newClass updateRefactoring |
	
	msgDef := self createSmalltalkMessageDef1.
	
	refactoring := PBAddMessageClassRefactoring addClassFor: msgDef.
	self executeRefactoring: refactoring.

	newClass := refactoring model classNamed: msgDef className.
	
	updateRefactoring	:= PBUpdateMessageClassRefactoring messageType: msgDef class: newClass.
	self executeRefactoring: updateRefactoring.

	
	

]
