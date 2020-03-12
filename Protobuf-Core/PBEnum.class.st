Class {
	#name : #PBEnum,
	#superclass : #PBType,
	#instVars : [
		'value'
	],
	#category : #'Protobuf-Core'
}

{ #category : #testing }
PBEnum >> isEnum [ ^true
]

{ #category : #'input-output' }
PBEnum >> readFrom: aCodedReadStream [
value :=aCodedReadStream	coder readVarint32: aCodedReadStream
]

{ #category : #accessing }
PBEnum >> value [ 
 ^value	
]

{ #category : #accessing }
PBEnum >> value:aVal [
value:= aVal
]

{ #category : #'input-output' }
PBEnum >> writeTo: pbWriteStream [
pbWriteStream writeEnum:value

	
]
