Class {
	#name : #PBProtobufOptionNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufOptionNode class >> name: aName value: aValue [

	^ self new initWithName: aName value: aValue
]

{ #category : #initialization }
PBProtobufOptionNode >> initWithName: aName value: aValue [

	name := aName.
	value := aValue
]

{ #category : #testing }
PBProtobufOptionNode >> isOptionNode [

	^true
]

{ #category : #accessing }
PBProtobufOptionNode >> name [
	^ name
]

{ #category : #accessing }
PBProtobufOptionNode >> value [
	^ value
]
