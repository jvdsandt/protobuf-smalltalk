Class {
	#name : #PBSmalltalkNodeWrapper,
	#superclass : #Object,
	#instVars : [
		'node'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #'instance creation' }
PBSmalltalkNodeWrapper class >> on: aMessageNode [

	^self new on: aMessageNode
]

{ #category : #accessing }
PBSmalltalkNodeWrapper >> node [
	^ node
]

{ #category : #initialization }
PBSmalltalkNodeWrapper >> on: aNode [

	node := aNode
]
