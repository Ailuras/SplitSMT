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

(declare-sort var2738 0)
(declare-sort var3646 0)
(declare-sort var279 0)
(declare-sort var35 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var35_getUrl/938756954 (var35) var279)
(declare-fun cast-from-var3646-to-var35 (var3646) var35)
(declare-fun getSide/-1479508364 (var279 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var2738 var2738)
(declare-const null-var3646 var3646)
(declare-const var1663 var2738) ; Statement: r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator 
(assert (not (= var1663 null-var2738)))
(declare-const var1425 var3646) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1425 null-var3646)))
(define-const var913 var279 (var35_getUrl/938756954 (cast-from-var3646-to-var35 var1425))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var693 String (getSide/-1479508364 var913 "")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("") 
(assert true)
(define-const var58 Bool (equalsIgnoreCase/-92311102 var693 "consumer")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("consumer") 
 ; Statement: return $z0 
(check-sat)
; {var35_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3646-to-var35=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getSide/-1479508364=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2738=org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator, var1663=r3, var3646=org.apache.dubbo.remoting.Channel, var1425=r0, var279=org.apache.dubbo.common.URL, var35=org.apache.dubbo.remoting.Endpoint, var913=$r1, var693=$r2, var58=$z0}
; {org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator=var2738, r3=var1663, org.apache.dubbo.remoting.Channel=var3646, r0=var1425, org.apache.dubbo.common.URL=var279, org.apache.dubbo.remoting.Endpoint=var35, $r1=var913, $r2=var693, $z0=var58}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.transport.netty4.NettyConfigOperator;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getSide(java.lang.String)>("");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("consumer");	return $z0
;block_num 1