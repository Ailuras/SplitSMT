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

(declare-sort var830 0)
(declare-sort var3017 0)
(declare-sort var242 0)
(declare-sort var3127 0)
(declare-sort var1158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun resolveAttribute/966471455 (var830 String) var3017)
(declare-fun cast-from-var3017-to-String (var3017) String)
(declare-fun var242_isEmpty/-813097145 (String) Bool)
(declare-fun cast-from-var3017-to-ClassObject (var3017) ClassObject)
(declare-fun var3127_isGenericClass/-837476823 (ClassObject) Bool)
(declare-const null-var830 var830)
(declare-const null-String String)
(declare-const var3614 var830) ; Statement: r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var3614 null-var830)))
(assert true)
(define-const var1716 var3017 (resolveAttribute/966471455 var3614 "interfaceName")) ; Statement: $r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName") 
(define-const var1227 String (cast-from-var3017-to-String var1716)) ; Statement: r8 = (java.lang.String) $r1 
(define-const var3551 Bool (var242_isEmpty/-813097145 var1227)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (not (= (ite var3551 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3833 var3017 (resolveAttribute/966471455 var3614 "interfaceClass")) ; Statement: $r7 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceClass") 
(define-const var1297 ClassObject (cast-from-var3017-to-ClassObject var3833)) ; Statement: r9 = (java.lang.Class) $r7 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9)] 
(assert true) ; Non Conditional
(define-const var3600 Bool (var3127_isGenericClass/-837476823 var1297)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9) 
 ; Statement: if $z1 == 0 goto r10 = null 
(assert (= (ite var3600 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3521 String null-String) ; Statement: r10 = null 
(assert true) ; Non Conditional
(define-const var3298 Bool (var242_isEmpty/-813097145 var3521)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z2 == 0 goto return r10 
(assert (= (ite var3298 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r10 
(check-sat)
; {resolveAttribute/966471455=([org.apache.dubbo.common.utils.ServiceAnnotationResolver, java.lang.String], java.lang.Object), cast-from-var3017-to-String=([java.lang.Object], java.lang.String), var242_isEmpty/-813097145=([java.lang.String], boolean), cast-from-var3017-to-ClassObject=([java.lang.Object], java.lang.Class), var3127_isGenericClass/-837476823=([java.lang.Class], boolean)}
; {var830=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var3614=r0, var3017=java.lang.Object, var1716=$r1, var1227=r8, var242=org.apache.dubbo.common.utils.StringUtils, var3551=$z0, var3833=$r7, var1297=r9, var3127=org.apache.dubbo.common.utils.ClassUtils, var3600=$z1, var1158=null_type, var3521=r10, var3298=$z2}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var830, r0=var3614, java.lang.Object=var3017, $r1=var1716, r8=var1227, org.apache.dubbo.common.utils.StringUtils=var242, $z0=var3551, $r7=var3833, r9=var1297, org.apache.dubbo.common.utils.ClassUtils=var3127, $z1=var3600, null_type=var1158, r10=var3521, $z2=var3298}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	$r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName");	r8 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r7 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceClass");	r9 = (java.lang.Class) $r7;	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9);	if $z1 == 0 goto r10 = null;	r10 = null;	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z2 == 0 goto return r10;	return r10
;block_num 6