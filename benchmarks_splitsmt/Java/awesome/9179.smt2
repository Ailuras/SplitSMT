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

(declare-sort var1119 0)
(declare-sort var1952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getOutput/-1207014030 (var1952) String)
(declare-fun cast-from-var1119-to-var1952 (var1119) var1952)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-const null-var1119 var1119)
(declare-const var1051 var1119) ; Statement: r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator 
(assert (not (= var1051 null-var1119)))
(assert true)
(define-const var1531 String (getOutput/-1207014030 (cast-from-var1119-to-var1952 var1051))) ; Statement: r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>() 
; split operation: var1441 = var1531.split("\u005cs+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1742 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var2524 Int (get_split_length var1531 "\u005cs+" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i2 >= $i0 goto i3 = i2 + 1 
(assert (>= var1742 var2524)) ; Cond: i2 >= $i0 
(define-const var3409 Int (+ var1742 1)) ; Statement: i3 = i2 + 1 
(define-const var2269 Int (get_split_length var1531 "\u005cs+" -1)) ; Statement: $i1 = lengthof r2 
 ; Statement: if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> 
(assert (not (>= var3409 var2269))) ; Negate: Cond: i3 >= $i1  
(define-const var3970 String (get_split_element var1531 "\u005cs+" -1 var3409)) ; Statement: $r9 = r2[i3] 
(define-const var2514 Float64 (Float64_parseDouble/1471110886 var3970)) ; Statement: $d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>($r9) 
 ; Statement: return $d0 
(check-sat)
; {getOutput/-1207014030=([edu.stanford.nlp.optimization.CmdEvaluator], java.lang.String), cast-from-var1119-to-var1952=([edu.stanford.nlp.ie.crf.CRFClassifierEvaluator], edu.stanford.nlp.optimization.CmdEvaluator), Float64_parseDouble/1471110886=([java.lang.String], double)}
; {var1119=edu.stanford.nlp.ie.crf.CRFClassifierEvaluator, var1051=r0, var1952=edu.stanford.nlp.optimization.CmdEvaluator, var1531=r1, var1441=r2, var1742=i2, var2524=$i0, var3409=i3, var2269=$i1, var3970=$r9, var2514=$d0}
; {edu.stanford.nlp.ie.crf.CRFClassifierEvaluator=var1119, r0=var1051, edu.stanford.nlp.optimization.CmdEvaluator=var1952, r1=var1531, r2=var1441, i2=var1742, $i0=var2524, i3=var3409, $i1=var2269, $r9=var3970, $d0=var2514}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator;	r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i2 = 0;	$i0 = lengthof r2;	if i2 >= $i0 goto i3 = i2 + 1;	i3 = i2 + 1;	$i1 = lengthof r2;	if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>;	$r9 = r2[i3];	$d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>($r9);	return $d0
;block_num 4
(exit)
