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

(declare-sort var3068 0)
(declare-sort var1876 0)
(declare-sort var1358 0)
(declare-sort var1810 0)
(declare-sort var1467 0)
(declare-sort var1042 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun resolveAttribute/966471455 (var3068 String) var1876)
(declare-fun cast-from-var1876-to-String (var1876) String)
(declare-fun var1358_isEmpty/-813097145 (String) Bool)
(declare-fun getClass/1258963082 (var1876) ClassObject)
(declare-fun cast-from-var3068-to-var1876 (var3068) var1876)
(declare-fun getClassLoader/-563698447 (ClassObject) var1810)
(declare-fun var1467_resolveClass/-1921470640 (String var1810) ClassObject)
(declare-fun var1467_isGenericClass/-837476823 (ClassObject) Bool)
(declare-const null-var3068 var3068)
(declare-const null-String String)
(declare-const var352 var3068) ; Statement: r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver 
(assert (not (= var352 null-var3068)))
(assert true)
(define-const var765 var1876 (resolveAttribute/966471455 var352 "interfaceName")) ; Statement: $r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName") 
(define-const var1779 String (cast-from-var1876-to-String var765)) ; Statement: r8 = (java.lang.String) $r1 
(define-const var1491 Bool (var1358_isEmpty/-813097145 var1779)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert (= (ite var1491 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var363 ClassObject (getClass/1258963082 (cast-from-var3068-to-var1876 var352))) ; Statement: $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var327 var1810 (getClassLoader/-563698447 var363)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var3898 ClassObject (var1467_resolveClass/-1921470640 var1779 var327)) ; Statement: r9 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.Class resolveClass(java.lang.String,java.lang.ClassLoader)>(r8, $r3) 
(assert true) ; Non Conditional
(define-const var659 Bool (var1467_isGenericClass/-837476823 var3898)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9) 
 ; Statement: if $z1 == 0 goto r10 = null 
(assert (= (ite var659 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3164 String null-String) ; Statement: r10 = null 
(assert true) ; Non Conditional
(define-const var1937 Bool (var1358_isEmpty/-813097145 var3164)) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10) 
 ; Statement: if $z2 == 0 goto return r10 
(assert (= (ite var1937 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return r10 
(check-sat)
; {resolveAttribute/966471455=([org.apache.dubbo.common.utils.ServiceAnnotationResolver, java.lang.String], java.lang.Object), cast-from-var1876-to-String=([java.lang.Object], java.lang.String), var1358_isEmpty/-813097145=([java.lang.String], boolean), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3068-to-var1876=([org.apache.dubbo.common.utils.ServiceAnnotationResolver], java.lang.Object), getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), var1467_resolveClass/-1921470640=([java.lang.String, java.lang.ClassLoader], java.lang.Class), var1467_isGenericClass/-837476823=([java.lang.Class], boolean)}
; {var3068=org.apache.dubbo.common.utils.ServiceAnnotationResolver, var352=r0, var1876=java.lang.Object, var765=$r1, var1779=r8, var1358=org.apache.dubbo.common.utils.StringUtils, var1491=$z0, var363=$r2, var1810=java.lang.ClassLoader, var327=$r3, var1467=org.apache.dubbo.common.utils.ClassUtils, var3898=r9, var659=$z1, var1042=null_type, var3164=r10, var1937=$z2}
; {org.apache.dubbo.common.utils.ServiceAnnotationResolver=var3068, r0=var352, java.lang.Object=var1876, $r1=var765, r8=var1779, org.apache.dubbo.common.utils.StringUtils=var1358, $z0=var1491, $r2=var363, java.lang.ClassLoader=var1810, $r3=var327, org.apache.dubbo.common.utils.ClassUtils=var1467, r9=var3898, $z1=var659, null_type=var1042, r10=var3164, $z2=var1937}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 2}
;stmts r0 := @this: org.apache.dubbo.common.utils.ServiceAnnotationResolver;	$r1 = specialinvoke r0.<org.apache.dubbo.common.utils.ServiceAnnotationResolver: java.lang.Object resolveAttribute(java.lang.String)>("interfaceName");	r8 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r8);	if $z0 == 0 goto $r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r2 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	r9 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.Class resolveClass(java.lang.String,java.lang.ClassLoader)>(r8, $r3);	$z1 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: boolean isGenericClass(java.lang.Class)>(r9);	if $z1 == 0 goto r10 = null;	r10 = null;	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r10);	if $z2 == 0 goto return r10;	return r10
;block_num 6