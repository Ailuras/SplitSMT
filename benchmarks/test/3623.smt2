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

(declare-sort var1378 0)
(declare-sort var345 0)
(declare-sort var1372 0)
(declare-sort var1487 0)
(declare-sort var3318 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun concatenatedPrams/1671230243 (var1378) var1372)
(declare-fun var1372_get/1088891777 (var1372 var1487) var1487)
(declare-fun cast-from-String-to-var1487 (String) var1487)
(declare-fun cast-from-var1487-to-String (var1487) String)
(declare-fun var3318_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1378 var1378)
(declare-const null-String String)
(declare-const null-var1372 var1372)
(declare-const var2686 var1378) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL 
(assert (not (= var2686 null-var1378)))
(declare-const var2671 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2671 null-String)))
(define-const var1582 var1372 (concatenatedPrams/1671230243 var2686)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams> 
 ; Statement: if $r1 != null goto $r3 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams> 
(assert (not (= var1582 null-var1372))) ; Cond: $r1 != null 
(define-const var2442 var1372 (concatenatedPrams/1671230243 var2686)) ; Statement: $r3 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams> 
(define-const var14 var1487 (var1372_get/1088891777 var2442 (cast-from-String-to-var1487 var2671))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var1406 String (cast-from-var1487-to-String var14)) ; Statement: $r14 = (java.lang.String) $r4 
(define-const var3129 String var1406) ; Statement: r15 = $r14 
(define-const var107 Bool (var3318_isNotEmpty/-1251449450 var1406)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r14) 
 ; Statement: if $z0 == 0 goto r5 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r2) 
(assert (not (= (ite var107 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return $r14 
(check-sat)
; {concatenatedPrams/1671230243=([org.apache.dubbo.common.url.component.ServiceAddressURL], java.util.Map), var1372_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1487=([java.lang.String], java.lang.Object), cast-from-var1487-to-String=([java.lang.Object], java.lang.String), var3318_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1378=org.apache.dubbo.common.url.component.ServiceAddressURL, var2686=r0, var2671=r2, var345=null_type, var1372=java.util.Map, var1582=$r1, var2442=$r3, var1487=java.lang.Object, var14=$r4, var1406=$r14, var3129=r15, var3318=org.apache.dubbo.common.utils.StringUtils, var107=$z0}
; {org.apache.dubbo.common.url.component.ServiceAddressURL=var1378, r0=var2686, r2=var2671, null_type=var345, java.util.Map=var1372, $r1=var1582, $r3=var2442, java.lang.Object=var1487, $r4=var14, $r14=var1406, r15=var3129, org.apache.dubbo.common.utils.StringUtils=var3318, $z0=var107}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceAddressURL;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams>;	if $r1 != null goto $r3 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams>;	$r3 = r0.<org.apache.dubbo.common.url.component.ServiceAddressURL: java.util.Map concatenatedPrams>;	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	$r14 = (java.lang.String) $r4;	r15 = $r14;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r14);	if $z0 == 0 goto r5 = specialinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r2);	return $r14
;block_num 3