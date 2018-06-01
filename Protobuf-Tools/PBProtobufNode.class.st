Class {
	#name : #PBProtobufNode,
	#superclass : #Object,
	#category : #'Protobuf-Tools-Model'
}

{ #category : #comparing }
PBProtobufNode >> = otherMessage [

	self == otherMessage
		ifTrue: [ ^true ].
	self class = otherMessage class
		ifFalse: [ ^false ].
		
	1 to: self class instSize do: [  :index|
		(self instVarAt: index) = (otherMessage instVarAt: index)
			ifFalse: [ ^false ] ].
	^ true
]

{ #category : #comparing }
PBProtobufNode >> hash [

	| value |
	value := self class hash.
	1 to: self class instSize do: [ :index |
		value := value bitXor: (self instVarAt: index) hash ].
	^value
]

{ #category : #testing }
PBProtobufNode >> isEnumValueNode [

	^false
]

{ #category : #testing }
PBProtobufNode >> isFieldNode [
	^false
]

{ #category : #testing }
PBProtobufNode >> isOptionNode [

	^false
]
