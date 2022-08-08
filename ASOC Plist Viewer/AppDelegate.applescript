script AppDelegate
	property parent : class "NSObject"
	
	(*on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:*)
	
	#MARK: window�������I��
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
	#MARK: �N�����ɃE�B���h�E���J���Ȃ�
	on applicationShouldOpenUntitledFile:sender
		log "applicationShouldOpenUntitledFile:"
		return true
		
		(*considering application responses -->�A�v���̉�����҂��ď����p��
			set mes to "�t�@�C����I�����Ă��������B"
			set chooseItems to choose file of type {"com.apple.property-list"} with prompt mes
		end considering
		set aPath to chooseItems's POSIX path
		set fileURL to (current application's NSURL's fileURLWithPath:aPath)
		
		current application's NSDocumentController's sharedDocumentController's ��
			openDocumentWithContentsOfURL:(fileURL) ��
				display:(true) ��
				completionHandler:(missing value)
		
		return false*)
	end applicationShouldOpenUntitledFile:
	
	
	#MARK: �N����
	on applicationWillFinishLaunching:aNotification
		log "applicationWillFinishLaunching"
		#sandbox�̎��ɁuopenDocument:�v�����܂������Ȃ�
		--current application's NSDocumentController's sharedDocumentController's openDocument:(me)
	end applicationWillFinishLaunching:
	
	on |application|:sender openFile:filename
	end |application|:openFile:
	
	on |application|:sender openFiles:filenames
	end |application|:openFiles:
	
	
	# �A�v���P�[�V�������A�N�e�B�u�ɂȂ�����
	on applicationDidBecomeActive:aNotification
		log "applicationDidBecomeActive:"
		
		tell current application's NSDocumentController's sharedDocumentController()
			set aCount to |documents|()'s |count|() as integer
			--log result
			if aCount is 0 then openDocument_(missing value)
		end tell
	end applicationDidBecomeActive:
	
end script
