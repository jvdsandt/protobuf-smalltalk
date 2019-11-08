Class {
	#name : #PBCodedStreamTest,
	#superclass : #TestCase,
	#pools : [
		'PBProtobufConstants'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #tests }
PBCodedStreamTest >> testBool [

	self testWriter: [ :output |
			output writeField: 1 bool: true.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeVarint).
			self assert: input readBool equals: true.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testDouble [

	self testWriter: [ :output |
			output writeField: 1 double: 123.456.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireType64bit).
			self assert: input readDouble equals: 123.456.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testFloat [

	self testWriter: [ :output |
			output writeField: 1 float: 123.456.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireType64bit).
			self assert: (input readFloat - 123.456) abs < 0.001.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testIntegers32 [
	self
		testWriter: [ :output | 
			output writeField: 1 int32: 12345.
			output writeField: 2 uint32: 12345.
			output writeField: 3 sint32: -12345.
			output writeField: 4 fixed32: 12345.
			output writeField: 5 sfixed32: -12345 ]
		reader: [ :input | 
			self
				assert: input readTag
				equals: (input coder makeTag: 1 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345.
			self
				assert: input readTag
				equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readUint32 equals: 12345.
			self
				assert: input readTag
				equals: (input coder makeTag: 3 wireType: WireTypeVarint).
			self assert: input readSint32 equals: -12345.
			self
				assert: input readTag
				equals: (input coder makeTag: 4 wireType: WireType32bit).
			self assert: input readFixed32 equals: 12345.
			self
				assert: input readTag
				equals: (input coder makeTag: 5 wireType: WireType32bit).
			self assert: input readSfixed32 equals: -12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testIntegers64 [

	self testWriter: [ :output |
			output writeField: 1 int64: 12345.
			output writeField: 2 uint64: 12345.
			output writeField: 3 sint64: -12345.
			output writeField: 4 fixed64: 12345.
			output writeField: 5 sfixed64: -12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeVarint).
			self assert: input readInt64 equals: 12345.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readUint64 equals: 12345.
			self assert: input readTag equals: (input coder makeTag: 3 wireType: WireTypeVarint).
			self assert: input readSint64 equals: -12345.
			self assert: input readTag equals: (input coder makeTag: 4 wireType: WireType64bit).
			self assert: input readFixed64 equals: 12345.
			self assert: input readTag equals: (input coder makeTag: 5 wireType: WireType64bit).
			self assert: input readSfixed64 equals: -12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testMessage [

	| msg |
	
	msg := PBProtobufTestMessage1 new
		fieldOne: 'Hello World!';
		fieldTwo: 42;
		yourself.

	self testWriter: [ :output |
			output writeField: 1 message: msg.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
			self assert: (input readMessage: msg class) equals: msg.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testMessageList [

	| msgList |
	
	msgList := (1 to: 10) collect: [ :index |
		PBProtobufTestMessage1 new
			fieldOne: 'Hello World ', index asString;
			fieldTwo: 42 * index;
			yourself ].

	self testWriter: [ :output |
			output writeField: 1 messageList: msgList.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			| resultList |
			resultList := (1 to: msgList size) collect: [ :index |
				self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
				input readMessage: PBProtobufTestMessage1 ].
			self assert: resultList equals: msgList.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testScalarLists [

	self testWriter: [ :output |
			output writeField: 1 int32List: #( -100 0 1 20000 ).
			output writeField: 2 boolList: #( true false true ).
			output writeField: 3 doubleList: #( -10.9 0.0 123.456 ) ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
			self assert: input readInt32List asArray equals: #( -100 0 1 20000 ).
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeLengthDelimited).
			self assert: input readBoolList asArray equals: #( true false true ).
			self assert: input readTag equals: (input coder makeTag: 3 wireType: WireTypeLengthDelimited).
			self assert: input readDoubleList asArray equals: #( -10.9 0.0 123.456 ) ]
]

{ #category : #tests }
PBCodedStreamTest >> testScalarListsEmpty [

	| bytes |
	
	bytes := self testWriter: [ :output |
			output writeField: 1 int32List: #(  ).
			output writeField: 2 boolList: #(  ).
			output writeField: 3 doubleList: #(  ) ]
		reader: [ :input | ].
		
	self assert: bytes equals: #[ ]
]

{ #category : #tests }
PBCodedStreamTest >> testString [

	self testWriter: [ :output |
			output writeField: 1 string: 'Testing 1-2-3'.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
			self assert: input readString equals: 'Testing 1-2-3'.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testStringUtf8 [

	self testWriter: [ :output |
			output writeField: 1 string: 'één'.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
			self assert: input readString equals: 'één'.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testStringWide [

	| wideString |
	
	wideString := WideString withAll: { 300 asCharacter. 400 asCharacter. 500 asCharacter }.

	self testWriter: [ :output |
			output writeField: 1 string: wideString.
			output writeField: 2 int32: 12345 ]
		reader: [ :input |
			self assert: input readTag equals: (input coder makeTag: 1 wireType: WireTypeLengthDelimited).
			self assert: input readString equals: wideString.
			self assert: input readTag equals: (input coder makeTag: 2 wireType: WireTypeVarint).
			self assert: input readInt32 equals: 12345 ]
]

{ #category : #tests }
PBCodedStreamTest >> testWriter: aWriteBlock reader: aReadBlock [

	| bytes |
	
	bytes := ByteArray streamContents: [ :s |
		aWriteBlock value: (PBCodedWriteStream on: s) ].
	
	aReadBlock value: (PBCodedReadStream on: bytes readStream).
	
	^ bytes
]
