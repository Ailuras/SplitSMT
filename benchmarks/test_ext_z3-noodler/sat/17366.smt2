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

(declare-sort var106 0)
(declare-sort var59 0)
(declare-sort var3662 0)
(declare-sort var3544 0)
(declare-sort var1152 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun closed/-1591198865 (var106) var3662)
(declare-fun get/2135855162 (var3662) Bool)
(declare-fun server/-1591198865 (var106) var3544)
(declare-fun var1152_send/-441995788 (var1152 var59 Bool) void)
(declare-fun cast-from-var3544-to-var1152 (var3544) var1152)
(declare-const null-var106 var106)
(declare-const null-var59 var59)
(declare-const null-Bool Bool)
(declare-const var1253 var106) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer 
(assert (not (= var1253 null-var106)))
(declare-const var3092 var59) ; Statement: r2 := @parameter0: java.lang.Object 
(assert (not (= var3092 null-var59)))
(declare-const var737 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var737 null-Bool)))
(define-const var975 var3662 (closed/-1591198865 var1253)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed> 
(assert true)
(define-const var3816 Bool (get/2135855162 var975)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
(assert (= (ite var3816 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2977 var3544 (server/-1591198865 var1253)) ; Statement: $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server> 
;(assert (var1152_send/-441995788 (cast-from-var3544-to-var1152 var2977) var3092 var737)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.remoting.RemotingServer: void send(java.lang.Object,boolean)>(r2, z1) 

(declare-const var2977!1 var3544)
(declare-const var3092!1 var59)
(declare-const var737!1 Bool)
 ; Statement: return 
(check-sat)
; {closed/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean), server/-1591198865=([org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer], org.apache.dubbo.remoting.RemotingServer), var1152_send/-441995788=([org.apache.dubbo.remoting.Endpoint, java.lang.Object, boolean], void), cast-from-var3544-to-var1152=([org.apache.dubbo.remoting.RemotingServer], org.apache.dubbo.remoting.Endpoint)}
; {var106=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer, var1253=r0, var59=java.lang.Object, var3092=r2, var737=z1, var3662=java.util.concurrent.atomic.AtomicBoolean, var975=$r1, var3816=$z0, var3544=org.apache.dubbo.remoting.RemotingServer, var2977=$r3, var1152=org.apache.dubbo.remoting.Endpoint}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer=var106, r0=var1253, java.lang.Object=var59, r2=var3092, z1=var737, java.util.concurrent.atomic.AtomicBoolean=var3662, $r1=var975, $z0=var3816, org.apache.dubbo.remoting.RemotingServer=var3544, $r3=var2977, org.apache.dubbo.remoting.Endpoint=var1152}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer;	r2 := @parameter0: java.lang.Object;	z1 := @parameter1: boolean;	$r1 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: java.util.concurrent.atomic.AtomicBoolean closed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	$r3 = r0.<org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeServer: org.apache.dubbo.remoting.RemotingServer server>;	interfaceinvoke $r3.<org.apache.dubbo.remoting.RemotingServer: void send(java.lang.Object,boolean)>(r2, z1);	return
;block_num 2