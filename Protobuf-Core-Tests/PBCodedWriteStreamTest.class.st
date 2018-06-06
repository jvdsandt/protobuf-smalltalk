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
PBCodedWriteStreamTest >> testInteger32Fields [

	| stream |
	
	stream := self newStream.
	stream writeField: 1 int32: 1.
	self assert: stream contents equals: #[ 2r00001000 2r00000001 ].

	stream := self newStream.
	stream writeField: 1 uint32: 1.
	self assert: stream contents equals: #[ 2r00001000 2r00000001 ].

	stream := self newStream.
	stream writeField: 1 sint32: 1.
	self assert: stream contents equals: #[ 2r1000 2r00000010 ].

	stream := self newStream.
	stream writeField: 1 fixed32: 1.
	self assert: stream contents equals: #[ 2r00001101 0 0 0 1 ].

	stream := self newStream.
	stream writeField: 1 int32: nil.
	self assert: stream contents equals: #[ ].

]

{ #category : #tests }
PBCodedWriteStreamTest >> testInteger64Fields [

	| stream |
	
	stream := self newStream.
	stream writeField: 1 int64: 1.
	self assert: stream contents equals: #[ 2r00001000 2r00000001 ].

	stream := self newStream.
	stream writeField: 1 uint64: 1.
	self assert: stream contents equals: #[ 2r00001000 2r00000001 ].

	stream := self newStream.
	stream writeField: 1 sint64: 1.
	self assert: stream contents equals: #[ 2r1000 2r00000010 ].

	stream := self newStream.
	stream writeField: 1 fixed64: 1.
	self assert: stream contents equals: #[ 2r00001001 0 0 0 0 0 0 0 1 ].

	stream := self newStream.
	stream writeField: 1 int64: nil.
	self assert: stream contents equals: #[ ].

]
