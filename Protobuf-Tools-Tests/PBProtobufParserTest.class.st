Class {
	#name : #PBProtobufParserTest,
	#superclass : #PBProtobufGrammarTest,
	#category : #'Protobuf-Tools-Tests'
}

{ #category : #accessing }
PBProtobufParserTest >> parserClass [
	^ PBProtobufParser
]

{ #category : #accessing }
PBProtobufParserTest >> result [
	^ result
]

{ #category : #tests }
PBProtobufParserTest >> testBoolLiteral1 [

	super testBoolLiteral1.
	self assert: self result equals: true
]

{ #category : #tests }
PBProtobufParserTest >> testBoolLiteral2 [

	super testBoolLiteral2.
	self assert: self result equals: false
]

{ #category : #tests }
PBProtobufParserTest >> testConstant1 [

	super testConstant1.
	self assert: self result equals: -123
]

{ #category : #tests }
PBProtobufParserTest >> testConstant2 [

	super testConstant2.
	self assert: self result equals: 123
]

{ #category : #tests }
PBProtobufParserTest >> testConstant3 [

	super testConstant3.
	self assert: self result equals: 'pop'
]

{ #category : #tests }
PBProtobufParserTest >> testConstant4 [

	super testConstant4.
	self assert: self result equals: 'foo.bar'
]

{ #category : #tests }
PBProtobufParserTest >> testDecimalLiteral1 [

	super testDecimalLiteral1.
	self assert: self result equals: 12345
]

{ #category : #tests }
PBProtobufParserTest >> testEnum1 [

	super testEnum1.
	self assert: self result name equals: 'EnumAllowingAlias'.
]

{ #category : #tests }
PBProtobufParserTest >> testEnumBody1 [

	super testEnumBody1.
	self assert: self result equals: (
		PBProtobufEnum name: ''
			values: (Array 
				with: (PBProtobufEnumValue name: 'XYZ' number: 1)
				with: (PBProtobufEnumValue name: 'AB' number: 99))
			options: #())
]

{ #category : #tests }
PBProtobufParserTest >> testEnumBody2 [

	super testEnumBody2.
	self assert: self result equals: (
		PBProtobufEnum name: ''
			values: (Array 
				with: (PBProtobufEnumValue name: 'XYZ' number: 321)
				with: (PBProtobufEnumValue name: 'AB' number: 99))
			options: (Array
				with: (PBProtobufOptionNode name: 'allow_alias' value: true)))
]

{ #category : #tests }
PBProtobufParserTest >> testEnumField1 [

	super testEnumField1.
	self assert: self result equals: (PBProtobufEnumValue name: 'STARTED' number: 1 options: #())
]

{ #category : #tests }
PBProtobufParserTest >> testEnumField2 [

	super testEnumField2.
	self assert: self result equals: (
		PBProtobufEnumValue name: 'RUNNING' 
			number: 2 
			options: (Array with: 'deprecated' -> true with: 'other_option' -> 123 with: 'third' -> 'last'))
]

{ #category : #tests }
PBProtobufParserTest >> testEnumField3 [

	super testEnumField3.
	self assert: self result equals: (
		PBProtobufEnumValue name: 'RUNNING' 
			number: 2 
			options: (Array with: '(custom_option)' -> 'hello world'))
]

{ #category : #tests }
PBProtobufParserTest >> testField1 [
	super testField1.
	self assert: self result name equals: 'nested_message'.
	self assert: self result number equals: 12.
	self assert: self result type name equals: 'foo.bar'
]

{ #category : #tests }
PBProtobufParserTest >> testFloatLiteral1 [
	
	super testFloatLiteral1.
	self assert: result equals: 123.45
	
]

{ #category : #tests }
PBProtobufParserTest >> testFloatLiteral2 [
	
	super testFloatLiteral2.
	self assert: result equals: 123.45e-3
	
]

{ #category : #tests }
PBProtobufParserTest >> testFullIdent [
	super testFullIdent.
	self assert: self result equals: 'foo.bar'
]

{ #category : #tests }
PBProtobufParserTest >> testHexLiteral1 [

	super testHexLiteral1.
	self assert: self result equals: 16rFFFF
]

{ #category : #tests }
PBProtobufParserTest >> testHexLiteral2 [

	super testHexLiteral2.
	self assert: self result equals: 16rFFAA
]

{ #category : #tests }
PBProtobufParserTest >> testImport1 [

	super testImport1.
	
	self assert: self result name equals: 'other.proto'.
	self assert: self result isPublic equals: true.
	self assert: self result isWeak equals: false.
]

{ #category : #tests }
PBProtobufParserTest >> testMapField1 [
	super testMapField1.
	self assert: self result name equals: 'projects'.
	self assert: self result number equals: 2.
]

{ #category : #tests }
PBProtobufParserTest >> testMessage1 [

	super testMessage1.
	self assert: self result name equals: 'Msg'.
	self assert: self result fields size equals: 1.
	self assert: self result fields first name equals: 'my_num'
]

{ #category : #tests }
PBProtobufParserTest >> testMessage2 [

	super testMessage2.
	self assert: self result name equals: 'Outer'.
	self assert: self result fields size equals: 1.
	self assert: self result fields first name equals: 'my_map'
]

{ #category : #tests }
PBProtobufParserTest >> testMessage3 [

	super testMessage3.
	self assert: self result name equals: 'outer'.
	self assert: self result fields size equals: 3.
	self assert: self result fields first name equals: 'inner_message'
]

{ #category : #tests }
PBProtobufParserTest >> testOctalLiteral1 [

	super testOctalLiteral1.
	self assert: self result equals: 8r777
]

{ #category : #tests }
PBProtobufParserTest >> testOption1 [

	super testOption1.
	self assert: self result name equals: 'java_package'.
	self assert: self result value equals: 'com.example.foo'.
]

{ #category : #tests }
PBProtobufParserTest >> testOption2 [

	super testOption2.
	self assert: self result name equals: 'xyz'.
	self assert: self result value equals: 123.
]

{ #category : #tests }
PBProtobufParserTest >> testProto1 [

	super testProto1.
	
	self assert: result imports isEmpty.
	self assert: result options isEmpty.
	self assert: result messages isEmpty.

]

{ #category : #tests }
PBProtobufParserTest >> testProto2 [

	super testProto2.
	
	self assert: result options size equals: 1.
	self assert: result messages size equals: 1.

]

{ #category : #tests }
PBProtobufParserTest >> testProto3 [

	super testProto3.
	
	self assert: result options isEmpty.
	self assert: result messages size equals: 1.

]

{ #category : #tests }
PBProtobufParserTest >> testStrLiteral1 [
	
	super testStrLiteral1.
	self assert: result equals: 'pipo'
	
]

{ #category : #tests }
PBProtobufParserTest >> testStrLiteral2 [
	
	super testStrLiteral2.
	self assert: result equals: 'pipo'
	
]

{ #category : #tests }
PBProtobufParserTest >> testType1 [

	super testType1.
	self assert: self result name equals: 'int64'.

]

{ #category : #tests }
PBProtobufParserTest >> testType2 [

	super testType2.
	self assert: self result name equals: 'foo.bar'.

]
