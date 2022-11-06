!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'MA 11/6/2022 16:29:48'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'MA 11/6/2022 16:29:53'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'MA 11/3/2022 20:21:19'!
test09EmptyCartItemsAreEmpty

	| cart |
	
	cart := testObjectsFactory createCart.

	self assert: 0 equals: cart items size! !

!CartTest methodsFor: 'tests' stamp: 'MA 11/3/2022 20:40:47'!
test10CartItemsHasTheAddedItems

	| cart items |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	items := cart items.
	self assert: 2 equals: (items occurrencesOf: testObjectsFactory itemSellByTheStore).
	self assert: 2 equals: items size.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory now
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory now 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
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
				on: testObjectsFactory now
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory now
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
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
		on: testObjectsFactory now
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'MA 11/5/2022 20:22:10'!
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
		on: testObjectsFactory now
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #FacadeTest category: 'TusLibros'!
TestCase subclass: #FacadeTest
	instanceVariableNames: 'testObjectsFactory debitBehavior facade now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:06:03'!
checkoutCart: cartId

	^ facade checkoutCart: cartId 
		   withCcn: testObjectsFactory validCreditCardNumber 
		   withCced: testObjectsFactory notExpiredCreditCardMonth
		   withCco: testObjectsFactory validCreditCardOwner! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 16:51:15'!
test01cannotCreateCartWithInvalidCredentials

	self should: [facade createCartWithUser: self validUser password: self invalidPassword] 
		raise: Error - MessageNotUnderstood 
		withMessageText: Facade invalidCredentialsErrorMessage
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test02createCartCreatesAnEmptyCart
	
	| cartId |
	
	cartId := self createCart.
	self assert: OrderedCollection new equals: (facade listCart: cartId).
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test03addToCartReturnsTheAddedItems
	
	| cartId item |
	
	cartId := self createCart.
	item := testObjectsFactory itemSellByTheStore.
	facade add: 2 of: item to: cartId. 
	self assert: (OrderedCollection with: item with: item) equals: (facade listCart: cartId).
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test04addToCartMultipleTimesReturnsTheAddedItems
	
	| cartId item |
	
	cartId := self createCart.
	item := testObjectsFactory itemSellByTheStore.
	facade add: 1 of: item to: cartId. 
	facade add: 1 of: item to: cartId. 
	self assert: (OrderedCollection with: item with: item) equals: (facade listCart: cartId).
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test05addToCartItemNotInCatalogFails
	
	| cartId |
	
	cartId := self createCart.
	self should: [ facade add: 1 of: testObjectsFactory itemNotSellByTheStore to: cartId ]  
	      	raise: Error - MessageNotUnderstood 
	      	withExceptionDo:  [ :error |
			self assert: Cart invalidItemErrorMessage equals: error messageText.
			self assert: OrderedCollection new equals: (facade listCart: cartId).
		]
	
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test06createMultipleCarts
	
	| item firstCartId secondCartId |

	item := testObjectsFactory itemSellByTheStore.
	
	firstCartId := self createCart.
	facade add: 2 of: item to: firstCartId. 
	
	secondCartId := self createCart.
	facade add: 1 of: item to: secondCartId. 
	
	self assert: (OrderedCollection with: item with: item) equals: (facade listCart: firstCartId).
	self assert: (OrderedCollection with: item) equals: (facade listCart: secondCartId).
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 16:51:15'!
test07AddToNonExistentCartFails
	
	self should: [ facade add: 1 of: testObjectsFactory itemSellByTheStore to: 1 ] 
		raise: Error - MessageNotUnderstood  
		withMessageText: Facade cartNotFoundErrorMessage.
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:07:46'!
test08ListNonExistentCartFails
	
	self should: [ facade listCart: 1 ] 
		raise: Error - MessageNotUnderstood  
		withMessageText: Facade cartNotFoundErrorMessage.
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:07:37'!
test09CheckoutNonExistentCartFails
	
	self should: [ self checkoutCart: 1 ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: Facade cartNotFoundErrorMessage equals: error messageText.
			self assert: OrderedCollection new equals: self listPurchases. 
		]
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:06:53'!
test10CheckoutCartWithNotExpiredCardSucceed
	
	| cartId item |
	
	cartId := self createCart.
	item := testObjectsFactory itemSellByTheStore.
	facade add: 2 of: item to: cartId.
	self checkoutCart: cartId.
	self assert: (OrderedCollection with: item with: item) equals: self listPurchases
		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test11CheckoutCartWithExpiredCardFails
	
	| cartId item |
	
	cartId := self createCart.
	item := testObjectsFactory itemSellByTheStore.
	facade add: 2 of: item to: cartId.
	self should: [
		facade checkoutCart: 1 
		   withCcn: testObjectsFactory validCreditCardNumber 
		   withCced: testObjectsFactory expiredCreditCardMonth
		   withCco: testObjectsFactory validCreditCardOwner ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Cashier canNotChargeAnExpiredCreditCardErrorMessage equals: error messageText.
			self assert: OrderedCollection new equals: self listPurchases
		]
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 16:51:15'!
test12ListPurchasesWithInvalidCredentialsFails
	
	self should: [ facade listPurchasesForUserId: self validUser withPassword: self invalidPassword. ] 
		raise: Error - MessageNotUnderstood
		withMessageText: Facade invalidCredentialsErrorMessage.
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:06:27'!
test13CheckoutCartWithCardWithoutCreditFails
	
	| cartId item |
	
	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage ].
	cartId := self createCart.
	item := testObjectsFactory itemSellByTheStore.
	facade add: 2 of: item to: cartId.
	self should: [ self checkoutCart: cartId ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Cashier creditCardHasNoCreditErrorMessage equals: error messageText.
			self assert: OrderedCollection new equals: self listPurchases
		]
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:36:59'!
test14CannotAddToExpiredCart
	
	| cartId |
	
	cartId := self createCart.
	now := now + 31 minutes.
	self should: [ facade add: 1 of: testObjectsFactory itemSellByTheStore to: cartId ] 
		raise: Error - MessageNotUnderstood
		withMessageText: CartSession expiredCartErrorMessage.
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 19:55:51'!
test15CannotListExpiredCart
	
	| cartId |
	
	cartId := self createCart.
	now := now + 31 minutes.
	self should: [ facade listCart: cartId ] 
		raise: Error - MessageNotUnderstood
		withMessageText: CartSession expiredCartErrorMessage.
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:06:10'!
test16CannotCheckoutExpiredCart
	
	| cartId |
	
	cartId := self createCart.
	facade add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	now := now + 31 minutes.
	self should: [ self checkoutCart: cartId ] 
		raise: Error - MessageNotUnderstood
		withMessageText: CartSession expiredCartErrorMessage.
	

		 ! !

!FacadeTest methodsFor: 'tests' stamp: 'MA 11/6/2022 20:00:35'!
test17aCartCanBeUseIfAnActionWasMadeInTheLast30Minutes
	
	| cartId |
	
	cartId := self createCart.
	now := now + 29 minutes.
	facade listCart: cartId.
	now := now + 2 minutes.
	self shouldnt: [ facade listCart: cartId ] raise: Error
	

		 ! !


!FacadeTest methodsFor: 'credential validation protocol' stamp: 'MA 11/3/2022 20:00:18'!
invalidPassword
	^'invalidPassword'.! !

!FacadeTest methodsFor: 'credential validation protocol' stamp: 'MA 11/3/2022 20:02:21'!
isValidUser: anUser withPassword: aPassword
	
	^anUser = self validUser and: [aPassword = self validPassword].! !

!FacadeTest methodsFor: 'credential validation protocol' stamp: 'MA 11/3/2022 19:57:48'!
validPassword
	^'validPassword'! !

!FacadeTest methodsFor: 'credential validation protocol' stamp: 'MA 11/3/2022 19:57:33'!
validUser
	^'user'! !


!FacadeTest methodsFor: 'setup' stamp: 'MA 11/6/2022 17:54:44'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	now := testObjectsFactory now.
	facade := Facade newWithValidator: self 
					withPriceList: testObjectsFactory defaultCatalog 
					withMerchantProcessor: self 
					withClock: self.! !


!FacadeTest methodsFor: 'clock protocol' stamp: 'MA 11/6/2022 19:32:39'!
now
	
	^now.! !


!FacadeTest methodsFor: 'payment processor protocol' stamp: 'MA 11/5/2022 20:17:49'!
debit: total from: creditCard 

	^debitBehavior value: total value: creditCard.! !


!FacadeTest methodsFor: 'actions' stamp: 'MA 11/6/2022 19:36:59'!
createCart

	^ facade createCartWithUser: self validUser password: self validPassword! !

!FacadeTest methodsFor: 'actions' stamp: 'MA 11/6/2022 16:52:32'!
listPurchases

	^ facade listPurchasesForUserId: self validUser withPassword: self validPassword! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'MA 11/6/2022 16:30:38'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'MA 11/3/2022 20:24:21'!
items
	
	^ items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'MA 11/6/2022 16:30:15'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart userId clock lastUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'MA 11/6/2022 19:27:17'!
initializeWithCart: aCart forUserId: anUserId withClock: aClock  

	cart := aCart.
	userId := anUserId.
	clock := aClock.
	lastUsed := aClock now.! !


!CartSession methodsFor: 'accessing' stamp: 'MA 11/5/2022 20:01:06'!
userId

	^userId! !


!CartSession methodsFor: 'actions' stamp: 'MA 11/6/2022 20:01:21'!
withCartDo: aClosure

	self sessionIsExpired ifTrue: [ self error: self class expiredCartErrorMessage ].
	lastUsed := clock now.
	^aClosure value: cart.
	! !


!CartSession methodsFor: 'expired' stamp: 'MA 11/6/2022 19:38:21'!
sessionIsExpired

	^ (clock now between: lastUsed and: lastUsed + 30 minutes) not ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'MA 11/6/2022 19:15:52'!
withCart: aCart forUserId: anUserId withClock: aClock  

	^self new initializeWithCart: aCart forUserId: anUserId withClock: aClock! !


!CartSession class methodsFor: 'error messages' stamp: 'MA 11/6/2022 19:08:38'!
expiredCartErrorMessage
	
	^'Expired cart'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MA 11/5/2022 19:11:36'!
createSale

	^ Sale of: total with: cart items
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'MA 11/5/2022 18:55:54'!
initializeExpiringOn: aMonth withNumber: aNumber withOwner: anOwner

	expiration := aMonth.
	number := aNumber.
	owner := anOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MA 11/5/2022 18:56:05'!
expiringOn: aMonth withNumber: aNumber withOwner: anOwner.
	"Ya esta hecho y testeado en la iteracion anterior"
	^self new initializeExpiringOn: aMonth withNumber: aNumber withOwner: anOwner.! !


!classDefinition: #Facade category: 'TusLibros'!
Object subclass: #Facade
	instanceVariableNames: 'credentialValidator facadeTest priceList repository cartSessionByCartId nextCartSessionId salesBookPerUser merchantProcessor clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Facade methodsFor: 'initialization' stamp: 'MA 11/5/2022 20:39:48'!
initializeNewWithValidator: aCredentialValidator withPriceList: aPriceList withMerchantProcessor: aMerchantProcessor withClock: aClock     

	credentialValidator := aCredentialValidator.
	priceList := aPriceList.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	cartSessionByCartId := Dictionary new.
	nextCartSessionId := 1.
	salesBookPerUser := Dictionary new.! !


!Facade methodsFor: 'list' stamp: 'MA 11/6/2022 19:42:54'!
listCart: cartId 
	
	^(self findCartSession: cartId) withCartDo: [ :cart | cart items ].! !

!Facade methodsFor: 'list' stamp: 'MA 11/6/2022 16:37:08'!
listPurchasesForUserId: anUserId withPassword: aPassword 
	
	| salesBooks |

	self validateUser: anUserId password: aPassword.
	salesBooks := salesBookPerUser at: anUserId ifAbsent: [OrderedCollection new].
	^salesBooks inject: OrderedCollection new into: [ :items :salesBook | 
		items addAll: salesBook items. 
		items 
	].
	! !


!Facade methodsFor: 'add' stamp: 'MA 11/6/2022 19:31:40'!
add: aQuantity of: anItem to: aCartId

	(self findCartSession: aCartId) withCartDo: [ :cart | cart add: aQuantity of: anItem ]! !


!Facade methodsFor: 'create cart' stamp: 'MA 11/5/2022 19:50:22'!
createCartWithUser: anUser password: aPassword 

	self validateUser: anUser password: aPassword.
	^self createNewCartSessionFor: anUser.! !


!Facade methodsFor: 'validations' stamp: 'MA 11/3/2022 20:57:37'!
validateUser: anUser password: aPassword

	^ (credentialValidator isValidUser: anUser withPassword: aPassword) 
		ifFalse: [self error: self class invalidCredentialsErrorMessage]! !


!Facade methodsFor: 'persistence private' stamp: 'MA 11/6/2022 19:15:04'!
createNewCartSessionFor: anUserId

	| newCartSessionId cartSession |
	
	newCartSessionId := nextCartSessionId.
	cartSession := CartSession withCart: (Cart acceptingItemsOf: priceList) forUserId: anUserId withClock: clock.
	cartSessionByCartId at: newCartSessionId put: cartSession.
	nextCartSessionId := nextCartSessionId + 1.
	^newCartSessionId. ! !

!Facade methodsFor: 'persistence private' stamp: 'MA 11/5/2022 20:00:45'!
findCartSession: aCartId
	
	^cartSessionByCartId at: aCartId ifAbsent: [ self error: self class cartNotFoundErrorMessage ].! !


!Facade methodsFor: 'checkout' stamp: 'MA 11/6/2022 19:52:03'!
checkoutCart: aCartId withCcn: aCcn withCced: aCced withCco: aCco 
	
	| creditCard salesBook cashier |
	
	(self findCartSession: aCartId) withCartDo: [ :cart | 
		creditCard := CreditCard expiringOn: aCced withNumber: aCcn withOwner: aCco.
		salesBook := salesBookPerUser at: ((self findCartSession: aCartId) userId) ifAbsent: [ | newSalesBook | 
			newSalesBook := OrderedCollection new.
			salesBookPerUser at: ((self findCartSession: aCartId) userId) put: newSalesBook.
			newSalesBook
		].
	
		cashier := Cashier toCheckout: cart
						     charging: creditCard 
						     throught: merchantProcessor 
						     on: clock now
						     registeringOn: salesBook.
		cashier checkOut.
	]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Facade class' category: 'TusLibros'!
Facade class
	instanceVariableNames: ''!

!Facade class methodsFor: 'error messages' stamp: 'MA 11/4/2022 20:20:32'!
cartNotFoundErrorMessage
	
	^'cart not found'.! !

!Facade class methodsFor: 'error messages' stamp: 'MA 11/3/2022 19:40:33'!
invalidCredentialsErrorMessage
	
	^'Invalid credentials'.! !


!Facade class methodsFor: 'instance creation' stamp: 'MA 11/5/2022 19:36:54'!
newWithValidator: aCredentialValidator withPriceList: aPriceList withMerchantProcessor: aMerchantProcessor withClock: aClock     

	^self new initializeNewWithValidator: aCredentialValidator withPriceList: aPriceList withMerchantProcessor: aMerchantProcessor withClock: aClock ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MA 11/5/2022 19:14:07'!
initializeTotal: aTotal with: someItems

	total := aTotal. 
	items := someItems.! !


!Sale methodsFor: 'accessing' stamp: 'MA 11/5/2022 20:07:42'!
items

	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MA 11/5/2022 19:13:02'!
of: aTotal with: items

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal with: items.
	 ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:25:16'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredCreditCardMonth 
			     withNumber: self validCreditCardNumber 
			     withOwner: self validCreditCardOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:24:20'!
expiredCreditCardMonth

	^ Month month: now monthIndex year: now yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:25:51'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredCreditCardMonth 
			     withNumber: self validCreditCardNumber 
			     withOwner: self validCreditCardOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:25:48'!
notExpiredCreditCardMonth

	^ Month month: now monthIndex year: now yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:24:49'!
validCreditCardNumber

	^ '1234567812345678'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'MA 11/5/2022 20:25:04'!
validCreditCardOwner

	^ 'Hernan Wilkinson'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'MA 11/5/2022 20:22:31'!
initialize

	now := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'MA 11/5/2022 20:22:31'!
now
	
	^ now! !
