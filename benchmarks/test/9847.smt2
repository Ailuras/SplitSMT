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

(declare-sort var926 0)
(declare-sort var927 0)
(declare-sort var2714 0)
(declare-sort var948 0)
(declare-sort var3784 0)
(declare-sort var2691 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClassLoader/-563698447 (ClassObject) var2714)
(declare-fun var3784_getClassPool/1841095477 (var2714) var948)
(declare-fun intern/-1326102057 (String) String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var926 var926)
(declare-const null-String String)
(declare-const null-var2691 var2691)
(declare-const var2391 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2391 null-ClassObject)))
(declare-const var2127 var926) ; Statement: r9 := @parameter1: java.lang.reflect.Method 
(assert (not (= var2127 null-var926)))
(declare-const var103 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var103 null-String)))
(assert true)
(define-const var2923 var2714 (getClassLoader/-563698447 var2391)) ; Statement: $r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var579 var948 (var3784_getClassPool/1841095477 var2923)) ; Statement: r2 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: javassist.ClassPool getClassPool(java.lang.ClassLoader)>($r1) 
(assert true)
(define-const var3884 String (intern/-1326102057 var103)) ; Statement: $r4 = virtualinvoke r3.<java.lang.String: java.lang.String intern()>() 
 ; Statement: entermonitor $r4 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3888 var2691) ; Statement: $r48 := @caughtexception 
(assert (not (= var3888 null-var2691)))
(assert true) ; Non Conditional
 ; Statement: exitmonitor $r4 
(assert true) ; Non Conditional
 ; Statement: throw $r48 
(check-sat)
; {getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), var3784_getClassPool/1841095477=([java.lang.ClassLoader], javassist.ClassPool), intern/-1326102057=([java.lang.String], java.lang.String)}
; {var2391=r0, var926=java.lang.reflect.Method, var2127=r9, var103=r3, var927=null_type, var2714=java.lang.ClassLoader, var2923=$r1, var948=javassist.ClassPool, var3784=org.apache.dubbo.common.bytecode.ClassGenerator, var579=r2, var3884=$r4, var2691=java.lang.Throwable, var3888=$r48}
; {r0=var2391, java.lang.reflect.Method=var926, r9=var2127, r3=var103, null_type=var927, java.lang.ClassLoader=var2714, $r1=var2923, javassist.ClassPool=var948, org.apache.dubbo.common.bytecode.ClassGenerator=var3784, r2=var579, $r4=var3884, java.lang.Throwable=var2691, $r48=var3888}
;seq <java.lang.String: java.lang.String intern()>
;cnt {"<java.lang.String: java.lang.String intern()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r9 := @parameter1: java.lang.reflect.Method;	r3 := @parameter2: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	r2 = staticinvoke <org.apache.dubbo.common.bytecode.ClassGenerator: javassist.ClassPool getClassPool(java.lang.ClassLoader)>($r1);	$r4 = virtualinvoke r3.<java.lang.String: java.lang.String intern()>();	entermonitor $r4;	$r48 := @caughtexception;	exitmonitor $r4;	throw $r48
;block_num 4