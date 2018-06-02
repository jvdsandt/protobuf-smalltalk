Class {
	#name : #PBSmalltalkClassInfoMessage,
	#superclass : #PBMessage,
	#instVars : [
		'name',
		'superclassName',
		'subclassNameList',
		'instVarNameList',
		'infoSize',
		'infoIndexList',
		'infoFinal'
	],
	#category : #'Protobuf-Core-Tests'
}

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> clear [
	
	name := nil.
	superclassName := nil.
	subclassNameList := OrderedCollection new.
	instVarNameList := OrderedCollection new.
	infoSize := 0.
	infoIndexList := OrderedCollection new. 
	infoFinal := false.

]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> infoIndexList [
	^ infoIndexList
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> infoIndexList: anObject [
	infoIndexList := anObject
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> infoSize [
	^ infoSize
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> infoSize: anObject [
	^ infoSize := anObject
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> instVarNameList [
	^ instVarNameList
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> instVarNameList: anObject [
	instVarNameList := anObject
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> name [
	^ name
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> name: anObject [
	^ name := anObject
]

{ #category : #'instance creation' }
PBSmalltalkClassInfoMessage >> readFrom: input [

	| done dict |
	
	dict := Dictionary new
		add: 10 -> [ name := input readString ];
		add: 18 -> [ superclassName := input readString ];
		add: 26 -> [ subclassNameList add: input readString ];
		add: 34 -> [ instVarNameList add: input readString ];
		add: 40 -> [ infoSize := input readUInt64 ];
		add: 72 -> [ infoIndexList add: input readInt32 ];
		add: 74 -> [ infoIndexList addAll: input readInt32List ];
		add: 80 -> [ infoFinal := input readBool ];
		yourself.
		
	self clear.
	done := false.
	[ done ] whileFalse: [ 
		| tag |
		tag := input readTag.
		(dict at: tag ifAbsent: [ self readUnknownField: tag from: input ]) value.
		done := input atEnd ]
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> subclassNameList [
	^ subclassNameList
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> subclassNameList: anObject [
	subclassNameList := anObject
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> superclassName [
	^ superclassName
]

{ #category : #accessing }
PBSmalltalkClassInfoMessage >> superclassName: anObject [
	^ superclassName := anObject
]

{ #category : #'instance creation' }
PBSmalltalkClassInfoMessage >> writeTo: output [

	output writeField: 1 string: name.
	output writeField: 2 string: superclassName.
	output writeField: 3 stringList: subclassNameList.
	output writeField: 4 stringList: instVarNameList.
	output writeField: 5 uint64: infoSize.
	output writeField: 9 int32List: infoIndexList.
	output writeField: 10 bool: infoFinal
]
