Class {
	#name : #PBProtobufGrammarTest,
	#superclass : #PP2CompositeNodeTest,
	#category : #'Protobuf-Tools-Tests'
}

{ #category : #accessing }
PBProtobufGrammarTest >> parserClass [
	^ PBProtobufGrammar
]

{ #category : #tests }
PBProtobufGrammarTest >> testBoolLiteral1 [
	self 
		parse: 'true'
		rule: #boolLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testBoolLiteral2 [
	self 
		parse: 'false'
		rule: #boolLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testComment1 [
	self 
		parse: '// Hello world'
		rule: #comment.
	self 
		parse: '//Hello world '
		rule: #comment.
	self 
		parse: '
// Hello world '
		rule: #comment		
]

{ #category : #tests }
PBProtobufGrammarTest >> testComment2 [

	self 
		parse: '/* Hello world */'
		rule: #comment.

	self 
		parse: '/* 
 * Hello world 
 */'
		rule: #comment.

	self 
		parse: '/* comment1 */

'
		rule: #comment.

]

{ #category : #tests }
PBProtobufGrammarTest >> testConstant1 [
	self 
		parse: '-123'
		rule: #constant.

]

{ #category : #tests }
PBProtobufGrammarTest >> testConstant2 [
	self 
		parse: '123'
		rule: #constant.

]

{ #category : #tests }
PBProtobufGrammarTest >> testConstant3 [
	self 
		parse: '"pop"'
		rule: #constant.

]

{ #category : #tests }
PBProtobufGrammarTest >> testConstant4 [
	self 
		parse: 'foo.bar'
		rule: #constant.

]

{ #category : #tests }
PBProtobufGrammarTest >> testDecimalLiteral1 [
	self 
		parse: '12345'
		rule: #decimalLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testEnum1 [
	self 
		parse: 'enum EnumAllowingAlias {
	option allow_alias = true;
	UNKNOWN = 0;
	STARTED = 1;
	RUNNING = 2 [(custom_option) = "hello world"];
}'
		rule: #enum
]

{ #category : #tests }
PBProtobufGrammarTest >> testEnumBody1 [
	self 
		parse: '{XYZ = 1;AB=99;}'
		rule: #enumBody.

]

{ #category : #tests }
PBProtobufGrammarTest >> testEnumBody2 [
	self 
		parse: '{	option allow_alias = true; 		
					XYZ = 321;
					AB = 99;
					}'
		rule: #enumBody.

]

{ #category : #tests }
PBProtobufGrammarTest >> testEnumField1 [
	self 
		parse: 'STARTED = 1;'
		rule: #enumField.

]

{ #category : #tests }
PBProtobufGrammarTest >> testEnumField2 [
	self 
		parse: 'RUNNING = 2 [deprecated=true,other_option=123, third="last"];'
		rule: #enumField
]

{ #category : #tests }
PBProtobufGrammarTest >> testEnumField3 [
	self 
		parse: 'RUNNING = 2 [(custom_option) = "hello world"];'
		rule: #enumField
]

{ #category : #tests }
PBProtobufGrammarTest >> testField1 [
	self 
		parse: 'foo.bar nested_message = 12;'
		rule: #field
]

{ #category : #tests }
PBProtobufGrammarTest >> testField2 [
	self 
		parse: 'repeated int32 samples = 4 [packed=true];'
		rule: #field.
	self 
		parse: 'repeated int32 samples=4 [ packed = true ] ; '
		rule: #field.
	self 
		parse: 'repeated int32 samples=4[packed=true];'
		rule: #field		
]

{ #category : #tests }
PBProtobufGrammarTest >> testFieldName1 [
	self 
		parse: 'nested_message'
		rule: #fieldName
]

{ #category : #tests }
PBProtobufGrammarTest >> testFloatLiteral1 [
	self 
		parse: '123.45'
		rule: #floatLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testFloatLiteral2 [
	self 
		parse: '123.45e-3'
		rule: #floatLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testFullIdent [
	self 
		parse: 'foo.bar'
		rule: #fullIdent.

]

{ #category : #tests }
PBProtobufGrammarTest >> testHexLiteral1 [
	self 
		parse: '0xffff'
		rule: #hexLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testHexLiteral2 [
	self 
		parse: '0XFFAA'
		rule: #hexLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testImport1 [
	self 
		parse: 'import public "other.proto";'
		rule: #import.
]

{ #category : #tests }
PBProtobufGrammarTest >> testIntLiteral0 [
	self 
		parse: '0'
		rule: #intLiteral
]

{ #category : #tests }
PBProtobufGrammarTest >> testIntLiteral1 [
	self 
		parse: '1'
		rule: #intLiteral
]

{ #category : #tests }
PBProtobufGrammarTest >> testMapField1 [
	self 
		parse: 'map<string, Project> projects = 2;'
		rule: #mapField
]

{ #category : #tests }
PBProtobufGrammarTest >> testMessage1 [
	self 
		parse: 'message Msg { int32 my_num = 1; }'
		rule: #message.

]

{ #category : #tests }
PBProtobufGrammarTest >> testMessage2 [
	self 
		parse: 'message Outer {
	option (my_option).a = true;
	message Inner {
		int64 ival = 1;
	}
	map<int32, string> my_map = 2;
}'
		rule: #message.

]

{ #category : #tests }
PBProtobufGrammarTest >> testMessage3 [
	self 
		parse: 'message outer {
  option (my_option).a = true;
  message inner {
    int64 ival = 1;
  }
  repeated inner inner_message = 2;
  EnumAllowingAlias enum_field =3;
  map<int32, string> my_map = 4;
}'
		rule: #message.

]

{ #category : #tests }
PBProtobufGrammarTest >> testMessage4 [
	self 
		parse: 'message SearchRequest {
  string query = 1;
  int32 page_number = 2;  // Which page number do we want?
  int32 result_per_page = 3;  // Number of results to return per page.
}'
		rule: #message.
]

{ #category : #tests }
PBProtobufGrammarTest >> testMessageType1 [
	self 
		parse: 'foo.bar'
		rule: #messageType
]

{ #category : #tests }
PBProtobufGrammarTest >> testOctalLiteral1 [
	self 
		parse: '0777'
		rule: #octalLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testOneof1 [
	self 
		parse: 'oneof foo {
	string name = 4;
	SubMessage sub_message = 9;
}'
		rule: #oneof
]

{ #category : #tests }
PBProtobufGrammarTest >> testOneof2 [
	self 
		parse: 'oneof foo {}'
		rule: #oneof.
	self 
		parse: 'oneof foo {;}'
		rule: #oneof.
	self 
		parse: 'oneof foo {;;}'
		rule: #oneof
]

{ #category : #tests }
PBProtobufGrammarTest >> testOneofField1 [
	self 
		parse: 'foo.bar nested_message = 12;'
		rule: #oneofField
]

{ #category : #tests }
PBProtobufGrammarTest >> testOption1 [
	self 
		parse: 'option java_package = "com.example.foo";'
		rule: #option.
	self 
		parse: 'option java_package = "com.example.foo" ;		
				'
		rule: #option.
	self 
		parse: 'option java_package = "com.example.foo";'
		rule: #option		
	
]

{ #category : #tests }
PBProtobufGrammarTest >> testOption2 [
	self 
		parse: 'option xyz = 123;'
		rule: #option.
]

{ #category : #tests }
PBProtobufGrammarTest >> testOption3 [
	self 
		parse: 'option optimize_for = CODE_SIZE;'
		rule: #option.
]

{ #category : #tests }
PBProtobufGrammarTest >> testOption4 [
	self 
		parse: 'option (google.api.http) = {
      put: "/v1/{name=projects/*/subscriptions/*}"
      body: "*" };
  }'
		rule: #option.
]

{ #category : #tests }
PBProtobufGrammarTest >> testProto1 [
	self 
		parse: 'syntax = "proto3";'
		rule: #proto.
]

{ #category : #tests }
PBProtobufGrammarTest >> testProto2 [
	self 
		parse: 'syntax = "proto3";
import public "other.proto";
option java_package = "com.example.foo";
enum EnumAllowingAlias {
  option allow_alias = true;
  UNKNOWN = 0;
  STARTED = 1;
  RUNNING = 2 [(custom_option) = "hello world"];
}
message outer {
  option (my_option).a = true;
  message inner { 
    int64 ival = 1;
  }
  repeated inner inner_message = 2;
  EnumAllowingAlias enum_field =3;
  map<int32, string> my_map = 4;
}'
		rule: #proto.
]

{ #category : #tests }
PBProtobufGrammarTest >> testProto3 [
	self 
		parse: 'syntax = "proto3";

/* SearchRequest represents a search query, with pagination options to
 * indicate which results to include in the response. */

message SearchRequest {
  string query = 1;
  int32 page_number = 2;  // Which page number do we want?
  int32 result_per_page = 3;  // Number of results to return per page.
}'
		rule: #proto.
]

{ #category : #tests }
PBProtobufGrammarTest >> testRange1 [
	self 
		parse: '1'
		rule: #range.
	self 
		parse: '1 to 99'
		rule: #range.
	self 
		parse: '100 to max'
		rule: #range
		
]

{ #category : #tests }
PBProtobufGrammarTest >> testReserved1 [
	self 
		parse: 'reserved 2, 15, 9 to 11;'
		rule: #reserved
]

{ #category : #tests }
PBProtobufGrammarTest >> testRpc1 [
	self 
		parse: 'rpc Search (SearchRequest) returns (SearchResponse);'
		rule: #rpc
]

{ #category : #tests }
PBProtobufGrammarTest >> testService1 [
	self 
		parse: 'service SearchService {
	rpc Search (SearchRequest) returns (SearchResponse);
}'
		rule: #service
]

{ #category : #tests }
PBProtobufGrammarTest >> testService2 [
	self 
		parse: 'service Subscriber {
  rpc CreateSubscription(Subscription) returns (Subscription) {
    option (google.api.http) = {
      put: "/v1/{name=projects/*/subscriptions/*}"
      body: "*" };
  }
  rpc GetSubscription(GetSubscriptionRequest) returns (Subscription) {
    option (google.api.http) = {
      get: "/v1/{subscription=projects/*/subscriptions/*}"
    };
  }
}'
		rule: #service
]

{ #category : #tests }
PBProtobufGrammarTest >> testStrLiteral1 [
	self 
		parse: '"pipo"'
		rule: #strLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testStrLiteral2 [
	self 
		parse: '''pipo'''
		rule: #strLiteral.

]

{ #category : #tests }
PBProtobufGrammarTest >> testSyntax [
	self 
		parse: 'syntax = "proto3";'
		rule: #syntax.
]

{ #category : #tests }
PBProtobufGrammarTest >> testType1 [
	self 
		parse: 'int64'
		rule: #type
]

{ #category : #tests }
PBProtobufGrammarTest >> testType2 [
	self 
		parse: 'foo.bar'
		rule: #type
]
