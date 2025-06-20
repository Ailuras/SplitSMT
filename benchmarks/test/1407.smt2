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

(declare-sort var2893 0)
(declare-sort var3718 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-686284803 (var2893) var3718)
(declare-fun getParameter/-1307325648 (var3718 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var2893 var2893)
(declare-const var229 var2893) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker 
(assert (not (= var229 null-var2893)))
(define-const var1890 String "broadcast") ; Statement: $r3 = "broadcast" 
(assert true)
(define-const var1937 var3718 (getUrl/-686284803 var229)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var795 String (getParameter/-1307325648 var1937 "cluster")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster") 
(assert true)
(define-const var116 Bool (equalsIgnoreCase/-92311102 var1890 var795)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getUrl/-686284803=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var2893=org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker, var229=r0, var1890=$r3, var3718=org.apache.dubbo.common.URL, var1937=$r1, var795=$r2, var116=$z0}
; {org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker=var2893, r0=var229, $r3=var1890, org.apache.dubbo.common.URL=var3718, $r1=var1937, $r2=var795, $z0=var116}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker;	$r3 = "broadcast";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster");	$z0 = virtualinvoke $r3.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r2);	return $z0
;block_num 1