--
--  CustomDocument.applescript
--  ASOC Plist Viewer
--
--  Created by zzz on 2021/03/17.
--  Copyright ˝ 2021 zzz. All rights reserved.
--

script CustomDocument
	property parent : class "NSDocument"
	
	
	# MARK: - @Property
	property autosavesInPlace : false --> ÉIÅ[ÉgÉZÅ[ÉuÇÃON/OFF
	--property windowNibName : "CustomDocument" --> ÉEÉCÉìÉhÉEÉRÉìÉgÉçÅ[ÉâÇÃÉEÉCÉìÉhÉEÇÃnibÉtÉ@ÉCÉãñº
	# ÉIÅ[ÉgÉZÅ[ÉuÇÃON/OFF
	(*on autosavesInPlace()
		-- Return true if you wish to support autosaving and versions, false if you do not.
		return not true
	end autosavesInPlace*)
	
	on windowNibName()
		return "CustomDocument"
	end windowNibName (**)
	
	
	#MARK: IBOutlets
	property theTreeController : missing value
	
	#MARK: 
	property _the_dict : {}
	
	
	# MARK: - NSDocument 
	## Instance Method
	
	on init()
		--log "CustomDocument - init"
		continue init()
		return me
	end init
	
	
	
	on dataOfType:typeName |error|:outError
		log "dataOfType:|error|:"
		set aContent to my theTreeController's content()
		set aData to current application's NSKeyedArchiver's archivedDataWithRootObject:aContent
		return aData
	end dataOfType:|error|:
	
	
	## ÉhÉLÉÖÉÅÉìÉgÉfÅ[É^Çì«Ç›çûÇ›ÉhÉLÉÖÉÅÉìÉgÉEÉCÉìÉhÉEÇ…ï\é¶
	on readFromData:theData ofType:typeName |error|:outError
		log "readFromData:ofType:|error|:"
	end readFromData:ofType:|error|:
	
	
	#MARK: ì«Ç›çûÇ›
	on readFromURL:theURL ofType:typeName |error|:outError
		log "readFromURL:ofType:|error|:"
		log theURL as alias
		
		try
			set my _the_dict to current application's NSDictionary's alloc's initWithContentsOfURL:theURL |error|:(missing value)
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
	
	(*
	Ç»Ç≠ÇƒÇ‡ëÂè‰ïvÇªÇ§
	on canAsynchronouslyWriteToURL:theURL ofType:typeName forSaveOperation:saveOperation
		log "canAsynchronouslyWriteToURL"
	end canAsynchronouslyWriteToURL:ofType:forSaveOperation:
	
	#
	on canConcurrentlyReadDocumentsOfType:typeName
		log "canConcurrentlyReadDocumentsOfType"
		log typeName
		return typeName is "com.apple.property-list"
	end canConcurrentlyReadDocumentsOfType:
	*)
	
	(*
	on makeWindowControllers()
		log "makeWindowControllers()"
	end makeWindowControllers
	*)
	
	#MARK: 
	on windowControllerDidLoadNib:windowController
		log "windowControllerDidLoadNib:"
		continue windowControllerDidLoadNib:windowController
		
		set theInfo to my task1(my _the_dict)
		log result
		set theTreeController's content to theInfo
		
	end windowControllerDidLoadNib:
	
	
	#MARK: ì«Ç›çûÇÒÇæplistÇoutlineViewópÇÃÉfÅ[É^Ç…ïœä∑
	(*on task3(anObj)
		
		set resulList to {}
		
		if (anObj's isKindOfClass:(current application's NSDictionary)) as boolean then
			
			set keyList to anObj's allKeys() as list
			
			repeat with aKey in keyList
				set aKey to aKey as text
				set aValue to (anObj's objectForKey:aKey)
				
				set tmpList to {}
				set tmpList to tmpList & {|key|:aKey}
				
				set tmpResult to my task1(aValue)
				log result's class
				
				if tmpResult's class is record then
					set tmpDict to (current application's NSDictionary's dictionaryWithDictionary:tmpResult)
					
					log tmpDict's allKeys() as list
					
					set tmpValue to (anObj's objectForKey:"type")
					if tmpValue is "Dictionary" then
						set tmpStr to current application's NSString's stringWithFormat_("(%@ items)", tmpDict's allKeys()'s |count|())
						set tmpList to tmpList & {value:tmpStr as text}
						set tmpList to tmpList & {type:"Dictionary"}
						set tmpList to tmpList & {children:tmpResult}
					else
						set tmpList to tmpList & tmpResult
					end if
				else if tmpResult's class is list then
					set aCount to count tmpResult
					set tmpStr to current application's NSString's stringWithFormat_("(%@ items)", aCount)
					--set tmpList to tmpList & {value:tmpStr as text}
					set tmpList to tmpList & {children:tmpResult}
				else
					set tmpList to tmpList & tmpResult
				end if
				
				set resulList's end to tmpList
			end repeat
			
		else if (anObj's isKindOfClass:(current application's NSArray)) as boolean then
			
			set countItem to anObj's |count|()
			set tmpStr to current application's NSString's stringWithFormat_("(%@ items)", countItem)
			repeat with num from 1 to countItem
				set aValue to (anObj's objectAtIndex:(num - 1))
				
				set tmpList to {}
				set tmpList to tmpList & {|key|:"item " & (num - 1) as text}
				set tmpList to tmpList & {type:"Array"}
				set tmpList to tmpList & {value:tmpStr as text}
				set tmpList to tmpList & {children:my task1(aValue)}
				
				set resulList's end to tmpList
			end repeat
			
		else if (anObj's isKindOfClass:(current application's NSString)) as boolean then
			
			set resulList to resulList & {type:"String"}
			set resulList to resulList & {value:anObj as text}
			
		else if (anObj's isKindOfClass:(current application's NSNumber)) as boolean then
			
			set resulList to resulList & {type:"Boolean"}
			set resulList to resulList & {value:anObj as text}
			
		end if
		
		return resulList
	end task3*)
	
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


