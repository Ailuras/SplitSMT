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

(declare-sort var1546 0)
(declare-sort var3939 0)
(declare-sort var771 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterAndDecoded/384969937 (var1546 String) String)
(declare-fun var771_isEmpty/-813097145 (String) Bool)
(declare-const null-var1546 var1546)
(declare-const null-String String)
(declare-const var375 var1546) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var375 null-var1546)))
(declare-const var377 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var377 null-String)))
(assert true)
(define-const var2392 String (getParameterAndDecoded/384969937 var375 var377)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>(r1) 
(define-const var1065 Bool (var771_isEmpty/-813097145 var2392)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2) 
(assert (not (= (ite var1065 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {getParameterAndDecoded/384969937=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var771_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1546=org.apache.dubbo.common.URL, var375=r0, var377=r1, var3939=null_type, var2392=r2, var771=org.apache.dubbo.common.utils.StringUtils, var1065=$z0}
; {org.apache.dubbo.common.URL=var1546, r0=var375, r1=var377, null_type=var3939, r2=var2392, org.apache.dubbo.common.utils.StringUtils=var771, $z0=var1065}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>(r2);	return null
;block_num 2