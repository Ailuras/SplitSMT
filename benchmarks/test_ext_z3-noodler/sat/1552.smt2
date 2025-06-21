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

(declare-sort var2746 0)
(declare-sort var1212 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-686284803 (var2746) var1212)
(declare-fun getParameter/-1307325648 (var1212 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var2746 var2746)
(declare-const var3922 var2746) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker 
(assert (not (= var3922 null-var2746)))
(define-const var3412 String "remote") ; Statement: $r3 = "remote" 
(assert true)
(define-const var2863 var1212 (getUrl/-686284803 var3922)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3520 String (getParameter/-1307325648 var2863 "scope")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope") 
(assert true)
(define-const var3481 Bool (equalsIgnoreCase/-92311102 var3412 var3520)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2) 
 ; Statement: if $z0 != 0 goto $z2 = 0 
(assert (not (= (ite var3481 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3178 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {getUrl/-686284803=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2746=org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker, var3922=r0, var3412=$r3, var1212=org.apache.dubbo.common.URL, var2863=$r1, var3520=$r2, var3481=$z0, var3178=$z2}
; {org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker=var2746, r0=var3922, $r3=var3412, org.apache.dubbo.common.URL=var1212, $r1=var2863, $r2=var3520, $z0=var3481, $z2=var3178}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker;	$r3 = "remote";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2);	if $z0 != 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3