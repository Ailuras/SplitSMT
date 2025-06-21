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

(declare-sort var1063 0)
(declare-sort var2979 0)
(declare-sort var334 0)
(declare-sort var2288 0)
(declare-sort var3220 0)
(declare-sort var1269 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClassLoader/-563698447 (ClassObject) var334)
(declare-fun var3220_getClassPool/1841095477 (var334) var2288)
(declare-fun intern/-1326102057 (String) String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var1063 var1063)
(declare-const null-String String)
(declare-const null-var1269 var1269)
(declare-const var59 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var59 null-ClassObject)))
(declare-const var2324 var1063) ; Statement: r9 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2324 null-var1063)))
(declare-const var2312 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2312 null-String)))
(assert true)
(define-const var1243 var334 (getClassLoader/-563698447 var59)) ; Statement: $r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var979 var2288 (var3220_getClassPool/1841095477 var1243)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: javassist.ClassPool getClassPool(java.lang.ClassLoader)>($r1) 
(assert true)
(define-const var994 String (intern/-1326102057 var2312)) ; Statement: $r4 = virtualinvoke r3.<java.lang.String: java.lang.String intern()>() 
 ; Statement: entermonitor $r4 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3628 var1269) ; Statement: $r48 := @caughtexception 
(assert (not (= var3628 null-var1269)))
(assert true) ; Non Conditional
 ; Statement: exitmonitor $r4 
(assert true) ; Non Conditional
 ; Statement: throw $r48 
(check-sat)
; {getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), var3220_getClassPool/1841095477=([java.lang.ClassLoader], javassist.ClassPool), intern/-1326102057=([java.lang.String], java.lang.String)}
; {var59=r0, var1063=java.lang.reflect.Method, var2324=r9, var2312=r3, var2979=null_type, var334=java.lang.ClassLoader, var1243=$r1, var2288=javassist.ClassPool, var3220=org.apache.dubbo.common.bytecode.ClassGenerator, var979=r2, var994=$r4, var1269=java.lang.Throwable, var3628=$r48}
; {r0=var59, java.lang.reflect.Method=var1063, r9=var2324, r3=var2312, null_type=var2979, java.lang.ClassLoader=var334, $r1=var1243, javassist.ClassPool=var2288, org.apache.dubbo.common.bytecode.ClassGenerator=var3220, r2=var979, $r4=var994, java.lang.Throwable=var1269, $r48=var3628}
;seq <java.lang.String: java.lang.String intern()>
;cnt {"<java.lang.String: java.lang.String intern()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r9 := @parameter1: java.lang.reflect.Method;	r3 := @parameter2: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	r2 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: javassist.ClassPool getClassPool(java.lang.ClassLoader)>($r1);	$r4 = virtualinvoke r3.<java.lang.String: java.lang.String intern()>();	entermonitor $r4;	$r48 := @caughtexception;	exitmonitor $r4;	throw $r48
;block_num 4