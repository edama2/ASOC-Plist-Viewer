script AppDelegate
	property parent : class "NSObject"
	
	on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	#MARK: windowを閉じたら終了
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
	#MARK: 起動時にウィンドウを開かない
	(*
on applicationShouldOpenUntitledFile:sender
		log "applicationShouldOpenUntitledFile:"
		log sender
		return false
	end applicationShouldOpenUntitledFile:
*)
	
	#MARK: 起動時
	on applicationWillFinishLaunching:aNotification
		log "applicationWillFinishLaunching"
		
		#sandboxの時に「openDocument:」だとうまくいかないので選択ダイアログを自前で出す
		--current application's NSDocumentController's sharedDocumentController's openDocument:(me)
		
		set mes to "ファイルを選択してください。"
		set chooseItems to choose file of type {"com.apple.property-list"} with prompt mes
		set aPath to chooseItems's POSIX path
		set fileURL to (current application's NSURL's fileURLWithPath:aPath)
		
		current application's NSDocumentController's sharedDocumentController's ￢
			openDocumentWithContentsOfURL:(fileURL) ￢
				display:(true) ￢
				completionHandler:(missing value)
		(**)
		--log result
	end applicationWillFinishLaunching:
	
	on |application|:sender openFile:filename
	end |application|:openFile:
	
	on |application|:sender openFiles:filenames
	end |application|:openFiles:
	
end script
