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

(declare-sort var2678 0)
(declare-sort var466 0)
(declare-sort var726 0)
(declare-sort var2790 0)
(declare-sort var440 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-fun var2790_asList/1779083644 ((Array Int var440)) var726)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var440__ ((Array Int String)) (Array Int var440))
(declare-const null-var2678 var2678)
(declare-const null-String String)
(declare-const var2059 var2678) ; Statement: r2 := @this: com.beust.jcommander.converters.CommaParameterSplitter 
(assert (not (= var2059 null-var2678)))
(declare-const var471 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var471 null-String)))
(assert true)
(define-const var2255 Bool (isEmpty/-1285796103 var471)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (= (ite var2255 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var3412 = var471.split(",") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1592 var726 (var2790_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var440__ var3412))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {isEmpty/-1285796103=([java.lang.String], boolean), var2790_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var440__=([java.lang.String[]], java.lang.Object[])}
; {var2678=com.beust.jcommander.converters.CommaParameterSplitter, var2059=r2, var471=r0, var466=null_type, var2255=$z0, var3412=$r1, var726=java.util.List, var2790=java.util.Arrays, var440=java.lang.Object, var1592=$r3}
; {com.beust.jcommander.converters.CommaParameterSplitter=var2678, r2=var2059, r0=var471, null_type=var466, $z0=var2255, $r1=var3412, java.util.List=var726, java.util.Arrays=var2790, java.lang.Object=var440, $r3=var1592}
;seq <java.lang.String: boolean isEmpty()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean isEmpty()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: com.beust.jcommander.converters.CommaParameterSplitter;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	return $r3
;block_num 3