Class {
	#name : #PBProtobufCommentNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'text'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufCommentNode class >> text: aString [

	^ self new initWithText: aString
]

{ #category : #initialization }
PBProtobufCommentNode >> initWithText: aString [

	text := aString
]

{ #category : #accessing }
PBProtobufCommentNode >> text [
	^ text
]
