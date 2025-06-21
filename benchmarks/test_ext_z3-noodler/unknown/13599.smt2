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

(declare-sort var534 0)
(declare-sort var226 0)
(declare-sort var779 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceMethodParameter/-1810918120 (var534 String String String) String)
(declare-fun var779_isEmpty/-813097145 (String) Bool)
(declare-const null-var534 var534)
(declare-const null-String String)
(declare-const var439 var534) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var439 null-var534)))
(declare-const var1124 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1124 null-String)))
(declare-const var3904 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3904 null-String)))
(declare-const var2857 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2857 null-String)))
(declare-const var967 String) ; Statement: r5 := @parameter3: java.lang.String 
(assert (not (= var967 null-String)))
(assert true)
(define-const var2449 String (getServiceMethodParameter/-1810918120 var439 var1124 var3904 var2857)) ; Statement: r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3) 
(define-const var1681 Bool (var779_isEmpty/-813097145 var2449)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $r6 = r4 
(assert (= (ite var1681 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2019 String var2449) ; Statement: $r6 = r4 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {getServiceMethodParameter/-1810918120=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var779_isEmpty/-813097145=([java.lang.String], boolean)}
; {var534=org.apache.dubbo.common.URL, var439=r0, var1124=r1, var226=null_type, var3904=r2, var2857=r3, var967=r5, var2449=r4, var779=org.apache.dubbo.common.utils.StringUtils, var1681=$z0, var2019=$r6}
; {org.apache.dubbo.common.URL=var534, r0=var439, r1=var1124, null_type=var226, r2=var3904, r3=var2857, r5=var967, r4=var2449, org.apache.dubbo.common.utils.StringUtils=var779, $z0=var1681, $r6=var2019}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r5 := @parameter3: java.lang.String;	r4 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, r3);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r4);	if $z0 == 0 goto $r6 = r4;	$r6 = r4;	return $r6
;block_num 3