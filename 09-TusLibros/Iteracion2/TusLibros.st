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

!CartTest methodsFor: 'tests' stamp: 'GM 10/31/2022 19:09:26'!
test09CartItemsReturnsAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart items occurrencesOf: self itemSellByTheStore) equals: 2.
	self assert: cart items size equals: 2.! !

!CartTest methodsFor: 'tests' stamp: 'GM 11/2/2022 21:21:08'!
test10EmptyCartTotalEqualsZero

	self assert: 0 equals: self createCart total! !

!CartTest methodsFor: 'tests' stamp: 'GM 11/2/2022 21:32:39'!
test11CartWithBookTotalIsBookPrice
	
	| cart priceList |
	priceList := Dictionary new.
	priceList at: 'book1' put: 2000*peso.
	cart := Cart withPriceList: priceList.
	cart add: 'book1'.
	self assert: 2000*peso equals: cart total! !

!CartTest methodsFor: 'tests' stamp: 'GM 11/2/2022 21:32:19'!
test12CartWithManyBooksTotalIsSumOfBooksPrices
	
	| cart priceList |
	priceList := Dictionary new.
	priceList at: 'book1' put: 2000*peso.
	priceList at: 'book2' put: 3000*peso.
	cart := Cart withPriceList: priceList.
	cart add: 2 of: 'book1'.
	cart add: 'book2'.
	self assert: 7000*peso equals: cart total! !

!CartTest methodsFor: 'tests' stamp: 'GM 11/2/2022 21:31:16'!
test13CannotCreateCartWithNotPositivePrices
	
	| priceList |
	priceList := Dictionary new.
	priceList at: 'book1' put: 0*peso.
	priceList at: 'book2' put: -1*peso.
	self should: [Cart withPriceList: priceList]
	       raise: Error - MessageNotUnderstood 
	       withMessageText: Cart invalidPriceListErrorMessage	
	! !


!CartTest methodsFor: 'support' stamp: 'GM 11/2/2022 21:12:32'!
createCart
	
	^Cart withPriceList: self defaultPriceList! !

!CartTest methodsFor: 'support' stamp: 'GM 11/2/2022 21:14:18'!
defaultPriceList
	
	| priceList |
	priceList := Dictionary new.
	priceList at: 'validBook' put: 2000.
	^priceList! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'GM 11/2/2022 21:15:30'!
itemSellByTheStore

	^'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test instances' stamp: 'GM 11/2/2022 21:40:15'!
cartWithBook1

	| cart priceList |
	priceList := Dictionary new.
	priceList at: 'book1' put: 2000*peso.
	cart := Cart withPriceList: priceList.
	cart add: 'book1'.
	^cart! !

!CashierTest methodsFor: 'test instances' stamp: 'GM 11/2/2022 21:36:22'!
emptyCart

	^ Cart withPriceList: Dictionary new.! !

!CashierTest methodsFor: 'test instances' stamp: 'GM 11/3/2022 09:46:35'!
validFebruary2020CreditCard

	^ CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'! !


!CashierTest methodsFor: 'tests' stamp: 'GM 11/3/2022 09:47:38'!
test01CannotCheckoutEmptyCart

	self should: [Cashier for: self emptyCart withMerchantProcessor: MerchantProcessorDouble new]
	      raise: Error - MessageNotUnderstood
	      withMessageText: Cashier cannotCheckoutEmptyCartErrorMessage! !

!CashierTest methodsFor: 'tests' stamp: 'GM 11/3/2022 10:01:13'!
test02CheckoutWithNotExpiredCardReturnsCartTotalAndPaysMerchantProcessor

	| cashier merchantProcessor card |
	
	merchantProcessor := MerchantProcessorDouble new.
	cashier := Cashier for: self cartWithBook1 withMerchantProcessor: merchantProcessor.
	card := self validFebruary2020CreditCard.
	self assert: self cartWithBook1 total equals: (cashier checkoutWith: card on: (GregorianMonthOfYear januaryOf: 2020)).
	self assert: (merchantProcessor hasBeenPaid: 2000*peso with: card).! !

!CashierTest methodsFor: 'tests' stamp: 'GM 11/3/2022 10:03:47'!
test03CheckoutWithExpiredCardRaisesErrorAndDoesntPayMerchantProcessor

	| cashier merchantProcessor |
	
	merchantProcessor := MerchantProcessorDouble new.
	cashier := Cashier for: self cartWithBook1 withMerchantProcessor: merchantProcessor.
	self should: [cashier checkoutWith: self validFebruary2020CreditCard on: (GregorianMonthOfYear marchOf: 2020)]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: Cashier expiredCreditCardErrorMessage equals: anError messageText.
							    self assert: merchantProcessor hasNotBeenPaid].
! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:14:19'!
test01NotExpiredCardsisNotExpired

	| creditCard |
	
	creditCard := CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'.
	self deny: (creditCard isExpiredOn: (GregorianMonthOfYear januaryOf: 2020))! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:14:29'!
test02ExpiredCardsisExpired

	| creditCard |
	
	creditCard := CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'.
						
	self assert: (creditCard isExpiredOn: (GregorianMonthOfYear marchOf: 2020))! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:14:36'!
test03CardIsNotExpiredIfItsTheSameExpirationDate

	| creditCard |
	
	creditCard := CreditCard withNumber: '1234567812345678'
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'.
						
	self deny: (creditCard isExpiredOn: (GregorianMonthOfYear februaryOf: 2020))! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:15:56'!
test04CannotCreateCardWithNumberWithoutSixteenCharacters
	
	self should: [CreditCard withNumber: '12345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'.]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard numberMustBeSixteenDigits! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:27:06'!
test05CannotCreateCardWIthNumberWithoutAllDigits
	
	self should: [CreditCard withNumber: '12345678123456#P' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'Hernan Wilkinson'.]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard numberMustBeSixteenDigits! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:30:15'!
test06CannotCreateCardWithEmptyOwnerName
	
	self should: [CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: ''.]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard ownerNameMustNotBeEmpty! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:38:25'!
test07CannotCreateCardWithOwnerNameAllEmptySpaces
	
	self should: [CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: '    '.]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard ownerNameMustNotBeEmpty! !

!CreditCardTest methodsFor: 'tests' stamp: 'GM 10/31/2022 21:43:57'!
test08CannotCreateCardWhenOwnerNameIsLongerThan30Characters
	
	self should: [CreditCard withNumber: '1234567812345678' 
						  withExpirationDate: (GregorianMonthOfYear februaryOf: 2020)
						  withOwner: 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'.]
		raise: Error - MessageNotUnderstood
		withMessageText: CreditCard ownerNameMustBeUpTo30Characters! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'GM 11/2/2022 21:11:03'!
assertIsValidItem: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'GM 10/31/2022 21:50:27'!
initializeAcceptingItemsOf: aCatalog

	priceList := aCatalog.
	items := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'GM 11/2/2022 21:11:41'!
initializeWithPricelist: aPriceList 
	
	priceList := aPriceList.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'GM 10/31/2022 19:06:51'!
items
	
	^items! !


!Cart methodsFor: 'total' stamp: 'GM 11/2/2022 21:19:58'!
total
	
	items ifEmpty: [^0].
	^items sum: [:item | priceList at: item].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !

!Cart class methodsFor: 'instance creation' stamp: 'GM 11/2/2022 21:26:04'!
withPriceList: aPriceList 
	
	(aPriceList values allSatisfy: [:price | price strictlyPositive]) ifFalse: [self error: self invalidPriceListErrorMessage].
	^self new initializeWithPricelist: aPriceList! !


!Cart class methodsFor: 'error messages' stamp: 'GM 11/2/2022 21:24:01'!
invalidPriceListErrorMessage
	
	^'Invalid price list'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart priceList merchantProcessorDouble'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'GM 11/3/2022 09:23:16'!
initializeFor: aCart withMerchantProcessor: aMerchantProcessorDouble 
	
	cart := aCart.
	merchantProcessorDouble := aMerchantProcessorDouble.! !


!Cashier methodsFor: 'pricd' stamp: 'GM 11/2/2022 21:43:09'!
checkout
	
	^cart total! !


!Cashier methodsFor: 'checkout' stamp: 'GM 11/3/2022 09:43:13'!
checkoutWith: card on: aDate

	(card isExpiredOn: aDate) ifTrue: [self error: self class expiredCreditCardErrorMessage].
 	^merchantProcessorDouble pay: cart total with: card.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'GM 10/31/2022 18:51:34'!
cannotCheckoutEmptyCartErrorMessage
	
	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'GM 11/3/2022 09:42:16'!
expiredCreditCardErrorMessage
	
	^'Expired credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'GM 11/3/2022 09:49:27'!
for: aCart withMerchantProcessor: aMerchantProcessorDouble 

	aCart isEmpty ifTrue: [self error: self cannotCheckoutEmptyCartErrorMessage].
	^self new initializeFor: aCart withMerchantProcessor: aMerchantProcessorDouble ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'GM 10/31/2022 21:01:26'!
initializeWithNumber: aCreditCardNumber withExpirationDate: anExpirationDate withOwner: anOwner 
	
	creditCardNumber := aCreditCardNumber.
	expirationDate := anExpirationDate.
	owner := anOwner.! !


!CreditCard methodsFor: 'expiration' stamp: 'GM 10/31/2022 21:07:01'!
isExpiredOn: aDate

	^ expirationDate < aDate
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'GM 10/31/2022 21:22:21'!
assertNumberIsValid: aCreditCardNumber

	aCreditCardNumber size = 16 ifFalse: [self error: self numberMustBeSixteenDigits].
	(aCreditCardNumber allSatisfy: [:character | character isDigit]) ifFalse: [self error: self numberMustBeSixteenDigits]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'GM 10/31/2022 21:44:40'!
assertOwnerNameIsValid: anOwner

	anOwner isEmpty ifTrue: [self error: self ownerNameMustNotBeEmpty].
	(anOwner allSatisfy: [:character | character asString = ' ']) ifTrue: [self error: self ownerNameMustNotBeEmpty].
	(anOwner size > 30) ifTrue: [self error: self ownerNameMustBeUpTo30Characters]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'GM 10/31/2022 21:44:40'!
withNumber: aCreditCardNumber withExpirationDate: anExpirationDate withOwner: anOwner
	
	self assertNumberIsValid: aCreditCardNumber.
	self assertOwnerNameIsValid: anOwner.
	^self new initializeWithNumber: aCreditCardNumber withExpirationDate: anExpirationDate  withOwner: anOwner! !


!CreditCard class methodsFor: 'error messages' stamp: 'GM 10/31/2022 21:11:20'!
numberMustBeSixteenDigits
	
	^ 'Credit card number must be sixteen digits'! !

!CreditCard class methodsFor: 'error messages' stamp: 'GM 10/31/2022 21:41:56'!
ownerNameMustBeUpTo30Characters
	
	^'Owner name must be up to 30 characters'! !

!CreditCard class methodsFor: 'error messages' stamp: 'GM 10/31/2022 21:29:02'!
ownerNameMustNotBeEmpty
	
	^'Owner name must not be empty'! !


!classDefinition: #MerchantProcessorDouble category: 'TusLibros'!
Object subclass: #MerchantProcessorDouble
	instanceVariableNames: 'paidAmount paidCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorDouble methodsFor: 'paying' stamp: 'GM 11/3/2022 09:28:36'!
pay: anAmount with: aCard

	paidAmount := anAmount.
	paidCard := aCard.
	^paidAmount! !


!MerchantProcessorDouble methodsFor: 'testing' stamp: 'GM 11/3/2022 09:59:57'!
hasBeenPaid: anAmount with: aCard

	^ anAmount = paidAmount and: [aCard == paidCard]
	
	! !

!MerchantProcessorDouble methodsFor: 'testing' stamp: 'GM 11/3/2022 09:45:33'!
hasNotBeenPaid
	
	^paidAmount isNil and: paidCard isNil ! !
