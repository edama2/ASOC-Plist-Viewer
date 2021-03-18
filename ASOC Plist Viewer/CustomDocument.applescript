--
--  CustomDocument.applescript
--  ASOC Plist Viewer
--
--  Created by zzz on 2021/03/17.
--  Copyright ˝ 2021 zzz. All rights reserved.
--

script CustomDocument
	property parent : class "NSDocument"
	
	#MARK: IBOutlets
	property theTreeController : missing value
	
	#MARK: 
	property _the_dict : {}
	
	#MARK: -
	on init()
		log "CustomDocument - init"
		continue init()
		return me
	end init
	
	#MARK: ëŒÇ…Ç»ÇÈxibÇÃñºëOÇï‘Ç∑
	on windowNibName()
		return "CustomDocument"
	end windowNibName
	
	on dataOfType:typeName |error|:outError
		log "dataOfType"
		-- Insert code here to write your document to data of the specified type. If the given outError is not missing value, ensure that you set contents of outError when returning missing value.
		
		-- You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
		set succeeded to false
		if not succeeded and outError is not missing value then
			set contents of outError to current application's NSError's errorWithDomain:(current application's NSCocoaErrorDomain) code:(current application's NSFileWriteUnknownError) userInfo:(missing value)
		end if
		
		-- Return your document's contents as data, or missing value if there was an error.
		return missing value
	end dataOfType:|error|:
	
	#MARK: ÉIÅ[ÉgÉZÅ[ÉuÇÃê›íË
	on autosavesInPlace()
		return false
	end autosavesInPlace
	
	#MARK: ì«Ç›çûÇ›
	on readFromURL:theURL ofType:typeName |error|:outError
		log "readFromURL"
		log theURL as alias
		
		try
			set _the_dict to current application's NSDictionary's alloc's initWithContentsOfURL:theURL |error|:(missing value)
			log result
		on error error_message number error_number
			set error_text to "Error: " & error_number & ". " & error_message
			log result
			return false
			display dialog error_text buttons {"OK"} default button 1
			return error_text
		end try
		
		return true
	end readFromURL:ofType:|error|:
	
	
	on canAsynchronouslyWriteToURL:theURL ofType:typeName forSaveOperation:saveOperation
		log "canAsynchronouslyWriteToURL"
	end canAsynchronouslyWriteToURL:ofType:forSaveOperation:
	
	#
	on canConcurrentlyReadDocumentsOfType:typeName
		log "canConcurrentlyReadDocumentsOfType"
		log typeName
		return typeName is "com.apple.property-list"
	end canConcurrentlyReadDocumentsOfType:
	
	
	(*
	on makeWindowControllers()
		log "makeWindowControllers()"
	end makeWindowControllers
	*)
	
	#MARK: 
	on windowControllerDidLoadNib:windowController
		log "windowControllerDidLoadNib"
		continue windowControllerDidLoadNib:windowController
		
		set theInfo to my task1(_the_dict)
		log result
		set theTreeController's content to theInfo
		
	end windowControllerDidLoadNib:
	
	
	#MARK: ì«Ç›çûÇÒÇæplistÇoutlineViewópÇÃÉfÅ[É^Ç…ïœä∑
	on task1(anObj)
		
		set resulList to {}
		
		if (anObj's isKindOfClass:(current application's NSDictionary)) as boolean then
			
			set keyList to anObj's allKeys() as list
			repeat with aKey in keyList
				set aKey to aKey as text
				set aValue to (anObj's objectForKey:aKey)
				
				set tmpList to {}
				set tmpList to tmpList & {|key|:aKey}
				set tmpList to tmpList & my task2(aValue)
				
				set resulList's end to tmpList
			end repeat
			
		else if (anObj's isKindOfClass:(current application's NSArray)) as boolean then
			
			set countItem to anObj's |count|()
			repeat with num from 1 to countItem
				set aValue to (anObj's objectAtIndex:(num - 1))
				
				set tmpList to {}
				set tmpList to tmpList & {|key|:"item " & (num - 1) as text}
				set tmpList to tmpList & my task2(aValue)
				
				set resulList's end to tmpList
			end repeat
		end if
		
		return resulList
	end task1
	
	on task2(aValue)
		set tmpList to {}
		
		if (aValue's isKindOfClass:(current application's NSDictionary)) as boolean then
			
			set tmpList to tmpList & {type:"Dictionary"}
			
			set tmpStr to current application's NSString's stringWithFormat_("(%@ items)", aValue's allKeys()'s |count|())
			set tmpList to tmpList & {value:tmpStr as text}
			set tmpList to tmpList & {children:my task1(aValue)}
			
		else if (aValue's isKindOfClass:(current application's NSArray)) as boolean then
			
			set tmpList to tmpList & {type:"Array"}
			
			set tmpStr to current application's NSString's stringWithFormat_("(%@ items)", aValue's |count|())
			set tmpList to tmpList & {value:tmpStr as text}
			set tmpList to tmpList & {children:my task1(aValue)}
			
		else if (aValue's isKindOfClass:(current application's NSString)) as boolean then
			
			set tmpList to tmpList & {type:"String"}
			set tmpList to tmpList & {value:aValue as text}
			
		else if (aValue's isKindOfClass:(current application's NSNumber)) as boolean then
			
			set tmpList to tmpList & {type:"Boolean"}
			set tmpList to tmpList & {value:aValue as text}
			
		end if
		
		return tmpList
	end task2
end script


