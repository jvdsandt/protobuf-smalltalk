Class {
	#name : #PBMessage,
	#superclass : #Object,
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBMessage class >> readFrom: aCodedReadStream [

	^self new readFrom: aCodedReadStream
]

{ #category : #comparing }
PBMessage >> = otherMessage [

	self == otherMessage
		ifTrue: [ ^ true ].
	self class = otherMessage class
		ifFalse: [ ^ false ].
	1 to: self class instSize do: [ :index |
		(self instVarAt: index) = (otherMessage instVarAt: index)
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #converting }
PBMessage >> asBytes [

	^ByteArray streamContents: [ :s |
		self writeTo: (PBCodedWriteStream on: s) ]
]

{ #category : #comparing }
PBMessage >> hash [

	| value |
	
	value := self class hash.
	1 to: self class instSize do: [ :index |
		value := value bitXor: (self instVarAt: index) hash ].
	^ value
]

{ #category : #'as yet unclassified' }
PBMessage >> readUnknownField: aTag from: anInput [

	anInput skipField: aTag
]
