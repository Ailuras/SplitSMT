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

(declare-sort var769 0)
(declare-sort var926 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2015795402 (var769 String String) String)
(declare-fun var863_isEmpty/-813097145 (String) Bool)
(declare-const null-var769 var769)
(declare-const null-String String)
(declare-const var2413 var769) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2413 null-var769)))
(declare-const var258 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var258 null-String)))
(declare-const var2341 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2341 null-String)))
(declare-const var687 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var687 null-String)))
(assert true)
(define-const var1914 String (getMethodParameter/2015795402 var2413 var258 var2341)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3314 Bool (var863_isEmpty/-813097145 var1914)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (= (ite var3314 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1741 String var1914) ; Statement: $r5 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {getMethodParameter/2015795402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var863_isEmpty/-813097145=([java.lang.String], boolean)}
; {var769=org.apache.dubbo.common.URL, var2413=r0, var258=r1, var926=null_type, var2341=r2, var687=r4, var1914=r3, var863=org.apache.dubbo.common.utils.StringUtils, var3314=$z0, var1741=$r5}
; {org.apache.dubbo.common.URL=var769, r0=var2413, r1=var258, null_type=var926, r2=var2341, r4=var687, r3=var1914, org.apache.dubbo.common.utils.StringUtils=var863, $z0=var3314, $r5=var1741}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r4 := @parameter2: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $r5 = r3;	$r5 = r3;	return $r5
;block_num 3