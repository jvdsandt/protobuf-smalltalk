"
Protocol Buffers message type.
"
Class {
	#name : #PBProtobufTypeNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'fields',
		'options'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufTypeNode class >> name: aName [

	^self new initWithName: aName
]

{ #category : #initialization }
PBProtobufTypeNode >> initWithName: aName [

	name := aName
]

{ #category : #accessing }
PBProtobufTypeNode >> name [
	^ name
]
