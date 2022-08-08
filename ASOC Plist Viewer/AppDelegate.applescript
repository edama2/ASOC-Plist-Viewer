script AppDelegate
	property parent : class "NSObject"
	
	(*on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:*)
	
	#MARK: windowを閉じたら終了
	on applicationShouldTerminateAfterLastWindowClosed:sender
		return true
	end applicationShouldTerminateAfterLastWindowClosed:
	
	#MARK: 起動時にウィンドウを開かない
	on applicationShouldOpenUntitledFile:sender
		log "applicationShouldOpenUntitledFile:"
		return true
		
		(*considering application responses -->アプリの応答を待って処理継続
			set mes to "ファイルを選択してください。"
			set chooseItems to choose file of type {"com.apple.property-list"} with prompt mes
		end considering
		set aPath to chooseItems's POSIX path
		set fileURL to (current application's NSURL's fileURLWithPath:aPath)
		
		current application's NSDocumentController's sharedDocumentController's ￢
			openDocumentWithContentsOfURL:(fileURL) ￢
				display:(true) ￢
				completionHandler:(missing value)
		
		return false*)
	end applicationShouldOpenUntitledFile:
	
	
	#MARK: 起動時
	on applicationWillFinishLaunching:aNotification
		log "applicationWillFinishLaunching"
		#sandboxの時に「openDocument:」がうまくいかない
		--current application's NSDocumentController's sharedDocumentController's openDocument:(me)
	end applicationWillFinishLaunching:
	
	on |application|:sender openFile:filename
	end |application|:openFile:
	
	on |application|:sender openFiles:filenames
	end |application|:openFiles:
	
	
	# アプリケーションがアクティブになった時
	on applicationDidBecomeActive:aNotification
		log "applicationDidBecomeActive:"
		
		tell current application's NSDocumentController's sharedDocumentController()
			set aCount to |documents|()'s |count|() as integer
			--log result
			if aCount is 0 then openDocument_(missing value)
		end tell
	end applicationDidBecomeActive:
	
end script
