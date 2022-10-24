!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'accountWithHundredDeposit hundredDeposit accountWithFiftyWithdraw fiftyWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:51:12'!
setUp

	accountWithHundredDeposit := ReceptiveAccount new.
	hundredDeposit := Deposit register: 100 on: accountWithHundredDeposit.
	
	accountWithFiftyWithdraw := ReceptiveAccount new.
	fiftyWithdraw := Withdraw register: 100 on: accountWithHundredDeposit.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:48:14'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| portfolio |
	
	portfolio := Portfolio with: accountWithHundredDeposit.
	
	self assert: accountWithHundredDeposit balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:51:12'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	|simplePortfolio composedPortofolio |
	
	
	simplePortfolio := Portfolio with: accountWithHundredDeposit.
	
	composedPortofolio := Portfolio with: simplePortfolio with: accountWithFiftyWithdraw.
	
	self assert: (accountWithFiftyWithdraw balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:48:14'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| portfolio |
	
	portfolio := Portfolio with: accountWithHundredDeposit.
	
	self assert: (portfolio hasRegistered: hundredDeposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:51:12'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolio composedPortfolio |
	
	simplePortfolio := Portfolio with: accountWithHundredDeposit.
	

	composedPortfolio := Portfolio with: simplePortfolio with: accountWithFiftyWithdraw.
	
	self assert: (composedPortfolio hasRegistered: hundredDeposit).
	self assert: (composedPortfolio hasRegistered: fiftyWithdraw )! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:51:12'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: accountWithHundredDeposit with: accountWithFiftyWithdraw .
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: hundredDeposit).
	self assert: (portfolioTransactions includes: fiftyWithdraw )! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:51:12'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolio composedPortfolio composedPortfolioTransactions |
	
	simplePortfolio := Portfolio with: accountWithHundredDeposit .
	
	composedPortfolio := Portfolio with: simplePortfolio with: accountWithFiftyWithdraw .
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: hundredDeposit ).
	self assert: (composedPortfolioTransactions includes: fiftyWithdraw )! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:52:02'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| portfolio |
	
	portfolio := Portfolio with: accountWithHundredDeposit.
	
	self 
		should: [ portfolio add: accountWithHundredDeposit ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: accountWithHundredDeposit) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:53:01'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| simplePortfolio composedPortfolio |
	
	simplePortfolio := Portfolio with: accountWithHundredDeposit.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: accountWithHundredDeposit ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:53:20'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio with: accountWithHundredDeposit.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: accountWithHundredDeposit) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:54:14'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| simplePortfolio composedPortfolio |
	
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: accountWithHundredDeposit.
	
	self 
		should: [ simplePortfolio add: accountWithHundredDeposit ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'E 10/20/2022 20:27:31'!
test16PortfolioKnowsItsName

	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio de hijos'.

	self assert: portfolio name equals: 'Portfolio de hijos'.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'emptyAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:32:33'!
setUp
	emptyAccount := ReceptiveAccount new.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:32:15'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	

	self assert: 0 equals: emptyAccount balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:33:00'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:30:32'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account1 deposit withdraw |
	
	account1 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account1.
		
	self assert: (account1 hasRegistered: deposit).
	self assert: (account1 hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:33:13'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (emptyAccount hasRegistered: deposit).
	self deny: (emptyAccount hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:29:46'!
test07AccountKnowsItsTransactions 

	| account1 deposit |
	
	account1 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'E 10/23/2022 22:29:32'!
test08AccountKnowsItsName

	| namedAccount |
	
	namedAccount := ReceptiveAccount named: 'Cuenta de Juan'.

	self assert: namedAccount name equals: 'Cuenta de Juan'.
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test01AccountSummaryEmptyAccount
	| account accountSummary|
	account _ ReceptiveAccount new.
	accountSummary _ AccountSummary  of: account.
	self assert: accountSummary report equals: (OrderedCollection with: 'Balance = 0').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test02AccountSummaryOfAnAccountWithADeposit
	| account accountSummary |
	account _ ReceptiveAccount new.
	Deposit register: 100 on: account .
	accountSummary _ AccountSummary  of: account.
	self assert: accountSummary report equals: (OrderedCollection with: 'Depósito por 100.' with: 'Balance = 100').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test03AccountSummaryOfAnAccountWithAWithdraw
	| account accountSummary |
	account _ ReceptiveAccount new.
	Withdraw register: 50 on: account .
	accountSummary _ AccountSummary  of: account.
	self assert: accountSummary report equals: (OrderedCollection with: 'Extracción por 50.' with: 'Balance = -50').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test04AccountSummaryOfAnAccountWithAnInwardTransfer
	| account otheraccount accountSummary |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Transfer register: 30 from: otheraccount  to: account .
	accountSummary _ AccountSummary  of: account.
	self assert:  accountSummary  report equals: (OrderedCollection with: 'Entrada por transferencia de 30.' with: 'Balance = 30').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test05AccountSummaryOfAnAccountWithAnOutwardTransfer
	| account otheraccount accountSummary |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Transfer register: 20 from: account  to: otheraccount .
	accountSummary _ AccountSummary  of: account.
	self assert: accountSummary report equals: (OrderedCollection with: 'Salida por transferencia de 20.' with: 'Balance = -20').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test06AccountSummaryOfAnAccountWithMultipleTransactions
	| account otheraccount accountSummary |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Deposit register: 100 on: account .
	Transfer register: 20 from: account  to: otheraccount .
	accountSummary _ AccountSummary  of: account.
	
	self assert: accountSummary report equals: (OrderedCollection with: 'Depósito por 100.' with: 'Salida por transferencia de 20.' with: 'Balance = 80').! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test07AccountSummaryOfAPortfolioWithMultipleTransactions
	| account otheraccount portfolio accountSummary |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 10 on: otheraccount.
	Transfer register: 20 from: account  to: otheraccount.
	portfolio := Portfolio new.
	portfolio add: account; add: otheraccount.
	
	accountSummary _ AccountSummary  of: portfolio.
	
	self assert: accountSummary report equals: (OrderedCollection with: 'Depósito por 100.' with: 'Salida por transferencia de 20.'
										   with: 'Extracción por 10.' with: 'Entrada por transferencia de 20.' with: 'Balance = 90').

	! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:19:55'!
test08AccountSummaryOfAPortfolioWithMultipleTransactionsAndAPortfolioInside
	| account otheraccount portfolio portfolio2 accountSummary |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 10 on: otheraccount.
	Transfer register: 20 from: account  to: otheraccount.
	portfolio := Portfolio new.
	portfolio2 := Portfolio new add: otheraccount ;yourself.
	portfolio add: account; add: portfolio2.
	
	accountSummary _ AccountSummary  of: portfolio .
	
	self assert: accountSummary report equals: (OrderedCollection with: 'Depósito por 100.' with: 'Salida por transferencia de 20.'
										   with: 'Extracción por 10.' with: 'Entrada por transferencia de 20.' with: 'Balance = 90').

	! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:29:59'!
test09TransferNetOfAccountWithOutwardTransfer
	| account otheraccount transferNet |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Transfer register: 20 from: account  to: otheraccount.
	transferNet := TransferNet of: account.
	self assert: transferNet report equals: -20.

	! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:32:51'!
test10TransferNetOfAccountWithAnInwardTransfer
	| account otheraccount transferNet |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	Transfer register: 20 from: account  to: otheraccount.
	transferNet := TransferNet of: otheraccount.
	self assert: transferNet report equals: 20.

	! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 22:57:42'!
test11TransferNetOfAccountWithMultipleTransactions
	| account otheraccount transferNet |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	
	Transfer register: 20 from: account  to: otheraccount.
	Transfer register: 40 from: otheraccount  to: account.
	Deposit register: 40 on: otheraccount.
	Withdraw register: 50 on: otheraccount.
	
	transferNet := TransferNet of: otheraccount.
	self assert: transferNet report equals: -20.

	! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 22:56:33'!
test12TransferNetOfPortfolioWithOneAccount
	| account otheraccount portfolio1 transferNet |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	
	Transfer register: 20 from: account  to: otheraccount.
	
	portfolio1 := Portfolio new add: account; yourself.
	transferNet := TransferNet of: portfolio1 .
	self assert: transferNet report equals: -20.

	! !

!ReportTest methodsFor: 'testing' stamp: 's 10/23/2022 19:34:37'!
test13TransferNetOfPortfolioWithMultiplesAccountsAndPortfolio
	| account otheraccount portfolio1 portfolio2 transferNet |
	account _ ReceptiveAccount new.
	otheraccount _ ReceptiveAccount new.
	
	Transfer register: 20 from: account  to: otheraccount.
	Transfer register: 30 from: otheraccount  to: account.
	Deposit register: 40 on: otheraccount.
	Withdraw register: 40 on: account.
	
	portfolio1 := Portfolio new add: account; yourself.
	portfolio2 := Portfolio new add: otheraccount; yourself.
	
	portfolio1 add: portfolio2.
	transferNet := TransferNet of: portfolio1 .
	self assert: transferNet report equals: 0.

	! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 22:57:50'!
test14PortfolioTreeOfEmptyPortfolio
	| portfolio tree |
	
	portfolio _ Portfolio named: 'Hola'.
	tree _ PortfolioTree  of: portfolio.
	
	self assert: tree report equals: (OrderedCollection with: 'Hola').! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 22:57:56'!
test15PortfolioTreeOfPortfolioWithAccounts
	| portfolio tree account otheraccount |
	portfolio _ Portfolio named: 'Hola'.
	account _ ReceptiveAccount named: 'CuentaB'.
	otheraccount _ ReceptiveAccount named: 'CuentaA'.
	
	portfolio add: account .
	portfolio add:otheraccount .
	tree _ PortfolioTree  of: portfolio.
	
	self assert: (tree report) equals: (OrderedCollection with: 'Hola' with: (OrderedCollection with:'CuentaB'with:'CuentaA')).! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 22:58:01'!
test16PortfolioTreeOfPortfolioWithPortfolios
	| portfolio tree account otheraccount portfolio2 |
	portfolio _ Portfolio named: 'Portfolio1'.
	portfolio2 _ Portfolio named: 'Portfolio2'.
	account _ ReceptiveAccount named: 'CuentaB'.
	otheraccount _ ReceptiveAccount named: 'CuentaA'.
	
	portfolio add: portfolio2.
	portfolio2 add: account .
	portfolio add:otheraccount .
	tree _ PortfolioTree  of: portfolio.
	
	self assert: (tree report) equals: (OrderedCollection with: 'Portfolio1' with: (OrderedCollection with:( OrderedCollection with: 'Portfolio2' with:( OrderedCollection with:'CuentaB'))  with:'CuentaA')).! !

!ReportTest methodsFor: 'testing' stamp: 'E 10/23/2022 21:34:56'!
test17SpecialPortfolioTreeOfPortfolioWithPortfolios
	| portfolio tree account otheraccount |
	portfolio _ Portfolio named: 'Portfolio1'.
	
	account _ ReceptiveAccount named: 'CuentaB'.
	otheraccount _ ReceptiveAccount named: 'CuentaA'.
	Deposit register: 300 on: account.
	Withdraw register: 100 on: otheraccount.
	Transfer register: 10 from: account to: otheraccount.
		
	portfolio add: account .
	portfolio add:otheraccount .
	tree _ SpecialPortfolioTree  of: portfolio.
	
	self assert: (tree report) equals: (OrderedCollection with: 'Portfolio1' with:  (OrderedCollection with: (OrderedCollection with: 'CuentaB' with: ( OrderedCollection with: 'Depósito por 300.' with: 'Salida por transferencia de 10.' with: 'Balance = 290' ) ) with:  ( OrderedCollection with: 'CuentaA' with: ( OrderedCollection with: 'Extracción por 100.' with: 'Entrada por transferencia de 10.' with:  'Balance = -90' ) ) ) with: 'Balance = 200'). 
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'extractsAccount depositAccount transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:05:27'!
setUp
	extractsAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.

	Deposit register: 100 on: extractsAccount.
	
	transfer := Transfer register: 30 from: extractsAccount to: depositAccount.! !

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:01:59'!
test01AccountThatTransfersLosesTransferedMoney

	self assert: (extractsAccount balance) equals: 70.
	
! !

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:03:30'!
test02AccountThatReceivesEarnsMoney

	self assert: (depositAccount balance) equals: 30.
	
! !

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:05:55'!
test03AccountThatTransfersHasRegisteredWithdrawal

	self assert: (extractsAccount hasRegistered: transfer withdrawLeg)
	
! !

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:06:14'!
test04AccountThatReceivesHasRegisteredDeposit
	
	self assert: (depositAccount hasRegistered: transfer depositLeg)
	
! !

!TransferTest methodsFor: 'tests' stamp: 'E 10/23/2022 23:06:22'!
test05ALegKnowsTheOtherLeg
	
	self assert: transfer depositLeg otherLeg equals: transfer withdrawLeg.
	self assert: transfer withdrawLeg otherLeg equals: transfer depositLeg
	
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'E 10/20/2022 20:28:36'!
name
	^name.! !


!Account methodsFor: 'initialize' stamp: 'E 10/20/2022 20:32:14'!
initializeNamed: aName
	self subclassResponsibility.! !


!Account methodsFor: 'reporting' stamp: 'E 10/23/2022 23:27:57'!
toBeReportedTo: aReport
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'E 10/20/2022 20:29:03'!
named: aName 
	^self new initializeNamed: aName. ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 's 10/23/2022 20:36:24'!
accounts
	^accounts .! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'E 10/20/2022 20:32:03'!
initializeNamed: aName
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reporting' stamp: 'E 10/23/2022 23:27:33'!
toBeReportedTo: aReport
	^aReport reportForPortfolio: self.
									
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'E 10/20/2022 20:33:32'!
initializeNamed: aName

	super initialize.
	name := aName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'E 10/23/2022 23:27:44'!
toBeReportedTo: aReport

	^aReport reportForReceptiveAccount: self .! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reporting' stamp: 'E 10/23/2022 23:28:15'!
toBeReportedTo: aReport 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!
!Deposit commentStamp: '<historical>' prior: 0!
{1. 2 .3} do: [:ea | 1] separatedBy: [:ea| 2]!


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reporting' stamp: 'E 10/23/2022 23:28:24'!
toBeReportedTo: aReport 
	^aReport reportForADeposit: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #DepositLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'accessing' stamp: 'E 10/18/2022 17:57:15'!
otherLeg
	^transfer withdrawLeg.! !


!DepositLeg methodsFor: 'initialization' stamp: 'E 10/18/2022 17:19:26'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!DepositLeg methodsFor: 'balance' stamp: 'E 10/18/2022 17:42:40'!
affectBalance: aBalance

	^aBalance + self value.! !


!DepositLeg methodsFor: 'value' stamp: 'E 10/18/2022 17:42:31'!
value

	^ transfer value.! !


!DepositLeg methodsFor: 'as yet unclassified' stamp: 'E 10/23/2022 23:28:30'!
toBeReportedTo: aReport 
		^aReport reportForADepositLeg: self value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'Portfolio-Solucion'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 17:43:39'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reporting' stamp: 'E 10/23/2022 23:28:38'!
toBeReportedTo: aReport 
	^aReport reportForAWithdraw: self value. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
AccountTransaction subclass: #WithdrawLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'initialization' stamp: 'E 10/18/2022 17:19:59'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!WithdrawLeg methodsFor: 'balance' stamp: 'E 10/18/2022 17:25:09'!
affectBalance: aBalance

	^aBalance - self value.! !


!WithdrawLeg methodsFor: 'accessing' stamp: 'E 10/18/2022 17:57:50'!
otherLeg
	^transfer depositLeg.! !


!WithdrawLeg methodsFor: 'value' stamp: 'E 10/18/2022 17:25:26'!
value

	^ transfer value.! !


!WithdrawLeg methodsFor: 'reporting' stamp: 'E 10/23/2022 23:28:43'!
toBeReportedTo: aReport 
	^aReport reportForAWithdrawLeg: self value. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: 'Portfolio-Solucion'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 17:23:23'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialize' stamp: 's 10/23/2022 19:28:46'!
initializeOf: anAccount 
	
	account := anAccount.! !


!Report methodsFor: 'evaluating' stamp: 's 10/23/2022 19:36:28'!
report
	self subclassResponsibility .! !


!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:37:06'!
reportForADeposit: aValue
	self subclassResponsibility .! !

!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:37:58'!
reportForADepositLeg: aValue 
	self subclassResponsibility .! !

!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:38:10'!
reportForAWithdraw: aValue
	self subclassResponsibility .! !

!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:38:18'!
reportForAWithdrawLeg: aValue 
	self subclassResponsibility .! !

!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:36:52'!
reportForPortfolio: accountsOfPortfolio
	self subclassResponsibility .! !

!Report methodsFor: 'operations -private' stamp: 's 10/23/2022 19:38:31'!
reportForReceptiveAccount: transactionsOfAccount
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 's 10/23/2022 19:27:31'!
of: anAccount 
	
	^self new initializeOf: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'evaluating' stamp: 's 10/23/2022 19:40:21'!
report
	| summary|
	summary _ account toBeReportedTo:self.
	summary add: 'Balance = ' , account balance asString .
	^ summary.
	! !


!AccountSummary methodsFor: 'operations -private' stamp: 's 10/23/2022 19:18:06'!
reportForADeposit: aValue
	^ 'Depósito por ',  aValue asString, '.' .
									
		! !

!AccountSummary methodsFor: 'operations -private' stamp: 's 10/23/2022 19:16:26'!
reportForADepositLeg: aValue 
		^'Entrada por transferencia de ', aValue asString ,'.'.! !

!AccountSummary methodsFor: 'operations -private' stamp: 's 10/23/2022 19:16:51'!
reportForAWithdraw: aValue
	^'Extracción por ', aValue asString ,'.'.! !

!AccountSummary methodsFor: 'operations -private' stamp: 's 10/23/2022 19:17:16'!
reportForAWithdrawLeg: aValue 
	^'Salida por transferencia de ', aValue asString ,'.'.! !

!AccountSummary methodsFor: 'operations -private' stamp: 's 10/23/2022 20:36:55'!
reportForPortfolio: aPortfolio
	^aPortfolio accounts inject: OrderedCollection new into: [ :printed_transactions :accountOfPortfolio | 
				printed_transactions addAll: 
										(accountOfPortfolio toBeReportedTo: self)
										. printed_transactions].
									
		! !

!AccountSummary methodsFor: 'operations -private' stamp: 'E 10/23/2022 23:30:56'!
reportForReceptiveAccount: receptiveAccount

	"Utilizamos el mensaje 'transactions' para no tener que pasar cómo parametro el nombre en el PortfolioTree"
	^ receptiveAccount transactions collect:[ :transaction | transaction  toBeReportedTo: self.]
									
		! !


!classDefinition: #PortfolioTree category: 'Portfolio-Solucion'!
Report subclass: #PortfolioTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTree methodsFor: 'evaluating' stamp: 's 10/23/2022 20:10:08'!
report
	^account toBeReportedTo: self.! !


!PortfolioTree methodsFor: 'operations -private' stamp: 'E 10/23/2022 23:32:16'!
reportForPortfolio: aPortfolio 
	| report |
	
	"Utilizamos el mensaje 'accounts' para no tener que pasar cómo parametro el nombre en el PortfolioTree"
	report _ OrderedCollection with: (aPortfolio name) .
	(aPortfolio accounts) ifNotEmpty: [  report add: ((aPortfolio accounts) collect: [ :accountOfPortfolio | accountOfPortfolio toBeReportedTo: self])].
	^report.! !

!PortfolioTree methodsFor: 'operations -private' stamp: 's 10/23/2022 20:33:11'!
reportForReceptiveAccount: receptiveAccount 
	^receptiveAccount name.! !


!classDefinition: #SpecialPortfolioTree category: 'Portfolio-Solucion'!
Report subclass: #SpecialPortfolioTree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialPortfolioTree methodsFor: 'evaluating' stamp: 'E 10/23/2022 21:03:23'!
report
	^account toBeReportedTo: self.! !


!SpecialPortfolioTree methodsFor: 'operations -private' stamp: 'E 10/23/2022 23:32:07'!
reportForPortfolio: aPortfolio 
	| report |
	
	report _ OrderedCollection with: (aPortfolio name).
	(aPortfolio accounts) ifNotEmpty: [  report add: ((aPortfolio accounts) collect: [ :accountOfPortfolio | accountOfPortfolio toBeReportedTo: self])].
	report add: 'Balance = ', aPortfolio balance asString.
	^report.! !

!SpecialPortfolioTree methodsFor: 'operations -private' stamp: 'E 10/23/2022 21:12:09'!
reportForReceptiveAccount: receptiveAccount 
	| accountReport accountSummary |
	
	accountReport := OrderedCollection with: receptiveAccount name.
	accountSummary := AccountSummary of: receptiveAccount.
	accountReport add: accountSummary report. 
	
	^accountReport! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'operations -private' stamp: 'E 10/23/2022 23:29:13'!
reportForADeposit: aValue 
	^0.! !

!TransferNet methodsFor: 'operations -private' stamp: 's 10/23/2022 19:51:56'!
reportForADepositLeg: aValue 
	^aValue .! !

!TransferNet methodsFor: 'operations -private' stamp: 'E 10/23/2022 23:29:03'!
reportForAWithdraw: aValue 
	^0.! !

!TransferNet methodsFor: 'operations -private' stamp: 's 10/23/2022 19:50:42'!
reportForAWithdrawLeg: aValue 
	^ 0-aValue.! !

!TransferNet methodsFor: 'operations -private' stamp: 's 10/23/2022 20:37:15'!
reportForPortfolio: aPortfolio 
	^aPortfolio accounts sum: [:accountOfPortfolio |accountOfPortfolio toBeReportedTo: self].! !

!TransferNet methodsFor: 'operations -private' stamp: 's 10/23/2022 20:32:43'!
reportForReceptiveAccount: receptiveAccount 
	^receptiveAccount transactions sum: [:transaction | transaction  toBeReportedTo: self.].! !


!TransferNet methodsFor: 'evaluating' stamp: 's 10/23/2022 19:43:54'!
report
	^account toBeReportedTo: self.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 17:55:12'!
depositLeg
	^depositLeg.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 18:00:22'!
initializeRegister: aValue from: anEmisorAccount to: aReceptiveAccount 
	value:= aValue.
	
	withdrawLeg := WithdrawLeg for: self.
	anEmisorAccount register: withdrawLeg.
	
	depositLeg := DepositLeg for: self.
	aReceptiveAccount register: depositLeg.
	
	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 17:32:24'!
value

	^ value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'E 10/18/2022 17:55:38'!
withdrawLeg
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: 'value withdrawLeg'!

!Transfer class methodsFor: 'initialize' stamp: 'E 10/18/2022 17:32:43'!
for: aValue
	value:= aValue! !

!Transfer class methodsFor: 'initialize' stamp: 'E 10/18/2022 17:36:46'!
register: aValue from: anEmisorAccount to: aReceptiveAccount 
	
	^self new initializeRegister: aValue from: anEmisorAccount to: aReceptiveAccount.
	
	
	
	! !
