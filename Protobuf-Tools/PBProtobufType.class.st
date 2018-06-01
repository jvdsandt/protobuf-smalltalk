"
Protocol Buffers message type.
"
Class {
	#name : #PBProtobufType,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'fields',
		'options'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufType class >> name: aName fields: aFieldsColl options: anOptionColl [

	^self new initWithName: aName 
		fields: aFieldsColl 
		options: anOptionColl
]

{ #category : #accessing }
PBProtobufType >> fields [
	^ fields
]

{ #category : #initialization }
PBProtobufType >> initWithName: aName fields: aFieldsColl options: anOptionColl [

	name := aName.
	fields := aFieldsColl.
	options := anOptionColl
]

{ #category : #accessing }
PBProtobufType >> name [
	^ name
]

{ #category : #accessing }
PBProtobufType >> options [
	^ options
]
