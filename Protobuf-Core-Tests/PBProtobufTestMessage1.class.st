Class {
	#name : #PBProtobufTestMessage1,
	#superclass : #PBMessage,
	#instVars : [
		'name',
		'hobbies',
		'favoriteNumbers'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #writing }
PBProtobufTestMessage1 >> writeTo: aCodedStream [

	aCodedStream
		writeStringField: 1 value: name;
		writeStringCollField: 2 value: hobbies;
		writeInt32CollField: 5 value: favoriteNumbers
]
