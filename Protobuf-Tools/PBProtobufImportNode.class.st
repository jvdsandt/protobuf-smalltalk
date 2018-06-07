Class {
	#name : #PBProtobufImportNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name',
		'isPublic',
		'isWeak'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufImportNode class >> name: aName public: publicFlag weak: weakFlag [

	^ self new initWithName: aName public: publicFlag weak: weakFlag
]

{ #category : #initialization }
PBProtobufImportNode >> initWithName: aName public: publicFlag weak: weakFlag [

	name := aName.
	isPublic := publicFlag.
	isWeak := weakFlag
]

{ #category : #testing }
PBProtobufImportNode >> isImportNode [
	^ true
]

{ #category : #testing }
PBProtobufImportNode >> isPublic [
	^ isPublic
]

{ #category : #testing }
PBProtobufImportNode >> isWeak [
	^ isWeak
]

{ #category : #accessing }
PBProtobufImportNode >> name [
	^ name
]
