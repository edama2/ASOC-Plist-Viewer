script AppDelegate
	property parent : class "NSObject"
	
	on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	#MARK: window�������I��
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
	#MARK: �N�����ɃE�B���h�E���J���Ȃ�
	(*
on applicationShouldOpenUntitledFile:sender
		log "applicationShouldOpenUntitledFile:"
		log sender
		return false
	end applicationShouldOpenUntitledFile:
*)
	
	#MARK: �N����
	on applicationWillFinishLaunching:aNotification
		log "applicationWillFinishLaunching"
		
		#sandbox�̎��ɁuopenDocument:�v���Ƃ��܂������Ȃ��̂őI���_�C�A���O�����O�ŏo��
		--current application's NSDocumentController's sharedDocumentController's openDocument:(me)
		
		set mes to "�t�@�C����I�����Ă��������B"
		set chooseItems to choose file of type {"com.apple.property-list"} with prompt mes
		set aPath to chooseItems's POSIX path
		set fileURL to (current application's NSURL's fileURLWithPath:aPath)
		
		current application's NSDocumentController's sharedDocumentController's ��
			openDocumentWithContentsOfURL:(fileURL) ��
				display:(true) ��
				completionHandler:(missing value)
		(**)
		--log result
	end applicationWillFinishLaunching:
	
	on |application|:sender openFile:filename
	end |application|:openFile:
	
	on |application|:sender openFiles:filenames
	end |application|:openFiles:
	
end script
