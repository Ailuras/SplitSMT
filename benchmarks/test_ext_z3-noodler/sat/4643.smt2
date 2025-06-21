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

(declare-sort var324 0)
(declare-sort var2788 0)
(declare-sort var1487 0)
(declare-sort var257 0)
(declare-sort var1206 0)
(declare-sort var2295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClass/1258963082 (var324) ClassObject)
(declare-fun var1487_resolveTypes/-936171205 ((Array Int var324)) (Array Int ClassObject))
(declare-fun var1206_findMethod/1018470640 (ClassObject String (Array Int ClassObject)) var257)
(declare-fun var2295-init () var2295)
(declare-fun arr-var324-init () (Array Int var324))
(declare-fun cast-from-String-to-var324 (String) var324)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun String_format/1339386452 (String (Array Int var324)) String)
(declare-fun <init>/-1092629202 (var2295 String) void)
(declare-const null-var324 var324)
(declare-const null-String String)
(declare-const null-__Array__Int__var324__ (Array Int var324))
(declare-const null-var257 var257)
(declare-const var1816 var324) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var1816 null-var324)))
(declare-const var2427 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var2427 null-String)))
(declare-const var488 (Array Int var324)) ; Statement: r2 := @parameter2: java.lang.Object[] 
(assert (not (= var488 null-__Array__Int__var324__)))
(assert true)
(define-const var1486 ClassObject (getClass/1258963082 var1816)) ; Statement: r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(define-const var2336 (Array Int ClassObject) (var1487_resolveTypes/-936171205 var488)) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] resolveTypes(java.lang.Object[])>(r2) 
(define-const var337 var257 (var1206_findMethod/1018470640 var1486 var2427 var2336)) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(r1, r4, r3) 
 ; Statement: if r5 != null goto z0 = virtualinvoke r5.<java.lang.reflect.Method: boolean isAccessible()>() 
(assert (not (not (= var337 null-var257)))) ; Negate: Cond: r5 != null  
(define-const var3218 var2295 var2295-init) ; Statement: $r7 = new java.lang.IllegalStateException 
(define-const var2555 (Array Int var324) arr-var324-init) ; Statement: $r8 = newarray (java.lang.Object)[2] 
(declare-const var2555!1 (Array Int var324))
(assert (not (= var2555!1 null-__Array__Int__var324__)))
(assert (= (select var2555!1 0) (cast-from-String-to-var324 var2427))) ; Statement: $r8[0] = r4 
(assert true)
(define-const var3950 String (getName/-1958580599 var1486)) ; Statement: $r9 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(declare-const var2555!2 (Array Int var324))
(assert (not (= var2555!2 null-__Array__Int__var324__)))
(assert (= (select var2555!2 1) (cast-from-String-to-var324 var3950))) ; Statement: $r8[1] = $r9 
(define-const var964 String (String_format/1339386452 "cannot find method %s,class: %s" var2555!2)) ; Statement: $r10 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("cannot find method %s,class: %s", $r8) 
(assert true)
;(assert (<init>/-1092629202 var3218 var964)) ; Statement: specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10) 

(declare-const var3218!1 var2295)
(declare-const var964!1 String)
 ; Statement: throw $r7 
(check-sat)
; {getClass/1258963082=([java.lang.Object], java.lang.Class), var1487_resolveTypes/-936171205=([java.lang.Object[]], java.lang.Class[]), var1206_findMethod/1018470640=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), var2295-init=([], java.lang.IllegalStateException), arr-var324-init=([], java.lang.Object[]), cast-from-String-to-var324=([java.lang.String], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var324=java.lang.Object, var1816=r0, var2427=r4, var2788=null_type, var488=r2, var1486=r1, var1487=org.apache.dubbo.common.utils.ReflectUtils, var2336=r3, var257=java.lang.reflect.Method, var1206=org.apache.dubbo.common.utils.MethodUtils, var337=r5, var2295=java.lang.IllegalStateException, var3218=$r7, var2555=$r8, var3950=$r9, var964=$r10}
; {java.lang.Object=var324, r0=var1816, r4=var2427, null_type=var2788, r2=var488, r1=var1486, org.apache.dubbo.common.utils.ReflectUtils=var1487, r3=var2336, java.lang.reflect.Method=var257, org.apache.dubbo.common.utils.MethodUtils=var1206, r5=var337, java.lang.IllegalStateException=var2295, $r7=var3218, $r8=var2555, $r9=var3950, $r10=var964}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.Object;	r4 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.Object[];	r1 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] resolveTypes(java.lang.Object[])>(r2);	r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(r1, r4, r3);	if r5 != null goto z0 = virtualinvoke r5.<java.lang.reflect.Method: boolean isAccessible()>();	$r7 = new java.lang.IllegalStateException;	$r8 = newarray (java.lang.Object)[2];	$r8[0] = r4;	$r9 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r8[1] = $r9;	$r10 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("cannot find method %s,class: %s", $r8);	specialinvoke $r7.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r10);	throw $r7
;block_num 2