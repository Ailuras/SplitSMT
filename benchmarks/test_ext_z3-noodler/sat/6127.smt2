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

(declare-sort var1760 0)
(declare-sort var2674 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2674_replace/553341465 (String String String) String)
(declare-const null-String String)
(declare-const var3876 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3876 null-String)))
(define-const var2738 String (var2674_replace/553341465 var3876 ", " ",")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r0, ", ", ",") 
 ; Statement: return $r1 
(check-sat)
; {var2674_replace/553341465=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var3876=r0, var1760=null_type, var2674=org.apache.dubbo.common.utils.StringUtils, var2738=$r1}
; {r0=var3876, null_type=var1760, org.apache.dubbo.common.utils.StringUtils=var2674, $r1=var2738}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r0, ", ", ",");	return $r1
;block_num 1