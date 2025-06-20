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

(declare-sort var2628 0)
(declare-sort var335 0)
(declare-sort var3064 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var2628 String String) String)
(declare-fun var3064_isEmpty/-813097145 (String) Bool)
(declare-const null-var2628 var2628)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var790 var2628) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var790 null-var2628)))
(declare-const var3611 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3611 null-String)))
(declare-const var610 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var610 null-String)))
(declare-const var3009 Int) ; Statement: l1 := @parameter2: long 
(assert (not (= var3009 null-Int)))
(assert true)
(define-const var3436 String (getServiceParameter/1782298180 var790 var3611 var610)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var743 Bool (var3064_isEmpty/-813097145 var3436)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3) 
(assert (not (= (ite var743 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return l1 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var3064_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2628=org.apache.dubbo.common.URL, var790=r0, var3611=r1, var335=null_type, var610=r2, var3009=l1, var3436=r3, var3064=org.apache.dubbo.common.utils.StringUtils, var743=$z0}
; {org.apache.dubbo.common.URL=var2628, r0=var790, r1=var3611, null_type=var335, r2=var610, l1=var3009, r3=var3436, org.apache.dubbo.common.utils.StringUtils=var3064, $z0=var743}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	l1 := @parameter2: long;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $l0 = staticinvoke <java.lang.Long: long parseLong(java.lang.String)>(r3);	return l1
;block_num 2