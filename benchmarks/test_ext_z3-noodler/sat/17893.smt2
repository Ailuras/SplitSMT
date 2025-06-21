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

(declare-sort var6 0)
(declare-sort var2498 0)
(declare-sort var1771 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1090915316 (var1771) String)
(declare-fun getParameter/-1307325648 (var2498 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var6 var6)
(declare-const null-var2498 var2498)
(declare-const var1771-FALSE var1771)
(declare-const var3290 var6) ; Statement: r4 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient 
(assert (not (= var3290 null-var6)))
(declare-const var1650 var2498) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1650 null-var2498)))
(define-const var3110 var1771 var1771-FALSE) ; Statement: $r0 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var2384 String (toString/1090915316 var3110)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var743 String (getParameter/-1307325648 var1650 "reconnect")) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reconnect") 
(assert true)
(define-const var419 Bool (equalsIgnoreCase/-92311102 var2384 var743)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var419 1 0) 0))) ; Cond: $z0 != 0 
(define-const var883 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {toString/1090915316=([java.lang.Boolean], java.lang.String), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var6=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient, var3290=r4, var2498=org.apache.dubbo.common.URL, var1650=r1, var1771=java.lang.Boolean, var3110=$r0, var2384=$r3, var743=$r2, var419=$z0, var883=$z1}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient=var6, r4=var3290, org.apache.dubbo.common.URL=var2498, r1=var1650, java.lang.Boolean=var1771, $r0=var3110, $r3=var2384, $r2=var743, $z0=var419, $z1=var883}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r0 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reconnect");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3