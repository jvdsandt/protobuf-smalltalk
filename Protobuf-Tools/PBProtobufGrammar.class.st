Class {
	#name : #PBProtobufGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'boolLiteral',
		'charEscape',
		'charValue',
		'comment',
		'constant',
		'decimalLiteral',
		'digits',
		'emptyStatement',
		'enum',
		'enumBody',
		'enumField',
		'enumName',
		'enumType',
		'enumValueOption',
		'exponent',
		'field',
		'fieldName',
		'fieldNames',
		'fieldNumber',
		'fieldOption',
		'fieldOptions',
		'floatLiteral',
		'fullIdent',
		'hexDigit',
		'hexDigits',
		'hexEscape',
		'hexLiteral',
		'ident',
		'import',
		'intLiteral',
		'keyType',
		'mapField',
		'mapName',
		'message',
		'messageBody',
		'messageName',
		'messageType',
		'nonZeroDigit',
		'octalDigit',
		'octalDigits',
		'octalLiteral',
		'octEscape',
		'oneof',
		'oneofField',
		'oneofName',
		'option',
		'optionName',
		'package',
		'proto',
		'quote',
		'range',
		'ranges',
		'reserved',
		'rpc',
		'rpcName',
		'service',
		'serviceName',
		'strLiteral',
		'syntax',
		'topLevelDef',
		'type',
		'whiteSpace',
		'enumFieldOptions'
	],
	#category : #'Protobuf-Tools-Parser'
}

{ #category : #'grammar-literals' }
PBProtobufGrammar >> boolLiteral [

	^ 'true' asPParser / 'false' asPParser
]

{ #category : #primitives }
PBProtobufGrammar >> charEscape [

	^ $\ asPParser , (PP2PredicateObjectNode anyOf: 'abfnrtv\''"')
]

{ #category : #primitives }
PBProtobufGrammar >> charValue [

	^ hexEscape / octEscape / charEscape / ((PP2PredicateObjectNode anyOf: '''"\') not , #any asPParser)
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> comment [

	^ (('/*' asPParser, ('*/' asPParser not, #any asPParser) star, '*/' asPParser) trim / 
			('//' asPParser, (#newline asPParser not, #any asPParser) star) trim) flatten
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> constant [

	^ boolLiteral /
		fullIdent / 
		((PP2PredicateObjectNode anyOf: '-+') optional, intLiteral) /
		((PP2PredicateObjectNode anyOf: '-+') optional, floatLiteral) /
		strLiteral
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> decimalLiteral [

	^ (nonZeroDigit, digits optional) flatten
]

{ #category : #primitives }
PBProtobufGrammar >> digits [ 
	"digit is already defined, no need to redefine it"

	^#digit asPParser plus
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> emptyStatement [

	^ $; asPParser
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> enum [

	^'enum' asPParser, whiteSpace plus, enumName, enumBody
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumBody [

	^${ asPParser trim, (comment / option / enumField / emptyStatement) star, $} asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumField [

	^ ident, $= asPParser trim, intLiteral, enumFieldOptions optional, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumFieldOptions [

	^ $[ asPParser trim, (enumValueOption, ($, asPParser trim, enumValueOption) star), $] asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumName [

	^ ident
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumType [

	^ '.' asPParser optional, (ident, '.' asPParser) star, enumName
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> enumValueOption [

	^ optionName, $= asPParser trim, constant
]

{ #category : #primitives }
PBProtobufGrammar >> exponent [

	^ (PP2PredicateObjectNode anyOf: 'eE'), (PP2PredicateObjectNode anyOf: '+-') optional, digits
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> field [

	^ ('repeated' asPParser, whiteSpace plus) optional, type, whiteSpace plus, fieldName, $= asPParser trim, fieldNumber, ( $[ asPParser trim, fieldOptions, $] asPParser trim) optional, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> fieldName [

	^ ident
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> fieldNames [

	^ fieldName, ($, asPParser trim, fieldName) star
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> fieldNumber [

	^ intLiteral
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> fieldOption [

	^ optionName, $= asPParser trim, constant
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> fieldOptions [

	^ fieldOption, ($, asPParser trim, fieldOption) star
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> floatLiteral [

	^ ((digits, '.' asPParser, digits optional, exponent optional) /
			(digits, exponent) /
			('.' asPParser, digits, exponent optional)) flatten
]

{ #category : #primitives }
PBProtobufGrammar >> fullIdent [

	^ (ident, ('.' asPParser, ident) star) flatten
]

{ #category : #primitives }
PBProtobufGrammar >> hexDigit [ 

	^#hex asPParser
]

{ #category : #primitives }
PBProtobufGrammar >> hexDigits [ 

	^hexDigit plus
]

{ #category : #primitives }
PBProtobufGrammar >> hexEscape [

	^ $\ asPParser , (PP2PredicateObjectNode anyOf: 'xX'), hexDigit, hexDigit
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> hexLiteral [

 	^ ($0 asPParser, (PP2PredicateObjectNode anyOf: 'xX' ), hexDigits) flatten
]

{ #category : #primitives }
PBProtobufGrammar >> ident [

	| word letter |
	letter := (PP2PredicateObjectNode
				on: [ :each | each isLetter ]
				message: 'letter expected').
				
	word := (PP2PredicateObjectNode
				on: [ :each | each isAlphaNumeric or: [ each = $_ ] ]
				message: 'letter, digit or underscore expected').
				
	^ (letter, word star) flatten
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> import [

	^ 'import' asPParser, whiteSpace plus, (('weak' asPParser / 'public' asPParser), whiteSpace plus) optional, strLiteral, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> intLiteral [

	^(decimalLiteral / octalLiteral / hexLiteral)
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> keyType [

	^ 'int32' asPParser /
		'int64' asPParser /
		'uint32' asPParser /
		'uint64' asPParser /
		'sint32' asPParser /
		'sint64' asPParser /
		'fixed32' asPParser /
		'fixed64' asPParser /
		'sfixed32' asPParser /
		'sfixed64' asPParser /
		'bool' asPParser /
		'string' asPParser
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> mapField [

	^'map' asPParser, $< asPParser, keyType, $, asPParser trim, type, $> asPParser, whiteSpace star, mapName, $= asPParser trim, fieldNumber, ( $[ asPParser trim, fieldOptions, $] asPParser trim) optional, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> mapName [

	^ ident
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> message [

	^'message' asPParser, whiteSpace plus, messageName, messageBody
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> messageBody [

	^${ asPParser trim, (comment / field / enum / message / option / oneof / mapField / reserved / emptyStatement) star, $} asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> messageName [

	^ ident
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> messageType [

	^ ('.' asPParser optional, (ident, '.' asPParser) star, messageName) flatten
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> nonZeroDigit [ 

	^ PP2PredicateObjectNode anyOf: '123456789'
]

{ #category : #primitives }
PBProtobufGrammar >> octEscape [

	^ $\ asPParser, octalDigit, octalDigit, octalDigit
]

{ #category : #primitives }
PBProtobufGrammar >> octalDigit [ 

	^PP2PredicateObjectNode anyOf: '01234567'
]

{ #category : #primitives }
PBProtobufGrammar >> octalDigits [

	^ octalDigit plus
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> octalLiteral [

	^ (($0 asPParser), octalDigit star) flatten
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> oneof [

	^ 'oneof' asPParser, whiteSpace plus, oneofName, ${ asPParser trim, (oneofField / emptyStatement) star, $} asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> oneofField [

	^type, whiteSpace plus, fieldName, $= asPParser trim, fieldNumber, ( $[ asPParser trim, fieldOptions, $] asPParser trim) optional, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> oneofName [

	^ ident
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> option [

	^ 'option' asPParser, whiteSpace plus, optionName, $= asPParser trim, constant, $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> optionName [

	^ ((ident / ($( asPParser, fullIdent, $) asPParser)), ( $. asPParser, ident) star) flatten
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> package [

	^ 'package' asPParser, whiteSpace plus, fullIdent, $; asPParser trim
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> proto [

	^ comment star, syntax, (comment / import / package / option / message / enum / service / emptyStatement) star
]

{ #category : #primitives }
PBProtobufGrammar >> quote [

	^ PP2PredicateObjectNode anyOf: '''"'
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> range [

	^ intLiteral, ('to' asPParser trim, (intLiteral / 'max' asPParser)) optional
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> ranges [

	^range, ($, asPParser trim, range) star
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> reserved [

	^ 'reserved' asPParser, whiteSpace plus, (ranges / fieldNames), $; asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> rpc [

	^ 'rpc' asPParser, 
			whiteSpace plus, rpcName, 
			$( asPParser trim, 'stream' asPParser optional, messageType, $) asPParser trim, 
			'returns' asPParser, $( asPParser trim, 'stream' asPParser optional, messageType, $) asPParser trim,
			(( ${ asPParser trim, (option / emptyStatement) star, $} asPParser trim) / $; asPParser trim)
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> rpcName [

	^ ident
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> service [

	^ 'service' asPParser, whiteSpace plus, serviceName, ${ asPParser trim, (option / rpc / emptyStatement) star, $} asPParser trim
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> serviceName [

	^ ident
]

{ #category : #accessing }
PBProtobufGrammar >> start [
	"Default start production."

	^ proto
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> strLiteral [

	^ ($' asPParser, charValue star flatten, $' asPParser) /
		($" asPParser, charValue star flatten, $" asPParser)
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> syntax [

	^ 'syntax' asPParser, $= asPParser trim, quote, 'proto3' asPParser, quote, $; asPParser trim
]

{ #category : #'grammar-toplevel' }
PBProtobufGrammar >> topLevelDef [

	^message / enum / service
]

{ #category : #'grammar-literals' }
PBProtobufGrammar >> type [

	^ 'double' asPParser /
		'float' asPParser /
		'int32' asPParser /
		'int64' asPParser /
		'uint32' asPParser /
		'uint64' asPParser /
		'sint32' asPParser /
		'sint64' asPParser /
		'fixed32' asPParser /
		'fixed64' asPParser /
		'sfixed32' asPParser /
		'sfixed64' asPParser /
		'bool' asPParser /
		'string' asPParser /
		'bytes' asPParser /
		messageType /
		enumType
]

{ #category : #primitives }
PBProtobufGrammar >> whiteSpace [

	^#space asPParser
]
