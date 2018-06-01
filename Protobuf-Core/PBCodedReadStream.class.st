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
