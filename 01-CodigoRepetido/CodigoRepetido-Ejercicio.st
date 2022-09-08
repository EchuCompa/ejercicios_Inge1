!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'EC 9/5/2022 21:48:33'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self assertIfThisClosure: [customerBook addCustomerNamed: 'John Lennon'.] executeInLessThan: 50 * millisecond .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'EC 9/5/2022 21:48:33'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self assertIfThisClosure: [customerBook removeCustomerNamed: 'Paul McCartney']  executeInLessThan: 100 * millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:42:04'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertIfThisClosure: [customerBook addCustomerNamed: ''] failsWithErrorMessage: CustomerBook customerCanNotBeEmptyErrorMessage.
	
	self assert: customerBook isEmpty ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:46:06'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertIfThisClosure: [customerBook removeCustomerNamed: 'Paul McCartney'] 
	failsWithErrorMessage:  CustomerBook customerDoesNotExistErrorMessage.

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:39:39'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:30:38'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfCustomers.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:43:03'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertIfThisClosure: [customerBook suspendCustomerNamed: 'George Harrison'] failsWithErrorMessage: CustomerBook customerCannotBeSuspendedErrorMessage.

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'E 9/7/2022 16:43:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertIfThisClosure: [customerBook suspendCustomerNamed: johnLennon]  failsWithErrorMessage: CustomerBook customerCannotBeSuspendedErrorMessage.

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'EC 9/5/2022 21:48:33'!
assertIfThisClosure: aClosureToExecute executeInLessThan: timeLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosureToExecute value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimit)

	
	! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'E 9/7/2022 16:40:50'!
assertIfThisClosure: aClosure failsWithErrorMessage: errorMessage
	
	
	[ aClosure value.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = errorMessage
			].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'E 9/7/2022 16:22:21'!
includesCustomerNamed: aName

	^self customerAlreadyExists: aName.! !

!CustomerBook methodsFor: 'testing' stamp: 'E 9/7/2022 16:23:00'!
isEmpty
	
	^self numberOfCustomers = 0.! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'S 9/6/2022 17:42:33'!
signalCustomerCannotBeSuspended 

	self error: self class customerCannotBeSuspendedErrorMessage.! !

!CustomerBook methodsFor: 'signals' stamp: 'S 9/6/2022 17:03:43'!
signalCustomerDoesNotExist

	self error: self class customerDoesNotExistErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer management' stamp: 'EC 9/5/2022 21:37:36'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self customerAlreadyExists: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'S 9/6/2022 17:56:34'!
customerAlreadyExists: aName

	^ (active includes: aName) or: [suspended includes: aName]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'E 9/7/2022 16:23:22'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'S 9/6/2022 17:07:09'!
removeCustomerNamed: aName 
 
	
	active remove: aName ifAbsent: [ 
		suspended remove: aName ifAbsent: [^self signalCustomerDoesNotExist ].
	].
	^aName	.
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 's 9/6/2022 18:03:49'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^ self signalCustomerCannotBeSuspended ].
	
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

!CustomerBook class methodsFor: 'error messages' stamp: 'S 9/6/2022 17:37:39'!
customerCannotBeSuspendedErrorMessage
	
	^'Customer cannot be suspended!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'S 9/6/2022 17:04:51'!
customerDoesNotExistErrorMessage

	^'Customer does not exist!!!!!!'! !
