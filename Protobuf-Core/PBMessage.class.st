Class {
	#name : #PBMessage,
	#superclass : #PBType,
	#category : #'Protobuf-Core'
}

{ #category : #testing }
PBMessage >> isMessage [
	^ true
]

{ #category : #'input-output' }
PBMessage >> readUnknownField: aTag from: anInput [

	anInput skipField: aTag
]
