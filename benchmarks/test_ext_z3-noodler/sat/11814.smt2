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

(declare-sort var1384 0)
(declare-sort var3316 0)
(declare-sort var1761 0)
(declare-sort var3103 0)
(declare-sort var3883 0)
(declare-sort var674 0)
(declare-sort var1461 0)
(declare-sort var3565 0)
(declare-sort var2569 0)
(declare-sort var2955 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2569_getUrl/-275947851 (var2569) var3565)
(declare-fun cast-from-var3316-to-var2569 (var3316) var2569)
(declare-fun append/-1031950772 (String var2955) String)
(declare-fun cast-from-var3565-to-var2955 (var3565) var2955)
(declare-fun getMessage/849299655 (var674) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1461_warn/126438324 (var1461 String String String String var674) void)
(declare-const null-var1384 var1384)
(declare-const null-var3316 var3316)
(declare-const null-var1761 var1761)
(declare-const null-var3103 var3103)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-var674 var674)
(declare-const var1384-logger var1461)
(declare-const var2971 var1384) ; Statement: r2 := @this: org.apache.dubbo.monitor.support.MonitorFilter 
(assert (not (= var2971 null-var1384)))
(declare-const var1301 var3316) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1301 null-var3316)))
(declare-const var3187 var1761) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3187 null-var1761)))
(declare-const var1495 var3103) ; Statement: r7 := @parameter2: org.apache.dubbo.rpc.Result 
(assert (not (= var1495 null-var3103)))
(declare-const var131 String) ; Statement: r8 := @parameter3: java.lang.String 
(assert (not (= var131 null-String)))
(declare-const var1821 Int) ; Statement: l0 := @parameter4: long 
(assert (not (= var1821 null-Int)))
(declare-const var3057 Bool) ; Statement: z1 := @parameter5: boolean 
(assert (not (= var3057 null-Bool)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3750 var674) ; Statement: $r11 := @caughtexception 
(assert (not (= var3750 null-var674)))
(define-const var3336 var1461 var1384-logger) ; Statement: $r13 = <org.apache.dubbo.monitor.support.MonitorFilter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3490 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3490)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3490!1 String)
(assert (= var3490!1 ""))
(assert true)
(define-const var3351 String (append/672562846 var3490!1 "Failed to monitor count service ")) ; Statement: $r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to monitor count service ") 
(declare-const var3490!2 String)
(assert (= var3490!2 (str.++ var3490!1 "Failed to monitor count service ")))
(define-const var1768 var3565 (var2569_getUrl/-275947851 (cast-from-var3316-to-var2569 var1301))) ; Statement: $r14 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2970 String (append/-1031950772 var3351 (cast-from-var3565-to-var2955 var1768))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var3351!1 String)
(assert (str.prefixof var3351 var3351!1))
(assert true)
(define-const var3286 String (append/672562846 var2970 ", cause: ")) ; Statement: $r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2970!1 String)
(assert (= var2970!1 (str.++ var2970 ", cause: ")))
(assert true)
(define-const var757 String (getMessage/849299655 var3750)) ; Statement: $r17 = virtualinvoke $r11.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3019 String (append/672562846 var3286 var757)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3286!1 String)
(assert (= var3286!1 (str.++ var3286 var757)))
(assert true)
(define-const var3325 String (toString/-2075883882 var3019)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1461_warn/126438324 var3336 "0-14" "" "" var3325 var3750)) ; Statement: interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-14", "", "", $r20, $r11) 

(declare-const var3336!1 var1461)
(declare-const var3572 String)
(declare-const var2185 String)
(declare-const var2185!1 String)
(declare-const var3325!1 String)
(declare-const var3750!1 var674)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2569_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3316-to-var2569=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3565-to-var2955=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1461_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1384=org.apache.dubbo.monitor.support.MonitorFilter, var2971=r2, var3316=org.apache.dubbo.rpc.Invoker, var1301=r0, var1761=org.apache.dubbo.rpc.Invocation, var3187=r6, var3103=org.apache.dubbo.rpc.Result, var1495=r7, var131=r8, var3883=null_type, var1821=l0, var3057=z1, var674=java.lang.Throwable, var3750=$r11, var1461=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3336=$r13, var3490=$r12, var3351=$r15, var3565=org.apache.dubbo.common.URL, var2569=org.apache.dubbo.common.Node, var1768=$r14, var2955=java.lang.Object, var2970=$r16, var3286=$r18, var757=$r17, var3019=$r19, var3325=$r20, var3572="0-14", var2185=""}
; {org.apache.dubbo.monitor.support.MonitorFilter=var1384, r2=var2971, org.apache.dubbo.rpc.Invoker=var3316, r0=var1301, org.apache.dubbo.rpc.Invocation=var1761, r6=var3187, org.apache.dubbo.rpc.Result=var3103, r7=var1495, r8=var131, null_type=var3883, l0=var1821, z1=var3057, java.lang.Throwable=var674, $r11=var3750, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1461, $r13=var3336, $r12=var3490, $r15=var3351, org.apache.dubbo.common.URL=var3565, org.apache.dubbo.common.Node=var2569, $r14=var1768, java.lang.Object=var2955, $r16=var2970, $r18=var3286, $r17=var757, $r19=var3019, $r20=var3325, "0-14"=var3572, ""=var2185}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.monitor.support.MonitorFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r6 := @parameter1: org.apache.dubbo.rpc.Invocation;	r7 := @parameter2: org.apache.dubbo.rpc.Result;	r8 := @parameter3: java.lang.String;	l0 := @parameter4: long;	z1 := @parameter5: boolean;	$r11 := @caughtexception;	$r13 = <org.apache.dubbo.monitor.support.MonitorFilter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r15 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to monitor count service ");	$r14 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r18 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r17 = virtualinvoke $r11.<java.lang.Throwable: java.lang.String getMessage()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r13.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-14", "", "", $r20, $r11);	return
;block_num 3