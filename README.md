# protobuf-smalltalk
[![Build Status](https://travis-ci.org/jvdsandt/protobuf-smalltalk.svg?branch=master)](https://travis-ci.org/jvdsandt/protobuf-smalltalk)

Protocol buffers support for Smalltalk. [Protocol buffers](https://developers.google.com/protocol-buffers/)
is a language and 
platform-neutral serialization protocol created by Google. This projects adds support for
the proto3 version of this protocol to the Smalltalk programming language. 

The library is developed in [Pharo](https://pharo.org/) Smalltalk and uses [PetitParser2](https://github.com/kursjan/petitparser2)
for parsing proto files.


## Installing protobuf-smalltalk

Pharo:

```smalltalk
Metacello new
   baseline: 'Protobuf';
   repository: 'github://jvdsandt/protobuf-smalltalk';
   load.
```