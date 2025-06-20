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

(declare-sort var596 0)
(declare-sort var1622 0)
(declare-sort var3623 0)
(declare-sort var2090 0)
(declare-sort var1900 0)
(declare-sort var3938 0)
(declare-sort var3626 0)
(declare-sort var2411 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var596) ClassObject)
(declare-fun var3623_resolveTypes/-936171205 ((Array Int var596)) (Array Int ClassObject))
(declare-fun var1900_findMethod/1018470640 (ClassObject String (Array Int ClassObject)) var2090)
(declare-fun var3626-init () var3626)
(declare-fun <init>/1654429637 (var3626 var2411) void)
(declare-fun cast-from-var3938-to-var2411 (var3938) var2411)
(declare-const null-var596 var596)
(declare-const null-String String)
(declare-const null-__Array__Int__var596__ (Array Int var596))
(declare-const null-var2090 var2090)
(declare-const null-var3938 var3938)
(declare-const var2362 var596) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var2362 null-var596)))
(declare-const var1734 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var1734 null-String)))
(declare-const var3111 (Array Int var596)) ; Statement: r2 := @parameter2: java.lang.Object[] 
(assert (not (= var3111 null-__Array__Int__var596__)))
(assert true)
(define-const var1613 ClassObject (getClass/1258963082 var2362)) ; Statement: r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var3616 (Array Int ClassObject) (var3623_resolveTypes/-936171205 var3111)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] resolveTypes(java.lang.Object[])>(r2) 
(define-const var1975 var2090 (var1900_findMethod/1018470640 var1613 var1734 var3616)) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(r1, r4, r3) 
 ; Statement: if r5 != null goto z0 = virtualinvoke r5.<java.lang.reflect.Method: boolean isAccessible()>() 
(assert (not (not (= var1975 null-var2090)))) ; Negate: Cond: r5 != null  
(declare-const var571 var3938) ; Statement: $r11 := @caughtexception 
(assert (not (= var571 null-var3938)))
(define-const var3903 var3626 var3626-init) ; Statement: $r12 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/1654429637 var3903 (cast-from-var3938-to-var2411 var571))) ; Statement: specialinvoke $r12.<java.lang.IllegalArgumentException: void <init>(java.lang.Throwable)>($r11) 

(declare-const var3903!1 var3626)
(declare-const var571!1 var3938)
 ; Statement: throw $r12 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), var3623_resolveTypes/-936171205=([java.lang.Object[]], java.lang.Class[]), var1900_findMethod/1018470640=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), var3626-init=([], java.lang.IllegalArgumentException), <init>/1654429637=([java.lang.IllegalArgumentException, java.lang.Throwable], void), cast-from-var3938-to-var2411=([java.lang.Exception], java.lang.Throwable)}
; {var596=java.lang.Object, var2362=r0, var1734=r4, var1622=null_type, var3111=r2, var1613=r1, var3623=org.apache.dubbo.common.utils.ReflectUtils, var3616=r3, var2090=java.lang.reflect.Method, var1900=org.apache.dubbo.common.utils.MethodUtils, var1975=r5, var3938=java.lang.Exception, var571=$r11, var3626=java.lang.IllegalArgumentException, var3903=$r12, var2411=java.lang.Throwable}
; {java.lang.Object=var596, r0=var2362, r4=var1734, null_type=var1622, r2=var3111, r1=var1613, org.apache.dubbo.common.utils.ReflectUtils=var3623, r3=var3616, java.lang.reflect.Method=var2090, org.apache.dubbo.common.utils.MethodUtils=var1900, r5=var1975, java.lang.Exception=var3938, $r11=var571, java.lang.IllegalArgumentException=var3626, $r12=var3903, java.lang.Throwable=var2411}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.Object;	r4 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] resolveTypes(java.lang.Object[])>(r2);	r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(r1, r4, r3);	if r5 != null goto z0 = virtualinvoke r5.<java.lang.reflect.Method: boolean isAccessible()>();	$r11 := @caughtexception;	$r12 = new java.lang.IllegalArgumentException;	specialinvoke $r12.<java.lang.IllegalArgumentException: void <init>(java.lang.Throwable)>($r11);	throw $r12
;block_num 2