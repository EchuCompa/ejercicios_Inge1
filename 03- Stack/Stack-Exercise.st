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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
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

!SentenceFinderByPrefixTest methodsFor: 'stack initialization' stamp: 'E 9/16/2022 16:40:57'!
createsStackFromOrderedCollection: anOrderedCollection
	|stack |
	stack := OOStack new.
	anOrderedCollection do: [:each | stack push: each ].
	^stack.! !


!SentenceFinderByPrefixTest methodsFor: 'stack comparision' stamp: 'E 9/18/2022 20:42:40'!
doesStack: aStack1 equals: aStack2

	| copyOfStack1 copyOfStack2 sentence_finder|
	sentence_finder := SentenceFinderByPrefix new.
	copyOfStack1 := sentence_finder copy: aStack1.
	copyOfStack2 := sentence_finder copy: aStack2.
	
	((self doesStack: aStack1 hasSameSize: aStack2)) ifTrue: [^false].
	
	[copyOfStack1 isEmpty] whileTrue: [
		(copyOfStack1 pop ~= copyOfStack2 pop) ifTrue: [^false]
	].
	^true.! !

!SentenceFinderByPrefixTest methodsFor: 'stack comparision' stamp: 'E 9/18/2022 19:44:59'!
doesStack: aStack1 hasSameSize: aStack2

	^ aStack1 size ~= aStack2 size! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 's 9/18/2022 14:54:53'!
test01NoSentencesGivesEmptyCollection

	| sentence_finder sentences_by_prefix sentences|
	sentence_finder := SentenceFinderByPrefix new.
	sentences := OOStack new.
	
	sentences_by_prefix := sentence_finder from: sentences selectAllWithPrefix: 'test'.
	self assert: sentences_by_prefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'E 9/18/2022 19:22:03'!
test02PrefixCannotBeEmpty

	| sentence_finder sentences|
	sentence_finder := SentenceFinderByPrefix new.
	sentences := OOStack new.
	self
		should: [ sentence_finder from: sentences selectAllWithPrefix: ''. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'E 9/18/2022 19:23:02'!
test03PrefixCannotContainSpaces

	| sentence_finder sentences|
	sentence_finder := SentenceFinderByPrefix new.
	sentences := OOStack new.
	self
		should: [ sentence_finder from: sentences selectAllWithPrefix: 'An invalid prefix'. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'E 9/18/2022 20:49:09'!
test04ReturnsSentencesWithSearchedPrefix

	| sentence_finder sentences sentences_found sentences_expected original_sentences|
	
	sentence_finder := SentenceFinderByPrefix new.
	sentences := self createsStackFromOrderedCollection:  #('Perdimos la batalla, pero no la guerra'  'Perdices son lo que usan los pescadores'  'Boca nunca va a descender' 'Perdi, este juego nunca se deja de jugar' 'Una oración cualquiera'  'perdición, eso es lo que vas a ser Jack').
	original_sentences  := sentence_finder copy: sentences. 
	
	sentences_found := sentence_finder from: sentences selectAllWithPrefix: 'Perdi'. 
	sentences_expected := #('Perdimos la batalla, pero no la guerra'   'Perdices son lo que usan los pescadores' 'Perdi, este juego nunca se deja de jugar') asOrderedCollection.
	
	self assert: (sentences_found  = sentences_expected ).
	self assert: ( self doesStack: original_sentences equals: sentences).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'E 9/18/2022 20:47:16'!
test05ReturnsEmptyCollectionIfThereIsNoMatch

	| sentence_finder sentences sentences_found sentences_expected original_sentences|
	
	sentence_finder := SentenceFinderByPrefix new.
	sentences := self createsStackFromOrderedCollection:  #('Perdimos la batalla, pero no la guerra'  'Perdices son lo que usan los pescadores'  'Boca nunca va a descender' 'Perdi, este juego nunca se deja de jugar' 'Una oración cualquiera'  'perdición, eso es lo que vas a ser Jack').
	original_sentences  := sentence_finder copy: sentences. 
	
	sentences_found := sentence_finder from: sentences selectAllWithPrefix: 'Noperdi'. 
	sentences_expected := #() asOrderedCollection.
	
	self assert: (sentences_found  = sentences_expected ).
	self assert: ( self doesStack: original_sentences equals: sentences).! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'ordered_elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'E 9/15/2022 20:39:57'!
isEmpty
	^ (ordered_elements isEmpty).! !

!OOStack methodsFor: 'accesing' stamp: 'E 9/15/2022 20:44:54'!
size
	^ordered_elements size.! !

!OOStack methodsFor: 'accesing' stamp: 'E 9/16/2022 16:18:32'!
top
	|state|
	state:= OOStackState stateOf: self.
	state errorIfEmpty: self.
	^ordered_elements first.! !


!OOStack methodsFor: 'initialization' stamp: 's 9/15/2022 21:38:16'!
initialize
	state := DoesNotHasElements new.
	ordered_elements := OrderedCollection new.! !


!OOStack methodsFor: 'substracting' stamp: 'E 9/16/2022 16:24:32'!
pop
	self top.
	^ordered_elements removeFirst.! !


!OOStack methodsFor: 'adding' stamp: 's 9/15/2022 21:38:56'!
push: anElement
	state := HasElements new.
	ordered_elements addFirst: anElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 's 9/15/2022 21:44:28'!
actualState: aStack
	self subclassResponsibility .! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'E 9/16/2022 16:19:08'!
stateOf: aStack
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'initialization' stamp: 'E 9/18/2022 20:49:51'!
canHandle: aStack
	self subclassResponsibility ! !

!OOStackState class methodsFor: 'initialization' stamp: 'E 9/16/2022 16:24:11'!
stateOf: aStack
	^(self allSubclasses detect:[:aClass | aClass canHandle: aStack]) new.
! !


!classDefinition: #DoesNotHasElements category: 'Stack-Exercise'!
OOStackState subclass: #DoesNotHasElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!DoesNotHasElements methodsFor: 'stack handler' stamp: 'E 9/16/2022 16:25:34'!
errorIfEmpty: aStack
	^aStack error: aStack class stackEmptyErrorDescription. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DoesNotHasElements class' category: 'Stack-Exercise'!
DoesNotHasElements class
	instanceVariableNames: ''!

!DoesNotHasElements class methodsFor: 'instance creation' stamp: 'E 9/16/2022 16:21:07'!
canHandle: aStack
	^(aStack size = 0)! !


!classDefinition: #HasElements category: 'Stack-Exercise'!
OOStackState subclass: #HasElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!HasElements methodsFor: 'stack handler' stamp: 'E 9/16/2022 16:25:57'!
errorIfEmpty: aStack
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HasElements class' category: 'Stack-Exercise'!
HasElements class
	instanceVariableNames: ''!

!HasElements class methodsFor: 'instance creation' stamp: 'E 9/16/2022 16:22:20'!
canHandle: aStack
	^(aStack size = 0) not. ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'stack copy' stamp: 'E 9/18/2022 20:24:39'!
copy: aStack
	| reverse_stack copy_stack |
	reverse_stack := OOStack new.
	copy_stack := OOStack new.
	self unload: aStack inReverseOrderTo: reverse_stack.
	self unload: reverse_stack inReverseOrderTo: copy_stack and: aStack.	
	^copy_stack.! !

!SentenceFinderByPrefix methodsFor: 'stack copy' stamp: 'E 9/18/2022 20:23:08'!
unload: aStackToUnload inReverseOrderTo: aStack1
	| element |
	[aStackToUnload isEmpty not] whileTrue: [
		element _ aStackToUnload pop.
		aStack1 push: element.
		].! !

!SentenceFinderByPrefix methodsFor: 'stack copy' stamp: 'E 9/18/2022 20:19:48'!
unload: aStackToUnload inReverseOrderTo: aStack1 and: aStack2
	| element |
	[aStackToUnload isEmpty not] whileTrue: [
		element _ aStackToUnload pop.
		aStack1 push: element.
		aStack2 push: element.
		].! !


!SentenceFinderByPrefix methodsFor: 'prefix' stamp: 'E 9/18/2022 19:18:25'!
checkIfPrefixIsValid: aPrefix
	((aPrefix isEmpty) or: [self containsSpaces: aPrefix]) ifTrue:[
		self error: self class invalidPrefixErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'prefix' stamp: 'E 9/18/2022 19:17:33'!
containsSpaces: aPrefix

	^ aPrefix anySatisfy: [:char | char isSeparator ]! !

!SentenceFinderByPrefix methodsFor: 'prefix' stamp: 'E 9/18/2022 20:54:09'!
esPrefijo: aPrefix de: aSentence

	^ aSentence is: aPrefix substringAt: 1! !


!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'E 9/18/2022 20:58:00'!
from: aStackOfSentences selectAllWithPrefix: aPrefix
	| sentencesWithPrefix copyOfStack sentence|
	
	self checkIfPrefixIsValid: aPrefix.
	sentencesWithPrefix := OrderedCollection new.
	copyOfStack _ OOStack new.
	
	[aStackOfSentences isEmpty not] whileTrue: [
		sentence _ aStackOfSentences pop.
		copyOfStack push: sentence.
		(self esPrefijo: aPrefix de: sentence) ifTrue:[
			sentencesWithPrefix addFirst: sentence.
			]
		].
	self unload: copyOfStack inReverseOrderTo: aStackOfSentences.
	^sentencesWithPrefix .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 's 9/18/2022 15:02:05'!
invalidPrefixErrorDescription
	^'Invalid Prefix: Prefix cannot be empty or have blank spaces'.! !
