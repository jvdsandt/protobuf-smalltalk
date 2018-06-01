Class {
	#name : #PBSmalltalkClassInfoMessage,
	#superclass : #PBMessage,
	#instVars : [
		'name',
		'superclassName',
		'subclassNameList',
		'instVarNameList',
		'size'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> clear [
	
	name := nil.
	superclassName := nil.
	subclassNameList := OrderedCollection new.
	instVarNameList := OrderedCollection new.
	size := 0.

]

{ #category : #'instance creation' }
PBSmalltalkClassInfoMessage >> readFrom: input [

	| done dict |
	
	dict := Dictionary new
		add: 10 -> [ name := input readString ];
		add: 18 -> [ superclassName := input readString ];
		add: 26 -> [ subclassNameList add: input readString ];
		add: 34 -> [ instVarNameList add: input readString ];
		add: 40 -> [ size := input readUInt64 ];
		yourself.
		
	self clear.
	done := false.
	[ done ] whileFalse: [ 
		| tag |
		tag := input readTag.
		(dict at: tag ifAbsent: [ self readUnknownField: tag from: input ]) value.
		done := input atEnd ]
]
