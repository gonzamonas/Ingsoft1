!classDefinition: #I category: 'NaturalNumbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NaturalNumbers'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 8/25/2022 20:43:03'!
next
	^II! !


!I class methodsFor: 'operations' stamp: 'MA 8/29/2022 17:00:00'!
* aMultiplier 
	^aMultiplier.! !

!I class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:12:30'!
+ anAdder

	^anAdder next! !

!I class methodsFor: 'operations' stamp: 'GM 9/2/2022 17:41:55'!
- subtrahend

	self error: self negativeNumbersNotSupportedErrorDescription ! !

!I class methodsFor: 'operations' stamp: 'GM 9/2/2022 18:26:48'!
/ aDivisor
	aDivisor = self ifTrue: [ ^I ]  ifFalse: [ self error: self canNotDivideByBiggerNumberErrorDescription ]! !

!I class methodsFor: 'operations' stamp: 'MA 8/29/2022 20:29:26'!
subtractFrom: minuend
	^minuend previous.! !


!I class methodsFor: 'error' stamp: 'GM 9/2/2022 18:27:06'!
canNotDivideByBiggerNumberErrorDescription
	^ 'Cannot divide by bigger number'! !

!I class methodsFor: 'error' stamp: 'GM 9/2/2022 18:00:17'!
negativeNumbersNotSupportedErrorDescription
	^ 'Negative numbers not supported'! !


!I class methodsFor: 'comparison' stamp: 'GM 9/2/2022 18:33:49'!
< aComparedNumber
	^ (aComparedNumber = I) not! !


!classDefinition: #II category: 'NaturalNumbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NaturalNumbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'next & previous' stamp: 'GM 9/2/2022 18:42:42'!
nameOfNext
	(self name endsWith: 'CMXCIX') ifTrue: [^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX') , 'C'].
	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX') , 'XC'].
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX') , 'XL'].
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII') , 'IX'].
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX') , 'X'].
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III') , 'IV'].
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV') , 'V'].
	^self name , 'I'! !

!II class methodsFor: 'next & previous' stamp: 'MA 8/29/2022 21:17:23'!
next
	next ifNil:[
		next _ II createChildNamed: self nameOfNext.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:21:12'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:25:57'!
previous: aNumber 

	previous := aNumber! !

!II class methodsFor: 'next & previous' stamp: 'MA 8/29/2022 21:31:36'!
replaceIfEnds: endsWith with: replaceWith 

	^ (self name endsWith: endsWith) ifTrue: [(self name withoutSuffix: endsWith) , replaceWith]! !


!II class methodsFor: 'remove all next' stamp: 'ARM 8/25/2022 21:37:56'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'operations' stamp: 'MA 8/29/2022 17:01:33'!
* aMultiplier
	^previous  * aMultiplier + aMultiplier. ! !

!II class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:19:09'!
+ anAdder 

	^self previous + anAdder next! !

!II class methodsFor: 'operations' stamp: 'MA 8/29/2022 20:27:58'!
- subtrahend 
	
	^subtrahend subtractFrom: self! !

!II class methodsFor: 'operations' stamp: 'GM 9/2/2022 18:37:21'!
/ aDivisor
	self = aDivisor 	ifTrue: [ ^I ].
	self < aDivisor ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription].
	^self - aDivisor / aDivisor + I! !

!II class methodsFor: 'operations' stamp: 'MA 8/29/2022 20:33:13'!
subtractFrom: aMinuend
	^aMinuend previous - previous.! !


!II class methodsFor: 'error' stamp: 'GM 9/2/2022 17:49:05'!
canNotDivideByBiggerNumberErrorDescription
	^ 'Cannot divide by bigger number'! !


!II class methodsFor: 'comparison' stamp: 'GM 9/2/2022 18:35:24'!
< aComparedNumber
	aComparedNumber = I ifTrue: [^false].
	^ (self previous) < (aComparedNumber previous)! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'GM 9/2/2022 18:45:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'NaturalNumbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NaturalNumbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'GM 9/2/2022 18:45:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'NaturalNumbers'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'NaturalNumbers'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'GM 9/2/2022 18:45:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!