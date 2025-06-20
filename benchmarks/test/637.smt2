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

(declare-sort var3393 0)
(declare-sort var639 0)
(declare-sort var985 0)
(declare-sort var3125 0)
(declare-sort var506 0)
(declare-sort var2334 0)
(declare-sort var1128 0)
(declare-sort var2199 0)
(declare-sort var1926 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-950407827 (var2199) var1128)
(declare-fun cast-from-var3393-to-var2199 (var3393) var2199)
(declare-fun append/-1031950772 (String var1926) String)
(declare-fun cast-from-var1128-to-var1926 (var1128) var1926)
(declare-fun getMessage/849299655 (var506) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2334_error/377575788 (var2334 String String String String var506) void)
(declare-fun var985_emptyList/-142670980 () var985)
(declare-const null-var3393 var3393)
(declare-const null-var639 var639)
(declare-const null-var985 var985)
(declare-const null-var3125 var3125)
(declare-const null-var506 var506)
(declare-const var3393-logger var2334)
(declare-const var1689 var3393) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.directory.StaticDirectory 
(assert (not (= var1689 null-var3393)))
(declare-const var1382 var639) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain 
(assert (not (= var1382 null-var639)))
(declare-const var167 var985) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var167 null-var985)))
(declare-const var2128 var3125) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2128 null-var3125)))
 ; Statement: if r0 == null goto return r1 
(assert (not (= var1382 null-var639))) ; Negate: Cond: r0 == null  
(declare-const var794 var506) ; Statement: $r5 := @caughtexception 
(assert (not (= var794 null-var506)))
(define-const var1124 var2334 var3393-logger) ; Statement: $r7 = <org.apache.dubbo.rpc.cluster.directory.StaticDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var364 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var364)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var364!1 String)
(assert (= var364!1 ""))
(assert true)
(define-const var262 String (append/672562846 var364!1 "Failed to execute router: ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to execute router: ") 
(declare-const var364!2 String)
(assert (= var364!2 (str.++ var364!1 "Failed to execute router: ")))
(assert true)
(define-const var3810 var1128 (getUrl/-950407827 (cast-from-var3393-to-var2199 var1689))) ; Statement: $r8 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.directory.StaticDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2444 String (append/-1031950772 var262 (cast-from-var1128-to-var1926 var3810))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var262!1 String)
(assert (str.prefixof var262 var262!1))
(assert true)
(define-const var3349 String (append/672562846 var2444 ", cause: ")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var2444!1 String)
(assert (= var2444!1 (str.++ var2444 ", cause: ")))
(assert true)
(define-const var2241 String (getMessage/849299655 var794)) ; Statement: $r11 = virtualinvoke $r5.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2757 String (append/672562846 var3349 var2241)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3349!1 String)
(assert (= var3349!1 (str.++ var3349 var2241)))
(assert true)
(define-const var1238 String (toString/-2075883882 var2757)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2334_error/377575788 var1124 "2-1" "Failed to execute router" "" var1238 var794)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-1", "Failed to execute router", "", $r14, $r5) 

(declare-const var1124!1 var2334)
(declare-const var3893 String)
(declare-const var1680 String)
(declare-const var2465 String)
(declare-const var1238!1 String)
(declare-const var794!1 var506)
(define-const var834 var985 var985_emptyList/-142670980) ; Statement: $r15 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>() 
 ; Statement: return $r15 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-950407827=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var3393-to-var2199=([org.apache.dubbo.rpc.cluster.directory.StaticDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1128-to-var1926=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2334_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var985_emptyList/-142670980=([], org.apache.dubbo.rpc.cluster.router.state.BitList)}
; {var3393=org.apache.dubbo.rpc.cluster.directory.StaticDirectory, var1689=r2, var639=org.apache.dubbo.rpc.cluster.SingleRouterChain, var1382=r0, var985=org.apache.dubbo.rpc.cluster.router.state.BitList, var167=r1, var3125=org.apache.dubbo.rpc.Invocation, var2128=r3, var506=java.lang.Throwable, var794=$r5, var2334=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1124=$r7, var364=$r6, var262=$r9, var1128=org.apache.dubbo.common.URL, var2199=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var3810=$r8, var1926=java.lang.Object, var2444=$r10, var3349=$r12, var2241=$r11, var2757=$r13, var1238=$r14, var3893="2-1", var1680="Failed to execute router", var2465="", var834=$r15}
; {org.apache.dubbo.rpc.cluster.directory.StaticDirectory=var3393, r2=var1689, org.apache.dubbo.rpc.cluster.SingleRouterChain=var639, r0=var1382, org.apache.dubbo.rpc.cluster.router.state.BitList=var985, r1=var167, org.apache.dubbo.rpc.Invocation=var3125, r3=var2128, java.lang.Throwable=var506, $r5=var794, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2334, $r7=var1124, $r6=var364, $r9=var262, org.apache.dubbo.common.URL=var1128, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2199, $r8=var3810, java.lang.Object=var1926, $r10=var2444, $r12=var3349, $r11=var2241, $r13=var2757, $r14=var1238, "2-1"=var3893, "Failed to execute router"=var1680, ""=var2465, $r15=var834}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.directory.StaticDirectory;	r0 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain;	r1 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList;	r3 := @parameter2: org.apache.dubbo.rpc.Invocation;	if r0 == null goto return r1;	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.rpc.cluster.directory.StaticDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to execute router: ");	$r8 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.directory.StaticDirectory: org.apache.dubbo.common.URL getUrl()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r11 = virtualinvoke $r5.<java.lang.Throwable: java.lang.String getMessage()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-1", "Failed to execute router", "", $r14, $r5);	$r15 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>();	return $r15
;block_num 2