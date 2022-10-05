!classDefinition: #TestMarsRover category: 'Actividad MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!TestMarsRover methodsFor: 'robot creation' stamp: 'e 10/4/2022 20:53:15'!
robotPointingEast

	^ MarsRover positionedIn: 1@1 withDirection: $E! !

!TestMarsRover methodsFor: 'robot creation' stamp: 'e 10/4/2022 20:50:40'!
robotPointingNorth

	^ MarsRover positionedIn: 1@1 withDirection: $N! !


!TestMarsRover methodsFor: 'robot actions' stamp: 'e 10/4/2022 20:54:55'!
moveForward: marsRover

	^ marsRover do: 'f'! !

!TestMarsRover methodsFor: 'robot actions' stamp: 'e 10/4/2022 20:51:31'!
rotateLeft: marsRover

	^ marsRover do: 'l'! !


!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:51:31'!
test01changeOfDirectionDoesNotMoveRobot
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self rotateLeft: marsRover.
	
	self assert: (marsRover isAt: 1@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:51:31'!
test02changeOfDirectionModifiesDirection
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self rotateLeft: marsRover.
	
	self deny: (marsRover isPointingTo: $N).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:51:31'!
test03Rotate90DegreesLeftChangesNorthToWest
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self rotateLeft: marsRover.
	
	self assert: (marsRover isPointingTo: $W).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:51:31'!
test04Rotate90DegreesLeftChangesWestToSouth
	|marsRover|
	
	marsRover := MarsRover positionedIn: 1@1 withDirection: $W.
	
	self rotateLeft: marsRover.
	
	self assert: (marsRover isPointingTo: $S).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test05Rotate90DegreesRightChangesNorthToEast
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'r'.
	
	self assert: (marsRover isPointingTo: $E).! !

!TestMarsRover methodsFor: 'tests' stamp: 's 10/4/2022 16:14:04'!
test06Rotate90DegreesRightChangesWestToNorth
	|marsRover|
	
	marsRover := MarsRover positionedIn: 1@1 withDirection: $W.
	
	marsRover do: 'r'.
	
	self assert: (marsRover isPointingTo: $N).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:54:55'!
test07MovingDoesNotModifyDirection
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self moveForward: marsRover.
	
	self assert: (marsRover isPointingTo: $N).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:54:55'!
test08MovingModifiesPosition
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self moveForward: marsRover.
	
	self deny: (marsRover isAt: 1@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:54:55'!
test09MovingForwardToNorthDecrementsYAxis
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	self moveForward: marsRover.
	
	self assert: (marsRover isAt: 1@0).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:54:55'!
test10MovingForwardToEastIncrementsXAxis
	|marsRover|
	
	marsRover := self robotPointingEast.
	
	self moveForward: marsRover.
	
	self assert: (marsRover isAt: 2@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test11MovingBackwardFacingNorthIncrementsYAxis
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'b'.
	
	self assert: (marsRover isAt: 1@2).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:53:15'!
test12MovingBackwardFacingEastDecrementsXAxis
	|marsRover|
	
	marsRover := self robotPointingEast.
	
	marsRover do: 'b'.
	
	self assert: (marsRover isAt: 0@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test13TwoChangesOfDirectionDoesNotMoveRobot
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'lr'.
	
	self assert: (marsRover isAt: 1@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test14ManyChangesOfDirectionDoesNotMoveRobot
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'lrlrlrlrrllll'.
	
	self assert: (marsRover isAt: 1@1).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test15Rotate180DegreesChangesNorthToSouth
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'll'.
	
	self assert: (marsRover isPointingTo: $S).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test16Rotate360DegreesDoesNotChangeDirection
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'rrrr'.
	
	self assert: (marsRover isPointingTo: $N).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test17MovingManyTimesDoesNotModifyDirection
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'ffb'.
	
	self assert: (marsRover isPointingTo: $N).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test18MovingTwoTimesBackwardFacingNorthIncrementsYAxis
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'bb'.
	
	self assert: (marsRover isAt: 1@3).! !

!TestMarsRover methodsFor: 'tests' stamp: 'e 10/4/2022 20:50:40'!
test19MovingAndRotatingALotEndsWell
	|marsRover|
	
	marsRover := self robotPointingNorth.
	
	marsRover do: 'bblffrrbbffffrff'.
	
	self assert: (marsRover isAt: 1@5).! !

!TestMarsRover methodsFor: 'tests' stamp: 's 10/4/2022 17:17:46'!
test20EmptySequenceDoesNothing
	|marsRover|
	
	marsRover := MarsRover positionedIn: 1@1 withDirection: $S.
	
	marsRover do: ''.
	
	self assert: (marsRover isAt: 1@1).
	self assert: (marsRover isPointingTo: $S).! !

!TestMarsRover methodsFor: 'tests' stamp: 's 10/4/2022 17:42:12'!
test21InvalidSequenceRaisesErrorAndStops
	|marsRover|
	
	marsRover := MarsRover positionedIn: 1@1 withDirection: $S.
	
	
	self 
		should: [ marsRover do: 'lxrllbff'. ]
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription .
	self assert: (marsRover isPointingTo: $E).
	self assert: (marsRover isAt: 1@1).
	! !


!classDefinition: #MarsRover category: 'Actividad MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'S 10/3/2022 21:25:56'!
initializePositionedIn: aPosition withDirection: aCardinalPoint 
	position := aPosition.
	direction := RobotOrientation pointingTo: aCardinalPoint.! !


!MarsRover methodsFor: 'commands -private' stamp: 's 10/4/2022 17:33:54'!
executeOne: command
	command = $l ifTrue: [direction:= direction turnLeft.].
	command = $r ifTrue: [direction:= direction turnRight.].
	command = $f ifTrue: [self moveForward.].
	command = $b ifTrue: [self moveBackward.].
	self isInvalidCommand: command.! !

!MarsRover methodsFor: 'commands -private' stamp: 's 10/4/2022 17:33:54'!
isInvalidCommand: command

	^ ('lrfb' includes: command)ifFalse:[ self error: self class invalidCommandErrorDescription.]! !

!MarsRover methodsFor: 'commands -private' stamp: 's 10/4/2022 16:46:49'!
moveBackward
	position _ position - direction whereToMove.! !

!MarsRover methodsFor: 'commands -private' stamp: 's 10/4/2022 16:37:22'!
moveForward
	position _ position + direction whereToMove.! !


!MarsRover methodsFor: 'commands' stamp: 's 10/4/2022 17:19:29'!
do: aSequenceOfCommands
	aSequenceOfCommands do: [ :command |
	self executeOne: command.].! !


!MarsRover methodsFor: 'testing' stamp: 'S 10/3/2022 21:37:01'!
isAt: aPosition
	^position = aPosition.! !

!MarsRover methodsFor: 'testing' stamp: 'S 10/3/2022 21:40:37'!
isPointingTo: aCardinalPoint
	^direction cardinalPoint = aCardinalPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Actividad MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'S 10/3/2022 20:43:47'!
positionedIn: aPosition withDirection: aCardinalPoint
	^self new initializePositionedIn: aPosition withDirection: aCardinalPoint.! !


!MarsRover class methodsFor: 'errors' stamp: 's 10/4/2022 17:26:39'!
invalidCommandErrorDescription
	^'This is an invalid command'.! !


!classDefinition: #RobotOrientation category: 'Actividad MarsRover'!
Object subclass: #RobotOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!RobotOrientation methodsFor: 'accesing' stamp: 'S 10/3/2022 21:27:01'!
cardinalPoint
	self subclassResponsibility.! !

!RobotOrientation methodsFor: 'accesing' stamp: 's 10/4/2022 16:37:59'!
whereToMove
	self subclassResponsibility .! !


!RobotOrientation methodsFor: 'change direction' stamp: 'S 10/3/2022 21:59:21'!
turnLeft
	^self subclassResponsibility.! !

!RobotOrientation methodsFor: 'change direction' stamp: 's 10/4/2022 16:14:50'!
turnRight
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotOrientation class' category: 'Actividad MarsRover'!
RobotOrientation class
	instanceVariableNames: ''!

!RobotOrientation class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:54:40'!
canHandle: aCardinalPoint
	^self subclassResponsibility.! !

!RobotOrientation class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:53:23'!
pointingTo: aCardinalPoint
	
	^(self allSubclasses select: [:aSubclass | aSubclass canHandle: aCardinalPoint]) first new.! !


!classDefinition: #East category: 'Actividad MarsRover'!
RobotOrientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!East methodsFor: 'accesing' stamp: 'S 10/3/2022 21:27:46'!
cardinalPoint
	^$E.! !

!East methodsFor: 'accesing' stamp: 's 10/4/2022 16:40:01'!
whereToMove
	^1@0.! !


!East methodsFor: 'change direction' stamp: 's 10/4/2022 16:09:20'!
turnLeft
	^North new.! !

!East methodsFor: 'change direction' stamp: 's 10/4/2022 16:15:29'!
turnRight
	^South new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'Actividad MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:55:58'!
canHandle: aCardinalPoint
	^$E = aCardinalPoint ! !


!classDefinition: #North category: 'Actividad MarsRover'!
RobotOrientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!North methodsFor: 'accesing' stamp: 'S 10/3/2022 21:27:53'!
cardinalPoint
	^$N.! !

!North methodsFor: 'accesing' stamp: 's 10/4/2022 16:40:22'!
whereToMove
	^0@-1.! !


!North methodsFor: 'change direction' stamp: 's 10/4/2022 16:07:55'!
turnLeft
	^West new.! !

!North methodsFor: 'change direction' stamp: 's 10/4/2022 16:15:57'!
turnRight
	^East new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'Actividad MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:56:17'!
canHandle: aCardinalPoint
	^$N = aCardinalPoint ! !


!classDefinition: #South category: 'Actividad MarsRover'!
RobotOrientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!South methodsFor: 'accesing' stamp: 'S 10/3/2022 21:28:00'!
cardinalPoint
	^$S.! !

!South methodsFor: 'accesing' stamp: 's 10/4/2022 16:40:36'!
whereToMove
	^0@1.! !


!South methodsFor: 'change direction' stamp: 's 10/4/2022 16:10:10'!
turnLeft
	^East new.! !

!South methodsFor: 'change direction' stamp: 's 10/4/2022 16:16:59'!
turnRight
	^West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'Actividad MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:56:27'!
canHandle: aCardinalPoint
	^$S = aCardinalPoint ! !


!classDefinition: #West category: 'Actividad MarsRover'!
RobotOrientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Actividad MarsRover'!

!West methodsFor: 'accesing' stamp: 'S 10/3/2022 21:28:07'!
cardinalPoint
	^$W.! !

!West methodsFor: 'accesing' stamp: 's 10/4/2022 16:40:45'!
whereToMove
	^-1@0.! !


!West methodsFor: 'change direction' stamp: 's 10/4/2022 16:11:22'!
turnLeft
	^South new.! !

!West methodsFor: 'change direction' stamp: 's 10/4/2022 16:17:42'!
turnRight
	^North new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'Actividad MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'instance creation' stamp: 'S 10/3/2022 21:56:36'!
canHandle: aCardinalPoint
	^$W = aCardinalPoint ! !
