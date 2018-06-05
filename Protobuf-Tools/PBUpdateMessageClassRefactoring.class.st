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
PBUpdateMessageClassRefactoring >> compileClearMethod [

	| source |
	
	source := String streamContents: [ :s | self printClearMethodSourceOn: s ].
	
	class 
		compile: source
		classified: #('initialization').

]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> compileField: aFieldType [

	| getter setter |

	class addInstanceVariable: aFieldType variableName.
	
	getter := String streamContents: [ :s |
		s
			nextPutAll: aFieldType variableName; cr;
			tab; nextPut: $"; nextPutAll: aFieldType comment; nextPut: $"; cr;
			tab; nextPutAll: '^ '; nextPutAll: aFieldType variableName ].
	
	class 
		compile: getter
		classified: #(accessing).
		
	setter := String streamContents: [ :s |
		s
			nextPutAll: aFieldType variableName; nextPut: $:; space; nextPutAll: aFieldType parameterName; cr;
			tab; nextPut: $"; nextPutAll: aFieldType comment; nextPut: $"; cr;
			tab; nextPutAll: aFieldType variableName; nextPutAll: ' := '; nextPutAll: aFieldType parameterName ].
	
	class 
		compile: setter
		classified: #(accessing).
	
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> compileInitializeMethod [

	| source |
	
	source := String streamContents: [ :s | self printInitializeMethodSourceOn: s ].
	
	class 
		compile: source
		classified: #('initialization').

]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> compileReadFromMethod [

	| source |
	
	source := String streamContents: [ :s | self printReadFromSourceOn: s ].
	
	class 
		compile: source
		classified: #('input-output').

]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> compileWriteTo [

	| source |
	
	source := String streamContents: [ :s | self printWriteToSourceOn: s ].
	
	class 
		compile: source
		classified: #('input-output').

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
PBUpdateMessageClassRefactoring >> printClearMethodSourceOn: s [

	s
		nextPutAll: 'clear'; cr;
		tab; nextPutAll: '"Reset all Protobuf fields to their default values."'; cr; cr.

	messageType fields
		do: [ :eachField |
			s
				tab;
				nextPutAll: eachField variableName;
				nextPutAll: ' := ';
				print: eachField defaultValue ]
		separatedBy: [ 
			s nextPut: $.; cr ]
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> printInitializeMethodSourceOn: s [

	s
		nextPutAll: 'initialize'; cr;
		tab; nextPutAll: 'super initialize.'; cr;
		tab; nextPutAll: 'self clear'
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> printReadFromSourceOn: s [

	s
		nextPutAll: 'readFrom: pbReadStream'; cr;
		tab; nextPutAll: '"Read this Protobuf message from the stream."'; cr; cr;
		tab; nextPutAll: '| dict done |'; cr; cr;
		tab; nextPutAll: 'dict := IdentityDictionary new'; cr.
		
	messageType fields
		do: [ :eachField |
			s
				tab; tab; nextPutAll: 'add: '; 
				print: eachField tagNumber; 
				nextPutAll: ' -> [ ';
				nextPutAll: eachField variableName;
				nextPutAll: ' := pbReadStream read'.
			eachField type isScalarValueType
				ifTrue: [ 
					s nextPutAll: eachField typeNameCapitalized.
					eachField isCardinalityRepeated
						ifTrue: [ s nextPutAll: 'List' ].
					 ]
				ifFalse: [ 
					eachField type isEnumType
						ifTrue: [ 
							s nextPutAll: 'Enum: '; nextPutAll: eachField typeClassName ]
						ifFalse: [ 
							"Must be message type"
							s nextPutAll: 'Message: '; nextPutAll: eachField typeClassName ] ].
			s nextPutAll: ' ];'; cr ].
	s tab; tab; nextPutAll: 'yourself.'; cr; cr.
	
	s
		tab; nextPutAll: 'self clear.'; cr;
		tab; nextPutAll: 'done := false.'; cr;
		tab; nextPutAll: '[ done ] whileFalse: ['; cr;
		tab; tab; nextPutAll: '| tag |'; cr;
		tab; tab; nextPutAll: 'tag := pbReadStream readTag.'; cr;
		tab; tab; nextPutAll: '(dict at: tag ifAbsent: [ self readUnknownField: tag from: pbReadStream ]) value.'; cr;
		tab; tab; nextPutAll: 'done := pbReadStream atEnd ]'
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> printWriteToSourceOn: s [

	s
		nextPutAll: 'writeTo: pbWriteStream'; cr;
		tab; nextPutAll: '"Serialize this Protobuf message to the stream."'; cr; cr;
		tab; nextPutAll: 'pbWriteStream'; cr.
	messageType fields
		do: [ :eachField |
			s
				tab; tab; nextPutAll: 'writeField: '; print: eachField number; space.
			eachField type isScalarValueType
				ifTrue: [ 
					s nextPutAll: eachField typeName.
					eachField isCardinalityRepeated
						ifTrue: [ s nextPutAll: 'List' ].
					 ]
				ifFalse: [ 
					eachField type isEnumType
						ifTrue: [ 
							s nextPutAll: 'enum' ]
						ifFalse: [ 
							"Must be message type"
							s nextPutAll: 'message' ] ].
			s nextPutAll: ': '; nextPutAll: eachField variableName ]
		separatedBy: [ 
			s nextPut: $;; cr ]
]

{ #category : #transforming }
PBUpdateMessageClassRefactoring >> transform [

	messageType fields do: [ :eachField |
		self compileField: eachField ].
	
	self compileClearMethod.
	self compileInitializeMethod.
	self compileReadFromMethod.
	self compileWriteTo.
	
]
