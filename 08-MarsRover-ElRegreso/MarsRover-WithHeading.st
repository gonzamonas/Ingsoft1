!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:23:05'!
test01NoLoggingWhenProcessingEmptyCommand

	|marsRover logger stream |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	stream := ReadWriteStream with: ''.
	logger := MarsRoverLogger logPositionFor: marsRover in: stream.
	marsRover process: ''.
	self assert: stream isEmpty.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:23:05'!
test02PositionLoggerLogsPositionWhenMovingForward

	|marsRover logger stream |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	stream := ReadWriteStream with: ''.
	logger := MarsRoverLogger logPositionFor: marsRover in: stream.
	marsRover process: 'f'.
	self assert: '0@1
' equals: stream contents.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:23:05'!
test03PositionLoggerLogsPositionWhenMovingBackwards

	|marsRover logger stream |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	stream := ReadWriteStream with: ''.
	logger := MarsRoverLogger logPositionFor: marsRover in: stream.
	marsRover process: 'b'.
	self assert: '0@ -1
' equals: stream contents.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:23:05'!
test04HeadingLoggerLogsAllPossibleHeadingsWhenRotating

	|marsRover stream expectedLog |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	stream := ReadWriteStream with: ''.
	MarsRoverLogger logHeadingFor: marsRover in: stream.
	marsRover process: 'rrrr'.
	expectedLog := 'East
South
West
North
'.
	self assert: expectedLog equals: stream contents.! !

!MarsRoverLoggerTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:23:05'!
test05PositionAndHeadingLoggerLogsPositionsAndHeadings

	|marsRover stream expectedLog |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	stream := ReadWriteStream with: ''.
	MarsRoverLogger logPositionAndHeadingFor: marsRover in: stream.
	marsRover process: 'frrb'.
	expectedLog := '0@1
East
South
0@2
'.
	self assert: expectedLog equals: stream contents.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:29:06'!
test01WindowShowsPositionEmptyWhenProcessingNoCommands

	|marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow logPositionFor: marsRover.
	marsRover process: ''.
	self assert: window position isEmpty.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:28:53'!
test02PositionWindowShowsFinalPositionWhenMovingMultipleTimes

	|marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow logPositionFor: marsRover.
	marsRover process: 'fb'.
	self assert: '0@0' equals: window position.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:30:05'!
test03HeadingWindowShowsFinalHeadingWhenRotatingTwice

	|marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow logHeadingFor: marsRover.
	marsRover process: 'rr'.
	self assert: 'South' equals: window heading.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'GM 10/27/2022 14:29:54'!
test04PositionAndHeadingWindowShowsFinalPositionAndHeading

	|marsRover window |
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow logPositionAndHeadingFor: marsRover.
	marsRover process: 'bbll'.
	self assert: '0@ -2' equals: window position.
	self assert: 'South' equals: window heading.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionUpdatesSubscriptions headingUpdatesSubscriptions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'GM 10/27/2022 14:34:15'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionUpdatesSubscriptions := Bag new.
	headingUpdatesSubscriptions := Bag new.! !


!MarsRover methodsFor: 'heading' stamp: 'GM 10/25/2022 18:28:26'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	self notifyHeadingUpdate: 'East'.! !

!MarsRover methodsFor: 'heading' stamp: 'GM 10/25/2022 18:42:13'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	self notifyHeadingUpdate: 'North'.! !

!MarsRover methodsFor: 'heading' stamp: 'GM 10/25/2022 18:36:09'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	self notifyHeadingUpdate: 'South'.! !

!MarsRover methodsFor: 'heading' stamp: 'GM 10/25/2022 18:41:58'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	self notifyHeadingUpdate: 'West'.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'GM 10/25/2022 18:24:46'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'GM 10/25/2022 18:15:34'!
moveBackward
	
	head moveBackward.
	self notifyPositionUpdate! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'GM 10/25/2022 18:08:50'!
moveForward
	
	head moveForward.
	self notifyPositionUpdate.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'logging' stamp: 'GM 10/25/2022 18:30:08'!
notifyHeadingUpdate: aHeadingString
	
	headingUpdatesSubscriptions do: [:aHeadingUpdateHandler | aHeadingUpdateHandler value: aHeadingString] 
	
	! !

!MarsRover methodsFor: 'logging' stamp: 'GM 10/25/2022 18:09:45'!
notifyPositionUpdate
	
	positionUpdatesSubscriptions do: [:aPositionUpdateHandler | aPositionUpdateHandler value: position]! !

!MarsRover methodsFor: 'logging' stamp: 'GM 10/25/2022 18:32:57'!
subscribeToHeadingUpdates: aHandlerForAHeadingUpdate 
	
	headingUpdatesSubscriptions add: aHandlerForAHeadingUpdate! !

!MarsRover methodsFor: 'logging' stamp: 'GM 10/25/2022 18:06:27'!
subscribeToPositionUpdates: aHandlerForAPositionUpdate 
	
	positionUpdatesSubscriptions add: aHandlerForAPositionUpdate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'marsRover log readWriteStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'GM 10/25/2022 18:53:43'!
initializeLogHeadingFor: aMarsRover in: aLog 
	
	log := aLog.
	self subscribeToHeadingUpdates: aMarsRover! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'GM 10/25/2022 18:53:31'!
initializeLogPositionAndHeadingFor: aMarsRover in: aLog 
	
	log := aLog.
	self subscribeToPositionUpdates: aMarsRover.
	self subscribeToHeadingUpdates: aMarsRover.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'GM 10/25/2022 18:53:56'!
initializeLogPositionFor: aMarsRover in: aLog 
	
	log := aLog.
	self subscribeToPositionUpdates: aMarsRover.! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'GM 10/25/2022 18:51:55'!
subscribeToHeadingUpdates: aMarsRover

	^ aMarsRover subscribeToHeadingUpdates: [:heading | self log: heading]! !

!MarsRoverLogger methodsFor: 'initialization' stamp: 'GM 10/25/2022 18:52:25'!
subscribeToPositionUpdates: aMarsRover

	^ aMarsRover subscribeToPositionUpdates: [:position | self log: position]! !


!MarsRoverLogger methodsFor: 'logging' stamp: 'GM 10/25/2022 18:47:27'!
log: aStringToLog

	log nextPutAll: aStringToLog asString; newLine.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 18:18:48'!
logHeadingFor: aMarsRover in: aReadWriteStream 
	
	^self new initializeLogHeadingFor: aMarsRover in: aReadWriteStream ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 18:50:07'!
logPositionAndHeadingFor: aMarsRover in: aLog 
	
	^self new initializeLogPositionAndHeadingFor: aMarsRover in: aLog ! !

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 17:57:10'!
logPositionFor: aMarsRover in: aReadWriteStream 
	
	^self new initializeLogPositionFor: aMarsRover in: aReadWriteStream ! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRover position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'GM 10/25/2022 19:15:18'!
initializeLogHeadingFor: aMarsRover 
	
	heading := ''.
	self subscribeToHeadingUpdates: aMarsRover! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'GM 10/25/2022 19:15:47'!
initializeLogPositionAndHeadingFor: aMarsRover 
	
	position := ''.
	heading := ''.
	self subscribeToPositionUpdates: aMarsRover.
	self subscribeToHeadingUpdates: aMarsRover.! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'GM 10/25/2022 19:14:41'!
initializeLogPositionFor: aMarsRover 
	
	position := ''.
	self subscribeToPositionUpdates: aMarsRover! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'GM 10/25/2022 19:15:18'!
subscribeToHeadingUpdates: aMarsRover

	^ aMarsRover subscribeToHeadingUpdates: [:aHeading | heading := aHeading asString]! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'GM 10/25/2022 19:14:41'!
subscribeToPositionUpdates: aMarsRover

	^ aMarsRover subscribeToPositionUpdates: [:aPosition | position := aPosition asString]! !


!MarsRoverWindow methodsFor: 'position' stamp: 'GM 10/25/2022 19:07:54'!
position

	^position! !


!MarsRoverWindow methodsFor: 'heading' stamp: 'GM 10/25/2022 19:11:09'!
heading
	
	^heading! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 19:09:21'!
logHeadingFor: aMarsRover 
	
	^self new initializeLogHeadingFor: aMarsRover ! !

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 19:13:11'!
logPositionAndHeadingFor: aMarsRover 
	
	^self new initializeLogPositionAndHeadingFor: aMarsRover ! !

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'GM 10/25/2022 19:02:24'!
logPositionFor: aMarsRover 
	
	^self new initializeLogPositionFor: aMarsRover ! !
