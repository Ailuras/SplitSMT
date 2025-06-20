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

(declare-sort var2084 0)
(declare-sort var1480 0)
(declare-sort var1508 0)
(declare-sort var3077 0)
(declare-sort var885 0)
(declare-sort var1422 0)
(declare-sort var2388 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/506106603 (var1480 String String) String)
(declare-fun var1508_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var885-init () var885)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1422) String)
(declare-fun cast-from-var1480-to-var1422 (var1480) var1422)
(declare-fun getMessage/849299655 (var2388) String)
(declare-fun cast-from-var3077-to-var2388 (var3077) var2388)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var885 String var2388) void)
(declare-const null-var2084 var2084)
(declare-const null-var1480 var1480)
(declare-const null-var3077 var3077)
(declare-const var3305 var2084) ; Statement: r9 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var3305 null-var2084)))
(declare-const var2070 var1480) ; Statement: r38 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2070 null-var1480)))
(assert true)
(define-const var2264 String (getParameter/506106603 var2070 "server" "netty")) ; Statement: $r0 = virtualinvoke r38.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty") 
(assert true)
(define-const var3006 String (getParameter/506106603 var2070 "client" var2264)) ; Statement: r1 = virtualinvoke r38.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("client", $r0) 
(define-const var2014 Bool (var1508_isNotEmpty/-1251449450 var3006)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r14 = virtualinvoke r38.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(assert (not (= (ite var2014 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var2350 var3077) ; Statement: $r29 := @caughtexception 
(assert (not (= var2350 null-var3077)))
(define-const var1682 var885 var885-init) ; Statement: $r45 = new org.apache.dubbo.rpc.RpcException 
(define-const var2835 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2835)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2835!1 String)
(assert (= var2835!1 ""))
(assert true)
(define-const var2792 String (append/672562846 var2835!1 "Fail to create remoting client for service(")) ; Statement: $r32 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to create remoting client for service(") 
(declare-const var2835!2 String)
(assert (= var2835!2 (str.++ var2835!1 "Fail to create remoting client for service(")))
(assert true)
(define-const var1130 String (append/-1031950772 var2792 (cast-from-var1480-to-var1422 var2070))) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r38) 
(declare-const var2792!1 String)
(assert (str.prefixof var2792 var2792!1))
(assert true)
(define-const var347 String (append/672562846 var1130 "): ")) ; Statement: $r35 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("): ") 
(declare-const var1130!1 String)
(assert (= var1130!1 (str.++ var1130 "): ")))
(assert true)
(define-const var411 String (getMessage/849299655 (cast-from-var3077-to-var2388 var2350))) ; Statement: $r34 = virtualinvoke $r29.<org.apache.dubbo.remoting.RemotingException: java.lang.String getMessage()>() 
(assert true)
(define-const var3799 String (append/672562846 var347 var411)) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34) 
(declare-const var347!1 String)
(assert (= var347!1 (str.++ var347 var411)))
(assert true)
(define-const var2529 String (toString/-2075883882 var3799)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var1682 var2529 (cast-from-var3077-to-var2388 var2350))) ; Statement: specialinvoke $r45.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r37, $r29) 

(declare-const var1682!1 var885)
(declare-const var2529!1 String)
(declare-const var2350!1 var3077)
 ; Statement: throw $r45 
(check-sat)
; {getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1508_isNotEmpty/-1251449450=([java.lang.String], boolean), var885-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1480-to-var1422=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var3077-to-var2388=([org.apache.dubbo.remoting.RemotingException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var2084=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var3305=r9, var1480=org.apache.dubbo.common.URL, var2070=r38, var2264=$r0, var3006=r1, var1508=org.apache.dubbo.common.utils.StringUtils, var2014=$z0, var3077=org.apache.dubbo.remoting.RemotingException, var2350=$r29, var885=org.apache.dubbo.rpc.RpcException, var1682=$r45, var2835=$r44, var2792=$r32, var1422=java.lang.Object, var1130=$r33, var347=$r35, var2388=java.lang.Throwable, var411=$r34, var3799=$r36, var2529=$r37}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var2084, r9=var3305, org.apache.dubbo.common.URL=var1480, r38=var2070, $r0=var2264, r1=var3006, org.apache.dubbo.common.utils.StringUtils=var1508, $z0=var2014, org.apache.dubbo.remoting.RemotingException=var3077, $r29=var2350, org.apache.dubbo.rpc.RpcException=var885, $r45=var1682, $r44=var2835, $r32=var2792, java.lang.Object=var1422, $r33=var1130, $r35=var347, java.lang.Throwable=var2388, $r34=var411, $r36=var3799, $r37=var2529}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	r38 := @parameter0: org.apache.dubbo.common.URL;	$r0 = virtualinvoke r38.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("server", "netty");	r1 = virtualinvoke r38.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("client", $r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r14 = virtualinvoke r38.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$r29 := @caughtexception;	$r45 = new org.apache.dubbo.rpc.RpcException;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r32 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to create remoting client for service(");	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r38);	$r35 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("): ");	$r34 = virtualinvoke $r29.<org.apache.dubbo.remoting.RemotingException: java.lang.String getMessage()>();	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34);	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r45.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r37, $r29);	throw $r45
;block_num 2