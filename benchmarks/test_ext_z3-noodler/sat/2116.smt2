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

(declare-sort var3180 0)
(declare-sort var3042 0)
(declare-sort var1776 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/2069355293 (var3180 String String) String)
(declare-fun var1776_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var3180 var3180)
(declare-const null-String String)
(declare-const var3054 var3180) ; Statement: r0 := @this: org.apache.dubbo.common.Parameters 
(assert (not (= var3054 null-var3180)))
(declare-const var457 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var457 null-String)))
(declare-const var2480 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2480 null-String)))
(assert true)
(define-const var1034 String (getMethodParameter/2069355293 var3054 var457 var2480)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var1518 Bool (var1776_isEmpty/-813097145 var1034)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
(assert (= (ite var1518 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2638 Int (Int_parseInt/1370970945 var1034)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3) 
 ; Statement: return $i0 
(check-sat)
; {getMethodParameter/2069355293=([org.apache.dubbo.common.Parameters, java.lang.String, java.lang.String], java.lang.String), var1776_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var3180=org.apache.dubbo.common.Parameters, var3054=r0, var457=r1, var3042=null_type, var2480=r2, var1034=r3, var1776=org.apache.dubbo.common.utils.StringUtils, var1518=$z0, var2638=$i0}
; {org.apache.dubbo.common.Parameters=var3180, r0=var3054, r1=var457, null_type=var3042, r2=var2480, r3=var1034, org.apache.dubbo.common.utils.StringUtils=var1776, $z0=var1518, $i0=var2638}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.Parameters;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.common.Parameters: java.lang.String getMethodParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r3);	return $i0
;block_num 2