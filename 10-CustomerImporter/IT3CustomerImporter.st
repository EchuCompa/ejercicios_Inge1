!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:46:33'!
test01Import

	CustomerImporter valueFrom: self validImportData using: system.

	self assertImportedCustomersAre: 2.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:46:48'!
test02DataOnlyHasCustomerOrAddresses

	self should: [CustomerImporter valueFrom: self invalidImportData using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter invalidDataTypeErrorDescription.
	
	self assertImportedCustomersAre: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:46:53'!
test03DataHasInvalidCustomerType

	self should: [CustomerImporter valueFrom: self invalidCustomerTypeData using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter invalidDataTypeErrorDescription.
	
	self assertImportedCustomersAre: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:46:56'!
test04DataHasInvalidAddressType

	self should: [CustomerImporter valueFrom: self invalidAddressTypeData using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter invalidDataTypeErrorDescription.
	
	self assertImportedCustomersAre: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:46:59'!
test05DataHasInvalidCustomerLineLength

	self should: [CustomerImporter valueFrom: self invalidAddressLineInData using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter invalidLineLengthErrorDescription.
	
	self assertImportedCustomersAre: 1.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:47:01'!
test06CanNotHaveAddressWithoutCustomer

	self should: [CustomerImporter valueFrom: self addressLineWithoutCustomerInData using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter canNotAddAddressErrorDescription.
	
	self assertImportedCustomersAre: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:47:04'!
test07CanNotImportEmptyStream
	
	self should: [ CustomerImporter valueFrom: self emptyLine using: system ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter canNotImportEmptyStreamErrorDescription.
	
	self assertImportedCustomersAre: 0.! !

!ImportTest methodsFor: 'tests' stamp: 'Simon 11/17/2022 18:47:07'!
test08CannotHaveEmptyFieldsInACustomerRecord

	self should: [CustomerImporter valueFrom: self customerLineWithEmptyFields using: system. ] 
	raise:  Error - MessageNotUnderstood
	withMessageText: CustomerImporter invalidLineLengthErrorDescription .
	
	self assertImportedCustomersAre: 0.! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'Simon 11/17/2022 18:41:32'!
assertImportedCustomersAre: numberOfCustomers

	^ self assert: numberOfCustomers equals: system numberOfCustomers.! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'Simon 11/17/2022 19:10:55'!
setUp

	
	system := Environment current system.
	system start.! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'Simon 11/17/2022 18:38:59'!
tearDown

	system end.
	! !


!ImportTest methodsFor: 'customer' stamp: 'Simon 11/17/2022 18:42:28'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ system customerWithIdentificationType: anIdType number: anIdNumber! !


!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:54:31'!
addressLineWithoutCustomerInData

	^ ReadStream on:
'A,Esta,Direccion,No,Tiene,Customer'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 19:42:43'!
customerLineWithEmptyFields

	^ ReadStream on:
'C,Pepe,,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 19:04:38'!
emptyLine

	^ ReadStream on:
''! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:45:42'!
invalidAddressLineInData

	^ ReadStream on:
'C,Pepe,Sanche,D,43085429
A,Esta,Direccion,Se,Rompe'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:29:50'!
invalidAddressTypeData

	^ ReadStream on:
'AC,Pepe, Sanchez,Igual,Se,Rompe'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:37:19'!
invalidCustomerLineInData

	^ ReadStream on:
'C,Pepe,Sanchez,Se,Rompe, Igual'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:26:39'!
invalidCustomerTypeData

	^ ReadStream on:
'CA,Pepe, Sanchez,Igual,Se,Rompe'! !

!ImportTest methodsFor: 'test data' stamp: 'Simon 11/14/2022 18:19:11'!
invalidImportData

	^ ReadStream on:
'INVALIDO'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'system readStream line record lastCustomerImported'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'Simon 11/17/2022 18:45:09'!
initializeFrom: aReadStream using: aSystem
	system := aSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:11:33'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:03:29'!
hasLineToImport

	line := readStream nextLine. 
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 19:37:02'!
hasRecordsToImport

	^ readStream isEmpty ifTrue: [self error: self class canNotImportEmptyStreamErrorDescription]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:53:28'!
importAddress

	| newAddress |
	newAddress := Address new.
	(record size = 6) ifFalse: [self error: self class invalidLineLengthErrorDescription].
	(lastCustomerImported isNil) ifTrue: [self error: self class canNotAddAddressErrorDescription].
	lastCustomerImported addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/17/2022 18:45:51'!
importCustomer

	lastCustomerImported := Customer new.
	(record size = 5) ifFalse: [self error: self class invalidLineLengthErrorDescription].
	lastCustomerImported firstName: record second.
	lastCustomerImported lastName: record third.
	lastCustomerImported identificationType: record fourth.
	lastCustomerImported identificationNumber: record fifth.
	system addCustomer: lastCustomerImported! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:23:53'!
importRecord

	(self isACustomerRecord) ifTrue: [^ self importCustomer ].
	(self isAnAddressRecord) ifTrue: [^ self importAddress ].
	
	self error: self class invalidDataTypeErrorDescription.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:28:18'!
isACustomerRecord

	^ line beginsWith: 'C,'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 18:28:25'!
isAnAddressRecord

	^ line beginsWith: 'A,'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'Simon 11/14/2022 19:36:46'!
value

	"
	self importCustomers
	"
	self hasRecordsToImport.
	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord.
		].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'Simon 11/17/2022 18:44:23'!
from: aReadStream using: aSystem
	^self new initializeFrom: aReadStream using: aSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'Simon 11/17/2022 18:44:01'!
valueFrom: aReadStream using: aSystem

	^(self from: aReadStream using: aSystem) value! !


!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 18:52:29'!
canNotAddAddressErrorDescription
	^'Can not add address if there is no customer.'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 19:43:57'!
canNotAddCustomerErrorDescription
	^'Customer Line is invalid'.! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 19:22:57'!
canNotImportEmptyStreamErrorDescription
	^'You cannot import an empty line.'.! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 18:28:00'!
invalidCustomerTypeErrorDescription
	^'This file has a line with an invalid customer type.'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 18:20:55'!
invalidDataTypeErrorDescription
	^'This file has a line with an invalid data type'.! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Simon 11/14/2022 18:37:04'!
invalidLineLengthErrorDescription
	^'This line has an invalid length. Customer lines needs 5 parameters and addresses need 6 parameters'.! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'Simon 11/17/2022 18:42:36'!
customerWithIdentificationType: anIdType number: anIdNumber
	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'Simon 11/17/2022 18:41:31'!
numberOfCustomers
	^ (session selectAllOfType: Customer) size! !

!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'Simon 11/17/2022 17:58:02'!
session
	^session! !


!PersistentCustomerSystem methodsFor: 'system' stamp: 'Simon 11/17/2022 18:45:46'!
addCustomer: aCustomer
	session persist: aCustomer! !

!PersistentCustomerSystem methodsFor: 'system' stamp: 'Simon 11/17/2022 18:38:55'!
end
	session commit.
	session close.! !

!PersistentCustomerSystem methodsFor: 'system' stamp: 'Simon 11/17/2022 18:39:40'!
start
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'instance creation' stamp: 'Simon 11/17/2022 18:51:03'!
start
	customers := OrderedCollection new.! !


!TransientCustomerSystem methodsFor: 'adding' stamp: 'Simon 11/17/2022 18:52:38'!
addCustomer: lastCustomerImported 
	^customers add: lastCustomerImported! !


!TransientCustomerSystem methodsFor: 'accesing' stamp: 'Simon 11/17/2022 18:54:47'!
customerWithIdentificationType: anIdType number: anIdNumber 
	^customers detect: [:aCustomer |  aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ] ].! !

!TransientCustomerSystem methodsFor: 'accesing' stamp: 'Simon 11/17/2022 18:53:15'!
numberOfCustomers
	^customers size.! !


!TransientCustomerSystem methodsFor: 'system' stamp: 'Simon 11/17/2022 18:55:07'!
end
	customers := nil.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'as yet unclassified' stamp: 'Simon 11/17/2022 19:06:02'!
system
	self  subclassResponsibility .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'as yet unclassified' stamp: 'Simon 11/17/2022 19:12:55'!
current
	^((Smalltalk at: #ENV) = 'DEV') ifTrue: [Development new] ifFalse: [Integration new].! !


!classDefinition: #Development category: 'CustomerImporter'!
Environment subclass: #Development
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Development methodsFor: 'accessing' stamp: 'Simon 11/17/2022 19:14:08'!
system
	^TransientCustomerSystem new.! !


!classDefinition: #Integration category: 'CustomerImporter'!
Environment subclass: #Integration
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Integration methodsFor: 'accessing' stamp: 'Simon 11/17/2022 19:14:49'!
system
	^PersistentCustomerSystem new.! !
