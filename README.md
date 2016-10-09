# SimpleTranslationTools

Collection of tools to easily find strings to translate in Objective-C source code.

##find\_raw\_string\_literals.rb

Ruby script that will (or at least should) find string literals in Objective-C source code and print an Xcode-compatible log line to remind you to translate it.



##SYTranslation.h

Macros to replace you string literals and describe them either as to be translated or as constants

	#define $(text)  NSLocalizedString(@text, @text)
	#define $$(text) @text
	
	// This string will be translated at runtime
	NSString *text = $("Hello");
	
	// This string will stay the same
	NSString *key = $$("some_key");
