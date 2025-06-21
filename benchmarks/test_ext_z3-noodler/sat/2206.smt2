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

(declare-sort var3624 0)
(declare-sort var3552 0)
(declare-sort var1323 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1323_isEmpty/-813097145 (String) Bool)
(declare-const null-var3624 var3624)
(declare-const null-String String)
(declare-const var1712 var3624) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1712 null-var3624)))
(declare-const var1242 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1242 null-String)))
(declare-const var3683 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3683 null-String)))
(define-const var1624 Bool (var1323_isEmpty/-813097145 var3683)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (not (= (ite var1624 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var1323_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3624=org.apache.dubbo.common.URLBuilder, var1712=r1, var1242=r2, var3552=null_type, var3683=r0, var1323=org.apache.dubbo.common.utils.StringUtils, var1624=$z0}
; {org.apache.dubbo.common.URLBuilder=var3624, r1=var1712, r2=var1242, null_type=var3552, r0=var3683, org.apache.dubbo.common.utils.StringUtils=var1323, $z0=var1624}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	return r1
;block_num 2