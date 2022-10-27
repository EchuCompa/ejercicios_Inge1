!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:25'!
test01LogOnlyPositionNoCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionLogger for: marsRover .	
	
	marsRover process: ''.
		
	self assert: logger logs equals: OrderedCollection new.
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:30'!
test02LogOnlyPositionOneCommand
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionLogger for: marsRover.
	
	marsRover process: 'f'.
	
	self assert: logger logs equals: (OrderedCollection with: (1@2)).
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:35'!
test03LogOnlyDirectionNoCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  DirectionLogger for: marsRover .	
	
	marsRover process: ''.
		
	self assert: logger logs equals: OrderedCollection new.
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:39'!
test04LogOnlyDirectionOneCommand
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  DirectionLogger for: marsRover .	
	
	marsRover process: 'r'.
		
	self assert: logger logs equals: (OrderedCollection with:'East').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:43'!
test05LogOnlyPositionAllCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionLogger for: marsRover.
	
	marsRover process: 'fbrl'.
	
	self assert: logger logs equals: (OrderedCollection with: (1@2) with: 1@1).
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:48'!
test06LogOnlyDirectionAllCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  DirectionLogger for: marsRover .	
	
	marsRover process: 'rlbf'.
		
	self assert: logger logs equals: (OrderedCollection with:'East' with:'North').
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 15:59:56'!
test07LogDirectionAndPositionNoCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionAndDirectionLogger for: marsRover.	
	
	marsRover process: ''.
		
	self assert: logger logs equals: (OrderedCollection new).
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 16:00:01'!
test08LogDirectionAndPositionOneCommand
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionAndDirectionLogger for: marsRover.	
	
	marsRover process: 'f'.
		
	self assert: logger logs equals: (OrderedCollection with:1@2).
! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'E 10/27/2022 16:00:06'!
test09LogDirectionAndPositionAllCommands
	| logger initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	logger :=  PositionAndDirectionLogger for: marsRover.	
	
	marsRover process: 'fl'.
		
	self assert: logger logs equals: (OrderedCollection with:1@2 with:'West').
! !


!MarsRoverLogTest methodsFor: 'headings' stamp: 'E 10/24/2022 20:01:26'!
east
	^ MarsRoverHeadingEast ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'E 10/24/2022 20:00:56'!
north
	^ MarsRoverHeadingNorth ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'E 10/24/2022 20:00:46'!
south
	^ MarsRoverHeadingSouth ! !

!MarsRoverLogTest methodsFor: 'headings' stamp: 'E 10/24/2022 20:01:36'!
west
	^ MarsRoverHeadingWest ! !


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

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'E 10/27/2022 16:10:36'!
east
	^ MarsRoverHeadingEast ! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'E 10/27/2022 16:10:29'!
north
	^ MarsRoverHeadingNorth ! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'E 10/27/2022 16:10:50'!
south
	^ MarsRoverHeadingSouth ! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'E 10/27/2022 16:11:15'!
west
	^ MarsRoverHeadingWest ! !


!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:13:53'!
test01WindowOnlyPositionNoCommands
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  PositionWindow for: marsRover .	
	
	marsRover process: ''.
		
	self assert: window displayPosition equals: ''.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:22:25'!
test02WindowOnlyPositionOneCommand
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  PositionWindow for: marsRover .	
	
	marsRover process: 'f'.
		
	self assert: window displayPosition equals: 1@2.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:22:49'!
test03WindowOnlyPositionAllCommands
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  PositionWindow for: marsRover .	
	
	marsRover process: 'flrb'.
		
	self assert: window displayPosition equals: 1@1.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:27:14'!
test04WindowOnlyDirectionNoCommands
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  DirectionWindow for: marsRover .	
	
	marsRover process: ''.
		
	self assert: window displayDirection equals: ''.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:32:40'!
test05WindowOnlyDirectionOneCommand
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  DirectionWindow for: marsRover .	
	
	marsRover process: 'l'.
		
	self assert: window displayDirection equals: 'Apuntando al Oeste'.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:35:48'!
test06WindowOnlyDirectionAllCommands
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  DirectionWindow for: marsRover .	
	
	marsRover process: 'lllrbf'.
		
	self assert: window displayDirection equals: 'Apuntando al Sur'.! !

!MarsRoverWindowTest methodsFor: 'testing' stamp: 'E 10/27/2022 16:39:09'!
test07WindowPositionAndDirectionAllCommands
	| window initialPosition marsRover |
	
	initialPosition := 1@1.
	marsRover := MarsRover at: initialPosition heading: self north. 
	window :=  PositionAndDirectionWindow for: marsRover .	
	
	marsRover process: 'lllrbf'.
		
	self assert: window displayDirection equals: 'Apuntando al Sur'.
	self assert: window displayPosition equals: 1@1.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head headObservers positionObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'E 10/27/2022 15:52:30'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionObservers := OrderedCollection new.
	headObservers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'E 10/27/2022 15:52:07'!
rotateLeft
	
	head rotateLeft.

	headObservers do: [:logger | logger directionClosure value: head].! !

!MarsRover methodsFor: 'heading' stamp: 'E 10/27/2022 15:52:07'!
rotateRight
	
	head rotateRight.
	
	headObservers do: [:logger | logger directionClosure value: head].
! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'E 10/27/2022 16:31:27'!
isBackwardCommand: aCommand

	^aCommand = $b ! !

!MarsRover methodsFor: 'testing' stamp: 'E 10/27/2022 16:31:25'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'E 10/27/2022 16:31:22'!
isRotateLeftCommand: aCommand

	^aCommand = $l  ! !

!MarsRover methodsFor: 'testing' stamp: 'E 10/27/2022 16:31:20'!
isRotateRightCommand: aCommand

	^aCommand = $r ! !


!MarsRover methodsFor: 'moving' stamp: 'E 10/27/2022 15:49:27'!
moveBackward
	
	head moveBackward.
	positionObservers do: [:logger | logger positionClosure value: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'E 10/24/2022 21:53:59'!
moveEast
	
	position := position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'E 10/27/2022 15:49:42'!
moveForward
	
	head moveForward.
	positionObservers do: [:logger | logger positionClosure value: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'E 10/24/2022 21:53:41'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'E 10/24/2022 20:12:32'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [. ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].
	
	self signalInvalidCommand.! !


!MarsRover methodsFor: 'logging' stamp: 'E 10/27/2022 15:52:07'!
addDirectionObserver: anObserver 
	headObservers add: anObserver.! !

!MarsRover methodsFor: 'logging' stamp: 'E 10/27/2022 15:37:40'!
addPositionObserver: anObserver 
	positionObservers add: anObserver.! !

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


!classDefinition: #Observer category: 'MarsRover-WithHeading'!
Object subclass: #Observer
	instanceVariableNames: 'positionClosure directionClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Observer methodsFor: 'loggin' stamp: 'E 10/27/2022 15:57:03'!
directionClosure
	^directionClosure .! !

!Observer methodsFor: 'loggin' stamp: 'E 10/27/2022 15:56:58'!
positionClosure
	^positionClosure .! !


!Observer methodsFor: 'instance creation' stamp: 'E 10/27/2022 15:57:31'!
initializeFor: aMarsRover

	self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Observer class' category: 'MarsRover-WithHeading'!
Observer class
	instanceVariableNames: ''!

!Observer class methodsFor: 'instance creation' stamp: 'E 10/27/2022 16:14:39'!
for: aMarsRover 
	^self new initializeFor: aMarsRover . ! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
Observer subclass: #Logger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'initialize' stamp: 'E 10/27/2022 15:46:43'!
initializeFor: aMarsRover

	self subclassResponsibility.
! !


!Logger methodsFor: 'accesing' stamp: 's 10/25/2022 17:40:49'!
logs
	^logs! !


!Logger methodsFor: 'loggin' stamp: 's 10/25/2022 18:08:20'!
log: aValueToLog
	logs add: aValueToLog .! !


!classDefinition: #DirectionLogger category: 'MarsRover-WithHeading'!
Logger subclass: #DirectionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!DirectionLogger methodsFor: 'initialize' stamp: 'E 10/27/2022 15:54:16'!
initializeFor: aMarsRover 
	
	logs := OrderedCollection new.

	aMarsRover addDirectionObserver: self.
	directionClosure := [:aDirection| 
		|value|
		(aDirection isKindOf: MarsRoverHeadingNorth) ifTrue: [value := 'North'].
	(aDirection isKindOf: MarsRoverHeadingEast ) ifTrue: [value :=  'East'].
	(aDirection isKindOf: MarsRoverHeadingSouth ) ifTrue: [value := 'South'].
	(aDirection isKindOf: MarsRoverHeadingWest ) ifTrue: [value := 'West'].
		self log: value ] .! !


!classDefinition: #PositionAndDirectionLogger category: 'MarsRover-WithHeading'!
Logger subclass: #PositionAndDirectionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionAndDirectionLogger methodsFor: 'initialize' stamp: 'E 10/27/2022 15:53:31'!
initializeFor: aMarsRover 
	
	logs := OrderedCollection new.

	aMarsRover addDirectionObserver: self.
	aMarsRover addPositionObserver: self.
	directionClosure:= [:aDirection| 
		|value|
	value:= aDirection.
	(aDirection isKindOf: MarsRoverHeadingNorth) ifTrue: [value := 'North'].
	(aDirection isKindOf: MarsRoverHeadingEast ) ifTrue: [value :=  'East'].
	(aDirection isKindOf: MarsRoverHeadingSouth ) ifTrue: [value := 'South'].
	(aDirection isKindOf: MarsRoverHeadingWest ) ifTrue: [value := 'West'].
		self log: value ] .
	positionClosure:= [:aPosition | self log: aPosition ] .! !


!classDefinition: #PositionLogger category: 'MarsRover-WithHeading'!
Logger subclass: #PositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogger methodsFor: 'initialize' stamp: 'E 10/27/2022 15:47:37'!
initializeFor: aMarsRover
	
	logs := OrderedCollection new.
	aMarsRover addPositionObserver: self.
	positionClosure:= [:aPosition | self log: aPosition ] .
! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
Observer subclass: #Window
	instanceVariableNames: 'displayPosition displayDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'accesing' stamp: 'E 10/27/2022 16:08:29'!
displayDirection
	^displayDirection ! !

!Window methodsFor: 'accesing' stamp: 'E 10/27/2022 16:08:09'!
displayPosition
	^displayPosition ! !


!Window methodsFor: 'instance creation' stamp: 'E 10/27/2022 16:19:06'!
initializeFor: aMarsRover

	self subclassResponsibility.
! !


!Window methodsFor: 'updateState' stamp: 'E 10/27/2022 16:34:00'!
updateDirection: aDirection 
	displayDirection := aDirection.! !

!Window methodsFor: 'updateState' stamp: 'E 10/27/2022 16:21:03'!
updatePosition: aPosition
	displayPosition := aPosition! !


!classDefinition: #DirectionWindow category: 'MarsRover-WithHeading'!
Window subclass: #DirectionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!DirectionWindow methodsFor: 'instance creation' stamp: 'E 10/27/2022 16:34:31'!
initializeFor: aMarsRover
	
	displayDirection := ''.
	aMarsRover addDirectionObserver: self.
	directionClosure := [:aDirection| 
		|value|
		(aDirection isKindOf: MarsRoverHeadingNorth) ifTrue: [value := 'Norte'].
		(aDirection isKindOf: MarsRoverHeadingEast ) ifTrue: [value :=  'Este'].
		(aDirection isKindOf: MarsRoverHeadingSouth ) ifTrue: [value := 'Sur'].
		(aDirection isKindOf: MarsRoverHeadingWest ) ifTrue: [value := 'Oeste'].
		self updateDirection: 'Apuntando al ', value. ] .! !


!classDefinition: #PositionAndDirectionWindow category: 'MarsRover-WithHeading'!
Window subclass: #PositionAndDirectionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionAndDirectionWindow methodsFor: 'instance creation' stamp: 'E 10/27/2022 16:38:34'!
initializeFor: aMarsRover
	
	displayDirection := ''.
	displayPosition := ''.
	aMarsRover addDirectionObserver: self.
	aMarsRover addPositionObserver: self.
	directionClosure := [:aDirection| 
		|value|
		(aDirection isKindOf: MarsRoverHeadingNorth) ifTrue: [value := 'Norte'].
		(aDirection isKindOf: MarsRoverHeadingEast ) ifTrue: [value :=  'Este'].
		(aDirection isKindOf: MarsRoverHeadingSouth ) ifTrue: [value := 'Sur'].
		(aDirection isKindOf: MarsRoverHeadingWest ) ifTrue: [value := 'Oeste'].
		self updateDirection: 'Apuntando al ', value. ] .
	positionClosure:= [:aPosition | self updatePosition: aPosition ] .! !


!classDefinition: #PositionWindow category: 'MarsRover-WithHeading'!
Window subclass: #PositionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindow methodsFor: 'instance creation' stamp: 'E 10/27/2022 16:16:39'!
initializeFor: aMarsRover
	
	displayPosition := ''.
	aMarsRover addPositionObserver: self.
	positionClosure:= [:aPosition | self updatePosition: aPosition ] .
! !
