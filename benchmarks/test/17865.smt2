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

(declare-sort var3847 0)
(declare-sort var421 0)
(declare-sort var2815 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1090915316 (var2815) String)
(declare-fun getParameter/-1307325648 (var421 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var3847 var3847)
(declare-const null-var421 var421)
(declare-const var2815-FALSE var2815)
(declare-const var2130 var3847) ; Statement: r4 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient 
(assert (not (= var2130 null-var3847)))
(declare-const var3193 var421) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3193 null-var421)))
(define-const var2922 var2815 var2815-FALSE) ; Statement: $r0 = <java.lang.Boolean: java.lang.Boolean FALSE> 
(assert true)
(define-const var2410 String (toString/1090915316 var2922)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var3712 String (getParameter/-1307325648 var3193 "reconnect")) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reconnect") 
(assert true)
(define-const var2904 Bool (equalsIgnoreCase/-92311102 var2410 var3712)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var2904 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2506 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {toString/1090915316=([java.lang.Boolean], java.lang.String), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var3847=org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient, var2130=r4, var421=org.apache.dubbo.common.URL, var3193=r1, var2815=java.lang.Boolean, var2922=$r0, var2410=$r3, var3712=$r2, var2904=$z0, var2506=$z1}
; {org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient=var3847, r4=var2130, org.apache.dubbo.common.URL=var421, r1=var3193, java.lang.Boolean=var2815, $r0=var2922, $r3=var2410, $r2=var3712, $z0=var2904, $z1=var2506}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.remoting.exchange.support.header.HeaderExchangeClient;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r0 = <java.lang.Boolean: java.lang.Boolean FALSE>;	$r3 = virtualinvoke $r0.<java.lang.Boolean: java.lang.String toString()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reconnect");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3