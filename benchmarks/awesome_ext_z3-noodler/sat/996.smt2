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

(declare-sort var945 0)
(declare-sort var79 0)
(declare-sort var3181 0)
(declare-sort var226 0)
(declare-sort var1995 0)
(declare-sort var3426 0)
(declare-sort var587 0)
(declare-sort var2106 0)
(declare-sort var40 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3181_stream/-1757820 ((Array Int var226)) var79)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var226__ ((Array Int String)) (Array Int var226))
(declare-fun var3426_bootstrap$/-555495744 () var1995)
(declare-fun var79_map/130902797 (var79 var1995) var79)
(declare-fun var2106_toSet/773895321 () var587)
(declare-fun var79_collect/-2050842585 (var79 var587) var226)
(declare-fun cast-from-var226-to-var40 (var226) var40)
(declare-const null-String String)
(declare-const var2414 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2414 null-String)))
; split operation: var2230 = var2414.split(",") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1048 var79 (var3181_stream/-1757820 (cast-from-__Array__Int__String__-to-__Array__Int__var226__ var2230))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1) 
(define-const var3386 var1995 var3426_bootstrap$/-555495744) ; Statement: $r2 = staticinvoke <com.cedarsoftware.io.MetaUtils$trim__4: java.util.function.Function bootstrap$()>() 
(define-const var3556 var79 (var79_map/130902797 var1048 var3386)) ; Statement: $r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2) 
(define-const var490 var587 var2106_toSet/773895321) ; Statement: $r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>() 
(define-const var1133 var226 (var79_collect/-2050842585 var3556 var490)) ; Statement: $r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4) 
(define-const var1685 var40 (cast-from-var226-to-var40 var1133)) ; Statement: $r7 = (java.util.Set) $r6 
 ; Statement: return $r7 
(check-sat)
; {var3181_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__String__-to-__Array__Int__var226__=([java.lang.String[]], java.lang.Object[]), var3426_bootstrap$/-555495744=([], java.util.function.Function), var79_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var2106_toSet/773895321=([], java.util.stream.Collector), var79_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var226-to-var40=([java.lang.Object], java.util.Set)}
; {var2414=r0, var945=null_type, var2230=$r1, var79=java.util.stream.Stream, var3181=java.util.Arrays, var226=java.lang.Object, var1048=$r3, var1995=java.util.function.Function, var3426=com.cedarsoftware.io.MetaUtils$trim__4, var3386=$r2, var3556=$r5, var587=java.util.stream.Collector, var2106=java.util.stream.Collectors, var490=$r4, var1133=$r6, var40=java.util.Set, var1685=$r7}
; {r0=var2414, null_type=var945, $r1=var2230, java.util.stream.Stream=var79, java.util.Arrays=var3181, java.lang.Object=var226, $r3=var1048, java.util.function.Function=var1995, com.cedarsoftware.io.MetaUtils$trim__4=var3426, $r2=var3386, $r5=var3556, java.util.stream.Collector=var587, java.util.stream.Collectors=var2106, $r4=var490, $r6=var1133, java.util.Set=var40, $r7=var1685}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1);	$r2 = staticinvoke <com.cedarsoftware.io.MetaUtils$trim__4: java.util.function.Function bootstrap$()>();	$r5 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r2);	$r4 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector toSet()>();	$r6 = interfaceinvoke $r5.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r4);	$r7 = (java.util.Set) $r6;	return $r7
;block_num 1