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

(declare-sort var17 0)
(declare-sort var3831 0)
(declare-sort var2526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2526_isEmpty/-813097145 (String) Bool)
(declare-const null-var17 var17)
(declare-const null-String String)
(declare-const var3855 var17) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3855 null-var17)))
(declare-const var255 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var255 null-String)))
(declare-const var668 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var668 null-String)))
(define-const var127 Bool (var2526_isEmpty/-813097145 var668)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (not (= (ite var127 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var2526_isEmpty/-813097145=([java.lang.String], boolean)}
; {var17=org.apache.dubbo.common.URL, var3855=r1, var255=r2, var3831=null_type, var668=r0, var2526=org.apache.dubbo.common.utils.StringUtils, var127=$z0}
; {org.apache.dubbo.common.URL=var17, r1=var3855, r2=var255, null_type=var3831, r0=var668, org.apache.dubbo.common.utils.StringUtils=var2526, $z0=var127}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	return r1
;block_num 2