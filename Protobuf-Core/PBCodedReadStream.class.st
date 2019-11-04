Class {
	#name : #PBCodedReadStream,
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
PBCodedReadStream class >> on: aByteStream [

	^self new on: aByteStream
]

{ #category : #accessing }
PBCodedReadStream >> atEnd [

	^ stream atEnd
]

{ #category : #accessing }
PBCodedReadStream >> coder [

	^ coder
]

{ #category : #'instance creation' }
PBCodedReadStream >> on: aByteStream [

	self on: aByteStream coder: PBProtobufCoder
]

{ #category : #'instance creation' }
PBCodedReadStream >> on: aByteStream coder: aCoder [

	stream := aByteStream.
	coder := aCoder
]

{ #category : #'write and read' }
PBCodedReadStream >> readBool [

	^ (coder readVarintRaw: stream) ~= 0
]

{ #category : #'write and read' }
PBCodedReadStream >> readBoolList [

	| size list limit |
	
	size := coder readVarintRaw: stream.
	list := OrderedCollection new: size.
	limit := stream position + size.
	[ stream position < limit ]
		whileTrue: [ list add: (coder readVarintRaw: stream) ~= 0 ].
	stream position = limit
		ifFalse: [ self error: 'wrong' ].
	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readBytes [
	| byteCount |
	byteCount := coder readVarintRaw: stream.
	^ stream next: byteCount 
]

{ #category : #'write and read' }
PBCodedReadStream >> readDouble [
	
	^coder readDouble: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readDoubleList [

	| length size list |
	
	length := coder readVarintRaw: stream.
	length \\ 8 ~= 0
		ifTrue: [ self error: 'Invalid double list length' ].
	size := length / 8.
	
	list := OrderedCollection new: size.
	size timesRepeat: [ 
		list add: (coder readDouble: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readFixed32 [
	
	^coder readFixed32: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readFixed32List [

	| length size list |
	
	length := coder readVarintRaw: stream.
	length \\ 4 ~= 0
		ifTrue: [ self error: 'Invalid fixed32 list length' ].
	size := length / 4.
		
	list := OrderedCollection new: size.
	size timesRepeat: [ 
		list add: (coder readFixed32: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readFixed64 [
	
	^coder readFixed64: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readFixed64List [

	| length size list |
	
	length := coder readVarintRaw: stream.
	length \\ 8 ~= 0
		ifTrue: [ self error: 'Invalid fixed64 list length' ].
	size := length // 8.
		
	list := OrderedCollection new: size.
	size timesRepeat: [ 
		list add: (coder readFixed64: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readFloat [
	
	^coder readFloat: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readFloatList [

	| length size list |
	
	length := coder readVarintRaw: stream.
	length \\ 4 ~= 0
		ifTrue: [ self error: 'Invalid float list length' ].
	size := length / 4.
		
	list := OrderedCollection new: size.
	size timesRepeat: [ 
		list add: (coder readFloat: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readInt32 [
	
	^self coder readVarint32: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readInt32List [

	| length list limit |
	
	length := self coder readVarintRaw: stream.
	list := OrderedCollection new: length.
	limit := stream position + length.
	[ stream position < limit ]
		whileTrue: [ list add: (self coder readVarint32: stream) ].
	stream position = limit
		ifFalse: [ self error: 'wrong' ].
	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readInt64 [
	
	^self coder readVarint64: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readMessage: aMessageClass [

	| length substream |
	
	length := self coder readVarintRaw: stream.
	
	substream := ReadStream on: stream originalContents 
			from: stream position + 1
			to: stream position + length.
			
	stream skip: length.
	
	^ aMessageClass readFrom: (self class on: substream)
	
]

{ #category : #'write and read' }
PBCodedReadStream >> readSfixed32 [
	
	^coder readSFixed32: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readSfixed32List [

	| length list |
	
	length := coder readVarintRaw: stream.
	length \\ 4 ~= 0
		ifTrue: [ self error: 'Invalid sfixed32 list length' ].
		
	list := OrderedCollection new: length / 4.
	list size timesRepeat: [ 
		list add: (coder readSFixed32: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readSfixed64 [
	
	^coder readSFixed64: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readSfixed64List [

	| length size list |
	
	length := coder readVarintRaw: stream.
	length \\ 8 ~= 0
		ifTrue: [ self error: 'Invalid sfixed64 list length' ].
	size := length // 8.
		
	list := OrderedCollection new: size.
	size timesRepeat: [ 
		list add: (coder readSFixed64: stream) ].

	^ list
]

{ #category : #'write and read' }
PBCodedReadStream >> readSint32 [
	
	^coder decodeZigZag32: (coder readVarintRaw: stream)
]

{ #category : #'write and read' }
PBCodedReadStream >> readSint64 [
	
	^coder decodeZigZag64: (coder readVarintRaw: stream)
]

{ #category : #'write and read' }
PBCodedReadStream >> readString [

	| byteCount |
	
	byteCount := coder readVarintRaw: stream.
	^ coder readString: byteCount from: stream
]

{ #category : #'as yet unclassified' }
PBCodedReadStream >> readTag [

	| lastTag |
	
	lastTag := self coder readVarintRaw: stream.
	(self coder getTagFieldNumber: lastTag) = 0
		ifTrue: [ self invalidProtobufError: 'Invalid tag' ].
	^ lastTag
]

{ #category : #'write and read' }
PBCodedReadStream >> readUint32 [
	^ self coder readVarint32: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readUint64 [
	
	^self coder readVarintRaw: stream
]

{ #category : #'as yet unclassified' }
PBCodedReadStream >> skipField: aTag [

	(self coder isVarintField: aTag)
		ifTrue: [ 
			self coder readVarintRaw: stream.
			^self ].

	(self coder is64bitField: aTag)
		ifTrue: [ 
			stream skip: 8.
			^self ].
		
	(self coder isLengthDelimitedField: aTag)
		ifTrue: [ 
			stream skip: (self coder readVarintRaw: stream).
			^self ].

	(self coder is32bitField: aTag)
		ifTrue: [ 
			stream skip: 4.
			^self ].
		
	self error: 'Unknown wire type'
	
]
