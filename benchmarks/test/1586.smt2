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

(declare-sort var666 0)
(declare-sort var3566 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-686284803 (var666) var3566)
(declare-fun getParameter/-1307325648 (var3566 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var666 var666)
(declare-const var3917 var666) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker 
(assert (not (= var3917 null-var666)))
(define-const var1415 String "local") ; Statement: $r3 = "local" 
(assert true)
(define-const var1375 var3566 (getUrl/-686284803 var3917)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3040 String (getParameter/-1307325648 var1375 "scope")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope") 
(assert true)
(define-const var127 Bool (equalsIgnoreCase/-92311102 var1415 var3040)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var127 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1636 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getUrl/-686284803=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var666=org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker, var3917=r0, var1415=$r3, var3566=org.apache.dubbo.common.URL, var1375=$r1, var3040=$r2, var127=$z0, var1636=$z2}
; {org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker=var666, r0=var3917, $r3=var1415, org.apache.dubbo.common.URL=var3566, $r1=var1375, $r2=var3040, $z0=var127, $z2=var1636}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker;	$r3 = "local";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3