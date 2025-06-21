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

(declare-sort var973 0)
(declare-sort var1599 0)
(declare-sort var468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1599_getenv/1182601525 (String) String)
(declare-fun var468_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2401 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2401 null-String)))
(define-const var3668 String (var1599_getenv/1182601525 var2401)) ; Statement: r1 = staticinvoke <java.lang.System: java.lang.String getenv(java.lang.String)>(r0) 
(define-const var1762 Bool (var468_isEmpty/-813097145 var3668)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return r1 
(assert (= (ite var1762 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r1 
(check-sat)
; {var1599_getenv/1182601525=([java.lang.String], java.lang.String), var468_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2401=r0, var973=null_type, var1599=java.lang.System, var3668=r1, var468=org.apache.dubbo.common.utils.StringUtils, var1762=$z0}
; {r0=var2401, null_type=var973, java.lang.System=var1599, r1=var3668, org.apache.dubbo.common.utils.StringUtils=var468, $z0=var1762}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <java.lang.System: java.lang.String getenv(java.lang.String)>(r0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return r1;	return r1
;block_num 2