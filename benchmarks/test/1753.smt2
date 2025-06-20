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

(declare-sort var2165 0)
(declare-sort var886 0)
(declare-sort var3757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var2165 String) String)
(declare-fun var3757_isEmpty/-813097145 (String) Bool)
(declare-const null-var2165 var2165)
(declare-const null-String String)
(declare-const var1732 var2165) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var1732 null-var2165)))
(declare-const var1986 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1986 null-String)))
(declare-const var626 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var626 null-String)))
(assert true)
(define-const var136 String (getParameter/356772413 var1732 var1986)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var3339 Bool (var3757_isEmpty/-813097145 var136)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto return r2 
(assert (= (ite var3339 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r2 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var3757_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2165=org.apache.dubbo.common.Parameters, var1732=r0, var1986=r1, var886=null_type, var626=r3, var136=r2, var3757=org.apache.dubbo.common.utils.StringUtils, var3339=$z0}
; {org.apache.dubbo.common.Parameters=var2165, r0=var1732, r1=var1986, null_type=var886, r3=var626, r2=var136, org.apache.dubbo.common.utils.StringUtils=var3757, $z0=var3339}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto return r2;	return r2
;block_num 2