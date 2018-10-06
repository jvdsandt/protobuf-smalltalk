Class {
	#name : #BaselineOfProtobuf,
	#superclass : #BaselineOf,
	#category : #BaselineOfProtobuf
}

{ #category : #baselines }
BaselineOfProtobuf >> baselineOf: spec [
	<baseline>
	spec for: #common do: [ 
		spec configuration: 'PetitParser2' with: [
			spec 
				versionString: #stable;
				repository: 'https://github.com/kursjan/petitparser2.git' ]. 
		spec package: 'Protobuf-Core'.
		spec package: 'Protobuf-Core-Tests' with: [ spec requires: #( 'Protobuf-Core' ) ].
		spec package: 'Protobuf-Tools' with: [ spec requires: #( 'Protobuf-Core' 'PetitParser2' ) ].
		spec package: 'Protobuf-Tools-Tests' with: [ spec requires: #( 'Protobuf-Tools' 'Protobuf-Core-Tests' ) ].
		spec group: 'default' with: #( 'Protobuf-Tools-Tests' ).
		spec group: 'runtime' with: #( 'Protobuf-Core-Tests' ) ]
]
