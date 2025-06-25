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

(declare-sort var431 0)
(declare-sort var1178 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1178_renderCodes/830694732 ((Array Int String)) String)
(declare-const null-String String)
(declare-const var450 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var450 null-String)))
; split operation: var538 = var450.split("\u005cs") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s") 
(define-const var2764 String (var1178_renderCodes/830694732 var538)) ; Statement: $r2 = staticinvoke <org.jline.jansi.AnsiRenderer: java.lang.String renderCodes(java.lang.String[])>($r1) 
 ; Statement: return $r2 
(check-sat)
; {var1178_renderCodes/830694732=([java.lang.String[]], java.lang.String)}
; {var450=r0, var431=null_type, var538=$r1, var1178=org.jline.jansi.AnsiRenderer, var2764=$r2}
; {r0=var450, null_type=var431, $r1=var538, org.jline.jansi.AnsiRenderer=var1178, $r2=var2764}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s");	$r2 = staticinvoke <org.jline.jansi.AnsiRenderer: java.lang.String renderCodes(java.lang.String[])>($r1);	return $r2
;block_num 1