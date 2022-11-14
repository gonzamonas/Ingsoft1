!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:13:57'!
importData: data

	^ CustomerImporter valueFrom: (ReadStream on: data) into: session! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:33:02'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session.

	self assertNumberOfImportedCustomersIs: 2.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:40:17'!
test02ImportFailsWhenInvalidRecordType

	self should: [self importData: 'X,Pepe,Sanchez,D,22333444'] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter invalidRecordTypeErrorMessage equals: error messageText.
						self assertNumberOfImportedCustomersIs: 0]! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:40:31'!
test03ImportFailsWhenInvalidCustomerRecordType

	self should: [self importData: 'CC,Pepe,Sanchez,D,22333444'] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter invalidRecordTypeErrorMessage equals: error messageText.
						self assertNumberOfImportedCustomersIs: 0]! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:40:40'!
test04ImportFailsWhenInvalidAddressRecordType

	| invalidAddressData |
	invalidAddressData := 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'.
	self should: [self importData: invalidAddressData] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter invalidRecordTypeErrorMessage equals: error messageText .
						self assertNumberOfImportedAddressesIs: 0]! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:39:23'!
test05CannotImportCustomerWithInvalidNumberOfParameters

	self should: [CustomerImporter valueFrom: (ReadStream on: 'C,Pepe,Sanchez,D') into: session] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter invalidNumberOfParameters equals: error messageText.
						self assertNumberOfImportedCustomersIs: 0]! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:39:44'!
test06CannotImportAddressWithInvalidNumberOfParameters

	| invalidAddressData |
	invalidAddressData := 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'.
	self should: [self importData: invalidAddressData] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter invalidNumberOfParameters equals: error messageText.
						self assertNumberOfImportedAddressesIs: 0]! !

!ImportTest methodsFor: 'tests' stamp: 'GM 11/14/2022 19:39:56'!
test07CannotImportAddressWhenCustomerWasNotImported

	self should: [self importData: 'A,San Martin,3322,Olivos,1636,BsAs'] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:error | self assert: CustomerImporter cannotImportAddressWhenCustomerWasNotImported equals: error messageText.
						self assertNumberOfImportedAddressesIs: 0]! !


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

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'GM 11/14/2022 18:45:54'!
assertNumberOfImportedAddressesIs: aNumberOfAddresses 
	
	^ self assert: aNumberOfAddresses equals: (session selectAllOfType: Address) size! !

!ImportTest methodsFor: 'assertions' stamp: 'GM 11/14/2022 18:34:22'!
assertNumberOfImportedCustomersIs: aNumberOfCustomers

	^ self assert: aNumberOfCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !


!Address methodsFor: 'initialization' stamp: 'GM 11/14/2022 19:31:39'!
initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'GM 11/14/2022 19:31:23'!
withStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 

	^self new initializeWithStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


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
lastName

	^lastName ! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !

!Customer methodsFor: 'initialization' stamp: 'GM 11/14/2022 19:35:39'!
initializeWithFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber 
	
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'GM 11/14/2022 19:35:27'!
withFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber 
	
	^self new initializeWithFirstName: aFirstName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 19:01:02'!
assertNumberOfParametersIs: aNumberOfParameters

	^ record size = aNumberOfParameters ifFalse: [self error: self class invalidNumberOfParameters]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:21:28'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:22:50'!
hasLineToImport

	line := readStream nextLine. 
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 19:29:59'!
importAddress

	| newAddress |
	self assertNumberOfParametersIs: 6.
	self assertACustomerWasAlreadyImported.
	newAddress := Address withStreetName: record second 
						streetNumber: record third asNumber 
						town: record fourth 
						zipCode: record fifth asNumber 
						province: record sixth.
	newCustomer addAddress: newAddress.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 19:34:41'!
importCustomer

	self assertNumberOfParametersIs: 5.
	newCustomer := Customer withFirstName: record second lastName: record third identificationType: record fourth identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:48:33'!
importRecord

	self isCustomerRecord ifTrue: [^self importCustomer].
	self isAddressRecord ifTrue: [^self importAddress].
	
	self error: self class invalidRecordTypeErrorMessage! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:44:54'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:40:26'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'GM 11/14/2022 18:23:01'!
value

	"
	self importCustomers
	"
	 [self hasLineToImport ] whileTrue: [  
		self createRecord.
		self importRecord.	].

	! !


!CustomerImporter methodsFor: 'assertion' stamp: 'GM 11/14/2022 19:10:52'!
assertACustomerWasAlreadyImported
	
	newCustomer ifNil: [self error: self class cannotImportAddressWhenCustomerWasNotImported] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error' stamp: 'GM 11/14/2022 19:11:21'!
cannotImportAddressWhenCustomerWasNotImported
	
	^ 'Cannot import address when customer was not imported'! !

!CustomerImporter class methodsFor: 'error' stamp: 'GM 11/14/2022 18:52:12'!
invalidNumberOfParameters
	
	^'Invalid number of parameters'! !

!CustomerImporter class methodsFor: 'error' stamp: 'GM 11/14/2022 18:48:45'!
invalidRecordTypeErrorMessage
	
	^'Invalid record type'! !


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
