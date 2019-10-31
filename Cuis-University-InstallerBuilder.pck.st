'From Cuis 5.0 of 7 November 2016 [latest update: #3285] on 29 October 2019 at 7:40:31 pm'!
'Description Image update atomatization'!
!provides: 'Cuis-University-InstallerBuilder' 1 8!
SystemOrganization addCategory: #'Cuis-University-InstallerBuilder'!


!classDefinition: #CuisInstallerBuilder category: #'Cuis-University-InstallerBuilder'!
Object subclass: #CuisInstallerBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-InstallerBuilder'!
!classDefinition: 'CuisInstallerBuilder class' category: #'Cuis-University-InstallerBuilder'!
CuisInstallerBuilder class
	instanceVariableNames: ''!


!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 3/31/2018 15:42:24'!
cuisSmalltalkDevDirName
	
	^'../Cuis-Smalltalk-Dev'! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 10/29/2019 19:36:02'!
cuisVersionNumberIn: aDirName

	| cuisSmalltalkDevDir fileNames imageName versionNumber |
	
	cuisSmalltalkDevDir := aDirName asDirectoryEntry.
	fileNames := (cuisSmalltalkDevDir fileNamesMatching: 'Cuis5.0-*.image') asSortedCollection: [:fileNameLeft :fileNameRight | fileNameLeft size < fileNameRight size ].
	fileNames isEmpty ifTrue: [ self error: 'Image file not found' ].
	
	imageName := fileNames first.
	versionNumber := imageName copyFrom: 'Cuis5.0-' size + 1 to: (imageName indexOfSubCollection: '.image' startingAt: 1) - 1.
	
	^versionNumber ! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 10/29/2019 19:40:00'!
cuisVersionNumberInCuisDev

	^self cuisVersionNumberIn: self cuisSmalltalkDevDirName
	! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 10/29/2019 19:40:04'!
cuisVersionNumberInLocalDir

	^self cuisVersionNumberIn: '.'
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 10/29/2019 19:02:30'!
add32BitUpdateLineTo: fileStream with: versionNumber
		
	self 
		addExecutionOf: '../Installer/updateImage.st' 
		to: fileStream 
		vmPath: '../Squeak32.app/Contents/MacOS/Squeak' 
		imageNameHead: 'Cuis5.0-' 
		imageNameTail: '-32'
		with: versionNumber.! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 10/29/2019 19:02:11'!
add64BitUpdateLineTo: fileStream with: versionNumber
		
	self 
		addExecutionOf: '../Installer/updateImage.st' 
		to: fileStream 
		vmPath: '../Squeak.app/Contents/MacOS/Squeak' 
		imageNameHead: 'Cuis5.0-' 
		imageNameTail: ''
		with: versionNumber.! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 7/1/2019 09:41:38'!
generate32BitImageBuilderScriptWith: versionNumber

	"self generate32BitImageBuilderScriptWith: '3283'
	There is no 32 bits LiveTyping VM
	"
	
	self 
		generate: '3-build32Image.sh' 
		vmPath: '../Squeak32.app/Contents/MacOS/Squeak' 
		liveTypingVMPath: nil 
		imageNameTail: '-32' 
		platforms: #('windows32' 'linux32') 
		pathSeparator: '/' 
		with: versionNumber
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 2/28/2019 22:51:01'!
generate64BitImageBuilderScriptWith: versionNumber

	"self generate64BitImageBuilderScriptWith: '3283'"
	
	self 
		generate: '2-build64Image.sh' 
		vmPath: '../Squeak.app/Contents/MacOS/Squeak' 
		liveTypingVMPath: '../SqueakLiveTyping.app/Contents/MacOS/Squeak' 
		imageNameTail: '' 
		platforms: #('macos64' 'linux64' 'windows64') 
		pathSeparator: '/' 
		with: versionNumber
		! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 4/1/2018 00:18:09'!
generateRunScriptsWith: versionNumber

	self generateWindow64RunScriptWith: versionNumber.
	self generateWindow32RunScriptWith: versionNumber.
	self generateLinux64RunScriptWith: versionNumber.
	self generateLinux32RunScriptWith: versionNumber.
	self generateMacOs64RunScriptWith: versionNumber.
	
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 10/29/2019 19:36:55'!
generateScripts

	"self generateScripts"
	
	| versionNumber |
	
	versionNumber := self cuisVersionNumberInLocalDir.
	
	self 
		generate64BitImageBuilderScriptWith: versionNumber;
		generate32BitImageBuilderScriptWith: versionNumber;
		generateRunScriptsWith: versionNumber;
		generateZipScript
! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/31/2018 12:51:34'!
generateScriptsAndExit

	self generateScripts.
	Smalltalk snapshot: true andQuit: true! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 10/29/2019 19:36:45'!
generateUpdateImagesScriptAndExit

	self generateUpdateImagesScriptWith: self cuisVersionNumberInCuisDev. 
	Smalltalk snapshot: true andQuit: true! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 10/29/2019 19:01:42'!
generateUpdateImagesScriptWith: versionNumber

	"self generateUpdateImagesScriptWith: '3283'"
	
	| fileStream |
	
	fileStream := FileStream concreteStream new 
		open:  '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/updateImages.sh'  
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create updateImages.sh' ].

	[ fileStream truncate. 
	fileStream nextPutAll: 'cd ../Cuis-Smalltalk-Dev'; newLine.
	self add64BitUpdateLineTo: fileStream with: versionNumber.
	fileStream newLine.
	self add32BitUpdateLineTo: fileStream with: versionNumber ] 
		ensure: [ fileStream close ].

		! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 8/6/2018 00:59:58'!
generateZipScript	
	
	| fileStream  |
		
	fileStream := FileStream concreteStream new 
		open: '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/4-zip.sh' 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create zip script file' ].

	[ fileStream
		truncate;
		nextPutAll: 'zip -r macos64 macos64';
		newLine;
		nextPutAll: 'zip -r windows64 windows64';
		newLine;
		nextPutAll: 'zip -r windows32 windows32';
		newLine;
		nextPutAll: 'tar czf linux64.tar.gz linux64';
		newLine;
		nextPutAll: 'tar czf linux32.tar.gz linux32' ] ensure: [ fileStream close ].
				

! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/15/2018 20:25:09'!
addCopyImageTo: fileStream on: osDir imageNameTail: tail pathSeparator: pathSeparator with: versionNumber

	fileStream 
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'rm '] ifFalse: [ 'del ' ]);
		nextPutAll: osDir;
		nextPutAll: pathSeparator;
		nextPutAll: '*.image';
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'rm '] ifFalse: [ 'del ' ]);
		nextPutAll: osDir;
		nextPutAll: pathSeparator;
		nextPutAll: '*.changes';
		newLine;
		nextPutAll: (pathSeparator = '/' ifTrue: [ 'cp'] ifFalse: [ 'copy' ]);
		nextPutAll: ' CuisUniversity-';
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.* ';
		nextPutAll: osDir ! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 2/28/2019 23:14:25'!
addExecutionOf: aScriptFileName to: fileStream vmPath: vmPath imageNameHead: header imageNameTail: tail with: versionNumber

	fileStream
		nextPutAll: vmPath;
		nextPut: Character space;
		nextPutAll: header;
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.image -s ';
		nextPutAll: aScriptFileName .! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 7/1/2019 09:41:22'!
generate: scriptName vmPath: vmPath liveTypingVMPath: liveTypingVMPath imageNameTail: tail platforms: platforms pathSeparator: pathSeparator with: versionNumber

	"self generate: '4-build32LinuxImage.sh' vmPath: 'linux32/vm/squeak' imageNameTail: '-V3' platforms: #('linux32') pathSeparator: '/' with: '3283'"
	
	| fileStream  |
		
	fileStream := FileStream concreteStream new 
		open:  '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/', scriptName 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create ', scriptName ].

	[ fileStream truncate. 
	self addExecutionOf: 'CuisUniversityInstallation.st' to: fileStream vmPath: vmPath imageNameHead: 'Cuis5.0-' imageNameTail: tail with: versionNumber.
	fileStream newLine.
	liveTypingVMPath ifNotNil: [ 
		self addExecutionOf: 'CuisUniversityInitializationWithLiveTypingVM.st' to: fileStream vmPath: liveTypingVMPath imageNameHead: 'CuisUniversity-' imageNameTail: tail with: versionNumber ].
	platforms do: [ :osDir | self addCopyImageTo: fileStream on: osDir imageNameTail: tail pathSeparator: pathSeparator with: versionNumber]
	] ensure: [ fileStream close ].

	! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 4/1/2018 00:53:18'!
generateRunScript: scriptFileName vmPath: vmPath imageNameTail: tail with: versionNumber
	
	"self generateRunScript: macos64/run.sh' vmPath: 'CocoaFast64.app/Contents/MacOS/Squeak' imageNameTail: '' with: '32'"
	
	| fileStream |
	
	fileStream := FileStream concreteStream new 
		open: '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/', scriptFileName  
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create ', scriptFileName ].

	[ fileStream truncate.
	(scriptFileName endsWith: '.sh') ifTrue: [
		fileStream 
			nextPutAll: '#!!/bin/bash';
			newLine ].
	fileStream 
		nextPutAll: vmPath;
		nextPutAll: ' CuisUniversity-';
		nextPutAll: versionNumber;
		nextPutAll: tail;
		nextPutAll: '.image' ] ensure: [ fileStream close ].



				

! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 8/6/2018 01:19:29'!
generateLinux32RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'linux32/run.sh'
		vmPath: 'vm/squeak'
		imageNameTail: '-32'
		with: versionNumber! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:54:55'!
generateLinux64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'linux64/run.sh'
		vmPath: 'vm/squeak'
		imageNameTail: ''
		with: versionNumber
		
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:54:17'!
generateMacOs64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'macos64/run.sh'
		vmPath: 'CocoaFast64.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:55:55'!
generateWindow32RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows32/run.bat'
		vmPath: 'vm\squeak'
		imageNameTail: '-32'
		with: versionNumber
	
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 4/1/2018 00:55:27'!
generateWindow64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows64/run.bat'
		vmPath: 'vm\squeak'
		imageNameTail: ''
		with: versionNumber
! !
