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

(declare-sort var2181 0)
(declare-sort var2785 0)
(declare-sort var3661 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var2181 String) String)
(declare-fun var3661_isEmpty/-813097145 (String) Bool)
(declare-const null-var2181 var2181)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3156 var2181) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3156 null-var2181)))
(declare-const var13 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var13 null-String)))
(declare-const var3155 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var3155 null-Int)))
(assert true)
(define-const var106 String (getParameter/356772413 var3156 var13)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var1237 Bool (var3661_isEmpty/-813097145 var106)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (not (= (ite var1237 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return i1 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var3661_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2181=org.apache.dubbo.common.Parameters, var3156=r0, var13=r1, var2785=null_type, var3155=i1, var106=r2, var3661=org.apache.dubbo.common.utils.StringUtils, var1237=$z0}
; {org.apache.dubbo.common.Parameters=var2181, r0=var3156, r1=var13, null_type=var2785, i1=var3155, r2=var106, org.apache.dubbo.common.utils.StringUtils=var3661, $z0=var1237}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	i1 := @parameter1: int;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return i1
;block_num 2