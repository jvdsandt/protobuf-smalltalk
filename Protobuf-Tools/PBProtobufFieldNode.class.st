"
Protocol Buffers Field definition. A single field of a message type.
"
Class {
	#name : #PBProtobufFieldNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'number',
		'name',
		'type',
		'cardinality',
		'typeUrl',
		'oneofIndex'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufFieldNode class >> number: aNumber name: aName type: aFieldType [

	^self number: aNumber name: aName type: aFieldType cardinality: #CARDINALITY_OPTIONAL
]

{ #category : #'instance creation' }
PBProtobufFieldNode class >> number: aNumber name: aName type: aFieldType cardinality: aCardEnum [ 

	^self new initWithNumber: aNumber 
		name: aName 
		type: aFieldType 
		cardinality: aCardEnum
]

{ #category : #'instance creation' }
PBProtobufFieldNode class >> number: aNumber name: aName typeName: aTypeName [

	^self number: aNumber
		name: aName 
		type: (PBProtobufTypeNode name: aTypeName)
]

{ #category : #accessing }
PBProtobufFieldNode >> cardinality [
	^ cardinality
]

{ #category : #accessing }
PBProtobufFieldNode >> defaultValue [

	^ self isCardinalityRepeated
		ifTrue: [ #() ]
		ifFalse: [ self type defaultValue ]
]

{ #category : #initialization }
PBProtobufFieldNode >> initWithNumber: aNumber name: aName type: aFieldType cardinality: aCardEnum [ 

	cardinality := aCardEnum.
	number := aNumber.
	name := aName.
	type := aFieldType
]

{ #category : #testing }
PBProtobufFieldNode >> isCardinalityOptional [

	^ self cardinality = #CARDINALITY_OPTIONAL
]

{ #category : #testing }
PBProtobufFieldNode >> isCardinalityRepeated [

	^ self cardinality = #CARDINALITY_REPEATED
]

{ #category : #testing }
PBProtobufFieldNode >> isFieldNode [
	^true
]

{ #category : #accessing }
PBProtobufFieldNode >> name [
	^ name
]

{ #category : #accessing }
PBProtobufFieldNode >> number [

	^ number
]

{ #category : #printing }
PBProtobufFieldNode >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $<;
		print: self name;
		nextPut: $>
]

{ #category : #accessing }
PBProtobufFieldNode >> tagNumber [

	^ PBProtobufCoder makeTag: self number wireType: self type wireType
]

{ #category : #accessing }
PBProtobufFieldNode >> type [
	^ type
]

{ #category : #accessing }
PBProtobufFieldNode >> typeName [
	^ self type name
]

{ #category : #accessing }
PBProtobufFieldNode >> typeUrl [
	^ typeUrl
]

{ #category : #accessing }
PBProtobufFieldNode >> wireType [

	^ self isCardinalityRepeated
			ifTrue: [ PBProtobufTypeNode wireTypeLengthDelimited ]
			ifFalse: [ self type wireType ]
]
