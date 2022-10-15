!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'assertions' stamp: 'GM 10/15/2022 15:18:35'!
assertThatAccount: account cannotBeAddedTo: portfolio

	^ self should: [portfolio addAccount: account]  
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: Portfolio cannotHaveSameAccountErrorMessage]! !


!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:14:43'!
test01BalanceOfEmptyPortfolioIsZero

	self assert: self emptyPortfolio balance equals: 0! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:13:11'!
test02BalanceOfPortfolioWithAccountIsAccountBalance

	| portfolio account |
	
	account := ReceptiveAccount with: (self depositFor100).
	portfolio := Portfolio with: account.
	self assert: portfolio balance equals: account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:13:11'!
test03BalanceOfPortfolioWithManyAccountsIsSumOfAccountsBalances

	| portfolio account anotherAccount |
	
	account := ReceptiveAccount with: (self depositFor100).
	anotherAccount := ReceptiveAccount with: (Deposit for: 200).
	portfolio := Portfolio with: account with: anotherAccount.
	self assert: portfolio balance equals: account balance + anotherAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:13:11'!
test04BalanceOfPortfolioWithPortfolioIsPortfolioBalance

	| portfolio newPortfolio |
	
	newPortfolio := Portfolio with: (ReceptiveAccount with: (self depositFor100)).
	portfolio := Portfolio with: newPortfolio.
	self assert: portfolio balance equals: newPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:43:27'!
test05EmptyPortfolioHasNoRegisteredTransaction

	| portfolio transaction |
	
	portfolio := self emptyPortfolio.
	transaction := self depositFor100.
	self deny: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:13:11'!
test06PortfolioWithAccountWithTransactionHasRegisteredTransaction

	| portfolio transaction |
	
	transaction := self depositFor100.
	portfolio := Portfolio with: (ReceptiveAccount with: transaction).
	self assert: (portfolio hasRegistered: transaction). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:13:11'!
test07PortfolioWithPortfolioWithTransactionHasRegisteredTransaction

	| portfolio newPortfolio transaction |
	
	transaction := self depositFor100.
	newPortfolio := Portfolio with: (ReceptiveAccount with: transaction).
	portfolio := Portfolio with: newPortfolio.
	self assert: (portfolio hasRegistered: transaction). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:14:42'!
test08EmptyPortfolioHasNoTransactions

	| portfolio |
	
	portfolio := self emptyPortfolio.
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:15:50'!
test09PortfolioWithAccountTransactionsEqualsAccountsTransactions

	| portfolio transaction |
	
	transaction := self depositFor100.
	portfolio := Portfolio with: (ReceptiveAccount with: transaction) 
					   with: (ReceptiveAccount new register: transaction).
	self assert: (OrderedCollection with: transaction with: transaction) equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:19:02'!
test10PortfolioWithPortfolioEqualsPortfolioTransactions

	| portfolio transaction |
	
	transaction := self depositFor100.
	portfolio := Portfolio with: (Portfolio with: (ReceptiveAccount with: transaction)).
	self assert: (OrderedCollection with: transaction) equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:19:53'!
test11CannotAddSameAccountTwiceToPortfolio

	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	self assertThatAccount: account cannotBeAddedTo: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:20:37'!
test12CannotAddAccountToPortfolioWithPortfolioWithAccount

	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: (Portfolio with: account).
	self assertThatAccount: account cannotBeAddedTo: portfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:24:01'!
test13CannotAddAccountWhenItsParentsHaveSameAccount

	| portfolio account |
	
	portfolio := self emptyPortfolio.
	account := ReceptiveAccount new.
	Portfolio with: portfolio with: account.
	self assertThatAccount: account cannotBeAddedTo: portfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:26:20'!
test14CannotAddPortfolioToPortfolioWithSameAccounts

	| portfolio newPortfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	newPortfolio := Portfolio with: account.
	self assertThatAccount: newPortfolio cannotBeAddedTo: portfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:28:54'!
test15CannotAddPortfolioToPortfolioWithPortfolioWithSameAccounts

	| portfolio newPortfolio account |
	
	account := ReceptiveAccount new.
	newPortfolio := Portfolio with: account.
	portfolio := Portfolio with: (Portfolio with: account).
	self assertThatAccount: newPortfolio cannotBeAddedTo: portfolio! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:32:35'!
test16CannotAddPortfolioToPortfolioWhenItsParentsHaveSameAccounts

	| portfolio newPortfolio account |
	
	account := ReceptiveAccount new.
	portfolio := self emptyPortfolio. 
	newPortfolio := Portfolio with: account.
	Portfolio with: account with: portfolio.
	self assertThatAccount: newPortfolio cannotBeAddedTo: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'GM 10/15/2022 17:34:21'!
test17CannotAddSamePortfolioTwice

	| portfolio newPortfolio |
	
	newPortfolio := self emptyPortfolio. 
	portfolio := Portfolio with: newPortfolio.
	self assertThatAccount: newPortfolio cannotBeAddedTo: portfolio.! !


!PortfolioTest methodsFor: 'instances' stamp: 'GM 10/15/2022 17:13:11'!
depositFor100

	^ Deposit for: 100! !

!PortfolioTest methodsFor: 'instances' stamp: 'GM 10/15/2022 17:14:42'!
emptyPortfolio

	^ Portfolio new! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'transactions' stamp: 'GM 10/10/2022 17:42:28'!
transactions

	self subclassResponsibility.! !


!Account methodsFor: 'testing' stamp: 'GM 10/10/2022 17:43:07'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!Account methodsFor: 'testing' stamp: 'GM 10/15/2022 15:52:24'!
hasSameAccounts: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'initialization' stamp: 'GM 10/10/2022 17:42:11'!
initialize

	self subclassResponsibility.! !


!Account methodsFor: 'adding' stamp: 'GM 10/15/2022 17:37:02'!
addParent: aPortfolio

	self subclassResponsibility! !


!Account methodsFor: 'balance' stamp: 'GM 10/10/2022 17:43:34'!
balance

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'GM 10/10/2022 17:37:29'!
balance

	^accounts sum: [ :account | account balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'adding' stamp: 'GM 10/15/2022 16:00:43'!
addAccount: anAccount
	
	(self rootParentHasAccount: anAccount) ifTrue: [self error: self class cannotHaveSameAccountErrorMessage].
	accounts add: anAccount.
	anAccount addParent: self.! !

!Portfolio methodsFor: 'adding' stamp: 'GM 10/15/2022 15:15:08'!
addParent: aPortfolio 
	parentPortfolios add: aPortfolio.! !


!Portfolio methodsFor: 'initialization' stamp: 'GM 10/15/2022 15:10:48'!
initialize

	accounts := OrderedCollection new.
	parentPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'GM 10/10/2022 17:37:55'!
hasRegistered: aTransaction 
	
	^accounts anySatisfy: [ :account | account hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'GM 10/15/2022 16:25:41'!
hasSameAccounts: anAccount

	^ (self = anAccount) or: [accounts anySatisfy: [ :account | (anAccount hasSameAccounts: account) or: [account hasSameAccounts: anAccount]]]! !


!Portfolio methodsFor: 'transactions' stamp: 'GM 10/15/2022 15:51:01'!
rootParentHasAccount: anAccount

	parentPortfolios ifEmpty: [^self hasSameAccounts: anAccount].
	^parentPortfolios anySatisfy: [ :parentPortfolio | parentPortfolio rootParentHasAccount: anAccount]! !

!Portfolio methodsFor: 'transactions' stamp: 'GM 10/10/2022 17:41:35'!
transactions

	^accounts inject: OrderedCollection new into: [ :transactions :portfolio | transactions addAll: portfolio transactions. transactions].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'GM 10/15/2022 15:17:56'!
cannotHaveSameAccountErrorMessage

	^'Cannot have same account'! !

!Portfolio class methodsFor: 'error messages' stamp: 'GM 10/15/2022 16:55:58'!
with: anAccount

	^ self new addAccount: anAccount! !

!Portfolio class methodsFor: 'error messages' stamp: 'GM 10/15/2022 16:56:22'!
with: anAccount with: anotherAccount

	^ self new addAccount: anAccount; addAccount: anotherAccount.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'GM 10/15/2022 16:16:28'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'GM 10/6/2022 20:45:14'!
balance

	^transactions inject: 0 into: [ :currentBalance :aTransaction | aTransaction applyToBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'GM 10/15/2022 16:18:11'!
hasSameAccounts: anAccount

	^ self = anAccount! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'GM 10/15/2022 15:15:29'!
addParent: aPortfolio 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'GM 10/15/2022 16:58:56'!
with: aTransaction

	^self new register: aTransaction! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'GM 10/15/2022 16:59:35'!
with: aTransaction with: anotherTransaction

	^self new register: aTransaction; register: anotherTransaction.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'GM 10/10/2022 18:11:52'!
initializeFor: aValue

	value := aValue.! !


!AccountTransaction methodsFor: 'value' stamp: 'GM 10/10/2022 18:11:24'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'GM 10/6/2022 20:43:55'!
applyToBalance: currentBalance 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'GM 10/10/2022 18:13:03'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!Deposit methodsFor: 'value' stamp: 'GM 10/6/2022 20:42:56'!
applyToBalance: currentBalance

	^ currentBalance + value! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!Withdraw methodsFor: 'value' stamp: 'GM 10/6/2022 20:43:35'!
applyToBalance: currentBalance

	^ currentBalance - value ! !
