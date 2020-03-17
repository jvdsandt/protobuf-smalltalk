Class {
	#name : #PBProtobufCoder,
	#superclass : #Object,
	#pools : [
		'PBProtobufConstants'
	],
	#category : #'Protobuf-Core'
}

{ #category : #'coder-varint' }
PBProtobufCoder class >> decodeVarint32: aByteArray [

	^ self readVarint32: aByteArray readStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> decodeVarint64: aByteArray [

	^ self readVarint64: aByteArray readStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> decodeZigZag32: anInteger [

	^(anInteger bitAt: 1) = 0
			ifTrue: [ anInteger >> 1 ]
			ifFalse: [ ((anInteger + 1) >> 1) negated ]	
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> decodeZigZag64: anInteger [

	^(anInteger bitAt: 1) = 0
			ifTrue: [ anInteger >> 1 ]
			ifFalse: [ ((anInteger + 1) >> 1) negated ]	
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> encodeVarint32: anInteger [

	^ ByteArray streamContents: [ :s | self writeVarint32: anInteger on: s ]
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> encodeVarint64: anInteger [

	^ ByteArray streamContents: [ :s | self writeVarint64: anInteger on: s ]
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> encodeZigZag32: anInteger [

	^ anInteger >= 0
			ifTrue: [ (anInteger << 1) ]
			ifFalse: [ (anInteger negated << 1) - 1 ]
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> encodeZigZag64: anInteger [

	^ anInteger >= 0
			ifTrue: [ (anInteger << 1) ]
			ifFalse: [ (anInteger negated << 1) - 1 ]	
]

{ #category : #'coder-tags' }
PBProtobufCoder class >> getTagFieldNumber: anInteger [
	"Given a tag value, determines the field number (the upper 29 bits)."

	^ anInteger >> 3
]

{ #category : #'coder-tags' }
PBProtobufCoder class >> getTagWireType: anInteger [
	"Given a tag value, determines the wire type (the lower 3 bits)."

	^ anInteger bitAnd: 2r111
]

{ #category : #testing }
PBProtobufCoder class >> is32bitField: aTag [

	^(self getTagWireType: aTag) = WireType32bit
]

{ #category : #testing }
PBProtobufCoder class >> is64bitField: aTag [

	^(self getTagWireType: aTag) = WireType64bit
]

{ #category : #testing }
PBProtobufCoder class >> isLengthDelimitedField: aTag [

	^(self getTagWireType: aTag) = WireTypeLengthDelimited
]

{ #category : #testing }
PBProtobufCoder class >> isVarintField: aTag [

	^(self getTagWireType: aTag) = WireTypeVarint
]

{ #category : #'coder-tags' }
PBProtobufCoder class >> makeTag: aFieldNr wireType: aTypeNr [

	^ (aFieldNr << 3) bitOr: aTypeNr
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readDouble: aByteStream [

	^ (aByteStream next: 8) doubleAt: 1
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readFixed32: aByteStream [

	| n |
	n := aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	^ n
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readFixed64: aByteStream [

	| n |
	n := aByteStream next.
	7 timesRepeat: [ 
		n := (n bitShift: 8) + aByteStream next ].
	^ n
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readFloat: aByteStream [

	^ (aByteStream next: 4) floatAt: 1
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readSFixed32: aByteStream [

	| n firstDigit |
	n := firstDigit := aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	n := (n bitShift: 8) + aByteStream next.
	firstDigit >= 128 ifTrue: [n := -16r100000000 + n].  "decode negative 32-bit integer"
	^ n

]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> readSFixed64: aByteStream [

	| n firstDigit |
	n := firstDigit := aByteStream next.
	7 timesRepeat: [ 
		n := (n bitShift: 8) + aByteStream next ].
	firstDigit >= 128 ifTrue: [n := -16r10000000000000000 + n].  "decode negative 64-bit integer"
	^ n

]

{ #category : #'coder-length-delimited' }
PBProtobufCoder class >> readString: aByteSize from: aByteStream [

	| decoder limit |
	
	decoder := self utf8Encoder.
	limit := aByteStream position + aByteSize.
	^ String streamContents: [ :s |
		[ aByteStream position < limit ]
			whileTrue: [ s nextPut: (decoder nextFromStream: aByteStream) ] ]
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> readVarint32: aByteStream [

	^ self readVarint64: aByteStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> readVarint64: aByteStream [

	| val |
	
	val := self readVarintRaw: aByteStream.
	
	^val < 16r8000000000000000
		ifTrue: [ val ]
		ifFalse: [ val - 16r10000000000000000 ]
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> readVarintRaw: aByteStream [

	| val byte shift |
	
	val := 0.
	shift := 0.
		
	[ 	byte := aByteStream next.
		byte isNil
			ifTrue: [ self error: 'Invalid protobuf stream' ].
		val := val + ((byte bitAnd: 16r7F) << shift).
		byte < 128 ]
			whileFalse: [ shift := shift + 7 ].
	^ val
]

{ #category : #'coder-length-delimited' }
PBProtobufCoder class >> utf8Encoder [

	^ ZnUTF8Encoder utf8
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeDouble: aFloat on: aByteStream [

	aByteStream nextPutAll: (
		(ByteArray new: 8)
			doubleAt: 1 put: aFloat;
			yourself)

]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeFixed32: anInteger on: aByteStream [
	aByteStream nextPut: (anInteger byteAt: 4).
	aByteStream nextPut: (anInteger byteAt: 3).
	aByteStream nextPut: (anInteger byteAt: 2).
	aByteStream nextPut: (anInteger byteAt: 1)
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeFixed64: anInteger on: aByteStream [
	aByteStream nextPut: (anInteger byteAt: 8).
	aByteStream nextPut: (anInteger byteAt: 7).
	aByteStream nextPut: (anInteger byteAt: 6).
	aByteStream nextPut: (anInteger byteAt: 5).
	aByteStream nextPut: (anInteger byteAt: 4).
	aByteStream nextPut: (anInteger byteAt: 3).
	aByteStream nextPut: (anInteger byteAt: 2).
	aByteStream nextPut: (anInteger byteAt: 1)
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeFloat: aFloat on: aByteStream [

	aByteStream nextPutAll: (
		(ByteArray new: 4)
			floatAt: 1 put: aFloat;
			yourself)

]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeSFixed32: anInteger on: aByteStream [

	self writeFixed32: (anInteger < 0
		ifTrue: [ 16r100000000 + anInteger ]
		ifFalse: [ anInteger ]) on: aByteStream
]

{ #category : #'coder-fixed' }
PBProtobufCoder class >> writeSFixed64: anInteger on: aByteStream [

	self writeFixed64: (anInteger < 0
		ifTrue: [ 16r10000000000000000 + anInteger ]
		ifFalse: [ anInteger ]) on: aByteStream
]

{ #category : #'coder-length-delimited' }
PBProtobufCoder class >> writeString: aString on: aByteStream [

	self utf8Encoder next: aString size putAll: aString startingAt: 1 toStream: aByteStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> writeVarint32: anInteger on: aByteStream [

	self writeVarint64: anInteger on: aByteStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> writeVarint64: anInteger on: aByteStream [

	self writeVarintRaw: (
			anInteger < 0
				ifTrue: [ 16r10000000000000000 + anInteger ]
				ifFalse: [ anInteger ])
		on: aByteStream
]

{ #category : #'coder-varint' }
PBProtobufCoder class >> writeVarintRaw: aPositiveInteger on: aByteStream [

	| val |
	
	val := aPositiveInteger.
	[ true ]
		whileTrue: [ 
			val < 128
				ifTrue: [ 
					aByteStream nextPut: val.
					^self ]
				ifFalse: [ 
					aByteStream nextPut: (val bitAnd: 16r7F) + 16r80.
					val := val >> 7 ] ]
]
