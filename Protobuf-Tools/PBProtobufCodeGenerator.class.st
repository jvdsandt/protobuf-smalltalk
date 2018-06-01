Class {
	#name : #PBProtobufCodeGenerator,
	#superclass : #Object,
	#instVars : [
		'messageTypes',
		'enumTypes'
	],
	#category : #'Protobuf-Tools-Generator'
}

{ #category : #'as yet unclassified' }
PBProtobufCodeGenerator >> refactoringsForMessage: aMessageType [

	| classRefactoring |

	classRefactoring := RBAddClassRefactoring addClass: aMessageType className
		superclass: aMessageType superclass
		subclasses: #()
		category: aMessageType packageName.
]
