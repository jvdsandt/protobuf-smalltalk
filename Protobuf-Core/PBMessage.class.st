Class {
	#name : #PBMessage,
	#superclass : #Object,
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBMessage class >> readFrom: aCodedReadStream [

	^self new readFrom: aCodedReadStream
]

{ #category : #converting }
PBMessage >> asBytes [

	^ByteArray streamContents: [ :s |
		self writeTo: (PBCodedWriteStream on: s) ]
]

{ #category : #'as yet unclassified' }
PBMessage >> readUnknownField: aTag from: anInput [

	anInput skipField: aTag
]
