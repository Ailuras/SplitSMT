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

(declare-sort var90 0)
(declare-sort var3876 0)
(declare-sort var2489 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3876_isEmpty/-813097145 (String) Bool)
(declare-fun var2489_getIntVersion/-315986503 (String) Int)
(declare-const null-String String)
(declare-const var2038 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2038 null-String)))
(define-const var237 Bool (var3876_isEmpty/-813097145 var2038)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0) 
(assert (= (ite var237 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1640 Int (var2489_getIntVersion/-315986503 var2038)) ; Statement: $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0) 
 ; Statement: if $i0 < 2070000 goto $z1 = 0 
(assert (< var1640 2070000)) ; Cond: $i0 < 2070000 
(define-const var1181 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var3876_isEmpty/-813097145=([java.lang.String], boolean), var2489_getIntVersion/-315986503=([java.lang.String], int)}
; {var2038=r0, var90=null_type, var3876=org.apache.dubbo.common.utils.StringUtils, var237=$z0, var2489=org.apache.dubbo.common.Version, var1640=$i0, var1181=$z1}
; {r0=var2038, null_type=var90, org.apache.dubbo.common.utils.StringUtils=var3876, $z0=var237, org.apache.dubbo.common.Version=var2489, $i0=var1640, $z1=var1181}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0);	$i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0);	if $i0 < 2070000 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 4