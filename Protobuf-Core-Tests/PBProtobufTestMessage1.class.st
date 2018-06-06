Class {
	#name : #PBProtobufTestMessage1,
	#superclass : #PBMessage,
	#instVars : [
		'fieldOne',
		'fieldTwo'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #writing }
PBProtobufTestMessage1 >> clear [

	fieldOne := ''.
	fieldTwo := 0
]

{ #category : #accessing }
PBProtobufTestMessage1 >> fieldOne [
	^ fieldOne
]

{ #category : #accessing }
PBProtobufTestMessage1 >> fieldOne: anObject [
	fieldOne := anObject
]

{ #category : #accessing }
PBProtobufTestMessage1 >> fieldTwo [
	^ fieldTwo
]

{ #category : #accessing }
PBProtobufTestMessage1 >> fieldTwo: anObject [
	fieldTwo := anObject
]

{ #category : #'input-output' }
PBProtobufTestMessage1 >> readFrom: input [

	| done dict |
	
	dict := Dictionary new
		add: 10 -> [ fieldOne := input readString ];
		add: 16 -> [ fieldTwo := input readInt32 ];
		yourself.
		
	self clear.
	done := false.
	[ done ] whileFalse: [ 
		| tag |
		tag := input readTag.
		(dict at: tag ifAbsent: [ self readUnknownField: tag from: input ]) value.
		done := input atEnd ]
]

{ #category : #'input-output' }
PBProtobufTestMessage1 >> writeTo: outputStream [

	outputStream
		writeField: 1 string: fieldOne;
		writeField: 2 int32: fieldTwo
]
