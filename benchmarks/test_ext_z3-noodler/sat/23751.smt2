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

(declare-sort var3452 0)
(declare-sort var2429 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2429_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2300 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2300 null-String)))
(define-const var2694 Bool (var2429_isEmpty/-813097145 var2300)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0) 
(assert (not (= (ite var2694 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "" 
(check-sat)
; {var2429_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2300=r0, var3452=null_type, var2429=org.apache.dubbo.common.utils.StringUtils, var2694=$z0}
; {r0=var2300, null_type=var3452, org.apache.dubbo.common.utils.StringUtils=var2429, $z0=var2694}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <io.netty.handler.codec.http.QueryStringDecoder: java.lang.String decodeComponent(java.lang.String)>(r0);	return ""
;block_num 2