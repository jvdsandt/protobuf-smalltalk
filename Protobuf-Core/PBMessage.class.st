Class {
	#name : #PBMessage,
	#superclass : #Object,
	#category : #'Protobuf-Core'
}

{ #category : #'instance creation' }
PBMessage class >> readFrom: aCodedReadStream [

	^self new readFrom: aCodedReadStream
]
