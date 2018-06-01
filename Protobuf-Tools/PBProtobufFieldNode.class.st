"
Protocol Buffers Field definition. A single field of a message type.
"
Class {
	#name : #PBProtobufFieldNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'kind',
		'cardinality',
		'number',
		'name',
		'typeUrl',
		'oneofIndex'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufFieldNode class >> kind: aKindEnum cardinality: aCardEnum number: aNumber name: aName [ 

	^self new initWithKind: aKindEnum 
		cardinality: aCardEnum 
		number: aNumber 
		name: aName 
]

{ #category : #'instance creation' }
PBProtobufFieldNode class >> standardTypes [

	^ Dictionary new
		at: 'double' put: #TYPE_DOUBLE;
		at: 'float' put: #TYPE_FLOAT;
		at: 'int64' put: #TYPE_INT64;
		at: 'uint64' put: #TYPE_UINT64;		
		at: 'int32' put: #TYPE_INT32;
		at: 'uint32' put: #TYPE_UINT32;		
		at: 'fixed64' put: #TYPE_FIXED64;
		at: 'fixed32' put: #TYPE_FIXED32;
		at: 'bool' put: #TYPE_BOOL;
		at: 'string' put: #TYPE_STRING;
		at: 'bytes' put: #TYPE_BYTES;
		at: 'sfixed64' put: #TYPE_SFIXED64;
		at: 'sfixed32' put: #TYPE_SFIXED32;
		at: 'sint32' put: #TYPE_SINT32;
		at: 'sint64' put: #TYPE_SINT64;
		yourself

]

{ #category : #accessing }
PBProtobufFieldNode >> cardinality [
	^ cardinality
]

{ #category : #initialization }
PBProtobufFieldNode >> initWithKind: aKindEnum cardinality: aCardEnum number: aNumber name: aName [ 

	kind := aKindEnum.
	cardinality := aCardEnum.
	number := aNumber.
	name := aName.
]

{ #category : #testing }
PBProtobufFieldNode >> isFieldNode [
	^true
]

{ #category : #accessing }
PBProtobufFieldNode >> kind [

	^ kind
]

{ #category : #accessing }
PBProtobufFieldNode >> name [
	^ name
]

{ #category : #accessing }
PBProtobufFieldNode >> number [

	^ number
]

{ #category : #accessing }
PBProtobufFieldNode >> typeUrl [
	^ typeUrl
]
