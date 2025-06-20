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

(declare-sort var2959 0)
(declare-sort var3531 0)
(declare-sort var3552 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var2959 String) String)
(declare-fun var3552_isEmpty/-813097145 (String) Bool)
(declare-const null-var2959 var2959)
(declare-const null-String String)
(declare-const var1037 var2959) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1037 null-var2959)))
(declare-const var61 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var61 null-String)))
(declare-const var2483 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2483 null-String)))
(assert true)
(define-const var925 String (getParameter/356772413 var1037 var61)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1159 Bool (var3552_isEmpty/-813097145 var925)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return r2 
(assert (not (= (ite var1159 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r3 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var3552_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2959=org.apache.dubbo.common.Parameters, var1037=r0, var61=r1, var3531=null_type, var2483=r3, var925=r2, var3552=org.apache.dubbo.common.utils.StringUtils, var1159=$z0}
; {org.apache.dubbo.common.Parameters=var2959, r0=var1037, r1=var61, null_type=var3531, r3=var2483, r2=var925, org.apache.dubbo.common.utils.StringUtils=var3552, $z0=var1159}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return r2;	return r3
;block_num 2