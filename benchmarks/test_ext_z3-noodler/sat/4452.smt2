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

(declare-sort var1611 0)
(declare-sort var1707 0)
(declare-sort var2590 0)
(declare-sort var3508 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun resolveAttribute/966471455 (var1611 String) var1707)
(declare-fun cast-from-var1707-to-String (var1707) String)
(declare-fun var2590_isEmpty/-813097145 (String) Bool)
(declare-fun cast-from-var1707-to-ClassObject (var1707) ClassObject)
(declare-fun var3508_isGenericClass/-837476823 (ClassObject) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-const null-var1611 var1611)
(declare-const var3691 var1611) ; Statement: r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var3691 null-var1611)))
(assert true)
(define-const var2556 var1707 (resolveAttribute/966471455 var3691 "interfaceName")) ; Statement: $r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName") 
(define-const var43 String (cast-from-var1707-to-String var2556)) ; Statement: r8 = (java.lang.String) $r1 
(define-const var3347 Bool (var2590_isEmpty/-813097145 var43)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (not (= (ite var3347 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3599 var1707 (resolveAttribute/966471455 var3691 "interfaceClass")) ; Statement: $r7 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceClass") 
(define-const var1780 ClassObject (cast-from-var1707-to-ClassObject var3599)) ; Statement: r9 = (java.lang.Class) $r7 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9)] 
(assert true) ; Non Conditional
(define-const var2859 Bool (var3508_isGenericClass/-837476823 var1780)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9) 
 ; Statement: if $z1 == 0 goto r10 = null 
(assert (not (= (ite var2859 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var3111 String (getName/-1958580599 var1780)) ; Statement: r10 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
 ; Statement: goto [?= $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10)] 
(assert true) ; Non Conditional
(define-const var2068 Bool (var2590_isEmpty/-813097145 var3111)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z2 == 0 goto return r10 
(assert (= (ite var2068 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r10 
(check-sat)
; {resolveAttribute/966471455=([org.apache.dubbo.common.utils.ServiceAnnotationResolver, java.lang.String], java.lang.Object), cast-from-var1707-to-String=([java.lang.Object], java.lang.String), var2590_isEmpty/-813097145=([java.lang.String], boolean), cast-from-var1707-to-ClassObject=([java.lang.Object], java.lang.Class), var3508_isGenericClass/-837476823=([java.lang.Class], boolean), getName/-1958580599=([java.lang.Class], java.lang.String)}
; {var1611=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var3691=r0, var1707=java.lang.Object, var2556=$r1, var43=r8, var2590=org.apache.dubbo.common.utils.StringUtils, var3347=$z0, var3599=$r7, var1780=r9, var3508=org.apache.dubbo.common.utils.ClassUtils, var2859=$z1, var3111=r10, var2068=$z2}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var1611, r0=var3691, java.lang.Object=var1707, $r1=var2556, r8=var43, org.apache.dubbo.common.utils.StringUtils=var2590, $z0=var3347, $r7=var3599, r9=var1780, org.apache.dubbo.common.utils.ClassUtils=var3508, $z1=var2859, r10=var3111, $z2=var2068}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	$r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName");	r8 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r7 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceClass");	r9 = (java.lang.Class) $r7;	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9);	if $z1 == 0 goto r10 = null;	r10 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	goto [?= $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10)];	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z2 == 0 goto return r10;	return r10
;block_num 6