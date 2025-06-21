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

(declare-sort var620 0)
(declare-sort var1002 0)
(declare-sort var1104 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/356772413 (var620 String) String)
(declare-fun var1104_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var620 var620)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var809 var620) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var809 null-var620)))
(declare-const var2626 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2626 null-String)))
(declare-const var2781 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var2781 null-Int)))
(assert true)
(define-const var2004 String (getParameter/356772413 var809 var2626)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var643 Bool (var1104_isEmpty/-813097145 var2004)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (= (ite var643 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2631 Int (Int_parseInt/1370970945 var2004)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
 ; Statement: return $i0 
(check-sat)
; {getParameter/356772413=([org.apache.dubbo.common.Parameters, java.lang.String], java.lang.String), var1104_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var620=org.apache.dubbo.common.Parameters, var809=r0, var2626=r1, var1002=null_type, var2781=i1, var2004=r2, var1104=org.apache.dubbo.common.utils.StringUtils, var643=$z0, var2631=$i0}
; {org.apache.dubbo.common.Parameters=var620, r0=var809, r1=var2626, null_type=var1002, i1=var2781, r2=var2004, org.apache.dubbo.common.utils.StringUtils=var1104, $z0=var643, $i0=var2631}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	i1 := @parameter1: int;	r2 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return $i0
;block_num 2