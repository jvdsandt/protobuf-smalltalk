Class {
	#name : #PBSmalltalkPackageMessage,
	#superclass : #PBMessage,
	#instVars : [
		'name',
		'classList'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #accessing }
PBSmalltalkPackageMessage >> classList [
	^ classList
]

{ #category : #accessing }
PBSmalltalkPackageMessage >> classList: anObject [
	classList := anObject
]

{ #category : #'instance creation' }
PBSmalltalkPackageMessage >> clear [

	name := nil.
	classList := OrderedCollection new.
]

{ #category : #accessing }
PBSmalltalkPackageMessage >> name [
	^ name
]

{ #category : #accessing }
PBSmalltalkPackageMessage >> name: anObject [
	name := anObject
]

{ #category : #'instance creation' }
PBSmalltalkPackageMessage >> readFrom: input [

	| done dict |
	
	dict := Dictionary new
		add: 10 -> [ name := input readString ];
		add: 18 -> [ classList add: (input readMessage: PBSmalltalkClassInfoMessage) ];
		yourself.
		
	self clear.
	done := false.
	[ done ] whileFalse: [ 
		| tag |
		tag := input readTag.
		(dict at: tag ifAbsent: [ self readUnknownField: tag from: input ]) value.
		done := input atEnd ]
]

{ #category : #writing }
PBSmalltalkPackageMessage >> writeTo: output [

	output writeField: 1 string: name.
	output writeField: 2 messageList: classList

]
