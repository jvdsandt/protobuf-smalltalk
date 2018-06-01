Class {
	#name : #PBProtobufPackageNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'name'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufPackageNode class >> name: aString [

	^self new initWithName: aString
]

{ #category : #'as yet unclassified' }
PBProtobufPackageNode >> initWithName: aString [

	name := aString
]

{ #category : #accessing }
PBProtobufPackageNode >> name [
	^ name
]