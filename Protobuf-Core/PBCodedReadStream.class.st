Class {
	#name : #PBCodedReadStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'coder'
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

	^ coder ifNil: [ coder := PBProtobufCoder ]
]

{ #category : #'instance creation' }
PBCodedReadStream >> on: aByteStream [

	stream := aByteStream
]

{ #category : #'write and read' }
PBCodedReadStream >> readBool [

	^ (self coder readVarintRaw: stream) ~= 0
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
PBCodedReadStream >> readString [

	| byteCount bytes |
	
	byteCount := self coder readVarintRaw: stream.
	bytes := stream next: byteCount.
	
	^self coder decodeUtf8: bytes
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
PBCodedReadStream >> readUInt32 [
	
	^self coder readVarintRaw: stream
]

{ #category : #'write and read' }
PBCodedReadStream >> readUInt64 [
	
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
