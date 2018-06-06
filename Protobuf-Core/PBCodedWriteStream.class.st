Class {
	#name : #PBCodedWriteStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'coder'
	],
	#pools : [
		'PBProtobufConstants'
	],
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBCodedWriteStream class >> on: aByteStream [

	^self new on: aByteStream
]

{ #category : #'as yet unclassified' }
PBCodedWriteStream >> buffer: aBlock [

	^ByteArray streamContents: aBlock
]

{ #category : #accessing }
PBCodedWriteStream >> coder [

	^ coder
]

{ #category : #accessing }
PBCodedWriteStream >> contents [

	^stream contents
]

{ #category : #initialization }
PBCodedWriteStream >> on: aByteStream [

	self on: aByteStream coder: PBProtobufCoder
]

{ #category : #initialization }
PBCodedWriteStream >> on: aByteStream coder: aCoder [

	stream := aByteStream.
	coder := aCoder
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr bool: aValue [
	"Only write somthing if <aValue> is true."

	aValue = true
		ifTrue: [ 
			self writeTag: aFieldNr type: WireTypeVarint.
			coder writeVarintRaw: 1 on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr boolList: aList [
	
	aList isEmptyOrNil
		ifTrue: [ ^ self ].

	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size on: stream.
	aList do: [ :eachBool |
		coder writeVarintRaw: (eachBool ifTrue: [ 1 ] ifFalse: [ 0 ]) on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr bytes: aByteArray [

	aByteArray isEmptyOrNil
		ifTrue: [ ^ self ].
		
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aByteArray size on: stream.
	stream nextPutAll: aByteArray
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr double: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType64bit.
	coder writeDouble: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr doubleList: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 8 on: stream.
	aList do: [ :eachInt |
		coder writeDouble: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr fixed32: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType32bit.
	coder writeFixed32: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr fixed32List: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 4 on: stream.
	aList do: [ :eachInt |
		coder writeFixed32: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr fixed64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType64bit.
	coder writeFixed64: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr fixed64List: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 8 on: stream.
	aList do: [ :eachInt |
		coder writeFixed64: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr float: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType64bit.
	coder writeFloat: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr floatList: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 4 on: stream.
	aList do: [ :eachInt |
		coder writeFloat: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr int32: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarint32: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr int32List: aList [

	| bufStream |

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
		
	bufStream := WriteStream on: (ByteArray new: aList size * 4).
	aList do: [ :eachInteger |
		coder writeVarint32: eachInteger on: bufStream ].
	
	self writeField: aFieldNr bytes: bufStream contents
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr int64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarint64: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr message: aMessage [

	| msgBytes |

	aMessage isNil
		ifTrue: [ ^ self ].
		
	msgBytes := self buffer: [ :s | aMessage writeTo: (self class on: s) ].
	self writeField: aFieldNr bytes: msgBytes.
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr messageList: aList [

	aList isNil
		ifTrue: [ ^ self ].

	aList do: [ :eachMessage |
		self writeField: aFieldNr message: eachMessage ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sfixed32: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType32bit.
	coder writeSFixed32: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sfixed32List: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 4 on: stream.
	aList do: [ :eachInt |
		coder writeSFixed32: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sfixed64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireType64bit.
	coder writeSFixed64: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sfixed64List: aList [

	aList isEmptyOrNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeLengthDelimited.
	coder writeVarintRaw: aList size * 8 on: stream.
	aList do: [ :eachInt |
		coder writeSFixed64: eachInt on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sint32: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarintRaw: (coder encodeZigZag32: aValue) on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr sint64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarintRaw: (coder encodeZigZag64: aValue) on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr string: aValue [

	| bytes |
	
	aValue isNil
		ifTrue: [ ^ self ].
		
	bytes := self buffer: [ :s | coder writeString: aValue on: s ].
	self writeField: aFieldNr bytes: bytes
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr stringList: aList [

	aList isNil
		ifTrue: [ ^ self ].
		
	aList do: [ :eachString |
		self writeField: aFieldNr string: eachString ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr uint32: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarintRaw: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr uint64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: WireTypeVarint.
	coder writeVarintRaw: aValue on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeTag: aFieldNr type: aWireTypeNr [

	coder writeVarintRaw: (coder makeTag: aFieldNr wireType: aWireTypeNr) on: stream
]
