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

(declare-sort var2046 0)
(declare-sort var2986 0)
(declare-sort var3862 0)
(declare-sort var73 0)
(declare-sort var1731 0)
(declare-sort var778 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1731-init () var1731)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var778) String)
(declare-fun cast-from-ClassObject-to-var778 (ClassObject) var778)
(declare-fun var3862_getMethodName/-888969971 (var3862) String)
(declare-fun getMessage/849299655 (var73) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1731 String var73) void)
(declare-fun getErrorCode/1811306288 (var2046 var73) Int)
(declare-fun setCode/842424770 (var1731 Int) void)
(declare-const null-var2046 var2046)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2986 var2986)
(declare-const null-var3862 var3862)
(declare-const null-var73 var73)
(declare-const var3704 var2046) ; Statement: r14 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol 
(assert (not (= var3704 null-var2046)))
(declare-const var2357 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var2357 null-ClassObject)))
(declare-const var144 var2986) ; Statement: r15 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var144 null-var2986)))
(declare-const var2113 var3862) ; Statement: r5 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2113 null-var3862)))
(declare-const var2869 var73) ; Statement: r9 := @parameter3: java.lang.Throwable 
(assert (not (= var2869 null-var73)))
(define-const var2071 var1731 var1731-init) ; Statement: $r0 = new org.apache.dubbo.rpc.RpcException 
(define-const var1806 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1806)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1806!1 String)
(assert (= var1806!1 ""))
(assert true)
(define-const var1752 String (append/672562846 var1806!1 "Failed to invoke remote service: ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke remote service: ") 
(declare-const var1806!2 String)
(assert (= var1806!2 (str.++ var1806!1 "Failed to invoke remote service: ")))
(assert true)
(define-const var1849 String (append/-1031950772 var1752 (cast-from-ClassObject-to-var778 var2357))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2) 
(declare-const var1752!1 String)
(assert (str.prefixof var1752 var1752!1))
(assert true)
(define-const var1245 String (append/672562846 var1849 ", method: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ") 
(declare-const var1849!1 String)
(assert (= var1849!1 (str.++ var1849 ", method: ")))
(define-const var1349 String (var3862_getMethodName/-888969971 var2113)) ; Statement: $r6 = interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1582 String (append/672562846 var1245 var1349)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1245!1 String)
(assert (= var1245!1 (str.++ var1245 var1349)))
(assert true)
(define-const var1705 String (append/672562846 var1582 ", cause: ")) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1582!1 String)
(assert (= var1582!1 (str.++ var1582 ", cause: ")))
(assert true)
(define-const var1579 String (getMessage/849299655 var2869)) ; Statement: $r10 = virtualinvoke r9.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2043 String (append/672562846 var1705 var1579)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1705!1 String)
(assert (= var1705!1 (str.++ var1705 var1579)))
(assert true)
(define-const var677 String (toString/-2075883882 var2043)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var2071 var677 var2869)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r13, r9) 

(declare-const var2071!1 var1731)
(declare-const var677!1 String)
(declare-const var2869!1 var73)
(assert true)
(define-const var1241 Int (getErrorCode/1811306288 var3704 var2869!1)) ; Statement: $i0 = virtualinvoke r14.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol: int getErrorCode(java.lang.Throwable)>(r9) 
(assert true)
;(assert (setCode/842424770 var2071!1 var1241)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.RpcException: void setCode(int)>($i0) 

(declare-const var2071!2 var1731)
(declare-const var1241!1 Int)
 ; Statement: return $r0 
(check-sat)
; {var1731-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var778=([java.lang.Class], java.lang.Object), var3862_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void), getErrorCode/1811306288=([org.apache.dubbo.rpc.protocol.AbstractProxyProtocol, java.lang.Throwable], int), setCode/842424770=([org.apache.dubbo.rpc.RpcException, int], void)}
; {var2046=org.apache.dubbo.rpc.protocol.AbstractProxyProtocol, var3704=r14, var2357=r2, var2986=org.apache.dubbo.common.URL, var144=r15, var3862=org.apache.dubbo.rpc.Invocation, var2113=r5, var73=java.lang.Throwable, var2869=r9, var1731=org.apache.dubbo.rpc.RpcException, var2071=$r0, var1806=$r1, var1752=$r3, var778=java.lang.Object, var1849=$r4, var1245=$r7, var1349=$r6, var1582=$r8, var1705=$r11, var1579=$r10, var2043=$r12, var677=$r13, var1241=$i0}
; {org.apache.dubbo.rpc.protocol.AbstractProxyProtocol=var2046, r14=var3704, r2=var2357, org.apache.dubbo.common.URL=var2986, r15=var144, org.apache.dubbo.rpc.Invocation=var3862, r5=var2113, java.lang.Throwable=var73, r9=var2869, org.apache.dubbo.rpc.RpcException=var1731, $r0=var2071, $r1=var1806, $r3=var1752, java.lang.Object=var778, $r4=var1849, $r7=var1245, $r6=var1349, $r8=var1582, $r11=var1705, $r10=var1579, $r12=var2043, $r13=var677, $i0=var1241}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r14 := @this: org.apache.dubbo.rpc.protocol.AbstractProxyProtocol;	r2 := @parameter0: java.lang.Class;	r15 := @parameter1: org.apache.dubbo.common.URL;	r5 := @parameter2: org.apache.dubbo.rpc.Invocation;	r9 := @parameter3: java.lang.Throwable;	$r0 = new org.apache.dubbo.rpc.RpcException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke remote service: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r2);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method: ");	$r6 = interfaceinvoke r5.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r10 = virtualinvoke r9.<java.lang.Throwable: java.lang.String getMessage()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r13, r9);	$i0 = virtualinvoke r14.<org.apache.dubbo.rpc.protocol.AbstractProxyProtocol: int getErrorCode(java.lang.Throwable)>(r9);	virtualinvoke $r0.<org.apache.dubbo.rpc.RpcException: void setCode(int)>($i0);	return $r0
;block_num 1