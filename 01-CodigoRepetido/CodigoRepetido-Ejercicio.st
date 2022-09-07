!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'asserts' stamp: 'GM 9/7/2022 16:19:28'!
assertNumberOfActiveCustomersIs: aNumberOfActiveCustomers andNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers andNumberOfCustomersIs: aNumberOfCustomers in: aCustomerBook.
	
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.

	
! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'GM 9/7/2022 16:12:41'!
assertOnlyCustomerIsJohnLennonIn: aCustomerBook

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'GM 9/5/2022 21:43:17'!
assertThat: anAction failsWith: anErrorType andDo: aCheck

[ anAction value.
	self fail ]
		on: anErrorType 
		do: aCheck

	
! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'GM 9/5/2022 21:52:35'!
assertThat: anAction takesLessThan: aTimeLimit

|millisecondsBeforeRunning millisecondsAfterRunning|

millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
anAction value.
millisecondsAfterRunning := Time millisecondClockValue * millisecond.

self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeLimit
	! !


!CustomerBookTest methodsFor: 'book creation' stamp: 'GM 9/7/2022 16:22:16'!
customerBookWith: aCustomer	
	|customerBook |
	customerBook := CustomerBook new.	
	customerBook addCustomerNamed: aCustomer.
	^customerBook! !

!CustomerBookTest methodsFor: 'book creation' stamp: 'GM 9/7/2022 16:22:10'!
customerBookWithSuspended: aCustomer

	|customerBook|
	customerBook := self customerBookWith: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.
	^customerBook
	
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:38:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50 * millisecond! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/5/2022 22:01:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWith: paulMcCartney.
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100 * millisecond.
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/5/2022 21:40:03'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertThat: [ customerBook addCustomerNamed: ''.] failsWith: Error andDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:16:27'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
		
	self assertThat: 	[ customerBook removeCustomerNamed: 'Paul McCartney'.]
		failsWith: NotFound 
		andDo: [ self assertOnlyCustomerIsJohnLennonIn: customerBook ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:23:57'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
		
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWithSuspended: paulMcCartney.
	
	self assertNumberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 1 andNumberOfCustomersIs: 1 in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:24:08'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self customerBookWithSuspended: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfActiveCustomersIs: 0 andNumberOfSuspendedCustomersIs: 0 andNumberOfCustomersIs: 0 in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:25:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.	
	customerBook := self customerBookWith: johnLennon.	
	
	self assertThat: 	[customerBook suspendCustomerNamed: 'George Harrison'.]
		failsWith: CantSuspend 
		andDo: [self assertOnlyCustomerIsJohnLennonIn: customerBook]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GM 9/7/2022 16:24:21'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWithSuspended: johnLennon.
	
	self assertThat: 	 [customerBook suspendCustomerNamed: johnLennon.]
		failsWith: CantSuspend 
		andDo: [ self assertOnlyCustomerIsJohnLennonIn: customerBook]! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'GM 9/7/2022 16:37:20'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'GM 9/7/2022 16:34:59'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'GM 9/7/2022 16:31:33'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent: 
		[suspended remove: aName 	ifAbsent: 
			[^ NotFound signal.]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
