Class {
	#name : #PBCodedWriteStreamTest,
	#superclass : #TestCase,
	#category : #'Protobuf-Core-Tests'
}

{ #category : #tests }
PBCodedWriteStreamTest >> newStream [

	^PBCodedWriteStream on: (WriteStream on: (ByteArray new: 1000))
]

{ #category : #tests }
PBCodedWriteStreamTest >> testEncodeZigZag [

	| stream |
	
	stream := self newStream.
	self assert: (stream encodeZigZag32: 0) equals: 0.
	self assert: (stream encodeZigZag32: -1) equals: 1.
	self assert: (stream encodeZigZag32: 1) equals: 2.
	self assert: (stream encodeZigZag32: -2) equals: 3.
	self assert: (stream encodeZigZag32: 16r3FFFFFFF) equals: 16r7FFFFFFE.
	self assert: (stream encodeZigZag32: -16r40000000) equals: 16r7FFFFFFF.
	self assert: (stream encodeZigZag32: 16r7FFFFFFF) equals: 16rFFFFFFFE.
	self assert: (stream encodeZigZag32: -16r80000000) equals: 16rFFFFFFFF.

	self assert: (stream encodeZigZag64: 0) equals: 0.
	self assert: (stream encodeZigZag64: -1) equals: 1.
	self assert: (stream encodeZigZag64: 1) equals: 2.
	self assert: (stream encodeZigZag64: -2) equals: 3.
	
	self assert: (stream decodeZigZag32: 0) equals: 0.
	self assert: (stream decodeZigZag32: 1) equals: -1.
	self assert: (stream decodeZigZag32: 2) equals: 1.
	self assert: (stream decodeZigZag32: 3) equals: -2.
	
	self assert: (stream encodeZigZag32: (stream decodeZigZag32: 0)) equals: 0.
	self assert: (stream encodeZigZag32: (stream decodeZigZag32: 1)) equals: 1.
	"self assert: (stream encodeZigZag32: (stream decodeZigZag32: -1)) equals: -1."
	self assert: (stream encodeZigZag32: (stream decodeZigZag32: 14927)) equals: 14927.
	"self assert: (stream encodeZigZag32: (stream decodeZigZag32: -3612)) equals: -3612."

]

{ #category : #tests }
PBCodedWriteStreamTest >> testUInt32 [

	| stream |
	
	stream := self newStream.
	stream writeUInt32: 1.
	self assert: stream contents equals: #[ 2r00000001 ].

	stream := self newStream.
	stream writeUInt32: 300.
	self assert: stream contents equals: #[ 2r10101100 2r00000010 ].
	

]
