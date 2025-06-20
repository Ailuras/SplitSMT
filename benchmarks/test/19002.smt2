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

(declare-sort var197 0)
(declare-sort var1444 0)
(declare-sort var546 0)
(declare-sort var3277 0)
(declare-sort var1483 0)
(declare-sort var3329 0)
(declare-sort var1555 0)
(declare-sort var1971 0)
(declare-sort var1867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1483_getUrl/-275947851 (var1483) var3277)
(declare-fun cast-from-var1444-to-var1483 (var1444) var1483)
(declare-fun var3329_getMethodName/-516674313 (var546) String)
(declare-fun getMethodParameter/-364685573 (var3277 String String Int) Int)
(declare-fun var1555_beginCount/1790217559 (var3277 String Int) Bool)
(declare-fun var1971-init () var1971)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1867) String)
(declare-fun cast-from-var3277-to-var1867 (var3277) var1867)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1027821060 (var1971 Int String) void)
(declare-const null-var197 var197)
(declare-const null-var1444 var1444)
(declare-const null-var546 var546)
(declare-const var2269 var197) ; Statement: r20 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter 
(assert (not (= var2269 null-var197)))
(declare-const var1607 var1444) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1607 null-var1444)))
(declare-const var2102 var546) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2102 null-var546)))
(define-const var3655 var3277 (var1483_getUrl/-275947851 (cast-from-var1444-to-var1483 var1607))) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var2700 String (var3329_getMethodName/-516674313 var2102)) ; Statement: r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert true)
(define-const var354 Int (getMethodParameter/-364685573 var3655 var2700 "executes" 0)) ; Statement: i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getMethodParameter(java.lang.String,java.lang.String,int)>(r3, "executes", 0) 
(define-const var2528 Bool (var1555_beginCount/1790217559 var3655 var2700 var354)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.RpcStatus: boolean beginCount(org.apache.dubbo.common.URL,java.lang.String,int)>(r1, r3, i0) 
 ; Statement: if $z0 != 0 goto $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(assert (not (not (= (ite var2528 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2684 var1971 var1971-init) ; Statement: $r6 = new org.apache.dubbo.rpc.RpcException 
(define-const var2324 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2324)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2324!1 String)
(assert (= var2324!1 ""))
(assert true)
(define-const var3229 String (append/672562846 var2324!1 "Failed to invoke method ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke method ") 
(declare-const var2324!2 String)
(assert (= var2324!2 (str.++ var2324!1 "Failed to invoke method ")))
(define-const var356 String (var3329_getMethodName/-516674313 var2102)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2) 
(assert true)
(define-const var3879 String (append/672562846 var3229 var356)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var3229!1 String)
(assert (= var3229!1 (str.++ var3229 var356)))
(assert true)
(define-const var3232 String (append/672562846 var3879 " in provider ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in provider ") 
(declare-const var3879!1 String)
(assert (= var3879!1 (str.++ var3879 " in provider ")))
(assert true)
(define-const var3423 String (append/-1031950772 var3232 (cast-from-var3277-to-var1867 var3655))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3232!1 String)
(assert (str.prefixof var3232 var3232!1))
(assert true)
(define-const var598 String (append/672562846 var3423 ", cause: The service using threads greater than <dubbo:service executes=\u0022")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The service using threads greater than <dubbo:service executes=\"") 
(declare-const var3423!1 String)
(assert (= var3423!1 (str.++ var3423 ", cause: The service using threads greater than <dubbo:service executes=\u0022")))
(assert true)
(define-const var1245 String (append/-1001720160 var598 var354)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var598!1 String)
(assert (str.prefixof var598 var598!1))
(assert true)
(define-const var2619 String (append/672562846 var1245 "\u0022 /> limited.")) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" /> limited.") 
(declare-const var1245!1 String)
(assert (= var1245!1 (str.++ var1245 "\u0022 /> limited.")))
(assert true)
(define-const var755 String (toString/-2075883882 var2619)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1027821060 var2684 7 var755)) ; Statement: specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(7, $r16) 

(declare-const var2684!1 var1971)
(declare-const var2068 Int)
(declare-const var755!1 String)
 ; Statement: throw $r6 
(check-sat)
; {var1483_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1444-to-var1483=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), var3329_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMethodParameter/-364685573=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, int], int), var1555_beginCount/1790217559=([org.apache.dubbo.common.URL, java.lang.String, int], boolean), var1971-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3277-to-var1867=([org.apache.dubbo.common.URL], java.lang.Object), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1027821060=([org.apache.dubbo.rpc.RpcException, int, java.lang.String], void)}
; {var197=org.apache.dubbo.rpc.filter.ExecuteLimitFilter, var2269=r20, var1444=org.apache.dubbo.rpc.Invoker, var1607=r0, var546=org.apache.dubbo.rpc.Invocation, var2102=r2, var3277=org.apache.dubbo.common.URL, var1483=org.apache.dubbo.common.Node, var3655=r1, var3329=org.apache.dubbo.rpc.support.RpcUtils, var2700=r3, var354=i0, var1555=org.apache.dubbo.rpc.RpcStatus, var2528=$z0, var1971=org.apache.dubbo.rpc.RpcException, var2684=$r6, var2324=$r7, var3229=$r9, var356=$r8, var3879=$r10, var3232=$r11, var1867=java.lang.Object, var3423=$r12, var598=$r13, var1245=$r14, var2619=$r15, var755=$r16, var2068=7}
; {org.apache.dubbo.rpc.filter.ExecuteLimitFilter=var197, r20=var2269, org.apache.dubbo.rpc.Invoker=var1444, r0=var1607, org.apache.dubbo.rpc.Invocation=var546, r2=var2102, org.apache.dubbo.common.URL=var3277, org.apache.dubbo.common.Node=var1483, r1=var3655, org.apache.dubbo.rpc.support.RpcUtils=var3329, r3=var2700, i0=var354, org.apache.dubbo.rpc.RpcStatus=var1555, $z0=var2528, org.apache.dubbo.rpc.RpcException=var1971, $r6=var2684, $r7=var2324, $r9=var3229, $r8=var356, $r10=var3879, $r11=var3232, java.lang.Object=var1867, $r12=var3423, $r13=var598, $r14=var1245, $r15=var2619, $r16=var755, 7=var2068}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r20 := @this: org.apache.dubbo.rpc.filter.ExecuteLimitFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r2 := @parameter1: org.apache.dubbo.rpc.Invocation;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r3 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	i0 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getMethodParameter(java.lang.String,java.lang.String,int)>(r3, "executes", 0);	$z0 = staticinvoke <org.apache.dubbo.rpc.RpcStatus: boolean beginCount(org.apache.dubbo.common.URL,java.lang.String,int)>(r1, r3, i0);	if $z0 != 0 goto $l1 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r6 = new org.apache.dubbo.rpc.RpcException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to invoke method ");	$r8 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r2);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" in provider ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The service using threads greater than <dubbo:service executes=\"");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\" /> limited.");	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(7, $r16);	throw $r6
;block_num 2