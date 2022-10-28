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


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'MA 10/27/2022 20:55:23'!
isEmpty
	^books isEmpty.! !


!Cart methodsFor: 'add' stamp: 'MA 10/27/2022 21:05:16'!
add: anISBN

	(catalog includes: anISBN) ifFalse: [self error: self class cannotAddExternalBookErrorMessage].	
	books add: anISBN.! !


!Cart methodsFor: 'initialization' stamp: 'MA 10/27/2022 20:55:03'!
initialize

	books := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'MA 10/27/2022 21:03:19'!
initializeWith: aCatalog 

	catalog := aCatalog.! !


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
