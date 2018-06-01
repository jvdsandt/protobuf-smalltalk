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

{ #category : #accessing }
PBProtobufEnum >> name [
	^ name
]

{ #category : #accessing }
PBProtobufEnum >> options [
	^ options
]

{ #category : #accessing }
PBProtobufEnum >> values [
	^ values
]

{ #category : #copying }
PBProtobufEnum >> withName: newName [

	^self class name: newName values: values options: options
]
