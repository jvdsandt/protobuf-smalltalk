Class {
	#name : #PBType,
	#superclass : #Object,
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBType class >> readFrom: aCodedReadStream [
	^ self new readFrom: aCodedReadStream
]

{ #category : #comparing }
PBType >> = otherMessage [

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
PBType >> asBytes [
	^ ByteArray
		streamContents: [ :s | self writeTo: (PBCodedWriteStream on: s) ]
]

{ #category : #comparing }
PBType >> hash [
	| value |
	value := self class hash.
	1 to: self class instSize do: [ :index | value := value bitXor: (self instVarAt: index) hash ].
	^ value
]

{ #category : #testing }
PBType >> isEnum [
	^false
]

{ #category : #testing }
PBType >> isMessage [
	^ false
]

{ #category : #'input-output' }
PBType >> readFrom: pbReadStream [
self subclassResponsibility 
]

{ #category : #'input-output' }
PBType >> writeTo: aCodedReadStream [
	self subclassResponsibility
]
