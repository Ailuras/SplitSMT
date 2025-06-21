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

(declare-sort var1049 0)
(declare-sort var1061 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1061_isNotEmpty/-1251449450 (String) Bool)
(declare-const var1049-HOST_ADDRESS_V6 String)
(define-const var3247 String var1049-HOST_ADDRESS_V6) ; Statement: $r0 = <org.apache.dubbo.common.utils.NetUtils: java.lang.String HOST_ADDRESS_V6> 
(define-const var464 Bool (var1061_isNotEmpty/-1251449450 var3247)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r0) 
 ; Statement: if $z0 == 0 goto $r2 = "" 
(assert (not (= (ite var464 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1262 String var1049-HOST_ADDRESS_V6) ; Statement: $r5 = <org.apache.dubbo.common.utils.NetUtils: java.lang.String HOST_ADDRESS_V6> 
 ; Statement: return $r5 
(check-sat)
; {var1061_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1049=org.apache.dubbo.common.utils.NetUtils, var3247=$r0, var1061=org.apache.dubbo.common.utils.StringUtils, var464=$z0, var1262=$r5}
; {org.apache.dubbo.common.utils.NetUtils=var1049, $r0=var3247, org.apache.dubbo.common.utils.StringUtils=var1061, $z0=var464, $r5=var1262}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 = <org.apache.dubbo.common.utils.NetUtils: java.lang.String HOST_ADDRESS_V6>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r0);	if $z0 == 0 goto $r2 = "";	$r5 = <org.apache.dubbo.common.utils.NetUtils: java.lang.String HOST_ADDRESS_V6>;	return $r5
;block_num 2