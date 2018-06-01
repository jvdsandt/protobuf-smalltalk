"
Protocol Buffers EnumValue definition.
"
Class {
	#name : #PBProtobufEnumValue,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'number',
		'options'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufEnumValue class >> name: aName number: anInteger [

	^self name: aName number: anInteger options: #()
]

{ #category : #'instance creation' }
PBProtobufEnumValue class >> name: aName number: anInteger options: anOptionColl [

	^self new initWithName: aName number: anInteger options: anOptionColl
]

{ #category : #initialization }
PBProtobufEnumValue >> initWithName: aName number: anInteger options: anOptionColl [

	name := aName.
	number := anInteger.
	options := anOptionColl
]

{ #category : #testing }
PBProtobufEnumValue >> isEnumValueNode [

	^true
]

{ #category : #accessing }
PBProtobufEnumValue >> name [
	^ name
]

{ #category : #accessing }
PBProtobufEnumValue >> number [
	^ number
]

{ #category : #accessing }
PBProtobufEnumValue >> options [
	^ options
]
