Class {
	#name : #PBCodedWriteStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'coder'
	],
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBCodedWriteStream class >> on: aByteStream [

	^self new on: aByteStream
]

{ #category : #accessing }
PBCodedWriteStream >> coder [

	^ coder ifNil: [ coder := PBProtobufCoder ]
]

{ #category : #accessing }
PBCodedWriteStream >> contents [

	^stream contents
]

{ #category : #utilities }
PBCodedWriteStream >> decodeUtf8: aByteArray [

	^ ZnUTF8Encoder default decodeBytes: aByteArray
]

{ #category : #utilities }
PBCodedWriteStream >> decodeZigZag32: anInteger [

	^(anInteger bitAt: 1) = 0
			ifTrue: [ anInteger >> 1 ]
			ifFalse: [ ((anInteger + 1) >> 1) negated ]	
]

{ #category : #utilities }
PBCodedWriteStream >> decodeZigZag64: anInteger [

	^(anInteger bitAt: 1) = 0
			ifTrue: [ anInteger >> 1 ]
			ifFalse: [ ((anInteger + 1) >> 1) negated ]	
	
]

{ #category : #utilities }
PBCodedWriteStream >> encodeUtf8: aString [

	^ ZnUTF8Encoder default encodeString: aString
]

{ #category : #utilities }
PBCodedWriteStream >> encodeZigZag32: anInteger [

	^ anInteger >= 0
			ifTrue: [ (anInteger << 1) ]
			ifFalse: [ (anInteger negated << 1) - 1 ]
]

{ #category : #utilities }
PBCodedWriteStream >> encodeZigZag64: anInteger [

	^ anInteger >= 0
			ifTrue: [ (anInteger << 1) ]
			ifFalse: [ (anInteger negated << 1) - 1 ]	
]

{ #category : #initialization }
PBCodedWriteStream >> on: aByteStream [

	stream := aByteStream
]

{ #category : #writing }
PBCodedWriteStream >> putByte: anInteger [

	stream nextPut: anInteger
]

{ #category : #writing }
PBCodedWriteStream >> putBytes: aByteArray [

	stream nextPutAll: aByteArray
]

{ #category : #resources }
PBCodedWriteStream >> wireTypeFixed32 [

	^5
]

{ #category : #resources }
PBCodedWriteStream >> wireTypeFixed64 [

	^1
]

{ #category : #resources }
PBCodedWriteStream >> wireTypeLengthDelimited [

	^2
]

{ #category : #resources }
PBCodedWriteStream >> wireTypeVarint [

	^0
]

{ #category : #writing }
PBCodedWriteStream >> writeByteArray: value [

	self writeUInt32: value size.
	self putBytes: value
]

{ #category : #writing }
PBCodedWriteStream >> writeDouble: aFloat [

	stream nextPutAll: (
		(ByteArray new: 8)
			doubleAt: 1 put: aFloat;
			yourself)
			
]

{ #category : #writing }
PBCodedWriteStream >> writeDouble: aValue field: aFieldNr [

	self writeTag: aFieldNr type: self wireTypeFixed64.
	self writeDouble: aValue
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr bool: aValue [
	"Only write somthing if <aValue> is true."

	aValue = true
		ifTrue: [ 
			self writeTag: aFieldNr type: 0. "Varint"
			self coder writeVarintRaw: 1 on: stream ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr int32List: aList [

	aList isNil
		ifTrue: [ ^ self ].
		
	aList do: [ :eachString |
		self writeField: aFieldNr string: eachString ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr message: aMessage [

	| msgBytes bufferStream |

	aMessage isNil
		ifTrue: [ ^ self ].

	self writeTag: aFieldNr type: 2. "length_delimited"

	bufferStream := WriteStream on: (ByteArray new: 512).
	aMessage writeTo: (self class on: bufferStream).
	msgBytes := bufferStream contents.
	
	self coder writeVarintRaw: msgBytes size on: stream.
	stream nextPutAll: msgBytes
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr messageList: aList [

	aList isNil
		ifTrue: [ ^ self ].

	aList do: [ :eachMessage |
		self writeField: aFieldNr message: eachMessage ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr string: aValue [

	aValue notNil
		ifTrue: [ 
			self writeTag: aFieldNr type: 2. "length_delimited"
			self writeString: aValue ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr stringList: aList [

	aList isNil
		ifTrue: [ ^ self ].
		
	aList do: [ :eachString |
		self writeField: aFieldNr string: eachString ]
]

{ #category : #writing }
PBCodedWriteStream >> writeField: aFieldNr uint64: aValue [

	aValue isNil
		ifTrue: [ ^ self ].
			
	self writeTag: aFieldNr type: 0. "Varint"
	self writeUInt64: aValue
]

{ #category : #writing }
PBCodedWriteStream >> writeFixed32: anInteger [

	self 
		putByte: (anInteger bitAnd: 16rFF);
		putByte: ((anInteger bitShift: 8) bitAnd: 16rFF);
		putByte: ((anInteger bitShift: 16) bitAnd: 16rFF);
		putByte: ((anInteger bitShift: 24) bitAnd: 16rFF)
]

{ #category : #writing }
PBCodedWriteStream >> writeFloat: aFloat [

	stream nextPutAll: (
		(ByteArray new: 4)
			floatAt: 1 put: aFloat;
			yourself)
			
]

{ #category : #writing }
PBCodedWriteStream >> writeFloat: aValue field: aFieldNr [

	self writeTag: aFieldNr type: self wireTypeFixed32.
	self writeFloat: aValue
]

{ #category : #writing }
PBCodedWriteStream >> writeInt32: anInteger [

	self coder writeVarint32: anInteger on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeInt32: aValue field: aFieldNr [

	self writeTag: aFieldNr type: self wireTypeVarInt.
	self writeInt32: aValue
]

{ #category : #writing }
PBCodedWriteStream >> writeString: aValue [

	self writeByteArray: (self coder encodeUtf8: aValue)
]

{ #category : #writing }
PBCodedWriteStream >> writeTag: aFieldNr type: aWireTypeNr [

	self coder writeVarintRaw: (self coder makeTag: aFieldNr wireType: aWireTypeNr) on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeUInt32: anInteger [

	self coder writeVarintRaw: anInteger on: stream
]

{ #category : #writing }
PBCodedWriteStream >> writeUInt64: anInteger [

	self coder writeVarintRaw: anInteger on: stream
]
