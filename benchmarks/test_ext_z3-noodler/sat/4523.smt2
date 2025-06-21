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

(declare-sort var2244 0)
(declare-sort var1637 0)
(declare-sort var1081 0)
(declare-sort var3310 0)
(declare-sort var998 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun resolveAttribute/966471455 (var2244 String) var1637)
(declare-fun cast-from-var1637-to-String (var1637) String)
(declare-fun var1081_isEmpty/-813097145 (String) Bool)
(declare-fun getClass/1258963082 (var1637) ClassObject)
(declare-fun cast-from-var2244-to-var1637 (var2244) var1637)
(declare-fun getClassLoader/-563698447 (ClassObject) var3310)
(declare-fun var998_resolveClass/-1921470640 (String var3310) ClassObject)
(declare-fun var998_isGenericClass/-837476823 (ClassObject) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-const null-var2244 var2244)
(declare-const var3749 var2244) ; Statement: r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var3749 null-var2244)))
(assert true)
(define-const var371 var1637 (resolveAttribute/966471455 var3749 "interfaceName")) ; Statement: $r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName") 
(define-const var2166 String (cast-from-var1637-to-String var371)) ; Statement: r8 = (java.lang.String) $r1 
(define-const var108 Bool (var1081_isEmpty/-813097145 var2166)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (= (ite var108 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2928 ClassObject (getClass/1258963082 (cast-from-var2244-to-var1637 var3749))) ; Statement: $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var2001 var3310 (getClassLoader/-563698447 var2928)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var854 ClassObject (var998_resolveClass/-1921470640 var2166 var2001)) ; Statement: r9 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.Class resolveClass(java.lang.String,java.lang.ClassLoader)>(r8, $r3) 
(assert true) ; Non Conditional
(define-const var2572 Bool (var998_isGenericClass/-837476823 var854)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9) 
 ; Statement: if $z1 == 0 goto r10 = null 
(assert (not (= (ite var2572 1 0) 0))) ; Negate: Cond: $z1 == 0  
(assert true)
(define-const var1991 String (getName/-1958580599 var854)) ; Statement: r10 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>() 
 ; Statement: goto [?= $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10)] 
(assert true) ; Non Conditional
(define-const var3012 Bool (var1081_isEmpty/-813097145 var1991)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z2 == 0 goto return r10 
(assert (= (ite var3012 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r10 
(check-sat)
; {resolveAttribute/966471455=([org.apache.dubbo.common.utils.ServiceAnnotationResolver, java.lang.String], java.lang.Object), cast-from-var1637-to-String=([java.lang.Object], java.lang.String), var1081_isEmpty/-813097145=([java.lang.String], boolean), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var2244-to-var1637=([org.apache.dubbo.common.utils.ServiceAnnotationResolver], java.lang.Object), getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), var998_resolveClass/-1921470640=([java.lang.String, java.lang.ClassLoader], java.lang.Class), var998_isGenericClass/-837476823=([java.lang.Class], boolean), getName/-1958580599=([java.lang.Class], java.lang.String)}
; {var2244=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var3749=r0, var1637=java.lang.Object, var371=$r1, var2166=r8, var1081=org.apache.dubbo.common.utils.StringUtils, var108=$z0, var2928=$r2, var3310=java.lang.ClassLoader, var2001=$r3, var998=org.apache.dubbo.common.utils.ClassUtils, var854=r9, var2572=$z1, var1991=r10, var3012=$z2}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var2244, r0=var3749, java.lang.Object=var1637, $r1=var371, r8=var2166, org.apache.dubbo.common.utils.StringUtils=var1081, $z0=var108, $r2=var2928, java.lang.ClassLoader=var3310, $r3=var2001, org.apache.dubbo.common.utils.ClassUtils=var998, r9=var854, $z1=var2572, r10=var1991, $z2=var3012}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	$r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName");	r8 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	r9 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.Class resolveClass(java.lang.String,java.lang.ClassLoader)>(r8, $r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9);	if $z1 == 0 goto r10 = null;	r10 = virtualinvoke r9.<java.lang.Class: java.lang.String getName()>();	goto [?= $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10)];	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z2 == 0 goto return r10;	return r10
;block_num 6