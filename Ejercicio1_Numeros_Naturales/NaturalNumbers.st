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


!I class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:19:08'!
* aMultiplicand
	^aMultiplicand! !

!I class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:12:30'!
+ anAdder

	^anAdder next! !

!I class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:55:45'!
- subtrahend

	self error: 'subtrahend can not be greater than minuend'! !

!I class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:55:05'!
> aNumberToCompare
	^false.! !

!I class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:32:14'!
divides: aDividend
	^aDividend! !

!I class methodsFor: 'operations' stamp: 'EC 8/26/2022 15:14:09'!
restaAlReves: numeroAlCualLeResto
	^numeroAlCualLeResto previous.! !


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

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:23:42'!
next
	next ifNil:[
		next _ II createChildNamed: self name , 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:21:12'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 8/25/2022 21:25:57'!
previous: aNumber 

	previous := aNumber! !


!II class methodsFor: 'remove all next' stamp: 'ARM 8/25/2022 21:37:56'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:24:43'!
* aMultiplicand
	
	^aMultiplicand + ( self previous * aMultiplicand).! !

!II class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:19:09'!
+ anAdder 

	^self previous + anAdder next! !

!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 15:16:08'!
- subtrahend 
	
	^(subtrahend restaAlReves: self).! !

!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 15:06:50'!
/ aDivisor
	(aDivisor = I) ifTrue: [^self].
	( (self > aDivisor) & (aDivisor * II > self) ) ifTrue: [^I].
	^ I + ( (self - aDivisor) / (aDivisor) ).! !

!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 15:02:14'!
> aNumberToCompare
	(aNumberToCompare = I) ifTrue: [^true].
	^ (self previous > aNumberToCompare previous).! !

!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:38:12'!
divides: aDividend
	
	
	^ 1 + (self divides: (aDividend - self) )! !

!II class methodsFor: 'operations' stamp: 'EC 8/26/2022 15:14:45'!
restaAlReves: numeroAlCualLeResto
	^self previous restaAlReves: numeroAlCualLeResto previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'EC 8/26/2022 15:16:45'!
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

!III class methodsFor: '--** private fileout/in **--' stamp: 'EC 8/26/2022 15:16:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'NaturalNumbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NaturalNumbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'EC 8/26/2022 15:16:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'NaturalNumbers'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NaturalNumbers'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'EC 8/26/2022 15:16:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'NaturalNumbers'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalNumbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'NaturalNumbers'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'EC 8/26/2022 15:16:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!