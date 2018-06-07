Class {
	#name : #PBProtobufFileNode,
	#superclass : #PBProtobufNode,
	#instVars : [
		'options',
		'package',
		'imports',
		'messages',
		'enums',
		'services'
	],
	#category : #'Protobuf-Tools-Model'
}

{ #category : #'instance creation' }
PBProtobufFileNode class >> fromNodes: aParseNodes [

	^self new initFromNodes: aParseNodes
]

{ #category : #accessing }
PBProtobufFileNode >> enums [
	^ enums
]

{ #category : #accessing }
PBProtobufFileNode >> imports [
	^ imports
]

{ #category : #initialization }
PBProtobufFileNode >> initFromNodes: aParseNodes [

	package := aParseNodes detect: [ :each | each isPackageNode ] ifNone: [ nil ].
	imports := aParseNodes select: [ :each | each isImportNode ].
	options := aParseNodes select: [ :each | each isOptionNode ].
	messages := aParseNodes select: [ :each | each isMessageNode ].
]

{ #category : #accessing }
PBProtobufFileNode >> messages [
	^ messages
]

{ #category : #accessing }
PBProtobufFileNode >> options [
	^ options
]

{ #category : #accessing }
PBProtobufFileNode >> package [
	^ package
]

{ #category : #accessing }
PBProtobufFileNode >> services [
	^ services
]
