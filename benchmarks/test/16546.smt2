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

(declare-sort var1411 0)
(declare-sort var1890 0)
(declare-sort var2897 0)
(declare-sort var3059 0)
(declare-sort var1027 0)
(declare-sort var726 0)
(declare-sort var2285 0)
(declare-sort var3885 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3059-init () var3059)
(declare-fun getId/-1251157979 (var2897) Int)
(declare-fun getVersion/440990027 (var2897) String)
(declare-fun <init>/1624423151 (var3059 Int String) void)
(declare-fun isBroken/-867862021 (var2897) Bool)
(declare-fun getData/1094198143 (var2897) var1027)
(declare-fun setStatus/-969168820 (var3059 Int) void)
(declare-fun var2285_toString/-109309168 (var726) String)
(declare-fun setErrorMessage/1202863900 (var3059 String) void)
(declare-fun var3885_send/1695952248 (var3885 var1027) void)
(declare-fun cast-from-var1890-to-var3885 (var1890) var3885)
(declare-fun cast-from-var3059-to-var1027 (var3059) var1027)
(declare-const null-var1411 var1411)
(declare-const null-var1890 var1890)
(declare-const null-var2897 var2897)
(declare-const null-var726 var726)
(declare-const var1842 var1411) ; Statement: r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler 
(assert (not (= var1842 null-var1411)))
(declare-const var984 var1890) ; Statement: r4 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel 
(assert (not (= var984 null-var1890)))
(declare-const var2353 var2897) ; Statement: r1 := @parameter1: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var2353 null-var2897)))
(define-const var423 var3059 var3059-init) ; Statement: $r0 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var1695 Int (getId/-1251157979 var2353)) ; Statement: $l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>() 
(assert true)
(define-const var3927 String (getVersion/440990027 var2353)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>() 
(assert true)
;(assert (<init>/1624423151 var423 var1695 var3927)) ; Statement: specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2) 

(declare-const var423!1 var3059)
(declare-const var1695!1 Int)
(declare-const var3927!1 String)
(assert true)
(define-const var1591 Bool (isBroken/-867862021 var2353)) ; Statement: $z0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: boolean isBroken()>() 
 ; Statement: if $z0 == 0 goto r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>() 
(assert (= (ite var1591 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2006 var1027 (getData/1094198143 var2353)) ; Statement: r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3515 var726) ; Statement: $r8 := @caughtexception 
(assert (not (= var3515 null-var726)))
(assert true)
;(assert (setStatus/-969168820 var423!1 70)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(70) 

(declare-const var423!2 var3059)
(declare-const var3214 Int)
(define-const var1560 String (var2285_toString/-109309168 var3515)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r8) 
(assert true)
;(assert (setErrorMessage/1202863900 var423!2 var1560)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r9) 

(declare-const var423!3 var3059)
(declare-const var1560!1 String)
;(assert (var3885_send/1695952248 (cast-from-var1890-to-var3885 var984) (cast-from-var3059-to-var1027 var423!3))) ; Statement: interfaceinvoke r4.<org.apache.dubbo.remoting.exchange.ExchangeChannel: void send(java.lang.Object)>($r0) 

(declare-const var984!1 var1890)
(declare-const var423!4 var3059)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var3059-init=([], org.apache.dubbo.remoting.exchange.Response), getId/-1251157979=([org.apache.dubbo.remoting.exchange.Request], long), getVersion/440990027=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), <init>/1624423151=([org.apache.dubbo.remoting.exchange.Response, long, java.lang.String], void), isBroken/-867862021=([org.apache.dubbo.remoting.exchange.Request], boolean), getData/1094198143=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), var2285_toString/-109309168=([java.lang.Throwable], java.lang.String), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void), var3885_send/1695952248=([org.apache.dubbo.remoting.Endpoint, java.lang.Object], void), cast-from-var1890-to-var3885=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Endpoint), cast-from-var3059-to-var1027=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object)}
; {var1411=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler, var1842=r3, var1890=org.apache.dubbo.remoting.exchange.ExchangeChannel, var984=r4, var2897=org.apache.dubbo.remoting.exchange.Request, var2353=r1, var3059=org.apache.dubbo.remoting.exchange.Response, var423=$r0, var1695=$l0, var3927=$r2, var1591=$z0, var1027=java.lang.Object, var2006=r16, var726=java.lang.Throwable, var3515=$r8, var3214=70, var2285=org.apache.dubbo.common.utils.StringUtils, var1560=$r9, var3885=org.apache.dubbo.remoting.Endpoint}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler=var1411, r3=var1842, org.apache.dubbo.remoting.exchange.ExchangeChannel=var1890, r4=var984, org.apache.dubbo.remoting.exchange.Request=var2897, r1=var2353, org.apache.dubbo.remoting.exchange.Response=var3059, $r0=var423, $l0=var1695, $r2=var3927, $z0=var1591, java.lang.Object=var1027, r16=var2006, java.lang.Throwable=var726, $r8=var3515, 70=var3214, org.apache.dubbo.common.utils.StringUtils=var2285, $r9=var1560, org.apache.dubbo.remoting.Endpoint=var3885}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeHandler;	r4 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel;	r1 := @parameter1: org.apache.dubbo.remoting.exchange.Request;	$r0 = new org.apache.dubbo.remoting.exchange.Response;	$l0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: long getId()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>();	specialinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l0, $r2);	$z0 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: boolean isBroken()>();	if $z0 == 0 goto r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>();	r16 = virtualinvoke r1.<org.apache.dubbo.remoting.exchange.Request: java.lang.Object getData()>();	$r8 := @caughtexception;	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(70);	$r9 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r8);	virtualinvoke $r0.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>($r9);	interfaceinvoke r4.<org.apache.dubbo.remoting.exchange.ExchangeChannel: void send(java.lang.Object)>($r0);	return
;block_num 4