(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1143 0)
(declare-sort var796 0)
(declare-sort var239 0)
(declare-sort var2830 0)
(declare-sort var737 0)
(declare-sort var1500 0)
(declare-sort var1613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var239) void)
(declare-fun cast-from-var1143-to-var239 (var1143) var239)
(declare-fun var2830-init () var2830)
(declare-fun <init>/-637772335 (var2830) void)
(declare-fun docAnnotationPatterns/150585675 (var1143) var2830)
(declare-fun tokenAnnotationPatterns/150585675 (var1143) var2830)
(declare-fun quoteAuthorAttributeNames/150585675 (var1143) (Array Int String))
(declare-fun sectionAnnotationPatterns/150585675 (var1143) var2830)
(declare-fun getProperty/-469436802 (var796 String String) String)
(declare-fun getProperty/1391780669 (var796 String) String)
(declare-fun xmlTagMatcher/150585675 (var1143) var1613)
(declare-fun sentenceEndingTagMatcher/150585675 (var1143) var1613)
(declare-fun var1143_toCaseInsensitivePattern/1088968652 (String) var1613)
(declare-fun dateTagMatcher/150585675 (var1143) var1613)
(declare-fun allowFlawedXml/150585675 (var1143) Bool)
(declare-fun setSingleSentenceTagMatcher/1966934900 (var1143 String) void)
(declare-fun setDocIdTagMatcher/451104962 (var1143 String) void)
(declare-fun setDocTypeTagMatcher/-741118397 (var1143 String) void)
(declare-fun setDiscourseTags/-1827098064 (var1143 String String) void)
(declare-fun setDocAnnotationPatterns/1342500003 (var1143 String) void)
(declare-fun setTokenAnnotationPatterns/950353346 (var1143 String) void)
(declare-fun setSectionTagMatcher/-936574768 (var1143 String) void)
(declare-fun setSectionAnnotationPatterns/-1134232170 (var1143 String) void)
(declare-fun setQuoteTagMatcher/244841305 (var1143 String) void)
(declare-fun setSsplitDiscardTokensMatcher/938741622 (var1143 String) void)
(declare-const null-var1143 var1143)
(declare-const null-var796 var796)
(declare-const var737-EMPTY_STRING_ARRAY (Array Int String))
(declare-const var1143-DEFAULT_SINGLE_SENTENCE_TAGS String)
(declare-const null-String String)
(declare-const var1143-DEFAULT_TOKEN_ANNOTATIONS_PATTERNS String)
(declare-const var1143-DEFAULT_SECTION_TAGS String)
(declare-const var1143-DEFAULT_SECTION_ANNOTATIONS_PATTERNS String)
(declare-const var1143-DEFAULT_QUOTE_TAGS String)
(declare-const null-var1613 var1613)
(declare-const var2178 var1143) ; Statement: r0 := @this: edu.stanford.nlp.pipeline.CleanXmlAnnotator 
(assert (not (= var2178 null-var1143)))
(declare-const var779 var796) ; Statement: r5 := @parameter0: java.util.Properties 
(assert (not (= var779 null-var796)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1143-to-var239 var2178))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2178!1 var1143)
(define-const var3895 var2830 var2830-init) ; Statement: $r1 = new edu.stanford.nlp.util.CollectionValuedMap 
(assert true)
;(assert (<init>/-637772335 var3895)) ; Statement: specialinvoke $r1.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>() 

(declare-const var3895!1 var2830)
(declare-const var2178!2 var1143)
(assert (not (= var2178!2 null-var1143)))
(assert (= (docAnnotationPatterns/150585675 var2178!2) var3895!1)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap docAnnotationPatterns> = $r1 
(define-const var3723 var2830 var2830-init) ; Statement: $r2 = new edu.stanford.nlp.util.CollectionValuedMap 
(assert true)
;(assert (<init>/-637772335 var3723)) ; Statement: specialinvoke $r2.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>() 

(declare-const var3723!1 var2830)
(declare-const var2178!3 var1143)
(assert (not (= var2178!3 null-var1143)))
(assert (= (tokenAnnotationPatterns/150585675 var2178!3) var3723!1)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap tokenAnnotationPatterns> = $r2 
(define-const var1653 (Array Int String) var737-EMPTY_STRING_ARRAY) ; Statement: $r3 = <edu.stanford.nlp.util.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY> 
(declare-const var2178!4 var1143)
(assert (not (= var2178!4 null-var1143)))
(assert (= (quoteAuthorAttributeNames/150585675 var2178!4) var1653)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String[] quoteAuthorAttributeNames> = $r3 
(define-const var1535 var2830 var2830-init) ; Statement: $r4 = new edu.stanford.nlp.util.CollectionValuedMap 
(assert true)
;(assert (<init>/-637772335 var1535)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>() 

(declare-const var1535!1 var2830)
(declare-const var2178!5 var1143)
(assert (not (= var2178!5 null-var1143)))
(assert (= (sectionAnnotationPatterns/150585675 var2178!5) var1535!1)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap sectionAnnotationPatterns> = $r4 
(assert true)
(define-const var2578 String (getProperty/-469436802 var779 "clean.xmltags" ".*")) ; Statement: r6 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.xmltags", ".*") 
(assert true)
(define-const var3269 String (getProperty/-469436802 var779 "clean.sentenceendingtags" "")) ; Statement: r7 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sentenceendingtags", "") 
(define-const var3121 String var1143-DEFAULT_SINGLE_SENTENCE_TAGS) ; Statement: $r8 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SINGLE_SENTENCE_TAGS> 
(assert true)
(define-const var3788 String (getProperty/-469436802 var779 "clean.singlesentencetags" var3121)) ; Statement: r9 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.singlesentencetags", $r8) 
(assert true)
(define-const var3324 String (getProperty/1391780669 var779 "clean.allowflawedxml")) ; Statement: r10 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("clean.allowflawedxml") 
(define-const var761 Bool (ite (= 1 1) true false)) ; Statement: z1 = 1 
 ; Statement: if r10 == null goto $r17 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.datetags", "datetime|date") 
(assert (= var3324 null-String)) ; Cond: r10 == null 
(assert true)
(define-const var2897 String (getProperty/-469436802 var779 "clean.datetags" "datetime|date")) ; Statement: $r17 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.datetags", "datetime|date") 
(assert true)
(define-const var3172 String (getProperty/-469436802 var779 "clean.docIdtags" "docid")) ; Statement: $r18 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docIdtags", "docid") 
(assert true)
(define-const var920 String (getProperty/-469436802 var779 "clean.docTypetags" "doctype")) ; Statement: $r19 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docTypetags", "doctype") 
(assert true)
(define-const var3400 String (getProperty/-469436802 var779 "clean.turntags" "turn")) ; Statement: $r20 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.turntags", "turn") 
(assert true)
(define-const var3807 String (getProperty/-469436802 var779 "clean.speakertags" "speaker")) ; Statement: $r21 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.speakertags", "speaker") 
(assert true)
(define-const var558 String (getProperty/-469436802 var779 "clean.docAnnotations" "docID=doc[id],doctype=doc[type],docsourcetype=doctype[source]")) ; Statement: $r22 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docAnnotations", "docID=doc[id],doctype=doc[type],docsourcetype=doctype[source]") 
(define-const var2564 String var1143-DEFAULT_TOKEN_ANNOTATIONS_PATTERNS) ; Statement: $r11 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_TOKEN_ANNOTATIONS_PATTERNS> 
(assert true)
(define-const var2560 String (getProperty/-469436802 var779 "clean.tokenAnnotations" var2564)) ; Statement: $r23 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.tokenAnnotations", $r11) 
(define-const var1611 String var1143-DEFAULT_SECTION_TAGS) ; Statement: $r12 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SECTION_TAGS> 
(assert true)
(define-const var882 String (getProperty/-469436802 var779 "clean.sectiontags" var1611)) ; Statement: $r24 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sectiontags", $r12) 
(define-const var3220 String var1143-DEFAULT_SECTION_ANNOTATIONS_PATTERNS) ; Statement: $r13 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SECTION_ANNOTATIONS_PATTERNS> 
(assert true)
(define-const var23 String (getProperty/-469436802 var779 "clean.sectionAnnotations" var3220)) ; Statement: $r25 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sectionAnnotations", $r13) 
(define-const var707 String var1143-DEFAULT_QUOTE_TAGS) ; Statement: $r14 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_QUOTE_TAGS> 
(assert true)
(define-const var3774 String (getProperty/-469436802 var779 "clean.quotetags" var707)) ; Statement: $r26 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.quotetags", $r14) 
(assert true)
(define-const var1345 String (getProperty/1391780669 var779 "clean.ssplitDiscardTokens")) ; Statement: $r27 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("clean.ssplitDiscardTokens") 
(assert true)
(define-const var3483 String (getProperty/-469436802 var779 "clean.quoteauthorattributes" "")) ; Statement: $r28 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.quoteauthorattributes", "") 
 ; Statement: if r6 == null goto r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern xmlTagMatcher> = null 
(assert (= var2578 null-String)) ; Cond: r6 == null 
(declare-const var2178!6 var1143)
(assert (not (= var2178!6 null-var1143)))
(assert (= (xmlTagMatcher/150585675 var2178!6) null-var1613)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern xmlTagMatcher> = null 
(declare-const var2178!7 var1143)
(assert (not (= var2178!7 null-var1143)))
(assert (= (sentenceEndingTagMatcher/150585675 var2178!7) null-var1613)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern sentenceEndingTagMatcher> = null 
(assert true) ; Non Conditional
(define-const var105 var1613 (var1143_toCaseInsensitivePattern/1088968652 var2897)) ; Statement: $r29 = staticinvoke <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern toCaseInsensitivePattern(java.lang.String)>($r17) 
(declare-const var2178!8 var1143)
(assert (not (= var2178!8 null-var1143)))
(assert (= (dateTagMatcher/150585675 var2178!8) var105)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern dateTagMatcher> = $r29 
(declare-const var2178!9 var1143)
(assert (not (= var2178!9 null-var1143)))
(assert (= (allowFlawedXml/150585675 var2178!9) var761)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: boolean allowFlawedXml> = z1 
(assert true)
;(assert (setSingleSentenceTagMatcher/1966934900 var2178!9 var3788)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSingleSentenceTagMatcher(java.lang.String)>(r9) 

(declare-const var2178!10 var1143)
(declare-const var3788!1 String)
(assert true)
;(assert (setDocIdTagMatcher/451104962 var2178!10 var3172)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocIdTagMatcher(java.lang.String)>($r18) 

(declare-const var2178!11 var1143)
(declare-const var3172!1 String)
(assert true)
;(assert (setDocTypeTagMatcher/-741118397 var2178!11 var920)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocTypeTagMatcher(java.lang.String)>($r19) 

(declare-const var2178!12 var1143)
(declare-const var920!1 String)
(assert true)
;(assert (setDiscourseTags/-1827098064 var2178!12 var3400 var3807)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDiscourseTags(java.lang.String,java.lang.String)>($r20, $r21) 

(declare-const var2178!13 var1143)
(declare-const var3400!1 String)
(declare-const var3807!1 String)
(assert true)
;(assert (setDocAnnotationPatterns/1342500003 var2178!13 var558)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocAnnotationPatterns(java.lang.String)>($r22) 

(declare-const var2178!14 var1143)
(declare-const var558!1 String)
(assert true)
;(assert (setTokenAnnotationPatterns/950353346 var2178!14 var2560)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setTokenAnnotationPatterns(java.lang.String)>($r23) 

(declare-const var2178!15 var1143)
(declare-const var2560!1 String)
(assert true)
;(assert (setSectionTagMatcher/-936574768 var2178!15 var882)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSectionTagMatcher(java.lang.String)>($r24) 

(declare-const var2178!16 var1143)
(declare-const var882!1 String)
(assert true)
;(assert (setSectionAnnotationPatterns/-1134232170 var2178!16 var23)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSectionAnnotationPatterns(java.lang.String)>($r25) 

(declare-const var2178!17 var1143)
(declare-const var23!1 String)
(assert true)
;(assert (setQuoteTagMatcher/244841305 var2178!17 var3774)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setQuoteTagMatcher(java.lang.String)>($r26) 

(declare-const var2178!18 var1143)
(declare-const var3774!1 String)
(assert true)
;(assert (setSsplitDiscardTokensMatcher/938741622 var2178!18 var1345)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSsplitDiscardTokensMatcher(java.lang.String)>($r27) 

(declare-const var2178!19 var1143)
(declare-const var1345!1 String)
; split operation: var2233 = var3483.split(",") ; Statement: $r30 = virtualinvoke $r28.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(declare-const var2178!20 var1143)
(assert (not (= var2178!20 null-var1143)))
(assert (= (quoteAuthorAttributeNames/150585675 var2178!20) var2233)) ; Statement: r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String[] quoteAuthorAttributeNames> = $r30 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1143-to-var239=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], java.lang.Object), var2830-init=([], edu.stanford.nlp.util.CollectionValuedMap), <init>/-637772335=([edu.stanford.nlp.util.CollectionValuedMap], void), docAnnotationPatterns/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], edu.stanford.nlp.util.CollectionValuedMap), tokenAnnotationPatterns/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], edu.stanford.nlp.util.CollectionValuedMap), quoteAuthorAttributeNames/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], java.lang.String[]), sectionAnnotationPatterns/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], edu.stanford.nlp.util.CollectionValuedMap), getProperty/-469436802=([java.util.Properties, java.lang.String, java.lang.String], java.lang.String), getProperty/1391780669=([java.util.Properties, java.lang.String], java.lang.String), xmlTagMatcher/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], java.util.regex.Pattern), sentenceEndingTagMatcher/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], java.util.regex.Pattern), var1143_toCaseInsensitivePattern/1088968652=([java.lang.String], java.util.regex.Pattern), dateTagMatcher/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], java.util.regex.Pattern), allowFlawedXml/150585675=([edu.stanford.nlp.pipeline.CleanXmlAnnotator], boolean), setSingleSentenceTagMatcher/1966934900=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setDocIdTagMatcher/451104962=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setDocTypeTagMatcher/-741118397=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setDiscourseTags/-1827098064=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String, java.lang.String], void), setDocAnnotationPatterns/1342500003=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setTokenAnnotationPatterns/950353346=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setSectionTagMatcher/-936574768=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setSectionAnnotationPatterns/-1134232170=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setQuoteTagMatcher/244841305=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void), setSsplitDiscardTokensMatcher/938741622=([edu.stanford.nlp.pipeline.CleanXmlAnnotator, java.lang.String], void)}
; {var1143=edu.stanford.nlp.pipeline.CleanXmlAnnotator, var2178=r0, var796=java.util.Properties, var779=r5, var239=java.lang.Object, var2830=edu.stanford.nlp.util.CollectionValuedMap, var3895=$r1, var3723=$r2, var737=edu.stanford.nlp.util.StringUtils, var1653=$r3, var1535=$r4, var2578=r6, var3269=r7, var3121=$r8, var3788=r9, var3324=r10, var761=z1, var1500=null_type, var2897=$r17, var3172=$r18, var920=$r19, var3400=$r20, var3807=$r21, var558=$r22, var2564=$r11, var2560=$r23, var1611=$r12, var882=$r24, var3220=$r13, var23=$r25, var707=$r14, var3774=$r26, var1345=$r27, var3483=$r28, var1613=java.util.regex.Pattern, var105=$r29, var2233=$r30}
; {edu.stanford.nlp.pipeline.CleanXmlAnnotator=var1143, r0=var2178, java.util.Properties=var796, r5=var779, java.lang.Object=var239, edu.stanford.nlp.util.CollectionValuedMap=var2830, $r1=var3895, $r2=var3723, edu.stanford.nlp.util.StringUtils=var737, $r3=var1653, $r4=var1535, r6=var2578, r7=var3269, $r8=var3121, r9=var3788, r10=var3324, z1=var761, null_type=var1500, $r17=var2897, $r18=var3172, $r19=var920, $r20=var3400, $r21=var3807, $r22=var558, $r11=var2564, $r23=var2560, $r12=var1611, $r24=var882, $r13=var3220, $r25=var23, $r14=var707, $r26=var3774, $r27=var1345, $r28=var3483, java.util.regex.Pattern=var1613, $r29=var105, $r30=var2233}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.pipeline.CleanXmlAnnotator;	r5 := @parameter0: java.util.Properties;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new edu.stanford.nlp.util.CollectionValuedMap;	specialinvoke $r1.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>();	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap docAnnotationPatterns> = $r1;	$r2 = new edu.stanford.nlp.util.CollectionValuedMap;	specialinvoke $r2.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>();	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap tokenAnnotationPatterns> = $r2;	$r3 = <edu.stanford.nlp.util.StringUtils: java.lang.String[] EMPTY_STRING_ARRAY>;	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String[] quoteAuthorAttributeNames> = $r3;	$r4 = new edu.stanford.nlp.util.CollectionValuedMap;	specialinvoke $r4.<edu.stanford.nlp.util.CollectionValuedMap: void <init>()>();	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: edu.stanford.nlp.util.CollectionValuedMap sectionAnnotationPatterns> = $r4;	r6 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.xmltags", ".*");	r7 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sentenceendingtags", "");	$r8 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SINGLE_SENTENCE_TAGS>;	r9 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.singlesentencetags", $r8);	r10 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("clean.allowflawedxml");	z1 = 1;	if r10 == null goto $r17 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.datetags", "datetime|date");	$r17 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.datetags", "datetime|date");	$r18 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docIdtags", "docid");	$r19 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docTypetags", "doctype");	$r20 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.turntags", "turn");	$r21 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.speakertags", "speaker");	$r22 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.docAnnotations", "docID=doc[id],doctype=doc[type],docsourcetype=doctype[source]");	$r11 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_TOKEN_ANNOTATIONS_PATTERNS>;	$r23 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.tokenAnnotations", $r11);	$r12 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SECTION_TAGS>;	$r24 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sectiontags", $r12);	$r13 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_SECTION_ANNOTATIONS_PATTERNS>;	$r25 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.sectionAnnotations", $r13);	$r14 = <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String DEFAULT_QUOTE_TAGS>;	$r26 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.quotetags", $r14);	$r27 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("clean.ssplitDiscardTokens");	$r28 = virtualinvoke r5.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("clean.quoteauthorattributes", "");	if r6 == null goto r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern xmlTagMatcher> = null;	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern xmlTagMatcher> = null;	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern sentenceEndingTagMatcher> = null;	$r29 = staticinvoke <edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern toCaseInsensitivePattern(java.lang.String)>($r17);	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.util.regex.Pattern dateTagMatcher> = $r29;	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: boolean allowFlawedXml> = z1;	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSingleSentenceTagMatcher(java.lang.String)>(r9);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocIdTagMatcher(java.lang.String)>($r18);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocTypeTagMatcher(java.lang.String)>($r19);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDiscourseTags(java.lang.String,java.lang.String)>($r20, $r21);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setDocAnnotationPatterns(java.lang.String)>($r22);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setTokenAnnotationPatterns(java.lang.String)>($r23);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSectionTagMatcher(java.lang.String)>($r24);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSectionAnnotationPatterns(java.lang.String)>($r25);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setQuoteTagMatcher(java.lang.String)>($r26);	virtualinvoke r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: void setSsplitDiscardTokensMatcher(java.lang.String)>($r27);	$r30 = virtualinvoke $r28.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	r0.<edu.stanford.nlp.pipeline.CleanXmlAnnotator: java.lang.String[] quoteAuthorAttributeNames> = $r30;	return
;block_num 4