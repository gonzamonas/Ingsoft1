!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:45:32'!
test01AccountSummaryOnNewAccountReturnsBalanceEqualsZero

	self assert: (OrderedCollection with: 'Balance = 0') equals: (AccountSummary for: ReceptiveAccount new) value.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:46:07'!
test02AccountSummaryOnReceptiveAccountWithMultipleTransactions

	| account expectedSummary |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 20 from: account to: ReceptiveAccount new.
	Transfer register: 30 from: ReceptiveAccount new to: account.
	
	expectedSummary := OrderedCollection 
						with: 'Depósito por 100.' 
						with: 'Extracción por 50.' 
						with: 'Salida por transferencia de 20.' 
						with: 'Entrada por transferencia de 30.' 
						with: 'Balance = 60'.
						
	self assert: expectedSummary equals: (AccountSummary for: account) value.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:46:28'!
test03AccountSummaryOnPortfolioWithMultipleAccounts

	| account anotherAccount expectedSummary portfolio |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: anotherAccount.
	
	expectedSummary := OrderedCollection 
						with: 'Depósito por 100.' 
						with: 'Extracción por 50.'
						with: 'Balance = 50'.					

	self assert: expectedSummary equals: (AccountSummary for: portfolio) value.! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
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


!classDefinition: #PortfolioTreeStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:50:53'!
test01EmptyPortfolioStructureIsNewOrderedCollection

	self assert: OrderedCollection new equals: (PortfolioTreeStructure for: Portfolio new) value! !

!PortfolioTreeStructureTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:51:23'!
test02PortfolioTreeStructureOnPortfolioWithManyLevels
	
	| expectedTreeStructure portfolio |
	expectedTreeStructure := OrderedCollection 
							with: 'Portfolio de la familia' 
							with: '	Cuenta Mia' 
							with: '	Portfolio de hijos' 
							with: '		Cuenta de Juan' 
							with: '		Cuenta de Angeles'.
							
			
	portfolio := Portfolio named: 'Portfolio de la familia' 
					   with: (ReceptiveAccount named: 'Cuenta Mia') 
					   with: (Portfolio named: '	Portfolio de hijos' 
								     with: (ReceptiveAccount named: 'Cuenta de Juan') 
								     with: (ReceptiveAccount named: 'Cuenta de Angeles')).
								
	self assert: expectedTreeStructure equals: (PortfolioTreeStructure for: portfolio) value! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:47:12'!
test01EmptyAccountTransferNetIsZero

	self assert: 0 equals: (TransferNet for: ReceptiveAccount new) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'GM 10/24/2022 16:48:08'!
test02TransferNetOnAccountWithMultipleTransactions

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 20 from: account to: ReceptiveAccount new.
	Transfer register: 30 from: ReceptiveAccount new to: account.

	self assert: 10 equals: (TransferNet for: account) value.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'GM 10/24/2022 09:54:48'!
test01TransferBetweenAccountsModifiesBalance

	| accountToExtract accountToDeposit |
	
	accountToExtract := ReceptiveAccount new.
	accountToDeposit := ReceptiveAccount new.
	Transfer register: 100 from: accountToExtract to: accountToDeposit.
	self assert: -100 equals: accountToExtract balance.
	self assert: 100 equals: accountToDeposit balance.! !

!TransferTest methodsFor: 'tests' stamp: 'GM 10/24/2022 11:18:29'!
test02AccountsRegisterTransferLegs

	| accountToExtract accountToDeposit transfer |
	
	accountToExtract := ReceptiveAccount new.
	accountToDeposit := ReceptiveAccount new.
	transfer := Transfer register: 100 from: accountToExtract to: accountToDeposit.
	self assert: (accountToExtract hasRegistered: transfer withdrawLeg).
	self assert: (accountToDeposit hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'GM 10/24/2022 11:19:17'!
test03CanMoveBetweenLegs

	| accountToExtract accountToDeposit transfer |
	
	accountToExtract := ReceptiveAccount new.
	accountToDeposit := ReceptiveAccount new.
	transfer := Transfer register: 100 from: accountToExtract to: accountToDeposit.
	self assert: transfer withdrawLeg anotherLeg equals: transfer depositLeg.
	self assert: transfer depositLeg anotherLeg equals: transfer withdrawLeg! !


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


!Account methodsFor: 'transactions' stamp: 'GM 10/24/2022 16:56:20'!
accept: aVisitor

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


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'GM 10/24/2022 16:54:54'!
accept: aVisitor

	accounts do: [:account | account accept: aVisitor]! !

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

!Portfolio methodsFor: 'account management - private' stamp: 'GM 10/24/2022 14:51:44'!
initializeNamed: aName with: anAccount with: anotherAccount.

	name := aName.
	self add: anAccount.
	self add: anotherAccount.! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 14:01:46'!
named: aName with: anAccount with: anotherAccount

	^self new initializeNamed: aName with: anAccount with: anotherAccount.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'GM 10/24/2022 14:50:24'!
initializeNamed: aName 

	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'GM 10/24/2022 12:14:43'!
accept: aVisitor

	transactions do: [:transaction | transaction accept: aVisitor]! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 14:49:37'!
named: aName
	
	^self new initializeNamed: aName.! !


!classDefinition: #PortfolioTreeStructure category: 'Portfolio-Solucion'!
Object subclass: #PortfolioTreeStructure
	instanceVariableNames: 'portfolio value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructure methodsFor: 'initialization' stamp: 'GM 10/24/2022 13:44:34'!
initializeFor: aPortfolio 
	
	portfolio := aPortfolio.
	value := OrderedCollection new.! !

!PortfolioTreeStructure methodsFor: 'initialization' stamp: 'GM 10/24/2022 16:52:37'!
value

	value := OrderedCollection new.
	portfolio accept: self.	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeStructure class' category: 'Portfolio-Solucion'!
PortfolioTreeStructure class
	instanceVariableNames: ''!

!PortfolioTreeStructure class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 13:43:25'!
for: aPortfolio 

	^self new initializeFor: aPortfolio! !


!classDefinition: #ReportGenerator category: 'Portfolio-Solucion'!
Object subclass: #ReportGenerator
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportGenerator methodsFor: 'evaluating' stamp: 'GM 10/24/2022 16:32:27'!
value

	self subclassResponsibility! !


!ReportGenerator methodsFor: 'visiting' stamp: 'GM 10/24/2022 16:31:31'!
visitDeposit: aDeposit

	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visiting' stamp: 'GM 10/24/2022 16:31:53'!
visitTransferDeposit: aTransferDeposit

	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visiting' stamp: 'GM 10/24/2022 16:31:45'!
visitTransferWithdraw: aTransferWithdraw

	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'visiting' stamp: 'GM 10/24/2022 16:31:37'!
visitWithdraw: aWithdraw

	self subclassResponsibility.! !


!ReportGenerator methodsFor: 'initialization' stamp: 'GM 10/24/2022 16:30:44'!
initializeFor: anAccount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReportGenerator class' category: 'Portfolio-Solucion'!
ReportGenerator class
	instanceVariableNames: ''!

!ReportGenerator class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 16:29:52'!
for: anAccount

	^self new initializeFor: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
ReportGenerator subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'GM 10/24/2022 13:14:50'!
initializeFor: anAccount

	account := anAccount.
	value := OrderedCollection new.! !


!AccountSummary methodsFor: 'visiting' stamp: 'GM 10/24/2022 12:16:50'!
visitDeposit: aDeposit

	value add: 'Depósito por ' , aDeposit value asString , '.'! !

!AccountSummary methodsFor: 'visiting' stamp: 'GM 10/24/2022 12:20:23'!
visitTransferDeposit: aTransferDeposit

	value add: 'Entrada por transferencia de ' , aTransferDeposit value asString , '.'! !

!AccountSummary methodsFor: 'visiting' stamp: 'GM 10/24/2022 12:17:22'!
visitTransferWithdraw: aTransferWithdraw

	value add: 'Salida por transferencia de ' , aTransferWithdraw value asString , '.'! !

!AccountSummary methodsFor: 'visiting' stamp: 'GM 10/24/2022 12:16:58'!
visitWithdraw: aWithdraw

	value add: 'Extracción por ' , aWithdraw value asString , '.'! !


!AccountSummary methodsFor: 'evaluating' stamp: 'GM 10/24/2022 12:22:20'!
value

	value := OrderedCollection new.
	account accept: self.
	value add: 'Balance = ' , account balance asString.
	^value! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
ReportGenerator subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'GM 10/24/2022 13:30:36'!
initializeFor: anAccount 

	account := anAccount.
	value := 0.! !


!TransferNet methodsFor: 'visiting' stamp: 'GM 10/24/2022 13:35:17'!
visitDeposit: aDeposit 
	! !

!TransferNet methodsFor: 'visiting' stamp: 'GM 10/24/2022 13:36:19'!
visitTransferDeposit: aTransferDeposit 
	
	value := value + aTransferDeposit value! !

!TransferNet methodsFor: 'visiting' stamp: 'GM 10/24/2022 13:35:53'!
visitTransferWithdraw: aTransferWithdraw 
	
	value := value - aTransferWithdraw value! !

!TransferNet methodsFor: 'visiting' stamp: 'GM 10/24/2022 13:35:24'!
visitWithdraw: aWithdraw 
	! !


!TransferNet methodsFor: 'evaluating' stamp: 'GM 10/24/2022 13:34:29'!
value

	value := 0.
	account accept: self.
	^value! !


!classDefinition: #Transaction category: 'Portfolio-Solucion'!
Object subclass: #Transaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!Transaction methodsFor: 'balance' stamp: 'GM 10/24/2022 16:43:20'!
affectBalance: aBalance

	self subclassResponsibility ! !


!Transaction methodsFor: 'evaluating' stamp: 'GM 10/24/2022 16:37:17'!
value

	self subclassResponsibility ! !


!Transaction methodsFor: 'accepting' stamp: 'GM 10/24/2022 16:42:19'!
accept: aVisitor
	
	self subclassResponsibility! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!




!AccountTransaction methodsFor: 'initialization' stamp: 'GM 10/24/2022 16:39:11'!
initializeFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'evaluating' stamp: 'GM 10/24/2022 16:39:27'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 16:40:16'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!Deposit methodsFor: 'accepting' stamp: 'GM 10/24/2022 16:41:55'!
accept: aVisitor
	
	aVisitor visitDeposit: self! !



!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!



!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'accepting' stamp: 'GM 10/24/2022 12:03:43'!
accept: aVisitor
	
	aVisitor visitWithdraw: self! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
Transaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'initialization' stamp: 'GM 10/24/2022 10:10:06'!
initializeForTransfer: aTransfer 
	
	transfer := aTransfer.! !


!TransferTransaction methodsFor: 'evaluating' stamp: 'GM 10/24/2022 16:40:39'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 10:11:03'!
forTransfer: aTransfer 

	^self new initializeForTransfer: aTransfer ! !

!TransferTransaction class methodsFor: 'instance creation' stamp: 'GM 10/24/2022 10:10:47'!
registerOn: aReceptiveAccount forTransfer: aTransfer
	
	| transaction |
	
	transaction := self forTransfer: aTransfer.
	aReceptiveAccount register: transaction.
	^ transaction! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'GM 10/24/2022 12:18:45'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDeposit methodsFor: 'legs' stamp: 'GM 10/24/2022 10:05:06'!
anotherLeg
	
	^transfer withdrawLeg! !


!TransferDeposit methodsFor: 'accepting' stamp: 'GM 10/24/2022 12:04:03'!
accept: aVisitor
	
	aVisitor visitTransferDeposit: self! !



!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!TransferWithdraw methodsFor: 'legs' stamp: 'GM 10/24/2022 09:42:49'!
anotherLeg
	
	^transfer depositLeg! !


!TransferWithdraw methodsFor: 'balance' stamp: 'GM 10/24/2022 12:18:23'!
affectBalance: aBalance

	^ aBalance - self value
 
	! !


!TransferWithdraw methodsFor: 'accepting' stamp: 'GM 10/24/2022 12:04:30'!
accept: aVisitor
	
	aVisitor visitTransferWithdraw: self! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'GM 10/24/2022 10:03:42'!
initializeRegister: anAmount from: aReceptiveAccountToExtract to: aReceptiveAccountToDeposit 
	
	value := anAmount.
	withdrawLeg := TransferWithdraw registerOn: aReceptiveAccountToExtract forTransfer: self.
	depositLeg := TransferDeposit registerOn: 	aReceptiveAccountToDeposit forTransfer: self.! !


!Transfer methodsFor: 'legs' stamp: 'GM 10/24/2022 09:30:48'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'GM 10/24/2022 09:57:52'!
value

	^value! !

!Transfer methodsFor: 'legs' stamp: 'GM 10/24/2022 09:29:06'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'GM 10/17/2022 21:52:17'!
register: anAmount from: aReceptiveAccountToExtract to: aReceptiveAccountToDeposit

	^self new initializeRegister: anAmount from: aReceptiveAccountToExtract to: aReceptiveAccountToDeposit! !
