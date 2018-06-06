Class {
	#name : #PBProtobufGoogleApiImporter,
	#superclass : #Object,
	#instVars : [
		'basePath'
	],
	#category : #'Protobuf-Tools-Tests'
}

{ #category : #tests }
PBProtobufGoogleApiImporter class >> test [

	| instance |
	
	instance := self new
		basePath: './protobuf' asFileReference;
		yourself.
		
	instance parse: 'google/pubsub/v1/pubsub.proto'
]

{ #category : #accessing }
PBProtobufGoogleApiImporter >> basePath [
	^ basePath
]

{ #category : #accessing }
PBProtobufGoogleApiImporter >> basePath: anObject [
	basePath := anObject
]

{ #category : #accessing }
PBProtobufGoogleApiImporter >> import: aPathname [

	^ (self basePath / aPathname) readStream contents
]

{ #category : #accessing }
PBProtobufGoogleApiImporter >> parse: aPathname [

	^ (self basePath / aPathname) readStreamDo: [ :stream |
		self parserClass new parse: stream contents ]
]

{ #category : #accessing }
PBProtobufGoogleApiImporter >> parserClass [
	^ PBProtobufParser
]
