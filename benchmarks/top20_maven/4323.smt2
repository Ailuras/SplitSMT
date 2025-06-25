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

(declare-sort var2952 0)
(declare-sort var1801 0)
(declare-sort var2188 0)
(declare-sort var3185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3185_createMap/-1128255493 ((Array Int String) (Array Int String)) var2188)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1801-COMMA_SEPARATOR String)
(declare-const var1038 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1038 null-String)))
(declare-const var2209 (Array Int String)) ; Statement: r2 := @parameter1: java.lang.String[] 
(assert (not (= var2209 null-__Array__Int__String__)))
(define-const var3436 String var1801-COMMA_SEPARATOR) ; Statement: $r1 = <org.apache.logging.log4j.core.util.Patterns: java.lang.String COMMA_SEPARATOR> 
; split operation: var2493 = var1038.split(var3436) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>($r1) 
(define-const var3593 var2188 (var3185_createMap/-1128255493 var2493 var2209)) ; Statement: $r4 = staticinvoke <org.apache.logging.log4j.core.pattern.AnsiEscape: java.util.Map createMap(java.lang.String[],java.lang.String[])>($r3, r2) 
 ; Statement: return $r4 
(check-sat)
; {var3185_createMap/-1128255493=([java.lang.String[], java.lang.String[]], java.util.Map)}
; {var1038=r0, var2952=null_type, var2209=r2, var1801=org.apache.logging.log4j.core.util.Patterns, var3436=$r1, var2493=$r3, var2188=java.util.Map, var3185=org.apache.logging.log4j.core.pattern.AnsiEscape, var3593=$r4}
; {r0=var1038, null_type=var2952, r2=var2209, org.apache.logging.log4j.core.util.Patterns=var1801, $r1=var3436, $r3=var2493, java.util.Map=var2188, org.apache.logging.log4j.core.pattern.AnsiEscape=var3185, $r4=var3593}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String[];	$r1 = <org.apache.logging.log4j.core.util.Patterns: java.lang.String COMMA_SEPARATOR>;	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>($r1);	$r4 = staticinvoke <org.apache.logging.log4j.core.pattern.AnsiEscape: java.util.Map createMap(java.lang.String[],java.lang.String[])>($r3, r2);	return $r4
;block_num 1