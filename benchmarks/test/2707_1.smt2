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

(declare-sort var1518 0)
(declare-sort var554 0)
(declare-sort var1519 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1519_isEmpty/-813097145 (String) Bool)
(declare-const null-var1518 var1518)
(declare-const null-String String)
(declare-const var3267 var1518) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3267 null-var1518)))
(declare-const var1545 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1545 null-String)))
(declare-const var2221 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2221 null-String)))
(declare-const var1592 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1592 null-String)))
(define-const var3704 Bool (var1519_isEmpty/-813097145 var1545)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var3704 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var1519_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1518=org.apache.dubbo.common.URLBuilder, var3267=r1, var1545=r0, var554=null_type, var2221=r2, var1592=r3, var1519=org.apache.dubbo.common.utils.StringUtils, var3704=$z0}
; {org.apache.dubbo.common.URLBuilder=var1518, r1=var3267, r0=var1545, null_type=var554, r2=var2221, r3=var1592, org.apache.dubbo.common.utils.StringUtils=var1519, $z0=var3704}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2