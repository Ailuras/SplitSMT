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

(declare-sort var1444 0)
(declare-sort var685 0)
(declare-sort var834 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterValue/784943207 (var685 var1444) var834)
(declare-fun cast-from-var834-to-String (var834) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var1444 var1444)
(declare-const var685-ROOT_PATH var685)
(declare-const var3905 var1444) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3905 null-var1444)))
(define-const var1862 var685 var685-ROOT_PATH) ; Statement: $r1 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams ROOT_PATH> 
(assert true)
(define-const var109 var834 (getParameterValue/784943207 var1862 var3905)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0) 
(define-const var3412 String (cast-from-var834-to-String var109)) ; Statement: r8 = (java.lang.String) $r2 
(assert true)
(define-const var2704 Bool (equalsIgnoreCase/-92311102 var3412 "/services")) ; Statement: $z0 = virtualinvoke r8.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("/services") 
 ; Statement: if $z0 == 0 goto return r8 
(assert (= (ite var2704 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r8 
(check-sat)
; {getParameterValue/784943207=([org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams, org.apache.dubbo.common.URL], java.lang.Object), cast-from-var834-to-String=([java.lang.Object], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var1444=org.apache.dubbo.common.URL, var3905=r0, var685=org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams, var1862=$r1, var834=java.lang.Object, var109=$r2, var3412=r8, var2704=$z0}
; {org.apache.dubbo.common.URL=var1444, r0=var3905, org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams=var685, $r1=var1862, java.lang.Object=var834, $r2=var109, r8=var3412, $z0=var2704}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams ROOT_PATH>;	$r2 = virtualinvoke $r1.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0);	r8 = (java.lang.String) $r2;	$z0 = virtualinvoke r8.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>("/services");	if $z0 == 0 goto return r8;	return r8
;block_num 2