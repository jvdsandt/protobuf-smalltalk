Class {
	#name : #PBSmalltalkClassInfoMessageTest,
	#superclass : #TestCase,
	#category : #'Protobuf-Core-Tests'
}

{ #category : #'as yet unclassified' }
PBSmalltalkClassInfoMessageTest >> messageBytes [
	"'C:\Stuff\pbdemo-java\ExportProtobufTest.pb' asFileReference binaryReadStream contents"
	
	^#[ 10 10 68 105 99 116 105 111 110 97 114 121 18 10 67 111 108 108 101 99 116 105 111 110 34 5 105 110 100 101 120 34 5 97 114 114 97 121 40 149 154 239 58 74 14 100 162 254 255 255 255 255 255 255 255 1 159 141 6 80 1 ]
]

{ #category : #'as yet unclassified' }
PBSmalltalkClassInfoMessageTest >> packageMessageBytes [
	"'C:\Stuff\pbdemo-java\ExportProtobufPackage.pb' asFileReference binaryReadStream contents"
	
	^#[ 10 18 77 121 83 109 97 108 108 116 97 108 107 80 97 99 107 97 103 101 18 38 10 10 68 105 99 116 105 111 110 97 114 121 18 10 67 111 108 108 101 99 116 105 111 110 34 5 105 110 100 101 120 34 5 97 114 114 97 121 18 61 10 17 79 114 100 101 114 101 100 67 111 108 108 101 99 116 105 111 110 18 10 67 111 108 108 101 99 116 105 111 110 34 5 97 114 114 97 121 34 10 102 105 114 115 116 73 110 100 101 120 34 9 108 97 115 116 73 110 100 101 120 ]
]

{ #category : #tests }
PBSmalltalkClassInfoMessageTest >> testRead [  

	| input info1 |
	
	input := PBCodedReadStream on: self messageBytes readStream.
	
	info1 := PBSmalltalkClassInfoMessage readFrom: input.
	
	self assert: info1 name equals: 'Dictionary'.
	self assert: info1 instVarNameList asArray equals: #( 'index' 'array' ).
	self assert: info1 infoSize equals: 123456789.
	self assert: info1 infoIndexList asArray equals: #( 100 -222 99999 ).
	

]

{ #category : #tests }
PBSmalltalkClassInfoMessageTest >> testReadPackage [

	| input p1 |
	
	input := PBCodedReadStream on: self packageMessageBytes readStream.
	
	p1 := PBSmalltalkPackageMessage readFrom: input.
	
	self assert: p1 name equals: 'MySmalltalkPackage'.
	self assert: p1 classList size equals: 2.
	self assert: p1 classList first name equals: 'Dictionary'.
	self assert: p1 classList last name equals: 'OrderedCollection'.

]

{ #category : #tests }
PBSmalltalkClassInfoMessageTest >> testWritePackage [

	| input p1 bytes |
	
	input := PBCodedReadStream on: self packageMessageBytes readStream.
	
	p1 := PBSmalltalkPackageMessage readFrom: input.
	
	bytes := p1 asBytes.
	
	self assert: bytes equals: self packageMessageBytes.
]
