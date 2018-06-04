"
Protocol Buffers message type.
"
Class {
	#name : #PBProtobufTypeNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #resources }
PBProtobufTypeNode class >> bool [

	^self name: 'bool'
]

{ #category : #resources }
PBProtobufTypeNode class >> bytes [

	^self name: 'bytes'
]

{ #category : #resources }
PBProtobufTypeNode class >> double [

	^self name: 'double'
]

{ #category : #resources }
PBProtobufTypeNode class >> fixed32 [

	^self name: 'fixed32'
]

{ #category : #resources }
PBProtobufTypeNode class >> fixed64 [

	^self name: 'fixed64'
]

{ #category : #resources }
PBProtobufTypeNode class >> float [

	^self name: 'float'
]

{ #category : #resources }
PBProtobufTypeNode class >> int32 [

	^self name: 'int32'
]

{ #category : #resources }
PBProtobufTypeNode class >> int64 [

	^self name: 'int64'
]

{ #category : #'instance creation' }
PBProtobufTypeNode class >> name: aName [

	^self new initWithName: aName
]

{ #category : #resources }
PBProtobufTypeNode class >> sint32 [

	^self name: 'sint32'
]

{ #category : #resources }
PBProtobufTypeNode class >> sint64 [

	^self name: 'sint64'
]

{ #category : #resources }
PBProtobufTypeNode class >> standardTypes [

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

{ #category : #resources }
PBProtobufTypeNode class >> string [

	^self name: 'string'
]

{ #category : #resources }
PBProtobufTypeNode class >> uint32 [

	^self name: 'uint32'
]

{ #category : #resources }
PBProtobufTypeNode class >> uint64 [

	^self name: 'uint64'
]

{ #category : #accessing }
PBProtobufTypeNode >> defaultParameterName [

	self isIntegerType
		ifTrue: [ ^ 'anInteger' ].
		
	self isString
		ifTrue: [ ^ 'aString' ].
		
	self isBooleanType
		ifTrue: [ ^ 'aBoolean' ].
		
	self isFloatType
		ifTrue: [ ^ 'aFloat' ].
		
	^'anObject'
]

{ #category : #initialization }
PBProtobufTypeNode >> initWithName: aName [

	name := aName
]

{ #category : #testing }
PBProtobufTypeNode >> isBooleanType [

	^ self name = 'bool'
]

{ #category : #testing }
PBProtobufTypeNode >> isFloatType [

	^ #( 'float' 'double' ) includes: self name
]

{ #category : #testing }
PBProtobufTypeNode >> isIntegerType [

	^ #( 'int32' 'int64' 'uint32' 'uint64' 'sint32' 'sint64' 'fixed32' 'fixed64' ) includes: self name
]

{ #category : #testing }
PBProtobufTypeNode >> isStringType [

	^ self name = 'string'
]

{ #category : #accessing }
PBProtobufTypeNode >> name [
	^ name
]

{ #category : #printing }
PBProtobufTypeNode >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $<;
		print: self name;
		nextPut: $>
]
