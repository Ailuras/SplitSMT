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

(declare-sort var1278 0)
(declare-sort var2253 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2253_replace/553341465 (String String String) String)
(declare-const null-String String)
(declare-const var3904 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3904 null-String)))
(define-const var3831 String (var2253_replace/553341465 var3904 "\t" "    ")) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r0, "\t", "    ") 
 ; Statement: return $r1 
(check-sat)
; {var2253_replace/553341465=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var3904=r0, var1278=null_type, var2253=org.apache.dubbo.common.utils.StringUtils, var3831=$r1}
; {r0=var3904, null_type=var1278, org.apache.dubbo.common.utils.StringUtils=var2253, $r1=var3831}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String replace(java.lang.String,java.lang.String,java.lang.String)>(r0, "\t", "    ");	return $r1
;block_num 1