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

(declare-sort var3962 0)
(declare-sort var2616 0)
(declare-sort var125 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3962 String String) String)
(declare-fun var125_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var3962 var3962)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2726 var3962) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var2726 null-var3962)))
(declare-const var3715 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3715 null-String)))
(declare-const var2047 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2047 null-String)))
(declare-const var1645 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1645 null-Int)))
(assert true)
(define-const var842 String (getMethodParameter/2069355293 var2726 var3715 var2047)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var3668 Bool (var125_isEmpty/-813097145 var842)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
(assert (= (ite var3668 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2023 Int (Int_parseInt/1370970945 var842)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
 ; Statement: return $i0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var125_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var3962=org.apache.dubbo.common.Parameters, var2726=r0, var3715=r1, var2616=null_type, var2047=r2, var1645=i1, var842=r3, var125=org.apache.dubbo.common.utils.StringUtils, var3668=$z0, var2023=$i0}
; {org.apache.dubbo.common.Parameters=var3962, r0=var2726, r1=var3715, null_type=var2616, r2=var2047, i1=var1645, r3=var842, org.apache.dubbo.common.utils.StringUtils=var125, $z0=var3668, $i0=var2023}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	i1 := @parameter2: int;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	return $i0
;block_num 2