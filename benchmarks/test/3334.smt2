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

(declare-sort var3408 0)
(declare-sort var2033 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2033 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun getProviderKey/-1135182146 (var3408 var2033) String)
(declare-const null-var3408 var3408)
(declare-const null-var2033 var2033)
(declare-const var2157 var3408) ; Statement: r3 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var2157 null-var3408)))
(declare-const var124 var2033) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var124 null-var2033)))
(define-const var273 String "consumer") ; Statement: $r2 = "consumer" 
(assert true)
(define-const var336 String (getParameter/-1307325648 var124 "side")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side") 
(assert true)
(define-const var1332 Bool (equalsIgnoreCase/-92311102 var273 var336)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0) 
(assert (= (ite var1332 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2007 String (getProviderKey/-1135182146 var2157 var124)) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: return $r4 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), getProviderKey/-1135182146=([org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, org.apache.dubbo.common.URL], java.lang.String)}
; {var3408=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var2157=r3, var2033=org.apache.dubbo.common.URL, var124=r0, var273=$r2, var336=$r1, var1332=$z0, var2007=$r4}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var3408, r3=var2157, org.apache.dubbo.common.URL=var2033, r0=var124, $r2=var273, $r1=var336, $z0=var1332, $r4=var2007}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "consumer";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0);	$r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0);	return $r4
;block_num 2