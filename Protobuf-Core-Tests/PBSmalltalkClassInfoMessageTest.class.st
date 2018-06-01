Class {
	#name : #PBSmalltalkClassInfoMessageTest,
	#superclass : #TestCase,
	#category : #'Protobuf-Core-Tests'
}

{ #category : #'as yet unclassified' }
PBSmalltalkClassInfoMessageTest >> messageBytes [
	"'C:\Stuff\pbdemo-java\ExportProtobufTest.pb' asFileReference binaryReadStream contents"
	
	^#[ 10 10 68 105 99 116 105 111 110 97 114 121 18 10 67 111 108 108 101 99 116 105 111 110 34 5 105 110 100 101 120 34 5 97 114 114 97 121 40 149 154 239 58 10 10 68 105 99 116 105 111 110 97 114 121 18 10 67 111 108 108 101 99 116 105 111 110 34 5 105 110 100 101 120 34 5 97 114 114 97 121 40 149 154 239 58 10 10 68 105 99 116 105 111 110 97 114 121 18 10 67 111 108 108 101 99 116 105 111 110 34 5 105 110 100 101 120 34 5 97 114 114 97 121 40 149 154 239 58 ]
]

{ #category : #tests }
PBSmalltalkClassInfoMessageTest >> testRead [  

	| input info1 |
	
	input := PBCodedReadStream on: self messageBytes readStream.
	
	info1 := PBSmalltalkClassInfoMessage readFrom: input.
	

]
