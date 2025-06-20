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

(declare-sort var1534 0)
(declare-sort var2675 0)
(declare-sort var2013 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2013_isEmpty/-813097145 (String) Bool)
(declare-const null-var1534 var1534)
(declare-const null-String String)
(declare-const var3841 var1534) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3841 null-var1534)))
(declare-const var1255 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1255 null-String)))
(declare-const var2918 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2918 null-String)))
(define-const var1718 Bool (var2013_isEmpty/-813097145 var1255)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var1718 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var2013_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1534=org.apache.dubbo.common.URLBuilder, var3841=r1, var1255=r0, var2675=null_type, var2918=r2, var2013=org.apache.dubbo.common.utils.StringUtils, var1718=$z0}
; {org.apache.dubbo.common.URLBuilder=var1534, r1=var3841, r0=var1255, null_type=var2675, r2=var2918, org.apache.dubbo.common.utils.StringUtils=var2013, $z0=var1718}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2