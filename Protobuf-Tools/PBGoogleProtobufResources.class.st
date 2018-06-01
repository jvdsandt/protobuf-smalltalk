Class {
	#name : #PBGoogleProtobufResources,
	#superclass : #Object,
	#category : #'Protobuf-Tools'
}

{ #category : #resources }
PBGoogleProtobufResources class >> any_proto [

	^'syntax = "proto3";

package google.protobuf;

option csharp_namespace = "Google.Protobuf.WellKnownTypes";
option go_package = "github.com/golang/protobuf/ptypes/any";
option java_package = "com.google.protobuf";
option java_outer_classname = "AnyProto";
option java_multiple_files = true;
option objc_class_prefix = "GPB";

// ''Any'' contains an arbitrary serialized protocol buffer message along with a
// URL that describes the type of the serialized message.
//
// Protobuf library provides support to pack/unpack Any values in the form
// of utility functions or additional generated methods of the Any type.
//
// Example 1: Pack and unpack a message in C++.
//
//     Foo foo = ...;
//     Any any;
//     any.PackFrom(foo);
//     ...
//     if (any.UnpackTo(&foo)) {
//       ...
//     }
//
// Example 2: Pack and unpack a message in Java.
//
//     Foo foo = ...;
//     Any any = Any.pack(foo);
//     ...
//     if (any.is(Foo.class)) {
//       foo = any.unpack(Foo.class);
//     }
//
//  Example 3: Pack and unpack a message in Python.
//
//     foo = Foo(...)
//     any = Any()
//     any.Pack(foo)
//     ...
//     if any.Is(Foo.DESCRIPTOR):
//       any.Unpack(foo)
//       ...
//
//  Example 4: Pack and unpack a message in Go
//
//      foo := &pb.Foo{...}
//      any, err := ptypes.MarshalAny(foo)
//      ...
//      foo := &pb.Foo{}
//      if err := ptypes.UnmarshalAny(any, foo); err != nil {
//        ...
//      }
//
// The pack methods provided by protobuf library will by default use
// ''type.googleapis.com/full.type.name'' as the type URL and the unpack
// methods only use the fully qualified type name after the last ''/''
// in the type URL, for example "foo.bar.com/x/y.z" will yield type
// name "y.z".
//
//
// JSON
// ====
// The JSON representation of an ''Any'' value uses the regular
// representation of the deserialized, embedded message, with an
// additional field ''@type'' which contains the type URL. Example:
//
//     package google.profile;
//     message Person {
//       string first_name = 1;
//       string last_name = 2;
//     }
//
//     {
//       "@type": "type.googleapis.com/google.profile.Person",
//       "firstName": <string>,
//       "lastName": <string>
//     }
//
// If the embedded message type is well-known and has a custom JSON
// representation, that representation will be embedded adding a field
// ''value'' which holds the custom JSON in addition to the ''@type''
// field. Example (for message [google.protobuf.Duration][]):
//
//     {
//       "@type": "type.googleapis.com/google.protobuf.Duration",
//       "value": "1.212s"
//     }
//
message Any {
  // A URL/resource name whose content describes the type of the
  // serialized protocol buffer message.
  //
  // For URLs which use the scheme ''http'', ''https'', or no scheme, the
  // following restrictions and interpretations apply:
  //
  // * If no scheme is provided, ''https'' is assumed.
  // * The last segment of the URL''s path must represent the fully
  //   qualified name of the type (as in ''path/google.protobuf.Duration'').
  //   The name should be in a canonical form (e.g., leading "." is
  //   not accepted).
  // * An HTTP GET on the URL must yield a [google.protobuf.Type][]
  //   value in binary format, or produce an error.
  // * Applications are allowed to cache lookup results based on the
  //   URL, or have them precompiled into a binary to avoid any
  //   lookup. Therefore, binary compatibility needs to be preserved
  //   on changes to types. (Use versioned type names to manage
  //   breaking changes.)
  //
  // Schemes other than ''http'', ''https'' (or the empty scheme) might be
  // used with implementation specific semantics.
  //
  string type_url = 1;

  // Must be a valid serialized protocol buffer of the above specified type.
  bytes value = 2;
}'
]

{ #category : #copyright }
PBGoogleProtobufResources class >> copyright [
"
// Protocol Buffers - Google's data interchange format
// Copyright 2008 Google Inc.  All rights reserved.
// https://developers.google.com/protocol-buffers/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// ""AS IS"" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
"

]

{ #category : #parsing }
PBGoogleProtobufResources class >> parse [

	| parser context resultContext |
	
	context := PP2Context new.
	parser := PBProtobufParser new.
	
	resultContext := parser parse: self any_proto withContext: context.
]

{ #category : #resources }
PBGoogleProtobufResources class >> source_context_proto [

	^'syntax = "proto3";

package google.protobuf;

option csharp_namespace = "Google.Protobuf.WellKnownTypes";
option java_package = "com.google.protobuf";
option java_outer_classname = "SourceContextProto";
option java_multiple_files = true;
option objc_class_prefix = "GPB";
option go_package = "google.golang.org/genproto/protobuf/source_context;source_context";

// ''SourceContext'' represents information about the source of a
// protobuf element, like the file in which it is defined.
message SourceContext {
  // The path-qualified name of the .proto file that contained the associated
  // protobuf element.  For example: `"google/protobuf/source_context.proto"`.
  string file_name = 1;
}'
]

{ #category : #resources }
PBGoogleProtobufResources class >> type_proto [

	^'syntax = "proto3";

package google.protobuf;

import "google/protobuf/any.proto";
import "google/protobuf/source_context.proto";

option csharp_namespace = "Google.Protobuf.WellKnownTypes";
option cc_enable_arenas = true;
option java_package = "com.google.protobuf";
option java_outer_classname = "TypeProto";
option java_multiple_files = true;
option objc_class_prefix = "GPB";
option go_package = "google.golang.org/genproto/protobuf/ptype;ptype";

// A protocol buffer message type.
message Type {
  // The fully qualified message name.
  string name = 1;
  // The list of fields.
  repeated Field fields = 2;
  // The list of types appearing in `oneof` definitions in this type.
  repeated string oneofs = 3;
  // The protocol buffer options.
  repeated Option options = 4;
  // The source context.
  SourceContext source_context = 5;
  // The source syntax.
  Syntax syntax = 6;
}

// A single field of a message type.
message Field {
  // Basic field types.
  enum Kind {
    // Field type unknown.
    TYPE_UNKNOWN        = 0;
    // Field type double.
    TYPE_DOUBLE         = 1;
    // Field type float.
    TYPE_FLOAT          = 2;
    // Field type int64.
    TYPE_INT64          = 3;
    // Field type uint64.
    TYPE_UINT64         = 4;
    // Field type int32.
    TYPE_INT32          = 5;
    // Field type fixed64.
    TYPE_FIXED64        = 6;
    // Field type fixed32.
    TYPE_FIXED32        = 7;
    // Field type bool.
    TYPE_BOOL           = 8;
    // Field type string.
    TYPE_STRING         = 9;
    // Field type group. Proto2 syntax only, and deprecated.
    TYPE_GROUP          = 10;
    // Field type message.
    TYPE_MESSAGE        = 11;
    // Field type bytes.
    TYPE_BYTES          = 12;
    // Field type uint32.
    TYPE_UINT32         = 13;
    // Field type enum.
    TYPE_ENUM           = 14;
    // Field type sfixed32.
    TYPE_SFIXED32       = 15;
    // Field type sfixed64.
    TYPE_SFIXED64       = 16;
    // Field type sint32.
    TYPE_SINT32         = 17;
    // Field type sint64.
    TYPE_SINT64         = 18;
  };

  // Whether a field is optional, required, or repeated.
  enum Cardinality {
    // For fields with unknown cardinality.
    CARDINALITY_UNKNOWN = 0;
    // For optional fields.
    CARDINALITY_OPTIONAL = 1;
    // For required fields. Proto2 syntax only.
    CARDINALITY_REQUIRED = 2;
    // For repeated fields.
    CARDINALITY_REPEATED = 3;
  };

  // The field type.
  Kind kind = 1;
  // The field cardinality.
  Cardinality cardinality = 2;
  // The field number.
  int32 number = 3;
  // The field name.
  string name = 4;
  // The field type URL, without the scheme, for message or enumeration
  // types. Example: `"type.googleapis.com/google.protobuf.Timestamp"`.
  string type_url = 6;
  // The index of the field type in `Type.oneofs`, for message or enumeration
  // types. The first type has index 1; zero means the type is not in the list.
  int32 oneof_index = 7;
  // Whether to use alternative packed wire representation.
  bool packed = 8;
  // The protocol buffer options.
  repeated Option options = 9;
  // The field JSON name.
  string json_name = 10;
  // The string value of the default value of this field. Proto2 syntax only.
  string default_value = 11;
}

// Enum type definition.
message Enum {
  // Enum type name.
  string name = 1;
  // Enum value definitions.
  repeated EnumValue enumvalue = 2;
  // Protocol buffer options.
  repeated Option options = 3;
  // The source context.
  SourceContext source_context = 4;
  // The source syntax.
  Syntax syntax = 5;
}

// Enum value definition.
message EnumValue {
  // Enum value name.
  string name = 1;
  // Enum value number.
  int32 number = 2;
  // Protocol buffer options.
  repeated Option options = 3;
}

// A protocol buffer option, which can be attached to a message, field,
// enumeration, etc.
message Option {
  // The option''s name. For protobuf built-in options (options defined in
  // descriptor.proto), this is the short name. For example, "map_entry".
  // For custom options, it should be the fully-qualified name. For example,
  // "google.api.http".
  string name = 1;
  // The option''s value packed in an Any message. If the value is a primitive,
  // the corresponding wrapper type defined in google/protobuf/wrappers.proto
  // should be used. If the value is an enum, it should be stored as an int32
  // value using the google.protobuf.Int32Value type.
  Any value = 2;
}

// The syntax in which a protocol buffer element is defined.
enum Syntax {
  // Syntax ''proto2''.
  SYNTAX_PROTO2 = 0;
  // Syntax ''proto3''.
  SYNTAX_PROTO3 = 1;
}'

]
