!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio1 p2 account1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 01:48:52'!
test01EmptyPortfolioHasZeroBalanceWhenCreated

	
	^ self assertPortfolio1BalanceIs: 0 . 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:13:58'!
test02PortfolioBalanceIncreasesWithOneAccount

	
	self deposit100IntoAccount1.
	
	self addAccount1ToPortfolio1.
	self assertPortfolio1BalanceIs: 100. 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:03:17'!
test03PortfolioBalanceWithMultipleAccounts

	|  account2 account3 |
	
	
	Withdraw register: 100 on: account1.
	
	account2 := ReceptiveAccount  new.
	Withdraw register: 100 on: account2.
	
	account3 := ReceptiveAccount  new.
	Deposit register: 180 on: account3.
	
	self addAccount1toPortfolio1And: account3 And: account2.
		
	self assertPortfolio1BalanceIs: -20. 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:31:56'!
test04PortfolioBalanceWithMultipleAccountsAndPortfolio

	|  portfolio2  account2 account3 |
	
	
	self deposit100IntoAccount1.
	
	account2 := ReceptiveAccount  new.
	Withdraw register: 100 on: account2.
	
	
	account3 := ReceptiveAccount  new.
	Deposit register: 180 on: account3.
	
	portfolio2 := Portfolio with: account2 .
	portfolio2 add: account3.
	
	self addAccount1ToPortfolio1And: portfolio2.
	
	self assertPortfolio1BalanceIs: 180 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:13:58'!
test05PortfolioHasRegisteredSomeTransaction

	|  deposit |
	
	
	deposit := self deposit100IntoAccount1.
	
	
	self addAccount1ToPortfolio1.
	
	self assert: (portfolio1 hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:13:58'!
test06PortfolioHasNotRegisteredSomeTransaction

	| deposit |
	
	self deposit100IntoAccount1.
	
	self addAccount1ToPortfolio1.
	
	deposit:= Deposit for: 100.
	self deny: (portfolio1 hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:13:01'!
test07PortfolioCannotAddAccountTwoTimesAtSameLevel

	self addAccount1ToPortfolio1.

	
	self should: 	[self addAccount1ToPortfolio1.] 
	raise: Error
	withMessageText: Portfolio cannotAddAssetErrorMessage .! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:16:48'!
test08PortfolioCannotAddAccountIfAlreadyPresentInAnAddedPortfolio

	|  portfolio2 |
	
	self deposit100IntoAccount1.
	self addAccount1ToPortfolio1.
	
	portfolio2 := Portfolio new.
	portfolio2 add: portfolio1.

	
	self should: 	[portfolio2 add: account1.] 
	raise: Error
	withMessageText: Portfolio cannotAddAssetErrorMessage .! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:28:40'!
test09PortfolioCannotAddAccountIfAlreadyPresentInAParentPortfolio

	|  portfolio2 |
	
	self deposit100IntoAccount1.
	
	portfolio2 := Portfolio with: account1.
	portfolio2 add: portfolio1.
	
	self should: 	[self addAccount1ToPortfolio1.] 
	raise: Error
	withMessageText: Portfolio cannotAddAssetErrorMessage .! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:26:40'!
test10PortfolioCannotAddPortfolioIfAlreadyPresentInAnAncestorPortfolio

	|  portfolio2 portfolio3 portfolio4 portfolio5 portfolio6 |
	
	
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	portfolio2 := Portfolio with: portfolio5 .
	portfolio3 := Portfolio with: portfolio4 .
	portfolio6:= Portfolio with: portfolio3.
	portfolio1 add: portfolio3.
	portfolio1 add: portfolio2.
	
	
	self should: 	[portfolio4 add: portfolio5.] 
	raise: Error
	withMessageText: Portfolio cannotAddAssetErrorMessage .! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/14/2022 23:43:43'!
test11EmptyPortfolioHasEmptyTransactions

	
	self assert:  portfolio1 transactions isEmpty . 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:13:57'!
test12PortfolioHasTheTransactionsOfDirectAccount

	| deposit|
	
	
	deposit := self deposit100IntoAccount1.
	
	self addAccount1ToPortfolio1.
		
	self assert: (portfolio1 transactions) equals: (OrderedCollection with: deposit). 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 02:21:42'!
test13PortfolioHasTransactionsOfIndirectAccount

	| deposit portfolio2 |
	
	
	
	deposit := self deposit100IntoAccount1.
	portfolio2 := Portfolio with: portfolio1 .
	self addAccount1ToPortfolio1.
		
	self assert: (portfolio2 transactions) equals: (OrderedCollection with: deposit). 
! !

!PortfolioTest methodsFor: 'tests' stamp: 's 10/15/2022 13:04:14'!
test14PortfolioHasTheLatestTransactionsOfDifferentAccounts

	| portfolio2 otheraccount otherdeposit deposit|
	
	portfolio2 := Portfolio new.
	
	portfolio2 add: portfolio1.
	deposit := self deposit100IntoAccount1.
	self addAccount1ToPortfolio1.
	
	otheraccount := ReceptiveAccount  new.
	portfolio2 add: otheraccount.
	otherdeposit := Deposit register: 50 on: otheraccount.
	
	self assert: (portfolio2 transactions) equals: (OrderedCollection with: deposit with:otherdeposit ). 
! !


!PortfolioTest methodsFor: 'assertions' stamp: 's 10/15/2022 01:37:57'!
assertPortfolio1BalanceIs: value

	^ self assert: value equals: portfolio1 balance! !


!PortfolioTest methodsFor: 'common actions' stamp: 's 10/15/2022 01:52:28'!
addAccount1ToPortfolio1

	portfolio1 add: account1.
	^portfolio1 .! !

!PortfolioTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:03:50'!
addAccount1ToPortfolio1And: account2

	^ portfolio1 add: account1 ; 
			add: account2! !

!PortfolioTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:03:17'!
addAccount1toPortfolio1And: account3 And: account2

	^ portfolio1 add: account1; 
			add: account2;
			add: account3! !

!PortfolioTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:13:57'!
deposit100IntoAccount1

	^ Deposit register: 100 on: account1! !


!PortfolioTest methodsFor: 'setUp' stamp: 's 10/15/2022 02:19:49'!
setUp
	
	account1 := ReceptiveAccount  new.
	portfolio1 := Portfolio new.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/14/2022 23:10:54'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assertAccountBalanceIs: 0.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 02:43:32'!
test02DepositIncreasesBalanceOnTransactionValue 

	
	self deposit100IntoAccount.
		
	self assertAccountBalanceIs: 100.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 02:44:57'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	self deposit100IntoAccount.
	self withdraw50FromAccount .
		
	self assertAccountBalanceIs: 50.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 02:44:57'!
test04WithdrawValueMustBePositive 
	
	self assert: 50 equals: (self withdraw50FromAccount) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 02:44:57'!
test05ReceptiveAccountKnowsRegisteredTransactions 

		
	self assert: (account hasRegistered: self deposit100IntoAccount).
	self assert: (account hasRegistered: self withdraw50FromAccount).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 12:59:42'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 's 10/15/2022 02:43:33'!
test07AccountKnowsItsTransactions 

	| deposit1 |
	
	account := ReceptiveAccount new.
	
	deposit1 := self deposit100IntoAccount.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit1).
! !


!ReceptiveAccountTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:44:32'!
accountWithdraw: withdrawValue

	^ Withdraw register: withdrawValue on: account! !

!ReceptiveAccountTest methodsFor: 'common actions' stamp: 's 10/14/2022 23:09:56'!
assertAccountBalanceIs: value

	^ self assert: value equals: account balance! !

!ReceptiveAccountTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:43:32'!
deposit100IntoAccount

	^ Deposit register: 100 on: account! !

!ReceptiveAccountTest methodsFor: 'common actions' stamp: 's 10/15/2022 02:44:57'!
withdraw50FromAccount

	^ self accountWithdraw: 50! !


!ReceptiveAccountTest methodsFor: 'setup' stamp: 's 10/14/2022 23:03:43'!
setUp

	 
	
	account := ReceptiveAccount new.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 's 10/14/2022 23:34:06'!
value

	^value.! !


!AccountTransaction methodsFor: 'account actions' stamp: 'E 10/6/2022 20:52:09'!
addTransactionMarketValue: aMarketValue
	^self subclassResponsibility.! !


!AccountTransaction methodsFor: 'initialization' stamp: 's 10/15/2022 02:35:01'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 's 10/14/2022 22:33:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 's 10/15/2022 00:29:29'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account addTransaction: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'account actions' stamp: 's 10/14/2022 23:37:49'!
addTransactionMarketValue: aMarketValue
	^aMarketValue + self value.! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'account actions' stamp: 's 10/14/2022 23:37:57'!
addTransactionMarketValue: aMarketValue
	^aMarketValue - self value.! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'parents transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'accesing private' stamp: 's 10/15/2022 02:37:00'!
hasAsset: anAsset
	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'accesing private' stamp: 's 10/15/2022 00:31:31'!
toBeAddedTo: aParentPortfolio
	parents add: aParentPortfolio .! !


!FinancialAsset methodsFor: 'initialization' stamp: 's 10/15/2022 00:06:42'!
initialize
	parents := OrderedCollection new.
	transactions := OrderedCollection new.! !


!FinancialAsset methodsFor: 'accessing' stamp: 's 10/14/2022 14:19:50'!
balance

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'accessing' stamp: 's 10/14/2022 14:20:36'!
hasRegistered: aTransaction

	self subclassResponsibility .! !

!FinancialAsset methodsFor: 'accessing' stamp: 's 10/15/2022 12:54:57'!
transactions 

	^ transactions.! !



!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 's 10/14/2022 14:53:18'!
initialize
	super initialize.
	assets:= OrderedCollection new.! !



!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 00:57:53'!
addTransactions: someTransactions

	self addTransactionsToAllTheAssetsIBelong: someTransactions.
	transactions addAll: someTransactions.
! !

!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 00:57:53'!
addTransactionsToAllTheAssetsIBelong: someTransactions

	^ parents do:[:parent | parent addTransactions: someTransactions]! !

!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 01:29:29'!
canAdd: anAsset

	^( self isNotOneOfMyAssets: anAsset ) and:[
	 self canTheAssetsIBelongToAdd: anAsset].! !

!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 01:24:50'!
canTheAssetsIBelongToAdd: anAsset

	^ parents allSatisfy: [:parent | parent canAdd: anAsset ]! !

!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 01:14:40'!
raiseErrorIfCannotAdd: anAsset

	^ (self canAdd: anAsset) ifFalse: [self error: self class cannotAddAssetErrorMessage ]! !

!Portfolio methodsFor: 'adding private' stamp: 's 10/15/2022 01:00:04'!
safeAdd: anAsset

	anAsset toBeAddedTo: self.
	assets add: anAsset! !


!Portfolio methodsFor: 'adding' stamp: 's 10/15/2022 01:06:18'!
add: anAsset
	self raiseErrorIfCannotAdd: anAsset.
	self safeAdd: anAsset.
	self addTransactions: (anAsset transactions).! !


!Portfolio methodsFor: 'accessing private' stamp: 's 10/15/2022 01:01:57'!
hasAsset: anAsset

	^anAsset = self or: [self oneOfMyAssetsHas: anAsset].! !

!Portfolio methodsFor: 'accessing private' stamp: 's 10/15/2022 01:29:29'!
isNotOneOfMyAssets: anAsset

	^(( self hasAsset: anAsset ) not ).! !

!Portfolio methodsFor: 'accessing private' stamp: 's 10/15/2022 01:02:38'!
oneOfMyAssetsHas: anAsset

	^ assets anySatisfy: [ :asset | asset hasAsset: anAsset ]! !


!Portfolio methodsFor: 'accesing' stamp: 's 10/14/2022 14:21:56'!
balance
	^ assets sum: [:each | each balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'accesing' stamp: 's 10/14/2022 14:23:31'!
hasRegistered: aTransaction 
	^assets anySatisfy: [:asset | asset hasRegistered: aTransaction ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 's 10/14/2022 15:22:34'!
cannotAddAssetErrorMessage
	^'Cannot add duplicated asset'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 's 10/15/2022 02:23:46'!
with: anAsset
	|portfolio|
	portfolio := self new.
	portfolio add: anAsset .
	^portfolio .! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'adding private' stamp: 's 10/15/2022 00:56:17'!
addTransaction: aTransaction
	self addTransactionToAllTheAssetsIBelong: aTransaction.
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 's 10/15/2022 00:56:17'!
addTransactionToAllTheAssetsIBelong: aTransaction

	^ parents do:[:parent | parent addTransactions: (OrderedCollection with: aTransaction)]! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 's 10/14/2022 14:43:36'!
hasAsset: anAsset

	^anAsset = self .! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'E 10/6/2022 20:51:54'!
balance

	^transactions inject: 0 into: [:acc :transaction |  transaction addTransactionMarketValue: acc.].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
