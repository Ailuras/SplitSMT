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

(declare-sort var3502 0)
(declare-sort var3895 0)
(declare-sort var846 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/760448707 (var3502 (Array Int String) var846 Bool) void)
(declare-const null-var3502 var3502)
(declare-const null-String String)
(declare-const null-var846 var846)
(declare-const null-Bool Bool)
(declare-const var1036 var3502) ; Statement: r0 := @this: edu.stanford.nlp.wordseg.ChineseDictionary 
(assert (not (= var1036 null-var3502)))
(declare-const var2741 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2741 null-String)))
(declare-const var1975 var846) ; Statement: r2 := @parameter1: edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor 
(assert (not (= var1975 null-var846)))
(declare-const var2000 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2000 null-Bool)))
; split operation: var2820 = var2741.split(",") ; Statement: $r3 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert true)
;(assert (<init>/760448707 var1036 var2820 var1975 var2000)) ; Statement: specialinvoke r0.<edu.stanford.nlp.wordseg.ChineseDictionary: void <init>(java.lang.String[],edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor,boolean)>($r3, r2, z0) 

(declare-const var1036!1 var3502)
(declare-const var2820!1 (Array Int String))
(declare-const var1975!1 var846)
(declare-const var2000!1 Bool)
 ; Statement: return 
(check-sat)
; {<init>/760448707=([edu.stanford.nlp.wordseg.ChineseDictionary, java.lang.String[], edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor, boolean], void)}
; {var3502=edu.stanford.nlp.wordseg.ChineseDictionary, var1036=r0, var2741=r1, var3895=null_type, var846=edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor, var1975=r2, var2000=z0, var2820=$r3}
; {edu.stanford.nlp.wordseg.ChineseDictionary=var3502, r0=var1036, r1=var2741, null_type=var3895, edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor=var846, r2=var1975, z0=var2000, $r3=var2820}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.wordseg.ChineseDictionary;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor;	z0 := @parameter2: boolean;	$r3 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	specialinvoke r0.<edu.stanford.nlp.wordseg.ChineseDictionary: void <init>(java.lang.String[],edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor,boolean)>($r3, r2, z0);	return
;block_num 1