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

(declare-sort var2359 0)
(declare-sort var2822 0)
(declare-sort var2939 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun name/2041112302 (var2359) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun parameterTypes/2041112302 (var2359) (Array Int ClassObject))
(declare-fun var2822_toString/-575966009 ((Array Int var2939)) String)
(declare-fun cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2939__ ((Array Int ClassObject)) (Array Int var2939))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2359 var2359)
(declare-const var2616 var2359) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key 
(assert (not (= var2616 null-var2359)))
(define-const var878 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var878)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var878!1 String)
(assert (= var878!1 ""))
(define-const var1207 String (name/2041112302 var2616)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name> 
(assert true)
(define-const var1876 String (append/672562846 var878!1 var1207)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var878!2 String)
(assert (= var878!2 (str.++ var878!1 var1207)))
(define-const var493 (Array Int ClassObject) (parameterTypes/2041112302 var2616)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.Class[] parameterTypes> 
(define-const var1735 String (var2822_toString/-575966009 (cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2939__ var493))) ; Statement: $r4 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r3) 
(assert true)
(define-const var354 String (append/672562846 var1876 var1735)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1876!1 String)
(assert (= var1876!1 (str.++ var1876 var1735)))
(assert true)
(define-const var2142 String (toString/-2075883882 var354)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), name/2041112302=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), parameterTypes/2041112302=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key], java.lang.Class[]), var2822_toString/-575966009=([java.lang.Object[]], java.lang.String), cast-from-__Array__Int__ClassObject__-to-__Array__Int__var2939__=([java.lang.Class[]], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2359=org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key, var2616=r1, var878=$r0, var1207=$r2, var1876=$r5, var493=$r3, var2822=java.util.Arrays, var2939=java.lang.Object, var1735=$r4, var354=$r6, var2142=$r7}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key=var2359, r1=var2616, $r0=var878, $r2=var1207, $r5=var1876, $r3=var493, java.util.Arrays=var2822, java.lang.Object=var2939, $r4=var1735, $r6=var354, $r7=var2142}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.Arrays: java.lang.String toString(java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name>;	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.Class[] parameterTypes>;	$r4 = staticinvoke <java.util.Arrays: java.lang.String toString(java.lang.Object[])>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1