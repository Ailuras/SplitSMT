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

(declare-sort var2550 0)
(declare-sort var3689 0)
(declare-sort var3532 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3532_isEmpty/-813097145 (String) Bool)
(declare-const null-var2550 var2550)
(declare-const null-String String)
(declare-const var1015 var2550) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1015 null-var2550)))
(declare-const var2485 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2485 null-String)))
(define-const var3760 Bool (var3532_isEmpty/-813097145 var2485)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert (not (= (ite var3760 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var3532_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2550=org.apache.dubbo.common.URL, var1015=r1, var2485=r0, var3689=null_type, var3532=org.apache.dubbo.common.utils.StringUtils, var3760=$z0}
; {org.apache.dubbo.common.URL=var2550, r1=var1015, r0=var2485, null_type=var3689, org.apache.dubbo.common.utils.StringUtils=var3532, $z0=var3760}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	return r1
;block_num 2