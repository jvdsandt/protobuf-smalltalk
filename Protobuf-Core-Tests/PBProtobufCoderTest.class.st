Class {
	#name : #PBProtobufCoderTest,
	#superclass : #TestCase,
	#instVars : [
		'coder'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #tests }
PBProtobufCoderTest >> assertStream: aBlock equals: aByteArray [

	self assert: (ByteArray streamContents: aBlock) equals: aByteArray
]

{ #category : #accessing }
PBProtobufCoderTest >> coder [

	^ coder
]

{ #category : #initialization }
PBProtobufCoderTest >> createCoder [

	^ PBProtobufCoder
]

{ #category : #initialization }
PBProtobufCoderTest >> setUp [

	super setUp.
	coder := self createCoder
]

{ #category : #tests }
PBProtobufCoderTest >> testDouble [

	| stream bytes |
	
	stream := WriteStream on: (ByteArray new: 100).
	coder writeDouble: 12345.67 on: stream.
	bytes := stream contents.
	
	self assert: bytes size equals: 8.
	self assert: (coder readDouble: bytes readStream) equals: 12345.67.

]

{ #category : #tests }
PBProtobufCoderTest >> testEncodeZigZag [

	self assert: (coder encodeZigZag32: 0) equals: 0.
	self assert: (coder encodeZigZag32: -1) equals: 1.
	self assert: (coder encodeZigZag32: 1) equals: 2.
	self assert: (coder encodeZigZag32: -2) equals: 3.
	self assert: (coder encodeZigZag32: 16r3FFFFFFF) equals: 16r7FFFFFFE.
	self assert: (coder encodeZigZag32: -16r40000000) equals: 16r7FFFFFFF.
	self assert: (coder encodeZigZag32: 16r7FFFFFFF) equals: 16rFFFFFFFE.
	self assert: (coder encodeZigZag32: -16r80000000) equals: 16rFFFFFFFF.

	self assert: (coder encodeZigZag64: 0) equals: 0.
	self assert: (coder encodeZigZag64: -1) equals: 1.
	self assert: (coder encodeZigZag64: 1) equals: 2.
	self assert: (coder encodeZigZag64: -2) equals: 3.
	
	self assert: (coder decodeZigZag32: 0) equals: 0.
	self assert: (coder decodeZigZag32: 1) equals: -1.
	self assert: (coder decodeZigZag32: 2) equals: 1.
	self assert: (coder decodeZigZag32: 3) equals: -2.
	
	self assert: (coder encodeZigZag32: (coder decodeZigZag32: 0)) equals: 0.
	self assert: (coder encodeZigZag32: (coder decodeZigZag32: 1)) equals: 1.
	"self assert: (coder encodeZigZag32: (coder decodeZigZag32: -1)) equals: -1."
	self assert: (coder encodeZigZag32: (coder decodeZigZag32: 14927)) equals: 14927.
	"self assert: (coder encodeZigZag32: (coder decodeZigZag32: -3612)) equals: -3612."

]

{ #category : #tests }
PBProtobufCoderTest >> testFixed32 [

	self assertStream: [ :s | coder writeFixed32: 0 on: s ] equals: #[ 0 0 0 0 ].
	self assertStream: [ :s | coder writeFixed32: 1 on: s ] equals: #[ 0 0 0 1 ].
	self assertStream: [ :s | coder writeFixed32: 16rFFFFFFFF on: s ] equals: #[ 16rFF 16rFF 16rFF 16rFF ].

	self assert: (coder readFixed32: #[ 0 0 0 0 ] readStream) equals: 0.
	self assert: (coder readFixed32: #[ 0 0 0 1 ] readStream) equals: 1.
	self assert: (coder readFixed32: #[ 0 0 1 0 ] readStream) equals: 256.
	self assert: (coder readFixed32: #[ 16rFF 16rFF 16rFF 16rFF ] readStream) equals: 16rFFFFFFFF.
]

{ #category : #tests }
PBProtobufCoderTest >> testFixed64 [

	self assertStream: [ :s | coder writeFixed64: 0 on: s ] equals: #[ 0 0 0 0 0 0 0 0 ].
	self assertStream: [ :s | coder writeFixed64: 1 on: s ] equals: #[ 0 0 0 0 0 0 0 1 ].
	self assertStream: [ :s | coder writeFixed64: 16rFFFFFFFF on: s ] equals: #[ 0 0 0 0 16rFF 16rFF 16rFF 16rFF ].
	self assertStream: [ :s | coder writeFixed64: 16rFFFFFFFFFFFFFFFF on: s ] equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF ].

	self assert: (coder readFixed64: #[ 0 0 0 0 0 0 0 0 ] readStream) equals: 0.
	self assert: (coder readFixed64: #[ 0 0 0 0 0 0 0 1 ] readStream) equals: 1.


]

{ #category : #tests }
PBProtobufCoderTest >> testFloat [

	| stream bytes |
	
	stream := WriteStream on: (ByteArray new: 100).
	coder writeFloat: 123.67 on: stream.
	bytes := stream contents.
	
	self assert: bytes size equals: 4.
	self assert: ((coder readFloat: bytes readStream) - 123.67) abs < 0.001.

]

{ #category : #tests }
PBProtobufCoderTest >> testSFixed32 [

	self assertStream: [ :s | coder writeSFixed32: 0 on: s ] equals: #[ 0 0 0 0 ].
	self assertStream: [ :s | coder writeSFixed32: 1 on: s ] equals: #[ 0 0 0 1 ].
	self assertStream: [ :s | coder writeSFixed32: -1 on: s ] equals: #[ 16rFF 16rFF 16rFF 16rFF ].
	self assertStream: [ :s | coder writeSFixed32: 16r00FFFFFF on: s ] equals: #[ 16r00 16rFF 16rFF 16rFF ].

	self assert: (coder readSFixed32: #[ 0 0 0 0 ] readStream) equals: 0.
	self assert: (coder readSFixed32: #[ 0 0 0 1 ] readStream) equals: 1.
	self assert: (coder readSFixed32: #[ 0 0 1 0 ] readStream) equals: 256.
	self assert: (coder readSFixed32: #[ 16r00 16rFF 16rFF 16rFF ] readStream) equals: 16r00FFFFFF.
	self assert: (coder readSFixed32: #[ 16rFF 16rFF 16rFF 16rFF ] readStream) equals: -1.
]

{ #category : #tests }
PBProtobufCoderTest >> testSFixed64 [

	self assertStream: [ :s | coder writeSFixed64: 0 on: s ] equals: #[ 0 0 0 0 0 0 0 0 ].
	self assertStream: [ :s | coder writeSFixed64: 1 on: s ] equals: #[ 0 0 0 0 0 0 0 1 ].
	self assertStream: [ :s | coder writeSFixed64: -1 on: s ] equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF ].
	self assertStream: [ :s | coder writeSFixed64: 16r00FFFFFF on: s ] equals: #[ 0 0 0 0 0 16rFF 16rFF 16rFF ].

	self assert: (coder readSFixed64: #[ 0 0 0 0 0 0 0 0 ] readStream) equals: 0.
	self assert: (coder readSFixed64: #[ 0 0 0 0 0 0 0 1 ] readStream) equals: 1.
	self assert: (coder readSFixed64: #[ 0 0 0 0 0 0 1 0 ] readStream) equals: 256.
	self assert: (coder readSFixed64: #[ 16r00 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF ] readStream) equals: 16r00FFFFFFFFFFFFFF.
	self assert: (coder readSFixed64: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF ] readStream) equals: -1.
]

{ #category : #tests }
PBProtobufCoderTest >> testVarInt32 [

	self assert: (coder encodeVarint32: 0) equals: #[ 0 ].
	self assert: (coder encodeVarint32: 1) equals: #[ 1 ].
	self assert: (coder encodeVarint32: 300) equals: #[ 2r10101100 2r00000010 ].	
	self assert: (coder encodeVarint32: 16r7FFFFFFF) equals: #[ 16rFF 16rFF 16rFF 16rFF 16r07 ].
	
	self assert: (coder encodeVarint32: -1) equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16r01 ].

	#( 0 1 100 100000 16r7FFFFFF -1 -100 -100000 -16r7FFFFFF -16r80000000 ) do: [ :eachInt |
		self assert: (coder decodeVarint32: (coder encodeVarint32: eachInt)) equals: eachInt ].

]

{ #category : #tests }
PBProtobufCoderTest >> testVarInt64 [

	self assert: (coder encodeVarint32: 0) equals: #[ 0 ].
	self assert: (coder encodeVarint64: 1) equals: #[ 1 ].
	self assert: (coder encodeVarint64: 300) equals: #[ 2r10101100 2r00000010 ].	
	
	self assert: (coder encodeVarint64: -1) size equals: 10.
	self assert: (coder encodeVarint64: -1) equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16r01 ].

	#( 0 1 100 100000 16rFFFFFFFF 16r7fffFFFFffffFFFF -1 -100 -100000 -16rFFFFFFFF -16r7FFFFFFFFFFFFFF -16r8000000000000000 ) do: [ :eachInt |
		self assert: (coder decodeVarint64: (coder encodeVarint64: eachInt)) equals: eachInt ].

]
