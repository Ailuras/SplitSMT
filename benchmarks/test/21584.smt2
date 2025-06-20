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

(declare-sort var2174 0)
(declare-sort var2843 0)
(declare-sort var1735 0)
(declare-sort var3013 0)
(declare-sort var2741 0)
(declare-sort var688 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1735-init () var1735)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun url/-1701008691 (var2174) var3013)
(declare-fun append/-1031950772 (String var2741) String)
(declare-fun cast-from-var3013-to-var2741 (var3013) var2741)
(declare-fun getMessage/849299655 (var688) String)
(declare-fun cast-from-var2843-to-var688 (var2843) var688)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var1735 String var688) void)
(declare-const null-var2174 var2174)
(declare-const null-var2843 var2843)
(declare-const var1124 var2174) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient 
(assert (not (= var1124 null-var2174)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2779 var2843) ; Statement: $r7 := @caughtexception 
(assert (not (= var2779 null-var2843)))
(define-const var1672 var1735 var1735-init) ; Statement: $r8 = new org.apache.dubbo.rpc.RpcException 
(define-const var3512 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3512)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3512!1 String)
(assert (= var3512!1 ""))
(assert true)
(define-const var3447 String (append/672562846 var3512!1 "Fail to create remoting client for service(")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to create remoting client for service(") 
(declare-const var3512!2 String)
(assert (= var3512!2 (str.++ var3512!1 "Fail to create remoting client for service(")))
(define-const var3499 var3013 (url/-1701008691 var1124)) ; Statement: $r10 = r0.<org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2846 String (append/-1031950772 var3447 (cast-from-var3013-to-var2741 var3499))) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var3447!1 String)
(assert (str.prefixof var3447 var3447!1))
(assert true)
(define-const var327 String (append/672562846 var2846 "): ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("): ") 
(declare-const var2846!1 String)
(assert (= var2846!1 (str.++ var2846 "): ")))
(assert true)
(define-const var3831 String (getMessage/849299655 (cast-from-var2843-to-var688 var2779))) ; Statement: $r13 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var2908 String (append/672562846 var327 var3831)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var327!1 String)
(assert (= var327!1 (str.++ var327 var3831)))
(assert true)
(define-const var731 String (toString/-2075883882 var2908)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var1672 var731 (cast-from-var2843-to-var688 var2779))) ; Statement: specialinvoke $r8.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r16, $r7) 

(declare-const var1672!1 var1735)
(declare-const var731!1 String)
(declare-const var2779!1 var2843)
 ; Statement: throw $r8 
(check-sat)
; {var1735-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), url/-1701008691=([org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3013-to-var2741=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var2843-to-var688=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var2174=org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient, var1124=r0, var2843=java.lang.Exception, var2779=$r7, var1735=org.apache.dubbo.rpc.RpcException, var1672=$r8, var3512=$r9, var3447=$r11, var3013=org.apache.dubbo.common.URL, var3499=$r10, var2741=java.lang.Object, var2846=$r12, var327=$r14, var688=java.lang.Throwable, var3831=$r13, var2908=$r15, var731=$r16}
; {org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient=var2174, r0=var1124, java.lang.Exception=var2843, $r7=var2779, org.apache.dubbo.rpc.RpcException=var1735, $r8=var1672, $r9=var3512, $r11=var3447, org.apache.dubbo.common.URL=var3013, $r10=var3499, java.lang.Object=var2741, $r12=var2846, $r14=var327, java.lang.Throwable=var688, $r13=var3831, $r15=var2908, $r16=var731}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient;	$r7 := @caughtexception;	$r8 = new org.apache.dubbo.rpc.RpcException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to create remoting client for service(");	$r10 = r0.<org.apache.dubbo.rpc.protocol.dubbo.LazyConnectExchangeClient: org.apache.dubbo.common.URL url>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("): ");	$r13 = virtualinvoke $r7.<java.lang.Exception: java.lang.String getMessage()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r8.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r16, $r7);	throw $r8
;block_num 2