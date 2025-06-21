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

(declare-sort var1382 0)
(declare-sort var3307 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3307 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun getConsumerKey/-1476881063 (var1382 var3307) String)
(declare-const null-var1382 var1382)
(declare-const null-var3307 var3307)
(declare-const var3960 var1382) ; Statement: r3 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var3960 null-var1382)))
(declare-const var3413 var3307) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3413 null-var3307)))
(define-const var3403 String "consumer") ; Statement: $r2 = "consumer" 
(assert true)
(define-const var2978 String (getParameter/-1307325648 var3413 "side")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side") 
(assert true)
(define-const var152 Bool (equalsIgnoreCase/-92311102 var3403 var2978)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0) 
(assert (not (= (ite var152 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1283 String (getConsumerKey/-1476881063 var3960 var3413)) ; Statement: $r5 = specialinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getConsumerKey(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: return $r5 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), getConsumerKey/-1476881063=([org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, org.apache.dubbo.common.URL], java.lang.String)}
; {var1382=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var3960=r3, var3307=org.apache.dubbo.common.URL, var3413=r0, var3403=$r2, var2978=$r1, var152=$z0, var1283=$r5}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var1382, r3=var3960, org.apache.dubbo.common.URL=var3307, r0=var3413, $r2=var3403, $r1=var2978, $z0=var152, $r5=var1283}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "consumer";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("side");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = virtualinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getProviderKey(org.apache.dubbo.common.URL)>(r0);	$r5 = specialinvoke r3.<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String getConsumerKey(org.apache.dubbo.common.URL)>(r0);	return $r5
;block_num 2