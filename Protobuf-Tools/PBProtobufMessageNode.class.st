Class {
	#name : #PBProtobufMessageNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'fields',
		'options'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufMessageNode class >> name: aName fields: aFieldColl options: anOptionColl [

	^self new initWithName: aName fields: aFieldColl options: anOptionColl
]

{ #category : #accessing }
PBProtobufMessageNode >> fields [
	^ fields
]

{ #category : #initialization }
PBProtobufMessageNode >> initWithName: aName fields: aFieldColl options: anOptionColl [

	name := aName.
	fields := aFieldColl asArray.
	options := anOptionColl asArray
]

{ #category : #accessing }
PBProtobufMessageNode >> name [
	^ name
]

{ #category : #accessing }
PBProtobufMessageNode >> options [
	^ options
]

{ #category : #printing }
PBProtobufMessageNode >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $<;
		print: self name;
		nextPut: $>
]

{ #category : #copying }
PBProtobufMessageNode >> withName: newName [

	^self class name: newName fields: fields options: options
]
