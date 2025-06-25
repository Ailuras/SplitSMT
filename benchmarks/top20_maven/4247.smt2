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

(declare-sort var3423 0)
(declare-sort var2909 0)
(declare-sort var3237 0)
(declare-sort var1322 0)
(declare-sort var3452 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1322_list/757555136 ((Array Int var3452)) var3237)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3452__ ((Array Int String)) (Array Int var3452))
(declare-fun <init>/703393884 (var3423 var3237) void)
(declare-const null-var3423 var3423)
(declare-const null-String String)
(declare-const var2040 var3423) ; Statement: r0 := @this: org.assertj.core.api.recursive.comparison.FieldLocation 
(assert (not (= var2040 null-var3423)))
(declare-const var1238 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1238 null-String)))
; split operation: var994 = var1238.split("\u005c.") ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var1027 var3237 (var1322_list/757555136 (cast-from-__Array__Int__String__-to-__Array__Int__var3452__ var994))) ; Statement: $r3 = staticinvoke <org.assertj.core.util.Lists: java.util.List list(java.lang.Object[])>($r2) 
(assert true)
;(assert (<init>/703393884 var2040 var1027)) ; Statement: specialinvoke r0.<org.assertj.core.api.recursive.comparison.FieldLocation: void <init>(java.util.List)>($r3) 

(declare-const var2040!1 var3423)
(declare-const var1027!1 var3237)
 ; Statement: return 
(check-sat)
; {var1322_list/757555136=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3452__=([java.lang.String[]], java.lang.Object[]), <init>/703393884=([org.assertj.core.api.recursive.comparison.FieldLocation, java.util.List], void)}
; {var3423=org.assertj.core.api.recursive.comparison.FieldLocation, var2040=r0, var1238=r1, var2909=null_type, var994=$r2, var3237=java.util.List, var1322=org.assertj.core.util.Lists, var3452=java.lang.Object, var1027=$r3}
; {org.assertj.core.api.recursive.comparison.FieldLocation=var3423, r0=var2040, r1=var1238, null_type=var2909, $r2=var994, java.util.List=var3237, org.assertj.core.util.Lists=var1322, java.lang.Object=var3452, $r3=var1027}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.assertj.core.api.recursive.comparison.FieldLocation;	r1 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$r3 = staticinvoke <org.assertj.core.util.Lists: java.util.List list(java.lang.Object[])>($r2);	specialinvoke r0.<org.assertj.core.api.recursive.comparison.FieldLocation: void <init>(java.util.List)>($r3);	return
;block_num 1