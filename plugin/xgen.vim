" File: xgen.vim
" Author: Wolf Sluyterman van Langeweyde
"
" $Name: xgen_2_0_1 $
" $Id: xgen.vim,v 1.4 2003/06/18 20:45:27 Wolf Exp $
" $Source: d:\\CvsRoot/trees/kits/vim/xgen.vim,v $
"
" Overview
" --------
"
" xgen.vim generates a menu for GENeration Xml-Element templates
" for different W3C-Recommondations.
"
" In addition to generation you can browse through the
" recommendation structure and have some simple but useful commands.
"
" You can find the following recommondations in the xGen-menu
" if they are enabled. Each one can be enable and disabled in
" this menu. If all an enable, the performance might be influenced.
" 
" dtd:  Document Type Definitions for XML 1.0
"
" fo:   Extensible Stylesheet Language (XSL) Version 1.0
"       Recommendation 15 October 2001
"
" html: Extensible HTML version 1.0 Strict DTD
"
" svg:  SVG 1.0 2001 September 04
"
" xsd : XML Schema 
"       Recommendation, 2 May 2001 
"
" xsl : XSL Transformations (XSLT) Version 1.0
"       Recommendation 16 November 1999
"
"
"
"
" XML-menu structure
" --------------
"
" TEMPLATES  : to generate some of my favourite templates
" MIN        : to generate the element with all required attributes
" MAX        : to generate the element with all attributes
" ------------
" ROOTS      : shows all root-elements and generates them, including
"              the <?xml ... and the xmlns
" BROWSE     : shows all possible child element for all elements,
"              so you can analyse the structure
" ------------
" FILL       : after creation, the elements are empty with a 
"              closing />. Use FILL to splitt the element
" >>         : the creation in done in the next line. Often
"              it is useful to shift the new element to the right
" <<         : to correct a shift to the left
" AUTOINDENT : normaly generation is most efficient with autoindent
"
"
" DTD-menu structure
" ------------------
"
" For DTD, only MIN, AUTOINDENT, >> and << are suported.
"
" The MIN-Structure inside the dtd.MIN, can be used in a
" comparable way. The items sould be "self explaining". Some
" specials are:
" 
" ATTRIBUTE-FIXED    : CDATA FIXED
" ATTRIBUTE-IMPLIED  : CDATA IMPLIED
" ATTRIBUTE-REQUIRED : CDATA REQUIRED
" ATTRIBUTE-VALUE    : CDATA VALUE
" ATTRIBUTE-VALUE-*  : replaces " CDATA " in the for about cases
"
" DOCTYPE-EXTERNAL   : external SYSTEM DOCTYPE
" DOCTYPE-MIXED      : mixed SYSTEM DOCTYPE
" DOCTYPE-PUBLIC     : replaces " SYSTEM " to PUBLIC in the two
"                      above cases
"
if exists("loaded_xGen_menu") || &cp
    finish
endif
let loaded_xGen_menu=1

" This script is useful only in GUI Vim
if !has("gui_running")
    finish
endif

function Set_enable()
:amenu 800.10.10 xGen.disable.-SEP-	<ESC>
:amenu 800.90 xGen.-SEP-	<ESC>
:call Set_enable_dtd()
:call Set_enable_xsl()
:aunmenu xGen.disable.-SEP-
endfunction

:amenu 800.10.400 xGen.enable.dtd	:call Set_enable_dtd()<CR>
function! Set_disable_dtd()
:amenu 800.10.400 xGen.enable.dtd	:call Set_enable_dtd()<CR>
:aunmenu xGen.disable.dtd
:aunmenu xGen.dtd
endfunction
function! Set_enable_dtd()
:amenu 800.20.400 xGen.disable.dtd	:call Set_disable_dtd()<CR>
:aunmenu xGen.enable.dtd
:amenu 800.400 xGen.dtd.MIN.ATTLIST-IMPLIED	o<!ATTLIST ???elem<ESC>o<TAB>???name CDATA #IMPLIED<ESC>ox<ESC>xxa><ESC>k
:amenu xGen.dtd.MIN.-SEPid179041- :
:amenu xGen.dtd.MIN.ATTRIBUT-FIXED	o???name CDATA #FIXED "???"<ESC>
:amenu xGen.dtd.MIN.ATTRIBUT-IMPLIED	o???name CDATA #IMPLIED<ESC>
:amenu xGen.dtd.MIN.ATTRIBUT-REQUIRED	o???name CDATA #REQUIRED<ESC>
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE	o???name CDATA "???"<ESC>
:amenu xGen.dtd.MIN.-SEPid178971- :
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-ID	:.,.s/ CDATA / ID /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-IDREF	:.,.s/ CDATA / IDREF /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-IDREFS	:.,.s/ CDATA / IDREFS /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-ENTITIES	:.,.s/ CDATA / ENTITIES /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-ENTITY	:.,.s/ CDATA / ENTITY /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-NMTOKEN	:.,.s/ CDATA / NMTOKEN /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-NMTOKENS	:.,.s/ CDATA / NMTOKENS /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-NOTATION	:.,.s/ CDATA / NOTATION (???\|???) /<ESC>^
:amenu xGen.dtd.MIN.ATTRIBUT-VALUE-SELECT	:.,.s/ CDATA / (???\|???) /<ESC>^
:amenu xGen.dtd.MIN.-SEPid179136- :
:amenu xGen.dtd.MIN.ELEMENT-ANY	o<!ELEMENT ???name ANY><ESC>
:amenu xGen.dtd.MIN.ELEMENT-EMPTY	o<!ELEMENT ???name EMPTY><ESC>
:amenu xGen.dtd.MIN.ELEMENT-PCDATA	o<!ELEMENT ???name (#PCDATA)><ESC>
:amenu xGen.dtd.MIN.ELEMENT-SELECT	o<!ELEMENT ???name (???\|???)><ESC>
:amenu xGen.dtd.MIN.ELEMENT-SEQUENCE	o<!ELEMENT ???name (???,???)><ESC>
:amenu xGen.dtd.MIN.-SEPid179208- :
:amenu xGen.dtd.MIN.ENTITIES-PREDEFINED.amp	a&amp;<ESC>
:amenu xGen.dtd.MIN.ENTITIES-PREDEFINED.apos	a&apos;<ESC>
:amenu xGen.dtd.MIN.ENTITIES-PREDEFINED.gt	a&gt;<ESC>
:amenu xGen.dtd.MIN.ENTITIES-PREDEFINED.lt	a&lt;<ESC>
:amenu xGen.dtd.MIN.ENTITIES-PREDEFINED.quot	a&quot;<ESC>
:amenu xGen.dtd.MIN.ENTITY-EXTERNAL-PARAMETER	o<!ENTITY % ???name ???extId><ESC>
:amenu xGen.dtd.MIN.ENTITY-EXTERNAL-UNPARSED	o<!ENTITY ???name ???extId NDATA ???name><ESC>
:amenu xGen.dtd.MIN.ENTITY-INTERNAL	o<!ENTITY ???name "???any"><ESC>
:amenu xGen.dtd.MIN.ENTITY-INTERNAL-PARAMETER	o<!ENTITY % ???name "???any"><ESC>
:amenu xGen.dtd.MIN.-SEPid179364- :
:amenu xGen.dtd.MIN.DOCTYPE-INTERNAL	o<!DOCTYPE ???name [<ESC>o<ESC>o]><ESC>
:amenu xGen.dtd.MIN.DOCTYPE-EXTERNAL	o<!DOCTYPE ???name SYSTEM "???URI"><ESC>
:amenu xGen.dtd.MIN.DOCTYPE-MIXED	o<!DOCTYPE ???name SYSTEM "???URI" [<ESC>o<ESC>o]><ESC>
:amenu xGen.dtd.MIN.-SEPid179438- :
:amenu xGen.dtd.MIN.DOCTYPE-PUBLIC	:.,.s/ SYSTEM / PUBLIC "???pubId" /<ESC>^
:amenu xGen.dtd.MIN.-SEPid179575- :
:amenu xGen.dtd.MIN.IGNORE	o<![IGNORE[ ???dec ]]><ESC>
:amenu xGen.dtd.MIN.INCLUDE	o<![INCLUDE[ ???dec ]]><ESC>
:amenu xGen.dtd.-SEPid179538- :
:amenu xGen.dtd.>>	>>
:amenu xGen.dtd.<<	<<
:amenu xGen.dtd.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.dtd.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:amenu 800.10.500	xGen.enable.fo	:call Set_enable_fo()<CR>
function! Set_disable_fo()
:amenu 800.10.500	xGen.enable.fo	:call Set_enable_fo()<CR>
:aunmenu xGen.disable.fo
:aunmenu xGen.fo
endfunction
function! Set_enable_fo()
:amenu 800.20.500	xGen.disable.fo	:call Set_disable_fo()<CR>
:aunmenu xGen.enable.fo
:amenu 800.500.1	xGen.fo.TEMPLATES.NO-TEMPLATES	<ESC>
:amenu xGen.fo.MIN.basic-link	o<fo:basic-link <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.bidi-override	o<fo:bidi-override <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.block	o<fo:block <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.block-container	o<fo:block-container <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.character	o<fo:character character="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.color-profile	o<fo:color-profile color-profile-name="required" src="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.conditional-page-master-reference	o<fo:conditional-page-master-reference master-reference="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.declarations	o<fo:declarations <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.external-graphic	o<fo:external-graphic <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.float	o<fo:float <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.flow	o<fo:flow flow-name="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.footnote	o<fo:footnote <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.footnote-body	o<fo:footnote-body <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.initial-property-set	o<fo:initial-property-set <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.inline	o<fo:inline <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.inline-container	o<fo:inline-container <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.instream-foreign-object	o<fo:instream-foreign-object <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.layout-master-set	o<fo:layout-master-set <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.leader	o<fo:leader <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.list-block	o<fo:list-block <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.list-item	o<fo:list-item <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.list-item-body	o<fo:list-item-body <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.list-item-label	o<fo:list-item-label <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.marker	o<fo:marker <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.multi-case	o<fo:multi-case <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.multi-properties	o<fo:multi-properties <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.multi-property-set	o<fo:multi-property-set active-state="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.multi-switch	o<fo:multi-switch <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.multi-toggle	o<fo:multi-toggle <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.page-number	o<fo:page-number <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.page-number-citation	o<fo:page-number-citation ref-id="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.page-sequence	o<fo:page-sequence master-reference="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.page-sequence-master	o<fo:page-sequence-master master-name="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-after	o<fo:region-after extent="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.region-before	o<fo:region-before extent="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.region-body	o<fo:region-body <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.region-end	o<fo:region-end extent="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.region-start	o<fo:region-start extent="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.repeatable-page-master-alternatives	o<fo:repeatable-page-master-alternatives <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.repeatable-page-master-reference	o<fo:repeatable-page-master-reference master-reference="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.retrieve-marker	o<fo:retrieve-marker <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.root	o<fo:root xmlns:fo="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.simple-page-master	o<fo:simple-page-master master-name="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.single-page-master-reference	o<fo:single-page-master-reference master-reference="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.static-content	o<fo:static-content flow-name="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table	o<fo:table <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-and-caption	o<fo:table-and-caption <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-body	o<fo:table-body <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-caption	o<fo:table-caption <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-cell	o<fo:table-cell <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-column	o<fo:table-column <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-footer	o<fo:table-footer <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-header	o<fo:table-header <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.table-row	o<fo:table-row <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.title	o<fo:title <ESC>xa/><ESC>^
:amenu xGen.fo.MIN.region-before>>.wrapper	o<fo:wrapper <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.basic-link	o<fo:basic-link absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" destination-placement-offset="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" external-destination="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" indicate-destination="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" internal-destination="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" show-destination="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" target-presentation-context="" target-processing-context="" target-stylesheet="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.bidi-override	o<fo:bidi-override absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.block	o<fo:block absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.block-container	o<fo:block-container absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.character	o<fo:character alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" character="required" color="" country="" cue="" cue-after="" cue-before="" dominant-baseline="" elevation="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" hyphenate="" hyphenation-character="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" language="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" relative-position="" richness="" right="" role="" score-spaces="" script="" source-document="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" stress="" suppress-at-line-break="" text-altitude="" text-decoration="" text-depth="" text-shadow="" text-transform="" top="" treat-as-word-space="" vertical-align="" visibility="" voice-family="" volume="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.color-profile	o<fo:color-profile color-profile-name="required" rendering-intent="" src="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.conditional-page-master-reference	o<fo:conditional-page-master-reference blank-or-not-blank="" master-reference="required" odd-or-even="" page-position="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.declarations	o<fo:declarations <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.external-graphic	o<fo:external-graphic alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" content-height="" content-type="" content-width="" cue="" cue-after="" cue-before="" display-align="" dominant-baseline="" elevation="" end-indent="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" height="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" left="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" relative-position="" richness="" right="" role="" scaling="" scaling-method="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" src="" start-indent="" stress="" text-align="" top="" vertical-align="" voice-family="" volume="" width="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.float	o<fo:float absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.flow	o<fo:flow absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" flow-name="required" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.footnote	o<fo:footnote absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.footnote-body	o<fo:footnote-body absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.initial-property-set	o<fo:initial-property-set alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" color="" country="" cue="" cue-after="" cue-before="" dominant-baseline="" elevation="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" hyphenate="" hyphenation-character="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" language="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" relative-position="" richness="" right="" role="" score-spaces="" script="" source-document="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" stress="" suppress-at-line-break="" text-altitude="" text-decoration="" text-depth="" text-shadow="" text-transform="" top="" treat-as-word-space="" vertical-align="" visibility="" voice-family="" volume="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.inline	o<fo:inline absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.inline-container	o<fo:inline-container absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.instream-foreign-object	o<fo:instream-foreign-object alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" content-height="" content-type="" content-width="" cue="" cue-after="" cue-before="" display-align="" dominant-baseline="" elevation="" end-indent="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" height="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" left="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" relative-position="" richness="" right="" role="" scaling="" scaling-method="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" text-align="" top="" vertical-align="" voice-family="" volume="" width="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.layout-master-set	o<fo:layout-master-set <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.leader	o<fo:leader absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.list-block	o<fo:list-block absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.list-item	o<fo:list-item absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.list-item-body	o<fo:list-item-body absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.list-item-label	o<fo:list-item-label absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.marker	o<fo:marker marker-class-name="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.multi-case	o<fo:multi-case absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" case-name="" case-title="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" starting-state="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.multi-properties	o<fo:multi-properties absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.multi-property-set	o<fo:multi-property-set absolute-position="" active-state="required" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.multi-switch	o<fo:multi-switch absolute-position="" alignment-adjust="" alignment-baseline="" auto-restore="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.multi-toggle	o<fo:multi-toggle absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" switch-to="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.page-number	o<fo:page-number alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" color="" country="" cue="" cue-after="" cue-before="" dominant-baseline="" elevation="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" hyphenate="" hyphenation-character="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" language="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" relative-position="" richness="" right="" role="" score-spaces="" script="" source-document="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" stress="" suppress-at-line-break="" text-altitude="" text-decoration="" text-depth="" text-shadow="" text-transform="" top="" treat-as-word-space="" vertical-align="" visibility="" voice-family="" volume="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.page-number-citation	o<fo:page-number-citation alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" color="" country="" cue="" cue-after="" cue-before="" dominant-baseline="" elevation="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" hyphenate="" hyphenation-character="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" language="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" ref-id="required" relative-position="" richness="" right="" role="" score-spaces="" script="" source-document="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" stress="" suppress-at-line-break="" text-altitude="" text-decoration="" text-depth="" text-shadow="" text-transform="" top="" treat-as-word-space="" vertical-align="" visibility="" voice-family="" volume="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.page-sequence	o<fo:page-sequence absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" force-page-count="" format="" glyph-orientation-horizontal="" glyph-orientation-vertical="" grouping-separator="" grouping-size="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" initial-page-number="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" letter-value="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" master-reference="required" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.page-sequence-master	o<fo:page-sequence-master master-name="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-after	o<fo:region-after background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" clip="" display-align="" extent="required" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" precedence="" reference-orientation="" region-name="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.region-before	o<fo:region-before background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" clip="" display-align="" extent="required" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" precedence="" reference-orientation="" region-name="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.region-body	o<fo:region-body background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" clip="" column-count="" column-gap="" display-align="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" reference-orientation="" region-name="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.region-end	o<fo:region-end background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" clip="" display-align="" extent="required" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" precedence="" reference-orientation="" region-name="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.region-start	o<fo:region-start background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" border="" border-after-color="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-color="" border-end-color="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-start-color="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" clip="" display-align="" extent="required" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" precedence="" reference-orientation="" region-name="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.repeatable-page-master-alternatives	o<fo:repeatable-page-master-alternatives maximum-repeats="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.repeatable-page-master-reference	o<fo:repeatable-page-master-reference master-reference="required" maximum-repeats="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.retrieve-marker	o<fo:retrieve-marker retrieve-boundary="" retrieve-class-name="" retrieve-position="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.root	o<fo:root absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" media-usage="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" xmlns:fo="required" xmlns:rx="" xmlns:svg="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.simple-page-master	o<fo:simple-page-master margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" master-name="required" page-height="" page-width="" reference-orientation="" size="" writing-mode="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.single-page-master-reference	o<fo:single-page-master-reference master-reference="required" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.static-content	o<fo:static-content absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" flow-name="required" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table	o<fo:table absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-and-caption	o<fo:table-and-caption absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-body	o<fo:table-body absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-caption	o<fo:table-caption absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-cell	o<fo:table-cell absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" column-number="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" ends-row="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" number-columns-spanned="" number-rows-spanned="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" starts-row="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-column	o<fo:table-column absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" column-number="" column-width="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" number-columns-repeated="" number-columns-spanned="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-footer	o<fo:table-footer absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-header	o<fo:table-header absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.table-row	o<fo:table-row absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.title	o<fo:title absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.MAX.region-before>>.wrapper	o<fo:wrapper absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" id="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.-SEPid181462- :
:amenu xGen.fo.ROOTS.root	O<?xml version="1.0" encoding="ISO-8859-1"?><ESC>o<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" absolute-position="" alignment-adjust="" alignment-baseline="" azimuth="" background="" background-attachment="" background-color="" background-image="" background-position="" background-position-horizontal="" background-position-vertical="" background-repeat="" baseline-shift="" block-progression-dimension="" block-progression-dimension.maximum="" block-progression-dimension.minimum="" block-progression-dimension.optimum="" border="" border-after-color="" border-after-precedence="" border-after-style="" border-after-width="" border-after-width.conditionality="" border-after-width.length="" border-before-color="" border-before-precedence="" border-before-style="" border-before-width="" border-before-width.conditionality="" border-before-width.length="" border-bottom="" border-bottom-color="" border-bottom-style="" border-bottom-width="" border-bottom-width.conditionality="" border-bottom-width.length="" border-collapse="" border-color="" border-end-color="" border-end-precedence="" border-end-style="" border-end-width="" border-end-width.conditionality="" border-end-width.length="" border-left="" border-left-color="" border-left-style="" border-left-width="" border-left-width.conditionality="" border-left-width.length="" border-right="" border-right-color="" border-right-style="" border-right-width="" border-right-width.conditionality="" border-right-width.length="" border-separation="" border-separation.block-progression-dimension="" border-separation.inline-progression-dimension="" border-spacing="" border-start-color="" border-start-precedence="" border-start-style="" border-start-width="" border-start-width.conditionality="" border-start-width.length="" border-style="" border-top="" border-top-color="" border-top-style="" border-top-width="" border-top-width.conditionality="" border-top-width.length="" border-width="" bottom="" break-after="" break-before="" caption-side="" clear="" clip="" color="" country="" cue="" cue-after="" cue-before="" direction="" display-align="" dominant-baseline="" elevation="" empty-cells="" end-indent="" float="" font="" font-family="" font-selection-strategy="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" hyphenate="" hyphenation-character="" hyphenation-keep="" hyphenation-ladder-count="" hyphenation-push-character-count="" hyphenation-remain-character-count="" inline-progression-dimension="" inline-progression-dimension.maximum="" inline-progression-dimension.minimum="" inline-progression-dimension.optimum="" intrusion-displace="" keep-together="" keep-together.within-column="" keep-together.within-line="" keep-together.within-page="" keep-with-next="" keep-with-next.within-column="" keep-with-next.within-line="" keep-with-next.within-page="" keep-with-previous="" keep-with-previous.within-column="" keep-with-previous.within-line="" keep-with-previous.within-page="" language="" last-line-end-indent="" leader-alignment="" leader-length="" leader-length.maximum="" leader-length.minimum="" leader-length.optimum="" leader-pattern="" leader-pattern-width="" left="" letter-spacing="" letter-spacing.conditionality="" letter-spacing.maximum="" letter-spacing.minimum="" letter-spacing.optimum="" letter-spacing.precedence="" line-height="" line-height-shift-adjustment="" line-height.conditionality="" line-height.maximum="" line-height.minimum="" line-height.optimum="" line-height.precedence="" line-stacking-strategy="" linefeed-treatment="" margin="" margin-after="" margin-before="" margin-bottom="" margin-end="" margin-left="" margin-right="" margin-start="" margin-top="" max-height="" max-width="" media-usage="" min-height="" min-width="" orphans="" overflow="" padding="" padding-after="" padding-after.conditionality="" padding-after.length="" padding-before="" padding-before.conditionality="" padding-before.length="" padding-bottom="" padding-bottom.conditionality="" padding-bottom.length="" padding-end="" padding-end.conditionality="" padding-end.length="" padding-left="" padding-left.conditionality="" padding-left.length="" padding-right="" padding-right.conditionality="" padding-right.length="" padding-start="" padding-start.conditionality="" padding-start.length="" padding-top="" padding-top.conditionality="" padding-top.length="" page-break-after="" page-break-before="" page-break-inside="" pause="" pause-after="" pause-before="" pitch="" pitch-range="" play-during="" position="" provisional-distance-between-starts="" provisional-label-separation="" reference-orientation="" relative-align="" relative-position="" richness="" right="" role="" rule-style="" rule-thickness="" score-spaces="" script="" source-document="" space-after="" space-after.conditionality="" space-after.maximum="" space-after.minimum="" space-after.optimum="" space-after.precedence="" space-before="" space-before.conditionality="" space-before.maximum="" space-before.minimum="" space-before.optimum="" space-before.precedence="" space-end="" space-end.conditionality="" space-end.maximum="" space-end.minimum="" space-end.optimum="" space-end.precedence="" space-start="" space-start.conditionality="" space-start.maximum="" space-start.minimum="" space-start.optimum="" space-start.precedence="" span="" speak="" speak-header="" speak-numeral="" speak-punctuation="" speech-rate="" start-indent="" stress="" suppress-at-line-break="" table-layout="" table-omit-footer-at-break="" table-omit-header-at-break="" text-align="" text-align-last="" text-altitude="" text-decoration="" text-depth="" text-indent="" text-shadow="" text-transform="" top="" treat-as-word-space="" unicode-bidi="" vertical-align="" visibility="" voice-family="" volume="" white-space="" white-space-collapse="" white-space-treatment="" widows="" width="" word-spacing="" word-spacing.conditionality="" word-spacing.maximum="" word-spacing.minimum="" word-spacing.optimum="" word-spacing.precedence="" wrap-option="" writing-mode="" xml:lang="" xmlns:fo="required" xmlns:rx="" xmlns:svg="" z-index="" <ESC>xa/><ESC>^
:amenu xGen.fo.BROWSE.basic-link.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.basic-link.character	<ESC>
:amenu xGen.fo.BROWSE.basic-link.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.basic-link.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.basic-link.inline	<ESC>
:amenu xGen.fo.BROWSE.basic-link.inline-container	<ESC>
:amenu xGen.fo.BROWSE.basic-link.leader	<ESC>
:amenu xGen.fo.BROWSE.basic-link.page-number	<ESC>
:amenu xGen.fo.BROWSE.basic-link.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.basic-link.basic-link	<ESC>
:amenu xGen.fo.BROWSE.basic-link.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.basic-link.block	<ESC>
:amenu xGen.fo.BROWSE.basic-link.block-container	<ESC>
:amenu xGen.fo.BROWSE.basic-link.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.basic-link.table	<ESC>
:amenu xGen.fo.BROWSE.basic-link.list-block	<ESC>
:amenu xGen.fo.BROWSE.basic-link.footnote	<ESC>
:amenu xGen.fo.BROWSE.basic-link.float	<ESC>
:amenu xGen.fo.BROWSE.basic-link.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.basic-link.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.basic-link.wrapper	<ESC>
:amenu xGen.fo.BROWSE.basic-link.marker	<ESC>
:amenu xGen.fo.BROWSE.basic-link.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.character	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.inline	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.inline-container	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.leader	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.page-number	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.basic-link	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.footnote	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.float	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.wrapper	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.marker	<ESC>
:amenu xGen.fo.BROWSE.bidi-override.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.block.initial-property-set	<ESC>
:amenu xGen.fo.BROWSE.block.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.block.character	<ESC>
:amenu xGen.fo.BROWSE.block.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.block.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.block.inline	<ESC>
:amenu xGen.fo.BROWSE.block.inline-container	<ESC>
:amenu xGen.fo.BROWSE.block.leader	<ESC>
:amenu xGen.fo.BROWSE.block.page-number	<ESC>
:amenu xGen.fo.BROWSE.block.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.block.basic-link	<ESC>
:amenu xGen.fo.BROWSE.block.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.block.block	<ESC>
:amenu xGen.fo.BROWSE.block.block-container	<ESC>
:amenu xGen.fo.BROWSE.block.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.block.table	<ESC>
:amenu xGen.fo.BROWSE.block.list-block	<ESC>
:amenu xGen.fo.BROWSE.block.footnote	<ESC>
:amenu xGen.fo.BROWSE.block.float	<ESC>
:amenu xGen.fo.BROWSE.block.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.block.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.block.wrapper	<ESC>
:amenu xGen.fo.BROWSE.block.marker	<ESC>
:amenu xGen.fo.BROWSE.block.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.block-container.block	<ESC>
:amenu xGen.fo.BROWSE.block-container.block-container	<ESC>
:amenu xGen.fo.BROWSE.block-container.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.block-container.table	<ESC>
:amenu xGen.fo.BROWSE.block-container.list-block	<ESC>
:amenu xGen.fo.BROWSE.block-container.footnote	<ESC>
:amenu xGen.fo.BROWSE.block-container.float	<ESC>
:amenu xGen.fo.BROWSE.block-container.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.block-container.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.block-container.wrapper	<ESC>
:amenu xGen.fo.BROWSE.block-container.marker	<ESC>
:amenu xGen.fo.BROWSE.block-container.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.character	<ESC>
:amenu xGen.fo.BROWSE.color-profile	<ESC>
:amenu xGen.fo.BROWSE.conditional-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.declarations.color-profile	<ESC>
:amenu xGen.fo.BROWSE.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.float.block	<ESC>
:amenu xGen.fo.BROWSE.float.block-container	<ESC>
:amenu xGen.fo.BROWSE.float.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.float.table	<ESC>
:amenu xGen.fo.BROWSE.float.list-block	<ESC>
:amenu xGen.fo.BROWSE.float.footnote	<ESC>
:amenu xGen.fo.BROWSE.float.float	<ESC>
:amenu xGen.fo.BROWSE.float.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.float.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.float.wrapper	<ESC>
:amenu xGen.fo.BROWSE.float.marker	<ESC>
:amenu xGen.fo.BROWSE.float.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.flow.block	<ESC>
:amenu xGen.fo.BROWSE.flow.block-container	<ESC>
:amenu xGen.fo.BROWSE.flow.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.flow.table	<ESC>
:amenu xGen.fo.BROWSE.flow.list-block	<ESC>
:amenu xGen.fo.BROWSE.flow.footnote	<ESC>
:amenu xGen.fo.BROWSE.flow.float	<ESC>
:amenu xGen.fo.BROWSE.flow.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.flow.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.flow.wrapper	<ESC>
:amenu xGen.fo.BROWSE.flow.marker	<ESC>
:amenu xGen.fo.BROWSE.flow.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.footnote.inline	<ESC>
:amenu xGen.fo.BROWSE.footnote.footnote-body	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.block	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.block-container	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.table	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.list-block	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.footnote	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.float	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.wrapper	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.marker	<ESC>
:amenu xGen.fo.BROWSE.footnote-body.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.initial-property-set	<ESC>
:amenu xGen.fo.BROWSE.inline.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.inline.character	<ESC>
:amenu xGen.fo.BROWSE.inline.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.inline.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.inline.inline	<ESC>
:amenu xGen.fo.BROWSE.inline.inline-container	<ESC>
:amenu xGen.fo.BROWSE.inline.leader	<ESC>
:amenu xGen.fo.BROWSE.inline.page-number	<ESC>
:amenu xGen.fo.BROWSE.inline.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.inline.basic-link	<ESC>
:amenu xGen.fo.BROWSE.inline.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.inline.block	<ESC>
:amenu xGen.fo.BROWSE.inline.block-container	<ESC>
:amenu xGen.fo.BROWSE.inline.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.inline.table	<ESC>
:amenu xGen.fo.BROWSE.inline.list-block	<ESC>
:amenu xGen.fo.BROWSE.inline.footnote	<ESC>
:amenu xGen.fo.BROWSE.inline.float	<ESC>
:amenu xGen.fo.BROWSE.inline.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.inline.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.inline.wrapper	<ESC>
:amenu xGen.fo.BROWSE.inline.marker	<ESC>
:amenu xGen.fo.BROWSE.inline.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.inline-container.block	<ESC>
:amenu xGen.fo.BROWSE.inline-container.block-container	<ESC>
:amenu xGen.fo.BROWSE.inline-container.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.inline-container.table	<ESC>
:amenu xGen.fo.BROWSE.inline-container.list-block	<ESC>
:amenu xGen.fo.BROWSE.inline-container.footnote	<ESC>
:amenu xGen.fo.BROWSE.inline-container.float	<ESC>
:amenu xGen.fo.BROWSE.inline-container.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.inline-container.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.inline-container.wrapper	<ESC>
:amenu xGen.fo.BROWSE.inline-container.marker	<ESC>
:amenu xGen.fo.BROWSE.inline-container.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.layout-master-set.page-sequence-master	<ESC>
:amenu xGen.fo.BROWSE.layout-master-set.simple-page-master	<ESC>
:amenu xGen.fo.BROWSE.layout-master-set.simple-page-master	<ESC>
:amenu xGen.fo.BROWSE.layout-master-set.page-sequence-master	<ESC>
:amenu xGen.fo.BROWSE.leader.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.leader.character	<ESC>
:amenu xGen.fo.BROWSE.leader.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.leader.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.leader.inline	<ESC>
:amenu xGen.fo.BROWSE.leader.inline-container	<ESC>
:amenu xGen.fo.BROWSE.leader.leader	<ESC>
:amenu xGen.fo.BROWSE.leader.page-number	<ESC>
:amenu xGen.fo.BROWSE.leader.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.leader.basic-link	<ESC>
:amenu xGen.fo.BROWSE.leader.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.leader.footnote	<ESC>
:amenu xGen.fo.BROWSE.leader.float	<ESC>
:amenu xGen.fo.BROWSE.leader.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.leader.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.leader.wrapper	<ESC>
:amenu xGen.fo.BROWSE.leader.marker	<ESC>
:amenu xGen.fo.BROWSE.leader.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.list-block.list-item	<ESC>
:amenu xGen.fo.BROWSE.list-item.list-item-label	<ESC>
:amenu xGen.fo.BROWSE.list-item.list-item-body	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.block	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.block-container	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.table	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.list-block	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.footnote	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.float	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.wrapper	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.marker	<ESC>
:amenu xGen.fo.BROWSE.list-item-body.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.block	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.block-container	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.table	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.list-block	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.footnote	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.float	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.wrapper	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.marker	<ESC>
:amenu xGen.fo.BROWSE.list-item-label.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.marker.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.marker.character	<ESC>
:amenu xGen.fo.BROWSE.marker.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.marker.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.marker.inline	<ESC>
:amenu xGen.fo.BROWSE.marker.inline-container	<ESC>
:amenu xGen.fo.BROWSE.marker.leader	<ESC>
:amenu xGen.fo.BROWSE.marker.page-number	<ESC>
:amenu xGen.fo.BROWSE.marker.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.marker.basic-link	<ESC>
:amenu xGen.fo.BROWSE.marker.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.marker.block	<ESC>
:amenu xGen.fo.BROWSE.marker.block-container	<ESC>
:amenu xGen.fo.BROWSE.marker.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.marker.table	<ESC>
:amenu xGen.fo.BROWSE.marker.list-block	<ESC>
:amenu xGen.fo.BROWSE.marker.footnote	<ESC>
:amenu xGen.fo.BROWSE.marker.float	<ESC>
:amenu xGen.fo.BROWSE.marker.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.marker.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.marker.wrapper	<ESC>
:amenu xGen.fo.BROWSE.marker.marker	<ESC>
:amenu xGen.fo.BROWSE.marker.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.multi-case.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.multi-case.character	<ESC>
:amenu xGen.fo.BROWSE.multi-case.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.multi-case.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.multi-case.inline	<ESC>
:amenu xGen.fo.BROWSE.multi-case.inline-container	<ESC>
:amenu xGen.fo.BROWSE.multi-case.leader	<ESC>
:amenu xGen.fo.BROWSE.multi-case.page-number	<ESC>
:amenu xGen.fo.BROWSE.multi-case.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.multi-case.basic-link	<ESC>
:amenu xGen.fo.BROWSE.multi-case.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.multi-case.block	<ESC>
:amenu xGen.fo.BROWSE.multi-case.block-container	<ESC>
:amenu xGen.fo.BROWSE.multi-case.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.multi-case.table	<ESC>
:amenu xGen.fo.BROWSE.multi-case.list-block	<ESC>
:amenu xGen.fo.BROWSE.multi-case.footnote	<ESC>
:amenu xGen.fo.BROWSE.multi-case.float	<ESC>
:amenu xGen.fo.BROWSE.multi-case.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.multi-case.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.multi-case.wrapper	<ESC>
:amenu xGen.fo.BROWSE.multi-case.marker	<ESC>
:amenu xGen.fo.BROWSE.multi-case.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.multi-properties.multi-property-set	<ESC>
:amenu xGen.fo.BROWSE.multi-properties.wrapper	<ESC>
:amenu xGen.fo.BROWSE.multi-property-set	<ESC>
:amenu xGen.fo.BROWSE.multi-switch.multi-case	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.character	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.inline	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.inline-container	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.leader	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.page-number	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.basic-link	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.footnote	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.float	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.wrapper	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.marker	<ESC>
:amenu xGen.fo.BROWSE.multi-toggle.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.page-number	<ESC>
:amenu xGen.fo.BROWSE.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.page-sequence.title	<ESC>
:amenu xGen.fo.BROWSE.page-sequence.static-content	<ESC>
:amenu xGen.fo.BROWSE.page-sequence.flow	<ESC>
:amenu xGen.fo.BROWSE.page-sequence-master.single-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.page-sequence-master.repeatable-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.page-sequence-master.repeatable-page-master-alternatives	<ESC>
:amenu xGen.fo.BROWSE.region-after	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.region-before	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.region-body	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.region-end	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.region-start	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.repeatable-page-master-alternatives.conditional-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.repeatable-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.root.layout-master-set	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.root.declarations	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.root.page-sequence	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.simple-page-master.region-body	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.simple-page-master.region-before	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.simple-page-master.region-after	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.simple-page-master.region-start	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.simple-page-master.region-end	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.single-page-master-reference	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.block-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.table	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.list-block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.footnote	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.float	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.wrapper	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.static-content.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table.table-column	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table.table-header	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table.table-footer	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table.table-body	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-and-caption.table-caption	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-and-caption.table	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-body.table-row	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-body.table-cell	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.block-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.table	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.list-block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.footnote	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.float	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.wrapper	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-caption.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.block-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.table	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.list-block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.footnote	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.float	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.wrapper	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-cell.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-column	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-footer.table-row	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-footer.table-cell	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-header.table-row	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-header.table-cell	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.table-row.table-cell	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.character	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.inline	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.inline-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.leader	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.page-number	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.basic-link	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.wrapper	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.title.retrieve-marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.bidi-override	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.character	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.external-graphic	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.instream-foreign-object	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.inline	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.inline-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.leader	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.page-number	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.page-number-citation	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.basic-link	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.multi-toggle	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.block-container	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.table-and-caption	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.table	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.list-block	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.footnote	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.float	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.multi-switch	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.multi-properties	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.wrapper	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.marker	<ESC>
:amenu xGen.fo.BROWSE.region-before>>.wrapper.retrieve-marker	<ESC>
:amenu xGen.fo.-SEPid187217- :
:amenu xGen.fo.FILL	:.s/\/*>$/>/<CR>yyp^a/<ESC>/[ >]<CR>C><ESC>k^
:amenu xGen.fo.>>	>>
:amenu xGen.fo.<<	<<
:amenu xGen.fo.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.fo.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:amenu 800.10.600	xGen.enable.html	:call Set_enable_html()<CR>
function! Set_disable_html()
:amenu 800.10.600	xGen.enable.html	:call Set_enable_html()<CR>
:aunmenu xGen.disable.html
:aunmenu xGen.html
endfunction
function! Set_enable_html()
:amenu 800.20.600	xGen.disable.html	:call Set_disable_html()<CR>
:aunmenu xGen.enable.html
:amenu xGen.html.MIN.a	o<a <ESC>xa/><ESC>^
:amenu xGen.html.MIN.abbr	o<abbr <ESC>xa/><ESC>^
:amenu xGen.html.MIN.acronym	o<acronym <ESC>xa/><ESC>^
:amenu xGen.html.MIN.address	o<address <ESC>xa/><ESC>^
:amenu xGen.html.MIN.area	o<area alt="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.b	o<b <ESC>xa/><ESC>^
:amenu xGen.html.MIN.base	o<base href="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.bdo	o<bdo dir="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.big	o<big <ESC>xa/><ESC>^
:amenu xGen.html.MIN.blockquote	o<blockquote <ESC>xa/><ESC>^
:amenu xGen.html.MIN.body	o<body <ESC>xa/><ESC>^
:amenu xGen.html.MIN.br	o<br <ESC>xa/><ESC>^
:amenu xGen.html.MIN.button	o<button <ESC>xa/><ESC>^
:amenu xGen.html.MIN.caption	o<caption <ESC>xa/><ESC>^
:amenu xGen.html.MIN.cite	o<cite <ESC>xa/><ESC>^
:amenu xGen.html.MIN.code	o<code <ESC>xa/><ESC>^
:amenu xGen.html.MIN.col	o<col <ESC>xa/><ESC>^
:amenu xGen.html.MIN.colgroup	o<colgroup <ESC>xa/><ESC>^
:amenu xGen.html.MIN.dd	o<dd <ESC>xa/><ESC>^
:amenu xGen.html.MIN.del	o<del <ESC>xa/><ESC>^
:amenu xGen.html.MIN.dfn	o<dfn <ESC>xa/><ESC>^
:amenu xGen.html.MIN.div	o<div <ESC>xa/><ESC>^
:amenu xGen.html.MIN.dl	o<dl <ESC>xa/><ESC>^
:amenu xGen.html.MIN.dt	o<dt <ESC>xa/><ESC>^
:amenu xGen.html.MIN.em	o<em <ESC>xa/><ESC>^
:amenu xGen.html.MIN.fieldset	o<fieldset <ESC>xa/><ESC>^
:amenu xGen.html.MIN.form	o<form action="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h1	o<h1 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h2	o<h2 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h3	o<h3 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h4	o<h4 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h5	o<h5 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.h6	o<h6 <ESC>xa/><ESC>^
:amenu xGen.html.MIN.head	o<head <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.hr	o<hr <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.html	o<html <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.i	o<i <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.img	o<img alt="required" src="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.input	o<input <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.ins	o<ins <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.kbd	o<kbd <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.label	o<label <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.legend	o<legend <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.li	o<li <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.link	o<link <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.map	o<map id="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.meta	o<meta content="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.noscript	o<noscript <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.object	o<object <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.ol	o<ol <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.optgroup	o<optgroup label="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.option	o<option <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.p	o<p <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.param	o<param <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.pre	o<pre <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.q	o<q <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.samp	o<samp <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.script	o<script type="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.select	o<select <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.small	o<small <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.span	o<span <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.strong	o<strong <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.style	o<style type="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.sub	o<sub <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.sup	o<sup <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.table	o<table <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.tbody	o<tbody <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.td	o<td <ESC>xa/><ESC>^
:amenu xGen.html.MIN.hr>>.textarea	o<textarea cols="required" rows="required" <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.tfoot	o<tfoot <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.th	o<th <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.thead	o<thead <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.title	o<title <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.tr	o<tr <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.tt	o<tt <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.ul	o<ul <ESC>xa/><ESC>^
:amenu xGen.html.MIN.tfoot>>.var	o<var <ESC>xa/><ESC>^
:amenu xGen.html.MAX.a	o<a accesskey="" charset="" class="" coords="" dir="" href="" hreflang="" id="" lang="" name="" onblur="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" rel="" rev="" shape="" style="" tabindex="" title="" type="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.abbr	o<abbr class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.acronym	o<acronym class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.address	o<address class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.area	o<area accesskey="" alt="required" class="" coords="" dir="" href="" id="" lang="" nohref="" onblur="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" shape="" style="" tabindex="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.b	o<b class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.base	o<base href="required" id="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.bdo	o<bdo class="" dir="required" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.big	o<big class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.blockquote	o<blockquote cite="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.body	o<body class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" onunload="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.br	o<br class="" id="" style="" title="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.button	o<button accesskey="" class="" dir="" disabled="" id="" lang="" name="" onblur="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" tabindex="" title="" type="" value="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.caption	o<caption class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.cite	o<cite class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.code	o<code class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.col	o<col align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" span="" style="" title="" valign="" width="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.colgroup	o<colgroup align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" span="" style="" title="" valign="" width="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.dd	o<dd class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.del	o<del cite="" class="" datetime="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.dfn	o<dfn class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.div	o<div class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.dl	o<dl class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.dt	o<dt class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.em	o<em class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.fieldset	o<fieldset class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.form	o<form accept="" accept-charset="" action="required" class="" dir="" enctype="" id="" lang="" method="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" onreset="" onsubmit="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h1	o<h1 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h2	o<h2 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h3	o<h3 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h4	o<h4 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h5	o<h5 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.h6	o<h6 class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.head	o<head dir="" id="" lang="" profile="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.hr	o<hr class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.html	o<html dir="" id="" lang="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.i	o<i class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.img	o<img alt="required" class="" dir="" height="" id="" ismap="" lang="" longdesc="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" src="required" style="" title="" usemap="" width="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.input	o<input accept="" accesskey="" alt="" checked="" class="" dir="" disabled="" id="" lang="" maxlength="" name="" onblur="" onchange="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" onselect="" readonly="" size="" src="" style="" tabindex="" title="" type="" usemap="" value="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.ins	o<ins cite="" class="" datetime="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.kbd	o<kbd class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.label	o<label accesskey="" class="" dir="" for="" id="" lang="" onblur="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.legend	o<legend accesskey="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.li	o<li class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.link	o<link charset="" class="" dir="" href="" hreflang="" id="" lang="" media="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" rel="" rev="" style="" title="" type="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.map	o<map class="" dir="" id="required" lang="" name="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.meta	o<meta content="required" dir="" http-equiv="" id="" lang="" name="" scheme="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.noscript	o<noscript class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.object	o<object archive="" class="" classid="" codebase="" codetype="" data="" declare="" dir="" height="" id="" lang="" name="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" standby="" style="" tabindex="" title="" type="" usemap="" width="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.ol	o<ol class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.optgroup	o<optgroup class="" dir="" disabled="" id="" label="required" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.option	o<option class="" dir="" disabled="" id="" label="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" selected="" style="" title="" value="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.p	o<p class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.param	o<param id="" name="" type="" value="" valuetype="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.pre	o<pre class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.q	o<q cite="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.samp	o<samp class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.script	o<script charset="" defer="" id="" src="" type="required" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.select	o<select class="" dir="" disabled="" id="" lang="" multiple="" name="" onblur="" onchange="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" size="" style="" tabindex="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.small	o<small class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.span	o<span class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.strong	o<strong class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.style	o<style dir="" id="" lang="" media="" title="" type="required" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.sub	o<sub class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.sup	o<sup class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.table	o<table border="" cellpadding="" cellspacing="" class="" dir="" frame="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" rules="" style="" summary="" title="" width="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.tbody	o<tbody align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.td	o<td abbr="" align="" axis="" char="" charoff="" class="" colspan="" dir="" headers="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" rowspan="" scope="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.hr>>.textarea	o<textarea accesskey="" class="" cols="required" dir="" disabled="" id="" lang="" name="" onblur="" onchange="" onclick="" ondblclick="" onfocus="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" onselect="" readonly="" rows="required" style="" tabindex="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.tfoot	o<tfoot align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.th	o<th abbr="" align="" axis="" char="" charoff="" class="" colspan="" dir="" headers="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" rowspan="" scope="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.thead	o<thead align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.title	o<title dir="" id="" lang="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.tr	o<tr align="" char="" charoff="" class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" valign="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.tt	o<tt class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.ul	o<ul class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.MAX.tfoot>>.var	o<var class="" dir="" id="" lang="" onclick="" ondblclick="" onkeydown="" onkeypress="" onkeyup="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" style="" title="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.-SEPid182632- :
:amenu xGen.html.ROOTS.html	O<?xml version="1.0" encoding="ISO-8859-1"?><ESC>o<html xmlns:="http://www.w3.org/1999/xhtml" dir="" id="" lang="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.html.BROWSE.a.br	<ESC>
:amenu xGen.html.BROWSE.a.span	<ESC>
:amenu xGen.html.BROWSE.a.bdo	<ESC>
:amenu xGen.html.BROWSE.a.map	<ESC>
:amenu xGen.html.BROWSE.a.object	<ESC>
:amenu xGen.html.BROWSE.a.img	<ESC>
:amenu xGen.html.BROWSE.a.tt	<ESC>
:amenu xGen.html.BROWSE.a.i	<ESC>
:amenu xGen.html.BROWSE.a.b	<ESC>
:amenu xGen.html.BROWSE.a.big	<ESC>
:amenu xGen.html.BROWSE.a.small	<ESC>
:amenu xGen.html.BROWSE.a.em	<ESC>
:amenu xGen.html.BROWSE.a.strong	<ESC>
:amenu xGen.html.BROWSE.a.dfn	<ESC>
:amenu xGen.html.BROWSE.a.code	<ESC>
:amenu xGen.html.BROWSE.a.q	<ESC>
:amenu xGen.html.BROWSE.a.samp	<ESC>
:amenu xGen.html.BROWSE.a.kbd	<ESC>
:amenu xGen.html.BROWSE.a.var	<ESC>
:amenu xGen.html.BROWSE.a.cite	<ESC>
:amenu xGen.html.BROWSE.a.abbr	<ESC>
:amenu xGen.html.BROWSE.a.acronym	<ESC>
:amenu xGen.html.BROWSE.a.sub	<ESC>
:amenu xGen.html.BROWSE.a.sup	<ESC>
:amenu xGen.html.BROWSE.a.input	<ESC>
:amenu xGen.html.BROWSE.a.select	<ESC>
:amenu xGen.html.BROWSE.a.textarea	<ESC>
:amenu xGen.html.BROWSE.a.label	<ESC>
:amenu xGen.html.BROWSE.a.button	<ESC>
:amenu xGen.html.BROWSE.a.ins	<ESC>
:amenu xGen.html.BROWSE.a.del	<ESC>
:amenu xGen.html.BROWSE.a.script	<ESC>
:amenu xGen.html.BROWSE.abbr.a	<ESC>
:amenu xGen.html.BROWSE.abbr.br	<ESC>
:amenu xGen.html.BROWSE.abbr.span	<ESC>
:amenu xGen.html.BROWSE.abbr.bdo	<ESC>
:amenu xGen.html.BROWSE.abbr.map	<ESC>
:amenu xGen.html.BROWSE.abbr.object	<ESC>
:amenu xGen.html.BROWSE.abbr.img	<ESC>
:amenu xGen.html.BROWSE.abbr.tt	<ESC>
:amenu xGen.html.BROWSE.abbr.i	<ESC>
:amenu xGen.html.BROWSE.abbr.b	<ESC>
:amenu xGen.html.BROWSE.abbr.big	<ESC>
:amenu xGen.html.BROWSE.abbr.small	<ESC>
:amenu xGen.html.BROWSE.abbr.em	<ESC>
:amenu xGen.html.BROWSE.abbr.strong	<ESC>
:amenu xGen.html.BROWSE.abbr.dfn	<ESC>
:amenu xGen.html.BROWSE.abbr.code	<ESC>
:amenu xGen.html.BROWSE.abbr.q	<ESC>
:amenu xGen.html.BROWSE.abbr.samp	<ESC>
:amenu xGen.html.BROWSE.abbr.kbd	<ESC>
:amenu xGen.html.BROWSE.abbr.var	<ESC>
:amenu xGen.html.BROWSE.abbr.cite	<ESC>
:amenu xGen.html.BROWSE.abbr.abbr	<ESC>
:amenu xGen.html.BROWSE.abbr.acronym	<ESC>
:amenu xGen.html.BROWSE.abbr.sub	<ESC>
:amenu xGen.html.BROWSE.abbr.sup	<ESC>
:amenu xGen.html.BROWSE.abbr.input	<ESC>
:amenu xGen.html.BROWSE.abbr.select	<ESC>
:amenu xGen.html.BROWSE.abbr.textarea	<ESC>
:amenu xGen.html.BROWSE.abbr.label	<ESC>
:amenu xGen.html.BROWSE.abbr.button	<ESC>
:amenu xGen.html.BROWSE.abbr.ins	<ESC>
:amenu xGen.html.BROWSE.abbr.del	<ESC>
:amenu xGen.html.BROWSE.abbr.script	<ESC>
:amenu xGen.html.BROWSE.acronym.a	<ESC>
:amenu xGen.html.BROWSE.acronym.br	<ESC>
:amenu xGen.html.BROWSE.acronym.span	<ESC>
:amenu xGen.html.BROWSE.acronym.bdo	<ESC>
:amenu xGen.html.BROWSE.acronym.map	<ESC>
:amenu xGen.html.BROWSE.acronym.object	<ESC>
:amenu xGen.html.BROWSE.acronym.img	<ESC>
:amenu xGen.html.BROWSE.acronym.tt	<ESC>
:amenu xGen.html.BROWSE.acronym.i	<ESC>
:amenu xGen.html.BROWSE.acronym.b	<ESC>
:amenu xGen.html.BROWSE.acronym.big	<ESC>
:amenu xGen.html.BROWSE.acronym.small	<ESC>
:amenu xGen.html.BROWSE.acronym.em	<ESC>
:amenu xGen.html.BROWSE.acronym.strong	<ESC>
:amenu xGen.html.BROWSE.acronym.dfn	<ESC>
:amenu xGen.html.BROWSE.acronym.code	<ESC>
:amenu xGen.html.BROWSE.acronym.q	<ESC>
:amenu xGen.html.BROWSE.acronym.samp	<ESC>
:amenu xGen.html.BROWSE.acronym.kbd	<ESC>
:amenu xGen.html.BROWSE.acronym.var	<ESC>
:amenu xGen.html.BROWSE.acronym.cite	<ESC>
:amenu xGen.html.BROWSE.acronym.abbr	<ESC>
:amenu xGen.html.BROWSE.acronym.acronym	<ESC>
:amenu xGen.html.BROWSE.acronym.sub	<ESC>
:amenu xGen.html.BROWSE.acronym.sup	<ESC>
:amenu xGen.html.BROWSE.acronym.input	<ESC>
:amenu xGen.html.BROWSE.acronym.select	<ESC>
:amenu xGen.html.BROWSE.acronym.textarea	<ESC>
:amenu xGen.html.BROWSE.acronym.label	<ESC>
:amenu xGen.html.BROWSE.acronym.button	<ESC>
:amenu xGen.html.BROWSE.acronym.ins	<ESC>
:amenu xGen.html.BROWSE.acronym.del	<ESC>
:amenu xGen.html.BROWSE.acronym.script	<ESC>
:amenu xGen.html.BROWSE.address.a	<ESC>
:amenu xGen.html.BROWSE.address.br	<ESC>
:amenu xGen.html.BROWSE.address.span	<ESC>
:amenu xGen.html.BROWSE.address.bdo	<ESC>
:amenu xGen.html.BROWSE.address.map	<ESC>
:amenu xGen.html.BROWSE.address.object	<ESC>
:amenu xGen.html.BROWSE.address.img	<ESC>
:amenu xGen.html.BROWSE.address.tt	<ESC>
:amenu xGen.html.BROWSE.address.i	<ESC>
:amenu xGen.html.BROWSE.address.b	<ESC>
:amenu xGen.html.BROWSE.address.big	<ESC>
:amenu xGen.html.BROWSE.address.small	<ESC>
:amenu xGen.html.BROWSE.address.em	<ESC>
:amenu xGen.html.BROWSE.address.strong	<ESC>
:amenu xGen.html.BROWSE.address.dfn	<ESC>
:amenu xGen.html.BROWSE.address.code	<ESC>
:amenu xGen.html.BROWSE.address.q	<ESC>
:amenu xGen.html.BROWSE.address.samp	<ESC>
:amenu xGen.html.BROWSE.address.kbd	<ESC>
:amenu xGen.html.BROWSE.address.var	<ESC>
:amenu xGen.html.BROWSE.address.cite	<ESC>
:amenu xGen.html.BROWSE.address.abbr	<ESC>
:amenu xGen.html.BROWSE.address.acronym	<ESC>
:amenu xGen.html.BROWSE.address.sub	<ESC>
:amenu xGen.html.BROWSE.address.sup	<ESC>
:amenu xGen.html.BROWSE.address.input	<ESC>
:amenu xGen.html.BROWSE.address.select	<ESC>
:amenu xGen.html.BROWSE.address.textarea	<ESC>
:amenu xGen.html.BROWSE.address.label	<ESC>
:amenu xGen.html.BROWSE.address.button	<ESC>
:amenu xGen.html.BROWSE.address.ins	<ESC>
:amenu xGen.html.BROWSE.address.del	<ESC>
:amenu xGen.html.BROWSE.address.script	<ESC>
:amenu xGen.html.BROWSE.area	<ESC>
:amenu xGen.html.BROWSE.b.a	<ESC>
:amenu xGen.html.BROWSE.b.br	<ESC>
:amenu xGen.html.BROWSE.b.span	<ESC>
:amenu xGen.html.BROWSE.b.bdo	<ESC>
:amenu xGen.html.BROWSE.b.map	<ESC>
:amenu xGen.html.BROWSE.b.object	<ESC>
:amenu xGen.html.BROWSE.b.img	<ESC>
:amenu xGen.html.BROWSE.b.tt	<ESC>
:amenu xGen.html.BROWSE.b.i	<ESC>
:amenu xGen.html.BROWSE.b.b	<ESC>
:amenu xGen.html.BROWSE.b.big	<ESC>
:amenu xGen.html.BROWSE.b.small	<ESC>
:amenu xGen.html.BROWSE.b.em	<ESC>
:amenu xGen.html.BROWSE.b.strong	<ESC>
:amenu xGen.html.BROWSE.b.dfn	<ESC>
:amenu xGen.html.BROWSE.b.code	<ESC>
:amenu xGen.html.BROWSE.b.q	<ESC>
:amenu xGen.html.BROWSE.b.samp	<ESC>
:amenu xGen.html.BROWSE.b.kbd	<ESC>
:amenu xGen.html.BROWSE.b.var	<ESC>
:amenu xGen.html.BROWSE.b.cite	<ESC>
:amenu xGen.html.BROWSE.b.abbr	<ESC>
:amenu xGen.html.BROWSE.b.acronym	<ESC>
:amenu xGen.html.BROWSE.b.sub	<ESC>
:amenu xGen.html.BROWSE.b.sup	<ESC>
:amenu xGen.html.BROWSE.b.input	<ESC>
:amenu xGen.html.BROWSE.b.select	<ESC>
:amenu xGen.html.BROWSE.b.textarea	<ESC>
:amenu xGen.html.BROWSE.b.label	<ESC>
:amenu xGen.html.BROWSE.b.button	<ESC>
:amenu xGen.html.BROWSE.b.ins	<ESC>
:amenu xGen.html.BROWSE.b.del	<ESC>
:amenu xGen.html.BROWSE.b.script	<ESC>
:amenu xGen.html.BROWSE.base	<ESC>
:amenu xGen.html.BROWSE.bdo.a	<ESC>
:amenu xGen.html.BROWSE.bdo.br	<ESC>
:amenu xGen.html.BROWSE.bdo.span	<ESC>
:amenu xGen.html.BROWSE.bdo.bdo	<ESC>
:amenu xGen.html.BROWSE.bdo.map	<ESC>
:amenu xGen.html.BROWSE.bdo.object	<ESC>
:amenu xGen.html.BROWSE.bdo.img	<ESC>
:amenu xGen.html.BROWSE.bdo.tt	<ESC>
:amenu xGen.html.BROWSE.bdo.i	<ESC>
:amenu xGen.html.BROWSE.bdo.b	<ESC>
:amenu xGen.html.BROWSE.bdo.big	<ESC>
:amenu xGen.html.BROWSE.bdo.small	<ESC>
:amenu xGen.html.BROWSE.bdo.em	<ESC>
:amenu xGen.html.BROWSE.bdo.strong	<ESC>
:amenu xGen.html.BROWSE.bdo.dfn	<ESC>
:amenu xGen.html.BROWSE.bdo.code	<ESC>
:amenu xGen.html.BROWSE.bdo.q	<ESC>
:amenu xGen.html.BROWSE.bdo.samp	<ESC>
:amenu xGen.html.BROWSE.bdo.kbd	<ESC>
:amenu xGen.html.BROWSE.bdo.var	<ESC>
:amenu xGen.html.BROWSE.bdo.cite	<ESC>
:amenu xGen.html.BROWSE.bdo.abbr	<ESC>
:amenu xGen.html.BROWSE.bdo.acronym	<ESC>
:amenu xGen.html.BROWSE.bdo.sub	<ESC>
:amenu xGen.html.BROWSE.bdo.sup	<ESC>
:amenu xGen.html.BROWSE.bdo.input	<ESC>
:amenu xGen.html.BROWSE.bdo.select	<ESC>
:amenu xGen.html.BROWSE.bdo.textarea	<ESC>
:amenu xGen.html.BROWSE.bdo.label	<ESC>
:amenu xGen.html.BROWSE.bdo.button	<ESC>
:amenu xGen.html.BROWSE.bdo.ins	<ESC>
:amenu xGen.html.BROWSE.bdo.del	<ESC>
:amenu xGen.html.BROWSE.bdo.script	<ESC>
:amenu xGen.html.BROWSE.big.a	<ESC>
:amenu xGen.html.BROWSE.big.br	<ESC>
:amenu xGen.html.BROWSE.big.span	<ESC>
:amenu xGen.html.BROWSE.big.bdo	<ESC>
:amenu xGen.html.BROWSE.big.map	<ESC>
:amenu xGen.html.BROWSE.big.object	<ESC>
:amenu xGen.html.BROWSE.big.img	<ESC>
:amenu xGen.html.BROWSE.big.tt	<ESC>
:amenu xGen.html.BROWSE.big.i	<ESC>
:amenu xGen.html.BROWSE.big.b	<ESC>
:amenu xGen.html.BROWSE.big.big	<ESC>
:amenu xGen.html.BROWSE.big.small	<ESC>
:amenu xGen.html.BROWSE.big.em	<ESC>
:amenu xGen.html.BROWSE.big.strong	<ESC>
:amenu xGen.html.BROWSE.big.dfn	<ESC>
:amenu xGen.html.BROWSE.big.code	<ESC>
:amenu xGen.html.BROWSE.big.q	<ESC>
:amenu xGen.html.BROWSE.big.samp	<ESC>
:amenu xGen.html.BROWSE.big.kbd	<ESC>
:amenu xGen.html.BROWSE.big.var	<ESC>
:amenu xGen.html.BROWSE.big.cite	<ESC>
:amenu xGen.html.BROWSE.big.abbr	<ESC>
:amenu xGen.html.BROWSE.big.acronym	<ESC>
:amenu xGen.html.BROWSE.big.sub	<ESC>
:amenu xGen.html.BROWSE.big.sup	<ESC>
:amenu xGen.html.BROWSE.big.input	<ESC>
:amenu xGen.html.BROWSE.big.select	<ESC>
:amenu xGen.html.BROWSE.big.textarea	<ESC>
:amenu xGen.html.BROWSE.big.label	<ESC>
:amenu xGen.html.BROWSE.big.button	<ESC>
:amenu xGen.html.BROWSE.big.ins	<ESC>
:amenu xGen.html.BROWSE.big.del	<ESC>
:amenu xGen.html.BROWSE.big.script	<ESC>
:amenu xGen.html.BROWSE.blockquote.p	<ESC>
:amenu xGen.html.BROWSE.blockquote.h1	<ESC>
:amenu xGen.html.BROWSE.blockquote.h2	<ESC>
:amenu xGen.html.BROWSE.blockquote.h3	<ESC>
:amenu xGen.html.BROWSE.blockquote.h4	<ESC>
:amenu xGen.html.BROWSE.blockquote.h5	<ESC>
:amenu xGen.html.BROWSE.blockquote.h6	<ESC>
:amenu xGen.html.BROWSE.blockquote.div	<ESC>
:amenu xGen.html.BROWSE.blockquote.ul	<ESC>
:amenu xGen.html.BROWSE.blockquote.ol	<ESC>
:amenu xGen.html.BROWSE.blockquote.dl	<ESC>
:amenu xGen.html.BROWSE.blockquote.pre	<ESC>
:amenu xGen.html.BROWSE.blockquote.hr	<ESC>
:amenu xGen.html.BROWSE.blockquote.blockquote	<ESC>
:amenu xGen.html.BROWSE.blockquote.address	<ESC>
:amenu xGen.html.BROWSE.blockquote.fieldset	<ESC>
:amenu xGen.html.BROWSE.blockquote.table	<ESC>
:amenu xGen.html.BROWSE.blockquote.form	<ESC>
:amenu xGen.html.BROWSE.blockquote.noscript	<ESC>
:amenu xGen.html.BROWSE.blockquote.ins	<ESC>
:amenu xGen.html.BROWSE.blockquote.del	<ESC>
:amenu xGen.html.BROWSE.blockquote.script	<ESC>
:amenu xGen.html.BROWSE.body.p	<ESC>
:amenu xGen.html.BROWSE.body.h1	<ESC>
:amenu xGen.html.BROWSE.body.h2	<ESC>
:amenu xGen.html.BROWSE.body.h3	<ESC>
:amenu xGen.html.BROWSE.body.h4	<ESC>
:amenu xGen.html.BROWSE.body.h5	<ESC>
:amenu xGen.html.BROWSE.body.h6	<ESC>
:amenu xGen.html.BROWSE.body.div	<ESC>
:amenu xGen.html.BROWSE.body.ul	<ESC>
:amenu xGen.html.BROWSE.body.ol	<ESC>
:amenu xGen.html.BROWSE.body.dl	<ESC>
:amenu xGen.html.BROWSE.body.pre	<ESC>
:amenu xGen.html.BROWSE.body.hr	<ESC>
:amenu xGen.html.BROWSE.body.blockquote	<ESC>
:amenu xGen.html.BROWSE.body.address	<ESC>
:amenu xGen.html.BROWSE.body.fieldset	<ESC>
:amenu xGen.html.BROWSE.body.table	<ESC>
:amenu xGen.html.BROWSE.body.form	<ESC>
:amenu xGen.html.BROWSE.body.noscript	<ESC>
:amenu xGen.html.BROWSE.body.ins	<ESC>
:amenu xGen.html.BROWSE.body.del	<ESC>
:amenu xGen.html.BROWSE.body.script	<ESC>
:amenu xGen.html.BROWSE.br	<ESC>
:amenu xGen.html.BROWSE.button.p	<ESC>
:amenu xGen.html.BROWSE.button.h1	<ESC>
:amenu xGen.html.BROWSE.button.h2	<ESC>
:amenu xGen.html.BROWSE.button.h3	<ESC>
:amenu xGen.html.BROWSE.button.h4	<ESC>
:amenu xGen.html.BROWSE.button.h5	<ESC>
:amenu xGen.html.BROWSE.button.h6	<ESC>
:amenu xGen.html.BROWSE.button.div	<ESC>
:amenu xGen.html.BROWSE.button.ul	<ESC>
:amenu xGen.html.BROWSE.button.ol	<ESC>
:amenu xGen.html.BROWSE.button.dl	<ESC>
:amenu xGen.html.BROWSE.button.pre	<ESC>
:amenu xGen.html.BROWSE.button.hr	<ESC>
:amenu xGen.html.BROWSE.button.blockquote	<ESC>
:amenu xGen.html.BROWSE.button.address	<ESC>
:amenu xGen.html.BROWSE.button.table	<ESC>
:amenu xGen.html.BROWSE.button.br	<ESC>
:amenu xGen.html.BROWSE.button.span	<ESC>
:amenu xGen.html.BROWSE.button.bdo	<ESC>
:amenu xGen.html.BROWSE.button.map	<ESC>
:amenu xGen.html.BROWSE.button.object	<ESC>
:amenu xGen.html.BROWSE.button.img	<ESC>
:amenu xGen.html.BROWSE.button.tt	<ESC>
:amenu xGen.html.BROWSE.button.i	<ESC>
:amenu xGen.html.BROWSE.button.b	<ESC>
:amenu xGen.html.BROWSE.button.big	<ESC>
:amenu xGen.html.BROWSE.button.small	<ESC>
:amenu xGen.html.BROWSE.button.em	<ESC>
:amenu xGen.html.BROWSE.button.strong	<ESC>
:amenu xGen.html.BROWSE.button.dfn	<ESC>
:amenu xGen.html.BROWSE.button.code	<ESC>
:amenu xGen.html.BROWSE.button.q	<ESC>
:amenu xGen.html.BROWSE.button.samp	<ESC>
:amenu xGen.html.BROWSE.button.kbd	<ESC>
:amenu xGen.html.BROWSE.button.var	<ESC>
:amenu xGen.html.BROWSE.button.cite	<ESC>
:amenu xGen.html.BROWSE.button.abbr	<ESC>
:amenu xGen.html.BROWSE.button.acronym	<ESC>
:amenu xGen.html.BROWSE.button.sub	<ESC>
:amenu xGen.html.BROWSE.button.sup	<ESC>
:amenu xGen.html.BROWSE.button.noscript	<ESC>
:amenu xGen.html.BROWSE.button.ins	<ESC>
:amenu xGen.html.BROWSE.button.del	<ESC>
:amenu xGen.html.BROWSE.button.script	<ESC>
:amenu xGen.html.BROWSE.caption.a	<ESC>
:amenu xGen.html.BROWSE.caption.br	<ESC>
:amenu xGen.html.BROWSE.caption.span	<ESC>
:amenu xGen.html.BROWSE.caption.bdo	<ESC>
:amenu xGen.html.BROWSE.caption.map	<ESC>
:amenu xGen.html.BROWSE.caption.object	<ESC>
:amenu xGen.html.BROWSE.caption.img	<ESC>
:amenu xGen.html.BROWSE.caption.tt	<ESC>
:amenu xGen.html.BROWSE.caption.i	<ESC>
:amenu xGen.html.BROWSE.caption.b	<ESC>
:amenu xGen.html.BROWSE.caption.big	<ESC>
:amenu xGen.html.BROWSE.caption.small	<ESC>
:amenu xGen.html.BROWSE.caption.em	<ESC>
:amenu xGen.html.BROWSE.caption.strong	<ESC>
:amenu xGen.html.BROWSE.caption.dfn	<ESC>
:amenu xGen.html.BROWSE.caption.code	<ESC>
:amenu xGen.html.BROWSE.caption.q	<ESC>
:amenu xGen.html.BROWSE.caption.samp	<ESC>
:amenu xGen.html.BROWSE.caption.kbd	<ESC>
:amenu xGen.html.BROWSE.caption.var	<ESC>
:amenu xGen.html.BROWSE.caption.cite	<ESC>
:amenu xGen.html.BROWSE.caption.abbr	<ESC>
:amenu xGen.html.BROWSE.caption.acronym	<ESC>
:amenu xGen.html.BROWSE.caption.sub	<ESC>
:amenu xGen.html.BROWSE.caption.sup	<ESC>
:amenu xGen.html.BROWSE.caption.input	<ESC>
:amenu xGen.html.BROWSE.caption.select	<ESC>
:amenu xGen.html.BROWSE.caption.textarea	<ESC>
:amenu xGen.html.BROWSE.caption.label	<ESC>
:amenu xGen.html.BROWSE.caption.button	<ESC>
:amenu xGen.html.BROWSE.caption.ins	<ESC>
:amenu xGen.html.BROWSE.caption.del	<ESC>
:amenu xGen.html.BROWSE.caption.script	<ESC>
:amenu xGen.html.BROWSE.cite.a	<ESC>
:amenu xGen.html.BROWSE.cite.br	<ESC>
:amenu xGen.html.BROWSE.cite.span	<ESC>
:amenu xGen.html.BROWSE.cite.bdo	<ESC>
:amenu xGen.html.BROWSE.cite.map	<ESC>
:amenu xGen.html.BROWSE.cite.object	<ESC>
:amenu xGen.html.BROWSE.cite.img	<ESC>
:amenu xGen.html.BROWSE.cite.tt	<ESC>
:amenu xGen.html.BROWSE.cite.i	<ESC>
:amenu xGen.html.BROWSE.cite.b	<ESC>
:amenu xGen.html.BROWSE.cite.big	<ESC>
:amenu xGen.html.BROWSE.cite.small	<ESC>
:amenu xGen.html.BROWSE.cite.em	<ESC>
:amenu xGen.html.BROWSE.cite.strong	<ESC>
:amenu xGen.html.BROWSE.cite.dfn	<ESC>
:amenu xGen.html.BROWSE.cite.code	<ESC>
:amenu xGen.html.BROWSE.cite.q	<ESC>
:amenu xGen.html.BROWSE.cite.samp	<ESC>
:amenu xGen.html.BROWSE.cite.kbd	<ESC>
:amenu xGen.html.BROWSE.cite.var	<ESC>
:amenu xGen.html.BROWSE.cite.cite	<ESC>
:amenu xGen.html.BROWSE.cite.abbr	<ESC>
:amenu xGen.html.BROWSE.cite.acronym	<ESC>
:amenu xGen.html.BROWSE.cite.sub	<ESC>
:amenu xGen.html.BROWSE.cite.sup	<ESC>
:amenu xGen.html.BROWSE.cite.input	<ESC>
:amenu xGen.html.BROWSE.cite.select	<ESC>
:amenu xGen.html.BROWSE.cite.textarea	<ESC>
:amenu xGen.html.BROWSE.cite.label	<ESC>
:amenu xGen.html.BROWSE.cite.button	<ESC>
:amenu xGen.html.BROWSE.cite.ins	<ESC>
:amenu xGen.html.BROWSE.cite.del	<ESC>
:amenu xGen.html.BROWSE.cite.script	<ESC>
:amenu xGen.html.BROWSE.code.a	<ESC>
:amenu xGen.html.BROWSE.code.br	<ESC>
:amenu xGen.html.BROWSE.code.span	<ESC>
:amenu xGen.html.BROWSE.code.bdo	<ESC>
:amenu xGen.html.BROWSE.code.map	<ESC>
:amenu xGen.html.BROWSE.code.object	<ESC>
:amenu xGen.html.BROWSE.code.img	<ESC>
:amenu xGen.html.BROWSE.code.tt	<ESC>
:amenu xGen.html.BROWSE.code.i	<ESC>
:amenu xGen.html.BROWSE.code.b	<ESC>
:amenu xGen.html.BROWSE.code.big	<ESC>
:amenu xGen.html.BROWSE.code.small	<ESC>
:amenu xGen.html.BROWSE.code.em	<ESC>
:amenu xGen.html.BROWSE.code.strong	<ESC>
:amenu xGen.html.BROWSE.code.dfn	<ESC>
:amenu xGen.html.BROWSE.code.code	<ESC>
:amenu xGen.html.BROWSE.code.q	<ESC>
:amenu xGen.html.BROWSE.code.samp	<ESC>
:amenu xGen.html.BROWSE.code.kbd	<ESC>
:amenu xGen.html.BROWSE.code.var	<ESC>
:amenu xGen.html.BROWSE.code.cite	<ESC>
:amenu xGen.html.BROWSE.code.abbr	<ESC>
:amenu xGen.html.BROWSE.code.acronym	<ESC>
:amenu xGen.html.BROWSE.code.sub	<ESC>
:amenu xGen.html.BROWSE.code.sup	<ESC>
:amenu xGen.html.BROWSE.code.input	<ESC>
:amenu xGen.html.BROWSE.code.select	<ESC>
:amenu xGen.html.BROWSE.code.textarea	<ESC>
:amenu xGen.html.BROWSE.code.label	<ESC>
:amenu xGen.html.BROWSE.code.button	<ESC>
:amenu xGen.html.BROWSE.code.ins	<ESC>
:amenu xGen.html.BROWSE.code.del	<ESC>
:amenu xGen.html.BROWSE.code.script	<ESC>
:amenu xGen.html.BROWSE.col	<ESC>
:amenu xGen.html.BROWSE.colgroup.col	<ESC>
:amenu xGen.html.BROWSE.dd.p	<ESC>
:amenu xGen.html.BROWSE.dd.h1	<ESC>
:amenu xGen.html.BROWSE.dd.h2	<ESC>
:amenu xGen.html.BROWSE.dd.h3	<ESC>
:amenu xGen.html.BROWSE.dd.h4	<ESC>
:amenu xGen.html.BROWSE.dd.h5	<ESC>
:amenu xGen.html.BROWSE.dd.h6	<ESC>
:amenu xGen.html.BROWSE.dd.div	<ESC>
:amenu xGen.html.BROWSE.dd.ul	<ESC>
:amenu xGen.html.BROWSE.dd.ol	<ESC>
:amenu xGen.html.BROWSE.dd.dl	<ESC>
:amenu xGen.html.BROWSE.dd.pre	<ESC>
:amenu xGen.html.BROWSE.dd.hr	<ESC>
:amenu xGen.html.BROWSE.dd.blockquote	<ESC>
:amenu xGen.html.BROWSE.dd.address	<ESC>
:amenu xGen.html.BROWSE.dd.fieldset	<ESC>
:amenu xGen.html.BROWSE.dd.table	<ESC>
:amenu xGen.html.BROWSE.dd.form	<ESC>
:amenu xGen.html.BROWSE.dd.a	<ESC>
:amenu xGen.html.BROWSE.dd.br	<ESC>
:amenu xGen.html.BROWSE.dd.span	<ESC>
:amenu xGen.html.BROWSE.dd.bdo	<ESC>
:amenu xGen.html.BROWSE.dd.map	<ESC>
:amenu xGen.html.BROWSE.dd.object	<ESC>
:amenu xGen.html.BROWSE.dd.img	<ESC>
:amenu xGen.html.BROWSE.dd.tt	<ESC>
:amenu xGen.html.BROWSE.dd.i	<ESC>
:amenu xGen.html.BROWSE.dd.b	<ESC>
:amenu xGen.html.BROWSE.dd.big	<ESC>
:amenu xGen.html.BROWSE.dd.small	<ESC>
:amenu xGen.html.BROWSE.dd.em	<ESC>
:amenu xGen.html.BROWSE.dd.strong	<ESC>
:amenu xGen.html.BROWSE.dd.dfn	<ESC>
:amenu xGen.html.BROWSE.dd.code	<ESC>
:amenu xGen.html.BROWSE.dd.q	<ESC>
:amenu xGen.html.BROWSE.dd.samp	<ESC>
:amenu xGen.html.BROWSE.dd.kbd	<ESC>
:amenu xGen.html.BROWSE.dd.var	<ESC>
:amenu xGen.html.BROWSE.dd.cite	<ESC>
:amenu xGen.html.BROWSE.dd.abbr	<ESC>
:amenu xGen.html.BROWSE.dd.acronym	<ESC>
:amenu xGen.html.BROWSE.dd.sub	<ESC>
:amenu xGen.html.BROWSE.dd.sup	<ESC>
:amenu xGen.html.BROWSE.dd.input	<ESC>
:amenu xGen.html.BROWSE.dd.select	<ESC>
:amenu xGen.html.BROWSE.dd.textarea	<ESC>
:amenu xGen.html.BROWSE.dd.label	<ESC>
:amenu xGen.html.BROWSE.dd.button	<ESC>
:amenu xGen.html.BROWSE.dd.noscript	<ESC>
:amenu xGen.html.BROWSE.dd.ins	<ESC>
:amenu xGen.html.BROWSE.dd.del	<ESC>
:amenu xGen.html.BROWSE.dd.script	<ESC>
:amenu xGen.html.BROWSE.del.p	<ESC>
:amenu xGen.html.BROWSE.del.h1	<ESC>
:amenu xGen.html.BROWSE.del.h2	<ESC>
:amenu xGen.html.BROWSE.del.h3	<ESC>
:amenu xGen.html.BROWSE.del.h4	<ESC>
:amenu xGen.html.BROWSE.del.h5	<ESC>
:amenu xGen.html.BROWSE.del.h6	<ESC>
:amenu xGen.html.BROWSE.del.div	<ESC>
:amenu xGen.html.BROWSE.del.ul	<ESC>
:amenu xGen.html.BROWSE.del.ol	<ESC>
:amenu xGen.html.BROWSE.del.dl	<ESC>
:amenu xGen.html.BROWSE.del.pre	<ESC>
:amenu xGen.html.BROWSE.del.hr	<ESC>
:amenu xGen.html.BROWSE.del.blockquote	<ESC>
:amenu xGen.html.BROWSE.del.address	<ESC>
:amenu xGen.html.BROWSE.del.fieldset	<ESC>
:amenu xGen.html.BROWSE.del.table	<ESC>
:amenu xGen.html.BROWSE.del.form	<ESC>
:amenu xGen.html.BROWSE.del.a	<ESC>
:amenu xGen.html.BROWSE.del.br	<ESC>
:amenu xGen.html.BROWSE.del.span	<ESC>
:amenu xGen.html.BROWSE.del.bdo	<ESC>
:amenu xGen.html.BROWSE.del.map	<ESC>
:amenu xGen.html.BROWSE.del.object	<ESC>
:amenu xGen.html.BROWSE.del.img	<ESC>
:amenu xGen.html.BROWSE.del.tt	<ESC>
:amenu xGen.html.BROWSE.del.i	<ESC>
:amenu xGen.html.BROWSE.del.b	<ESC>
:amenu xGen.html.BROWSE.del.big	<ESC>
:amenu xGen.html.BROWSE.del.small	<ESC>
:amenu xGen.html.BROWSE.del.em	<ESC>
:amenu xGen.html.BROWSE.del.strong	<ESC>
:amenu xGen.html.BROWSE.del.dfn	<ESC>
:amenu xGen.html.BROWSE.del.code	<ESC>
:amenu xGen.html.BROWSE.del.q	<ESC>
:amenu xGen.html.BROWSE.del.samp	<ESC>
:amenu xGen.html.BROWSE.del.kbd	<ESC>
:amenu xGen.html.BROWSE.del.var	<ESC>
:amenu xGen.html.BROWSE.del.cite	<ESC>
:amenu xGen.html.BROWSE.del.abbr	<ESC>
:amenu xGen.html.BROWSE.del.acronym	<ESC>
:amenu xGen.html.BROWSE.del.sub	<ESC>
:amenu xGen.html.BROWSE.del.sup	<ESC>
:amenu xGen.html.BROWSE.del.input	<ESC>
:amenu xGen.html.BROWSE.del.select	<ESC>
:amenu xGen.html.BROWSE.del.textarea	<ESC>
:amenu xGen.html.BROWSE.del.label	<ESC>
:amenu xGen.html.BROWSE.del.button	<ESC>
:amenu xGen.html.BROWSE.del.noscript	<ESC>
:amenu xGen.html.BROWSE.del.ins	<ESC>
:amenu xGen.html.BROWSE.del.del	<ESC>
:amenu xGen.html.BROWSE.del.script	<ESC>
:amenu xGen.html.BROWSE.dfn.a	<ESC>
:amenu xGen.html.BROWSE.dfn.br	<ESC>
:amenu xGen.html.BROWSE.dfn.span	<ESC>
:amenu xGen.html.BROWSE.dfn.bdo	<ESC>
:amenu xGen.html.BROWSE.dfn.map	<ESC>
:amenu xGen.html.BROWSE.dfn.object	<ESC>
:amenu xGen.html.BROWSE.dfn.img	<ESC>
:amenu xGen.html.BROWSE.dfn.tt	<ESC>
:amenu xGen.html.BROWSE.dfn.i	<ESC>
:amenu xGen.html.BROWSE.dfn.b	<ESC>
:amenu xGen.html.BROWSE.dfn.big	<ESC>
:amenu xGen.html.BROWSE.dfn.small	<ESC>
:amenu xGen.html.BROWSE.dfn.em	<ESC>
:amenu xGen.html.BROWSE.dfn.strong	<ESC>
:amenu xGen.html.BROWSE.dfn.dfn	<ESC>
:amenu xGen.html.BROWSE.dfn.code	<ESC>
:amenu xGen.html.BROWSE.dfn.q	<ESC>
:amenu xGen.html.BROWSE.dfn.samp	<ESC>
:amenu xGen.html.BROWSE.dfn.kbd	<ESC>
:amenu xGen.html.BROWSE.dfn.var	<ESC>
:amenu xGen.html.BROWSE.dfn.cite	<ESC>
:amenu xGen.html.BROWSE.dfn.abbr	<ESC>
:amenu xGen.html.BROWSE.dfn.acronym	<ESC>
:amenu xGen.html.BROWSE.dfn.sub	<ESC>
:amenu xGen.html.BROWSE.dfn.sup	<ESC>
:amenu xGen.html.BROWSE.dfn.input	<ESC>
:amenu xGen.html.BROWSE.dfn.select	<ESC>
:amenu xGen.html.BROWSE.dfn.textarea	<ESC>
:amenu xGen.html.BROWSE.dfn.label	<ESC>
:amenu xGen.html.BROWSE.dfn.button	<ESC>
:amenu xGen.html.BROWSE.dfn.ins	<ESC>
:amenu xGen.html.BROWSE.dfn.del	<ESC>
:amenu xGen.html.BROWSE.dfn.script	<ESC>
:amenu xGen.html.BROWSE.div.p	<ESC>
:amenu xGen.html.BROWSE.div.h1	<ESC>
:amenu xGen.html.BROWSE.div.h2	<ESC>
:amenu xGen.html.BROWSE.div.h3	<ESC>
:amenu xGen.html.BROWSE.div.h4	<ESC>
:amenu xGen.html.BROWSE.div.h5	<ESC>
:amenu xGen.html.BROWSE.div.h6	<ESC>
:amenu xGen.html.BROWSE.div.div	<ESC>
:amenu xGen.html.BROWSE.div.ul	<ESC>
:amenu xGen.html.BROWSE.div.ol	<ESC>
:amenu xGen.html.BROWSE.div.dl	<ESC>
:amenu xGen.html.BROWSE.div.pre	<ESC>
:amenu xGen.html.BROWSE.div.hr	<ESC>
:amenu xGen.html.BROWSE.div.blockquote	<ESC>
:amenu xGen.html.BROWSE.div.address	<ESC>
:amenu xGen.html.BROWSE.div.fieldset	<ESC>
:amenu xGen.html.BROWSE.div.table	<ESC>
:amenu xGen.html.BROWSE.div.form	<ESC>
:amenu xGen.html.BROWSE.div.a	<ESC>
:amenu xGen.html.BROWSE.div.br	<ESC>
:amenu xGen.html.BROWSE.div.span	<ESC>
:amenu xGen.html.BROWSE.div.bdo	<ESC>
:amenu xGen.html.BROWSE.div.map	<ESC>
:amenu xGen.html.BROWSE.div.object	<ESC>
:amenu xGen.html.BROWSE.div.img	<ESC>
:amenu xGen.html.BROWSE.div.tt	<ESC>
:amenu xGen.html.BROWSE.div.i	<ESC>
:amenu xGen.html.BROWSE.div.b	<ESC>
:amenu xGen.html.BROWSE.div.big	<ESC>
:amenu xGen.html.BROWSE.div.small	<ESC>
:amenu xGen.html.BROWSE.div.em	<ESC>
:amenu xGen.html.BROWSE.div.strong	<ESC>
:amenu xGen.html.BROWSE.div.dfn	<ESC>
:amenu xGen.html.BROWSE.div.code	<ESC>
:amenu xGen.html.BROWSE.div.q	<ESC>
:amenu xGen.html.BROWSE.div.samp	<ESC>
:amenu xGen.html.BROWSE.div.kbd	<ESC>
:amenu xGen.html.BROWSE.div.var	<ESC>
:amenu xGen.html.BROWSE.div.cite	<ESC>
:amenu xGen.html.BROWSE.div.abbr	<ESC>
:amenu xGen.html.BROWSE.div.acronym	<ESC>
:amenu xGen.html.BROWSE.div.sub	<ESC>
:amenu xGen.html.BROWSE.div.sup	<ESC>
:amenu xGen.html.BROWSE.div.input	<ESC>
:amenu xGen.html.BROWSE.div.select	<ESC>
:amenu xGen.html.BROWSE.div.textarea	<ESC>
:amenu xGen.html.BROWSE.div.label	<ESC>
:amenu xGen.html.BROWSE.div.button	<ESC>
:amenu xGen.html.BROWSE.div.noscript	<ESC>
:amenu xGen.html.BROWSE.div.ins	<ESC>
:amenu xGen.html.BROWSE.div.del	<ESC>
:amenu xGen.html.BROWSE.div.script	<ESC>
:amenu xGen.html.BROWSE.dl.dt	<ESC>
:amenu xGen.html.BROWSE.dl.dd	<ESC>
:amenu xGen.html.BROWSE.dt.a	<ESC>
:amenu xGen.html.BROWSE.dt.br	<ESC>
:amenu xGen.html.BROWSE.dt.span	<ESC>
:amenu xGen.html.BROWSE.dt.bdo	<ESC>
:amenu xGen.html.BROWSE.dt.map	<ESC>
:amenu xGen.html.BROWSE.dt.object	<ESC>
:amenu xGen.html.BROWSE.dt.img	<ESC>
:amenu xGen.html.BROWSE.dt.tt	<ESC>
:amenu xGen.html.BROWSE.dt.i	<ESC>
:amenu xGen.html.BROWSE.dt.b	<ESC>
:amenu xGen.html.BROWSE.dt.big	<ESC>
:amenu xGen.html.BROWSE.dt.small	<ESC>
:amenu xGen.html.BROWSE.dt.em	<ESC>
:amenu xGen.html.BROWSE.dt.strong	<ESC>
:amenu xGen.html.BROWSE.dt.dfn	<ESC>
:amenu xGen.html.BROWSE.dt.code	<ESC>
:amenu xGen.html.BROWSE.dt.q	<ESC>
:amenu xGen.html.BROWSE.dt.samp	<ESC>
:amenu xGen.html.BROWSE.dt.kbd	<ESC>
:amenu xGen.html.BROWSE.dt.var	<ESC>
:amenu xGen.html.BROWSE.dt.cite	<ESC>
:amenu xGen.html.BROWSE.dt.abbr	<ESC>
:amenu xGen.html.BROWSE.dt.acronym	<ESC>
:amenu xGen.html.BROWSE.dt.sub	<ESC>
:amenu xGen.html.BROWSE.dt.sup	<ESC>
:amenu xGen.html.BROWSE.dt.input	<ESC>
:amenu xGen.html.BROWSE.dt.select	<ESC>
:amenu xGen.html.BROWSE.dt.textarea	<ESC>
:amenu xGen.html.BROWSE.dt.label	<ESC>
:amenu xGen.html.BROWSE.dt.button	<ESC>
:amenu xGen.html.BROWSE.dt.ins	<ESC>
:amenu xGen.html.BROWSE.dt.del	<ESC>
:amenu xGen.html.BROWSE.dt.script	<ESC>
:amenu xGen.html.BROWSE.em.a	<ESC>
:amenu xGen.html.BROWSE.em.br	<ESC>
:amenu xGen.html.BROWSE.em.span	<ESC>
:amenu xGen.html.BROWSE.em.bdo	<ESC>
:amenu xGen.html.BROWSE.em.map	<ESC>
:amenu xGen.html.BROWSE.em.object	<ESC>
:amenu xGen.html.BROWSE.em.img	<ESC>
:amenu xGen.html.BROWSE.em.tt	<ESC>
:amenu xGen.html.BROWSE.em.i	<ESC>
:amenu xGen.html.BROWSE.em.b	<ESC>
:amenu xGen.html.BROWSE.em.big	<ESC>
:amenu xGen.html.BROWSE.em.small	<ESC>
:amenu xGen.html.BROWSE.em.em	<ESC>
:amenu xGen.html.BROWSE.em.strong	<ESC>
:amenu xGen.html.BROWSE.em.dfn	<ESC>
:amenu xGen.html.BROWSE.em.code	<ESC>
:amenu xGen.html.BROWSE.em.q	<ESC>
:amenu xGen.html.BROWSE.em.samp	<ESC>
:amenu xGen.html.BROWSE.em.kbd	<ESC>
:amenu xGen.html.BROWSE.em.var	<ESC>
:amenu xGen.html.BROWSE.em.cite	<ESC>
:amenu xGen.html.BROWSE.em.abbr	<ESC>
:amenu xGen.html.BROWSE.em.acronym	<ESC>
:amenu xGen.html.BROWSE.em.sub	<ESC>
:amenu xGen.html.BROWSE.em.sup	<ESC>
:amenu xGen.html.BROWSE.em.input	<ESC>
:amenu xGen.html.BROWSE.em.select	<ESC>
:amenu xGen.html.BROWSE.em.textarea	<ESC>
:amenu xGen.html.BROWSE.em.label	<ESC>
:amenu xGen.html.BROWSE.em.button	<ESC>
:amenu xGen.html.BROWSE.em.ins	<ESC>
:amenu xGen.html.BROWSE.em.del	<ESC>
:amenu xGen.html.BROWSE.em.script	<ESC>
:amenu xGen.html.BROWSE.fieldset.legend	<ESC>
:amenu xGen.html.BROWSE.fieldset.p	<ESC>
:amenu xGen.html.BROWSE.fieldset.h1	<ESC>
:amenu xGen.html.BROWSE.fieldset.h2	<ESC>
:amenu xGen.html.BROWSE.fieldset.h3	<ESC>
:amenu xGen.html.BROWSE.fieldset.h4	<ESC>
:amenu xGen.html.BROWSE.fieldset.h5	<ESC>
:amenu xGen.html.BROWSE.fieldset.h6	<ESC>
:amenu xGen.html.BROWSE.fieldset.div	<ESC>
:amenu xGen.html.BROWSE.fieldset.ul	<ESC>
:amenu xGen.html.BROWSE.fieldset.ol	<ESC>
:amenu xGen.html.BROWSE.fieldset.dl	<ESC>
:amenu xGen.html.BROWSE.fieldset.pre	<ESC>
:amenu xGen.html.BROWSE.fieldset.hr	<ESC>
:amenu xGen.html.BROWSE.fieldset.blockquote	<ESC>
:amenu xGen.html.BROWSE.fieldset.address	<ESC>
:amenu xGen.html.BROWSE.fieldset.fieldset	<ESC>
:amenu xGen.html.BROWSE.fieldset.table	<ESC>
:amenu xGen.html.BROWSE.fieldset.form	<ESC>
:amenu xGen.html.BROWSE.fieldset.a	<ESC>
:amenu xGen.html.BROWSE.fieldset.br	<ESC>
:amenu xGen.html.BROWSE.fieldset.span	<ESC>
:amenu xGen.html.BROWSE.fieldset.bdo	<ESC>
:amenu xGen.html.BROWSE.fieldset.map	<ESC>
:amenu xGen.html.BROWSE.fieldset.object	<ESC>
:amenu xGen.html.BROWSE.fieldset.img	<ESC>
:amenu xGen.html.BROWSE.fieldset.tt	<ESC>
:amenu xGen.html.BROWSE.fieldset.i	<ESC>
:amenu xGen.html.BROWSE.fieldset.b	<ESC>
:amenu xGen.html.BROWSE.fieldset.big	<ESC>
:amenu xGen.html.BROWSE.fieldset.small	<ESC>
:amenu xGen.html.BROWSE.fieldset.em	<ESC>
:amenu xGen.html.BROWSE.fieldset.strong	<ESC>
:amenu xGen.html.BROWSE.fieldset.dfn	<ESC>
:amenu xGen.html.BROWSE.fieldset.code	<ESC>
:amenu xGen.html.BROWSE.fieldset.q	<ESC>
:amenu xGen.html.BROWSE.fieldset.samp	<ESC>
:amenu xGen.html.BROWSE.fieldset.kbd	<ESC>
:amenu xGen.html.BROWSE.fieldset.var	<ESC>
:amenu xGen.html.BROWSE.fieldset.cite	<ESC>
:amenu xGen.html.BROWSE.fieldset.abbr	<ESC>
:amenu xGen.html.BROWSE.fieldset.acronym	<ESC>
:amenu xGen.html.BROWSE.fieldset.sub	<ESC>
:amenu xGen.html.BROWSE.fieldset.sup	<ESC>
:amenu xGen.html.BROWSE.fieldset.input	<ESC>
:amenu xGen.html.BROWSE.fieldset.select	<ESC>
:amenu xGen.html.BROWSE.fieldset.textarea	<ESC>
:amenu xGen.html.BROWSE.fieldset.label	<ESC>
:amenu xGen.html.BROWSE.fieldset.button	<ESC>
:amenu xGen.html.BROWSE.fieldset.noscript	<ESC>
:amenu xGen.html.BROWSE.fieldset.ins	<ESC>
:amenu xGen.html.BROWSE.fieldset.del	<ESC>
:amenu xGen.html.BROWSE.fieldset.script	<ESC>
:amenu xGen.html.BROWSE.form.p	<ESC>
:amenu xGen.html.BROWSE.form.h1	<ESC>
:amenu xGen.html.BROWSE.form.h2	<ESC>
:amenu xGen.html.BROWSE.form.h3	<ESC>
:amenu xGen.html.BROWSE.form.h4	<ESC>
:amenu xGen.html.BROWSE.form.h5	<ESC>
:amenu xGen.html.BROWSE.form.h6	<ESC>
:amenu xGen.html.BROWSE.form.div	<ESC>
:amenu xGen.html.BROWSE.form.ul	<ESC>
:amenu xGen.html.BROWSE.form.ol	<ESC>
:amenu xGen.html.BROWSE.form.dl	<ESC>
:amenu xGen.html.BROWSE.form.pre	<ESC>
:amenu xGen.html.BROWSE.form.hr	<ESC>
:amenu xGen.html.BROWSE.form.blockquote	<ESC>
:amenu xGen.html.BROWSE.form.address	<ESC>
:amenu xGen.html.BROWSE.form.fieldset	<ESC>
:amenu xGen.html.BROWSE.form.table	<ESC>
:amenu xGen.html.BROWSE.form.noscript	<ESC>
:amenu xGen.html.BROWSE.form.ins	<ESC>
:amenu xGen.html.BROWSE.form.del	<ESC>
:amenu xGen.html.BROWSE.form.script	<ESC>
:amenu xGen.html.BROWSE.h1.a	<ESC>
:amenu xGen.html.BROWSE.h1.br	<ESC>
:amenu xGen.html.BROWSE.h1.span	<ESC>
:amenu xGen.html.BROWSE.h1.bdo	<ESC>
:amenu xGen.html.BROWSE.h1.map	<ESC>
:amenu xGen.html.BROWSE.h1.object	<ESC>
:amenu xGen.html.BROWSE.h1.img	<ESC>
:amenu xGen.html.BROWSE.h1.tt	<ESC>
:amenu xGen.html.BROWSE.h1.i	<ESC>
:amenu xGen.html.BROWSE.h1.b	<ESC>
:amenu xGen.html.BROWSE.h1.big	<ESC>
:amenu xGen.html.BROWSE.h1.small	<ESC>
:amenu xGen.html.BROWSE.h1.em	<ESC>
:amenu xGen.html.BROWSE.h1.strong	<ESC>
:amenu xGen.html.BROWSE.h1.dfn	<ESC>
:amenu xGen.html.BROWSE.h1.code	<ESC>
:amenu xGen.html.BROWSE.h1.q	<ESC>
:amenu xGen.html.BROWSE.h1.samp	<ESC>
:amenu xGen.html.BROWSE.h1.kbd	<ESC>
:amenu xGen.html.BROWSE.h1.var	<ESC>
:amenu xGen.html.BROWSE.h1.cite	<ESC>
:amenu xGen.html.BROWSE.h1.abbr	<ESC>
:amenu xGen.html.BROWSE.h1.acronym	<ESC>
:amenu xGen.html.BROWSE.h1.sub	<ESC>
:amenu xGen.html.BROWSE.h1.sup	<ESC>
:amenu xGen.html.BROWSE.h1.input	<ESC>
:amenu xGen.html.BROWSE.h1.select	<ESC>
:amenu xGen.html.BROWSE.h1.textarea	<ESC>
:amenu xGen.html.BROWSE.h1.label	<ESC>
:amenu xGen.html.BROWSE.h1.button	<ESC>
:amenu xGen.html.BROWSE.h1.ins	<ESC>
:amenu xGen.html.BROWSE.h1.del	<ESC>
:amenu xGen.html.BROWSE.h1.script	<ESC>
:amenu xGen.html.BROWSE.h2.a	<ESC>
:amenu xGen.html.BROWSE.h2.br	<ESC>
:amenu xGen.html.BROWSE.h2.span	<ESC>
:amenu xGen.html.BROWSE.h2.bdo	<ESC>
:amenu xGen.html.BROWSE.h2.map	<ESC>
:amenu xGen.html.BROWSE.h2.object	<ESC>
:amenu xGen.html.BROWSE.h2.img	<ESC>
:amenu xGen.html.BROWSE.h2.tt	<ESC>
:amenu xGen.html.BROWSE.h2.i	<ESC>
:amenu xGen.html.BROWSE.h2.b	<ESC>
:amenu xGen.html.BROWSE.h2.big	<ESC>
:amenu xGen.html.BROWSE.h2.small	<ESC>
:amenu xGen.html.BROWSE.h2.em	<ESC>
:amenu xGen.html.BROWSE.h2.strong	<ESC>
:amenu xGen.html.BROWSE.h2.dfn	<ESC>
:amenu xGen.html.BROWSE.h2.code	<ESC>
:amenu xGen.html.BROWSE.h2.q	<ESC>
:amenu xGen.html.BROWSE.h2.samp	<ESC>
:amenu xGen.html.BROWSE.h2.kbd	<ESC>
:amenu xGen.html.BROWSE.h2.var	<ESC>
:amenu xGen.html.BROWSE.h2.cite	<ESC>
:amenu xGen.html.BROWSE.h2.abbr	<ESC>
:amenu xGen.html.BROWSE.h2.acronym	<ESC>
:amenu xGen.html.BROWSE.h2.sub	<ESC>
:amenu xGen.html.BROWSE.h2.sup	<ESC>
:amenu xGen.html.BROWSE.h2.input	<ESC>
:amenu xGen.html.BROWSE.h2.select	<ESC>
:amenu xGen.html.BROWSE.h2.textarea	<ESC>
:amenu xGen.html.BROWSE.h2.label	<ESC>
:amenu xGen.html.BROWSE.h2.button	<ESC>
:amenu xGen.html.BROWSE.h2.ins	<ESC>
:amenu xGen.html.BROWSE.h2.del	<ESC>
:amenu xGen.html.BROWSE.h2.script	<ESC>
:amenu xGen.html.BROWSE.h3.a	<ESC>
:amenu xGen.html.BROWSE.h3.br	<ESC>
:amenu xGen.html.BROWSE.h3.span	<ESC>
:amenu xGen.html.BROWSE.h3.bdo	<ESC>
:amenu xGen.html.BROWSE.h3.map	<ESC>
:amenu xGen.html.BROWSE.h3.object	<ESC>
:amenu xGen.html.BROWSE.h3.img	<ESC>
:amenu xGen.html.BROWSE.h3.tt	<ESC>
:amenu xGen.html.BROWSE.h3.i	<ESC>
:amenu xGen.html.BROWSE.h3.b	<ESC>
:amenu xGen.html.BROWSE.h3.big	<ESC>
:amenu xGen.html.BROWSE.h3.small	<ESC>
:amenu xGen.html.BROWSE.h3.em	<ESC>
:amenu xGen.html.BROWSE.h3.strong	<ESC>
:amenu xGen.html.BROWSE.h3.dfn	<ESC>
:amenu xGen.html.BROWSE.h3.code	<ESC>
:amenu xGen.html.BROWSE.h3.q	<ESC>
:amenu xGen.html.BROWSE.h3.samp	<ESC>
:amenu xGen.html.BROWSE.h3.kbd	<ESC>
:amenu xGen.html.BROWSE.h3.var	<ESC>
:amenu xGen.html.BROWSE.h3.cite	<ESC>
:amenu xGen.html.BROWSE.h3.abbr	<ESC>
:amenu xGen.html.BROWSE.h3.acronym	<ESC>
:amenu xGen.html.BROWSE.h3.sub	<ESC>
:amenu xGen.html.BROWSE.h3.sup	<ESC>
:amenu xGen.html.BROWSE.h3.input	<ESC>
:amenu xGen.html.BROWSE.h3.select	<ESC>
:amenu xGen.html.BROWSE.h3.textarea	<ESC>
:amenu xGen.html.BROWSE.h3.label	<ESC>
:amenu xGen.html.BROWSE.h3.button	<ESC>
:amenu xGen.html.BROWSE.h3.ins	<ESC>
:amenu xGen.html.BROWSE.h3.del	<ESC>
:amenu xGen.html.BROWSE.h3.script	<ESC>
:amenu xGen.html.BROWSE.h4.a	<ESC>
:amenu xGen.html.BROWSE.h4.br	<ESC>
:amenu xGen.html.BROWSE.h4.span	<ESC>
:amenu xGen.html.BROWSE.h4.bdo	<ESC>
:amenu xGen.html.BROWSE.h4.map	<ESC>
:amenu xGen.html.BROWSE.h4.object	<ESC>
:amenu xGen.html.BROWSE.h4.img	<ESC>
:amenu xGen.html.BROWSE.h4.tt	<ESC>
:amenu xGen.html.BROWSE.h4.i	<ESC>
:amenu xGen.html.BROWSE.h4.b	<ESC>
:amenu xGen.html.BROWSE.h4.big	<ESC>
:amenu xGen.html.BROWSE.h4.small	<ESC>
:amenu xGen.html.BROWSE.h4.em	<ESC>
:amenu xGen.html.BROWSE.h4.strong	<ESC>
:amenu xGen.html.BROWSE.h4.dfn	<ESC>
:amenu xGen.html.BROWSE.h4.code	<ESC>
:amenu xGen.html.BROWSE.h4.q	<ESC>
:amenu xGen.html.BROWSE.h4.samp	<ESC>
:amenu xGen.html.BROWSE.h4.kbd	<ESC>
:amenu xGen.html.BROWSE.h4.var	<ESC>
:amenu xGen.html.BROWSE.h4.cite	<ESC>
:amenu xGen.html.BROWSE.h4.abbr	<ESC>
:amenu xGen.html.BROWSE.h4.acronym	<ESC>
:amenu xGen.html.BROWSE.h4.sub	<ESC>
:amenu xGen.html.BROWSE.h4.sup	<ESC>
:amenu xGen.html.BROWSE.h4.input	<ESC>
:amenu xGen.html.BROWSE.h4.select	<ESC>
:amenu xGen.html.BROWSE.h4.textarea	<ESC>
:amenu xGen.html.BROWSE.h4.label	<ESC>
:amenu xGen.html.BROWSE.h4.button	<ESC>
:amenu xGen.html.BROWSE.h4.ins	<ESC>
:amenu xGen.html.BROWSE.h4.del	<ESC>
:amenu xGen.html.BROWSE.h4.script	<ESC>
:amenu xGen.html.BROWSE.h5.a	<ESC>
:amenu xGen.html.BROWSE.h5.br	<ESC>
:amenu xGen.html.BROWSE.h5.span	<ESC>
:amenu xGen.html.BROWSE.h5.bdo	<ESC>
:amenu xGen.html.BROWSE.h5.map	<ESC>
:amenu xGen.html.BROWSE.h5.object	<ESC>
:amenu xGen.html.BROWSE.h5.img	<ESC>
:amenu xGen.html.BROWSE.h5.tt	<ESC>
:amenu xGen.html.BROWSE.h5.i	<ESC>
:amenu xGen.html.BROWSE.h5.b	<ESC>
:amenu xGen.html.BROWSE.h5.big	<ESC>
:amenu xGen.html.BROWSE.h5.small	<ESC>
:amenu xGen.html.BROWSE.h5.em	<ESC>
:amenu xGen.html.BROWSE.h5.strong	<ESC>
:amenu xGen.html.BROWSE.h5.dfn	<ESC>
:amenu xGen.html.BROWSE.h5.code	<ESC>
:amenu xGen.html.BROWSE.h5.q	<ESC>
:amenu xGen.html.BROWSE.h5.samp	<ESC>
:amenu xGen.html.BROWSE.h5.kbd	<ESC>
:amenu xGen.html.BROWSE.h5.var	<ESC>
:amenu xGen.html.BROWSE.h5.cite	<ESC>
:amenu xGen.html.BROWSE.h5.abbr	<ESC>
:amenu xGen.html.BROWSE.h5.acronym	<ESC>
:amenu xGen.html.BROWSE.h5.sub	<ESC>
:amenu xGen.html.BROWSE.h5.sup	<ESC>
:amenu xGen.html.BROWSE.h5.input	<ESC>
:amenu xGen.html.BROWSE.h5.select	<ESC>
:amenu xGen.html.BROWSE.h5.textarea	<ESC>
:amenu xGen.html.BROWSE.h5.label	<ESC>
:amenu xGen.html.BROWSE.h5.button	<ESC>
:amenu xGen.html.BROWSE.h5.ins	<ESC>
:amenu xGen.html.BROWSE.h5.del	<ESC>
:amenu xGen.html.BROWSE.h5.script	<ESC>
:amenu xGen.html.BROWSE.h6.a	<ESC>
:amenu xGen.html.BROWSE.h6.br	<ESC>
:amenu xGen.html.BROWSE.h6.span	<ESC>
:amenu xGen.html.BROWSE.h6.bdo	<ESC>
:amenu xGen.html.BROWSE.h6.map	<ESC>
:amenu xGen.html.BROWSE.h6.object	<ESC>
:amenu xGen.html.BROWSE.h6.img	<ESC>
:amenu xGen.html.BROWSE.h6.tt	<ESC>
:amenu xGen.html.BROWSE.h6.i	<ESC>
:amenu xGen.html.BROWSE.h6.b	<ESC>
:amenu xGen.html.BROWSE.h6.big	<ESC>
:amenu xGen.html.BROWSE.h6.small	<ESC>
:amenu xGen.html.BROWSE.h6.em	<ESC>
:amenu xGen.html.BROWSE.h6.strong	<ESC>
:amenu xGen.html.BROWSE.h6.dfn	<ESC>
:amenu xGen.html.BROWSE.h6.code	<ESC>
:amenu xGen.html.BROWSE.h6.q	<ESC>
:amenu xGen.html.BROWSE.h6.samp	<ESC>
:amenu xGen.html.BROWSE.h6.kbd	<ESC>
:amenu xGen.html.BROWSE.h6.var	<ESC>
:amenu xGen.html.BROWSE.h6.cite	<ESC>
:amenu xGen.html.BROWSE.h6.abbr	<ESC>
:amenu xGen.html.BROWSE.h6.acronym	<ESC>
:amenu xGen.html.BROWSE.h6.sub	<ESC>
:amenu xGen.html.BROWSE.h6.sup	<ESC>
:amenu xGen.html.BROWSE.h6.input	<ESC>
:amenu xGen.html.BROWSE.h6.select	<ESC>
:amenu xGen.html.BROWSE.h6.textarea	<ESC>
:amenu xGen.html.BROWSE.h6.label	<ESC>
:amenu xGen.html.BROWSE.h6.button	<ESC>
:amenu xGen.html.BROWSE.h6.ins	<ESC>
:amenu xGen.html.BROWSE.h6.del	<ESC>
:amenu xGen.html.BROWSE.h6.script	<ESC>
:amenu xGen.html.BROWSE.head.script	<ESC>
:amenu xGen.html.BROWSE.head.style	<ESC>
:amenu xGen.html.BROWSE.head.meta	<ESC>
:amenu xGen.html.BROWSE.head.link	<ESC>
:amenu xGen.html.BROWSE.head.object	<ESC>
:amenu xGen.html.BROWSE.head.title	<ESC>
:amenu xGen.html.BROWSE.head.script	<ESC>
:amenu xGen.html.BROWSE.head.style	<ESC>
:amenu xGen.html.BROWSE.head.meta	<ESC>
:amenu xGen.html.BROWSE.head.link	<ESC>
:amenu xGen.html.BROWSE.head.object	<ESC>
:amenu xGen.html.BROWSE.head.base	<ESC>
:amenu xGen.html.BROWSE.head.script	<ESC>
:amenu xGen.html.BROWSE.head.style	<ESC>
:amenu xGen.html.BROWSE.head.meta	<ESC>
:amenu xGen.html.BROWSE.head.link	<ESC>
:amenu xGen.html.BROWSE.head.object	<ESC>
:amenu xGen.html.BROWSE.head.base	<ESC>
:amenu xGen.html.BROWSE.head.script	<ESC>
:amenu xGen.html.BROWSE.head.style	<ESC>
:amenu xGen.html.BROWSE.head.meta	<ESC>
:amenu xGen.html.BROWSE.head.link	<ESC>
:amenu xGen.html.BROWSE.head.object	<ESC>
:amenu xGen.html.BROWSE.head.title	<ESC>
:amenu xGen.html.BROWSE.head.script	<ESC>
:amenu xGen.html.BROWSE.head.style	<ESC>
:amenu xGen.html.BROWSE.head.meta	<ESC>
:amenu xGen.html.BROWSE.head.link	<ESC>
:amenu xGen.html.BROWSE.head.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.html.head	<ESC>
:amenu xGen.html.BROWSE.hr>>.html.body	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.i.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.ins.q>>.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.kbd.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.label.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.legend.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.li.q>>.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.link	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.area	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.map.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.meta	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.noscript.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.param	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.object.code>>.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.ol.li	<ESC>
:amenu xGen.html.BROWSE.hr>>.optgroup.option	<ESC>
:amenu xGen.html.BROWSE.hr>>.option	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.p.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.param	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.pre.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.q.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.samp.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.select.optgroup	<ESC>
:amenu xGen.html.BROWSE.hr>>.select.option	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.small.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.span.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.strong.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.style	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.sub.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.sup.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.caption	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.thead	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.tfoot	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.col	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.colgroup	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.tbody	<ESC>
:amenu xGen.html.BROWSE.hr>>.table.tr	<ESC>
:amenu xGen.html.BROWSE.hr>>.tbody.tr	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.p	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h1	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h2	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h3	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h4	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h5	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.h6	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.div	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.ul	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.ol	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.dl	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.pre	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.hr	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.blockquote	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.address	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.fieldset	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.table	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.form	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.a	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.br	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.span	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.bdo	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.map	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.object	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.img	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.tt	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.i	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.b	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.big	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.small	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.em	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.strong	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.dfn	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.code	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.q	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.samp	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.kbd	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.var	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.cite	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.abbr	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.acronym	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.sub	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.sup	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.input	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.select	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.textarea	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.label	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.button	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.noscript	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.ins	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.del	<ESC>
:amenu xGen.html.BROWSE.hr>>.td.q>>.script	<ESC>
:amenu xGen.html.BROWSE.hr>>.textarea	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tfoot.tr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.p	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h1	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h2	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h3	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h4	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h5	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.h6	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.div	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.ul	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.ol	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.dl	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.pre	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.hr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.blockquote	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.address	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.fieldset	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.table	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.form	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.a	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.br	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.span	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.bdo	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.map	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.object	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.img	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.tt	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.i	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.b	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.big	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.small	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.em	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.strong	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.dfn	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.code	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.q	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.samp	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.kbd	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.var	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.cite	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.abbr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.acronym	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.sub	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.sup	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.input	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.select	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.textarea	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.label	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.button	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.noscript	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.ins	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.del	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.th.q>>.script	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.thead.tr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.title	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tr.th	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tr.td	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.a	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.br	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.span	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.bdo	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.map	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.object	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.img	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.tt	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.i	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.b	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.big	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.small	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.em	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.strong	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.dfn	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.code	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.q	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.samp	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.kbd	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.var	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.cite	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.abbr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.acronym	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.sub	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.sup	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.input	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.select	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.textarea	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.label	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.button	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.ins	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.del	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.tt.script	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.ul.li	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.a	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.br	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.span	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.bdo	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.map	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.object	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.img	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.tt	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.i	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.b	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.big	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.small	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.em	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.strong	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.dfn	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.code	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.q	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.samp	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.kbd	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.var	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.cite	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.abbr	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.acronym	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.sub	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.sup	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.input	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.select	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.textarea	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.label	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.button	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.ins	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.del	<ESC>
:amenu xGen.html.BROWSE.tfoot>>.var.script	<ESC>
:amenu xGen.html.-SEPid309485- :
:amenu xGen.html.FILL	:.s/\/*>$/>/<CR>yyp^a/<ESC>/[ >]<CR>C><ESC>k^
:amenu xGen.html.>>	>>
:amenu xGen.html.<<	<<
:amenu xGen.html.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.html.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:amenu 800.10.700	xGen.enable.svg	:call Set_enable_svg()<CR>
function! Set_disable_svg()
:amenu 800.10.700	xGen.enable.svg	:call Set_enable_svg()<CR>
:aunmenu xGen.disable.svg
:aunmenu xGen.svg
endfunction
function! Set_enable_svg()
:amenu 800.20.700	xGen.disable.svg	:call Set_disable_svg()<CR>
:aunmenu xGen.enable.svg
:amenu 800.700.1	xGen.svg.TEMPLATES.svg	o<?xml version="1.0" encoding="iso-8859-1" ?><ESC>o<svg:svg xmlns:xsl="http://www.w3.org/2000/svg"/><ESC>XA<ESC>o</svg:svg><ESC>
:amenu xGen.svg.MIN.a	o<svg:a xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.altGlyph	o<svg:altGlyph <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.altGlyphDef	o<svg:altGlyphDef <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.altGlyphItem	o<svg:altGlyphItem <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.animate	o<svg:animate attributeName="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.animateColor	o<svg:animateColor attributeName="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.animateMotion	o<svg:animateMotion <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.animateTransform	o<svg:animateTransform attributeName="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.circle	o<svg:circle r="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.clipPath	o<svg:clipPath <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.color-profile	o<svg:color-profile name="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.cursor	o<svg:cursor xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.definition-src	o<svg:definition-src xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.defs	o<svg:defs <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.desc	o<svg:desc <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.ellipse	o<svg:ellipse rx="required" ry="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feBlend	o<svg:feBlend in2="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feColorMatrix	o<svg:feColorMatrix <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feComponentTransfer	o<svg:feComponentTransfer <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feComposite	o<svg:feComposite in2="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feConvolveMatrix	o<svg:feConvolveMatrix kernelMatrix="required" order="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feDiffuseLighting	o<svg:feDiffuseLighting <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feDisplacementMap	o<svg:feDisplacementMap in2="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feDistantLight	o<svg:feDistantLight <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feFlood	o<svg:feFlood <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feFuncA	o<svg:feFuncA type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feFuncB	o<svg:feFuncB type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feFuncG	o<svg:feFuncG type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feFuncR	o<svg:feFuncR type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feGaussianBlur	o<svg:feGaussianBlur <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feImage	o<svg:feImage xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feMerge	o<svg:feMerge <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feMergeNode	o<svg:feMergeNode <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feMorphology	o<svg:feMorphology <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.feOffset	o<svg:feOffset <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.fePointLight	o<svg:fePointLight <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.feSpecularLighting	o<svg:feSpecularLighting <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.feSpotLight	o<svg:feSpotLight <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.feTile	o<svg:feTile <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.feTurbulence	o<svg:feTurbulence <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.filter	o<svg:filter <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font	o<svg:font horiz-adv-x="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font-face	o<svg:font-face <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font-face-format	o<svg:font-face-format <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font-face-name	o<svg:font-face-name <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font-face-src	o<svg:font-face-src <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.font-face-uri	o<svg:font-face-uri xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.foreignObject	o<svg:foreignObject height="required" width="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.g	o<svg:g <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.glyph	o<svg:glyph <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.glyphRef	o<svg:glyphRef <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.hkern	o<svg:hkern k="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.image	o<svg:image height="required" width="required" xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.line	o<svg:line <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.linearGradient	o<svg:linearGradient <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.marker	o<svg:marker <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.mask	o<svg:mask <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.metadata	o<svg:metadata <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.missing-glyph	o<svg:missing-glyph <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.mpath	o<svg:mpath xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.path	o<svg:path d="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.pattern	o<svg:pattern <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.polygon	o<svg:polygon points="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.polyline	o<svg:polyline points="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.radialGradient	o<svg:radialGradient <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.rect	o<svg:rect height="required" width="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.script	o<svg:script type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.set	o<svg:set attributeName="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.feOffset>>.stop	o<svg:stop offset="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.style	o<svg:style type="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.svg	o<svg:svg <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.switch	o<svg:switch <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.symbol	o<svg:symbol <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.text	o<svg:text <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.textPath	o<svg:textPath xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.title	o<svg:title <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.tref	o<svg:tref xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.tspan	o<svg:tspan <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.use	o<svg:use xlink:href="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.view	o<svg:view <ESC>xa/><ESC>^
:amenu xGen.svg.MIN.style>>.vkern	o<svg:vkern k="required" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.a	o<svg:a alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" target="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.altGlyph	o<svg:altGlyph alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" dx="" dy="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" format="" glyph-orientation-horizontal="" glyph-orientation-vertical="" glyphRef="" id="" image-rendering="" kerning="" letter-spacing="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rotate="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" visibility="" word-spacing="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.altGlyphDef	o<svg:altGlyphDef id="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.altGlyphItem	o<svg:altGlyphItem id="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.animate	o<svg:animate accumulate="" additive="" attributeName="required" attributeType="" begin="" by="" calcMode="" dur="" end="" externalResourcesRequired="" fill="" from="" id="" keySplines="" keyTimes="" max="" min="" onbegin="" onend="" onrepeat="" repeatCount="" repeatDur="" requiredExtensions="" requiredFeatures="" restart="" systemLanguage="" to="" values="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.animateColor	o<svg:animateColor accumulate="" additive="" attributeName="required" attributeType="" begin="" by="" calcMode="" dur="" end="" externalResourcesRequired="" fill="" from="" id="" keySplines="" keyTimes="" max="" min="" onbegin="" onend="" onrepeat="" repeatCount="" repeatDur="" requiredExtensions="" requiredFeatures="" restart="" systemLanguage="" to="" values="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.animateMotion	o<svg:animateMotion accumulate="" additive="" begin="" by="" calcMode="" dur="" end="" externalResourcesRequired="" fill="" from="" id="" keyPoints="" keySplines="" keyTimes="" max="" min="" onbegin="" onend="" onrepeat="" origin="" path="" repeatCount="" repeatDur="" requiredExtensions="" requiredFeatures="" restart="" rotate="" systemLanguage="" to="" values="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.animateTransform	o<svg:animateTransform accumulate="" additive="" attributeName="required" attributeType="" begin="" by="" calcMode="" dur="" end="" externalResourcesRequired="" fill="" from="" id="" keySplines="" keyTimes="" max="" min="" onbegin="" onend="" onrepeat="" repeatCount="" repeatDur="" requiredExtensions="" requiredFeatures="" restart="" systemLanguage="" to="" type="" values="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.circle	o<svg:circle class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" cx="" cy="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" r="required" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.clipPath	o<svg:clipPath alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" clipPathUnits="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" mask="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.color-profile	o<svg:color-profile id="" local="" name="required" rendering-intent="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.cursor	o<svg:cursor externalResourcesRequired="" id="" requiredExtensions="" requiredFeatures="" systemLanguage="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.definition-src	o<svg:definition-src id="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.defs	o<svg:defs alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.desc	o<svg:desc class="" content="" id="" style="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.ellipse	o<svg:ellipse class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" cx="" cy="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rx="required" ry="required" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feBlend	o<svg:feBlend color-interpolation-filters="" height="" id="" in="" in2="required" mode="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feColorMatrix	o<svg:feColorMatrix color-interpolation-filters="" height="" id="" in="" result="" type="" values="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feComponentTransfer	o<svg:feComponentTransfer color-interpolation-filters="" height="" id="" in="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feComposite	o<svg:feComposite color-interpolation-filters="" height="" id="" in="" in2="required" k1="" k2="" k3="" k4="" operator="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feConvolveMatrix	o<svg:feConvolveMatrix bias="" color-interpolation-filters="" divisor="" edgeMode="" height="" id="" in="" kernelMatrix="required" kernelUnitLength="" order="required" preserveAlpha="" result="" targetX="" targetY="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feDiffuseLighting	o<svg:feDiffuseLighting class="" color="" color-interpolation="" color-interpolation-filters="" color-rendering="" diffuseConstant="" height="" id="" in="" kernelUnitLength="" lighting-color="" result="" style="" surfaceScale="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feDisplacementMap	o<svg:feDisplacementMap color-interpolation-filters="" height="" id="" in="" in2="required" result="" scale="" width="" x="" xChannelSelector="" xml:base="" y="" yChannelSelector="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feDistantLight	o<svg:feDistantLight azimuth="" elevation="" id="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feFlood	o<svg:feFlood class="" color="" color-interpolation="" color-interpolation-filters="" color-rendering="" flood-color="" flood-opacity="" height="" id="" in="" result="" style="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feFuncA	o<svg:feFuncA amplitude="" exponent="" id="" intercept="" offset="" slope="" tableValues="" type="required" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feFuncB	o<svg:feFuncB amplitude="" exponent="" id="" intercept="" offset="" slope="" tableValues="" type="required" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feFuncG	o<svg:feFuncG amplitude="" exponent="" id="" intercept="" offset="" slope="" tableValues="" type="required" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feFuncR	o<svg:feFuncR amplitude="" exponent="" id="" intercept="" offset="" slope="" tableValues="" type="required" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feGaussianBlur	o<svg:feGaussianBlur color-interpolation-filters="" height="" id="" in="" result="" stdDeviation="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feImage	o<svg:feImage alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" overflow="" pointer-events="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feMerge	o<svg:feMerge color-interpolation-filters="" height="" id="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feMergeNode	o<svg:feMergeNode id="" in="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feMorphology	o<svg:feMorphology color-interpolation-filters="" height="" id="" in="" operator="" radius="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.feOffset	o<svg:feOffset color-interpolation-filters="" dx="" dy="" height="" id="" in="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.fePointLight	o<svg:fePointLight id="" x="" xml:base="" y="" z="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.feSpecularLighting	o<svg:feSpecularLighting class="" color="" color-interpolation="" color-interpolation-filters="" color-rendering="" height="" id="" in="" kernelUnitLength="" lighting-color="" result="" specularConstant="" specularExponent="" style="" surfaceScale="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.feSpotLight	o<svg:feSpotLight id="" limitingConeAngle="" pointsAtX="" pointsAtY="" pointsAtZ="" specularExponent="" x="" xml:base="" y="" z="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.feTile	o<svg:feTile color-interpolation-filters="" height="" id="" in="" result="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.feTurbulence	o<svg:feTurbulence baseFrequency="" color-interpolation-filters="" height="" id="" numOctaves="" result="" seed="" stitchTiles="" type="" width="" x="" xml:base="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.filter	o<svg:filter alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" filterRes="" filterUnits="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" overflow="" pointer-events="" primitiveUnits="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" visibility="" width="" word-spacing="" writing-mode="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font	o<svg:font alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" horiz-adv-x="required" horiz-origin-x="" horiz-origin-y="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" overflow="" pointer-events="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" vert-adv-y="" vert-origin-x="" vert-origin-y="" visibility="" word-spacing="" writing-mode="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font-face	o<svg:font-face accent-height="" alphabetic="" ascent="" bbox="" cap-height="" descent="" font-family="" font-size="" font-stretch="" font-style="" font-variant="" font-weight="" hanging="" id="" ideographic="" mathematical="" overline-position="" overline-thickness="" panose-1="" slope="" stemh="" stemv="" strikethrough-position="" strikethrough-thickness="" underline-position="" underline-thickness="" unicode-range="" units-per-em="" v-alphabetic="" v-hanging="" v-ideographic="" v-mathematical="" widths="" x-height="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font-face-format	o<svg:font-face-format id="" string="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font-face-name	o<svg:font-face-name id="" name="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font-face-src	o<svg:font-face-src id="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.font-face-uri	o<svg:font-face-uri id="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.foreignObject	o<svg:foreignObject alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" content="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="required" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" width="required" word-spacing="" writing-mode="" x="" xml:base="" xml:lang="" xml:space="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.g	o<svg:g alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.glyph	o<svg:glyph alignment-baseline="" arabic-form="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" d="" direction="" display="" dominant-baseline="" enable-background="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-name="" glyph-orientation-horizontal="" glyph-orientation-vertical="" horiz-adv-x="" id="" image-rendering="" kerning="" lang="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" orientation="" overflow="" pointer-events="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode="" unicode-bidi="" vert-adv-y="" vert-origin-x="" vert-origin-y="" visibility="" word-spacing="" writing-mode="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.glyphRef	o<svg:glyphRef class="" dx="" dy="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" format="" glyphRef="" id="" style="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.hkern	o<svg:hkern g1="" g2="" id="" k="required" u1="" u2="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.image	o<svg:image class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-profile="" color-rendering="" cursor="" display="" externalResourcesRequired="" filter="" height="required" id="" image-rendering="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" preserveAspectRatio="" requiredExtensions="" requiredFeatures="" shape-rendering="" style="" systemLanguage="" text-rendering="" transform="" visibility="" width="required" x="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.line	o<svg:line class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" x1="" x2="" xml:base="" xml:lang="" xml:space="" y1="" y2="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.linearGradient	o<svg:linearGradient class="" color="" color-interpolation="" color-rendering="" externalResourcesRequired="" gradientTransform="" gradientUnits="" id="" spreadMethod="" stop-color="" stop-opacity="" style="" x1="" x2="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" y1="" y2="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.marker	o<svg:marker alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" markerHeight="" markerUnits="" markerWidth="" mask="" opacity="" orient="" overflow="" pointer-events="" preserveAspectRatio="" refX="" refY="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" viewBox="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.mask	o<svg:mask alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" maskContentUnits="" maskUnits="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" visibility="" width="" word-spacing="" writing-mode="" x="" xml:base="" xml:lang="" xml:space="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.metadata	o<svg:metadata id="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.missing-glyph	o<svg:missing-glyph alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" d="" direction="" display="" dominant-baseline="" enable-background="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" horiz-adv-x="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" overflow="" pointer-events="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" vert-adv-y="" vert-origin-x="" vert-origin-y="" visibility="" word-spacing="" writing-mode="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.mpath	o<svg:mpath externalResourcesRequired="" id="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.path	o<svg:path class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" d="required" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pathLength="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.pattern	o<svg:pattern alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" opacity="" overflow="" patternContentUnits="" patternTransform="" patternUnits="" pointer-events="" preserveAspectRatio="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" viewBox="" visibility="" width="" word-spacing="" writing-mode="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.polygon	o<svg:polygon class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" points="required" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.polyline	o<svg:polyline class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" id="" image-rendering="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" points="required" requiredExtensions="" requiredFeatures="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.radialGradient	o<svg:radialGradient class="" color="" color-interpolation="" color-rendering="" cx="" cy="" externalResourcesRequired="" fx="" fy="" gradientTransform="" gradientUnits="" id="" r="" spreadMethod="" stop-color="" stop-opacity="" style="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.rect	o<svg:rect class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" display="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" height="required" id="" image-rendering="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rx="" ry="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-rendering="" transform="" visibility="" width="required" x="" xml:base="" xml:lang="" xml:space="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.script	o<svg:script externalResourcesRequired="" id="" type="required" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.set	o<svg:set attributeName="required" attributeType="" begin="" dur="" end="" externalResourcesRequired="" fill="" id="" max="" min="" onbegin="" onend="" onrepeat="" repeatCount="" repeatDur="" requiredExtensions="" requiredFeatures="" restart="" systemLanguage="" to="" xlink:actuate="" xlink:arcrole="" xlink:href="" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.feOffset>>.stop	o<svg:stop class="" color="" color-interpolation="" color-rendering="" id="" offset="required" stop-color="" stop-opacity="" style="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.style	o<svg:style id="" media="" title="" type="required" xml:base="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.svg	o<svg:svg alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" contentScriptType="" contentStyleType="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onabort="" onactivate="" onclick="" onerror="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" onresize="" onscroll="" onunload="" onzoom="" opacity="" overflow="" pointer-events="" preserveAspectRatio="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" version="" viewBox="" visibility="" width="" word-spacing="" writing-mode="" x="" xml:base="" xml:lang="" xml:space="" y="" zoomAndPan="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.switch	o<svg:switch alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.symbol	o<svg:symbol alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" preserveAspectRatio="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" text-anchor="" text-decoration="" text-rendering="" unicode-bidi="" viewBox="" visibility="" word-spacing="" writing-mode="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.text	o<svg:text alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" dx="" dy="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" lengthAdjust="" letter-spacing="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rotate="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" textLength="" transform="" unicode-bidi="" visibility="" word-spacing="" writing-mode="" x="" xml:base="" xml:lang="" xml:space="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.textPath	o<svg:textPath alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" lengthAdjust="" letter-spacing="" mask="" method="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" spacing="" startOffset="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" textLength="" unicode-bidi="" visibility="" word-spacing="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.title	o<svg:title class="" content="" id="" style="" xml:base="" xml:lang="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.tref	o<svg:tref alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" dx="" dy="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" lengthAdjust="" letter-spacing="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rotate="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" textLength="" unicode-bidi="" visibility="" word-spacing="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.tspan	o<svg:tspan alignment-baseline="" baseline-shift="" class="" clip-path="" clip-rule="" color="" color-interpolation="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" dx="" dy="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" id="" image-rendering="" kerning="" lengthAdjust="" letter-spacing="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" pointer-events="" requiredExtensions="" requiredFeatures="" rotate="" shape-rendering="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" textLength="" unicode-bidi="" visibility="" word-spacing="" x="" xml:base="" xml:lang="" xml:space="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.use	o<svg:use alignment-baseline="" baseline-shift="" class="" clip="" clip-path="" clip-rule="" color="" color-interpolation="" color-interpolation-filters="" color-profile="" color-rendering="" cursor="" direction="" display="" dominant-baseline="" enable-background="" externalResourcesRequired="" fill="" fill-opacity="" fill-rule="" filter="" flood-color="" flood-opacity="" font-family="" font-size="" font-size-adjust="" font-stretch="" font-style="" font-variant="" font-weight="" glyph-orientation-horizontal="" glyph-orientation-vertical="" height="" id="" image-rendering="" kerning="" letter-spacing="" lighting-color="" marker-end="" marker-mid="" marker-start="" mask="" onactivate="" onclick="" onfocusin="" onfocusout="" onload="" onmousedown="" onmousemove="" onmouseout="" onmouseover="" onmouseup="" opacity="" overflow="" pointer-events="" requiredExtensions="" requiredFeatures="" shape-rendering="" stop-color="" stop-opacity="" stroke="" stroke-dasharray="" stroke-dashoffset="" stroke-linecap="" stroke-linejoin="" stroke-miterlimit="" stroke-opacity="" stroke-width="" style="" systemLanguage="" text-anchor="" text-decoration="" text-rendering="" transform="" unicode-bidi="" visibility="" width="" word-spacing="" writing-mode="" x="" xlink:actuate="" xlink:arcrole="" xlink:href="required" xlink:role="" xlink:show="" xlink:title="" xlink:type="" xml:base="" xml:lang="" xml:space="" xmlns:xlink="" y="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.view	o<svg:view externalResourcesRequired="" id="" preserveAspectRatio="" viewBox="" viewTarget="" xml:base="" zoomAndPan="" <ESC>xa/><ESC>^
:amenu xGen.svg.MAX.style>>.vkern	o<svg:vkern g1="" g2="" id="" k="required" u1="" u2="" xml:base="" <ESC>xa/><ESC>^
:amenu xGen.svg.-SEPid182885- :
:amenu xGen.svg.BROWSE.a.desc	<ESC>
:amenu xGen.svg.BROWSE.a.title	<ESC>
:amenu xGen.svg.BROWSE.a.metadata	<ESC>
:amenu xGen.svg.BROWSE.a.defs	<ESC>
:amenu xGen.svg.BROWSE.a.path	<ESC>
:amenu xGen.svg.BROWSE.a.text	<ESC>
:amenu xGen.svg.BROWSE.a.rect	<ESC>
:amenu xGen.svg.BROWSE.a.circle	<ESC>
:amenu xGen.svg.BROWSE.a.ellipse	<ESC>
:amenu xGen.svg.BROWSE.a.line	<ESC>
:amenu xGen.svg.BROWSE.a.polyline	<ESC>
:amenu xGen.svg.BROWSE.a.polygon	<ESC>
:amenu xGen.svg.BROWSE.a.use	<ESC>
:amenu xGen.svg.BROWSE.a.image	<ESC>
:amenu xGen.svg.BROWSE.a.svg	<ESC>
:amenu xGen.svg.BROWSE.a.g	<ESC>
:amenu xGen.svg.BROWSE.a.view	<ESC>
:amenu xGen.svg.BROWSE.a.switch	<ESC>
:amenu xGen.svg.BROWSE.a.a	<ESC>
:amenu xGen.svg.BROWSE.a.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.a.script	<ESC>
:amenu xGen.svg.BROWSE.a.style	<ESC>
:amenu xGen.svg.BROWSE.a.symbol	<ESC>
:amenu xGen.svg.BROWSE.a.marker	<ESC>
:amenu xGen.svg.BROWSE.a.clipPath	<ESC>
:amenu xGen.svg.BROWSE.a.mask	<ESC>
:amenu xGen.svg.BROWSE.a.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.a.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.a.pattern	<ESC>
:amenu xGen.svg.BROWSE.a.filter	<ESC>
:amenu xGen.svg.BROWSE.a.cursor	<ESC>
:amenu xGen.svg.BROWSE.a.font	<ESC>
:amenu xGen.svg.BROWSE.a.animate	<ESC>
:amenu xGen.svg.BROWSE.a.set	<ESC>
:amenu xGen.svg.BROWSE.a.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.a.animateColor	<ESC>
:amenu xGen.svg.BROWSE.a.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.a.color-profile	<ESC>
:amenu xGen.svg.BROWSE.a.font-face	<ESC>
:amenu xGen.svg.BROWSE.altGlyph	<ESC>
:amenu xGen.svg.BROWSE.altGlyphDef.glyphRef	<ESC>
:amenu xGen.svg.BROWSE.altGlyphDef.altGlyphItem	<ESC>
:amenu xGen.svg.BROWSE.altGlyphItem.glyphRef	<ESC>
:amenu xGen.svg.BROWSE.animate.desc	<ESC>
:amenu xGen.svg.BROWSE.animate.title	<ESC>
:amenu xGen.svg.BROWSE.animate.metadata	<ESC>
:amenu xGen.svg.BROWSE.animate.metadata	<ESC>
:amenu xGen.svg.BROWSE.animate.title	<ESC>
:amenu xGen.svg.BROWSE.animate.title	<ESC>
:amenu xGen.svg.BROWSE.animate.desc	<ESC>
:amenu xGen.svg.BROWSE.animate.metadata	<ESC>
:amenu xGen.svg.BROWSE.animate.metadata	<ESC>
:amenu xGen.svg.BROWSE.animate.desc	<ESC>
:amenu xGen.svg.BROWSE.animate.metadata	<ESC>
:amenu xGen.svg.BROWSE.animate.desc	<ESC>
:amenu xGen.svg.BROWSE.animate.title	<ESC>
:amenu xGen.svg.BROWSE.animate.title	<ESC>
:amenu xGen.svg.BROWSE.animate.desc	<ESC>
:amenu xGen.svg.BROWSE.animateColor.desc	<ESC>
:amenu xGen.svg.BROWSE.animateColor.title	<ESC>
:amenu xGen.svg.BROWSE.animateColor.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateColor.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateColor.title	<ESC>
:amenu xGen.svg.BROWSE.animateColor.title	<ESC>
:amenu xGen.svg.BROWSE.animateColor.desc	<ESC>
:amenu xGen.svg.BROWSE.animateColor.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateColor.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateColor.desc	<ESC>
:amenu xGen.svg.BROWSE.animateColor.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateColor.desc	<ESC>
:amenu xGen.svg.BROWSE.animateColor.title	<ESC>
:amenu xGen.svg.BROWSE.animateColor.title	<ESC>
:amenu xGen.svg.BROWSE.animateColor.desc	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.mpath	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.desc	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.title	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.title	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.title	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.desc	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.desc	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.desc	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.title	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.title	<ESC>
:amenu xGen.svg.BROWSE.animateMotion.desc	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.desc	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.title	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.title	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.title	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.desc	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.desc	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.metadata	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.desc	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.title	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.title	<ESC>
:amenu xGen.svg.BROWSE.animateTransform.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.title	<ESC>
:amenu xGen.svg.BROWSE.circle.metadata	<ESC>
:amenu xGen.svg.BROWSE.circle.metadata	<ESC>
:amenu xGen.svg.BROWSE.circle.title	<ESC>
:amenu xGen.svg.BROWSE.circle.title	<ESC>
:amenu xGen.svg.BROWSE.circle.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.metadata	<ESC>
:amenu xGen.svg.BROWSE.circle.metadata	<ESC>
:amenu xGen.svg.BROWSE.circle.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.metadata	<ESC>
:amenu xGen.svg.BROWSE.circle.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.title	<ESC>
:amenu xGen.svg.BROWSE.circle.title	<ESC>
:amenu xGen.svg.BROWSE.circle.desc	<ESC>
:amenu xGen.svg.BROWSE.circle.animate	<ESC>
:amenu xGen.svg.BROWSE.circle.set	<ESC>
:amenu xGen.svg.BROWSE.circle.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.circle.animateColor	<ESC>
:amenu xGen.svg.BROWSE.circle.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.clipPath.desc	<ESC>
:amenu xGen.svg.BROWSE.clipPath.title	<ESC>
:amenu xGen.svg.BROWSE.clipPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.clipPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.clipPath.title	<ESC>
:amenu xGen.svg.BROWSE.clipPath.title	<ESC>
:amenu xGen.svg.BROWSE.clipPath.desc	<ESC>
:amenu xGen.svg.BROWSE.clipPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.clipPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.clipPath.desc	<ESC>
:amenu xGen.svg.BROWSE.clipPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.clipPath.desc	<ESC>
:amenu xGen.svg.BROWSE.clipPath.title	<ESC>
:amenu xGen.svg.BROWSE.clipPath.title	<ESC>
:amenu xGen.svg.BROWSE.clipPath.desc	<ESC>
:amenu xGen.svg.BROWSE.clipPath.path	<ESC>
:amenu xGen.svg.BROWSE.clipPath.text	<ESC>
:amenu xGen.svg.BROWSE.clipPath.rect	<ESC>
:amenu xGen.svg.BROWSE.clipPath.circle	<ESC>
:amenu xGen.svg.BROWSE.clipPath.ellipse	<ESC>
:amenu xGen.svg.BROWSE.clipPath.line	<ESC>
:amenu xGen.svg.BROWSE.clipPath.polyline	<ESC>
:amenu xGen.svg.BROWSE.clipPath.polygon	<ESC>
:amenu xGen.svg.BROWSE.clipPath.use	<ESC>
:amenu xGen.svg.BROWSE.clipPath.animate	<ESC>
:amenu xGen.svg.BROWSE.clipPath.set	<ESC>
:amenu xGen.svg.BROWSE.clipPath.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.clipPath.animateColor	<ESC>
:amenu xGen.svg.BROWSE.clipPath.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.color-profile.desc	<ESC>
:amenu xGen.svg.BROWSE.color-profile.title	<ESC>
:amenu xGen.svg.BROWSE.color-profile.metadata	<ESC>
:amenu xGen.svg.BROWSE.color-profile.metadata	<ESC>
:amenu xGen.svg.BROWSE.color-profile.title	<ESC>
:amenu xGen.svg.BROWSE.color-profile.title	<ESC>
:amenu xGen.svg.BROWSE.color-profile.desc	<ESC>
:amenu xGen.svg.BROWSE.color-profile.metadata	<ESC>
:amenu xGen.svg.BROWSE.color-profile.metadata	<ESC>
:amenu xGen.svg.BROWSE.color-profile.desc	<ESC>
:amenu xGen.svg.BROWSE.color-profile.metadata	<ESC>
:amenu xGen.svg.BROWSE.color-profile.desc	<ESC>
:amenu xGen.svg.BROWSE.color-profile.title	<ESC>
:amenu xGen.svg.BROWSE.color-profile.title	<ESC>
:amenu xGen.svg.BROWSE.color-profile.desc	<ESC>
:amenu xGen.svg.BROWSE.cursor.desc	<ESC>
:amenu xGen.svg.BROWSE.cursor.title	<ESC>
:amenu xGen.svg.BROWSE.cursor.metadata	<ESC>
:amenu xGen.svg.BROWSE.cursor.metadata	<ESC>
:amenu xGen.svg.BROWSE.cursor.title	<ESC>
:amenu xGen.svg.BROWSE.cursor.title	<ESC>
:amenu xGen.svg.BROWSE.cursor.desc	<ESC>
:amenu xGen.svg.BROWSE.cursor.metadata	<ESC>
:amenu xGen.svg.BROWSE.cursor.metadata	<ESC>
:amenu xGen.svg.BROWSE.cursor.desc	<ESC>
:amenu xGen.svg.BROWSE.cursor.metadata	<ESC>
:amenu xGen.svg.BROWSE.cursor.desc	<ESC>
:amenu xGen.svg.BROWSE.cursor.title	<ESC>
:amenu xGen.svg.BROWSE.cursor.title	<ESC>
:amenu xGen.svg.BROWSE.cursor.desc	<ESC>
:amenu xGen.svg.BROWSE.definition-src	<ESC>
:amenu xGen.svg.BROWSE.defs.desc	<ESC>
:amenu xGen.svg.BROWSE.defs.title	<ESC>
:amenu xGen.svg.BROWSE.defs.metadata	<ESC>
:amenu xGen.svg.BROWSE.defs.defs	<ESC>
:amenu xGen.svg.BROWSE.defs.path	<ESC>
:amenu xGen.svg.BROWSE.defs.text	<ESC>
:amenu xGen.svg.BROWSE.defs.rect	<ESC>
:amenu xGen.svg.BROWSE.defs.circle	<ESC>
:amenu xGen.svg.BROWSE.defs.ellipse	<ESC>
:amenu xGen.svg.BROWSE.defs.line	<ESC>
:amenu xGen.svg.BROWSE.defs.polyline	<ESC>
:amenu xGen.svg.BROWSE.defs.polygon	<ESC>
:amenu xGen.svg.BROWSE.defs.use	<ESC>
:amenu xGen.svg.BROWSE.defs.image	<ESC>
:amenu xGen.svg.BROWSE.defs.svg	<ESC>
:amenu xGen.svg.BROWSE.defs.g	<ESC>
:amenu xGen.svg.BROWSE.defs.view	<ESC>
:amenu xGen.svg.BROWSE.defs.switch	<ESC>
:amenu xGen.svg.BROWSE.defs.a	<ESC>
:amenu xGen.svg.BROWSE.defs.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.defs.script	<ESC>
:amenu xGen.svg.BROWSE.defs.style	<ESC>
:amenu xGen.svg.BROWSE.defs.symbol	<ESC>
:amenu xGen.svg.BROWSE.defs.marker	<ESC>
:amenu xGen.svg.BROWSE.defs.clipPath	<ESC>
:amenu xGen.svg.BROWSE.defs.mask	<ESC>
:amenu xGen.svg.BROWSE.defs.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.defs.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.defs.pattern	<ESC>
:amenu xGen.svg.BROWSE.defs.filter	<ESC>
:amenu xGen.svg.BROWSE.defs.cursor	<ESC>
:amenu xGen.svg.BROWSE.defs.font	<ESC>
:amenu xGen.svg.BROWSE.defs.animate	<ESC>
:amenu xGen.svg.BROWSE.defs.set	<ESC>
:amenu xGen.svg.BROWSE.defs.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.defs.animateColor	<ESC>
:amenu xGen.svg.BROWSE.defs.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.defs.color-profile	<ESC>
:amenu xGen.svg.BROWSE.defs.font-face	<ESC>
:amenu xGen.svg.BROWSE.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.title	<ESC>
:amenu xGen.svg.BROWSE.ellipse.metadata	<ESC>
:amenu xGen.svg.BROWSE.ellipse.metadata	<ESC>
:amenu xGen.svg.BROWSE.ellipse.title	<ESC>
:amenu xGen.svg.BROWSE.ellipse.title	<ESC>
:amenu xGen.svg.BROWSE.ellipse.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.metadata	<ESC>
:amenu xGen.svg.BROWSE.ellipse.metadata	<ESC>
:amenu xGen.svg.BROWSE.ellipse.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.metadata	<ESC>
:amenu xGen.svg.BROWSE.ellipse.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.title	<ESC>
:amenu xGen.svg.BROWSE.ellipse.title	<ESC>
:amenu xGen.svg.BROWSE.ellipse.desc	<ESC>
:amenu xGen.svg.BROWSE.ellipse.animate	<ESC>
:amenu xGen.svg.BROWSE.ellipse.set	<ESC>
:amenu xGen.svg.BROWSE.ellipse.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.ellipse.animateColor	<ESC>
:amenu xGen.svg.BROWSE.ellipse.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feBlend.animate	<ESC>
:amenu xGen.svg.BROWSE.feBlend.set	<ESC>
:amenu xGen.svg.BROWSE.feColorMatrix.animate	<ESC>
:amenu xGen.svg.BROWSE.feColorMatrix.set	<ESC>
:amenu xGen.svg.BROWSE.feComponentTransfer.feFuncR	<ESC>
:amenu xGen.svg.BROWSE.feComponentTransfer.feFuncG	<ESC>
:amenu xGen.svg.BROWSE.feComponentTransfer.feFuncB	<ESC>
:amenu xGen.svg.BROWSE.feComponentTransfer.feFuncA	<ESC>
:amenu xGen.svg.BROWSE.feComposite.animate	<ESC>
:amenu xGen.svg.BROWSE.feComposite.set	<ESC>
:amenu xGen.svg.BROWSE.feConvolveMatrix.animate	<ESC>
:amenu xGen.svg.BROWSE.feConvolveMatrix.set	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.feDistantLight	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.fePointLight	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.feSpotLight	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.animate	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.set	<ESC>
:amenu xGen.svg.BROWSE.feDiffuseLighting.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feDisplacementMap.animate	<ESC>
:amenu xGen.svg.BROWSE.feDisplacementMap.set	<ESC>
:amenu xGen.svg.BROWSE.feDistantLight.animate	<ESC>
:amenu xGen.svg.BROWSE.feDistantLight.set	<ESC>
:amenu xGen.svg.BROWSE.feFlood.animate	<ESC>
:amenu xGen.svg.BROWSE.feFlood.set	<ESC>
:amenu xGen.svg.BROWSE.feFlood.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feFuncA.animate	<ESC>
:amenu xGen.svg.BROWSE.feFuncA.set	<ESC>
:amenu xGen.svg.BROWSE.feFuncB.animate	<ESC>
:amenu xGen.svg.BROWSE.feFuncB.set	<ESC>
:amenu xGen.svg.BROWSE.feFuncG.animate	<ESC>
:amenu xGen.svg.BROWSE.feFuncG.set	<ESC>
:amenu xGen.svg.BROWSE.feFuncR.animate	<ESC>
:amenu xGen.svg.BROWSE.feFuncR.set	<ESC>
:amenu xGen.svg.BROWSE.feGaussianBlur.animate	<ESC>
:amenu xGen.svg.BROWSE.feGaussianBlur.set	<ESC>
:amenu xGen.svg.BROWSE.feImage.animate	<ESC>
:amenu xGen.svg.BROWSE.feImage.set	<ESC>
:amenu xGen.svg.BROWSE.feImage.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feMerge.feMergeNode	<ESC>
:amenu xGen.svg.BROWSE.feMergeNode.animate	<ESC>
:amenu xGen.svg.BROWSE.feMergeNode.set	<ESC>
:amenu xGen.svg.BROWSE.feMorphology.animate	<ESC>
:amenu xGen.svg.BROWSE.feMorphology.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feOffset.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feOffset.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.fePointLight.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.fePointLight.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.feDistantLight	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.fePointLight	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.feSpotLight	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpecularLighting.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpotLight.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feSpotLight.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feTile.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feTile.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feTurbulence.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.feTurbulence.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feBlend	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feFlood	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feColorMatrix	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feComponentTransfer	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feComposite	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feConvolveMatrix	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feDiffuseLighting	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feDisplacementMap	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feGaussianBlur	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feImage	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feMerge	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feMorphology	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feOffset	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feSpecularLighting	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feTile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.feTurbulence	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.filter.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.missing-glyph	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.glyph	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.hkern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font.vkern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.font-face-src	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.definition-src	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face-format	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face-name	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face-src.font-face-uri	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face-src.font-face-name	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.font-face-uri.font-face-format	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.foreignObject	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.g.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyph.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.glyphRef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.hkern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.image.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.line.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.stop	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.linearGradient.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.marker.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mask.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.missing-glyph.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.mpath.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.path.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.defs	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.path	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.text	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.rect	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.circle	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.ellipse	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.line	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.polyline	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.polygon	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.use	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.image	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.svg	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.g	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.view	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.switch	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.a	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.style	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.symbol	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.marker	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.clipPath	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.mask	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.pattern	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.filter	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.cursor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.font	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.pattern.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polygon.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.polyline.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.stop	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.radialGradient.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.animateColor	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.rect.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.script	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.metadata	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.title	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.set.desc	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.stop.animate	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.stop.set	<ESC>
:amenu xGen.svg.BROWSE.feOffset>>.stop.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.style	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.defs	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.path	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.text	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.rect	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.circle	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.ellipse	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.line	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.polyline	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.polygon	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.use	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.image	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.svg	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.g	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.view	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.switch	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.script	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.style	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.symbol	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.marker	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.clipPath	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.mask	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.pattern	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.filter	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.cursor	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.font	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.style>>.svg.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.path	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.text	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.rect	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.circle	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.ellipse	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.line	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.polyline	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.polygon	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.use	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.image	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.svg	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.g	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.switch	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.foreignObject	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.switch.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.defs	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.path	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.text	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.rect	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.circle	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.ellipse	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.line	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.polyline	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.polygon	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.use	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.image	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.svg	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.g	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.view	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.switch	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.altGlyphDef	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.script	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.style	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.symbol	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.marker	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.clipPath	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.mask	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.linearGradient	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.radialGradient	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.pattern	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.filter	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.cursor	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.font	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animateMotion>>.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animateMotion>>.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animateMotion>>.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animateMotion>>.color-profile	<ESC>
:amenu xGen.svg.BROWSE.style>>.symbol.animateMotion>>.font-face	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.tspan	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.tref	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.textPath	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.altGlyph	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.text.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.tspan	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.tref	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.altGlyph	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.textPath.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.tref.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.tspan	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.tref	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.altGlyph	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.a	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.tspan.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.animate	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.set	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.animateMotion	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.animateColor	<ESC>
:amenu xGen.svg.BROWSE.style>>.use.animateTransform	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.metadata	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.title	<ESC>
:amenu xGen.svg.BROWSE.style>>.view.desc	<ESC>
:amenu xGen.svg.BROWSE.style>>.vkern	<ESC>
:amenu xGen.svg.-SEPid196617- :
:amenu xGen.svg.FILL	:.s/\/*>$/>/<CR>yyp^a/<ESC>/[ >]<CR>C><ESC>k^
:amenu xGen.svg.>>	>>
:amenu xGen.svg.<<	<<
:amenu xGen.svg.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.svg.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:amenu 800.10.900	xGen.enable.xsd	:call Set_enable_xsd()<CR>
function! Set_disable_xsd()
:amenu 800.10.900	xGen.enable.xsd	:call Set_enable_xsd()<CR>
:aunmenu xGen.disable.xsd
:aunmenu xGen.xsd
endfunction
function! Set_enable_xsd()
:amenu 800.20.900	xGen.disable.xsd	:call Set_disable_xsd()<CR>
:aunmenu xGen.enable.xsd
:amenu 800.900.1	xGen.xsd.TEMPLATES.NO-TEMPLATES	<ESC>
:amenu xGen.xsd.MIN.all	o<xsd:all <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.annotation	o<xsd:annotation <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.any	o<xsd:any <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.anyAttribute	o<xsd:anyAttribute <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.appinfo	o<xsd:appinfo <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.attribute	o<xsd:attribute <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.attributeGroup	o<xsd:attributeGroup <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.choice	o<xsd:choice <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.complexContent	o<xsd:complexContent <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.complexType	o<xsd:complexType <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.documentation	o<xsd:documentation <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.element	o<xsd:element <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.enumeration	o<xsd:enumeration value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.extension	o<xsd:extension base="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.field	o<xsd:field xpath="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.fractionDigits	o<xsd:fractionDigits value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.group	o<xsd:group <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.import	o<xsd:import <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.include	o<xsd:include schemaLocation="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.key	o<xsd:key name="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.keyref	o<xsd:keyref name="required" refer="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.length	o<xsd:length value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.list	o<xsd:list <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.maxExclusive	o<xsd:maxExclusive value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.maxInclusive	o<xsd:maxInclusive value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.maxLength	o<xsd:maxLength value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.minExclusive	o<xsd:minExclusive value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.minInclusive	o<xsd:minInclusive value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.minLength	o<xsd:minLength value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.notation	o<xsd:notation name="required" public="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.pattern	o<xsd:pattern value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.redefine	o<xsd:redefine schemaLocation="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.restriction	o<xsd:restriction <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.schema	o<xsd:schema <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.selector	o<xsd:selector xpath="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.sequence	o<xsd:sequence <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.simpleContent	o<xsd:simpleContent <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.simpleType	o<xsd:simpleType <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.totalDigits	o<xsd:totalDigits value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.union	o<xsd:union <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.unique	o<xsd:unique name="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MIN.selector>>.whiteSpace	o<xsd:whiteSpace value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.all	o<xsd:all id="" maxOccurs="" minOccurs="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.annotation	o<xsd:annotation <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.any	o<xsd:any id="" maxOccurs="" minOccurs="" namespace="" processContents="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.anyAttribute	o<xsd:anyAttribute id="" namespace="" processContents="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.appinfo	o<xsd:appinfo id="" source="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.attribute	o<xsd:attribute default="" fixed="" form="" id="" name="" ref="" type="" use="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.attributeGroup	o<xsd:attributeGroup id="" name="" ref="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.choice	o<xsd:choice id="" maxOccurs="" minOccurs="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.complexContent	o<xsd:complexContent id="" mixed="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.complexType	o<xsd:complexType abstract="" block="" final="" id="" mixed="" name="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.documentation	o<xsd:documentation id="" source="" xml:lang="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.element	o<xsd:element abstract="" block="" default="" final="" fixed="" form="" id="" maxOccurs="" minOccurs="" name="" nillable="" ref="" substitutionGroup="" type="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.enumeration	o<xsd:enumeration id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.extension	o<xsd:extension base="required" id="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.field	o<xsd:field id="" xpath="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.fractionDigits	o<xsd:fractionDigits fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.group	o<xsd:group id="" maxOccurs="" minOccurs="" name="" ref="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.import	o<xsd:import id="" namespace="" schemaLocation="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.include	o<xsd:include id="" schemaLocation="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.key	o<xsd:key id="" name="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.keyref	o<xsd:keyref id="" name="required" refer="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.length	o<xsd:length fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.list	o<xsd:list id="" itemType="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.maxExclusive	o<xsd:maxExclusive fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.maxInclusive	o<xsd:maxInclusive fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.maxLength	o<xsd:maxLength fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.minExclusive	o<xsd:minExclusive fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.minInclusive	o<xsd:minInclusive fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.minLength	o<xsd:minLength fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.notation	o<xsd:notation id="" name="required" public="required" system="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.pattern	o<xsd:pattern id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.redefine	o<xsd:redefine id="" schemaLocation="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.restriction	o<xsd:restriction base="" id="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.schema	o<xsd:schema attributeFormDefault="" blockDefault="" elementFormDefault="" finalDefault="" id="" targetNamespace="" version="" xml:lang="" xmlns:xs="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.selector	o<xsd:selector id="" xpath="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.sequence	o<xsd:sequence id="" maxOccurs="" minOccurs="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.simpleContent	o<xsd:simpleContent id="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.simpleType	o<xsd:simpleType final="" id="" name="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.totalDigits	o<xsd:totalDigits fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.union	o<xsd:union id="" memberTypes="" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.unique	o<xsd:unique id="" name="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.MAX.selector>>.whiteSpace	o<xsd:whiteSpace fixed="" id="" value="required" <ESC>xa/><ESC>^
:amenu xGen.xsd.-SEPid180914- :
:amenu xGen.xsd.ROOTS.schema	O<?xml version="1.0" encoding="ISO-8859-1"?><ESC>o<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" attributeFormDefault="" blockDefault="" elementFormDefault="" finalDefault="" id="" targetNamespace="" version="" xml:lang="" xmlns:xs="" <ESC>xa/><ESC>^
:amenu xGen.xsd.BROWSE.all.annotation	<ESC>
:amenu xGen.xsd.BROWSE.all.element	<ESC>
:amenu xGen.xsd.BROWSE.annotation.appinfo	<ESC>
:amenu xGen.xsd.BROWSE.annotation.documentation	<ESC>
:amenu xGen.xsd.BROWSE.any.annotation	<ESC>
:amenu xGen.xsd.BROWSE.anyAttribute.annotation	<ESC>
:amenu xGen.xsd.BROWSE.appinfo	<ESC>
:amenu xGen.xsd.BROWSE.attribute.annotation	<ESC>
:amenu xGen.xsd.BROWSE.attribute.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.attributeGroup.annotation	<ESC>
:amenu xGen.xsd.BROWSE.attributeGroup.attribute	<ESC>
:amenu xGen.xsd.BROWSE.attributeGroup.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.attributeGroup.anyAttribute	<ESC>
:amenu xGen.xsd.BROWSE.choice.annotation	<ESC>
:amenu xGen.xsd.BROWSE.choice.element	<ESC>
:amenu xGen.xsd.BROWSE.choice.group	<ESC>
:amenu xGen.xsd.BROWSE.choice.choice	<ESC>
:amenu xGen.xsd.BROWSE.choice.sequence	<ESC>
:amenu xGen.xsd.BROWSE.choice.any	<ESC>
:amenu xGen.xsd.BROWSE.complexContent.restriction	<ESC>
:amenu xGen.xsd.BROWSE.complexContent.extension	<ESC>
:amenu xGen.xsd.BROWSE.complexType.annotation	<ESC>
:amenu xGen.xsd.BROWSE.complexType.simpleContent	<ESC>
:amenu xGen.xsd.BROWSE.complexType.complexContent	<ESC>
:amenu xGen.xsd.BROWSE.complexType.all	<ESC>
:amenu xGen.xsd.BROWSE.complexType.choice	<ESC>
:amenu xGen.xsd.BROWSE.complexType.sequence	<ESC>
:amenu xGen.xsd.BROWSE.complexType.group	<ESC>
:amenu xGen.xsd.BROWSE.complexType.attribute	<ESC>
:amenu xGen.xsd.BROWSE.complexType.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.complexType.anyAttribute	<ESC>
:amenu xGen.xsd.BROWSE.documentation	<ESC>
:amenu xGen.xsd.BROWSE.element.annotation	<ESC>
:amenu xGen.xsd.BROWSE.element.complexType	<ESC>
:amenu xGen.xsd.BROWSE.element.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.element.unique	<ESC>
:amenu xGen.xsd.BROWSE.element.key	<ESC>
:amenu xGen.xsd.BROWSE.element.keyref	<ESC>
:amenu xGen.xsd.BROWSE.enumeration.annotation	<ESC>
:amenu xGen.xsd.BROWSE.extension.all	<ESC>
:amenu xGen.xsd.BROWSE.extension.choice	<ESC>
:amenu xGen.xsd.BROWSE.extension.sequence	<ESC>
:amenu xGen.xsd.BROWSE.extension.group	<ESC>
:amenu xGen.xsd.BROWSE.extension.attribute	<ESC>
:amenu xGen.xsd.BROWSE.extension.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.extension.anyAttribute	<ESC>
:amenu xGen.xsd.BROWSE.field.annotation	<ESC>
:amenu xGen.xsd.BROWSE.fractionDigits.annotation	<ESC>
:amenu xGen.xsd.BROWSE.group.annotation	<ESC>
:amenu xGen.xsd.BROWSE.group.all	<ESC>
:amenu xGen.xsd.BROWSE.group.choice	<ESC>
:amenu xGen.xsd.BROWSE.group.sequence	<ESC>
:amenu xGen.xsd.BROWSE.import.annotation	<ESC>
:amenu xGen.xsd.BROWSE.include.annotation	<ESC>
:amenu xGen.xsd.BROWSE.key.selector	<ESC>
:amenu xGen.xsd.BROWSE.key.annotation	<ESC>
:amenu xGen.xsd.BROWSE.key.field	<ESC>
:amenu xGen.xsd.BROWSE.keyref.selector	<ESC>
:amenu xGen.xsd.BROWSE.keyref.annotation	<ESC>
:amenu xGen.xsd.BROWSE.keyref.field	<ESC>
:amenu xGen.xsd.BROWSE.length.annotation	<ESC>
:amenu xGen.xsd.BROWSE.list.annotation	<ESC>
:amenu xGen.xsd.BROWSE.list.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.maxExclusive.annotation	<ESC>
:amenu xGen.xsd.BROWSE.maxInclusive.annotation	<ESC>
:amenu xGen.xsd.BROWSE.maxLength.annotation	<ESC>
:amenu xGen.xsd.BROWSE.minExclusive.annotation	<ESC>
:amenu xGen.xsd.BROWSE.minInclusive.annotation	<ESC>
:amenu xGen.xsd.BROWSE.minLength.annotation	<ESC>
:amenu xGen.xsd.BROWSE.notation.annotation	<ESC>
:amenu xGen.xsd.BROWSE.pattern.annotation	<ESC>
:amenu xGen.xsd.BROWSE.redefine.annotation	<ESC>
:amenu xGen.xsd.BROWSE.redefine.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.redefine.complexType	<ESC>
:amenu xGen.xsd.BROWSE.redefine.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.redefine.group	<ESC>
:amenu xGen.xsd.BROWSE.restriction.annotation	<ESC>
:amenu xGen.xsd.BROWSE.restriction.all	<ESC>
:amenu xGen.xsd.BROWSE.restriction.choice	<ESC>
:amenu xGen.xsd.BROWSE.restriction.sequence	<ESC>
:amenu xGen.xsd.BROWSE.restriction.group	<ESC>
:amenu xGen.xsd.BROWSE.restriction.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.restriction.totalDigits	<ESC>
:amenu xGen.xsd.BROWSE.restriction.fractionDigits	<ESC>
:amenu xGen.xsd.BROWSE.restriction.pattern	<ESC>
:amenu xGen.xsd.BROWSE.restriction.enumeration	<ESC>
:amenu xGen.xsd.BROWSE.restriction.whiteSpace	<ESC>
:amenu xGen.xsd.BROWSE.restriction.length	<ESC>
:amenu xGen.xsd.BROWSE.restriction.maxLength	<ESC>
:amenu xGen.xsd.BROWSE.restriction.minLength	<ESC>
:amenu xGen.xsd.BROWSE.restriction.minInclusive	<ESC>
:amenu xGen.xsd.BROWSE.restriction.minExclusive	<ESC>
:amenu xGen.xsd.BROWSE.restriction.maxInclusive	<ESC>
:amenu xGen.xsd.BROWSE.restriction.maxExclusive	<ESC>
:amenu xGen.xsd.BROWSE.restriction.attribute	<ESC>
:amenu xGen.xsd.BROWSE.restriction.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.restriction.anyAttribute	<ESC>
:amenu xGen.xsd.BROWSE.schema.include	<ESC>
:amenu xGen.xsd.BROWSE.schema.import	<ESC>
:amenu xGen.xsd.BROWSE.schema.redefine	<ESC>
:amenu xGen.xsd.BROWSE.schema.annotation	<ESC>
:amenu xGen.xsd.BROWSE.schema.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.schema.complexType	<ESC>
:amenu xGen.xsd.BROWSE.schema.element	<ESC>
:amenu xGen.xsd.BROWSE.schema.attribute	<ESC>
:amenu xGen.xsd.BROWSE.schema.attributeGroup	<ESC>
:amenu xGen.xsd.BROWSE.schema.group	<ESC>
:amenu xGen.xsd.BROWSE.schema.notation	<ESC>
:amenu xGen.xsd.BROWSE.schema.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.selector.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.element	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.group	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.choice	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.sequence	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.sequence.any	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleContent.restriction	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleContent.extension	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleType.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleType.restriction	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleType.list	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.simpleType.union	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.totalDigits.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.union.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.union.simpleType	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.unique.selector	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.unique.annotation	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.unique.field	<ESC>
:amenu xGen.xsd.BROWSE.selector>>.whiteSpace.annotation	<ESC>
:amenu xGen.xsd.-SEPid183087- :
:amenu xGen.xsd.FILL	:.s/\/*>$/>/<CR>yyp^a/<ESC>/[ >]<CR>C><ESC>k^
:amenu xGen.xsd.>>	>>
:amenu xGen.xsd.<<	<<
:amenu xGen.xsd.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.xsd.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:amenu 800.10.1000	xGen.enable.xsl	:call Set_enable_xsl()<CR>
function! Set_disable_xsl()
:amenu 800.10.1000	xGen.enable.xsl	:call Set_enable_xsl()<CR>
:aunmenu xGen.disable.xsl
:aunmenu xGen.xsl
endfunction
function! Set_enable_xsl()
:amenu 800.20.1000	xGen.disable.xsl	:call Set_disable_xsl()<CR>
:aunmenu xGen.enable.xsl
:amenu 800.1000.1	xGen.xsl.TEMPLATES.call-template	o<xsl:call-template name="required"/><ESC>XA<ESC>o<xsl:with-param name="required" select=""/><ESC>>>^o<xsl:sort select=""/><ESC>o</xsl:call-template><ESC><<^
:amenu xGen.xsl.TEMPLATES.choose	o<xsl:choose/><ESC>XA<ESC>o<xsl:when test=""/><ESC>XA<ESC>>>^o</xsl:when><ESC>o<xsl:otherwise/><ESC>XA<ESC>o</xsl:otherwise><ESC>o</xsl:choose><ESC><<^
:amenu xGen.xsl.TEMPLATES.template	o<xsl:template name="theElementMode" match="*" mode="mode"/><ESC>XA<ESC>o<xsl:param name="required" select=""/><ESC>>>^o</xsl:template><ESC><<^
:amenu xGen.xsl.TEMPLATES.transform	o<?xml version="1.0" encoding="iso-8859-1" ?><ESC>o<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"/><ESC>XA<ESC>o<xsl:import href="required"/><ESC>>>^o<xsl:include href="required"/><ESC>o<xsl:output encoding="iso-8859-1" method="xml" standalone="yes" /><ESC>o<xsl:param name="required" select=""/><ESC>o</xsl:transform><ESC><<^
:amenu xGen.xsl.MIN.apply-imports	o<xsl:apply-imports <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.apply-templates	o<xsl:apply-templates <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.attribute	o<xsl:attribute name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.attribute-set	o<xsl:attribute-set name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.call-template	o<xsl:call-template name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.choose	o<xsl:choose <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.comment	o<xsl:comment <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.copy	o<xsl:copy <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.copy-of	o<xsl:copy-of select="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.decimal-format	o<xsl:decimal-format <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.element	o<xsl:element name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.fallback	o<xsl:fallback <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.for-each	o<xsl:for-each select="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.if	o<xsl:if test="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.import	o<xsl:import href="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.include	o<xsl:include href="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.key	o<xsl:key match="required" name="required" use="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.message	o<xsl:message <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.namespace-alias	o<xsl:namespace-alias result-prefix="required" stylesheet-prefix="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.number	o<xsl:number <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.otherwise	o<xsl:otherwise <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.output	o<xsl:output <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.param	o<xsl:param name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.preserve-space	o<xsl:preserve-space elements="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.processing-instruction	o<xsl:processing-instruction name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.sort	o<xsl:sort <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.strip-space	o<xsl:strip-space elements="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.stylesheet	o<xsl:stylesheet version="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.template	o<xsl:template <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.text	o<xsl:text <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.transform	o<xsl:transform version="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.value-of	o<xsl:value-of select="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.variable	o<xsl:variable name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.when	o<xsl:when test="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MIN.with-param	o<xsl:with-param name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.apply-imports	o<xsl:apply-imports <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.apply-templates	o<xsl:apply-templates mode="" select="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.attribute	o<xsl:attribute name="required" namespace="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.attribute-set	o<xsl:attribute-set name="required" use-attribute-sets="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.call-template	o<xsl:call-template name="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.choose	o<xsl:choose xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.comment	o<xsl:comment xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.copy	o<xsl:copy use-attribute-sets="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.copy-of	o<xsl:copy-of select="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.decimal-format	o<xsl:decimal-format NaN="" decimal-separator="" digit="" grouping-separator="" infinity="" minus-sign="" name="" pattern-separator="" per-mille="" percent="" zero-digit="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.element	o<xsl:element name="required" namespace="" use-attribute-sets="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.fallback	o<xsl:fallback xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.for-each	o<xsl:for-each select="required" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.if	o<xsl:if test="required" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.import	o<xsl:import href="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.include	o<xsl:include href="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.key	o<xsl:key match="required" name="required" use="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.message	o<xsl:message terminate="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.namespace-alias	o<xsl:namespace-alias result-prefix="required" stylesheet-prefix="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.number	o<xsl:number count="" format="" from="" grouping-separator="" grouping-size="" lang="" letter-value="" level="" value="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.otherwise	o<xsl:otherwise xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.output	o<xsl:output cdata-section-elements="" doctype-public="" doctype-system="" encoding="" indent="" media-type="" method="" omit-xml-declaration="" standalone="" version="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.param	o<xsl:param name="required" select="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.preserve-space	o<xsl:preserve-space elements="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.processing-instruction	o<xsl:processing-instruction name="required" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.sort	o<xsl:sort case-order="" data-type="" lang="" order="" select="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.strip-space	o<xsl:strip-space elements="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.stylesheet	o<xsl:stylesheet exclude-result-prefixes="" extension-element-prefixes="" id="" version="required" xml:space="" xmlns:xsl="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.template	o<xsl:template match="" mode="" name="" priority="" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.text	o<xsl:text disable-output-escaping="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.transform	o<xsl:transform exclude-result-prefixes="" extension-element-prefixes="" id="" version="required" xml:space="" xmlns:xsl="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.value-of	o<xsl:value-of disable-output-escaping="" select="required" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.variable	o<xsl:variable name="required" select="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.when	o<xsl:when test="required" xml:space="" <ESC>xa/><ESC>^
:amenu xGen.xsl.MAX.with-param	o<xsl:with-param name="required" select="" <ESC>xa/><ESC>^
:amenu xGen.xsl.-SEPid180977- :
:amenu xGen.xsl.ROOTS.stylesheet	O<?xml version="1.0" encoding="ISO-8859-1"?><ESC>o<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="" extension-element-prefixes="" id="" version="required" xml:space="" xmlns:xsl="" <ESC>xa/><ESC>^
:amenu xGen.xsl.ROOTS.transform	O<?xml version="1.0" encoding="ISO-8859-1"?><ESC>o<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="" extension-element-prefixes="" id="" version="required" xml:space="" xmlns:xsl="" <ESC>xa/><ESC>^
:amenu xGen.xsl.BROWSE.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.apply-templates.sort	<ESC>
:amenu xGen.xsl.BROWSE.apply-templates.with-param	<ESC>
:amenu xGen.xsl.BROWSE.attribute.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.attribute.call-template	<ESC>
:amenu xGen.xsl.BROWSE.attribute.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.attribute.for-each	<ESC>
:amenu xGen.xsl.BROWSE.attribute.value-of	<ESC>
:amenu xGen.xsl.BROWSE.attribute.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.attribute.number	<ESC>
:amenu xGen.xsl.BROWSE.attribute.choose	<ESC>
:amenu xGen.xsl.BROWSE.attribute.if	<ESC>
:amenu xGen.xsl.BROWSE.attribute.text	<ESC>
:amenu xGen.xsl.BROWSE.attribute.copy	<ESC>
:amenu xGen.xsl.BROWSE.attribute.variable	<ESC>
:amenu xGen.xsl.BROWSE.attribute.message	<ESC>
:amenu xGen.xsl.BROWSE.attribute.fallback	<ESC>
:amenu xGen.xsl.BROWSE.attribute-set.attribute	<ESC>
:amenu xGen.xsl.BROWSE.call-template.with-param	<ESC>
:amenu xGen.xsl.BROWSE.choose.when	<ESC>
:amenu xGen.xsl.BROWSE.choose.otherwise	<ESC>
:amenu xGen.xsl.BROWSE.comment.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.comment.call-template	<ESC>
:amenu xGen.xsl.BROWSE.comment.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.comment.for-each	<ESC>
:amenu xGen.xsl.BROWSE.comment.value-of	<ESC>
:amenu xGen.xsl.BROWSE.comment.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.comment.number	<ESC>
:amenu xGen.xsl.BROWSE.comment.choose	<ESC>
:amenu xGen.xsl.BROWSE.comment.if	<ESC>
:amenu xGen.xsl.BROWSE.comment.text	<ESC>
:amenu xGen.xsl.BROWSE.comment.copy	<ESC>
:amenu xGen.xsl.BROWSE.comment.variable	<ESC>
:amenu xGen.xsl.BROWSE.comment.message	<ESC>
:amenu xGen.xsl.BROWSE.comment.fallback	<ESC>
:amenu xGen.xsl.BROWSE.copy.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.copy.call-template	<ESC>
:amenu xGen.xsl.BROWSE.copy.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.copy.for-each	<ESC>
:amenu xGen.xsl.BROWSE.copy.value-of	<ESC>
:amenu xGen.xsl.BROWSE.copy.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.copy.number	<ESC>
:amenu xGen.xsl.BROWSE.copy.choose	<ESC>
:amenu xGen.xsl.BROWSE.copy.if	<ESC>
:amenu xGen.xsl.BROWSE.copy.text	<ESC>
:amenu xGen.xsl.BROWSE.copy.copy	<ESC>
:amenu xGen.xsl.BROWSE.copy.variable	<ESC>
:amenu xGen.xsl.BROWSE.copy.message	<ESC>
:amenu xGen.xsl.BROWSE.copy.fallback	<ESC>
:amenu xGen.xsl.BROWSE.copy.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.copy.comment	<ESC>
:amenu xGen.xsl.BROWSE.copy.element	<ESC>
:amenu xGen.xsl.BROWSE.copy.attribute	<ESC>
:amenu xGen.xsl.BROWSE.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.decimal-format	<ESC>
:amenu xGen.xsl.BROWSE.element.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.element.call-template	<ESC>
:amenu xGen.xsl.BROWSE.element.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.element.for-each	<ESC>
:amenu xGen.xsl.BROWSE.element.value-of	<ESC>
:amenu xGen.xsl.BROWSE.element.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.element.number	<ESC>
:amenu xGen.xsl.BROWSE.element.choose	<ESC>
:amenu xGen.xsl.BROWSE.element.if	<ESC>
:amenu xGen.xsl.BROWSE.element.text	<ESC>
:amenu xGen.xsl.BROWSE.element.copy	<ESC>
:amenu xGen.xsl.BROWSE.element.variable	<ESC>
:amenu xGen.xsl.BROWSE.element.message	<ESC>
:amenu xGen.xsl.BROWSE.element.fallback	<ESC>
:amenu xGen.xsl.BROWSE.element.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.element.comment	<ESC>
:amenu xGen.xsl.BROWSE.element.element	<ESC>
:amenu xGen.xsl.BROWSE.element.attribute	<ESC>
:amenu xGen.xsl.BROWSE.fallback.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.fallback.call-template	<ESC>
:amenu xGen.xsl.BROWSE.fallback.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.fallback.for-each	<ESC>
:amenu xGen.xsl.BROWSE.fallback.value-of	<ESC>
:amenu xGen.xsl.BROWSE.fallback.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.fallback.number	<ESC>
:amenu xGen.xsl.BROWSE.fallback.choose	<ESC>
:amenu xGen.xsl.BROWSE.fallback.if	<ESC>
:amenu xGen.xsl.BROWSE.fallback.text	<ESC>
:amenu xGen.xsl.BROWSE.fallback.copy	<ESC>
:amenu xGen.xsl.BROWSE.fallback.variable	<ESC>
:amenu xGen.xsl.BROWSE.fallback.message	<ESC>
:amenu xGen.xsl.BROWSE.fallback.fallback	<ESC>
:amenu xGen.xsl.BROWSE.fallback.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.fallback.comment	<ESC>
:amenu xGen.xsl.BROWSE.fallback.element	<ESC>
:amenu xGen.xsl.BROWSE.fallback.attribute	<ESC>
:amenu xGen.xsl.BROWSE.for-each.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.for-each.call-template	<ESC>
:amenu xGen.xsl.BROWSE.for-each.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.for-each.for-each	<ESC>
:amenu xGen.xsl.BROWSE.for-each.value-of	<ESC>
:amenu xGen.xsl.BROWSE.for-each.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.for-each.number	<ESC>
:amenu xGen.xsl.BROWSE.for-each.choose	<ESC>
:amenu xGen.xsl.BROWSE.for-each.if	<ESC>
:amenu xGen.xsl.BROWSE.for-each.text	<ESC>
:amenu xGen.xsl.BROWSE.for-each.copy	<ESC>
:amenu xGen.xsl.BROWSE.for-each.variable	<ESC>
:amenu xGen.xsl.BROWSE.for-each.message	<ESC>
:amenu xGen.xsl.BROWSE.for-each.fallback	<ESC>
:amenu xGen.xsl.BROWSE.for-each.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.for-each.comment	<ESC>
:amenu xGen.xsl.BROWSE.for-each.element	<ESC>
:amenu xGen.xsl.BROWSE.for-each.attribute	<ESC>
:amenu xGen.xsl.BROWSE.for-each.sort	<ESC>
:amenu xGen.xsl.BROWSE.if.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.if.call-template	<ESC>
:amenu xGen.xsl.BROWSE.if.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.if.for-each	<ESC>
:amenu xGen.xsl.BROWSE.if.value-of	<ESC>
:amenu xGen.xsl.BROWSE.if.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.if.number	<ESC>
:amenu xGen.xsl.BROWSE.if.choose	<ESC>
:amenu xGen.xsl.BROWSE.if.if	<ESC>
:amenu xGen.xsl.BROWSE.if.text	<ESC>
:amenu xGen.xsl.BROWSE.if.copy	<ESC>
:amenu xGen.xsl.BROWSE.if.variable	<ESC>
:amenu xGen.xsl.BROWSE.if.message	<ESC>
:amenu xGen.xsl.BROWSE.if.fallback	<ESC>
:amenu xGen.xsl.BROWSE.if.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.if.comment	<ESC>
:amenu xGen.xsl.BROWSE.if.element	<ESC>
:amenu xGen.xsl.BROWSE.if.attribute	<ESC>
:amenu xGen.xsl.BROWSE.import	<ESC>
:amenu xGen.xsl.BROWSE.include	<ESC>
:amenu xGen.xsl.BROWSE.key	<ESC>
:amenu xGen.xsl.BROWSE.message.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.message.call-template	<ESC>
:amenu xGen.xsl.BROWSE.message.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.message.for-each	<ESC>
:amenu xGen.xsl.BROWSE.message.value-of	<ESC>
:amenu xGen.xsl.BROWSE.message.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.message.number	<ESC>
:amenu xGen.xsl.BROWSE.message.choose	<ESC>
:amenu xGen.xsl.BROWSE.message.if	<ESC>
:amenu xGen.xsl.BROWSE.message.text	<ESC>
:amenu xGen.xsl.BROWSE.message.copy	<ESC>
:amenu xGen.xsl.BROWSE.message.variable	<ESC>
:amenu xGen.xsl.BROWSE.message.message	<ESC>
:amenu xGen.xsl.BROWSE.message.fallback	<ESC>
:amenu xGen.xsl.BROWSE.message.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.message.comment	<ESC>
:amenu xGen.xsl.BROWSE.message.element	<ESC>
:amenu xGen.xsl.BROWSE.message.attribute	<ESC>
:amenu xGen.xsl.BROWSE.namespace-alias	<ESC>
:amenu xGen.xsl.BROWSE.number	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.call-template	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.for-each	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.value-of	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.number	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.choose	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.if	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.text	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.copy	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.variable	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.message	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.fallback	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.comment	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.element	<ESC>
:amenu xGen.xsl.BROWSE.otherwise.attribute	<ESC>
:amenu xGen.xsl.BROWSE.output	<ESC>
:amenu xGen.xsl.BROWSE.param.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.param.call-template	<ESC>
:amenu xGen.xsl.BROWSE.param.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.param.for-each	<ESC>
:amenu xGen.xsl.BROWSE.param.value-of	<ESC>
:amenu xGen.xsl.BROWSE.param.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.param.number	<ESC>
:amenu xGen.xsl.BROWSE.param.choose	<ESC>
:amenu xGen.xsl.BROWSE.param.if	<ESC>
:amenu xGen.xsl.BROWSE.param.text	<ESC>
:amenu xGen.xsl.BROWSE.param.copy	<ESC>
:amenu xGen.xsl.BROWSE.param.variable	<ESC>
:amenu xGen.xsl.BROWSE.param.message	<ESC>
:amenu xGen.xsl.BROWSE.param.fallback	<ESC>
:amenu xGen.xsl.BROWSE.param.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.param.comment	<ESC>
:amenu xGen.xsl.BROWSE.param.element	<ESC>
:amenu xGen.xsl.BROWSE.param.attribute	<ESC>
:amenu xGen.xsl.BROWSE.preserve-space	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.call-template	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.for-each	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.value-of	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.number	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.choose	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.if	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.text	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.copy	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.variable	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.message	<ESC>
:amenu xGen.xsl.BROWSE.processing-instruction.fallback	<ESC>
:amenu xGen.xsl.BROWSE.sort	<ESC>
:amenu xGen.xsl.BROWSE.strip-space	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.import	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.include	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.strip-space	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.preserve-space	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.output	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.key	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.decimal-format	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.attribute-set	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.variable	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.param	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.template	<ESC>
:amenu xGen.xsl.BROWSE.stylesheet.namespace-alias	<ESC>
:amenu xGen.xsl.BROWSE.template.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.template.call-template	<ESC>
:amenu xGen.xsl.BROWSE.template.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.template.for-each	<ESC>
:amenu xGen.xsl.BROWSE.template.value-of	<ESC>
:amenu xGen.xsl.BROWSE.template.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.template.number	<ESC>
:amenu xGen.xsl.BROWSE.template.choose	<ESC>
:amenu xGen.xsl.BROWSE.template.if	<ESC>
:amenu xGen.xsl.BROWSE.template.text	<ESC>
:amenu xGen.xsl.BROWSE.template.copy	<ESC>
:amenu xGen.xsl.BROWSE.template.variable	<ESC>
:amenu xGen.xsl.BROWSE.template.message	<ESC>
:amenu xGen.xsl.BROWSE.template.fallback	<ESC>
:amenu xGen.xsl.BROWSE.template.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.template.comment	<ESC>
:amenu xGen.xsl.BROWSE.template.element	<ESC>
:amenu xGen.xsl.BROWSE.template.attribute	<ESC>
:amenu xGen.xsl.BROWSE.template.param	<ESC>
:amenu xGen.xsl.BROWSE.text	<ESC>
:amenu xGen.xsl.BROWSE.transform.import	<ESC>
:amenu xGen.xsl.BROWSE.transform.include	<ESC>
:amenu xGen.xsl.BROWSE.transform.strip-space	<ESC>
:amenu xGen.xsl.BROWSE.transform.preserve-space	<ESC>
:amenu xGen.xsl.BROWSE.transform.output	<ESC>
:amenu xGen.xsl.BROWSE.transform.key	<ESC>
:amenu xGen.xsl.BROWSE.transform.decimal-format	<ESC>
:amenu xGen.xsl.BROWSE.transform.attribute-set	<ESC>
:amenu xGen.xsl.BROWSE.transform.variable	<ESC>
:amenu xGen.xsl.BROWSE.transform.param	<ESC>
:amenu xGen.xsl.BROWSE.transform.template	<ESC>
:amenu xGen.xsl.BROWSE.transform.namespace-alias	<ESC>
:amenu xGen.xsl.BROWSE.value-of	<ESC>
:amenu xGen.xsl.BROWSE.variable.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.variable.call-template	<ESC>
:amenu xGen.xsl.BROWSE.variable.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.variable.for-each	<ESC>
:amenu xGen.xsl.BROWSE.variable.value-of	<ESC>
:amenu xGen.xsl.BROWSE.variable.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.variable.number	<ESC>
:amenu xGen.xsl.BROWSE.variable.choose	<ESC>
:amenu xGen.xsl.BROWSE.variable.if	<ESC>
:amenu xGen.xsl.BROWSE.variable.text	<ESC>
:amenu xGen.xsl.BROWSE.variable.copy	<ESC>
:amenu xGen.xsl.BROWSE.variable.variable	<ESC>
:amenu xGen.xsl.BROWSE.variable.message	<ESC>
:amenu xGen.xsl.BROWSE.variable.fallback	<ESC>
:amenu xGen.xsl.BROWSE.variable.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.variable.comment	<ESC>
:amenu xGen.xsl.BROWSE.variable.element	<ESC>
:amenu xGen.xsl.BROWSE.variable.attribute	<ESC>
:amenu xGen.xsl.BROWSE.when.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.when.call-template	<ESC>
:amenu xGen.xsl.BROWSE.when.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.when.for-each	<ESC>
:amenu xGen.xsl.BROWSE.when.value-of	<ESC>
:amenu xGen.xsl.BROWSE.when.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.when.number	<ESC>
:amenu xGen.xsl.BROWSE.when.choose	<ESC>
:amenu xGen.xsl.BROWSE.when.if	<ESC>
:amenu xGen.xsl.BROWSE.when.text	<ESC>
:amenu xGen.xsl.BROWSE.when.copy	<ESC>
:amenu xGen.xsl.BROWSE.when.variable	<ESC>
:amenu xGen.xsl.BROWSE.when.message	<ESC>
:amenu xGen.xsl.BROWSE.when.fallback	<ESC>
:amenu xGen.xsl.BROWSE.when.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.when.comment	<ESC>
:amenu xGen.xsl.BROWSE.when.element	<ESC>
:amenu xGen.xsl.BROWSE.when.attribute	<ESC>
:amenu xGen.xsl.BROWSE.with-param.apply-templates	<ESC>
:amenu xGen.xsl.BROWSE.with-param.call-template	<ESC>
:amenu xGen.xsl.BROWSE.with-param.apply-imports	<ESC>
:amenu xGen.xsl.BROWSE.with-param.for-each	<ESC>
:amenu xGen.xsl.BROWSE.with-param.value-of	<ESC>
:amenu xGen.xsl.BROWSE.with-param.copy-of	<ESC>
:amenu xGen.xsl.BROWSE.with-param.number	<ESC>
:amenu xGen.xsl.BROWSE.with-param.choose	<ESC>
:amenu xGen.xsl.BROWSE.with-param.if	<ESC>
:amenu xGen.xsl.BROWSE.with-param.text	<ESC>
:amenu xGen.xsl.BROWSE.with-param.copy	<ESC>
:amenu xGen.xsl.BROWSE.with-param.variable	<ESC>
:amenu xGen.xsl.BROWSE.with-param.message	<ESC>
:amenu xGen.xsl.BROWSE.with-param.fallback	<ESC>
:amenu xGen.xsl.BROWSE.with-param.processing-instruction	<ESC>
:amenu xGen.xsl.BROWSE.with-param.comment	<ESC>
:amenu xGen.xsl.BROWSE.with-param.element	<ESC>
:amenu xGen.xsl.BROWSE.with-param.attribute	<ESC>
:amenu xGen.xsl.-SEPid185437- :
:amenu xGen.xsl.FILL	:.s/\/*>$/>/<CR>yyp^a/<ESC>/[ >]<CR>C><ESC>k^
:amenu xGen.xsl.>>	>>
:amenu xGen.xsl.<<	<<
:amenu xGen.xsl.AUTOINDENT.ON	:set autoindent<ESC>^
:amenu xGen.xsl.AUTOINDENT.OFF	:set noautoindent<ESC>^
endfunction
:call Set_enable()
