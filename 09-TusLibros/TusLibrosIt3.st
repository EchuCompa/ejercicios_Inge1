!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !

!CreditCardTest methodsFor: 'tests'!
test01CannotCreateCreditCartWithInvalidNumer
	
	self should: [CreditCard with: '14' of: 'Pepe' thatExpiresOn: testObjectsFactory expirationDate.]
	 raise:  Error  withMessageText: CreditCard invalidNumberErrorDescription.! !

!CreditCardTest methodsFor: 'tests'!
test02CannotCreateCreditCartWithInvalidOwner
	
	self should: [CreditCard with: '0123456789101112' of: '     ' thatExpiresOn: testObjectsFactory expirationDate.]
	 raise:  Error - MessageNotUnderstood  withMessageText: CreditCard invalidOwnerErrorDescription.
	! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory restInterface authenticationBehavior clientId password time debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/6/2022 12:48:45'!
setUp 
	
	testObjectsFactory := StoreTestObjectsFactory new.
	
	time := testObjectsFactory today.

	restInterface := InternalRestInterface withAuthenticator: self andCatalog: testObjectsFactory defaultCatalog on: time withMp: self.
	clientId := 1234.
	password := 'ContraReDificilYSegura123'.
	
	authenticationBehavior := true.
	
	debitBehavior := [ :anAmount :aCreditCard | ]
	
	! !

!RestInterfaceTest methodsFor: 'tests'!
test01NewCartCannotBeCreatedWithInvalidLogin

	authenticationBehavior :=false.
	self should: [ restInterface createCartFor: clientId with: password.]
	raise: Error - MessageNotUnderstood
	withMessageText: 	InternalRestInterface invalidLoginErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests'!
test02NewCartIsListedEmpty

	| cartID |
	
	cartID:= restInterface createCartFor: clientId with: password.
	self assert: (restInterface listCart: cartID) isEmpty.
	
	! !

!RestInterfaceTest methodsFor: 'tests'!
test03CannotListInvalidCartID

	self should: [restInterface listCart: 1000]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class invalidCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/3/2022 21:24:09'!
test04ListCartWithOneBook

	| cartID isbn expected |
	isbn := '1'.
	cartID:= restInterface createCartFor: clientId with: password.
	restInterface addToCart: cartID aBook: isbn times: 1.
	
	expected _ Bag new.
	expected add: isbn.
	
	self assert: (restInterface listCart: cartID) equals: expected .
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/3/2022 21:40:53'!
test05ListCartWithManyBooks

	| cartID isbn expected isbn2 |
	isbn := '1'.
	isbn2 := '2'.
	cartID:= restInterface createCartFor: clientId with: password.
	restInterface addToCart: cartID aBook: isbn times: 2.
	restInterface addToCart: cartID aBook: isbn2 times: 1.
	
	expected := Bag new.
	expected add: isbn withOccurrences: 2.
	expected add: isbn2.
	
	self assert: (restInterface listCart: cartID) equals: expected .
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/3/2022 21:43:04'!
test06CannotAddToInvalidCartID

	self should: [restInterface addToCart: 10000 aBook: '1' times:1]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class invalidCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/3/2022 21:55:40'!
test07CannotAddInvalidQuantityBook

	| cartID |
	cartID:= restInterface createCartFor: clientId with: password.
	
	self should: [restInterface addToCart: cartID aBook: 	testObjectsFactory itemSellByTheStore times:0]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class invalidQuantityErrorDescription .
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 's 11/5/2022 16:30:13'!
test08CannotAddToExpiredCartID

	| cartID |
	
	cartID:= restInterface createCartFor: clientId with: password.
	
	self timePast: (Duration minutes: 31).
	
	self should: [  restInterface addToCart: cartID aBook: '1' times:1]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class expiredCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 's 11/5/2022 16:37:25'!
test09CannotListExpiredCartID

	| cartID |
	
	cartID:= restInterface createCartFor: clientId with: password.
	
	self timePast: (Duration minutes: 31).
	
	self should: [  restInterface listCart: cartID ]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class expiredCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 's 11/5/2022 16:46:37'!
test10CannotCheckoutExpiredCartID

	| cartID |
	
	cartID:= restInterface createCartFor: clientId with: password.
	
	self timePast: (Duration minutes: 31).
	
	self should: [  restInterface checkOutCart: cartID payingWith: testObjectsFactory notExpiredCreditCard ]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class expiredCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 's 11/5/2022 16:49:37'!
test11CannotCheckOutInvalidCartID

	self should: [restInterface checkOutCart: 1000 payingWith: testObjectsFactory notExpiredCreditCard ]
	raise: Error - MessageNotUnderstood
	withMessageText: restInterface class invalidCartIDErrorDescription.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/6/2022 13:42:19'!
test12ListPurchasesAfterCheckingOutACartWithOneBook

	| cartID isbn expected |
	isbn := '1'.
	cartID:= restInterface createCartFor: clientId with: password.
	restInterface addToCart: cartID aBook: isbn times: 1.
	
	expected := Bag new.
	expected add: isbn.
	
	restInterface checkOutCart: cartID payingWith: testObjectsFactory notExpiredCreditCard .
	
	self assert: (restInterface listPurchasesOf: clientId with: password ) equals: expected .
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 's 11/5/2022 17:24:15'!
test13ListPurchasesAfterCheckingOutOnlyOneCart

	| cart1 cart2 isbn1 isbn2 expected |
	isbn1 := '1'.
	isbn2 := '2'.
	
	cart1:= restInterface createCartFor: clientId with: password.
	cart2:= restInterface createCartFor: clientId with: password.
	
	restInterface addToCart: cart1 aBook: isbn1 times: 1.
	restInterface addToCart: cart1 aBook: isbn2 times: 3.
	restInterface addToCart: cart2 aBook: isbn1 times: 1. 
	
	expected _ Bag new.
	expected add: isbn1 withOccurrences: 1.
	expected add: isbn2 withOccurrences: 3.
	
	restInterface checkOutCart: cart1 payingWith: testObjectsFactory notExpiredCreditCard .
	
	self assert: (restInterface listPurchasesOf: clientId with: password ) equals: expected .
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/6/2022 12:55:23'!
test14ListPurchasesAfterCheckingOutVariousCartWithManyBooks

	| cart1 cart2 isbn1 isbn2 expected |
	isbn1 := '1'.
	isbn2 := '2'.
	
	cart1:= restInterface createCartFor: clientId with: password.
	cart2:= restInterface createCartFor: clientId with: password.
	
	restInterface addToCart: cart1 aBook: isbn1 times: 1.
	restInterface addToCart: cart1 aBook: isbn2 times: 3.
	restInterface addToCart: cart2 aBook: isbn1 times: 1. 
	
	expected := Bag new.
	expected add: isbn1 withOccurrences: 2.
	expected add: isbn2 withOccurrences: 3.
	
	restInterface checkOutCart: cart1 payingWith: testObjectsFactory notExpiredCreditCard.
	restInterface checkOutCart: cart2 payingWith: testObjectsFactory notExpiredCreditCard .
	
	self assert: expected  equals: (restInterface listPurchasesOf: clientId with: password ).
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'Simon 11/6/2022 13:20:35'!
test15CannotUseACartAfterCheckout

	| cartID isbn expected |
	isbn := '1'.
	cartID:= restInterface createCartFor: clientId with: password.
	restInterface addToCart: cartID aBook: isbn times: 1.
	
	expected _ Bag new.
	expected add: isbn.
	
	restInterface checkOutCart: cartID payingWith: testObjectsFactory notExpiredCreditCard.
	
	self should: [ restInterface addToCart: cartID aBook: isbn times: 1 ]
	raise: Error - MessageNotUnderstood
	withMessageText: 	InternalRestInterface checkoutCartErrorDescription.! !


!RestInterfaceTest methodsFor: 'authBehavior'!
isAuthenticUser: clientID with: clientPassword
	^authenticationBehavior.! !


!RestInterfaceTest methodsFor: 'time' stamp: 's 11/5/2022 16:35:22'!
timePast: aTime 
	restInterface timePast: aTime.! !


!RestInterfaceTest methodsFor: 'debit behavior' stamp: 'Simon 11/6/2022 12:49:23'!
debit: total from: creditCard 
	^debitBehavior value: total value: creditCard.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'Simon 11/3/2022 21:36:45'!
listItems
	"Tenemos la alternativa de que el Cart se encarge de iterar sobre sus items o que los devuelva para que otro objeto los procese. Ya que creemos que convertirlo a string no le compete al Cart implementamos esta opción."
	^ items asBag copy.! !

!Cart methodsFor: 'queries'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartInfo category: 'TusLibros'!
Object subclass: #CartInfo
	instanceVariableNames: 'cart ownerID lastTimeOfUse'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInfo methodsFor: 'initialize' stamp: 'Simon 11/6/2022 13:45:29'!
initializeOf: aCart createdBy: aClientID at: aDateAndTime 
	cart := aCart.
	ownerID := aClientID.
	lastTimeOfUse := aDateAndTime.! !


!CartInfo methodsFor: 'accesing' stamp: 'Simon 11/6/2022 13:41:16'!
cart
	^cart! !

!CartInfo methodsFor: 'accesing' stamp: 'Simon 11/6/2022 13:40:03'!
lastTimeOfUse
	^lastTimeOfUse! !

!CartInfo methodsFor: 'accesing' stamp: 'Simon 11/6/2022 13:41:47'!
owner
	^ownerID.! !


!CartInfo methodsFor: 'setters' stamp: 'Simon 11/6/2022 13:41:06'!
lastTimeOfUse: actualTime 
	lastTimeOfUse := actualTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartInfo class' category: 'TusLibros'!
CartInfo class
	instanceVariableNames: ''!

!CartInfo class methodsFor: 'instance creation' stamp: 'Simon 11/6/2022 13:37:34'!
of: aCart createdBy: aClientID at: aDateAndTime 
	^self new initializeOf: aCart createdBy: aClientID at: aDateAndTime.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'Simon 11/6/2022 12:18:45'!
createSale

	^ Sale of: total with: cart listItems.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'Simon 11/6/2022 12:44:01'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'Simon 11/6/2022 12:03:18'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^total! !


!Cashier methodsFor: 'initialization'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization'!
initializeWith: cardNumber of: cardOwner thatExpireson: expirationDate
	
	expiration := expirationDate.
	number := cardNumber.
	owner := cardOwner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation'!
with: stringCardNumber of: cardOwner thatExpiresOn: expirationDate
	
	self assertNumberIsValid: stringCardNumber.
	self assertOwnerIsValid: cardOwner.
	
	^self new initializeWith: stringCardNumber asNumber of: cardOwner thatExpireson: expirationDate.
	
	! !


!CreditCard class methodsFor: 'errors'!
invalidNumberErrorDescription
	^'Credit card can only be created with a positive 16 digit number.'! !

!CreditCard class methodsFor: 'errors'!
invalidOwnerErrorDescription
	^'Owner name cannot be empty'.! !


!CreditCard class methodsFor: 'asserts'!
assertNumberIsValid: cardNumber

	^ ((cardNumber size == 16) and: [cardNumber asNumber > 0]) ifFalse: [^self error: self invalidNumberErrorDescription]! !

!CreditCard class methodsFor: 'asserts'!
assertOwnerIsValid: cardOwner

	^((cardOwner isEmpty) or:[cardOwner isLastSeparator]) ifTrue: [^self error: self invalidOwnerErrorDescription]! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'authenticator lastID activeCarts catalog actualTime cartsLastUsed cartsByClient merchantProcessor salesByClients clientIDOfCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialize' stamp: 'Simon 11/6/2022 13:26:04'!
initializeWithAuthenticator: anAuthenticator andCatalog: interfaceCatalog  on: aDateAndTime withMP: aMerchantProcessor
	authenticator := anAuthenticator.
	catalog := interfaceCatalog.
	merchantProcessor := aMerchantProcessor .
	actualTime := aDateAndTime.
	lastID := 0.
	cartsLastUsed := Dictionary new.
	salesByClients := Dictionary new.
	activeCarts := Dictionary new.
	clientIDOfCart := Dictionary new.
	! !


!InternalRestInterface methodsFor: 'carts' stamp: 'Simon 11/6/2022 13:35:06'!
addToCart: cartID aBook: bookISBN times: quantity 
	| cartInfo |
	cartInfo := self obtainActiveCart: cartID.
	self canBeUsed: cartInfo .
	self assertValidQuantity: quantity.
	cartInfo cart add: quantity of: bookISBN.
	self updateTimeOf: cartInfo.
	activeCarts at: cartID put: cartInfo.
	^'OK'.! !

!InternalRestInterface methodsFor: 'carts' stamp: 'Simon 11/6/2022 13:33:52'!
checkOutCart: cartID payingWith: aCreditCard 

	| cartInfo  salesByClient cashier |
	cartInfo := self obtainActiveCart: cartID .
	self canBeUsed: cartInfo.
	salesByClient := salesByClients at: cartInfo owner ifAbsent: [OrderedCollection new].
	cashier := Cashier toCheckout: cartInfo cart charging: aCreditCard  throught: merchantProcessor on:  actualTime registeringOn: salesByClient.
	cashier checkOut.
	salesByClients at: cartInfo owner put: salesByClient.
	activeCarts removeKey: cartID.! !

!InternalRestInterface methodsFor: 'carts' stamp: 'Simon 11/6/2022 13:39:10'!
createCartFor: clientID with: password 
	self assertValid: clientID with: password.
	lastID := lastID+1.
	activeCarts at: lastID put: (CartInfo of: (Cart acceptingItemsOf: catalog) createdBy: clientID at: actualTime).
	^lastID.! !

!InternalRestInterface methodsFor: 'carts' stamp: 'Simon 11/6/2022 13:36:31'!
listCart: cartID 
	| cartInfo |
	cartInfo := self obtainActiveCart: cartID.
	self canBeUsed: cartInfo.
	self updateTimeOf: cartInfo.
	^cartInfo cart listItems.
! !

!InternalRestInterface methodsFor: 'carts' stamp: 'Simon 11/6/2022 13:10:38'!
obtainActiveCart: cartID

	^ activeCarts at: cartID ifAbsent: [
		(cartID > lastID) ifTrue: [self error: self class invalidCartIDErrorDescription]
		ifFalse: [self error: self class checkoutCartErrorDescription]
		]! !


!InternalRestInterface methodsFor: 'assert'!
assertValid: clientId with: password
	(authenticator isAuthenticUser: clientId with: password) ifFalse: [^self error: self class invalidLoginErrorDescription.].
	.! !

!InternalRestInterface methodsFor: 'assert' stamp: 'Simon 11/6/2022 13:11:35'!
assertValidQuantity: quantity

	^ (quantity >=1) ifFalse: [self error: self class invalidQuantityErrorDescription]! !

!InternalRestInterface methodsFor: 'assert' stamp: 'Simon 11/6/2022 13:40:28'!
canBeUsed: aCartInfo
	 ((actualTime - aCartInfo lastTimeOfUse ) >= (self expirationTimeForCarts)) ifTrue:[self error: self class expiredCartIDErrorDescription].

! !

!InternalRestInterface methodsFor: 'assert' stamp: 's 11/5/2022 16:41:10'!
expirationTimeForCarts

	^ Duration minutes: 30! !


!InternalRestInterface methodsFor: 'time' stamp: 's 11/5/2022 16:36:06'!
timePast: aTime 
	actualTime := actualTime + aTime .! !

!InternalRestInterface methodsFor: 'time' stamp: 'Simon 11/6/2022 13:40:41'!
updateTimeOf: cartInfo
	cartInfo lastTimeOfUse: actualTime.
! !


!InternalRestInterface methodsFor: 'purchases' stamp: 'Simon 11/6/2022 13:19:43'!
listPurchasesOf: clientId with: password 
	self assertValid: clientId with: password.
	^(salesByClients at: clientId ) inject: (Bag new) into: [ :list :sale | list addAll: sale listItems . list].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation'!
withAuthenticator: anAuthenticator andCatalog: interfaceCatalog  
	^self new initializeWithAuthenticator: anAuthenticator andCatalog: interfaceCatalog. ! !

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'Simon 11/6/2022 12:48:30'!
withAuthenticator: aRestInterfaceTest andCatalog: aDictionary on: aDateAndTime withMp: aMerchantProcessor  
	^self new initializeWithAuthenticator: aRestInterfaceTest andCatalog: aDictionary on: aDateAndTime withMP: aMerchantProcessor.! !


!InternalRestInterface class methodsFor: 'errors' stamp: 'Simon 11/6/2022 13:08:39'!
checkoutCartErrorDescription
	^'Cannot use a cart that was already checked out.'! !

!InternalRestInterface class methodsFor: 'errors' stamp: 's 11/5/2022 16:53:23'!
emptyCartErrorDescription
	self shouldBeImplemented.! !

!InternalRestInterface class methodsFor: 'errors' stamp: 's 11/5/2022 16:30:56'!
expiredCartIDErrorDescription
	^'Carts expire after 30 minutes'.! !

!InternalRestInterface class methodsFor: 'errors'!
invalidCartIDErrorDescription
	^'Invalid cart, please use a cart that was created. You can do it!!'! !

!InternalRestInterface class methodsFor: 'errors'!
invalidLoginErrorDescription
	^'Invalid login, wrong clientID or password.'! !

!InternalRestInterface class methodsFor: 'errors' stamp: 'Simon 11/3/2022 21:55:10'!
invalidQuantityErrorDescription
	^'Quantity of items must be one or more'.! !


!InternalRestInterface class methodsFor: 'MP double' stamp: 'Simon 11/6/2022 12:35:41'!
debit: total from: creditCard 
	self shouldBeImplemented.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accesing' stamp: 'Simon 11/6/2022 12:27:58'!
listItems
	^items.! !

!Sale methodsFor: 'accesing' stamp: 'Simon 11/6/2022 12:28:11'!
total
	
	^total! !


!Sale methodsFor: 'initialization' stamp: 'Simon 11/6/2022 12:16:06'!
initializeTotal: aTotal with: aCollectionOfItems

	total := aTotal.
	items := aCollectionOfItems.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'Simon 11/6/2022 12:50:52'!
of: aTotal with: aCollectionOfItems 

	"should assert total is not negative or 0!!"

	^self new initializeTotal: aTotal with: aCollectionOfItems.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items'!
itemNotSellByTheStore
	
	^'24832958293'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'Simon 11/6/2022 12:04:38'!
itemSellByTheStore
	
	^ '0'! !

!StoreTestObjectsFactory methodsFor: 'items'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: '1' put: 1;
		at: '2' put: 2;
		at: '3' put: 3;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card'!
expirationDate

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card'!
expiredCreditCard
	
	^CreditCard expiringOn: self expirationDate! !

!StoreTestObjectsFactory methodsFor: 'credit card'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredDate! !

!StoreTestObjectsFactory methodsFor: 'credit card'!
notExpiredDate

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date'!
today
	
	^ today! !
