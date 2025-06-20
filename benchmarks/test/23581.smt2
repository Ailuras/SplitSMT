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

(declare-sort var2127 0)
(declare-sort var339 0)
(declare-sort var3829 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun methodName/-1585781850 (var2127) String)
(declare-fun parameterTypes/-1585781850 (var2127) (Array Int ClassObject))
(declare-fun var339_toString/-575966009 ((Array Int var3829)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3829__ ((Array Int ClassObject)) (Array Int var3829))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2127 var2127)
(declare-const var1028 var2127) ; Statement: r1 := @this: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var1028 null-var2127)))
(define-const var3818 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3818)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3818!1 String)
(assert (= var3818!1 ""))
(assert true)
(define-const var2785 String (append/672562846 var3818!1 "RpcInvocation [methodName=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RpcInvocation [methodName=") 
(declare-const var3818!2 String)
(assert (= var3818!2 (str.++ var3818!1 "RpcInvocation [methodName=")))
(define-const var2030 String (methodName/-1585781850 var1028)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String methodName> 
(assert true)
(define-const var1939 String (append/672562846 var2785 var2030)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2785!1 String)
(assert (= var2785!1 (str.++ var2785 var2030)))
(assert true)
(define-const var3749 String (append/672562846 var1939 ", parameterTypes=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=") 
(declare-const var1939!1 String)
(assert (= var1939!1 (str.++ var1939 ", parameterTypes=")))
(define-const var1896 (Array Int ClassObject) (parameterTypes/-1585781850 var1028)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] parameterTypes> 
(define-const var39 String (var339_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3829__ var1896))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5) 
(assert true)
(define-const var1321 String (append/672562846 var3749 var39)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3749!1 String)
(assert (= var3749!1 (str.++ var3749 var39)))
(assert true)
(define-const var35 String (append/672562846 var1321 "]")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var1321!1 String)
(assert (= var1321!1 (str.++ var1321 "]")))
(assert true)
(define-const var901 String (toString/-2075883882 var35)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), methodName/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), parameterTypes/-1585781850=([org.apache.dubbo.rpc.RpcInvocation], java.lang.Class[]), var339_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var3829__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2127=org.apache.dubbo.rpc.RpcInvocation, var1028=r1, var3818=$r0, var2785=$r3, var2030=$r2, var1939=$r4, var3749=$r7, var1896=$r5, var339=java.util.Arrays, var3829=java.lang.Object, var39=$r6, var1321=$r8, var35=$r9, var901=$r10}
; {org.apache.dubbo.rpc.RpcInvocation=var2127, r1=var1028, $r0=var3818, $r3=var2785, $r2=var2030, $r4=var1939, $r7=var3749, $r5=var1896, java.util.Arrays=var339, java.lang.Object=var3829, $r6=var39, $r8=var1321, $r9=var35, $r10=var901}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.RpcInvocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RpcInvocation [methodName=");	$r2 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String methodName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=");	$r5 = r1.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Class[] parameterTypes>;	$r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1