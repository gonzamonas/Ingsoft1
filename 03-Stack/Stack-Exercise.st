!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'GM 9/16/2022 17:37:52'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 19:26:30'!
test01FindInEmptyStackReturnsEmpty

	|emptyStack sentenceFinder|
	emptyStack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix for: emptyStack.
	self assert: (sentenceFinder find: 'pre') isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:21:41'!
test02FindInStackWithOneSentenceWithPrefixReturnsThatSentence

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self assert: (Bag with: 'prefix') equals: (sentenceFinder find: 'pre').! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:13:42'!
test03FindInStackWithOneSentenceWithoutPrefixReturnsEmpty

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self assert: (sentenceFinder find: 'post') isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:24:39'!
test04FindInStackWithManySentencesReturnsTheSentencesWithThePrefix

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'; push: 'preorder'; push: 'post'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self assert: (Bag with: 'prefix' with: 'preorder') equals: (sentenceFinder find: 'pre').! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:29:55'!
test05CanNotFindEmptyPrefixInStack

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self should: [ sentenceFinder find: '' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription].
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:35:39'!
test06CanNotFindPrefixWithEmptySpacesInStack

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self should: [ sentenceFinder find: 'pre fix' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithEmptySpacesErrorDescription].
		! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/16/2022 18:42:47'!
test07FindPrefixIsCaseSensitive

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'; push: 'PREFIX'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	self assert: (sentenceFinder find: 'pre') equals: (Bag with: 'prefix').
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'GM 9/17/2022 01:17:52'!
test08FindMaintainsOriginalStackSentencesAndOrder

	|stack sentenceFinder|
	stack := OOStack new.
	stack push: 'prefix'; push: 'postfix'.
	sentenceFinder := SentenceFinderByPrefix for: stack.
	sentenceFinder find: 'pre'.
	self assert: stack hasSameSentencesAndOrderThan: (OOStack new push: 'prefix'; push: 'postfix').
! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'GM 9/16/2022 19:44:31'!
assert: aStack hasSameSentencesAndOrderThan: anotherStack
	self assert: anotherStack hasSameSizeThan: aStack.
	self assert: anotherStack hasSameSentencesInSameOrderThan: aStack.! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'GM 9/16/2022 19:44:26'!
assert: anotherStack hasSameSentencesInSameOrderThan: aStack

	^ [aStack isEmpty not] whileTrue: [
		self assert: aStack pop equals: anotherStack pop
		]! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'GM 9/16/2022 19:43:31'!
assert: anotherStack hasSameSizeThan: aStack

	^ self assert: aStack size equals: anotherStack size! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'values'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'GM 9/15/2022 20:41:03'!
isEmpty
	
	^values isEmpty.! !


!OOStack methodsFor: 'operations' stamp: 'GM 9/16/2022 17:31:18'!
initialize

	values := OrderedCollection new.! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/15/2022 21:45:08'!
pop
	
	self top.
	^values removeLast.! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/15/2022 20:40:39'!
push: aString 
	
	values add: aString.! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/15/2022 20:44:54'!
size

	^values size! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/16/2022 17:36:48'!
state

	^OOStackState for: self! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/16/2022 17:33:23'!
top

	^self state top.
	! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/15/2022 21:43:56'!
topFromEmptyStack
	
	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'operations' stamp: 'GM 9/16/2022 17:31:48'!
topFromNotEmptyStack
	
	^values last.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'initialization' stamp: 'GM 9/16/2022 17:26:00'!
initializeFor: aStack

	stack := aStack

	! !


!OOStackState methodsFor: 'operations' stamp: 'GM 9/16/2022 17:34:58'!
top

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'state search' stamp: 'GM 9/16/2022 17:30:15'!
canHandle: aStack
	
	self subclassResponsibility ! !


!OOStackState class methodsFor: 'instance creation' stamp: 'GM 9/16/2022 17:37:37'!
for: aStack

	^(self subclasses detect: [:subclass | subclass canHandle: aStack]) new initializeFor: aStack.! !


!classDefinition: #OOEmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #OOEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStackState methodsFor: 'operations' stamp: 'GM 9/16/2022 17:36:36'!
top

	^stack topFromEmptyStack ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyStackState class' category: 'Stack-Exercise'!
OOEmptyStackState class
	instanceVariableNames: ''!

!OOEmptyStackState class methodsFor: 'state search' stamp: 'GM 9/16/2022 17:26:40'!
canHandle: aStack
	
	^aStack isEmpty! !


!classDefinition: #OONotEmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #OONotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotEmptyStackState methodsFor: 'operations' stamp: 'GM 9/16/2022 17:36:30'!
top

	^stack topFromNotEmptyStack! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotEmptyStackState class' category: 'Stack-Exercise'!
OONotEmptyStackState class
	instanceVariableNames: ''!

!OONotEmptyStackState class methodsFor: 'state search' stamp: 'GM 9/16/2022 17:26:54'!
canHandle: aStack
	
	^aStack isEmpty not! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentenceSourceStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'GM 9/16/2022 17:46:34'!
initializeFor: aSentenceSourceStack

	sentenceSourceStack := aSentenceSourceStack
! !


!SentenceFinderByPrefix methodsFor: 'validation - private' stamp: 'GM 9/16/2022 18:48:44'!
validateNoEmptySpaces: aPrefix

	^ (aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixWithEmptySpacesErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'validation - private' stamp: 'GM 9/16/2022 18:48:19'!
validateNotEmpty: aPrefix

	^ aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription]! !

!SentenceFinderByPrefix methodsFor: 'validation - private' stamp: 'GM 9/16/2022 18:48:44'!
validatePrefix: aPrefix

	self validateNotEmpty: aPrefix.
	self validateNoEmptySpaces: aPrefix! !


!SentenceFinderByPrefix methodsFor: 'operation - private' stamp: 'GM 9/16/2022 18:56:34'!
add: aSentence to: sentencesWithPrefix ifBeginsWith: aPrefix 

	^ (aSentence beginsWith: aPrefix) ifTrue: [sentencesWithPrefix add: aSentence]! !

!SentenceFinderByPrefix methodsFor: 'operation - private' stamp: 'GM 9/16/2022 19:26:59'!
addSentencesWithPrefix: aPrefix to: sentencesWithPrefix andAddAllTo: aTemporaryStack

	^ [sentenceSourceStack isEmpty not] whileTrue: [
		|sentence|
		sentence := sentenceSourceStack pop.
		self add: sentence to: sentencesWithPrefix ifBeginsWith: aPrefix.
		aTemporaryStack push: sentence.
		]! !

!SentenceFinderByPrefix methodsFor: 'operation - private' stamp: 'GM 9/16/2022 18:59:09'!
restoreOriginalStackFrom: temporaryStack

	^ [temporaryStack isEmpty not] whileTrue: [
		sentenceSourceStack push: temporaryStack pop.
		]! !


!SentenceFinderByPrefix methodsFor: 'operation' stamp: 'GM 9/16/2022 19:04:03'!
find: aPrefix

	|sentencesWithPrefix temporaryStack|
	self validatePrefix: aPrefix.
	sentencesWithPrefix := Bag new.
	temporaryStack := OOStack new.
	
	self addSentencesWithPrefix: aPrefix to: sentencesWithPrefix andAddAllTo: temporaryStack.
	self restoreOriginalStackFrom: temporaryStack.
	
	^sentencesWithPrefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'GM 9/16/2022 18:30:24'!
emptyPrefixErrorDescription

	^'Prefix cannot be empty.'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'GM 9/16/2022 18:35:09'!
prefixWithEmptySpacesErrorDescription

	^'Prefix cannot have empty spaces.'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'GM 9/16/2022 17:47:08'!
for: aSentenceSourceStack

	^self new initializeFor: aSentenceSourceStack! !
