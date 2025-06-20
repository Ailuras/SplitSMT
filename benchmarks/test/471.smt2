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

(declare-sort var2414 0)
(declare-sort var2739 0)
(declare-sort var3310 0)
(declare-sort var3492 0)
(declare-sort var3620 0)
(declare-sort var3275 0)
(declare-sort var1801 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun invokers/-1359601043 (var2414) var3310)
(declare-fun getOriginList/530008015 (var3310) var3620)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3620_size/-959786421 (var3620) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3275_error/-110665684 (var3275 String String String String) void)
(declare-fun var1801-init () var1801)
(declare-fun <init>/-1092629202 (var1801 String) void)
(declare-const null-var2414 var2414)
(declare-const null-var2739 var2739)
(declare-const null-var3310 var3310)
(declare-const null-var3492 var3492)
(declare-const var2414-logger var3275)
(declare-const var2838 var2414) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.SingleRouterChain 
(assert (not (= var2838 null-var2414)))
(declare-const var3082 var2739) ; Statement: r6 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3082 null-var2739)))
(declare-const var1717 var3310) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var1717 null-var3310)))
(declare-const var2479 var3492) ; Statement: r7 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2479 null-var3492)))
(define-const var2002 var3310 (invokers/-1359601043 var2838)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.rpc.cluster.router.state.BitList invokers> 
(assert true)
(define-const var1918 var3620 (getOriginList/530008015 var2002)) ; Statement: $r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>() 
(assert true)
(define-const var3943 var3620 (getOriginList/530008015 var1717)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>() 
 ; Statement: if $r4 == $r3 goto $r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (not (= var1918 var3943))) ; Negate: Cond: $r4 == $r3  
(define-const var1608 var3275 var2414-logger) ; Statement: $r11 = <org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1956 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1956)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1956!1 String)
(assert (= var1956!1 ""))
(assert true)
(define-const var869 String (append/672562846 var1956!1 "Router\u0027s invoker size: ")) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Router\'s invoker size: ") 
(declare-const var1956!2 String)
(assert (= var1956!2 (str.++ var1956!1 "Router\u0027s invoker size: ")))
(define-const var3916 var3310 (invokers/-1359601043 var2838)) ; Statement: $r12 = r0.<org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.rpc.cluster.router.state.BitList invokers> 
(assert true)
(define-const var3848 var3620 (getOriginList/530008015 var3916)) ; Statement: $r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>() 
(define-const var2740 Int (var3620_size/-959786421 var3848)) ; Statement: $i0 = interfaceinvoke $r13.<java.util.List: int size()>() 
(assert true)
(define-const var865 String (append/-1001720160 var869 var2740)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var869!1 String)
(assert (str.prefixof var869 var869!1))
(assert true)
(define-const var3144 String (append/672562846 var865 " Invocation\u0027s invoker size: ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Invocation\'s invoker size: ") 
(declare-const var865!1 String)
(assert (= var865!1 (str.++ var865 " Invocation\u0027s invoker size: ")))
(assert true)
(define-const var3649 var3620 (getOriginList/530008015 var1717)) ; Statement: $r16 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>() 
(define-const var1875 Int (var3620_size/-959786421 var3649)) ; Statement: $i1 = interfaceinvoke $r16.<java.util.List: int size()>() 
(assert true)
(define-const var2416 String (append/-1001720160 var3144 var1875)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1) 
(declare-const var3144!1 String)
(assert (str.prefixof var3144 var3144!1))
(assert true)
(define-const var73 String (toString/-2075883882 var2416)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3275_error/-110665684 var1608 "99-0" "" var73 "Reject to route, because the invokers has changed.")) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "", $r19, "Reject to route, because the invokers has changed.") 

(declare-const var1608!1 var3275)
(declare-const var2910 String)
(declare-const var1825 String)
(declare-const var73!1 String)
(declare-const var2901 String)
(define-const var728 var1801 var1801-init) ; Statement: $r20 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var728 "reject to route, because the invokers has changed.")) ; Statement: specialinvoke $r20.<java.lang.IllegalStateException: void <init>(java.lang.String)>("reject to route, because the invokers has changed.") 

(declare-const var728!1 var1801)
(declare-const var125 String)
 ; Statement: throw $r20 
(check-sat)
; {invokers/-1359601043=([org.apache.dubbo.rpc.cluster.SingleRouterChain], org.apache.dubbo.rpc.cluster.router.state.BitList), getOriginList/530008015=([org.apache.dubbo.rpc.cluster.router.state.BitList], java.util.List), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3620_size/-959786421=([java.util.List], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3275_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), var1801-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2414=org.apache.dubbo.rpc.cluster.SingleRouterChain, var2838=r0, var2739=org.apache.dubbo.common.URL, var3082=r6, var3310=org.apache.dubbo.rpc.cluster.router.state.BitList, var1717=r2, var3492=org.apache.dubbo.rpc.Invocation, var2479=r7, var2002=$r1, var3620=java.util.List, var1918=$r4, var3943=$r3, var3275=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1608=$r11, var1956=$r10, var869=$r14, var3916=$r12, var3848=$r13, var2740=$i0, var865=$r15, var3144=$r17, var3649=$r16, var1875=$i1, var2416=$r18, var73=$r19, var2910="99-0", var1825="", var2901="Reject to route, because the invokers has changed.", var1801=java.lang.IllegalStateException, var728=$r20, var125="reject to route, because the invokers has changed."}
; {org.apache.dubbo.rpc.cluster.SingleRouterChain=var2414, r0=var2838, org.apache.dubbo.common.URL=var2739, r6=var3082, org.apache.dubbo.rpc.cluster.router.state.BitList=var3310, r2=var1717, org.apache.dubbo.rpc.Invocation=var3492, r7=var2479, $r1=var2002, java.util.List=var3620, $r4=var1918, $r3=var3943, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3275, $r11=var1608, $r10=var1956, $r14=var869, $r12=var3916, $r13=var3848, $i0=var2740, $r15=var865, $r17=var3144, $r16=var3649, $i1=var1875, $r18=var2416, $r19=var73, "99-0"=var2910, ""=var1825, "Reject to route, because the invokers has changed."=var2901, java.lang.IllegalStateException=var1801, $r20=var728, "reject to route, because the invokers has changed."=var125}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.SingleRouterChain;	r6 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList;	r7 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = r0.<org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.rpc.cluster.router.state.BitList invokers>;	$r4 = virtualinvoke $r1.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>();	$r3 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>();	if $r4 == $r3 goto $r5 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r11 = <org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Router\'s invoker size: ");	$r12 = r0.<org.apache.dubbo.rpc.cluster.SingleRouterChain: org.apache.dubbo.rpc.cluster.router.state.BitList invokers>;	$r13 = virtualinvoke $r12.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>();	$i0 = interfaceinvoke $r13.<java.util.List: int size()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Invocation\'s invoker size: ");	$r16 = virtualinvoke r2.<org.apache.dubbo.rpc.cluster.router.state.BitList: java.util.List getOriginList()>();	$i1 = interfaceinvoke $r16.<java.util.List: int size()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i1);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "", $r19, "Reject to route, because the invokers has changed.");	$r20 = new java.lang.IllegalStateException;	specialinvoke $r20.<java.lang.IllegalStateException: void <init>(java.lang.String)>("reject to route, because the invokers has changed.");	throw $r20
;block_num 2