(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1124 0)
(declare-sort var2643 0)
(declare-sort var2590 0)
(declare-sort var1767 0)
(declare-sort var3369 0)
(declare-sort var2029 0)
(declare-sort var527 0)
(declare-sort var3448 0)
(declare-sort var1033 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2643_isNumber/1050655655 (String) Bool)
(declare-fun var2590_values/1343703651 () (Array Int var2590))
(declare-fun var3369_stream/-1757820 ((Array Int var2029)) var1767)
(declare-fun cast-from-__Array__Int__var2590__-to-__Array__Int__var2029__ ((Array Int var2590)) (Array Int var2029))
(declare-fun var3448_bootstrap$/-478158980 (String) var527)
(declare-fun var1767_filter/320182972 (var1767 var527) var1767)
(declare-fun var1767_findFirst/-512239506 (var1767) var1033)
(declare-fun orElse/-757175127 (var1033 var2029) var2029)
(declare-fun cast-from-var2590-to-var2029 (var2590) var2029)
(declare-fun cast-from-var2029-to-var2590 (var2029) var2590)
(declare-const null-String String)
(declare-const var2590-PUBLIC var2590)
(declare-const var1451 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1451 null-String)))
(define-const var806 Bool (var2643_isNumber/1050655655 var1451)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>() 
(assert (= (ite var806 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3106 (Array Int var2590) var2590_values/1343703651) ; Statement: $r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>() 
(define-const var1006 var1767 (var3369_stream/-1757820 (cast-from-__Array__Int__var2590__-to-__Array__Int__var2029__ var3106))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1) 
(define-const var242 var527 (var3448_bootstrap$/-478158980 var1451)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel$lambda_from_1__843: java.util.function.Predicate bootstrap$(java.lang.String)>(r0) 
(define-const var2758 var1767 (var1767_filter/320182972 var1006 var242)) ; Statement: $r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2) 
(define-const var3229 var1033 (var1767_findFirst/-512239506 var2758)) ; Statement: $r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>() 
(define-const var2241 var2590 var2590-PUBLIC) ; Statement: $r5 = <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel PUBLIC> 
(assert true)
(define-const var1052 var2029 (orElse/-757175127 var3229 (cast-from-var2590-to-var2029 var2241))) ; Statement: $r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r5) 
(define-const var3505 var2590 (cast-from-var2029-to-var2590 var1052)) ; Statement: $r8 = (org.apache.dubbo.qos.api.PermissionLevel) $r7 
 ; Statement: return $r8 
(check-sat)
; {var2643_isNumber/1050655655=([java.lang.String], boolean), var2590_values/1343703651=([], org.apache.dubbo.qos.api.PermissionLevel[]), var3369_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__var2590__-to-__Array__Int__var2029__=([org.apache.dubbo.qos.api.PermissionLevel[]], java.lang.Object[]), var3448_bootstrap$/-478158980=([java.lang.String], java.util.function.Predicate), var1767_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var1767_findFirst/-512239506=([java.util.stream.Stream], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var2590-to-var2029=([org.apache.dubbo.qos.api.PermissionLevel], java.lang.Object), cast-from-var2029-to-var2590=([java.lang.Object], org.apache.dubbo.qos.api.PermissionLevel)}
; {var1451=r0, var1124=null_type, var2643=org.apache.dubbo.common.utils.StringUtils, var806=$z0, var2590=org.apache.dubbo.qos.api.PermissionLevel, var3106=$r1, var1767=java.util.stream.Stream, var3369=java.util.Arrays, var2029=java.lang.Object, var1006=$r3, var527=java.util.function.Predicate, var3448=org.apache.dubbo.qos.api.PermissionLevel$lambda_from_1__843, var242=$r2, var2758=$r4, var1033=java.util.Optional, var3229=$r6, var2241=$r5, var1052=$r7, var3505=$r8}
; {r0=var1451, null_type=var1124, org.apache.dubbo.common.utils.StringUtils=var2643, $z0=var806, org.apache.dubbo.qos.api.PermissionLevel=var2590, $r1=var3106, java.util.stream.Stream=var1767, java.util.Arrays=var3369, java.lang.Object=var2029, $r3=var1006, java.util.function.Predicate=var527, org.apache.dubbo.qos.api.PermissionLevel$lambda_from_1__843=var3448, $r2=var242, $r4=var2758, java.util.Optional=var1033, $r6=var3229, $r5=var2241, $r7=var1052, $r8=var3505}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>();	$r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>();	$r3 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r1);	$r2 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel$lambda_from_1__843: java.util.function.Predicate bootstrap$(java.lang.String)>(r0);	$r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2);	$r6 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>();	$r5 = <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel PUBLIC>;	$r7 = virtualinvoke $r6.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r5);	$r8 = (org.apache.dubbo.qos.api.PermissionLevel) $r7;	return $r8
;block_num 2