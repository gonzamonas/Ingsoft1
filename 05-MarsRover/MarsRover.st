!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'GM 10/5/2022 22:12:54'!
assertThatMarsRoverStartingAt: aStartingPosition heading: aStartingOrientation afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalOrientation

	|marsRover|
	marsRover := MarsRover at: aStartingPosition heading: aStartingOrientation .
	marsRover process: aStringOfCommands.
	self assert: (marsRover isAt: aFinalPosition heading: aFinalOrientation).! !


!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/5/2022 22:04:36'!
test01EmptyCommandDoesntChangePositionOrHeading

	self assertThatMarsRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:23'!
test02MarsRoverHeadingNorthHeadsWestAfterProcessingL

	self assertThatMarsRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:30'!
test03MarsRoverHeadingNorthHeadsEastAfterProcessingR

	self assertThatMarsRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:34'!
test04MarsRoverHeadingEastHeadsNorthAfterProcessingL

	self assertThatMarsRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:39'!
test05MarsRoverHeadingEastHeadsSouthAfterProcessingR

	self assertThatMarsRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:49'!
test06MarsRoverHeadingSouthHeadsEastAfterProcessingL

	self assertThatMarsRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:13:54'!
test07MarsRoverHeadingSouthHeadsWestAfterProcessingR

	self assertThatMarsRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:01'!
test08MarsRoverHeadingWestHeadsSouthAfterProcessingL

	self assertThatMarsRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:06'!
test09MarsRoverHeadingWestHeadsNorthAfterProcessingR

	self assertThatMarsRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:12'!
test10MarsRoverHeadingNorthMovesNorthAfterProcessingF

	self assertThatMarsRoverStartingAt: 0@1 heading: #North afterProcessing: 'f' endsAt: 0@2 heading: #North.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:19'!
test11MarsRoverHeadingNorthMovesSouthAfterProcessingB

	self assertThatMarsRoverStartingAt: 0@-1 heading: #North afterProcessing: 'b' endsAt: 0@-2 heading: #North.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:23'!
test12MarsRoverHeadingEastMovesEastAfterProcessingF

	self assertThatMarsRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:27'!
test13MarsRoverHeadingEastMovesWestAfterProcessingB

	self assertThatMarsRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:14:53'!
test14MarsRoverHeadingSouthMovesSouthAfterProcessingF

	self assertThatMarsRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:15:02'!
test15MarsRoverHeadingSouthMovesNorthAfterProcessingB

	self assertThatMarsRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:15:06'!
test16MarsRoverHeadingWestMovesWestAfterProcessingF
	
	self assertThatMarsRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:15:12'!
test17MarsRoverHeadingWestMovesEastAfterProcessingB

	self assertThatMarsRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:15:17'!
test18MarsRoverCanProcessMultipleCommands

	self assertThatMarsRoverStartingAt: 0@0 heading: #North afterProcessing: 'ffr' endsAt: 0@2 heading: #East.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'GM 10/6/2022 16:15:22'!
test19MarsRoverCantProcessInvalidCommand
	
	|marsRover|
	marsRover := MarsRover at: 0@0 heading: #North.
	self should: [marsRover process: 'x'] raise: Error withExceptionDo: 
	[ :anError |		self assert: anError messageText equals: MarsRover invalidCommandErrorMessage]! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'GM 10/5/2022 21:09:39'!
initializeAt: aPosition heading: anOrientation 

	position := aPosition.
	heading := MarsRoverHeading for: self heading: anOrientation.! !


!MarsRover methodsFor: 'error messages' stamp: 'GM 10/5/2022 22:16:45'!
invalidCommandError

	^ 'Please enter a valid command'! !


!MarsRover methodsFor: 'processing' stamp: 'GM 10/6/2022 11:01:50'!
process: aStringOfCommands
	
	aStringOfCommands do: [ :command | self processCommand: command].
	! !

!MarsRover methodsFor: 'processing' stamp: 'GM 10/6/2022 11:11:06'!
processCommand: aCommand

	aCommand = $f ifTrue: [^heading moveForward.].
	aCommand = $b ifTrue: [^heading moveBackwards.].
	aCommand = $l ifTrue: [	^heading rotateLeft	. ].
	aCommand = $r ifTrue: [^heading rotateRight.].
	
	self error: self class invalidCommandErrorMessage.! !


!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:32:29'!
rotateLeftWhenHeadingEast

	heading := MarsRoverHeadingNorth for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:32:51'!
rotateLeftWhenHeadingNorth

	heading := MarsRoverHeadingWest for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:05'!
rotateLeftWhenHeadingSouth

	heading := MarsRoverHeadingEast for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:20'!
rotateLeftWhenHeadingWest

	heading := MarsRoverHeadingSouth for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:31'!
rotateRightWhenHeadingEast

	heading := MarsRoverHeadingSouth for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:45'!
rotateRightWhenHeadingNorth

	heading := MarsRoverHeadingEast for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:34:31'!
rotateRightWhenHeadingSouth

	heading := MarsRoverHeadingWest for: self.! !

!MarsRover methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:34:42'!
rotateRightWhenHeadingWest

	heading := MarsRoverHeadingNorth for: self.! !


!MarsRover methodsFor: 'testing' stamp: 'GM 10/5/2022 21:10:51'!
isAt: aPosition heading: anOrientation 
	
	^ aPosition = position and: (heading class isHeading: anOrientation)! !


!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:29'!
moveBackwardsHeadingEast
	
	self moveWest! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:43'!
moveBackwardsHeadingNorth
	
	self moveSouth! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:33:53'!
moveBackwardsHeadingSouth
	
	self moveNorth! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:35:56'!
moveBackwardsHeadingWest
	
	self moveEast! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:56'!
moveEast

	^ position := position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:56'!
moveForwardHeadingEast
	
	self moveEast! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:30:03'!
moveForwardHeadingNorth
	
	self moveNorth! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:32:24'!
moveForwardHeadingSouth
	
	self moveSouth! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:35:16'!
moveForwardHeadingWest
	
	self moveWest.! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:30:03'!
moveNorth

	^ position := position + (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:43'!
moveSouth

	^ position := position + (0@-1)! !

!MarsRover methodsFor: 'movement' stamp: 'GM 10/5/2022 21:29:29'!
moveWest

	^ position := position + (-1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'GM 10/5/2022 21:09:16'!
at: aPosition heading: anOrientation 
	
	^self new initializeAt: aPosition heading: anOrientation.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'GM 10/6/2022 11:42:09'!
invalidCommandErrorMessage

	^ 'Please input a valid command'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeading methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:31:27'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHeading methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:31:39'!
rotateRight

	self subclassResponsibility! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'GM 10/5/2022 20:55:37'!
initializeFor: aMarsRover

	marsRover := aMarsRover! !


!MarsRoverHeading methodsFor: 'movement' stamp: 'GM 10/5/2022 22:29:20'!
moveBackwards

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'movement' stamp: 'GM 10/5/2022 22:29:13'!
moveForward

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'testing' stamp: 'GM 10/5/2022 22:38:23'!
isHeading: anOrientation

	self subclassResponsibility! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'GM 10/5/2022 21:06:04'!
for: aMarsRover

	^ self new initializeFor: aMarsRover.! !

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'GM 10/5/2022 21:06:09'!
for: aMarsRover heading: anOrientation
	
	^ (self subclasses detect: [ :class | class isHeading: anOrientation]) new initializeFor: aMarsRover.! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingEast methodsFor: 'movement' stamp: 'GM 10/5/2022 21:26:28'!
moveBackwards
	
	marsRover moveBackwardsHeadingEast! !

!MarsRoverHeadingEast methodsFor: 'movement' stamp: 'GM 10/5/2022 21:22:23'!
moveForward

	marsRover moveForwardHeadingEast! !


!MarsRoverHeadingEast methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:32:29'!
rotateLeft

	marsRover rotateLeftWhenHeadingEast! !

!MarsRoverHeadingEast methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:31'!
rotateRight

	marsRover rotateRightWhenHeadingEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'testing' stamp: 'GM 10/3/2022 21:57:31'!
isHeading: anOrientation

	^ anOrientation = #East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingNorth methodsFor: 'movement' stamp: 'GM 10/5/2022 21:27:40'!
moveBackwards
	
	marsRover moveBackwardsHeadingNorth! !

!MarsRoverHeadingNorth methodsFor: 'movement' stamp: 'GM 10/5/2022 21:21:53'!
moveForward
	
	marsRover moveForwardHeadingNorth! !


!MarsRoverHeadingNorth methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:32:51'!
rotateLeft

	marsRover rotateLeftWhenHeadingNorth! !

!MarsRoverHeadingNorth methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:45'!
rotateRight

	marsRover rotateRightWhenHeadingNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'testing' stamp: 'GM 10/3/2022 21:58:02'!
isHeading: anOrientation

	^anOrientation = #North	! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingSouth methodsFor: 'movement' stamp: 'GM 10/5/2022 21:33:18'!
moveBackwards
	
	marsRover moveBackwardsHeadingSouth.! !

!MarsRoverHeadingSouth methodsFor: 'movement' stamp: 'GM 10/5/2022 21:32:13'!
moveForward
	
	marsRover moveForwardHeadingSouth! !


!MarsRoverHeadingSouth methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:05'!
rotateLeft

	marsRover rotateLeftWhenHeadingSouth! !

!MarsRoverHeadingSouth methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:34:31'!
rotateRight

	marsRover rotateRightWhenHeadingSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'testing' stamp: 'GM 10/5/2022 20:53:16'!
isHeading: anOrientation

	^ anOrientation = #South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeadingWest methodsFor: 'movement' stamp: 'GM 10/5/2022 21:35:46'!
moveBackwards
	
	marsRover moveBackwardsHeadingWest! !

!MarsRoverHeadingWest methodsFor: 'movement' stamp: 'GM 10/5/2022 21:35:01'!
moveForward
	
	marsRover moveForwardHeadingWest! !


!MarsRoverHeadingWest methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:33:20'!
rotateLeft

	marsRover rotateLeftWhenHeadingWest! !

!MarsRoverHeadingWest methodsFor: 'rotation' stamp: 'GM 10/5/2022 22:34:42'!
rotateRight

	marsRover rotateRightWhenHeadingWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'testing' stamp: 'GM 10/5/2022 20:53:25'!
isHeading: anOrientation

	^ anOrientation = #West! !
