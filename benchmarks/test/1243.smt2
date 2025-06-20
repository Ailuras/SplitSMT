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

(declare-sort var125 0)
(declare-sort var3558 0)
(declare-sort var483 0)
(declare-sort var95 0)
(declare-sort var789 0)
(declare-sort var1818 0)
(declare-sort var899 0)
(declare-sort var1495 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-1753441051 (var125) var483)
(declare-fun var95_getMethodName/-516674313 (var3558) String)
(declare-fun toString/1090915316 (var789) String)
(declare-fun getMethodParameter/271412369 (var483 String String String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1818_isEmpty/-1425963210 (String) Bool)
(declare-fun invoker/449019207 (var125) var899)
(declare-fun var899_invoke/-1860754555 (var899 var3558) var1495)
(declare-const null-var125 var125)
(declare-const null-var3558 var3558)
(declare-const var789-FALSE var789)
(declare-const var1832 var125) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker 
(assert (not (= var1832 null-var125)))
(declare-const var2010 var3558) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2010 null-var3558)))
(assert true)
(define-const var1803 var483 (getUrl/-1753441051 var1832)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var1684 String (var95_getMethodName/-516674313 var2010)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1) 
(define-const var286 var789 var789-FALSE) ; Statement: $r2 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var1727 String (toString/1090915316 var286)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var1179 String (getMethodParameter/271412369 var1803 var1684 "mock" var1727)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r4, "mock", $r3) 
(assert true)
(define-const var2360 String (trim/-847153721 var1179)) ; Statement: r7 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>() 
(define-const var1371 Bool (var1818_isEmpty/-1425963210 var2360)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("force") 
(assert (not (= (ite var1371 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1530 var899 (invoker/449019207 var1832)) ; Statement: $r22 = r0.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.Invoker invoker> 
(define-const var3679 var1495 (var899_invoke/-1860754555 var1530 var2010)) ; Statement: r34 = interfaceinvoke $r22.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r1) 
 ; Statement: goto [?= return r34] 
(assert true) ; Non Conditional
 ; Statement: return r34 
(check-sat)
; {getUrl/-1753441051=([org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker], org.apache.dubbo.common.URL), var95_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/1090915316=([java.lang.Boolean], java.lang.String), getMethodParameter/271412369=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1818_isEmpty/-1425963210=([java.lang.String], boolean), invoker/449019207=([org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker], org.apache.dubbo.rpc.Invoker), var899_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var125=org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker, var1832=r0, var3558=org.apache.dubbo.rpc.Invocation, var2010=r1, var483=org.apache.dubbo.common.URL, var1803=$r5, var95=org.apache.dubbo.rpc.support.RpcUtils, var1684=$r4, var789=java.lang.Boolean, var286=$r2, var1727=$r3, var1179=$r6, var2360=r7, var1818=org.apache.dubbo.common.utils.ConfigUtils, var1371=$z0, var899=org.apache.dubbo.rpc.Invoker, var1530=$r22, var1495=org.apache.dubbo.rpc.Result, var3679=r34}
; {org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker=var125, r0=var1832, org.apache.dubbo.rpc.Invocation=var3558, r1=var2010, org.apache.dubbo.common.URL=var483, $r5=var1803, org.apache.dubbo.rpc.support.RpcUtils=var95, $r4=var1684, java.lang.Boolean=var789, $r2=var286, $r3=var1727, $r6=var1179, r7=var2360, org.apache.dubbo.common.utils.ConfigUtils=var1818, $z0=var1371, org.apache.dubbo.rpc.Invoker=var899, $r22=var1530, org.apache.dubbo.rpc.Result=var1495, r34=var3679}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker;	r1 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r5 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r4 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1);	$r2 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r2.<java.lang.Boolean: java.lang.String toString()>();	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String,java.lang.String)>($r4, "mock", $r3);	r7 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean isEmpty(java.lang.String)>(r7);	if $z0 == 0 goto $z1 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("force");	$r22 = r0.<org.apache.dubbo.rpc.cluster.support.wrapper.MockClusterInvoker: org.apache.dubbo.rpc.Invoker invoker>;	r34 = interfaceinvoke $r22.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r1);	goto [?= return r34];	return r34
;block_num 3