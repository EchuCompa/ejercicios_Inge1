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


!I class methodsFor: 'errors' stamp: 'EC 9/1/2022 16:42:04'!
negativeNumbersNotSupportedErrorDescription
	^'Negative numbers not supported'! !


!I class methodsFor: 'operations' stamp: 'EC 8/26/2022 14:19:08'!
* aMultiplicand
	^aMultiplicand! !

!I class methodsFor: 'operations' stamp: 'ARM 8/25/2022 21:12:30'!
+ anAdder

	^anAdder next! !

!I class methodsFor: 'operations' stamp: 'EC 9/1/2022 16:42:56'!
- subtrahend

	self error: I negativeNumbersNotSupportedErrorDescription.! !

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

!II class methodsFor: 'next & previous' stamp: 'EC 9/1/2022 16:27:17'!
nameOfNext2
	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix:'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix:'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDLXXXIX') ifTrue:[^(self name withoutSuffix:'CDLXXXIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix:'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix:'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix:'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix:'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix:'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix:'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix:'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix:'IV'), 'V'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix:'III'), 'IV'].
	
	^self name , 'I'.! !

!II class methodsFor: 'next & previous' stamp: 'EC 9/1/2022 16:23:37'!
next
	next ifNil:[
		next _ II createChildNamed: self nameOfNext2.
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

!II class methodsFor: 'operations' stamp: 'EC 9/1/2022 16:44:34'!
/ aDivisor
	( aDivisor > self) ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription ].
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


!II class methodsFor: 'errors' stamp: 'EC 9/1/2022 16:44:09'!
canNotDivideByBiggerNumberErrorDescription
	^'Can''t divide by bigger number'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'EC 9/2/2022 10:35:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

II initializeAfterFileIn!