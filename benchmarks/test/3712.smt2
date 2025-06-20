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

(declare-sort var628 0)
(declare-sort var3480 0)
(declare-sort var3441 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3480 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var628 var628)
(declare-const null-var3480 var3480)
(declare-const var3441-EXECUTOR_SERVICE_COMPONENT_KEY String)
(declare-const var3019 var628) ; Statement: r4 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var3019 null-var628)))
(declare-const var657 var3480) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var657 null-var3480)))
(define-const var3164 String "consumer") ; Statement: $r2 = "consumer" 
(assert true)
(define-const var2771 String (getParameter/-1307325648 var657 "side")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side") 
(assert true)
(define-const var1064 Bool (equalsIgnoreCase/-92311102 var3164 var2771)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
(assert (= (ite var1064 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2927 String var3441-EXECUTOR_SERVICE_COMPONENT_KEY) ; Statement: $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY> 
 ; Statement: return $r3 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var628=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var3019=r4, var3480=org.apache.dubbo.common.URL, var657=r0, var3164=$r2, var2771=$r1, var1064=$z0, var3441=org.apache.dubbo.common.constants.CommonConstants, var2927=$r3}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var628, r4=var3019, org.apache.dubbo.common.URL=var3480, r0=var657, $r2=var3164, $r1=var2771, $z0=var1064, org.apache.dubbo.common.constants.CommonConstants=var3441, $r3=var2927}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "consumer";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	$r3 = <org.apache.dubbo.common.constants.CommonConstants: java.lang.String EXECUTOR_SERVICE_COMPONENT_KEY>;	return $r3
;block_num 2