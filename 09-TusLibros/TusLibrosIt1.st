!classDefinition: #CartTest category: 'TusLibrosIt1'!
TestCase subclass: #CartTest
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosIt1'!

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 20:36:59'!
test01newCartIsEmpty
	| cart |
	cart := Cart new.
	
	self assert: cart isEmpty equals: true.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:50:51'!
test02cartWithOneAddedBookIsNotEmpty
	| cart bookISBN |
	cart := Cart withCatalog: catalog.
	bookISBN := 1.
	cart add: bookISBN.
	
	self assert: cart isEmpty equals: false.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:51:05'!
test03cartWithOneBookHasOnlyOneBook
	| cart bookISBN |
	cart := Cart withCatalog: catalog.
	bookISBN := 1.
	cart add: bookISBN.
	
	self assert: (cart quantityOf:  bookISBN) equals: 1.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:51:13'!
test04cartWithManyBookHasRegisteredTheirQuantites
	| cart bookISBN1 bookISBN2 |
	cart := Cart withCatalog: catalog.
	bookISBN1 := 1.
	bookISBN2 := 2.
	cart add: 5 times: bookISBN1.
	cart add: 4 times: bookISBN2.
	
	self assert: (cart quantityOf:  bookISBN1) equals: 5.
	self assert: (cart quantityOf:  bookISBN2) equals: 4.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:51:24'!
test05cartWithManyBooksKnowsTheirISBN
	| cart bookISBN1 bookISBN2 bookISBN3 |
	cart := Cart withCatalog: catalog.
	bookISBN1 := 1.
	bookISBN2 := 2.
	bookISBN3 := 3.
	cart add: 5 times: bookISBN1.
	cart add: 4 times: bookISBN2.
	cart add: 2 times: bookISBN3.
	
	self assert: (cart content ) equals: {1. 2. 3} asSet.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:37:20'!
test06cartCanNotAddInvalidISBN
	| cart bookISBN |
	cart := Cart withCatalog: catalog.
	bookISBN := 7.
	
	self  should: [cart add: bookISBN.] 
		raise:  Error
		withMessageText: cart class invalidBookerrorDescription.

	self assert: cart isEmpty equals: true.! !

!CartTest methodsFor: 'tests' stamp: 'Simon 10/27/2022 21:37:26'!
test07cartCanNotAddANonPositiveAmountOfBooks
	| cart bookISBN |
	cart := Cart withCatalog: catalog.
	bookISBN := 4.
	
	self  should: [cart add: 0 times: bookISBN.] 
		raise:  Error
		withMessageText: cart class invalidAmountErrorDescription.

	self assert: cart isEmpty equals: true.! !


!CartTest methodsFor: 'setUp' stamp: 'Simon 10/27/2022 20:56:04'!
setUp
	catalog := {1. 2. 3. 4. 5. 6.} asOrderedCollection ! !


!classDefinition: #Cart category: 'TusLibrosIt1'!
Object subclass: #Cart
	instanceVariableNames: 'bookCatalog contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosIt1'!

!Cart methodsFor: 'accesing' stamp: 'Simon 10/27/2022 21:40:52'!
content
	^contents asSet.! !

!Cart methodsFor: 'accesing' stamp: 'Simon 10/27/2022 21:24:07'!
isEmpty
	^contents isEmpty.! !

!Cart methodsFor: 'accesing' stamp: 'Simon 10/27/2022 21:32:48'!
quantityOf: bookISBN 
	^contents occurrencesOf: bookISBN.! !


!Cart methodsFor: 'initialize' stamp: 'Simon 10/27/2022 21:31:00'!
initialize
	contents := Bag new.! !

!Cart methodsFor: 'initialize' stamp: 'Simon 10/27/2022 20:58:18'!
initializeWithCatalog: aBookCatalog 
	bookCatalog := aBookCatalog.! !


!Cart methodsFor: 'adding' stamp: 'Simon 10/27/2022 21:23:51'!
add: anISBN 
	self add: 1 times: anISBN.
	! !

!Cart methodsFor: 'adding' stamp: 'Simon 10/27/2022 21:34:19'!
add: aQuantity times: anISBN 
	self raiseErrorIfNotInCatalog: anISBN.
	self raiseErrorIfQuantityNotPositive: aQuantity.
	contents add: anISBN withOccurrences: aQuantity.! !


!Cart methodsFor: 'exceptions' stamp: 'Simon 10/27/2022 21:10:53'!
raiseErrorIfNotInCatalog: anISBN
	(bookCatalog includes: anISBN ) ifFalse: [^self error: self class invalidBookerrorDescription].! !

!Cart methodsFor: 'exceptions' stamp: 'Simon 10/27/2022 21:36:17'!
raiseErrorIfQuantityNotPositive: aQuantity.
	(aQuantity < 1) ifTrue: [^self error: self class invalidAmountErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibrosIt1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'Simon 10/27/2022 20:58:05'!
withCatalog: aBookCatalog 
	^self new initializeWithCatalog: aBookCatalog. ! !


!Cart class methodsFor: 'errors' stamp: 'Simon 10/27/2022 21:33:42'!
invalidAmountErrorDescription
	^'Cannot add a book a negative amount of times'! !

!Cart class methodsFor: 'errors' stamp: 'Simon 10/27/2022 21:02:48'!
invalidBookerrorDescription
	^'Cannot add book that is not in catalog.'! !
