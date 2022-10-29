!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/27/2022 20:45:08'!
test01NewCartIsEmpty

	|cart|
	
	cart := Cart new.
	self assert: cart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/27/2022 21:06:10'!
test02CartWithAddedBookHasIt

	| cart catalog |
	
	catalog := OrderedCollection with: 'book1'.
	cart := Cart with: catalog.
	cart add: 'book1'. 
	self deny: cart isEmpty.
	self assert: cart books includes: 'book1'.
	self assert: cart books size equals: 1.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/27/2022 21:06:26'!
test03CannotAddBookFromAnotherEditorialToCart

	| cart catalog |
	
	catalog := OrderedCollection with: 'book1'.
	cart := Cart with: catalog.
	self should: [cart add: 'bookFromExternalEditorial'] 
		raise: Error 
		withMessageText: Cart cannotAddExternalBookErrorMessage. ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/29/2022 19:20:21'!
test04CanAddMultipleBooksAtTheSameTimeToACart

	| cart catalog |
	
	catalog := OrderedCollection with: 'book1'.
	cart := Cart with: catalog.
	cart add: 'book1' times: 2.
	self assert: (cart books occurrencesOf: 'book1') equals: 2! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/29/2022 19:27:00'!
test05CannotAddZeroBooksToACart

	| cart catalog |
	
	catalog := OrderedCollection with: 'book1'.
	cart := Cart with: catalog.
	self should: [cart add: 'book1' times: 0] 
		raise: Error 
		withMessageText: Cart cannotAddNonPositiveBooksErrorMessage. ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'MA 10/29/2022 19:26:14'!
test06CannotAddNegativeBooksToACart

	| cart catalog |
	
	catalog := OrderedCollection with: 'book1'.
	cart := Cart with: catalog.
	self should: [cart add: 'book1' times: -1] 
		raise: Error 
		withMessageText: Cart cannotAddNonPositiveBooksErrorMessage. ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'MA 10/27/2022 20:55:23'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'add' stamp: 'MA 10/29/2022 19:19:27'!
add: anISBN

	self add: anISBN times: 1.! !

!Cart methodsFor: 'add' stamp: 'MA 10/29/2022 19:28:00'!
add: anISBN times: aQuantity 

	self assertQuantityIsPositive: aQuantity.
	self assertBooksIsInCatalog: anISBN.	
	
	books add: anISBN withOccurrences: aQuantity.! !


!Cart methodsFor: 'initialization' stamp: 'MA 10/29/2022 19:18:13'!
initialize

	books := Bag new.! !

!Cart methodsFor: 'initialization' stamp: 'MA 10/27/2022 21:03:19'!
initializeWith: aCatalog 

	catalog := aCatalog.! !


!Cart methodsFor: 'asserts private' stamp: 'MA 10/29/2022 19:23:03'!
assertBooksIsInCatalog: anISBN

	^ (catalog includes: anISBN) ifFalse: [self error: self class cannotAddExternalBookErrorMessage]! !

!Cart methodsFor: 'asserts private' stamp: 'MA 10/29/2022 19:28:00'!
assertQuantityIsPositive: aQuantity

	^ (aQuantity < 1) ifTrue: [self error: self class cannotAddNonPositiveBooksErrorMessage]! !


!Cart methodsFor: 'accessing' stamp: 'MA 10/27/2022 20:55:46'!
books
	^books! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'MA 10/27/2022 21:03:09'!
with: aCatalog 
	^self new initializeWith: aCatalog! !


!Cart class methodsFor: 'error messages' stamp: 'MA 10/27/2022 21:03:53'!
cannotAddExternalBookErrorMessage
	^'cannot add external book'.! !

!Cart class methodsFor: 'error messages' stamp: 'MA 10/29/2022 19:24:37'!
cannotAddNegativeBooksErrorMessage
	^'cannot add negative books'.! !

!Cart class methodsFor: 'error messages' stamp: 'MA 10/29/2022 19:26:36'!
cannotAddNonPositiveBooksErrorMessage
	
	^'cannot add non positive books'.! !

!Cart class methodsFor: 'error messages' stamp: 'MA 10/29/2022 19:21:31'!
cannotAddZeroBooksErrorMessage
	
	^'cannot add zero books'.! !
