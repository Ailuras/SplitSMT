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

(declare-sort var3556 0)
(declare-sort var478 0)
(declare-sort var1415 0)
(declare-sort var3300 0)
(declare-sort var3412 0)
(declare-sort var967 0)
(declare-sort var2942 0)
(declare-sort var1695 0)
(declare-sort var2065 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var478_isNumber/1050655655 (String) Bool)
(declare-fun var1415_values/1343703651 () (Array Int var1415))
(declare-fun var3412_stream/-1757820 ((Array Int var967)) var3300)
(declare-fun cast-from-__Array__Int__var1415__-to-__Array__Int__var967__ ((Array Int var1415)) (Array Int var967))
(declare-fun var1695_bootstrap$/-413690342 (String) var2942)
(declare-fun var3300_filter/320182972 (var3300 var2942) var3300)
(declare-fun var3300_findFirst/-512239506 (var3300) var2065)
(declare-fun orElse/-757175127 (var2065 var967) var967)
(declare-fun cast-from-var1415-to-var967 (var1415) var967)
(declare-fun cast-from-var967-to-var1415 (var967) var1415)
(declare-const null-String String)
(declare-const var1415-PUBLIC var1415)
(declare-const var330 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var330 null-String)))
(define-const var43 Bool (var478_isNumber/1050655655 var330)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>() 
(assert (not (= (ite var43 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var24 (Array Int var1415) var1415_values/1343703651) ; Statement: $r9 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>() 
(define-const var3589 var3300 (var3412_stream/-1757820 (cast-from-__Array__Int__var1415__-to-__Array__Int__var967__ var24))) ; Statement: $r11 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r9) 
(define-const var2345 var2942 (var1695_bootstrap$/-413690342 var330)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel$lambda_from_0__862: java.util.function.Predicate bootstrap$(java.lang.String)>(r0) 
(define-const var3182 var3300 (var3300_filter/320182972 var3589 var2345)) ; Statement: $r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r10) 
(define-const var858 var2065 (var3300_findFirst/-512239506 var3182)) ; Statement: $r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional findFirst()>() 
(define-const var743 var1415 var1415-PUBLIC) ; Statement: $r13 = <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel PUBLIC> 
(assert true)
(define-const var2323 var967 (orElse/-757175127 var858 (cast-from-var1415-to-var967 var743))) ; Statement: $r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13) 
(define-const var1692 var1415 (cast-from-var967-to-var1415 var2323)) ; Statement: $r16 = (org.apache.dubbo.qos.api.PermissionLevel) $r15 
 ; Statement: return $r16 
(check-sat)
; {var478_isNumber/1050655655=([java.lang.String], boolean), var1415_values/1343703651=([], org.apache.dubbo.qos.api.PermissionLevel[]), var3412_stream/-1757820=([java.lang.Object[]], java.util.stream.Stream), cast-from-__Array__Int__var1415__-to-__Array__Int__var967__=([org.apache.dubbo.qos.api.PermissionLevel[]], java.lang.Object[]), var1695_bootstrap$/-413690342=([java.lang.String], java.util.function.Predicate), var3300_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var3300_findFirst/-512239506=([java.util.stream.Stream], java.util.Optional), orElse/-757175127=([java.util.Optional, java.lang.Object], java.lang.Object), cast-from-var1415-to-var967=([org.apache.dubbo.qos.api.PermissionLevel], java.lang.Object), cast-from-var967-to-var1415=([java.lang.Object], org.apache.dubbo.qos.api.PermissionLevel)}
; {var330=r0, var3556=null_type, var478=org.apache.dubbo.common.utils.StringUtils, var43=$z0, var1415=org.apache.dubbo.qos.api.PermissionLevel, var24=$r9, var3300=java.util.stream.Stream, var3412=java.util.Arrays, var967=java.lang.Object, var3589=$r11, var2942=java.util.function.Predicate, var1695=org.apache.dubbo.qos.api.PermissionLevel$lambda_from_0__862, var2345=$r10, var3182=$r12, var2065=java.util.Optional, var858=$r14, var743=$r13, var2323=$r15, var1692=$r16}
; {r0=var330, null_type=var3556, org.apache.dubbo.common.utils.StringUtils=var478, $z0=var43, org.apache.dubbo.qos.api.PermissionLevel=var1415, $r9=var24, java.util.stream.Stream=var3300, java.util.Arrays=var3412, java.lang.Object=var967, $r11=var3589, java.util.function.Predicate=var2942, org.apache.dubbo.qos.api.PermissionLevel$lambda_from_0__862=var1695, $r10=var2345, $r12=var3182, java.util.Optional=var2065, $r14=var858, $r13=var743, $r15=var2323, $r16=var1692}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>();	$r9 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel[] values()>();	$r11 = staticinvoke <java.util.Arrays: java.util.stream.Stream stream(java.lang.Object[])>($r9);	$r10 = staticinvoke <org.apache.dubbo.qos.api.PermissionLevel$lambda_from_0__862: java.util.function.Predicate bootstrap$(java.lang.String)>(r0);	$r12 = interfaceinvoke $r11.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r10);	$r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.Optional findFirst()>();	$r13 = <org.apache.dubbo.qos.api.PermissionLevel: org.apache.dubbo.qos.api.PermissionLevel PUBLIC>;	$r15 = virtualinvoke $r14.<java.util.Optional: java.lang.Object orElse(java.lang.Object)>($r13);	$r16 = (org.apache.dubbo.qos.api.PermissionLevel) $r15;	return $r16
;block_num 2