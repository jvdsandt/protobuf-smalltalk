Class {
	#name : #PBProtobufCoderTest,
	#superclass : #TestCase,
	#category : #'Protobuf-Core-Tests'
}

{ #category : #accessing }
PBProtobufCoderTest >> coder [

	^ PBProtobufCoder
]

{ #category : #tests }
PBProtobufCoderTest >> testVarInt32 [

	self assert: (self coder encodeVarint32: 0) equals: #[ 0 ].
	self assert: (self coder encodeVarint32: 1) equals: #[ 1 ].
	self assert: (self coder encodeVarint32: 300) equals: #[ 2r10101100 2r00000010 ].	
	self assert: (self coder encodeVarint32: 16r7FFFFFFF) equals: #[ 16rFF 16rFF 16rFF 16rFF 16r07 ].
	
	self assert: (self coder encodeVarint32: -1) equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16r01 ].

	#( 0 1 100 100000 16r7FFFFFF -1 -100 -100000 -16r7FFFFFF -16r80000000 ) do: [ :eachInt |
		self assert: (self coder decodeVarint32: (self coder encodeVarint32: eachInt)) equals: eachInt ].

]

{ #category : #tests }
PBProtobufCoderTest >> testVarInt64 [

	self assert: (self coder encodeVarint32: 0) equals: #[ 0 ].
	self assert: (self coder encodeVarint64: 1) equals: #[ 1 ].
	self assert: (self coder encodeVarint64: 300) equals: #[ 2r10101100 2r00000010 ].	
	
	self assert: (self coder encodeVarint64: -1) size equals: 10.
	self assert: (self coder encodeVarint64: -1) equals: #[ 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16r01 ].

	#( 0 1 100 100000 16rFFFFFFFF 16r7fffFFFFffffFFFF -1 -100 -100000 -16rFFFFFFFF -16r7FFFFFFFFFFFFFF -16r8000000000000000 ) do: [ :eachInt |
		self assert: (self coder decodeVarint64: (self coder encodeVarint64: eachInt)) equals: eachInt ].

]
