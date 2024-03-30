'From Cuis 6.0 [latest update: #5688] on 30 March 2024 at 5:56:48 pm'!
'Description Update with version 6291'!
!provides: 'Cuis-University-InstallerBuilder' 1 19!
SystemOrganization addCategory: 'Cuis-University-InstallerBuilder'!


!classDefinition: #CuisInstallerBuilder category: 'Cuis-University-InstallerBuilder'!
Object subclass: #CuisInstallerBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-InstallerBuilder'!
!classDefinition: 'CuisInstallerBuilder class' category: 'Cuis-University-InstallerBuilder'!
CuisInstallerBuilder class
	instanceVariableNames: 'nameWithMajorVersionNumber'!


!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 1/17/2024 11:26:03'!
cuisVersionNumberIn: aDirName

	| cuisSmalltalkDevDir fileNames imageName versionNumber imageNameSplited |
	
	cuisSmalltalkDevDir := aDirName asDirectoryEntry.
	fileNames := (cuisSmalltalkDevDir fileNamesMatching: 'Cuis*.image') asSortedCollection: [:fileNameLeft :fileNameRight | fileNameLeft size < fileNameRight size ].
	fileNames isEmpty ifTrue: [ self error: 'Image file not found' ].
	
	imageName := fileNames first.
	imageNameSplited := imageName findTokens: '-'.
	nameWithMajorVersionNumber := imageNameSplited first.
	versionNumber := (imageNameSplited second findTokens: '.') first.
	
	^versionNumber ! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 3/30/2024 17:13:49'!
cuisVersionNumberInCuisDev

	^self cuisVersionNumberIn: (self cuisSmalltalkDevDirName, self cuisImageDirName)
	! !

!CuisInstallerBuilder class methodsFor: 'version number' stamp: 'HAW 10/29/2019 19:40:04'!
cuisVersionNumberInLocalDir

	^self cuisVersionNumberIn: '.'
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:55:53'!
add64BitUpdateLineTo: fileStream with: versionNumber
		
	self assertNameWithMajorVersionNumberIsDefined.

	self 
		addExecutionOf: '../../Installer/updateImage.st' 
		to: fileStream 
		vmPath: '../CuisVM.app/Contents/MacOS/Squeak' 
		imageNameHead: nameWithMajorVersionNumber, '-' 
		imageNameTail: ''
		with: versionNumber.! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 1/17/2024 11:27:55'!
assertNameWithMajorVersionNumberIsDefined
		
	nameWithMajorVersionNumber ifNil: [ self error: 'nameWithMajorVersionNumber no está definido' ]! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:39:39'!
generate64BitImageBuilderScriptWith: versionNumber

	"self generate64BitImageBuilderScriptWith: '3283'"
	
	self 
		generate: '2-build64Image.sh' 
		vmPath: '../Cuis-Smalltalk-Dev/CuisVM.app/Contents/MacOS/Squeak' 
		liveTypingVMPath: '../SqueakLiveTyping.app/Contents/MacOS/Squeak' 
		imageNameTail: '' 
		platforms: #('macos64' 'linux64' 'windows64') 
		pathSeparator: '/' 
		with: versionNumber
		! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:43:21'!
generateRunScriptsWith: versionNumber

	self generateWindow64RunScriptWith: versionNumber.
	self generateLinux64RunScriptWith: versionNumber.
	self generateMacOs64RunScriptWith: versionNumber.
	
	! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:38:47'!
generateScripts

	"self generateScripts"
	
	| versionNumber |
	
	versionNumber := self cuisVersionNumberInLocalDir.
	
	self 
		generate64BitImageBuilderScriptWith: versionNumber;
		generateRunScriptsWith: versionNumber;
		generateZipScript
! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/14/2023 14:21:13'!
generateScriptsAndExit

	self generateScripts.
	Smalltalk saveAndQuit ! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/14/2023 14:23:51'!
generateUpdateImagesScriptAndExit

	self generateUpdateImagesScriptWith: self cuisVersionNumberInCuisDev. 
	Smalltalk saveAndQuit ! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:25:37'!
generateUpdateImagesScriptWith: versionNumber

	"self generateUpdateImagesScriptWith: '3283'"
	
	| fileStream |
	
	fileStream := UniFileStream new 
		open:  'updateImages.sh'  
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create updateImages.sh' ].

	[ fileStream truncate. 
	fileStream nextPutAll: 'cd '; nextPutAll: self cuisSmalltalkDevDirName; nextPutAll: self cuisImageDirName; newLine.
	self add64BitUpdateLineTo: fileStream with: versionNumber.
	fileStream newLine ] 
		ensure: [ fileStream close ].

		! !

!CuisInstallerBuilder class methodsFor: 'script generation' stamp: 'HAW 3/30/2024 17:46:57'!
generateZipScript	
	
	| fileStream  |
		
	fileStream := UniFileStream new 
		open: '4-zip.sh' 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create zip script file' ].

	[ fileStream
		truncate;
		nextPutAll: 'zip -r macos64 macos64';
		newLine;
		nextPutAll: 'zip -r windows64 windows64';
		newLine;
		nextPutAll: 'tar czf linux64.tar.gz linux64';
		newLine] ensure: [ fileStream close ].
				

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

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 1/17/2024 11:28:55'!
generate: scriptName vmPath: vmPath liveTypingVMPath: liveTypingVMPath imageNameTail: tail platforms: platforms pathSeparator: pathSeparator with: versionNumber

	"self generate: '4-build32LinuxImage.sh' vmPath: 'linux32/vm/squeak' imageNameTail: '-V3' platforms: #('linux32') pathSeparator: '/' with: '3283'"
	
	| fileStream  |
		
	self assertNameWithMajorVersionNumberIsDefined.
	
	fileStream := UniFileStream new 
		open:  '/Users/hernan/Documents/Cuis/5.0-64Bits/Cuis-University-Installer/', scriptName 
		forWrite: true.
	fileStream ifNil: [ self error: 'Could not create ', scriptName ].

	[ fileStream truncate. 
	self addExecutionOf: 'CuisUniversityInstallation.st' to: fileStream vmPath: vmPath imageNameHead: nameWithMajorVersionNumber, '-'  imageNameTail: tail with: versionNumber.
	fileStream newLine.
	liveTypingVMPath ifNotNil: [ 
		self addExecutionOf: 'CuisUniversityInitializationWithLiveTypingVM.st' to: fileStream vmPath: liveTypingVMPath imageNameHead: 'CuisUniversity-' imageNameTail: tail with: versionNumber ].
	platforms do: [ :osDir | self addCopyImageTo: fileStream on: osDir imageNameTail: tail pathSeparator: pathSeparator with: versionNumber]
	] ensure: [ fileStream close ].

	! !

!CuisInstallerBuilder class methodsFor: 'script generation - private' stamp: 'HAW 3/14/2023 14:19:26'!
generateRunScript: scriptFileName vmPath: vmPath imageNameTail: tail with: versionNumber
	
	"self generateRunScript: macos64/run.sh' vmPath: 'CocoaFast64.app/Contents/MacOS/Squeak' imageNameTail: '' with: '32'"
	
	| fileStream |
	
	fileStream := UniFileStream new 
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

!CuisInstallerBuilder class methodsFor: 'directories' stamp: 'HAW 3/30/2024 17:14:08'!
cuisImageDirName
	
	^'/CuisImage'! !

!CuisInstallerBuilder class methodsFor: 'directories' stamp: 'HAW 3/31/2018 15:42:24'!
cuisSmalltalkDevDirName
	
	^'../Cuis-Smalltalk-Dev'! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 3/30/2024 17:43:48'!
generateLinux64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'linux64/run.sh'
		vmPath: 'vmLiveTyping/squeak'
		imageNameTail: ''
		with: versionNumber.
		
	self 
		generateRunScript: 'linux64/run-stack.sh'
		vmPath: 'vmLiveTyping-Stack/squeak'
		imageNameTail: ''
		with: versionNumber.
		
	self 
		generateRunScript: 'linux64/run-arm.sh'
		vmPath: 'vmLiveTyping-ARM/squeak'
		imageNameTail: ''
		with: versionNumber.
		
	self 
		generateRunScript: 'linux64/run-jit.sh'
		vmPath: 'vm-jit/CuisVM.app'
		imageNameTail: ''
		with: versionNumber

		
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 3/30/2024 17:44:51'!
generateMacOs64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'macos64/run.sh'
		vmPath: 'SqueakLiveTyping.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber.
		
	self 
		generateRunScript: 'macos64/run-stack.sh'
		vmPath: 'SqueakLiveTyping-Stack.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber.
		
	self 
		generateRunScript: 'macos64/run-arm.sh'
		vmPath: 'SqueakLiveTyping-ARM.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber.
		

	self 
		generateRunScript: 'macos64/run-jit.sh'
		vmPath: 'CuisVM.app/Contents/MacOS/Squeak'
		imageNameTail: ''
		with: versionNumber! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 1/22/2021 10:44:45'!
generateWindow32RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows32/run.bat'
		vmPath: 'vm\squeak'
		imageNameTail: '-32'
		with: versionNumber.
		
	self 
		generateRunScript: 'windows32/run-jit.bat'
		vmPath: 'vm\squeak-jit'
		imageNameTail: '-32'
		with: versionNumber

	
	! !

!CuisInstallerBuilder class methodsFor: 'run script generation' stamp: 'HAW 3/30/2024 17:42:54'!
generateWindow64RunScriptWith: versionNumber
	
	self 
		generateRunScript: 'windows64/run.bat'
		vmPath: 'vmLiveTyping\squeak'
		imageNameTail: ''
		with: versionNumber.

	self 
		generateRunScript: 'windows64/run-stack.bat'
		vmPath: 'vmLiveTyping-Stack\squeak'
		imageNameTail: ''
		with: versionNumber.

	self 
		generateRunScript: 'windows64/run-jit.bat'
		vmPath: 'vm-jit\CuisVM.app'
		imageNameTail: ''
		with: versionNumber.
! !
