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

(declare-sort var1407 0)
(declare-sort var3688 0)
(declare-sort var1957 0)
(declare-sort var2830 0)
(declare-sort var2056 0)
(declare-sort var1501 0)
(declare-sort var817 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2830-init () var2830)
(declare-fun getId/-1251157979 (var1957) Int)
(declare-fun getVersion/440990027 (var1957) String)
(declare-fun <init>/1624423151 (var2830 Int String) void)
(declare-fun isBroken/-867862021 (var1957) Bool)
(declare-fun getData/1094198143 (var1957) var2056)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun setErrorMessage/1202863900 (var2830 String) void)
(declare-fun setStatus/-969168820 (var2830 Int) void)
(declare-fun var817_send/1695952248 (var817 var2056) void)
(declare-fun cast-from-var3688-to-var817 (var3688) var817)
(declare-fun cast-from-var2830-to-var2056 (var2830) var2056)
(declare-const null-var1407 var1407)
(declare-const null-var3688 var3688)
(declare-const null-var1957 var1957)
(declare-const null-var2056 var2056)
(declare-const null-String String)
(declare-const var1459 var1407) ; Statement: r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler 
(assert (not (= var1459 null-var1407)))
(declare-const var2366 var3688) ; Statement: r4 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel 
(assert (not (= var2366 null-var3688)))
(declare-const var3218 var1957) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var3218 null-var1957)))
(define-const var3528 var2830 var2830-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var3005 Int (getId/-1251157979 var3218)) ; Statement: $l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>() 
(assert true)
(define-const var2185 String (getVersion/440990027 var3218)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>() 
(assert true)
;(assert (<init>/1624423151 var3528 var3005 var2185)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2) 

(declare-const var3528!1 var2830)
(declare-const var3005!1 Int)
(declare-const var2185!1 String)
(assert true)
(define-const var2873 Bool (isBroken/-867862021 var3218)) ; Statement: $z0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: boolean isBroken()>() 
 ; Statement: if $z0 == 0 goto r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>() 
(assert (not (= (ite var2873 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3489 var2056 (getData/1094198143 var3218)) ; Statement: r10 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>() 
 ; Statement: if r10 != null goto $z1 = r10 instanceof java.lang.Throwable 
(assert (not (not (= var3489 null-var2056)))) ; Negate: Cond: r10 != null  
(define-const var3728 String null-String) ; Statement: r11 = null 
 ; Statement: goto [?= $r12 = new java.lang.StringBuilder] 
(assert true) ; Non Conditional
(define-const var2747 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2747)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2747!1 String)
(assert (= var2747!1 ""))
(assert true)
(define-const var1044 String (append/672562846 var2747!1 "Fail to decode request due to: ")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to decode request due to: ") 
(declare-const var2747!2 String)
(assert (= var2747!2 (str.++ var2747!1 "Fail to decode request due to: ")))
(assert true)
(define-const var310 String (append/672562846 var1044 var3728)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11) 
(declare-const var1044!1 String)
(assert (= var1044!1 (str.++ var1044 var3728)))
(assert true)
(define-const var3748 String (toString/-2075883882 var310)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (setErrorMessage/1202863900 var3528!1 var3748)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r15) 

(declare-const var3528!2 var2830)
(declare-const var3748!1 String)
(assert true)
;(assert (setStatus/-969168820 var3528!2 40)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40) 

(declare-const var3528!3 var2830)
(declare-const var575 Int)
;(assert (var817_send/1695952248 (cast-from-var3688-to-var817 var2366) (cast-from-var2830-to-var2056 var3528!3))) ; Statement: interfaceinvoke r4.<org.apache.dubbo.remoting.exchange.ExchangeChannel: void send(java.lang.Object)>($r0) 

(declare-const var2366!1 var3688)
(declare-const var3528!4 var2830)
 ; Statement: return 
(check-sat)
; {var2830-init=([], org.apache.dubbo.remoting.exchange.Response), getId/-1251157979=([org.apache.dubbo.remoting.exchange.Request], long), getVersion/440990027=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), <init>/1624423151=([org.apache.dubbo.remoting.exchange.Response, long, java.lang.String], void), isBroken/-867862021=([org.apache.dubbo.remoting.exchange.Request], boolean), getData/1094198143=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), var817_send/1695952248=([org.apache.dubbo.remoting.Endpoint, java.lang.Object], void), cast-from-var3688-to-var817=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Endpoint), cast-from-var2830-to-var2056=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object)}
; {var1407=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler, var1459=r3, var3688=org.apache.dubbo.remoting.exchange.ExchangeChannel, var2366=r4, var1957=org.apache.dubbo.remoting.exchange.Request, var3218=r1, var2830=org.apache.dubbo.remoting.exchange.Response, var3528=$r0, var3005=$l0, var2185=$r2, var2873=$z0, var2056=java.lang.Object, var3489=r10, var1501=null_type, var3728=r11, var2747=$r12, var1044=$r13, var310=$r14, var3748=$r15, var575=40, var817=org.apache.dubbo.remoting.Endpoint}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler=var1407, r3=var1459, org.apache.dubbo.remoting.exchange.ExchangeChannel=var3688, r4=var2366, org.apache.dubbo.remoting.exchange.Request=var1957, r1=var3218, org.apache.dubbo.remoting.exchange.Response=var2830, $r0=var3528, $l0=var3005, $r2=var2185, $z0=var2873, java.lang.Object=var2056, r10=var3489, null_type=var1501, r11=var3728, $r12=var2747, $r13=var1044, $r14=var310, $r15=var3748, 40=var575, org.apache.dubbo.remoting.Endpoint=var817}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler;	r4 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel;	r1 := @parameter1: org.apache.dubbo.remoting.exchange.Request;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2);	$z0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: boolean isBroken()>();	if $z0 == 0 goto r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>();	r10 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>();	if r10 != null goto $z1 = r10 instanceof java.lang.Throwable;	r11 = null;	goto [?= $r12 = new java.lang.StringBuilder];	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Fail to decode request due to: ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r15);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(40);	interfaceinvoke r4.<org.apache.dubbo.remoting.exchange.ExchangeChannel: void send(java.lang.Object)>($r0);	return
;block_num 4