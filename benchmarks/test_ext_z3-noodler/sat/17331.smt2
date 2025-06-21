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

(declare-sort var2436 0)
(declare-sort var1259 0)
(declare-sort var1006 0)
(declare-sort var3400 0)
(declare-sort var326 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/-1591198865 (var2436) var1006)
(declare-fun get/2135855162 (var1006) Bool)
(declare-fun server/-1591198865 (var2436) var3400)
(declare-fun var326_send/1695952248 (var326 var1259) void)
(declare-fun cast-from-var3400-to-var326 (var3400) var326)
(declare-const null-var2436 var2436)
(declare-const null-var1259 var1259)
(declare-const var2420 var2436) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer 
(assert (not (= var2420 null-var2436)))
(declare-const var3696 var1259) ; Statement: r2 := @parameter0: java.lang.Object 
(assert (not (= var3696 null-var1259)))
(define-const var286 var1006 (closed/-1591198865 var2420)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed> 
(assert true)
(define-const var1077 Bool (get/2135855162 var286)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (= (ite var1077 1 0) 0)) ; Cond: $z0 == 0 
(define-const var44 var3400 (server/-1591198865 var2420)) ; Statement: $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
;(assert (var326_send/1695952248 (cast-from-var3400-to-var326 var44) var3696)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.remoting.RemotingServer: void send(java.lang.Object)>(r2) 

(declare-const var44!1 var3400)
(declare-const var3696!1 var1259)
 ; Statement: return 
(check-sat)
; {closed/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), server/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], org.apache.dubbo.remoting.RemotingServer), var326_send/1695952248=([org.apache.dubbo.remoting.Endpoint, java.lang.Object], void), cast-from-var3400-to-var326=([org.apache.dubbo.remoting.RemotingServer], org.apache.dubbo.remoting.Endpoint)}
; {var2436=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer, var2420=r0, var1259=java.lang.Object, var3696=r2, var1006=java.util.concurrent.atomic.AtomicBoolean, var286=$r1, var1077=$z0, var3400=org.apache.dubbo.remoting.RemotingServer, var44=$r3, var326=org.apache.dubbo.remoting.Endpoint}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer=var2436, r0=var2420, java.lang.Object=var1259, r2=var3696, java.util.concurrent.atomic.AtomicBoolean=var1006, $r1=var286, $z0=var1077, org.apache.dubbo.remoting.RemotingServer=var3400, $r3=var44, org.apache.dubbo.remoting.Endpoint=var326}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer;	r2 := @parameter0: java.lang.Object;	$r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	$r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	interfaceinvoke $r3.<org.apache.dubbo.remoting.RemotingServer: void send(java.lang.Object)>(r2);	return
;block_num 2