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

(declare-sort var1059 0)
(declare-sort var1009 0)
(declare-sort var3931 0)
(declare-sort var2985 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1009_getMethodName/-888969971 (var1009) String)
(declare-fun getMethodParameter/2015795402 (var1059 String String) String)
(declare-fun toString/1090915316 (var2985) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var1059 var1059)
(declare-const null-var1009 var1009)
(declare-const null-String String)
(declare-const var2985-TRUE var2985)
(declare-const var3192 var1059) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3192 null-var1059)))
(declare-const var1257 var1009) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1257 null-var1009)))
(define-const var913 String (var1009_getMethodName/-888969971 var1257)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1473 String (getMethodParameter/2015795402 var3192 var913 "invocationid.autoattach")) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>($r2, "invocationid.autoattach") 
 ; Statement: if r3 != null goto $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert (not (= var1473 null-String))) ; Cond: r3 != null 
(define-const var3073 var2985 var2985-TRUE) ; Statement: $r4 = <java.lang.Boolean: java.lang.Boolean TRUE> 
(assert true)
(define-const var1690 String (toString/1090915316 var3073)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>() 
(assert true)
(define-const var3646 Bool (equalsIgnoreCase/-92311102 var1690 var1473)) ; Statement: $z0 = virtualinvoke $r5.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r3) 
 ; Statement: return $z0 
(check-sat)
; {var1009_getMethodName/-888969971=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), toString/1090915316=([java.lang.Boolean], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var1059=org.apache.dubbo.common.URL, var3192=r0, var1009=org.apache.dubbo.rpc.Invocation, var1257=r1, var913=$r2, var1473=r3, var3931=null_type, var2985=java.lang.Boolean, var3073=$r4, var1690=$r5, var3646=$z0}
; {org.apache.dubbo.common.URL=var1059, r0=var3192, org.apache.dubbo.rpc.Invocation=var1009, r1=var1257, $r2=var913, r3=var1473, null_type=var3931, java.lang.Boolean=var2985, $r4=var3073, $r5=var1690, $z0=var3646}
;seq <java.lang.Boolean: java.lang.String toString()>;	<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getMethodName()>();	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>($r2, "invocationid.autoattach");	if r3 != null goto $r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r4 = <java.lang.Boolean: java.lang.Boolean TRUE>;	$r5 = virtualinvoke $r4.<java.lang.Boolean: java.lang.String toString()>();	$z0 = virtualinvoke $r5.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r3);	return $z0
;block_num 2