Class {
	#name : #PBProtobufEnum,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'values',
		'options'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufEnum class >> name: aName values: anEnumValueColl options: anOptionColl [

	^self new initWithName: aName values: anEnumValueColl options: anOptionColl
]

{ #category : #initialization }
PBProtobufEnum >> initWithName: aName values: anEnumValueColl options: anOptionColl [

	name := aName.
	values := anEnumValueColl asArray.
	options := anOptionColl asArray
]

{ #category : #testing }
PBProtobufEnum >> isEnumNode [
	^ true
]

{ #category : #accessing }
PBProtobufEnum >> name [
	^ name
]

{ #category : #accessing }
PBProtobufEnum >> options [
	^ options
]

{ #category : #printing }
PBProtobufEnum >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $<;
		print: self name;
		nextPut: $>
]

{ #category : #accessing }
PBProtobufEnum >> values [
	^ values
]

{ #category : #copying }
PBProtobufEnum >> withName: newName [

	^self class name: newName values: values options: options
]
