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

(declare-sort var73 0)
(declare-sort var2881 0)
(declare-sort var2683 0)
(declare-sort var1434 0)
(declare-sort var3202 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1434_toCoreLabelList/1371704325 ((Array Int String)) var2683)
(declare-fun var3202_StringToIOB/-1125840573 (var2683 var2881 Bool) var2683)
(declare-const null-String String)
(declare-const null-var2881 var2881)
(declare-const var2101 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2101 null-String)))
(declare-const var2648 var2881) ; Statement: r4 := @parameter1: java.lang.Character 
(assert (not (= var2648 null-var2881)))
(assert true)
(define-const var660 String (trim/-847153721 var2101)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
; split operation: var1473 = var660.split("\u005cs+") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1889 var2683 (var1434_toCoreLabelList/1371704325 var1473)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toCoreLabelList(java.lang.String[])>($r2) 
(define-const var3256 var2683 (var3202_StringToIOB/-1125840573 var1889 var2648 (ite (= 1 0) true false))) ; Statement: $r5 = staticinvoke <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.List StringToIOB(java.util.List,java.lang.Character,boolean)>(r3, r4, 0) 
 ; Statement: return $r5 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), var1434_toCoreLabelList/1371704325=([java.lang.String[]], java.util.List), var3202_StringToIOB/-1125840573=([java.util.List, java.lang.Character, boolean], java.util.List)}
; {var2101=r0, var73=null_type, var2881=java.lang.Character, var2648=r4, var660=$r1, var1473=$r2, var2683=java.util.List, var1434=edu.stanford.nlp.ling.SentenceUtils, var1889=r3, var3202=edu.stanford.nlp.international.arabic.process.IOBUtils, var3256=$r5}
; {r0=var2101, null_type=var73, java.lang.Character=var2881, r4=var2648, $r1=var660, $r2=var1473, java.util.List=var2683, edu.stanford.nlp.ling.SentenceUtils=var1434, r3=var1889, edu.stanford.nlp.international.arabic.process.IOBUtils=var3202, $r5=var3256}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r4 := @parameter1: java.lang.Character;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	r3 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toCoreLabelList(java.lang.String[])>($r2);	$r5 = staticinvoke <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.List StringToIOB(java.util.List,java.lang.Character,boolean)>(r3, r4, 0);	return $r5
;block_num 1