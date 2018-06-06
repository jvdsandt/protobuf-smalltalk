Class {
	#name : #PBProtobufConstants,
	#superclass : #SharedPool,
	#classVars : [
		'WireType32bit',
		'WireType64bit',
		'WireTypeLengthDelimited',
		'WireTypeVarint'
	],
	#category : #'Protobuf-Core'
}

{ #category : #initialization }
PBProtobufConstants class >> initialize [
	"PBProtobufConstants initialize"

	WireTypeVarint := 0.
	WireType64bit := 1.
	WireTypeLengthDelimited := 2.
	WireType32bit := 5.
	
]
