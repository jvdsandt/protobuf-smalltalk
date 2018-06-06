Class {
	#name : #PBProtobufParser,
	#superclass : #PBProtobufGrammar,
	#instVars : [
		'start'
	],
	#category : #'Protobuf-Tools-Parser'
}

{ #category : #'grammar-literals' }
PBProtobufParser >> boolLiteral [

	^super boolLiteral ==> [ :v | v = 'true' ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> comment [

	^super comment ==> [ :str | PBProtobufCommentNode text: str ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> constant [

	^super constant ==> [ :val |
		val class = Array
			ifTrue: [
				val first = $-
					ifTrue: [ (val at: 2) negated ]
					ifFalse: [ val at: 2 ] ]
			ifFalse: [
				val ] ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> decimalLiteral [

	^super decimalLiteral ==> [ :str | self numberParser parse: str ]

]

{ #category : #'grammar-toplevel' }
PBProtobufParser >> enum [

	^super enum ==> [ :array |
		| name body |
		name := array at: 3.
		body := array at: 4.
		body withName: name ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> enumBody [

	^super enumBody ==> [ :array |
		| contents |
		contents := array at: 2.	
		PBProtobufEnum name: ''	
			values: (contents select: [ :each | each isEnumValueNode] )
			options: (contents select: [ :each | each isOptionNode ]) ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> enumField [

	^super enumField ==> [ :array | 
		PBProtobufEnumValue name: (array at: 1)
			number: (array at: 3)
			options: ((array at: 4) ifNil: [ #() ]) ]

]

{ #category : #'grammar-literals' }
PBProtobufParser >> enumFieldOptions [

	^super enumFieldOptions ==> [ :array | 
		| list result |
		list := array at: 2.
		result := OrderedCollection new.
		list notEmpty
			ifTrue: [ 
				result add: list first.
				list size > 1
					ifTrue: [ 
						result addAll: ((list at: 2) collect: [ :eachArray | eachArray last ]) ] ].
		result asArray ]
]

{ #category : #accessing }
PBProtobufParser >> enumValueOption [
	"Answer an association with the options name as key and the constant as value."

	^super enumValueOption ==> [ :array | (array at: 1) -> (array at: 3) ]
]

{ #category : #accessing }
PBProtobufParser >> field [

	^super field ==> [ :array |
		
		| fType fCardinality fName fNumber |
	
		fType := array at: 2.
		fCardinality := array first = 'repeated'
			ifTrue: [ #CARDINALITY_REPEATED ]
			ifFalse: [ #CARDINALITY_OPTIONAL ].
		fName := array at: 4.
		fNumber := (array at: 6) asNumber.
	
		PBProtobufFieldNode number: fNumber
			name: fName 
			type: fType
			cardinality: fCardinality ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> floatLiteral [

	^super floatLiteral ==> [ :str | self numberParser parse: str ]

]

{ #category : #accessing }
PBProtobufParser >> fullIdent [

	^super fullIdent ==> [ :str| str ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> hexLiteral [

	^super hexLiteral ==> [ :str | self numberParser parse: '16r', (str allButFirst: 2) ]

]

{ #category : #accessing }
PBProtobufParser >> mapField [

	^super mapField ==> [ :array |
		
		| fType fCardinality fName fNumber |
	
		fType := #TYPE_MESSAGE.
		fCardinality := array first = 'repeated'
			ifTrue: [ #CARDINALITY_REPEATED ]
			ifFalse: [ #CARDINALITY_OPTIONAL ].
		fName := array at: 8.
		fNumber := (array at: 10) asNumber.
	
		PBProtobufFieldNode number: fNumber
			name: fName 
			type: fType
			cardinality: fCardinality ]
]

{ #category : #'grammar-toplevel' }
PBProtobufParser >> message [

	^super message ==> [ :array |
		| name body |
		name := array at: 3.
		body := array at: 4.
		body withName: name ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> messageBody [

	^super messageBody ==> [ :array |
		| contents |
		contents := array at: 2.	
		PBProtobufMessageNode name: ''	
			fields: (contents select: [ :each | each isFieldNode] )
			options: (contents select: [ :each | each isOptionNode ]) ]
]

{ #category : #accessing }
PBProtobufParser >> numberParser [

	^NumberParser
]

{ #category : #'grammar-literals' }
PBProtobufParser >> octalLiteral [

	^super octalLiteral ==> [ :str | self numberParser parse: '8r', str ]
]

{ #category : #accessing }
PBProtobufParser >> option [
	"Answer an association with the full identifier String as key and the constant as value."

	^super option ==> [ :array | 
		PBProtobufOptionNode name: (array at: 3) value: (array at: 5) ]
]

{ #category : #'grammar-toplevel' }
PBProtobufParser >> package [

	^super package ==> [ :array | PBProtobufPackageNode name: (array at: 3) ]
]

{ #category : #'grammar-toplevel' }
PBProtobufParser >> proto [

	^super proto ==> [ :array | 
		| relevantNodes |
		relevantNodes := (array at: 3).
		PBProtobufFileNode fromNodes: relevantNodes ]
]

{ #category : #'grammar-literals' }
PBProtobufParser >> strLiteral [

	^super strLiteral ==> [ :array | array at: 2 ]

]

{ #category : #'grammar-literals' }
PBProtobufParser >> type [

	^super type ==> [ :str | PBProtobufTypeNode name: str ]
]
