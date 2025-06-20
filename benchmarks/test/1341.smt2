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

(declare-sort var463 0)
(declare-sort var418 0)
(declare-sort var835 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var418_isEmpty/-813097145 (String) Bool)
(declare-fun var835_getIntVersion/-315986503 (String) Int)
(declare-const null-String String)
(declare-const var1013 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1013 null-String)))
(define-const var646 Bool (var418_isEmpty/-813097145 var1013)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0) 
(assert (= (ite var646 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1006 Int (var835_getIntVersion/-315986503 var1013)) ; Statement: $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0) 
 ; Statement: if $i0 < 2070000 goto $z1 = 0 
(assert (not (< var1006 2070000))) ; Negate: Cond: $i0 < 2070000  
(define-const var2604 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var418_isEmpty/-813097145=([java.lang.String], boolean), var835_getIntVersion/-315986503=([java.lang.String], int)}
; {var1013=r0, var463=null_type, var418=org.apache.dubbo.common.utils.StringUtils, var646=$z0, var835=org.apache.dubbo.common.Version, var1006=$i0, var2604=$z1}
; {r0=var1013, null_type=var463, org.apache.dubbo.common.utils.StringUtils=var418, $z0=var646, org.apache.dubbo.common.Version=var835, $i0=var1006, $z1=var2604}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0);	$i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0);	if $i0 < 2070000 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 4