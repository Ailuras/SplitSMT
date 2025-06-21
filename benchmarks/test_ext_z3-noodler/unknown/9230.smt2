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

(declare-sort var3465 0)
(declare-sort var1679 0)
(declare-sort var797 0)
(declare-sort var2772 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun methodName/306834173 (var3465) String)
(declare-fun parameterTypes/306834173 (var3465) (Array Int ClassObject))
(declare-fun var1679_toString/-575966009 ((Array Int var797)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var797__ ((Array Int ClassObject)) (Array Int var797))
(declare-fun arguments/306834173 (var3465) (Array Int var797))
(declare-fun attachments/306834173 (var3465) var2772)
(declare-fun append/-1031950772 (String var797) String)
(declare-fun cast-from-var2772-to-var797 (var2772) var797)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3465 var3465)
(declare-const var1112 var3465) ; Statement: r1 := @this: com.alibaba.dubbo.rpc.RpcInvocation 
(assert (not (= var1112 null-var3465)))
(define-const var3623 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3623)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3623!1 String)
(assert (= var3623!1 ""))
(assert true)
(define-const var3965 String (append/672562846 var3623!1 "RpcInvocation [methodName=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RpcInvocation [methodName=") 
(declare-const var3623!2 String)
(assert (= var3623!2 (str.++ var3623!1 "RpcInvocation [methodName=")))
(define-const var576 String (methodName/306834173 var1112)) ; Statement: $r2 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.String methodName> 
(assert true)
(define-const var2113 String (append/672562846 var3965 var576)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3965!1 String)
(assert (= var3965!1 (str.++ var3965 var576)))
(assert true)
(define-const var2529 String (append/672562846 var2113 ", parameterTypes=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=") 
(declare-const var2113!1 String)
(assert (= var2113!1 (str.++ var2113 ", parameterTypes=")))
(define-const var3018 (Array Int ClassObject) (parameterTypes/306834173 var1112)) ; Statement: $r5 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.Class[] parameterTypes> 
(define-const var63 String (var1679_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var797__ var3018))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5) 
(assert true)
(define-const var3074 String (append/672562846 var2529 var63)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2529!1 String)
(assert (= var2529!1 (str.++ var2529 var63)))
(assert true)
(define-const var1406 String (append/672562846 var3074 ", arguments=")) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", arguments=") 
(declare-const var3074!1 String)
(assert (= var3074!1 (str.++ var3074 ", arguments=")))
(define-const var2091 (Array Int var797) (arguments/306834173 var1112)) ; Statement: $r9 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.Object[] arguments> 
(define-const var3032 String (var1679_toString/-575966009 var2091)) ; Statement: $r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r9) 
(assert true)
(define-const var1446 String (append/672562846 var1406 var3032)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1406!1 String)
(assert (= var1406!1 (str.++ var1406 var3032)))
(assert true)
(define-const var2276 String (append/672562846 var1446 ", attachments=")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", attachments=") 
(declare-const var1446!1 String)
(assert (= var1446!1 (str.++ var1446 ", attachments=")))
(define-const var3327 var2772 (attachments/306834173 var1112)) ; Statement: $r13 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.util.Map attachments> 
(assert true)
(define-const var3481 String (append/-1031950772 var2276 (cast-from-var2772-to-var797 var3327))) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var2276!1 String)
(assert (str.prefixof var2276 var2276!1))
(assert true)
(define-const var2889 String (append/672562846 var3481 "]")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3481!1 String)
(assert (= var3481!1 (str.++ var3481 "]")))
(assert true)
(define-const var597 String (toString/-2075883882 var2889)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r17 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), methodName/306834173=([com.alibaba.dubbo.rpc.RpcInvocation], java.lang.String), parameterTypes/306834173=([com.alibaba.dubbo.rpc.RpcInvocation], java.lang.Class[]), var1679_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var797__=([java.lang.Class[]], java.lang.Object[]), arguments/306834173=([com.alibaba.dubbo.rpc.RpcInvocation], java.lang.Object[]), attachments/306834173=([com.alibaba.dubbo.rpc.RpcInvocation], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2772-to-var797=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3465=com.alibaba.dubbo.rpc.RpcInvocation, var1112=r1, var3623=$r0, var3965=$r3, var576=$r2, var2113=$r4, var2529=$r7, var3018=$r5, var1679=java.util.Arrays, var797=java.lang.Object, var63=$r6, var3074=$r8, var1406=$r11, var2091=$r9, var3032=$r10, var1446=$r12, var2276=$r14, var2772=java.util.Map, var3327=$r13, var3481=$r15, var2889=$r16, var597=$r17}
; {com.alibaba.dubbo.rpc.RpcInvocation=var3465, r1=var1112, $r0=var3623, $r3=var3965, $r2=var576, $r4=var2113, $r7=var2529, $r5=var3018, java.util.Arrays=var1679, java.lang.Object=var797, $r6=var63, $r8=var3074, $r11=var1406, $r9=var2091, $r10=var3032, $r12=var1446, $r14=var2276, java.util.Map=var2772, $r13=var3327, $r15=var3481, $r16=var2889, $r17=var597}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: com.alibaba.dubbo.rpc.RpcInvocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RpcInvocation [methodName=");	$r2 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.String methodName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", parameterTypes=");	$r5 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.Class[] parameterTypes>;	$r6 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", arguments=");	$r9 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.lang.Object[] arguments>;	$r10 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", attachments=");	$r13 = r1.<com.alibaba.dubbo.rpc.RpcInvocation: java.util.Map attachments>;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	return $r17
;block_num 1