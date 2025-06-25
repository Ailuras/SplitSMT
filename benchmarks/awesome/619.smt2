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

(declare-sort var176 0)
(declare-sort var1179 0)
(declare-sort var2207 0)
(declare-sort var1090 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun segmentString/-855932877 (var176 String) String)
(declare-fun var1090_toWordList/-1296196856 ((Array Int String)) var2207)
(declare-const null-var176 var176)
(declare-const null-String String)
(declare-const var720 var176) ; Statement: r0 := @this: edu.stanford.nlp.international.arabic.process.ArabicSegmenter 
(assert (not (= var720 null-var176)))
(declare-const var3143 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3143 null-String)))
(assert true)
(define-const var986 String (segmentString/-855932877 var720 var3143)) ; Statement: r2 = virtualinvoke r0.<edu.stanford.nlp.international.arabic.process.ArabicSegmenter: java.lang.String segmentString(java.lang.String)>(r1) 
; split operation: var1144 = var986.split("\u005cs+") ; Statement: $r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var88 var2207 (var1090_toWordList/-1296196856 var1144)) ; Statement: $r4 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toWordList(java.lang.String[])>($r3) 
 ; Statement: return $r4 
(check-sat)
; {segmentString/-855932877=([edu.stanford.nlp.international.arabic.process.ArabicSegmenter, java.lang.String], java.lang.String), var1090_toWordList/-1296196856=([java.lang.String[]], java.util.List)}
; {var176=edu.stanford.nlp.international.arabic.process.ArabicSegmenter, var720=r0, var3143=r1, var1179=null_type, var986=r2, var1144=$r3, var2207=java.util.List, var1090=edu.stanford.nlp.ling.SentenceUtils, var88=$r4}
; {edu.stanford.nlp.international.arabic.process.ArabicSegmenter=var176, r0=var720, r1=var3143, null_type=var1179, r2=var986, $r3=var1144, java.util.List=var2207, edu.stanford.nlp.ling.SentenceUtils=var1090, $r4=var88}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.international.arabic.process.ArabicSegmenter;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<edu.stanford.nlp.international.arabic.process.ArabicSegmenter: java.lang.String segmentString(java.lang.String)>(r1);	$r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r4 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toWordList(java.lang.String[])>($r3);	return $r4
;block_num 1