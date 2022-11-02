!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/31/2022 19:05:08'!
test09CartCannotHaveInvalidPriceList
	
	self 
		should: [Cart acceptingItemsOf: self invalidPriceList.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart new invalidPriceErrorMesage.]! !

!CartTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:15:49'!
test10PriceOfEmptyCart
	| cart |
	cart := self createCartBiggerCatalog.
	
	self assert: cart totalPrice equals: 0.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:16:00'!
test11PriceOfCartWithOneBook
	| cart |
	
	cart := self createCartBiggerCatalog.
	cart add: '1'.
	
	self assert:  cart totalPrice equals: 1*peso.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:16:38'!
test12PriceOfCartWithManyBooks
	| cart |
	
	cart := self createCartBiggerCatalog.
	cart add: 1 of: '1'.
	cart add: 2 of: '2'.
	cart add: 3 of: '3'.
	
	self assert: cart totalPrice equals: 14*peso.! !


!CartTest methodsFor: 'support' stamp: 'Simon 11/2/2022 08:15:35'!
biggerPriceList
	
	^Dictionary new at: '1' put: 1*peso; at: '2' put: 2*peso; at: '3' put: 3*peso;yourself.! !

!CartTest methodsFor: 'support' stamp: 'Simon 10/31/2022 18:50:37'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!CartTest methodsFor: 'support' stamp: 'Simon 11/2/2022 08:15:24'!
createCartBiggerCatalog
	
	^Cart acceptingItemsOf: self biggerPriceList! !

!CartTest methodsFor: 'support' stamp: 'Simon 10/31/2022 18:51:43'!
defaultPriceList
	
	^ Dictionary new at: self itemSellByTheStore put: 1*peso; yourself.! !

!CartTest methodsFor: 'support' stamp: 'Simon 10/31/2022 19:01:06'!
invalidPriceList
	
	^ Dictionary new at: '1' put: 1*peso; at: '2' put: -1*peso; yourself.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'salesBook casshier cartWithOneBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'Simon 10/31/2022 18:50:37'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!CashierTest methodsFor: 'support' stamp: 'Simon 11/2/2022 08:30:41'!
createCashier

	^ Cashier withSalesBook: salesBook andMerchantProcessor: MerchantProccesorDouble new! !

!CashierTest methodsFor: 'support' stamp: 'Simon 10/31/2022 19:08:49'!
defaultPriceList
	
	^Dictionary new at: '1' put: 1*peso; at: '2' put: 2*peso; at: '3' put: 3*peso;yourself.! !

!CashierTest methodsFor: 'support' stamp: 's 11/1/2022 18:31:12'!
insufficientCreditCard

	^ CreditCard with: 888888888888888 of: 'Insuficiente' thatExpiresIn: self validExpirationDate! !

!CashierTest methodsFor: 'support' stamp: 'Simon 10/31/2022 20:30:50'!
invalidExpirationDate
	^FixedGregorianDate today previous: GregorianMonth oneMonth.! !

!CashierTest methodsFor: 'support' stamp: 's 11/1/2022 18:29:41'!
stolenCreditCard

	^ CreditCard with: 9999999999999999 of: 'Robada' thatExpiresIn: self validExpirationDate! !

!CashierTest methodsFor: 'support' stamp: 'Simon 11/2/2022 08:18:04'!
validCreditCard

	^ CreditCard with: 1 of: 'Harry Potter' thatExpiresIn: self validExpirationDate! !

!CashierTest methodsFor: 'support' stamp: 'Simon 10/31/2022 20:31:04'!
validExpirationDate
	^FixedGregorianDate today.! !


!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:35:39'!
expiredCard

	^ CreditCard with: 1 of: 'Harry Potter' thatExpiresIn: self invalidExpirationDate! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:31:52'!
setUp
	salesBook := OrderedCollection new.
	cartWithOneBook := self createCart.
	cartWithOneBook add: '1'.
	! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:30:41'!
test01CannotCheckoutAnEmptyCart
	| cashier cart creditCard |
	
	cashier := self createCashier.
	cart := self createCart..
	creditCard := self validCreditCard.
	
	self should:[ (cashier checkoutOf: cart payingWith: creditCard) ] 
	raise: Error 
	withMessageText:Cashier invalidEmptyCartErrorMessage .
		self assert: (salesBook isEmpty ).! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:35:39'!
test02CannotCheckoutWithExpiredCard
	| cashier creditCard |
	
	cashier := self createCashier.
	creditCard := self expiredCard .
	
	self should:[ (cashier checkoutOf: cartWithOneBook payingWith: creditCard) ] 
	raise: Error 
	withMessageText:Cashier expiredCardErrorDescription .
		self assert: (salesBook isEmpty ).! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:32:14'!
test03CannotCheckoutWithStolenCard
	| cashier creditCard |
	
	cashier := self createCashier.
	creditCard := self stolenCreditCard .
	
	self should:[ (cashier checkoutOf: cartWithOneBook payingWith: creditCard) ] 
	raise: Error 
	withMessageText:MerchantProccesorDouble stolenCardErrorDescription .
		self assert: (salesBook isEmpty ).! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:32:23'!
test04CannotCheckoutWithACardWithInsufficientCredit
	| cashier creditCard |
	
	cashier := self createCashier.
	creditCard := self insufficientCreditCard .
	
	self should:[ (cashier checkoutOf: cartWithOneBook payingWith: creditCard) ] 
	raise: Error 
	withMessageText:MerchantProccesorDouble insufficientCreditErrorDescription .
		self assert: (salesBook isEmpty ).! !

!CashierTest methodsFor: 'tests' stamp: 'Simon 11/2/2022 08:32:31'!
test05CanCheckout
	| cashier creditCard |
	
	cashier := self createCashier.
	creditCard := self validCreditCard.
	cashier checkoutOf: cartWithOneBook payingWith: creditCard.
	self deny: (salesBook isEmpty ).! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'support' stamp: 'Simon 10/31/2022 20:37:54'!
invalidExpirationDate

	^ (FixedGregorianDate today previous: GregorianMonth oneMonth) monthOfYear.! !

!CreditCardTest methodsFor: 'support' stamp: 'Simon 10/31/2022 20:11:27'!
validExpirationDate

	^FixedGregorianDate today monthOfYear.! !


!CreditCardTest methodsFor: 'tests' stamp: 'Simon 10/31/2022 21:16:21'!
test01CannotCreateCreditCardWithInvalidOwner
	
	
	self should: [CreditCard with: 1 of: '     ' thatExpiresIn: self validExpirationDate.]
	 raise:  Error  withMessageText: CreditCard invalidOwnerErrorDescription.
	
	self should: [CreditCard with: 1 of: 'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm' thatExpiresIn: self validExpirationDate.]
	 raise:  Error  withMessageText: CreditCard invalidOwnerErrorDescription.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Simon 10/31/2022 21:16:13'!
test02isExpiredACreditCardWithInvalidExpirationDate
	| creditCard |
	creditCard:= CreditCard with: 1 of: 'Harry Potter' thatExpiresIn: self invalidExpirationDate.
	
	self assert: (creditCard isExpiredOn: self validExpirationDate) equals: true.! !

!CreditCardTest methodsFor: 'tests' stamp: 'Simon 10/31/2022 21:15:47'!
test03isNotExpiredACreditCardWithValidExpirationDate
	| creditCard |
	creditCard:= CreditCard with: 1 of: 'Harry Potter' thatExpiresIn: self validExpirationDate.
	
	self assert: (creditCard isExpiredOn: self validExpirationDate) equals: false.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'Simon 10/31/2022 19:00:14'!
invalidPriceErrorMesage
	
	^'Price list cannot have negative prices.'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'Simon 10/31/2022 18:54:30'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [self error: self invalidItemErrorMessage] ! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'Simon 10/31/2022 19:06:07'!
raiseErrorIfCatalogHasNegativePrices

	catalog valuesDo: [:price | (price < 0  ) ifTrue: [self error: self invalidPriceErrorMesage ] ].! !


!Cart methodsFor: 'initialization' stamp: 'Simon 10/31/2022 18:56:49'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	self raiseErrorIfCatalogHasNegativePrices.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'Simon 10/31/2022 19:18:03'!
totalPrice
	| sum |
	sum := 0 * peso.
	items withOccurrencesDo: [:item :quantity | sum:= sum + ((catalog at: item) * quantity) ].
	^sum.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'Simon 10/31/2022 18:38:03'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProccesorDouble merchantProccesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'pricing' stamp: 'Simon 10/31/2022 18:49:33'!
priceOf: aCart
	self raiseErrorIfCartIsEmpty: aCart.
	^aCart totalPrice.
	! !

!Cashier methodsFor: 'pricing' stamp: 'Simon 10/31/2022 18:32:34'!
raiseErrorIfCartIsEmpty: aCart

	^ (aCart isEmpty) ifTrue: [^self error: self class invalidEmptyCartErrorMessage.]! !


!Cashier methodsFor: 'initialize' stamp: 's 11/1/2022 18:06:51'!
initializeWithSalesBook: aSalesBook andMerchantProcessor: aMerchantProccesor 
	salesBook := aSalesBook.
	merchantProccesor := aMerchantProccesor.! !


!Cashier methodsFor: 'checkout' stamp: 's 11/1/2022 18:08:03'!
checkoutOf: aCart payingWith: aCreditCard 
	(aCart isEmpty ) ifTrue:[self error: self class invalidEmptyCartErrorMessage .].
	(aCreditCard isExpiredOn: 	FixedGregorianDate today) ifTrue:[self error: self class expiredCardErrorDescription .].
	merchantProccesor debit: (aCart totalPrice ) from: aCreditCard.
	salesBook add: aCart .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'Simon 10/31/2022 21:42:46'!
expiredCardErrorDescription
	'Expired card'.! !

!Cashier class methodsFor: 'errors' stamp: 'Simon 10/31/2022 18:31:05'!
invalidEmptyCartErrorMessage
	^ 'Cashier cannot price an empty cart.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'Simon 10/31/2022 21:22:55'!
with: aSalesBook 

	^self new initializeWith: aSalesBook .! !

!Cashier class methodsFor: 'instance creation' stamp: 's 11/1/2022 18:07:19'!
withSalesBook: aSalesBook andMerchantProcessor: aMerchantProccesor 
	
	^self new initializeWithSalesBook: aSalesBook andMerchantProcessor: aMerchantProccesor! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialize' stamp: 'Simon 10/31/2022 19:38:46'!
initializeWith: creditCardNumber of: creditCardOwner thatExpiresIn: creditCartExpirationDate
	number := creditCardNumber.
	expirationDate := creditCartExpirationDate.
	owner := creditCardOwner.! !


!CreditCard methodsFor: 'expiration' stamp: 'Simon 10/31/2022 20:57:48'!
isExpiredOn: aDate
	^expirationDate < aDate.! !


!CreditCard methodsFor: 'accesing' stamp: 's 11/1/2022 18:39:17'!
number
	^number.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Simon 10/31/2022 21:12:50'!
with: creditCardNumber of: creditCardOwner thatExpiresIn: creditCartExpirationDate
	(creditCardOwner isLastSeparator | (creditCardOwner size > 30)) ifTrue: [^self error: self invalidOwnerErrorDescription ].
	^self new initializeWith: creditCardNumber of: creditCardOwner thatExpiresIn: creditCartExpirationDate.! !


!CreditCard class methodsFor: 'errors' stamp: 'Simon 10/31/2022 21:05:21'!
invalidOwnerErrorDescription
	^'Owner cannot have more than 30 characters or be empty'.! !


!classDefinition: #MerchantProccesorDouble category: 'TusLibros'!
Object subclass: #MerchantProccesorDouble
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProccesorDouble methodsFor: 'assertions' stamp: 'Simon 11/2/2022 08:21:07'!
assertCardCannotBeExpired: aCreditCard

	^ (aCreditCard isExpiredOn: 	FixedGregorianDate today) ifTrue: [self error: 	'Innecesary use of Merchant Processor']! !

!MerchantProccesorDouble methodsFor: 'assertions' stamp: 'Simon 11/2/2022 08:23:40'!
assertCardHasEnoughCredit: aCreditCard
	(aCreditCard number = CashierTest new insufficientCreditCard number ) ifTrue: [^self error: self class insufficientCreditErrorDescription .]! !

!MerchantProccesorDouble methodsFor: 'assertions' stamp: 'Simon 11/2/2022 08:23:01'!
assertCardIsNotStolen: aCreditCard
	(aCreditCard number = CashierTest new stolenCreditCard number ) ifTrue: [^self error: self class stolenCardErrorDescription.].
	! !


!MerchantProccesorDouble methodsFor: 'creditcard' stamp: 'Simon 11/2/2022 08:23:31'!
debit: anAmount from: aCreditCard 
	
	self assertCardCannotBeExpired: aCreditCard.
	self assertCardIsNotStolen: aCreditCard.
	self assertCardHasEnoughCredit: aCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProccesorDouble class' category: 'TusLibros'!
MerchantProccesorDouble class
	instanceVariableNames: ''!

!MerchantProccesorDouble class methodsFor: 'errors' stamp: 's 11/1/2022 18:26:56'!
insufficientCreditErrorDescription
	^'Cannot debit from a card with insufficient credit'.! !

!MerchantProccesorDouble class methodsFor: 'errors' stamp: 's 11/1/2022 18:15:54'!
stolenCardErrorDescription
	^'Cannot Debit: Stolen Card'.! !
